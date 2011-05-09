require 'spec_helper'

describe 'Users' do
  describe 'GET /account' do
    it 'displays user info', :js => true do
      signin
      click_link 'Account'
      page.should have_content('test_name')
      page.should have_content('test_email@example.com')
    end

    it 'refreshes user plan', :js => true do
      signin
      click_link 'Account'
      # Change the user's plan
      User.last.update_attribute :kind, 'paid'
      # Refresh the plan
      click_link 'refresh'
      User.last.plan.should == 'paid'
    end

    it 'displays ad for free users' do
      signin
      # Should display ad
      page.should have_css 'div#ad'
      page.should have_text 'Upgrade to the paid plan to'
      # Change the plan to paid
      Rails.cache.write("#{User.last.cache_key}-plan", 'paid')
      # Reload the page
      page.reload
      # Should not display ad
      page.should have_no_css 'div#ad'
      page.should have_no_text 'Upgrade to the paid plan to'
    end
  end

  describe 'POST /account' do
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

  it 'requires authentication' do
    requires_auth '/account'
    requires_auth '/account/update', true
    requires_auth '/account/delete'
    requires_auth '/account/destroy', true
  end
end
