require 'test_helper'

class FaqTest < ActiveSupport::TestCase
  test "create faq with valid data" do
    f = Factory.build(:faq)
    assert f.save
  end
  
  test "create faq without question" do
    f = Factory.build(:faq, :question => nil)
    assert !f.save
  end
  
  test "create faq without answer" do
    f = Factory.build(:faq, :answer => nil)
    assert !f.save
  end
  
  test "search faqs" do  
    setup_selenium
    
    @selenium.open "/"
    @selenium.click "link=Help"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=FAQ"
    @selenium.wait_for_page_to_load "30000"
    @selenium.type "search", "download"
    @selenium.click "//input[@value='Search']"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("Can I download my sketches?")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    @selenium.click "link=exact:Can I download my sketches?"
    begin
        assert @selenium.is_text_present("You can download your sketches as PDF documents or as PNG or JPEG images. See this tutorial for more information.")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    
    teardown_selenium
  end
end
