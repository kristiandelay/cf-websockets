<cfcomponent name="socketWrap">   
  <cfset PACKET_MODES = StructNew()/>
  <cfset a = StructInsert(PACKET_MODES, "BROADCAST", "BROADCAST", 1)/>
  <cfset a = StructInsert(PACKET_MODES, "RELAY", "RELAY", 1)/>
  <cfset a = StructInsert(PACKET_MODES, "PING", "PING", 1)/>
  <cfset a = StructInsert(PACKET_MODES, "TOSERVER", "TOSERVER", 1)/>
  <cfset a = StructInsert(PACKET_MODES, "SERVERBROADCAST", "SERVERBROADCAST", 1)/>

  <cfset packet = StructNew()/>
  <cfset a = StructInsert(packet, "message", "server_message", 1)/>
  <cfset a = StructInsert(packet, "data", "1", 1)/>
  <cfset a = StructInsert(packet, "sender", "0", 1)/> 
  <cfset a = StructInsert(packet, "type", PACKET_MODES.BROADCAST, 1)/> 

  <cffunction name="onClientOpen">
    <cfargument name="event" />
    <cfset var msg = {} />
    <cfset a = StructInsert(packet, "data", "Connected to the WS server", 1)/>
    <cfset a = StructInsert(packet, "sender", event.originatorID, 1)/> 

    <cfset outgoingPacket = SerializeJSON(packet)>

    <cfset msg["MESSAGE"] = outgoingPacket />
    <cfset msg["DESTINATIONWEBSOCKETID"] = event.originatorID />
    <cfreturn msg/>
  </cffunction>

  <cffunction name="onIncomingMessage">
    <cfargument name="event" />
    <cfset var msg = {} />
    <cfset incomingPacket = DeserializeJSON(event.data.message)>
    <cfset a = StructInsert(incomingPacket, "type", incomingPacket.type, 1)/> 
    <cfset a = StructInsert(incomingPacket, "sender", event.originatorID, 1)/> 

    <cfif incomingPacket.type eq PACKET_MODES.PING >
      <cfset msg["DESTINATIONWEBSOCKETID"] = event.originatorID />
      <cfset outgoingPacket = SerializeJSON(incomingPacket)/>
      <cfset msg["MESSAGE"] = outgoingPacket />
    <cfelseif incomingPacket.type eq PACKET_MODES.TOSERVER >
    <cfelse>
      <cfset outgoingPacket = SerializeJSON(incomingPacket)/>
      <cfset msg["MESSAGE"] = outgoingPacket />
    </cfif>

	<cfreturn msg />
  </cffunction>

  <cffunction name="onClientClose">
    <cfargument name="event" />
    <cfset var msg = {} />
	<cfset a = StructInsert(packet, "data", "A User Has Left :(", 1)/>
    <cfset outgoingPacket = SerializeJSON(packet)>
    <cfset msg["MESSAGE"] = outgoingPacket />
	<cfreturn msg />
  </cffunction>
</cfcomponent>