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
end
