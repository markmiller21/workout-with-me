$( document ).ready(function() {
  if ($("#message").text() == "You've been matched!"){
    $(function() {
      $( "#dialog-confirm" ).dialog({
        resizable: false,
        height:300,
        modal: true,
        title: "You've been matched!",
        open: function(event, ui) { $(".ui-dialog-titlebar-close", ui.dialog | ui).hide(); },
        buttons: {
          "See your current matches!": function() {
            window.location = "/matches"
          },
          "Keep on swiping!": function() {
            $( this ).dialog( "close" );
          }
        }
      });
      $('.ui-dialog-buttonset').prepend($('.ui-dialog-titlebar'))
    });
  }
});