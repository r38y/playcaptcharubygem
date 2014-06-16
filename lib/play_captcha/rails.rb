require 'net/http'
require 'play_captcha'

ActionView::Base.send(:include, PlayCaptcha::ClientHelper)
ActionController::Base.send(:include, PlayCaptcha::Verify)
