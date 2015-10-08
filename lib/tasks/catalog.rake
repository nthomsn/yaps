CATALOG_LOCATION = './catalog/'

desc 'Update the catalog database from the catalog directory'
task :update_catalog => :environment do
  Program.delete_all

  added = 0
  Dir.entries(CATALOG_LOCATION).each do |filename|
    if File.file?(CATALOG_LOCATION+filename)
      name = File.open(CATALOG_LOCATION+filename, 'r').first
      Program.new(:name => name).save
      added += 1
    end
  end
  puts "Added %s programs to the database." % added
end
