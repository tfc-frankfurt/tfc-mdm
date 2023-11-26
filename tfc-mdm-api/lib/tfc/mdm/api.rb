require "cmor-core-api"
require "rao-api-resources_controller"
require "rao-api-service_controller"
require "rao-query"
require "responders"
require "tfc-mdm"

require "tfc/mdm/api/configuration"
require "tfc/mdm/api/engine"
require "tfc/mdm/api/version"

module Tfc
  module Mdm
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
