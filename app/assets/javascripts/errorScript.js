$(document).ready(function() {
  if ($("#message").text() == "You've been matched!"){
    $("#message").hide();
    $(function() {
      $( "#error-confirm" ).dialog({
        resizable: false,
        height:300,
        modal: true,
        open: function(event, ui) { $(".ui-dialog-titlebar-close", ui.dialog | ui).hide(); },
        buttons: {
          "Start chatting!": function() {
            window.location = "/matches"
          },
          "Close window!": function() {
            $( this ).dialog( "close" );
          }
        }
      });
    });
  }
});