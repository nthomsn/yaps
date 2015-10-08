CATALOG_LOCATION = './catalog/'

desc 'Import all programs from the catalog directory into the database'
task :import_programs => :environment do
  Dir.entries(CATALOG_LOCATION).each do |filename|
    if File.file?(CATALOG_LOCATION+filename)
      name = File.open(CATALOG_LOCATION+filename, 'r').first
      Program.new(:name => name).save
    end
  end
end
