require 'spec_helper'

describe "Faqs" do
  describe 'GET /faqs' do
    it 'display faqs', :js => true do
      faq = Factory(:faq)
      visit '/help/faq'
      page.should have_content(faq.question)
      click_link faq.question
      page.should have_content(faq.answer)
    end

    it 'search faqs', :js => true do
      visit '/help/faq'
      faq1 = Factory(:faq)
      faq2 = Factory(:faq)
      visit '/help/faq'
      # search for question
      search(faq2.question)
      verify_search(faq1, faq2)
      # search for answer
      search(faq2.answer)
      verify_search(faq1, faq2)
    end
  end
end

def search(query)
  fill_in 'search', :with => query
  click_button 'Search'
end

def verify_search(faq1, faq2)
  page.should have_content(faq2.question)
  click_link faq2.question
  page.should have_content(faq2.answer)
end
