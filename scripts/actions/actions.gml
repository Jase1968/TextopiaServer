
var accountID = argument1;
var timer = argument2;
var addInput = argument3;

 var location = ds_map_find_value(accountID, "location");
 var locID = function("searchList", locations, "#", location);
 
 
switch(argument0){

case "act_lookAround":
 /*function("messageSingle", accountID, description("location", accountID), c_gray);
 for(var a = 0; a < ds_list_size(accounts); a++){
  var otherID = ds_list_find_value(accounts, a);
  if(ds_map_find_value(otherID, "location") == ds_map_find_value(accountID, "location") &&
     ds_map_find_value(otherID, "sublocation") == ds_map_find_value(accountID, "sublocation")){
   if(ds_map_find_value(otherID, "socket") == noone){
    function("messageSingle", accountID, ds_map_find_value(otherID, "name") + " is here. <Offline>", c_dkgray);
   }else if(otherID != accountID){
    function("messageSingle", accountID, ds_map_find_value(otherID, "name") + " is here.", c_gray);
   }
  }
 }*/
break;

case "act_addFriend":
 function("messageSingle", accountID, "Who do you want to add? Enter '/friendName'", c_yellow);
 ds_map_replace(accountID, "response", "addFriend");
break;

case "act_time":
switch(timer){
 case initialize:
  function("messageSingle", accountID, function("getTime", time, false, false), c_white);
  break;
}
break;

case "act_viewFriends":
 var friendsList = ds_map_find_value(accountID, "friendsList");
 if(ds_list_size(friendsList) == 0)
  function("messageSingle", accountID, "You don't have any friends yet.", c_yellow);
 else
  function("messageSingle", accountID, "These are your friends:", c_yellow);
 for(var f = 0; f < ds_list_size(friendsList); f++){
  function("messageSingle", accountID, ds_list_find_value(friendsList, f), c_white);
 }
break;

case "act_sendMessage":
  function("messageSingle", accountID, "Who do you want to write to? Enter /name.", c_yellow);
  ds_map_replace(accountID, "response", "sendMailTo");
break;

case "act_readMail":
 var mail = ds_map_find_value(accountID, "mail");
 if(ds_list_size(mail) > 0){
 for(var m = 0; m < ds_list_size(mail); m++){
  var mailSplit = function("split", ds_list_find_value(mail, m), ";", false);
  var message = "";
  for(var s = 3; s <= mailSplit[0]; s++)
   message += mailSplit[s];
  var mailColor;
  if(mailSplit[1] == "new") mailColor = c_white;
  else mailColor = c_gray;
  function("messageSingle", accountID, string(m + 1) + ")" + mailSplit[2] + ">" + message, mailColor);
  ds_list_replace(mail, m, "old;" + mailSplit[2] + ";" + message);
 }
 function("messageSingle", accountID, "Do you want to /reply /delete or /close?", c_yellow);
 ds_map_replace(accountID, "response", "checkMail");
 }else{
  function("messageSingle", accountID, "You have no mail.", c_yellow);
 }
break;

/*
case "act_goToPark":
 if(ds_map_find_value(accountID, "location") != "park"){
 function("messageLocation", ds_map_find_value(accountID, "location"), ds_map_find_value(accountID, "name") + " has gone to the park.", c_white);
 ds_map_replace(accountID, "location", "park");
 ds_map_replace(accountID, "sublocation", "main");
 function("messageLocation", ds_map_find_value(accountID, "location"), ds_map_find_value(accountID, "name") + " arrived.", c_white);
 actions("act_lookAround", accountID, initialize);
 }else{
  function("messageSingle", accountID, "You are already at the park.", c_yellow);
 }
break;

case "act_goHome":
 if(ds_map_find_value(accountID, "location") == "house" &&
    ds_map_find_value(accountID, "sublocation") == ds_map_find_value(accountID, "name")){
	 function("messageSingle", accountID, "You are already home.", c_yellow);
 }else{
  function("messageLocation", accountID, ds_map_find_value(accountID, "name") + " has gone home.", c_white);
  ds_map_replace(accountID, "location", "house");
  ds_map_replace(accountID, "sublocation", ds_map_find_value(accountID, "name"));
  actions("act_lookAround", accountID, initialize);
 }
break;
*/

case "act_eat":
var name = ds_map_find_value(accountID, "name");

if(timer > 0 && timer < 20) ds_map_replace(accountID, "hunger",
								ds_map_find_value(accountID, "hunger") + 1);

switch(timer){
 case initialize:
  ds_map_replace(accountID, "action", "act_eat");
  ds_map_replace(accountID, "timer", 30);
  break;
 case queary:
  return "You are eating.";
  break;
 case 30:
  function("messageLocation", ds_map_find_value(accountID, "location"), name + " is making a sandwich.", c_white);
  break;
 case 20:
  function("messageLocation", ds_map_find_value(accountID, "location"), name + " is eating a sandwich.", c_white);
  break;
 default:
  return false;
}
break;

case "act_showNeeds":
//var accountID = argument1;

switch(timer){
 case initialize:
  function("messageSingle", accountID, "Hunger: " + string(ds_map_find_value(accountID, "hunger")) + "%", c_gray);
  break;
}
break;

case "act_query":
//var accountID = argument1;
var action = ds_map_find_value(accountID, "action");
switch(timer){
 case initialize:
  if(action == "none")
   function("messageSingle", accountID, "You are idle.", c_yellow);
  else
   function("messageSingle", accountID, actions(action, accountID, queary, addInput), c_yellow);
  break;
}
break;

case "act_chooseColor":
 function("messageSingle", accountID, "Type in '/red, green, blue' values or choose a color from the following:", c_yellow);
 var key = ds_map_find_first(colors);
 for(var k = 0; k < ds_map_size(colors); k++){
 function("messageSingle", accountID, "/" + key, ds_map_find_value(colors, key));
 key = ds_map_find_next(colors, key);
 }
 ds_map_replace(accountID, "response", "chooseColor");
break;


case "act_cook":

var name = ds_map_find_value(accountID, "name");

switch(timer){
 case initialize:
  ds_map_replace(accountID, "action", "act_cook");
  ds_map_replace(accountID, "timer", ds_list_find_value(addInput, 1));

  break;
 
 case queary:
  return "You are cooking a " + ds_list_find_value(addInput, 0) + ".";
  break;
 case 1:
  function("messageSingle", accountID, "Your meal is ready.", c_white);
  break;
 default:
  return false;
}
break;

}