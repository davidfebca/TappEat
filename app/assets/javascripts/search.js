var searchController = function(form, inputLocation, inputLat, inputLng, submitButton){
  this.formulario = form
  this.inputLocation = inputLocation
  this.btnSubmit = submitButton
  this.inputLat = inputLat;
  this.inputLng = inputLng;
  this.placeSearch;
  this.autocomplete;
  this.initAutocomplete();
  this.setListeners();
  this.checkCookie();
};

searchController.prototype.setListeners = function(){
  $(this.inputLocation).focus(this.geolocate.bind(this));
  $(this.btnSubmit).click(this.submit.bind(this));
};

searchController.prototype.submit = function (e){
  e.preventDefault();
  if(this.inputLat.val() == 0 || this.inputLng.val() == 0){
    this.inputLocation.focus();
    return;
  }
  this.setCookie(document.getElementById(this.inputLocation).value,this.inputLat.val(),this.inputLng.val());
  this.formulario.submit();
};

searchController.prototype.fillInAddress = function(){
  var place = this.autocomplete.getPlace();
  this.inputLat.val(place.geometry.location.lat());
  this.inputLng.val(place.geometry.location.lng());
};

searchController.prototype.initAutocomplete = function(){
  this.autocomplete = new google.maps.places.Autocomplete((document.getElementById(this.inputLocation)),{types: ['geocode']});
  this.autocomplete.addListener('place_changed', this.fillInAddress.bind(this));
};

searchController.prototype.geolocate = function(){
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      this.autocomplete.setBounds(circle.getBounds());
    });
  }
};

searchController.prototype.checkCookie = function(){
  if (typeof $.cookie('tap_search') === 'undefined') {
    console.log("no cookies");
  }
  else {
    var cookie = JSON.parse($.cookie("tap_search"));
    this.inputLat.val(cookie.lat);
    this.inputLng.val(cookie.lng);
    document.getElementById(this.inputLocation).value = cookie.name;
  }
};

searchController.prototype.setCookie = function(name,lat,lng){
  var search = {
    name: name,
    lat:lat,
    lng:lng
  }
  $.cookie("tap_search", JSON.stringify(search));
};
