require 'spec_helper'
require 'rake'

describe 'cron task' do
  def prepare_rake
    rake = Rake::Application.new
    Rake.application = rake
    Rake.application.rake_require 'lib/tasks/cron'
    Rake::Task.define_task(:environment)
    @rake_cron = rake['cron']
  end

  def stub_feeback_html(file)
    URI.stub!(:parse => mock.as_null_object)
    body = mock(:body => File.read(file))
    response = mock.as_null_object
    response.stub!(:get => body)
    Net::HTTP.stub!(:new => response)
  end

  def create_auctions
    @open      = Factory(:auction, :item_id => '380261770710')
    @pending   = Factory(:auction, :item_id => '130423805348', :end_time => 1.day.ago)
    @invisible = Factory(:auction, :item_id => '380267241870', :end_time => 91.days.ago)
    @unpending = Factory(:auction, :item_id => '130429054922', :end_time => 1.day.ago, :buyer => Factory(:ebayer))
  end

  before do
    prepare_rake
    stub_feeback_html("#{Rails.root}/spec/fixtures/feedback.html")
    create_auctions
  end

  pending 'to be fixed (prepare_rake fails)' do
    it 'should not set @invisible buyer' do
      @rake_cron.invoke
      @invisible.reload.buyer.should be_nil
    end

    it 'should not set @open buyer' do
      @rake_cron.invoke
      @open.reload.buyer.should be_nil
    end

    it 'should not change @unpending buyer' do
      lambda do
        @rake_cron.invoke
        @unpending.reload
      end.should_not change(@unpending, :buyer)
    end

    it 'should set expected buyer' do
      @rake_cron.invoke
      @pending.reload.buyer.should_not be_nil
    end
  end
end