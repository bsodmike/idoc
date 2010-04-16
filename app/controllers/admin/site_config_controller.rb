class Admin::SiteConfigController < ApplicationController
  layout 'admin/application'
  
  def edit
  end

  def update
    redirect_to :action => :show
  end

  def show
    
  end
end
