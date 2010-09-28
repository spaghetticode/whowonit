module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the notification area/
      'div#flash'
    when /the (login|registration|password recovery|edit password|resend confirmation) form/
      'form#user_new'
    when
      /the error notification area/
      'div#error_explanation'
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" + "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)