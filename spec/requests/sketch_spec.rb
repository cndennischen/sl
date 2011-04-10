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

  it 'creates multiple sketches on the paid plan' do
    signin
    # set the user's plan to paid
    User.last.update_attributes(:kind => 'paid')
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1
    click_link 'Sketch Lab'
    page.should have_content('Test Sketch')
    fill_in 'name', :with => 'Test Sketch #2'
    click_button 'New Sketch'
    Sketch.count.should == 2
    click_link 'Sketch Lab'
    page.should have_content('Test Sketch #2')
  end

  it 'edits sketch'

  it 'exports sketch' do
    signin
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1

    click_link 'PDF'
    # make sure we get a pdf document
    page.response_headers['Content-Type'].should == "application/octet-stream"
    page.response_headers['Content-Disposition'].should =~ /sketch.pdf/

    # go back to the sketch's edit page
    visit page.driver.last_request.env['HTTP_REFERER']
    click_link 'PNG'
    # make sure we get a png image
    page.response_headers['Content-Type'].should == "application/octet-stream"
    page.response_headers['Content-Disposition'].should =~ /sketch.png/

    # go back to the sketch's edit page
    visit page.driver.last_request.env['HTTP_REFERER']
    click_link 'JPEG'
    # make sure we get a jpeg image
    page.response_headers['Content-Type'].should == "application/octet-stream"
    page.response_headers['Content-Disposition'].should =~ /sketch.jpg/
  end

  it 'sets title' do
    signin
    fill_in 'name', :with => 'Test Sketch'
    click_button 'New Sketch'
    Sketch.count.should == 1
    page.should have_css('head title', :text => 'Sketch Lab - Test Sketch')
  end
end
