print '[ActiveStorage] Enabling hack to serve svg files as images'
ActiveStorage::Engine.config
  .active_storage
  .content_types_to_serve_as_binary
  .delete('image/svg+xml')
puts ' => [OK]'