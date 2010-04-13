class Admin::ModeratorListController < ApplicationController
  layout 'admin/application'

  def edit
    if can? :update, ModeratorList
      @moderators = ModeratorList.moderators
      @users = ModeratorList.users
    end
  end

  def update
    if can? :update, ModeratorList
      ModeratorList.update_list(params[:moderator_list])
      flash[:notice] = "Moderator added"
      redirect_to admin_moderator_list_url
    end
  end

  def show
    if can? :read, ModeratorList
      @moderators = ModeratorList.moderators
    end
  end
end
