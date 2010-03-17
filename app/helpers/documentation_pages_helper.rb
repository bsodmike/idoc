module DocumentationPagesHelper
  def render_as_new_item?(current_item, is_root)
    is_root && !current_item.new_record?
  end
end
