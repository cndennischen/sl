require 'spec_helper'

describe 'Users' do
  describe "GET /account" do
    it 'displays user info', :js => true do
      signin
      visit '/account'
      page.should have_content('test_name')
      page.should have_content('test_email@example.com')
    end
  end

  describe "POST /account" do
    it 'changes user name', :js => true do
      signin
      visit '/account'
      fill_in 'name', :with => 'new name'
      click_button 'Update'
      page.should have_content('new name')
      page.should have_selector('#flash_notice')
    end
    it 'does not change email', :js => true do
      signin
      post '/account/update', :email => 'new_email@example.com'
      visit '/account'
      page.should have_no_content('new_email@example.com')
    end
    it 'deletes account', :js => true do
      signin
      visit '/account'
      click_link 'Delete Account'
      check 'confirmed'
      click_button 'Delete Account'
      page.should have_selector('#flash_notice')
      page.should have_content 'Sign In / Sign Up'
      current_path.should == '/'
    end
    it 'does not delete account without confirmation', :js => true do
      signin
      visit '/account'
      click_link 'Delete Account'
      click_button 'Delete Account'
      page.should have_selector('#flash_notice')
      page.should have_content 'Sign Out'
      current_path.should == '/account/delete'
    end
  end
end