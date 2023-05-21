require 'factory_bot_rails'

FactoryBot.tap do |f|
  f.factories.clear
  f.definition_file_paths = [
    Rails.root.join(*%w(spec factories)),
    Cmor::Core::Api::Engine.root.join(*%w(spec factories)),
    Tfc::Mdm::Engine.root.join(*%w(spec factories))
  ]
  f.find_definitions 
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
