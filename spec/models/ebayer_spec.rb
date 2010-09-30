require 'spec_helper'

describe Ebayer do
  context 'a new blank ebayer' do
    it { should_not be_valid }
    it { should have(1).error_on(:name) }
  end
  
  context 'a factory ebayer' do
    before { @ebayer = Factory(:ebayer) }
    
    it { @ebayer.should be_valid }
    
    it 'should require a unique name' do
      invalid = Factory.build(:ebayer, :name => @ebayer.name)
      invalid.should have(1).error_on(:name)
    end
  end
end
