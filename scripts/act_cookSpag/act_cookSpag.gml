
var accountID = argument0;
var name = ds_map_find_value(accountID, "name");
var timer = argument1;


switch(timer){
 case initialize:
  ds_map_replace(accountID, "action", act_cookSpag);
  ds_map_replace(accountID, "timer", 30);
  break;
 case queary:
  return "You are cooking spaghetti.";
  break;
 case 30:
  function("messageSingle", accountID, name + " is getting out the required ingredients.", false);
  break;
 case 28:
  function("messageSingle", accountID, name + " is heating up a pot of water.", false);
  break;
 case 27:
  function("messageSingle", accountID, name + " is heating up a pan of hamburger.", false);
  break;
 case 24:
  function("messageSingle", accountID, name + " is adding a handfull of spaghetti noodles and a pinch of salt to the boiling water.", false);
  break;
 case 20:
  function("messageSingle", accountID, name + " is draining the hamburger grease.", false);
  break;
 case 19:
  function("messageSingle", accountID, name + " is adding tomato sauce and seasoning to the hanburger.", false);
  break;
 case 10:
  function("messageSingle", accountID, name + " is straining the pasta.", false);
  break;
 case 8:
  function("messageSingle", accountID, name + " is combining the sauce with the noodles.", false);
  break;
 case 7:
  function("messageSingle", accountID, name + " is cleaning up the kitchen.", false);
  break;
 default:
  return false;
}