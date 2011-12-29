require 'spec_helper'

describe 'auctions/index.html.haml' do
  before do
    assign(:auctions, [
      stub_model(Auction,
        :url => 'Url',
        :end_time => Time.now,
        :seller => stub_model(Ebayer, :name => 'Name')
      ),
      stub_model(Auction,
        :url => 'Url',
        :end_time => Time.now,
        :seller => stub_model(Ebayer, :name => 'Name')
      )
    ])
  end

  it 'renders a list of auctions' do
    render
    rendered.should have_selector('tr>td', :size => 2, :content => 'Url')
  end
end