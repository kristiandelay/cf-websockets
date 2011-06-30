  var Packet = function(t, d) {
    this.type = t;
    this.data = d;
  };

  //socket
  var SocketParty = function() {
    this.mysocket;
    this.callbacks = new Object();
    this.router = {};
  };

  SocketParty.prototype.bind = function(message, callback) {
    this.callbacks[message] = callback;
    this.router[message] = new signals.Signal();
    this.router[message].add(this.callbacks[message]);
  };

  SocketParty.prototype.openSocket = function() {

    this.mysocket = new WebSocket("ws://192.168.5.170:1225");
    this.mysocket._parent = this;
    this.bind('server_message', function(message){$('#messages').append('<p>' + message + '</p>');});

    this.mysocket.onopen = function(evt) {
      var json = evt.data;
      this._parent.router['server_message'].dispatch('onopen triggered');
    };

    this.mysocket.onmessage = function(evt) {
      var json = evt.data;
      this._parent.router[JSON.parse(json).type].dispatch(JSON.parse(json).data);
    };

    this.mysocket.onclose = function(evt) {
      displayMessage("High", "Socket Connection closed.");
    };
  };

  SocketParty.prototype.closeSocket = function() {
    this.mysocket.close();
  }

  SocketParty.prototype.transmit = function(type,data) {
    var json = new Packet(type, data);
    this.mysocket.send(JSON.stringify(json));
  };