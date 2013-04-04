require 'net/http'
require 'playcaptcha'

ActionView::Base.send(:include, PlayCaptcha::ClientHelper)
ActionController::Base.send(:include, PlayCaptcha::Verify)