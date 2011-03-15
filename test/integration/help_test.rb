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
  
  test "should get faqs" do
    get '/help/faq'
    assert_response :success
  end
  
  test "should search faqs" do
    get '/help/faq?search=download'
    assert_select 'a.question', 'Can I download my sketches?'
    assert_select 'p.answer', 'You can download your sketches as PDF documents or as PNG or JPEG images. See this tutorial for more information.'
    # make sure the search term is in the search box
    assert_select '#search[value="download"]'
  end
end
