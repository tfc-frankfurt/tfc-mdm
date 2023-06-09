# frozen_string_literal: true

require "rao/shoulda/matchers"

RSpec.configure do |config|
  config.include Rao::Shoulda::Matchers, type: :feature
  config.include Rao::Shoulda::Matchers, type: :system
end
