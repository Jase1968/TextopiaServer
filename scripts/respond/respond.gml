
accountID = argument1;
input = argument2;

switch(argument0){ //the response type
 case "chooseColor":
  var chosenColor = function("getColor", input, false, false);
 if(chosenColor == noone){
  function("messageSingle", accountID, "Invalid color. Input a /color name or /rgb values between 0 and 255 that average over 50.", c_yellow);
 }else{
    var buffer = buffer_create(1024, buffer_grow, 1);
    buffer_write(buffer, buffer_u8, colorChange);
    buffer_write(buffer, buffer_u32, chosenColor);
    network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
    buffer_delete(buffer);
    ds_map_replace(accountID, "color", chosenColor);
	ds_map_replace(accountID, "response", noone);
 }
 break;
 case "addFriend":
  var friendID = function("searchList", accounts, "name", input);
  if(friendID == noone){
   function("messageSingle", accountID, "There is noone named " + input, c_yellow);
  }else{
   function("sendLetter", accountID, friendID, "Want to be friends?");
   function("messageSingle", accountID, "Friend request sent via mail.", c_white);
   ds_map_replace(accountID, "response", noone);
  }
 break;
 
 case "checkMail":
  if(input == "reply"){
   function("messageSingle", accountID, "Which message do you want to reply to? Enter /number.", c_yellow);
   ds_map_replace(accountID, "response", "replyMail");
  }else if(input == "delete"){
   function("messageSingle", accountID, "Which message do you want to delete? Enter /number.", c_yellow);
   ds_map_replace(accountID, "response", "deleteMail");
  }else if(input == "close"){
   ds_map_replace(accountID, "response", noone);
  }else
   function("messageSingle", accountID, "That is not an option now. Enter /reply /delete or /close.", c_yellow);
 break;
 
 case "sendMailTo":
  var otherID = function("searchList", accounts, "name", input);
  if(otherID == noone){
   function("messageSingle", accountID, "There is noone with that name.", c_yellow);
   ds_map_replace(accountID, "response", noone);
  }else{
   function("messageSingle", accountID, "Write /(your message) to " + input + " or /cancel.", c_yellow);
   ds_map_replace(accountID, "response", "writeMail;" + input);
  }
 break;
 
 case "replyMail":
  var mail = ds_map_find_value(accountID, "mail");
  var mailNumber = real(input);
  if(string(mailNumber) == input && mailNumber > 0 && mailNumber <= ds_list_size(mail)){
   var mailSplit = function("split", ds_list_find_value(mail, mailNumber - 1), ";", false);
   var message = "";
   for(var s = 3; s <= mailSplit[0]; s++){
	message += mailSplit[s];
   }
   if(message == "Want to be friends?"){
    function("messageSingle", accountID, "Do you want to be friends with " + mailSplit[2] + "? Reply /Yes /No or /Cancel. You can never have too many friends!", c_yellow);
	ds_map_replace(accountID, "response", "confirmFriendRequest;" + mailSplit[2]);
   }else{
	function("messageSingle", accountID, "Write /(your reply) to " + mailSplit[2] + " or /cancel.", c_yellow);
	ds_map_replace(accountID, "response", "writeReplyMail;" + mailSplit[2]);
   }
  }else{
   if(ds_list_size(mail) == 1)
    function("messageSingle", accountID, "Enter /1 or /cancel", c_yellow);  
   else
    function("messageSingle", accountID, "Enter a number between /1 and /" + string(ds_list_size(mail)) + " or /cancel", c_yellow);
  }
  break;
  
 case "deleteMail":
  var mail = ds_map_find_value(accountID, "mail");
  var mailNumber = real(input);
  if(string(mailNumber) == input && mailNumber > 0 && mailNumber <= ds_list_size(mail)){
   ds_list_delete(mail, mailNumber - 1);
   function("messageSingle", accountID, "Message deleted!", c_yellow);
   ds_map_replace(accountID, "response", noone);
  }else{
   if(ds_list_size(mail) == 1)
    function("messageSingle", accountID, "Enter /1 or /cancel", c_yellow);  
   else
    function("messageSingle", accountID, "Enter a number between /1 and /" + string(ds_list_size(mail)) + " or /cancel", c_yellow);  
  }
 break;
 
 default:
  var responseSplit = function("split", argument0, ";", false);
  var otherID = function("searchList", accounts, "name", responseSplit[2]);
  if(otherID == noone){
   function("messageSingle", accountID, "That person no longer exists.", c_yellow);
   ds_map_replace(accountID, "response", noone);
  }
  if(responseSplit[1] == "confirmFriendRequest"){
   if(string_lower(input) == "yes"){
    var friendsList = ds_map_find_value(accountID, "friendsList");
	if(ds_list_find_index(friendsList, ds_map_find_value(otherID, "name")) == -1)
	 ds_list_add(friendsList, ds_map_find_value(otherID, "name"));
	friendsList = ds_map_find_value(otherID, "friendsList");
	if(ds_list_find_index(friendsList, ds_map_find_value(accountID, "name")) == -1)
	 ds_list_add(friendsList, ds_map_find_value(accountID, "name"));
	var mail = ds_map_find_value(accountID, "mail");
    for(var m = 0; m < ds_list_size(mail); m++){
     var mailSplit = function("split", ds_list_find_value(mail, m), ";", false);
	 if(mailSplit[2] == responseSplit[2] && mailSplit[3] == "Want to be friends?"){
	  ds_list_delete(mail, m);
	 }
    }
    function("messageSingle", accountID, ds_map_find_value(otherID, "name") + " is now your friend.", c_yellow);
    function("messageSingle", otherID, ds_map_find_value(accountID, "name") + " accepted your friend request.", c_yellow);
    ds_map_replace(accountID, "response", noone);
   }else if(string_lower(input) == "no"){
	var mail = ds_map_find_value(accountID, "mail");
   for(var m = 0; m < ds_list_size(mail); m++){
    var mailSplit = function("split", ds_list_find_value(mail, m), ";", false);
	if(mailSplit[2] == responseSplit[2] && mailSplit[3] == "Want to be friends?"){
	 ds_list_delete(mail, m);
	}
   }
   function("messageSingle", accountID, "Friend request deleted.", c_yellow);
   ds_map_replace(accountID, "response", noone);
   }	  
  }else if(responseSplit[1] == "writeMail"){
   function("sendLetter", accountID, otherID, input);
   function("messageSingle", accountID, "Message sent via mail!", c_yellow);
   ds_map_replace(accountID, "response", noone);
  }else if(responseSplit[1] == "writeReplyMail"){
   function("sendLetter", accountID, otherID, input);
   ds_map_replace(accountID, "response", noone);
   function("messageSingle", accountID, "Message sent via mail!", c_yellow);
  }
 break;
}