
var list = argument0;
var key = argument1;
var val = argument2;

for(var m = 0; m < ds_list_size(list); m++){
 var mapID = ds_list_find_value(list, m);
 if(ds_map_find_value(mapID, key) == val)
  return mapID;
}

return noone;