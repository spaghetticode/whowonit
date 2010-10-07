module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the notification area/
      'div#flash'
    when /the (login|registration|password recovery|edit password|resend confirmation) form/
      'form#user_new'
    when /the error notification area/
      'div#errorExplanation'
    when /an auction row/
      'tr.auction'
    when /the auction row with id (\d+)/
      "tr#id-#{$1}"
    when /the add auction form/
      'div#add_auction'
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" + "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)