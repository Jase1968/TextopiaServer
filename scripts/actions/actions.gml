
var accountID = argument1;
var timer = argument2;

switch(argument0){

case "act_lookAround":
 function("messageSingle", accountID, description("location", accountID), c_gray);
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
 }
break;

case "act_time":
switch(timer){
 case initialize:
  function("messageSingle", accountID, function("getTime", time, false, false), c_white);
  break;
}
break;

case "act_goToPark":
 if(ds_map_find_value(accountID, "location") != "park"){
 function("messageLocation", accountID, ds_map_find_value(accountID, "name") + " has gone to the park.", c_white);
 ds_map_replace(accountID, "location", "park");
 ds_map_replace(accountID, "sublocation", "main");
 function("messageLocation", accountID, ds_map_find_value(accountID, "name") + " arrived.", c_white);
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
  function("messageLocation", accountID, name + " is making a sandwich.", c_white);
  break;
 case 20:
  function("messageLocation", accountID, name + " is eating a sandwich.", c_white);
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
   function("messageSingle", accountID, actions(action, accountID, queary), c_yellow);
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

case "act_cookSpag":

var name = ds_map_find_value(accountID, "name");

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