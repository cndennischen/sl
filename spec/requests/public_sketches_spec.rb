require 'spec_helper'

describe 'Public Sketches' do
  it 'lists public sketches' do
    # Create a few public sketches
    sketches = Array.new
    3.times do |i|
      sketches << new_public_sketch
    end
    visit '/public'
    # Make sure the page lists all the public sketches
    sketches.each { |sketch| page.should have_content(sketch.name) }
  end
  it 'allows all users to view' do
    # Create a public sketch
    sketch = new_public_sketch
    visit "/public"
    click_link sketch.name
    # Check the title
    page.should have_css('head title', :text => "Sketch Lab - #{sketch.name}")
  end

  it 'returns not found when the sketch does not exist' do
    visit '/public/999' # Doesn't exist
    page.driver.response.status.should == 404 # Should return 404
  end
end

# Create a new public sketch
def new_public_sketch
  Factory(:sketch, :public => true)
end
