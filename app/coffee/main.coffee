define ['extra'], (extra)->
  console.log "Thiss Main and: #{extra}"
  # console.log "Thiss Main and: #{map}"

  # Menu ###########################################
  do ->
    bodyEl = document.body
    content = document.querySelector('.content-wrap')
    openbtn = document.getElementById('cd-nav-trigger')
    closebtn = document.getElementById('close-button')
    isOpen = false

    init = ->
      initEvents()

    initEvents = ->
      openbtn.addEventListener 'click', toggleMenu

      if closebtn
        closebtn.addEventListener 'click', toggleMenu

      content.addEventListener 'click', (ev) ->
        target = ev.target
        if isOpen and target != openbtn
          toggleMenu()

    toggleMenu = ->
      if isOpen
        bodyEl.className = ''
        openbtn.className = ' cd-nav-trigger'
      else
        bodyEl.className += 'show-menu'
        openbtn.className += ' cd-nav-trigger nav-is-visible'
      isOpen = !isOpen

    init()

  # Show #####################################

  show = $('.show')

  show.click ->
    $(this).parent().find('.text-desc').css 'height', '100%'
    $(this).hide()
    # ------------------

  # ShowToggle #####################################

  showToggle = $('.show-toggle')
  titleToggle = $('.infoCard-title')
  button_d = $('#button_show')

  button_d.click ->
    $(this).parents('main').toggleClass('show-map')

  showToggle.click ->
    $(this).parent().find('.show-toggle').toggle()
    $(this).parent().find('.contentCard').slideToggle(300, "swing")

  titleToggle.click ->
    $(this).parent().find('.show-toggle').toggle()
    $(this).parent().find('.contentCard').slideToggle(300, "swing")

  # Acardion #####################################
  $('.sub-menu ul').eq(1).hide()
  $('.sub-menu ul').eq(2).hide()

  title = $('.wrapLink')
  arrow = $('.arrows i')
  # $('.sub-menu ul').hide()
  title.click ->
    $(this).toggleClass('hide')
    $(this).parent('.sub-menu').find('ul').slideToggle(300, "swing")
    $(this).find('.fa').toggleClass 'fa-angle-down fa-angle-up'
  # Data Slider
  $('.selectDate').slick
    centerMode: true
    centerPadding: '0px'
    slidesToShow: 3
    focusOnSelect: true
    infinite: false
    initialSlide: 24
    responsive: [
      {
        breakpoint: 570
        settings:
          slidesToShow: 2
          slidesToScroll: 1
      }
      {
        breakpoint: 400
        settings:
          slidesToShow: 1
          slidesToScroll: 1
      }
    ]

  # Slide Card
  btnShow = $('.button_show')
  btnShow.click ->
    console.log 2
    $(this).parent().find('.content').slideToggle(300, "swing")

  # Map ####################################################
  # {map}
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


