require 'net/http'
require 'recaptcha'

ActionView::Base.send(:include, PlayCaptcha::ClientHelper)
ActionController::Base.send(:include, PlayCaptcha::Verify)