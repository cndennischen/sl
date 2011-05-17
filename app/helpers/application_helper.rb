module ApplicationHelper
  # Sets the page title
  def title(page_title)
    @title = page_title
  end

  # Creates a tab for tabbed navigation
  def tab(name, path)
    if current_page?(path)
      html = '<span class="tab">' + name + '</span>'
    else
      html = view_context.link_to(name, path)
    end
    html.html_safe
  end

  # Shows a signup button
  def signup_button
    # Only show signup button if there is no user signed in
    unless current_user
      view_context.link_to(image_tag('signup.png'), '/signin', :class => 'signup_button')
    end
  end

  def last_deployed_time
    if defined?(REDIS) && REDIS.get('last_deployed')
      "Site last updated #{time_ago_in_words(REDIS.get('last_deployed'))} ago"
    end
  end
end
