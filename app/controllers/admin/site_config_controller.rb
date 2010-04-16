class Admin::SiteConfigController < ApplicationController
  layout 'admin/application'

  def edit
    allowed_to? :update, @site_config do
      render :action => :edit
    end
  end

  def update
    allowed_to? :update, @site_config do
      SiteConfig.update_or_create!(params[:site_config])
      flash[:notice] = "Configuration saved"
      redirect_to :action => :show
    end
  end

  def show
    allowed_to? :update, @site_config do
      render :action => :show
    end
  end
end
