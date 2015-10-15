CATALOG_LOCATION = './catalog/'

desc 'Update the catalog database from the catalog directory'
task :update_catalog => :environment do
  Program.delete_all
  Course.delete_all

  Dir.entries(CATALOG_LOCATION).each do |filename|
    if File.file?(CATALOG_LOCATION+filename)
      parse_file(CATALOG_LOCATION+filename)
    end
  end
  puts "Done adding programs to the database."
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
    file.each_line do |line|
      if line_count > 0
        paren_index = line.index('(')
        name = line[0..paren_index-1].strip
        credits = line[paren_index+1..paren_index+2].to_i
        if Course.exists?(:name => name)
          program.courses << Course.find_by(:name => name)
        else
          program.courses.create(:name => name, :credits => credits)
        end
      end
      line_count += 1
    end

end
