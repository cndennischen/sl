class HelpController < ApplicationController
  def index
    @faqs = Faq.all
  end

end
