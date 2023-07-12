# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tfc/mdm/backend/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tfc-mdm-backend"
  s.version     = Tfc::Mdm::Backend::VERSION
  s.authors     = ["BeeGood IT"]
  s.email       = ["info@beegoodit.de"]
  s.summary     = "Tfc::Mdm::Backend."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "cmor_core"
  s.add_dependency "cmor_core_backend"
  s.add_dependency "tfc-mdm"
  s.add_dependency "country_select"
  s.add_dependency "twitter-bootstrap-components-rails", '>= 1.0.0'

  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-select-2"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rails-dummy"
  s.add_development_dependency "rao-shoulda_matchers"
  s.add_development_dependency "bootsnap"
  s.add_development_dependency "webpacker"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "puma"
end
