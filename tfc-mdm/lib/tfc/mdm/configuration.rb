module Tfc
  module Mdm
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:base_controller) { "FrontendController" }
      mattr_accessor(:google_maps_api_key) { "your-google-maps-ypi-key-goes-here" }
    end
  end
end
