
var accountID = argument1;
var timer = argument2;

switch(argument0){


case "act_time":
//var accountID = argument1;

switch(timer){
 case initialize:
  function("messageSingle", accountID, function("getTime", time, false, false), c_white);
  break;
}
break;

case "act_eat":
//var accountID = argument1;
var name = ds_map_find_value(accountID, "name");
//var timer = argument2;

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
  function("messageSingle", accountID, name + " is making a sandwich.", c_white);
  break;
 case 20:
  function("messageSingle", accountID, name + " is eating a sandwich.", c_white);
  break;
 default:
  return false;
}
break;

case "act_showNeeds":
//var accountID = argument1;

switch(timer){
 case initialize:
  function("messageSingle", accountID, "Hunger: " + string(ds_map_find_value(accountID, "hunger")) + "%", c_blue);
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
   function("messageSingle", accountID, actions(action, accountID, queary), c_yellow);
  break;
}
break;

case "act_chooseColor":
 function("messageSingle", accountID, "Choose a color from the following:", c_yellow);
 function("messageSingle", accountID, "/red", c_red);
 function("messageSingle", accountID, "/blue", c_blue);
 function("messageSingle", accountID, "/orange", c_orange);
 function("messageSingle", accountID, "/green", c_green);
 ds_map_replace(accountID, "response", "chooseColor");
break;

case "act_chooseRed":
 if(ds_map_find_value(accountID, "response") == "chooseColor"){
  var buffer = buffer_create(1024, buffer_grow, 1);
  buffer_write(buffer, buffer_u8, colorChange);
  buffer_write(buffer, buffer_u32, c_red);
  network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
  buffer_delete(buffer);
  ds_map_replace(accountID, "color", c_red);
 }else
  function("messageSingle", accountID, "Try /Change color", c_yellow);
 ds_map_replace(accountID, "response", noone);
break;

case "act_chooseBlue":
 if(ds_map_find_value(accountID, "response") == "chooseColor"){
  var buffer = buffer_create(1024, buffer_grow, 1);
  buffer_write(buffer, buffer_u8, colorChange);
  buffer_write(buffer, buffer_u32, c_blue);
  network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
  buffer_delete(buffer);
  ds_map_replace(accountID, "color", c_blue);
 }else
  function("messageSingle", accountID, "Try /Change color", c_yellow);
 ds_map_replace(accountID, "response", noone);
break;

case "act_chooseOrange":
 if(ds_map_find_value(accountID, "response") == "chooseColor"){
  var buffer = buffer_create(1024, buffer_grow, 1);
  buffer_write(buffer, buffer_u8, colorChange);
  buffer_write(buffer, buffer_u32, c_orange);
  network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
  buffer_delete(buffer);
  ds_map_replace(accountID, "color", c_orange);
 }else
  function("messageSingle", accountID, "Try /Change color", c_yellow);
 ds_map_replace(accountID, "response", noone);
break;

case "act_chooseGreen":
 if(ds_map_find_value(accountID, "response") == "chooseColor"){
  var buffer = buffer_create(1024, buffer_grow, 1);
  buffer_write(buffer, buffer_u8, colorChange);
  buffer_write(buffer, buffer_u32, c_green);
  network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
  buffer_delete(buffer);
  ds_map_replace(accountID, "color", c_green);
 }else
  function("messageSingle", accountID, "Try /Change color", c_yellow);
 ds_map_replace(accountID, "response", noone);
break;

case "act_cookSpag":

//var accountID = argument1;
var name = ds_map_find_value(accountID, "name");
//var timer = argument2;


switch(timer){
 case initialize:
  ds_map_replace(accountID, "action", "act_cookSpag");
  ds_map_replace(accountID, "timer", 30);
  break;
 case queary:
  return "You are cooking spaghetti.";
  break;
 case 30:
  function("messageSingle", accountID, name + " is getting out the required ingredients.", c_white);
  break;
 case 28:
  function("messageSingle", accountID, name + " is heating up a pot of water.", c_white);
  break;
 case 27:
  function("messageSingle", accountID, name + " is heating up a pan of hamburger.", c_white);
  break;
 case 24:
  function("messageSingle", accountID, name + " is adding a handfull of spaghetti noodles and a pinch of salt to the boiling water.", c_white);
  break;
 case 20:
  function("messageSingle", accountID, name + " is draining the hamburger grease.", c_white);
  break;
 case 19:
  function("messageSingle", accountID, name + " is adding tomato sauce and seasoning to the hamburger.", c_white);
  break;
 case 10:
  function("messageSingle", accountID, name + " is straining the pasta.", c_white);
  break;
 case 8:
  function("messageSingle", accountID, name + " is combining the sauce with the noodles.", c_white);
  break;
 case 7:
  function("messageSingle", accountID, name + " is cleaning up the kitchen.", c_white);
  break;
 default:
  return false;
}
break;
}