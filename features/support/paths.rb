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

    when /the document page/
      documentation_page_path(@documentation_page)

    when /the add comment page/
      new_documentation_page_comment_path(@documentation_page)

    when /the comment page/
      documentation_page_comments_path(@documentation_page)
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
