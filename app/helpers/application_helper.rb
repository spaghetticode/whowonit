module ApplicationHelper
  # will remove all \n and replace ' with ", so the string can be
  # safely wrapped by jquery
  def jquery_wrappable(object)
    type = object.class.name.downcase
    options = {:partial => "/#{type.pluralize}/#{type}", :locals => {type.to_sym => object}}
    render(options).gsub(/'/, '"').gsub("\n", '').html_safe
  end
end
