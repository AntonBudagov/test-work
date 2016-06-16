define [], ->
  initMap = ->
    myLatlng = new (google.maps.LatLng)(45.4474136, 10.9589054)
    # Add the coordinates
    mapOptions =
      zoom: 17
      minZoom: 6
      maxZoom: 20
      zoomControl: true
      zoomControlOptions: style: google.maps.ZoomControlStyle.DEFAULT
      center: myLatlng
      mapTypeId: google.maps.MapTypeId.ROADMAP
      scrollwheel: false
      panControl: false
      mapTypeControl: false
      scaleControl: false
      streetViewControl: false
      overviewMapControl: false
      rotateControl: false
    map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
    map2 = new (google.maps.Map)(document.getElementById('map-canvas2'), mapOptions)
    image = new google.maps.MarkerImage("/images/markGoogle.png", null, null, null, new google.maps.Size(24, 40))

    marker = new (google.maps.Marker)(
      position: myLatlng
      icon: image
      map: map
      title: 'Click to visit our company on Google Places')

    contentString = "
      <div class='infoWindowMap'>
      <div class='title'>
      <i class='w-icon wi-dog'></i>
      <div class='title-content'>
      <h3>Trattoria Da Ropeton</h3>
      <p class='subTitle'>Via Fontana del Ferro, 1, Verona, Italy</p>
      </div>
      </div>
      <a class='link phone' href='tel:+390458030040'>
      <i class='fa fa-phone'></i>
      +390458030040
      </a>
      <a class='link' href='http://trattoriadaropeton.it/' target='_blank'>
      <i class='fa fa-link'></i>
      trattoriadaropeton.it‎
      </a>
      </div>"
    infowindow = new (google.maps.InfoWindow)(content: contentString)

    google.maps.event.addListener marker, 'click', ->
      # Add a Click Listener to our marker
      infowindow.open map, marker

      # Open our InfoWindow
    google.maps.event.addDomListener window, 'resize', ->
      map.setCenter myLatlng


  initMap()