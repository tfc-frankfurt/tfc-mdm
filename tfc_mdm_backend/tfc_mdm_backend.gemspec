# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tfc/mdm/backend/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tfc_mdm_backend"
  s.version     = Tfc::Mdm::Backend::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.summary     = "Tfc::Mdm::Backend."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "cmor_core"
  s.add_dependency "tfc_mdm"
  s.add_dependency "country_select"
  s.add_dependency "twitter-bootstrap-components-rails", '>= 1.0.0'
end
