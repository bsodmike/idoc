namespace :idoc do
  desc "Regenerate the table of contents for all pages"
  task :regenerate_toc => :environment do
    d = DocumentationPage.all
    d.map(&:generate_toc)
    d.map(&:save)
  end
end