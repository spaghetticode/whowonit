require 'spec_helper'

describe AuctionsController do

  def mock_auction(stubs={})
    @mock_auction ||= mock_model(Auction, stubs).as_null_object
  end

  context 'when not logged in' do
    it_should_redirect_for(
      :new => :get,
      :create => :post,
      :destroy => :delete
    )

    it 'should get index' do
      get :index
      response.should be_success
    end
  end

  context 'when logged in' do
    before do
      @user = Factory(:user)
      sign_in @user
    end

    describe "GET index" do
      it "assigns all visible user auctions as @auctions" do
        auction = Factory(:auction, :user_ids => [@user])
        get :index
        assigns(:auctions).should == [auction]
      end
    end

    describe "GET new" do
      it "assigns a new auction as @auction" do
        Auction.stub(:new) { mock_auction }
        get :new
        assigns(:auction).should be(mock_auction)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        before do
          Auction.stub(:new) { mock_auction(:save => true) }
          post :create, :auction => {:item_id => '123456789012'}
        end

        it "assigns a newly created auction as @auction" do
          assigns(:auction).should be(mock_auction)
        end

        it "redirects to the created auction" do
          response.should redirect_to(auctions_path)
        end
      end

      describe "with invalid params" do
        before do
          Auction.stub(:new) { mock_auction(:save => false) }
          post :create, :auction => {:item_id => '123456789012'}
        end

        it "assigns a newly created but unsaved auction as @auction" do
          post :create, :auction => {:item_id => '123456789011'}
          assigns(:auction).should be(mock_auction)
        end

        it "re-renders the 'new' template" do
          response.should render_template("new")
        end
      end
    end

    describe "DELETE destroy" do
      context 'when the auction has only one associated user' do
        before do
          @auction = Factory(:auction, :user_ids => [@user.id])
          delete :destroy, :id => @auction.id
        end

        it "remove the user association with the found auction" do
          @user.auctions.should_not include(@auction)
        end

        it "redirects to the auctions list" do
          response.should redirect_to(auctions_url)
        end

        it 'should destroy auction' do
          lambda do
            @auction.reload
          end.should raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when the auction has more than one associated user' do
        before do
          other = Factory(:user)
          @auction = Factory(:auction, :user_ids => [@user.id, other.id])
          delete :destroy, :id => @auction.id
        end

        it 'should not destroy auction' do
          lambda do
            @auction.reload
          end.should_not raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
