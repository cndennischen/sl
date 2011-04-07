require 'spec_helper'

describe 'Sketches' do
  it 'creates, edits, and deletes sketch', :js => true do
    ## create sketch 
    signin
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1
    ## TODO: edit sketch

    ## delete sketch
    visit '/'
    page.should have_content('Test Sketch')
    click_link 'Delete'
    # accept the confirmation dialog
    page.driver.browser.switch_to.alert.accept
    Sketch.count.should == 0
  end

  it 'does not create more than one sketch on free plan'
end
