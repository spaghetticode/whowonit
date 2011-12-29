require 'spec_helper'

describe ApplicationHelper do
  before { @auction = Factory(:auction) }

  describe '#jquery_wrappable' do
    it 'should return a string' do
      helper.jquery_wrappable(@auction).should be_a(String)
    end

    it 'should not include single quotes' do
      helper.jquery_wrappable(@auction).should_not include("'")
    end

    it 'should not include newlines' do
      helper.jquery_wrappable(@auction).should_not include("\n")
    end
  end

  describe '#present' do
    it 'should return expected presenter type' do
      helper.present(@auction).should be_a(AuctionPresenter)
    end
  end
end