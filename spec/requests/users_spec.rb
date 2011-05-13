require 'spec_helper'

describe 'Users', :js => true do
  describe 'GET /account' do
    it 'displays user info' do
      signin
      click_link 'Account'
      page.should have_content('test_name')
      page.should have_content('test_email@example.com')
    end

    it 'refreshes plan' do
      signin
      click_link 'Account'
      # Change the user's plan
      User.last.update_attribute :kind, 'premium'
      # Refresh the plan
      click_link 'refresh'
      User.last.plan.should == 'premium'
    end

    it 'displays ad for basic users' do
      signin
      # Should display ad
      page.should have_selector('div#ad')
      page.should have_content('Upgrade to the premium plan to')
      # Change the plan to 'premium'
      Rails.cache.write(User.last.plan_key, 'premium')
      # Reload the page
      visit(current_path)
      # Should not display ad
      page.should have_no_selector('div#ad')
      page.should have_no_content('Upgrade to the premium plan to')
    end
  end

  describe 'POST /account' do
    it 'changes user name' do
      signin
      visit '/account'
      fill_in 'name', :with => 'new name'
      click_button 'Update'
      page.should have_content('new name')
      page.should have_selector('#flash_notice')
    end

    it 'does not change email' do
      signin
      post '/account/update', :email => 'new_email@example.com'
      visit '/account'
      page.should have_no_content('new_email@example.com')
    end

    it 'deletes account' do
      signin
      visit '/account'
      click_link 'Delete Account'
      check 'confirmed'
      click_button 'Delete Account'
      page.should have_selector('#flash_notice')
      page.should have_content 'Sign In / Sign Up'
      current_path.should == '/'
    end

    it 'does not delete account without confirmation' do
      signin
      visit '/account'
      click_link 'Delete Account'
      click_button 'Delete Account'
      page.should have_selector('#flash_notice')
      page.should have_content 'Sign Out'
      current_path.should == '/account/delete'
    end
  end

  it 'requires authentication' do
    requires_auth '/account'
    requires_auth '/account/update', true
    requires_auth '/account/delete'
    requires_auth '/account/destroy', true
  end
end
