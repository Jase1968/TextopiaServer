
var accountID = argument0;
var name = ds_map_find_value(accountID, "name");
var timer = argument1;

if(timer > 0 && timer < 20) ds_map_replace(accountID, "hunger",
								ds_map_find_value(accountID, "hunger") + 1);

switch(timer){
 case initialize:
  ds_map_replace(accountID, "action", act_eat);
  ds_map_replace(accountID, "timer", 30);
  break;
 case queary:
  return "You are eating.";
  break;
 case 30:
  messageSingle(accountID, name + " is making a sandwich.");
  break;
 case 20:
  messageSingle(accountID, name + " is eating a sandwich.");
  break;
 default:
  return false;
}