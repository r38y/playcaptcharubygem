require 'playcaptcha'

Merb::GlobalHelpers.send(:include, PlayCaptcha::ClientHelper)
Merb::Controller.send(:include, PlayCaptcha::Verify)
