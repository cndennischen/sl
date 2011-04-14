require 'spec_helper'

describe 'Admins' do
  it 'admin interface works' do
    # first create an admin user
    Admin.create!(
      :email => "admin@sketchlabhq.com",
      :password => 'secret',
      :password_confirmation => 'secret'
    )

    # make sure the admin can log in
    visit '/admin'
    # should redirect to admin sign in page
    current_path.should == '/admins/sign_in'
    fill_in 'Email', :with => 'admin@sketchlabhq.com'
    fill_in 'Password', :with => 'secret'
    click_button 'Sign in'
    current_path.should == '/admin'
    page.should have_content('Signed in successfully.')
  end
end
