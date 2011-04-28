module AccountHelper
  # Returns a link to refresh the user's plan
  def refresh_link
    "(#{view_context.link_to('refresh', refresh_plan_path, :method => :post)})".html_safe
  end
end
