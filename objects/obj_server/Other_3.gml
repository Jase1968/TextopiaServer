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

