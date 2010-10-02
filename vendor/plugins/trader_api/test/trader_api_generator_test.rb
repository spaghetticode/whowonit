require File.dirname(__FILE__) + '/test_helper'

require 'rails/generators'
require 'generators/trader_api_generator'

class TraderApiGeneratorTest < Rails::Generators::TestCase
  DEST = File.join(Rails.root, 'tmp')
  tests TraderApiGenerator
  destination DEST
  teardown :remove_dest
  
  test 'generates expected file' do
    run_generator
    assert_file File.join(DEST, 'config/trader_api_config.yml'), /development:/
  end
  
  private
  
  def remove_dest
    FileUtils.rm_r(File.join(DEST, 'config'))
  end
end