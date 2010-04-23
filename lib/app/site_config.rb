module App::SiteConfig
  def self.included(base)
    base.before_filter(:load_config)
  end

  protected

  def load_config
    @site_config = ::SiteConfig.find_or_create_default!
  end
end