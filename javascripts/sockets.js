
//app
$(document).ready(function() {
  var socket = new SocketParty();

  socket.openSocket();

  socket.bind('text_message', function(message){$('#messages').append('<p>' + message + '</p>');});
  socket.bind('box_moved', function(pos){$('.draggable').css({top: pos.top , left: pos.left})});

  //app specific
  $('.draggable').draggable({ drag: function(event, ui) {
    socket.transmit('box_moved', ui.position);
  }});
  
  var sendChatMessage = function() {
    socket.transmit('text_message', $('#newMessage').val());
    $('#newMessage').val('');
  };

  $('#newMessage').keypress(function(){
    if( event.which == '13' ) {
      sendChatMessage();
    }
  });


  $('#submitMessage').click(function(){
	sendChatMessage();
  });

  $('#disconnect').click(function(){
	socket.closeSocket();
  });

  $('#connect').click(function(){
	socket.openSocket();
  });
});