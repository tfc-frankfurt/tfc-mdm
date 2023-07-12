require "capybara-select-2"

RSpec.configure do |config|
  config.include CapybaraSelect2
  config.include CapybaraSelect2::Helpers # if need specific helpers
end