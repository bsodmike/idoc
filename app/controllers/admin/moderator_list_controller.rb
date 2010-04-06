class Admin::ModeratorListController < ApplicationController
  layout 'admin/application'

  def edit
    if can? :update, ModeratorList
      @moderators = ModeratorList.moderators
      @users = ModeratorList.users
    end
  end
end
