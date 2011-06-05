# put following code as ~/config/initializers/001_app_congfig.rb
require 'ostruct'
require 'yaml'

appconfig       = OpenStruct.new(YAML.load_file("#{Rails.root}/config/app_config.yml"))
env_config      = appconfig.send(Rails.env) rescue nil

appconfig.common.update(env_config) unless env_config.nil?

AppConfig       = OpenStruct.new(appconfig.common)
