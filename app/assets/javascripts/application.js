// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery-barcode
//= reuiqre jquery-print
//= require_tree .

$(document).ready (function(){
  
  $("#bar-code-input").change(function() {
    query = $("#bar-code-input").val()
    $.ajax({
      type: "GET",
      url: "/commodities",
      data: { search: query },
      dataType: "json",
      success:function(data) {
        data.commodities.forEach(function(c){
          $commodity = $("<tr><input type='hidden' name='c_ids' value='" + c.id+"' /><td>" + c.name + "</td><td>" + c.code +"</td><td></td><td></td><td>" + c.specification + "</td><td>" + c.unit + "</td><td><input type='text' name='"+c.id+"_quantity' value='1' class='form-control'/></td></tr>");
          $('#stock_data').append($commodity);
        });
      }
    });
  });
});