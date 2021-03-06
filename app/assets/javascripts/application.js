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
  
  var select = $("#select_service");
  if(select.length > 0){
    var price = select.find("option:selected").data('price');

    $("#paid_period_required_amount_service_id").val(select.val());

    $('#required-price').val(price);

    $('#amount').attr("max",price);

    select.on("change",function(){
      price = $(this).find("option:selected").data('price');
      $('#require-price').val(price);
      $('#amount').attr("max",price);
      $("#paid_period_required_amount_service_id").val(select.val());
      if($(this).find("option:selected").text() == "Питание"){
        $("#select_discount").attr("disabled",true);
      }else{
        $("#select_discount").attr("disabled",false);
      }
    });
  }
  
  
  $(".date").on("change",function(){
    console.log($(this).val());
    if($(this).attr("id") == "paid_period_start_date"){
      $("#start_date").val($(this).val());
    }else{
      $("#end_date").val($(this).val());
    }
  })
  $("#select_discount").on("change",function(){
    $("#paid_period_required_amount_single_discount_id").val($(this).find("option:selected").val())
  })
  $("#select_client").on("change",function(){
    if (select.find("option:selected").text() != "Питание"){
      
      if($(this).find("option:selected").data("discount") == true){
        $("#select_discount").attr("disabled",true);
        $("#paid_period_required_amount_discount_client_id").val($(this).find("option:selected").val())
      }else{
        $("#select_discount").attr("disabled",false);
        $("#paid_period_required_amount_discount_client_id").val("");
      }
    }
  })
  
$("#calculate-btn").on("click",function(){
    $("#calculate_form").submit();
});
  
  
});

function findClient(elem,path){
    $.ajax({
      type: 'GET',
      url: path,
      data: {client_name: $(elem).val()},
      dataType: 'script'
    })
}



  