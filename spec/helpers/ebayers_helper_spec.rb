require 'spec_helper'

describe 'PROFILE_FOR' do
  before { @ebayer = Factory.stub(:ebayer) }

  it 'should return a link tag' do
    helper.profile_for(@ebayer).should =~ %r[^<a href=".+</a>$]
  end

  it 'should include the expected url' do
    helper.profile_for(@ebayer).should include(@ebayer.profile_url)
  end
end