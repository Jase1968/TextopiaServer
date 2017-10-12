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
    ds_map_replace(accountID, "socket", noone);
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
    actions("act_chooseColor", accountID, initialize);
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
	if(function("hasNewMail", accountID, false, false)){
	 function("messageSingle", accountID, "You've got mail!", c_yellow);
	}
   }
   //if(successfulLogin)
   // actions("act_chooseColor", accountID, initialize);
   break;
   
  case chat:
   var accountID = function("searchList", accounts, "socket", eventID);
   var name = ds_map_find_value(accountID, "name");
   var message = buffer_read(rbuffer, buffer_string);
   function("messageAll", name + ">" + message, ds_map_find_value(accountID, "color"), false);
   if(string_char_at(message, 1) == "/"){
    doAction(accountID, string_copy(message, 2, string_length(message)));
   }
   break;
 
 }
}