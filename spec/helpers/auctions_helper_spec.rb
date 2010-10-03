require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AuctionsHelper. For example:
#
# describe AuctionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AuctionsHelper do
  describe 'gallery_image_tag' do
    before { @auction = Factory.stub(:auction) }
    
    it 'should return an image tag' do
      helper.gallery_image_tag(@auction).should =~ %r[<img.+/>]
    end
    
    it 'should include expected string' do
      expected = "http://thumbs3.ebaystatic.com/pict/#{@auction.item_id}.jpg"
      helper.gallery_image_tag(@auction).should include(expected)
    end
  end
end
