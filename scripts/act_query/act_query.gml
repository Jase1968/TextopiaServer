var accountID = argument0;
var action = ds_map_find_value(accountID, "action");
switch(argument1){
 case initialize:
  if(action == noone)
   function("messageSingle", accountID, "You are idle.", false);
  else
   function("messageSingle", accountID, script_execute(action, accountID, queary), false);
  break;
}