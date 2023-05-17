require "tfc/mdm/api/version"
require "tfc/mdm/api/configuration"
require "tfc/mdm/api/engine"

module Tfc
  module Mdm
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
