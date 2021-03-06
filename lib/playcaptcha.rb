require 'playcaptcha/configuration'
require 'playcaptcha/client_helper'
require 'playcaptcha/verify'

module PlayCaptcha
  RECAPTCHA_API_SERVER_URL        = '//www.google.com/recaptcha/api'
  RECAPTCHA_API_SECURE_SERVER_URL = 'https://www.google.com/recaptcha/api'
  RECAPTCHA_VERIFY_URL            = 'http://www.google.com/recaptcha/api/verify'
  PLAYCAPTCHA_VERIFY_URL          = 'http://validation.futureadlabs.com/validate/'
  USE_SSL_BY_DEFAULT              = false

  HANDLE_TIMEOUTS_GRACEFULLY      = true
  SKIP_VERIFY_ENV = ['test', 'cucumber']

  # Gives access to the current Configuration.
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Allows easy setting of multiple configuration options. See Configuration
  # for all available options.
  #--
  # The temp assignment is only used to get a nicer rdoc. Feel free to remove
  # this hack.
  #++
  def self.configure
    config = configuration
    yield(config)
  end

  def self.with_configuration(config)
    original_config = {}

    config.each do |key, value|
      original_config[key] = configuration.send(key)
      configuration.send("#{key}=", value)
    end

    result = yield if block_given?

    original_config.each { |key, value| configuration.send("#{key}=", value) }
    result
  end

  class RecaptchaError < StandardError
  end
end

if defined?(Rails)
  require 'playcaptcha/rails'
end
