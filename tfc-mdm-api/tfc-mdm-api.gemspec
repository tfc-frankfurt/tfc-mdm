require_relative "lib/tfc/mdm/api/version"

Gem::Specification.new do |spec|
  spec.name        = "tfc-mdm-api"
  spec.version     = Tfc::Mdm::Api::VERSION
  spec.authors     = ["Roberto Vasquez Angel"]
  spec.email       = ["roberto@vasquez-angel.de"]
  spec.homepage    = "https://www.tfc-frankfurt.de"
  spec.summary     = "TFC Master Data Management Api"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.1.4"
  spec.add_dependency "rao-api-resources_controller"
  spec.add_dependency "rao-api-service_controller"
  spec.add_dependency "rao-query"
  spec.add_development_dependency "sqlite3"
end
