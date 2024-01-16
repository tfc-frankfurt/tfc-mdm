module Tfc
  module Mdm
    class Configuration
      class << self
        extend Forwardable

        attr_accessor :values

        def define_option(key, default: nil)
          @values[key] = default
          define_singleton_method(key) do
            @values[key]
          end

          define_singleton_method("#{key}=") do |value|
            @values[key] = value
          end
        end
      end

      @values = {}

      define_option(:base_controller, default: "FrontendController")
      define_option(:google_maps_api_key, default: "your-google-maps-ypi-key-goes-here")
      define_option(:default_currency, default: :eur)
      define_option(:user_class_name, default: "User")
      define_option(:current_user_proc, default: -> { send(:current_user) })
    end
  end
end
