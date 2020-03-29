require_relative 'boot'

require 'rails'

%w[
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  sprockets/railtie
].each { |railtie| require railtie }

Bundler.require(*Rails.groups)

module Rubyfunctions
  class Application < Rails::Application
    config.load_defaults 6.0
  end
end
