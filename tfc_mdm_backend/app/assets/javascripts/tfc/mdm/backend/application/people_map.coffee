initMap = ->
  if typeof(google) == 'undefined'
    console.log 'Error: google is not defined.'
    return

  container = $('#people-map .map')
  container.css("height", container.width() / 16 * 9);
  console.log container
  myLatLng = 
    lat: -25.363
    lng: 131.044
  map = new (google.maps.Map)(container[0],
    zoom: 10
    center: myLatLng)

  $('#people-map .markers').children().each ->
    coordinates = 
      lat: $(@).data('lat')
      lng: $(@).data('lng')
    new (google.maps.Marker)(
      position: coordinates
      map: map
      title: $(@).data('label')
      label: $(@).data('label'))
    unless $(@).data('center') == null
      console.log "Centering map on #{$(@).data('label')}"
      map.setCenter(coordinates);
    console.log $(@)

  console.log map
  return

$ ->
  initMap()
