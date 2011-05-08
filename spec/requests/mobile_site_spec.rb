require 'spec_helper'

describe 'Mobile Site', :js => true do
  it 'displays sketch' do
    signin
    create_sketch
    visit '/?mobile=1'
    click_link 'Test Sketch'
  end
end
