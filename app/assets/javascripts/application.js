// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function responseForm(msg){
  $("#response_form")[0].style.display = "block"
  $("#response_form").append("<br /> "+ msg);
  $("#response_form").fadeOut(3000, function(){
  	$("#response_form").empty();
  });
}

function logout(){
	$("#logout")[0].click();
}

function coloboxHTML(url) {
	$.colorbox({href:url});
}

function editNote(id, body){
	value = { body: body }

	if (window.confirm("Do you really want to UPDATE this note?")) { 
		$.ajax({
			type: "PUT",
		  	url: "/notes/"+ id,
		  	data: value,
		    success: function (data) {
		    	alert('Note Updated')
	        }
		});
	}
}

function destroyNote(id){
	if (window.confirm("Do you really want to DELETE this note?")) { 
		$.ajax({
			type: "DELETE",
		  	url: "/notes/"+ id,
		  	data: null,
		    success: function (data) {
		    	console.log(data);
		    	$("#cboxOverlay").click();
		    	$("#note_item-"+id).remove();
	        }
		});
	}
}

$("#new_note_button").on("click", function(){
    var url = "/notes/new";
    $.colorbox({href:url});
});

$( document ).ready(function() {
	//logout 5min 
	setTimeout("logout()",  5 * 60 * 1000);
});


