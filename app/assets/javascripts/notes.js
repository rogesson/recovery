/*
function deleteNote(id){
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
*/

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
