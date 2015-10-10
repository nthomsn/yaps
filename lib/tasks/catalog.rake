require_relative 'course'

CATALOG_LOCATION = './catalog/'

desc 'Update the catalog database from the catalog directory'
task :update_catalog => :environment do
  Program.delete_all

  Dir.entries(CATALOG_LOCATION).each do |filename|
    if File.file?(CATALOG_LOCATION+filename)
      parse_file(CATALOG_LOCATION+filename)
    end
  end
  puts "Done adding programs to the database."
end

def parse_file(location)
    file = File.open(location, 'r')

    name = file.first.strip
    puts "Found %s" % name

    line_count = 0
    file.each_line do |line|
      if line_count > 0
        Course.new(line).display
      end
      line_count += 1
    end

    Program.new(:name => name).save
end
