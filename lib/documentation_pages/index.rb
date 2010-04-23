module DocumentationPages::Index
  def display_new_page
    allowed_to? :create, DocumentationPage do
      setup_new_page
      render :action => :new
    end
  end

  def display_first_page
    @documentation_page = DocumentationPage.roots.first
    allowed_to? :read, @documentation_page do
      render :action => :show
    end
  end
end