require 'spec_helper'

describe AuctionsHelper do
  describe 'GALLERY_IMAGE_TAG' do
    before { @auction = Factory.stub(:auction) }
    
    it 'should return an image tag' do
      helper.gallery_image_tag(@auction).should =~ %r[^<img.+/>$]
    end
    
    it 'should include expected string' do
      expected = "http://thumbs3.ebaystatic.com/pict/#{@auction.item_id}.jpg"
      helper.gallery_image_tag(@auction).should include(expected)
    end
  end
  
  describe 'PROFILE_FOR' do
    before { @ebayer = Factory.stub(:ebayer) }
    
    it 'should return a link tag' do
      helper.profile_for(@ebayer).should =~ %r[^<a href=".+</a>$]
    end
    
    it 'should include the expected url' do
      helper.profile_for(@ebayer).should include(@ebayer.profile_url)
    end
  end
  
  describe 'color_for' do
    before { @auction = Factory.build(:auction) }
    
    it 'should return black if auction is closed' do
      @auction.end_time = 1.week.ago
      helper.color_for(@auction).should == 'black'
    end
    
    it 'should return green if auction is not closed' do
      helper.color_for(@auction).should == 'green'
    end
  end
end