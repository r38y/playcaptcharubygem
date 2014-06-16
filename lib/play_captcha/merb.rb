require 'play_captcha'

Merb::GlobalHelpers.send(:include, PlayCaptcha::ClientHelper)
Merb::Controller.send(:include, PlayCaptcha::Verify)
