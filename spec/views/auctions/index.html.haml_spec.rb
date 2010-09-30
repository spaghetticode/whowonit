require 'spec_helper'

describe "auctions/index.html.haml" do
  before(:each) do
    assign(:auctions, [
      stub_model(Auction,
        :url => "Url",
        :end_time => Time.now,
        :seller => stub_model(Ebayer, :name => 'Name')
      )
    ])
  end

  it "renders a list of auctions" do
    render
    pending do
      rendered.should have_selector("tr>td", :content => "Url".to_s, :count => 2)
    end
  end
end
