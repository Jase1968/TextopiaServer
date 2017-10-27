/// Destroy Vars

function("messageAll", "Server down. Maybe it will be up again later? /logout or /exit.", c_red, false);

function("saveAccounts", false, false, false);

ds_list_destroy(onlineAccounts);

for(var a = 0; a < ds_list_size(accounts); a++){
 ds_map_destroy(ds_list_find_value(accounts, a));
}
ds_list_destroy(accounts);

for(var a = 0; a < ds_list_size(locations); a++){
 ds_map_destroy(ds_list_find_value(locations, a));
}
ds_list_destroy(locations);

ds_map_destroy(commands);
ds_map_destroy(colors);
ds_list_destroy(foodSearchList);
ds_list_destroy(itemList);
for(var n = 0; n < ds_list_size(npcs); n++){
 var npc = ds_list_find_value(npcs, n);
 ds_map_destroy(ds_map_find_value(npc, "quest"));
 ds_map_destroy(npc)
}
ds_list_destroy(npcs);
