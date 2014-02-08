# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

function requestTo(){
	var xdp = { name: $("#weq")[0].value, location: "Boston" }
	$.ajax({
	  type: "GET",
	  url: "main/1",
	  data: xdp
	})
}
