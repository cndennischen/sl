require 'spec_helper'

describe 'Faqs' do
  it 'display faqs' do
    faq = Factory(:faq)
    visit '/help/faq'
    page.should have_content(faq.question)
    page.should have_content(faq.answer)
  end

  it 'search faqs' do
    visit '/help/faq'
    faq1 = Factory(:faq)
    faq2 = Factory(:faq)
    visit '/help/faq'
    # search for question
    search(faq2.question)
    verify_search(faq2)
    # search for answer
    search(faq2.answer)
    verify_search(faq2)
  end

  it 'reports when no faqs match search' do
    visit '/help/faq'
    # search for a search term that doesn't match any faqs
    search('Lorem ipsum dolor sit amet')
    page.should have_content('No items match your search')
  end
end

def search(query)
  fill_in 'search', :with => query
  click_button 'Search'
end

def verify_search(faq)
  page.should have_content(faq.question)
  page.should have_content(faq.answer)
end
