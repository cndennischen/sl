require 'spec_helper'

describe 'Public Sketches' do
  it 'lists public sketches' do
    # Create a few public sketches
    sketches = Array.new
    3.times do |i|
      sketches << Factory(:sketch, :public => true)
    end
    visit '/public'
    # Make sure the page lists all the public sketches
    sketches.each { |sketch| page.should have_content(sketch.name) }
  end
  it 'allows all users to view' do
    # Create a public sketch
    sketch = Factory(:sketch, :public => true)
    visit "/public"
    click_link sketch.name
    # Check the title
    page.should have_css('head title', :text => "Sketch Lab - #{sketch.name}")
  end
end
