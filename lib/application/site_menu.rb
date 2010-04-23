module Application::SiteMenu
  def find_menu_items
    @menu_items = ::DocumentationPage.roots
  end
end