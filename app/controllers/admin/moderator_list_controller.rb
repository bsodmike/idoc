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
      flash[:notice] = "Moderator added"
      redirect_to admin_moderator_list_url
    end
  end

  def show
    allowed_to? :read, ModeratorList do
      @moderators = ModeratorList.moderators
    end
  end
end
