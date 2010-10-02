require 'spec_helper'

describe Ebayer do
  context 'a new blank ebayer' do
    it { should_not be_valid }
    it { should have(1).error_on(:name) }
  end
  
  context 'a factory seller' do
    before { @ebayer = Factory(:ebayer) }
    
    it { @ebayer.should be_valid }    
    
    it 'should require a unique name' do
      invalid = Factory.build(:ebayer, :name => @ebayer.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'profile_url should be as expected' do
      @ebayer.profile_url.should == "http://myworld.ebay.it/#{@ebayer.name}"
    end
    
    it 'feedback_url should include expected string' do
      expected = "http://feedback.ebay.com/ws/eBayISAPI.dll?"
      @ebayer.feedback_url.should include(expected)
    end
  end
end
