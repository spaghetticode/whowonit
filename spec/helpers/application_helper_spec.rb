require 'spec_helper'

describe ApplicationHelper do
  describe '#jquery_wrappable' do
    before { @object = Factory(:auction) }

    it 'should return a string' do
      helper.jquery_wrappable(@object).should be_a(String)
    end

    it 'should not include single quotes' do
      helper.jquery_wrappable(@object).should_not include("'")
    end

    it 'should not include newlines' do
      helper.jquery_wrappable(@object).should_not include("\n")
    end
  end
end