require 'test_helper'

class HelpTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get help_path
    assert_response :success
  end
  
  test "should return 404 error" do
    get '/help/nothing'
    assert_response 404
  end
  
  test "should list faqs" do
    get '/help/faq'
    # TODO: Make sure faqs are listed
    assert_response :success
  end
end
