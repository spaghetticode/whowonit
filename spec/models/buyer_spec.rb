require 'spec_helper'

describe Buyer do
  context 'a new blank buyer' do
    it { should_not be_valid }
    it { should have(1).error_on(:name) }
  end
  
  context 'a factory buyer' do
    before { @buyer = Factory(:buyer) }
    
    it { @buyer.should be_valid }
    it { @buyer.type.should  == 'Buyer' }    
    
    
    it 'should require a unique name' do
      invalid = Factory.build(:buyer, :name => @buyer.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'profile_url should be as expected' do
      @buyer.profile_url.should == "http://myworld.ebay.it/#{@buyer.name}"
    end
  end
end
