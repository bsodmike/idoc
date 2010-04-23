module DocumentationPages::DestroyPages
  def destroy_page
    @documentation_page.destroy
    flash[:notice] = "Page deleted"
    redirect_to root_url
  end

  def cannot_destroy_page
    flash[:error] = "You are not allowed to destroy documentation pages"
    redirect_to @documentation_page
  end
end