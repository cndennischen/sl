class HomeController < ApplicationController
  before_filter :signin_required
  def index
  end
    
end
