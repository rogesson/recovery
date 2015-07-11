function showPassword(id){
	var btnShow = $("#btn-show-"+ id);
	$("#password-" + id).attr("type","text");
	btnShow.text("Hide");
	btnShow.attr("onclick", "hidePassword("+ id +");")
}

function hidePassword(id){
	var btnShow = $("#btn-show-"+ id);
	$("#password-" + id).attr("type","password");
	btnShow.text("Show");
	btnShow.attr("onclick", "showPassword("+ id +");")
}

function updatePassword(id){
	$.ajax({
		type: "PUT",
	  	url: "/credentials/"+ id,
	  	data: $("#password"+ id).val(),
	    success: function (data) {
	    	console.log(data);
	    	alert("Password Updated!")
        }
	})
}

function deletePassword(id){
	if (window.confirm("Are you sure?")) { 
		$.ajax({
		  	type: "DELETE",
		  	url: "/credentials/"+ id,
		  	data: $("#password"+ id).val(),
		  	success: function (data) {
		    	$("#cred-"+ id)[0].remove();
		    	console.log(data);
	      }
		})
	}
}

function createCredential(){
	var url = "/credentials/new";
	$.colorbox({href:url});
}