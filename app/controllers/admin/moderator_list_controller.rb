class Admin::ModeratorListController < ApplicationController
  layout 'admin/application'

  def edit
    allowed_to? :update, ModeratorList do
      @moderators = ModeratorList.moderators
      @users = ModeratorList.users
    end
  end

  def update
    allowed_to? :update, ModeratorList do
      ModeratorList.update_list(params[:moderator_list])
      if !params[:moderator_list][:add_moderators].blank?
        flash[:notice] = "Moderator added"
      end
      if !params[:moderator_list][:remove_moderators].blank?
        flash[:notice] = "Moderator removed"
      end
      
      redirect_to admin_moderator_list_url
    end
  end

  def show
    allowed_to? :read, ModeratorList do
      @moderators = ModeratorList.moderators
    end
  end
end
