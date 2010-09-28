require 'spec_helper'

describe User do
  context 'a new blank instance' do
    it { should_not be_valid }
    it { should have(1).error_on(:email) }
    it { should have(1).error_on(:password) }
  end
  
  context 'a factory user' do
    before { @user = Factory(:user) }
    
    it { @user.should be_valid }
  end
end