var accountID = argument0;
ds_map_add(accountID, "name", argument1);
ds_map_add(accountID, "password", argument2);
ds_map_add(accountID, "socket", noone);
ds_map_add(accountID, "action", noone);
ds_map_add(accountID, "timer", -1);
ds_map_add(accountID, "hunger", 100);