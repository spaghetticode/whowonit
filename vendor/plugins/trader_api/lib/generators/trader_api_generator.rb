class TraderApiGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  def generate_config
    copy_file 'trader_api_config.yml', 'config/trader_api_config.yml'
  end
end
