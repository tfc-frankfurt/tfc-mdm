Tfc::Mdm.configure do |config|
  # Set the base controller for the frontend.
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # Set the base controller for the frontend.
  #
  # Default: config.base_controller = 'your-google-maps-api-key-goes-here'
  #
  config.google_maps_api_key = 'your-google-maps-api-key-goes-here'
end
