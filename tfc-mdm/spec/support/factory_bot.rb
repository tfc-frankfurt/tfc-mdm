require "factory_bot"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.tap do |f|
  f.factories.clear
  f.definition_file_paths += [
    Bgit::Invoicing::Engine.root.join(*%w[spec factories]),
    Tfc::Mdm::Engine.root.join(*%w[spec factories]),
    Rails.root.join(*%w[spec factories])
  ]
  f.find_definitions
end
