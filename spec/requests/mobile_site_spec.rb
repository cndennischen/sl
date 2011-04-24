require 'spec_helper'

describe 'Mobile Site', :js => true do
  it 'displays sketch' do
    signin
    create_sketch
    visit '/?mobile=1'
    click_link 'Test Sketch'
    page.should have_css('head title', :text => 'Test Sketch')
  end
end
