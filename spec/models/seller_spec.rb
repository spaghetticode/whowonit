require 'spec_helper'

describe Seller do
  context 'a new blank seller' do
    it { should_not be_valid }
    it { should have(1).error_on(:name) }
  end
  
  context 'a factory seller' do
    before { @seller = Factory(:seller) }
    
    it { @seller.should be_valid }
    it { @seller.type.should  == 'Seller' }    
    
    
    it 'should require a unique name' do
      invalid = Factory.build(:seller, :name => @seller.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'feedback_url should include expected string' do
      expected = "http://feedback.ebay.com/ws/eBayISAPI.dll?"
      @seller.feedback_url.should include(expected)
    end
  end
end
