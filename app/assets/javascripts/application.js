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


function getValue(id){
	return $("#"+id)[0].value 
}

function responseForm(msg){
  $("#response_form")[0].style.display = "block"
  $("#response_form").append("<br /> "+ msg);
  $("#response_form").fadeOut(3000, function(){
  	$("#response_form").empty();
  });
}

function alterPassword(id_password){
	var value = { password: getValue('password'+ id_password) }
	$.ajax({
		type: "PUT",
	  	url: "/credentials/"+ id_password,
	  	data: value,
	    success: function (data) {
	    	alert(data.message)
	    	console.log(data);
        }
	})

}

function deleteData(id_password){
	var value = { password: getValue('password'+ id_password) }
	if (window.confirm("Are you sure?")) { 
		$.ajax({
		  	type: "DELETE",
		  	url: "/credentials/"+ id_password,
		  	data: value,
		  	success: function (data) {
		    	$("#cred-"+ id_password)[0].remove();
		    	console.log(data);
	      	}
		})
	}
}

function switchPass(id_password){
	if ($("#spassword-"+id_password+"")[0].value == "Show") {
		$("#spassword-"+id_password+"")[0].value = "Hide";
		$("#password"+id_password+"").attr("type","text")
	} else {
		$("#password"+id_password+"").attr("type","password")
		$("#spassword-"+id_password+"")[0].value = "Show";
	}
}

function logout(){
	$("#logout")[0].click();
	
}

function verifyNewMsg()
{	
	var new_messages = "";
	$("#messages").text("Messages"+new_messages)
	
}

$( document ).ready(function() {
	//logout 5min 
	setTimeout("logout()",  5 * 60 * 1000);
	
	//Verify msg
	setInterval(function(){verifyNewMsg()}, 3000);
});

