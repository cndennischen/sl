class HelpController < ApplicationController
  def index
    @faqs = Faq.all
  end
  
  def kb
    @name = params[:article]
    begin
      render @name, :layout => true
    rescue ActionView::MissingTemplate
      not_found
    end
  end

end
