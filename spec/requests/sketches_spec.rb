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
    create_sketch
    click_link 'Home'
    page.should have_content('Test Sketch')
  end

  it 'deletes sketch', :js => true do
    signin
    create_sketch
    visit '/'
    click_link 'Delete'
    # Accept the confirmation dialog
    page.driver.browser.switch_to.alert.accept
    Sketch.count.should == 0
  end

  it 'does not create more than one sketch on free plan' do
    signin
    create_sketch
    click_link 'Home'
    page.should have_content('Test Sketch')
    post_via_redirect '/new', :name => 'Test Sketch 2'
    current_path.should == '/'
    Sketch.count.should == 1
    page.should have_selector('#flash_error')
    page.should have_no_content('Test Sketch 2')
  end

  it 'creates multiple sketches on the paid plan' do
    signin
    # Set the user's plan to paid
    Rails.cache.write("#{User.last.cache_key}-plan", 'paid')
    create_sketch
    click_link 'Home'
    page.should have_content('Test Sketch')
    fill_in 'name', :with => 'Test Sketch #2'
    click_button 'New Sketch'
    Sketch.count.should == 2
    click_link 'Home'
    page.should have_content('Test Sketch #2')
  end

  it 'renames sketch', :js => true do
    signin
    create_sketch
    click_button 'renameBtn'
    fill_in 'name', :with => 'Renamed!'
    click_button 'rename'
    page.should have_content 'Renamed!'
    page.should have_css('head title', :text => 'Sketch Lab - Renamed!')
  end

  it 'edits sketch'

  it 'exports sketch' do
    signin
    create_sketch

    click_link 'PDF'
    # Make sure we get a pdf document
    page.response_headers['Content-Type'].should == "application/octet-stream"
    page.response_headers['Content-Disposition'].should =~ /sketch.pdf/

    # Go back to the sketch's edit page
    visit page.driver.last_request.env['HTTP_REFERER']
    click_link 'PNG'
    # Make sure we get a png image
    page.response_headers['Content-Type'].should == "application/octet-stream"
    page.response_headers['Content-Disposition'].should =~ /sketch.png/

    # Go back to the sketch's edit page
    visit page.driver.last_request.env['HTTP_REFERER']
    click_link 'JPEG'
    # Make sure we get a jpeg image
    page.response_headers['Content-Type'].should == "application/octet-stream"
    page.response_headers['Content-Disposition'].should =~ /sketch.jpg/
  end

  it 'sets title' do
    signin
    create_sketch
    page.should have_css('head title', :text => 'Sketch Lab - Test Sketch')
  end
end
