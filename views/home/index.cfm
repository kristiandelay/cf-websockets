<!doctype html>
<html>
<head>
  
<script src="http://cdn.socket.io/stable/socket.io.js"></script>
  <!-- Grab Google CDN's jQuery, with a protocol relative URL; fall back to local if necessary -->
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js"></script>
  <script type="text/javascript" src="/javascripts/signals.min.js"></script>
  <script type="text/javascript" src="/javascripts/socket.party.js"></script>
  <script type="text/javascript" src="/javascripts/sockets.js"></script>
  <script type="text/javascript" src="/javascripts/modernizr-1.7.min.js"></script>
</head>
<body>
  <div class="draggable" style="height:100px;width:100px;background-color:#dd0"></div>
  <div id="messages"></div>

  <br/>
  Priority
  <select id="newMessageType">
    <option>None</option>
    <option>Low</option>
    <option>Medium</option>
    <option>High</option>
  </select>
  <input type="text" id="newMessage"/>
  <br/>
  <button id="submitMessage">Send Message</button>
  <br/>
  <button id="disconnect">Disconnect</button>
  <br/>
  <button id="connect">Connect</button>
</body>
</html>