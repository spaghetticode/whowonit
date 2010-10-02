require 'test_helper'

class TraderApiTest < ActiveSupport::TestCase
  load_schema
  
  @@config = YAML.load_file("#{Rails.root}/config/trader_api_config.yml")['test']
  
  def test_config_loaded
    assert_equal @@config['url'], TraderApi::Config.url
  end
end