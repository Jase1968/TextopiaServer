/// Destroy Vars

function("messageAll", "Server down.", c_red, false);

function("saveAccounts", false, false, false);

ds_list_destroy(onlineAccounts);

for(var a = 0; a < ds_list_size(accounts); a++){
 ds_map_destroy(ds_list_find_value(accounts, a));
}
ds_list_destroy(accounts);

ds_map_destroy(commands);
ds_map_destroy(colors);