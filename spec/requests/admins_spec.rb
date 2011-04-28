require 'spec_helper'

describe 'Admins' do
  it 'admin interface works' do
    # First create an admin user
    Admin.create!(
      :email => "admin@sketchlabhq.com",
      :password => 'secret',
      :password_confirmation => 'secret'
    )

    # Make sure the admin can log in
    visit '/admin'
    # Should redirect to admin sign in page
    current_path.should == '/admins/sign_in'
    fill_in 'Email', :with => 'admin@sketchlabhq.com'
    fill_in 'Password', :with => 'secret'
    click_button 'Sign in'
    current_path.should == '/admin'
    page.should have_content('Signed in successfully.')
  end

  it 'allows admin to access all sketches', :js => true do
    # Create a new sketch
    Factory(:sketch, :name => 'Testing')
    # Sign in as an admin
    OmniAuth.config.mock_auth[:google] = {
      'provider' => 'google',
      'uid' => 'admin_uid',
      'user_info' => {
        'name' => 'admin',
        'email' => 'admin@sketchlabhq.com' # This is what makes him an admin
      }
    }
    signin
    # Make sure the admin can edit the sketch created above
    page.should have_content 'Testing'
    click_link 'Testing'
    page.should have_content 'Testing'
    # Make sure the admin can delete the sketch created above
    click_link 'Sketch Lab' # Go back to the home page
    click_link 'Delete'
    # Accept the confirmation dialog
    page.driver.browser.switch_to.alert.accept
    Sketch.count.should == 0
    # Go back to the regular settings
    OmniAuth.config.mock_auth[:google] = {
      'provider' => 'google',
      'uid' => 'test_uid',
      'user_info' => {
        'name' => 'test_name',
        'email' => 'test_email@example.com'
      }
    }
  end
end
