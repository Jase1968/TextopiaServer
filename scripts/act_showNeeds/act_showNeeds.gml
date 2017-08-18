var accountID = argument0;

switch(argument1){
 case initialize:
  messageSingle(accountID, "Hunger: " + string(ds_map_find_value(accountID, "hunger")) + "%");
  break;
}