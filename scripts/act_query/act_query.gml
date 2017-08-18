var accountID = argument0;
var action = ds_map_find_value(accountID, "action");
switch(argument1){
 case initialize:
  if(action == noone)
   messageSingle(accountID, "You are idle.");
  else
   messageSingle(accountID, script_execute(action, accountID, queary));
  break;
}