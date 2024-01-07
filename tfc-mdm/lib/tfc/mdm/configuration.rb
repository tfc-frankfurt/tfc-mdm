module Tfc
  module Mdm
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:base_controller) { "FrontendController" }
      mattr_accessor(:google_maps_api_key) { "your-google-maps-ypi-key-goes-here" }
      mattr_accessor(:default_currency) { :eur }
      mattr_accessor(:user_class_name) { "User" }
      mattr_accessor(:current_user_proc) { -> { send(:current_user) } }
    end
  end
end
