module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

      when /the home\s?page/
        '/'

      when /the add documentation page/
        new_documentation_page_path

      when /the user session page/
        user_session_path

      when /the account logon page/
        new_user_session_path

      when /the new account page/
        new_user_path

      when /the document page for "(.*)"/
        documentation_page_path(DocumentationPage.find_by_title($1))
      
      when /the document page$/
        documentation_page_path(@documentation_page)

      when /the edit document page$/
        edit_documentation_page_path(@documentation_page)

      when /the edit document page for "(.*)"/
        edit_documentation_page_path(DocumentationPage.find_by_title($1))
      when /the documentation page$/
        documentation_pages_path

      when /the add comment page/
        new_documentation_page_comment_path(@documentation_page)

      when /the comment page/
        documentation_page_comments_path(@documentation_page)

      when /the edit moderator list page/
        edit_admin_moderator_list_path

      when /the edit site configuration page/
        edit_admin_site_config_path

      when /the site configuration page/
        admin_site_config_path

      when /the document authors list page/
        admin_document_author_list_path
        
      when /the edit document authors list page/
        edit_admin_document_author_list_path

      when /the search results page/
        search_documentation_pages_path

      when /the recent comments page/
        recent_comments_path
        
      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
