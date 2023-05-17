# frozen_string_literal: true

module Tfc
  module Mdm
    class Engine < ::Rails::Engine
      isolate_namespace Tfc::Mdm

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot
        g.factory_bot dir: 'spec/factories'
      end
    end
  end
end
