require 'spec_helper'

describe 'Sketches' do
  it 'creates sketch' do
    signin
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1
    click_link 'Sketch Lab'
    page.should have_content('Test Sketch')
  end

  it 'deletes sketch', :js => true do
    signin
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1
    visit '/'
    click_link 'Delete'
    # accept the confirmation dialog
    page.driver.browser.switch_to.alert.accept
    Sketch.count.should == 0
  end

  it 'does not create more than one sketch on free plan' do
    signin
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1
    click_link 'Sketch Lab'
    page.should have_content('Test Sketch')
    post_via_redirect '/new', :name => 'Test Sketch 2'
    current_path.should == '/'
    Sketch.count.should == 1
    page.should have_content('You cannot have more than one sketch on the free plan. Upgrade to the paid plan to have unlimited sketches.')
    page.should have_no_content('Test Sketch 2')
  end
end
