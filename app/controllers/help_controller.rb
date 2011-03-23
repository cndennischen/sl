class HelpController < ApplicationController
  def index
  end

  def kb
    @name = params[:article]
    if @name == 'faq'
      @faqs = Faq.search(params[:search])
    end
    if @name == 'index'
      return redirect_to help_path
    end
    if @name
      @help_article = true
    end
    begin
      render @name, :layout => true
    rescue ActionView::MissingTemplate
      not_found
    end
  end

end
