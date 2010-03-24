# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_item?(item1, item2)
    result = {:"data-id" => item1.id, :"data-position" => item1.position}
    if item1.id == item2.id
      result[:rel] = "editable"
      result[:id] = "current_item"
    end
    return result 
  end

  def dont_display_login_bar
    current_page?(:controller => :users, :action => :new) ||
    current_page?(:controller => :users, :action => :create) ||
    current_page?(:controller => :user_sessions, :action => :new) ||
    current_page?(:controller => :user_sessions, :action => :create)
  end
end
