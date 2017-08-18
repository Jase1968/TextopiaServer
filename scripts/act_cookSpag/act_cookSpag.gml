
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
  messageSingle(accountID, name + " is getting out the required ingredients.");
  break;
 case 28:
  messageSingle(accountID, name + " is heating up a pot of water.");
  break;
 case 27:
  messageSingle(accountID, name + " is heating up a pan of hamburger.");
  break;
 case 24:
  messageSingle(accountID, name + " is adding a handfull of spaghetti noodles and a pinch of salt to the boiling water.");
  break;
 case 20:
  messageSingle(accountID, name + " is draining the hamburger grease.");
  break;
 case 19:
  messageSingle(accountID, name + " is adding tomato sauce and seasoning to the hanburger.");
  break;
 case 10:
  messageSingle(accountID, name + " is straining the pasta.");
  break;
 case 8:
  messageSingle(accountID, name + " is combining the sauce with the noodles.");
  break;
 case 7:
  messageSingle(accountID, name + " is cleaning up the kitchen.");
  break;
 default:
  return false;
}