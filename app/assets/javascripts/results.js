var resultsController = function(map, target,initialLat,initialLng, icon){
  this.map = map;
  this.mapInstance;
  this.icon = icon;
  this.resultsContainer = target;
  this.initialLat = parseFloat(initialLat);
  this.initialLng = parseFloat(initialLng);
  this.currentCenter =  {lat: this.initialLat, lng: this.initialLng};
  this.ratio = 1; //in km
  this.products = [];
  this.infoWindows = [];
  this.initMap();
  this.getProducts(this.initialLat,this.initialLng);
  this.setListeners();
};
Math.degrees = function(radians) {
  return radians * 180 / Math.PI;
};

resultsController.prototype.renderMarkers = function(products){
  for(var i = 0 ; i < products.length;i++){
    var myLatLng = {lat: Math.degrees(products[i][1]), lng: Math.degrees(products[i][2])};
      this.setMarker(myLatLng, products[i][0].id, products[i][0].title,products[i][3],products[i][0].price);
    }
};

resultsController.prototype.calculateDistance = function(origin,destination){
  return (google.maps.geometry.spherical.computeDistanceBetween(origin, destination) / 1000).toFixed(2);
};

resultsController.prototype.setListeners = function(){
  var self = this;
  this.mapInstance.addListener('center_changed',function(){
    var origin = self.mapInstance.getCenter();
    var destination = new google.maps.LatLng(self.currentCenter.lat,self.currentCenter.lng);
    var distance = self.calculateDistance(origin,destination);
    if(distance > self.ratio){
      self.currentCenter.lat = origin.lat();
      self.currentCenter.lng = origin.lng();
      self.getProducts(origin.lat(),origin.lng());
    }
  });
};

resultsController.prototype.appendProduct= function(product){
  //TODO: hacer un partial to string en rails
  var productString ='<article class="col-md-6 col-lg-4 col-sm-6 animated zoomIn product-container"><div class="product"><img class="header-bg img-responsive" src="' + product[3] +'" alt="'+ product[0].title+'"><div class="avatar"><img src="' + product[4] + '" alt=""></div><div class="content"><h3>'+ product[0].title +'</h3><p>' + product[0].short_description +'</p><span class="price color-red">' + product[0].price + '€ / <small>tappeat</small></span><a href="/products/details/' + product[0].id +'" class="btn btn-buy btn-red">Details</a></div></div></article>'
  this.resultsContainer.prepend(productString);
};

resultsController.prototype.setMarker = function(myLatLng , id, title, image, price){
  var self = this;
  var infowindow = new google.maps.InfoWindow({
   content: '<div data-id="'+ id +'" class="map-popup"><div class="pop-header">'+ title +'</div><div class="pop-content"><img src="' + image + '"/><span class="price">' + price + ' €</span></div></div>'
  });
  self.infoWindows.push(infowindow);
  var marker = new google.maps.Marker({
    position: myLatLng,
    map: self.mapInstance,
    icon: self.icon
  });
  marker.addListener('click', function() {
    for (var i=0;i<self.infoWindows.length;i++) {
     self.infoWindows[i].close();
    }
    infowindow.open(this.mapInstance, marker);
  });
};

resultsController.prototype.initMap = function(){
    this.mapInstance = new google.maps.Map(document.getElementById(this.map), {
      zoom: 15,
      center: this.currentCenter,
      scrollwheel: false,
      streetViewControl: false,
    });
};

resultsController.prototype.getProducts = function(lat,lng){
  var self = this;
  $.ajax({
  //TODO: don't hardcode the url
  url: '/search/search_near_json',
    type: 'GET',
    data: { lat: lat, lng: lng} ,
    success: function (data) {
      for(var i = 0 ; i < data.length;i++){
        var result = $.grep(self.products, function(e){ return e.id == data[i][0].id; });
        if (result.length == 0) {
          self.products.push(data[i][0]);
          self.appendProduct(data[i]);
        }
      }
      self.renderMarkers(data);
    },
    error: function () {
      console.log('Could not load products')
    }
  });
};
