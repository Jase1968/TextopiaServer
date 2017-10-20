/// Networking

var eventID = ds_map_find_value(async_load, "id");

if(eventID==server){

 var clientSocket = ds_map_find_value(async_load, "socket");
 
 switch(ds_map_find_value(async_load, "type")){
 
  case network_type_connect:
   //var clientID = ds_map_create();
   //ds_list_add(clients, clientID);
   //ds_map_add(clientID, "socket", clientSocket);
   //ds_map_add(clientID, "name", "Guest");
   //ds_map_add(clientID, "online", false);
   //messageSingle(clientSocket, "'New' or 'Continue'");
   break;
   
  case network_type_disconnect:
   var accountID = function("searchList", onlineAccounts, "socket", clientSocket);
   if(accountID != noone){
	function("messageLocation", ds_map_find_value(accountID, "location"), ds_map_find_value(accountID, "name") + " has logged out.", c_gray);
	function("messageSingle", accountID, "You have been disconnected. /logout or /exit.", c_red);
    ds_map_replace(accountID, "socket", noone);
    ds_map_replace(accountID, "response", noone);
    ds_list_delete(onlineAccounts, ds_list_find_index(onlineAccounts, accountID));
    function("saveAccounts", false, false, false);
   }
 }
}else{

 //var clientID = searchList(clients, "socket", eventID);
 var rbuffer = ds_map_find_value(async_load, "buffer");
 
 //Read buffer
 switch(buffer_read(rbuffer, buffer_u8)){
 
  case register:
   var successfulRegistry = false;
   var buffer = buffer_create(1024, buffer_grow, 1);
   buffer_write(buffer, buffer_u8, register);
   var name = buffer_read(rbuffer, buffer_string);
   if(function("searchList", accounts, "name", name) == noone){
    successfulRegistry = true;
    buffer_write(buffer, buffer_bool, true);
    var accountID = ds_map_create();
	function("createAccount", accountID, name, buffer_read(rbuffer, buffer_string));
    //ds_map_add(clientID, "accountID", accountID);
    //ds_map_replace(accountID, "online", true);
	ds_map_replace(accountID, "socket", eventID);
	ds_list_add(accounts, accountID);
	ds_list_add(onlineAccounts, accountID);
   }else{
    buffer_write(buffer, buffer_bool, false); //not a unique username
   }
   network_send_packet(eventID, buffer, buffer_tell(buffer));
   buffer_delete(buffer);
   if(successfulRegistry)
    //function("messageLocation", ds_map_find_value(accountID, "location"), ds_map_find_value(accountID, "name") + " has joined the world.", c_white);
	actions("act_chooseColor", accountID, initialize, false);
   break;
  
  case login:
   var successfulLogin = false;
   buffer = buffer_create(1024, buffer_grow, 1);
   buffer_write(buffer, buffer_u8, login);
   var accountID = function("searchList", accounts, "name", buffer_read(rbuffer, buffer_string));
   if(accountID == noone)
    buffer_write(buffer, buffer_u8, false); //no usernames match
   else{
    if(ds_map_find_value(accountID, "password") == buffer_read(rbuffer, buffer_string)){
	 successfulLogin = true;
	 var onlineAccountID = ds_list_find_index(onlineAccounts, accountID);
	 if(onlineAccountID != -1){
      ds_map_replace(accountID, "response", noone);
	  function("messageSingle", accountID, "You have logged in on another computer. Please /logout or /exit.", c_red);
      ds_list_delete(onlineAccounts, ds_list_find_index(onlineAccounts, accountID));
	 }
	 buffer_write(buffer, buffer_u8, true);
     ds_map_replace(accountID, "socket", eventID);
	 ds_list_add(onlineAccounts, accountID);
	}else
	 buffer_write(buffer, buffer_u8, false); //passwords don't match
   }
   network_send_packet(eventID, buffer, buffer_tell(buffer));
   buffer_delete(buffer);
   if(successfulLogin){
    var buffer = buffer_create(1024, buffer_grow, 1);
    buffer_write(buffer, buffer_u8, colorChange);
    buffer_write(buffer, buffer_u32, ds_map_find_value(accountID, "color"));
    network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
    buffer_delete(buffer);
	function("messageLocation", ds_map_find_value(accountID, "location"), ds_map_find_value(accountID, "name") + " has logged in.", c_white);
	if(function("hasNewMail", accountID, false, false)){
	 function("messageSingle", accountID, "You've got mail!", c_yellow);
	}
   }
   break;
   
  case chat:
   var accountID = function("searchList", accounts, "socket", eventID);
   if(accountID == noone) return;
   var name = ds_map_find_value(accountID, "name");
   var message = buffer_read(rbuffer, buffer_string);
   if(string_char_at(message, 1) == "/"){
    function("messageSingle", accountID, name + ">" + message, ds_map_find_value(accountID, "color"));
    doAction(accountID, string_copy(message, 2, string_length(message)));
   }else{
    function("messageLocation", ds_map_find_value(accountID, "location"), name + ">" + message, ds_map_find_value(accountID, "color"));
   }
  break;
 }
}