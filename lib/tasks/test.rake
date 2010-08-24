task :testing_stuff => :environment do
  DocumentationPage.find :first
end
