require 'spec_helper'

describe "auctions/new.html.haml" do
  before(:each) do
    assign(:auction, stub_model(Auction,
      :new_record? => true,
      :url => "MyString"
    ))
  end

  it "renders new auction form" do
    render
    rendered.should have_selector("form", :action => auctions_path, :method => "post") do |form|
      form.should have_selector("input#auction_url", :name => "auction[url]")
    end
  end
end
