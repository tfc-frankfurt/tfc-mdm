Tfc::Mdm.configure do |config|
  # Set the base controller for the frontend.
  #
  # Default: config.base_controller = "<%= base_controller_class_name %>"
  #
  config.base_controller = "<%= base_controller_class_name %>"

  # Set the base controller for the frontend.
  #
  # Default: config.base_controller = "your-google-maps-api-key-goes-here"
  #
  config.google_maps_api_key = "your-google-maps-api-key-goes-here"

  # Set the default currency.
  #
  # Default: config.default_currency = :eur
  #
  config.default_currency = :eur

  # Set the user class name. This is used to tie users to people and memberships.
  #
  # Default: config.user_class_name = "<%= user_class_name %>"
  #
  config.user_class_name = "<%= user_class_name %>"

  # Set the current user proc. This is called inside controllers to fetch the
  # current user.
  #
  # Default: config.current_user_proc = -> { send(:current_user) }
  #
  config.current_user_proc = -> { send(:current_user) }
end
