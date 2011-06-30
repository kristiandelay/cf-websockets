<cfcomponent name="socketWrap">
  <cfset packet = StructNew()/>  
  <cfset a = StructInsert(packet, "type", "server_message", 1)/>
  <cfset a = StructInsert(packet, "data", "1", 1)/>


  <cffunction name="onClientOpen">
    <cfargument name="event" />
    <cfset var msg = {} />

    <cfset a = StructInsert(packet, "data", "Connected to the WS server", 1)/>

    <cfset outgoingPacket = SerializeJSON(packet)>
    <cfset msg["MESSAGE"] = outgoingPacket />
    <cfset msg["DESTINATIONWEBSOCKETID"] = event.originatorID />
    <cfreturn msg/>
  </cffunction>

  <cffunction name="onIncomingMessage">
    <cfargument name="event" />
    <cfset var msg = {} />

    <cfset incomingPacket = DeserializeJSON(event.data.message)>
    <cfset outgoingPacket = Duplicate(packet)/>
    <cfset outgoingPacket = SerializeJSON(incomingPacket)/>
 
    <cfset msg["MESSAGE"] = outgoingPacket />
  
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