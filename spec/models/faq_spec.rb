require 'spec_helper'

describe Faq do
  it 'creates faq with valid data' do
    f = Factory.build(:faq)
    assert f.save
  end

  it 'does not create faq without question' do
    f = Factory.build(:faq, :question => nil)
    assert !f.save
  end

  it 'does not create faq without answer' do
    f = Factory.build(:faq, :answer => nil)
    assert !f.save
  end
end
