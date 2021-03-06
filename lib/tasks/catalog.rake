CATALOG_DIRECTORY = './catalog/'

desc 'Update the catalog database from the catalog directory'
task :update_catalog => :environment do
  Program.delete_all
  Course.delete_all

  Dir.entries(CATALOG_DIRECTORY).each do |filename|
    if File.file?(CATALOG_DIRECTORY+filename)
      if filename.include?('.yml')
        parse_yml_file(CATALOG_DIRECTORY+filename)
      else
        parse_file(CATALOG_DIRECTORY+filename)
      end
    end
  end
  puts "Done adding programs to the database."
end

def parse_yml_file(file_path)
  program_yml = YAML.load_file(file_path)

  name = program_yml['name']
  catalog_id = program_yml['id']
  requirements = ''
  program_yml['requirements'].each do |requirement|
    requirements += '<h4>' + requirement['title'] + '</h4>'
    requirements += requirement['text']
  end

  program = Program.new(:name => name, :catalog_id => catalog_id,
    :requirements_text => requirements)
  program.save

  program_yml['courses'].each do |course|
      paren_index = course.index('(')
      name = course[0..paren_index-1].strip
      credits = course[paren_index+1..paren_index+2].to_i
      if Course.exists?(:name => name)
        program.courses << Course.find_by(:name => name)
      else
        program.courses.create(:name => name, :credits => credits)
      end
  end
end

def parse_file(location)
    file = File.open(location, 'r')

    firstline = file.first
    name = firstline.split(",").first.strip
    catalog_id = firstline.split(",")[1].strip.to_i
    program = Program.new(:name => name, :catalog_id => catalog_id)
    program.save
    puts "Found %s" % name

    line_count = 0
    parsing_requirements = false
    requirements = ''
    file.each_line do |line|
      # Check for break indicating start of requirements
      if (line.include?('#'))
        parsing_requirements = true;
      elsif line_count > 0 && !parsing_requirements
        paren_index = line.index('(')
        name = line[0..paren_index-1].strip
        credits = line[paren_index+1..paren_index+2].to_i
        if Course.exists?(:name => name)
          program.courses << Course.find_by(:name => name)
        else
          program.courses.create(:name => name, :credits => credits)
        end
      elsif parsing_requirements
        requirements += line
      end
      line_count += 1
    end

    program[:requirements_text] = requirements
    program.save

end
