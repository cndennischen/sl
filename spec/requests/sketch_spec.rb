require 'spec_helper'

describe 'Sketches' do
  it 'requires authentication' do
    requires_auth '/new', true
    requires_auth '/edit/1'
    requires_auth '/canvas'
    requires_auth '/rename', true
    requires_auth '/delete', true
    requires_auth '/export/1/pdf'
  end

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
    page.should have_selector('#flash_error')
    page.should have_no_content('Test Sketch 2')
  end

  it 'edits sketch'

  it 'exports sketch as pdf'

  it 'exports sketch as png'

  it 'exports sketch as jpeg'

  it 'sets title' do
    signin
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1
    page.should have_css('head title', :text => 'Sketch Lab - Test Sketch')
  end
end
