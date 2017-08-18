ini_open("Accounts.ini");

ini_write_real("Global", "numAccounts", ds_list_size(obj_server.accounts));

for(var a = 0; a < ds_list_size(obj_server.accounts); a++){
 var accountID = ds_list_find_value(obj_server.accounts, a);
 var name = ds_map_find_value(accountID, "name");
 ini_write_string("AccountNames", string(a), name);
 ini_write_string(name, "password", ds_map_find_value(accountID, "password"));
}

ini_close();