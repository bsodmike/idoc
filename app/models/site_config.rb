class SiteConfig < ActiveRecord::Base
  def self.find_or_create_default!
    if count == 0
      return create!(:site_title => 'iDoc', :use_document_author_list => false)
    else
      return first
    end
  end

  def self.update_or_create!(config_params)
    if count == 0
      return SiteConfig.create(config_params)
    else
      config = first
      config.update_attributes!(config_params)
    end
  end
end
