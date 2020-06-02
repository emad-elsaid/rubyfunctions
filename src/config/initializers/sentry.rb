Raven.configure { |config| config.dsn = ENV['SENTRY_DSN'] } if Rails.application.config_for(:rescue)[:report_to_sentry]
