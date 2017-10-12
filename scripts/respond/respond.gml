
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
  }
 break;
 
 case "confirmFriendRequest":
  if(string_lower(input) == "yes"){
   //add to friends list
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
   function("messageSingle", accountID, "That is not an option now. Enter /reply, /delete, or /close.", c_yellow);
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
    function("messageSingle", accountID, "Reply /Yes or /No. You can never have too many friends!", c_yellow);
	ds_map_replace(accountID, "response", "confirmFriendRequest");
   }else{
	function("messageSingle", accountID, "Write reply to " + mailSplit[2], c_yellow);
	ds_map_replace(accountID, "response", "writeReplyMail");
   }
  }else{
   function("messageSingle", accountID, "Enter a number between 1 and " + ds_list_size(mail) + " or /cancel", c_yellow);
  }
}