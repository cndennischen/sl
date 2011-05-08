module ApplicationHelper
  # Sets the page title
  def title(page_title)
    @title = page_title
  end

  def tab(name, path)
    if current_page?(path)
      html = '<span class="tab">' + name + '</span>'
    else
      html = view_context.link_to(name, path)
    end
    html.html_safe
  end

end
