  var Packet = function(m, d, t) {
    this.message = m;
    this.data = d;
    this.type = t;
  };

  //socket
  var SocketParty = function() {
    this.mysocket;
    this.uid;
    this.callbacks = new Object();
    this.router = {};
  };

  SocketParty.prototype.bind = function(message, callback , type) {
    this.callbacks[message] = callback;
    this.router[message] = new signals.Signal();
    this.router[message].add(this.callbacks[message]);
  };

  SocketParty.prototype.openSocket = function() {
    this.mysocket = new WebSocket("ws://192.168.5.170:1225");
    this.mysocket._parent = this;

    this.bind('server_message', function(message){$('#messages').append('<p>' + message + '</p>');});

    this.mysocket.onopen = function(evt) {
      this._parent.router['server_message'].dispatch('onopen triggered');
    };

    this.mysocket.onmessage = function(evt) {
      var json = JSON.parse(evt.data);
      if( this.uid === undefined ) {
        this.uid = json.sender;
      }

      if( json.type === "RELAY" && this.uid === json.sender ) {
        return false;
      }
      
      this._parent.router[json.message].dispatch(json.data, json.type, json.sender);
    };

    this.mysocket.onclose = function(evt) {
      displayMessage("High", "Socket Connection closed.");
    };
  };

  SocketParty.prototype.closeSocket = function() {
    this.mysocket.close();
  }

  SocketParty.prototype.send = function(message, data, type) {
    var json = new Packet(message, data, type);
    this.mysocket.send(JSON.stringify(json));
  };