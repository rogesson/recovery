function updateNote(id, body){
  value = { note: { body: body } }

  if (window.confirm("Do you really want to update?")) { 
    $.ajax({
      type: "PUT",
        url: "/notes/"+ id,
        data: value,
        success: function (data) {
          alert('Note Updated');
        }
    });
  }
}

function showNote(note){
  var url = $(note).attr("value");
  coloboxHTML(url);
}
