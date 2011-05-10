class HelpController < ApplicationController
  # Lists the help articles
  def index
  end

  # Displays help / knowledge base articles
  def kb
    # Get the name of the article requested
    @name = params[:article]
    # For FAQs:
    if @name == 'faq'
      # Cache the Faqs
      faqs = Rails.cache.fetch('faqs') { Faq.all }
      @faqs = search_array(faqs, params[:search])
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

  private

  # Searches an array (of Faqs) and returns a new array of all the matching items
  def search_array(array, search = nil)
    # Check if there is a search term
    if search
      # Delete all the items that don't include the search term
      array.select do |item|
        item.include?(search)
      end
    else
      # If there is no search term, return the original array
      array
    end
  end
end
