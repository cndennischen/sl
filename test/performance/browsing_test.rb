require 'test_helper'
require 'rails/performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class BrowsingTest < ActionDispatch::PerformanceTest
  def test_homepage_when_not_signed_in
    get '/'
  end
  
  def test_homepage_when_signed_in
    signin
    get '/'
  end
  
  def test_help_page
    get '/help'
  end
  
  def test_faq_page
    get '/help/faq'
  end
end
