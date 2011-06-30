//app
$(document).ready(function() {
  var socket = new SocketParty();

  socket.openSocket();
  socket.bind('server_message', function(message){$('#messages').append('<p>' + message + '</p>');});
  //socket.bind('user_connected', function(message){$('#messages').append('<p>userconnected</p>');});
  socket.bind('text_message', function(message, type, sender){$('#messages').append('<p>' + message + ' (' + type + ' from ' + sender +') </p>');}, 'broadcast');
  socket.bind('box_moved', function(pos, type, sender){$('.draggable').css({top: pos.top , left: pos.left})}, 'broadcast');
  
  //app specific
  $('.draggable').draggable({ drag: function(event, ui) {
    socket.send('box_moved', ui.position, 'broadcast');
  }});
  
  var sendChatMessage = function() {
    socket.send('text_message', $('#newMessage').val(), $('#newMessageType').val());
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