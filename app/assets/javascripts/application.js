// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require_tree .


$(document).ready(function(){
  $('.filter-form').submit(function(){
    $('.filter-form :input').each(function(){
      if($(this).val() == ''){
        $(this).prop('name', '');
      }   
    });
  });
  
  var select = $("#select_service")
  
  var price = select.find("option:selected").data('price');
  
  $("#paid_service_service_id").val(select.val());
  
  $('#require-price').val(price);
  
  $('#amount').attr("max",price);
  
  select.on("change",function(){
    price = $(this).find("option:selected").data('price');
    $('#require-price').val(price);
    $('#amount').attr("max",price);
    $("#paid_service_service_id").val(select.val());
  });
  
  $("#new_paid_service").find(".date").on("change",function(){
    if($(this).attr("id") == "paid_service_start_date"){
      $("#start_date").val($(this).val());
    }else{
      $("#end_date").val($(this).val());
    }
  })
});

  