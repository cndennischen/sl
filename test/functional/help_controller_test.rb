require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

end
