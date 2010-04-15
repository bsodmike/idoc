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
      construct_update_responses(params[:moderator_list])
      redirect_to admin_moderator_list_url
    end
  end

  def show
    allowed_to? :read, ModeratorList do
      @moderators = ModeratorList.moderators
    end
  end

  private

  def construct_update_responses(moderator_update_arrays)
    flash[:notice] = pluralize_moderator(moderator_update_arrays[:add_moderators], " added")
    flash[:notice] = pluralize_moderator(moderator_update_arrays[:remove_moderators], " removed")
  end

  def pluralize_moderator(array, ending)
    if array.blank?
      flash[:notice]
    else
      "Moderator".smart_pluralize(array.size) + ending
    end
  end
end
