# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tfc/mdm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tfc_mdm"
  s.version     = Tfc::Mdm::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.summary     = "Tfc::Mdm."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "acts_as_list"
  s.add_dependency "acts_as_published"
  s.add_dependency "cmor-translations"
  s.add_dependency "geocoder"
  s.add_dependency "rao-service"
  s.add_dependency "route_translator"
  s.add_dependency "simple_form-fake_inputs"
  s.add_dependency "simple_form-polymorphic_associations"
  s.add_dependency "timeline_events"
  
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "webpacker"
  s.add_development_dependency "bootsnap"
  s.add_development_dependency "rails-dummy"
  s.add_development_dependency "capybara"
  s.add_development_dependency "sqlite3", "~> 1.4"
end
