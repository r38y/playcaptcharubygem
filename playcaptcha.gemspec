# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "playcaptcha"
  s.version     = "0.4.4"
  s.authors     = ["Future Ad Labs"]
  s.email       = ["info@futureadlabs.com"]
  s.homepage    = "http://futureadlabs.com"
  s.summary     = %q{Helpers for the PlayCaptcha API}
  s.description = %q{This plugin adds helpers for the PlayCaptcha API}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
  s.add_development_dependency "activesupport"
  s.add_development_dependency "i18n"
end
