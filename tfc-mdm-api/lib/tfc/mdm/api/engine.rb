module Tfc
  module Mdm
    module Api
      class Engine < ::Rails::Engine
        isolate_namespace Tfc::Mdm::Api
        config.generators.api_only = true
      end
    end
  end
end
