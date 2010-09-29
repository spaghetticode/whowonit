module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /the home\s?page/
      '/'
    when /the auctions list page/
      auctions_path
    when /the login page/
      new_user_session_path
    when /the registration page/
      new_user_registration_path
    when /the password recovery page/
      new_user_password_path
    when /the edit password page/
      edit_user_password_path
    when /the resend confirmation instructions page/
      new_user_confirmation_path
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
