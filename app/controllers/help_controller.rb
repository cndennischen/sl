class HelpController < ApplicationController
  # Lists the help articles
  def index
    cache_page
  end

  # Displays help / knowledge base articles
  def kb
    cache_page

    # Get the name of the article requested
    @name = params[:article]
    # For FAQs:
    if @name == 'faq'
      @faqs = Faq.search(params[:search])
    end
    # For the index
    if @name == 'index'
      return redirect_to help_path
    end
    # So the layout knows the page is for a help article:
    if @name
      @help_article = true
    end

    # Render the requested help article
    render @name, :layout => true
  end

end
