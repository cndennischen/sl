module ApplicationHelper
  def title(page_title)
    @title = page_title
  end
  
  def newsletter_subscribe
    '<a href="http://eepurl.com/cSPjA">Subscribe to our newsletter</a>'.html_safe
  end

end
