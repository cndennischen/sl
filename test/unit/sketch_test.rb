require 'test_helper'

class SketchTest < ActiveSupport::TestCase
  test "create sketch with valid data" do
    s = Factory.build(:sketch)
    assert s.save
  end
  
  test "create sketch without name" do
    s = Factory.build(:sketch, :name => nil)
    assert !s.save
  end
  
  test "create sketch without content" do
    s = Factory.build(:sketch, :content => nil)
    assert s.save
  end
  
  test "create sketch without user_id" do
    s = Factory.build(:sketch, :user_id => nil)
    assert !s.save
  end
  
  test "create sketch from browser" do
    setup_selenium
    signin
    
    # test creating a new sketch
    @selenium.open "/"
    @selenium.type "name", "Test Sketch"
    @selenium.click "commit"
    @selenium.wait_for_page_to_load "30000"
    # test very basic sketch editing functionality
    @selenium.click "addBtn"
    begin
        assert @selenium.is_text_present("Window")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    @selenium.click "undoBtn"
    begin
        assert !@selenium.is_text_present("Window")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    
    teardown_selenium
  end
end
