//=require jquery-2.2.4.min
//=require jquery-cookies
//=require bootstrap.min
//= require jquery_ujs
//=require search
//=require results

function updateCount() {
  var count = $(this).val().length;
  $('.count').text(count);
  if(count >100){
    $('.count').css("color","red")
  } else{
     $('.count').css("color","green")
  }
}

TAPPEAT = {
  common: {
    init: function() {
      new searchController($('#searchForm'),'autocomplete',$('#inputLat'),$('#inputLng'),$('#btnSearch'));
    }
  },
  home: {
      init: function() {
        $('.header').addClass('is-home');
        $('#autocomplete').focus();
      },
      index: function() {
        $(window).scroll(function(){
          if($(window).scrollTop() > $('.claim').height() - 90){
            $('.header').addClass('colored');
          }else{
            $('.header').removeClass('colored');
          }
        });
      }
  },
  products:{
    edit: function(){
      var shortDescription = $( "input[name='product[short_description]']");
      shortDescription.keyup(updateCount);
      shortDescription.keydown(updateCount);
      initAutocomplete()
    }
  },
  shoppingcart:{
    basket:function(){
      $('.cart-product .delete').click(function(){
        var id = $(this).attr('data-id');
        $.ajax({
           url: '/ajax/shoppingcart/delete',
           type:'POST',
           data: {id:id},
           success: function(data) {
             location.reload();
           },
           error: function() {
             console.log("error deleting the product")
           }
        });
      });
    },
  },
  account: {
    index: function(){
      var shortDescription = $( "input[name='product[short_description]']");
      shortDescription.keyup(updateCount);
      shortDescription.keydown(updateCount);
      $('.add-product').click(function(){
        $('.add-product-form').show();
        initAutocomplete()
        $('html, body').animate({
          scrollTop: $('.add-product-form').offset().top
        }, 1000);
      });
      $('.user-product .delete').click(function(){
        var id = $(this).attr('data-id');
        $.ajax({
           url: '/ajax/products/delete',
           type:'POST',
           data: {id:id},
           success: function(data) {
             location.reload();
           },
           error: function() {
             console.log("error deleting the product")
           }
        });
      });
    }
  }
};
UTIL = {
  exec: function( controller, action ) {
    var ns = TAPPEAT, action = ( action === undefined ) ? "init" : action;
    if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {
      ns[controller][action]();
    }
  },
  init: function() {
    var body = document.body, controller = body.getAttribute( "data-controller" ),
    action = body.getAttribute( "data-action" ); UTIL.exec( "common" );
    UTIL.exec( controller );
    UTIL.exec( controller, action );
  }
};
$( document ).ready( UTIL.init );
