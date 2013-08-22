# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$("#address").autocomplete
    source: (request, response) ->
      $.ajax
          url: $("#address").attr "data"
          dataType: "json"
          data:
            maxRows: 12
            query: request.term

          success: (data) ->
            console.log data
            response $.map(data, (item) ->
              label: item.data.formatted_address
              lat: item.data.geometry.location.lat
              lng: item.data.geometry.location.lng
            )

    minLength: 2
    select: (event, ui) ->
      $('#latitude').val(ui.item.lat)
      $('#longitude').val(ui.item.lng)
      move_marker()
      #console.log (if ui.item then "Selected: " + ui.item.label else "Nothing selected, input was " + @value)

    open: ->
      $(this).removeClass("ui-corner-all").addClass "ui-corner-top"

    close: ->
      $(this).removeClass("ui-corner-top").addClass "ui-corner-all"



map = undefined
marker = undefined

getLocationByForm = ->
  new google.maps.LatLng($('#latitude').val(), $('#longitude').val())

initialize = ->
  current_location = getLocationByForm()
  options =
    zoom: 13
    mapTypeId: google.maps.MapTypeId.ROADMAP
    center: current_location
  map = new google.maps.Map(document.getElementById("map-canvas"), options)
  marker = new google.maps.Marker(
      map: map
      draggable: true
      animation: google.maps.Animation.DROP
      position: current_location
  )
  google.maps.event.addListener(marker, 'dragend', (event) ->
                                $('#latitude').val( event.latLng.lat())
                                $('#longitude').val(event.latLng.lng())
  )
  map

google.maps.event.addDomListener window, "load", initialize

move_marker = ->
  pos = getLocationByForm()
  marker.setPosition pos
  map.panTo pos


$ ->
  if $('form#new_hotel')
    $.ajax(
        url: $("#address").attr "data"
        dataType: "json"
        data:
          query: $("#address").attr "ip"
        success: (data) ->
          if item = data[0]
            console.log data
            $('#address').val(item.data.formatted_address)
            $('#latitude').val(item.data.geometry.location.lat)
            $('#longitude').val(item.data.geometry.location.lng)
            move_marker()
    )