ini_open("Accounts.ini");

var numAccounts = ini_read_real("Global", "numAccounts", 0);

for(var a = 0; a < numAccounts; a++){
 var accountID = ds_map_create();
 var name = ini_read_string("AccountNames", string(a), "");
 ds_map_add(accountID, "name", name);
 ds_map_add(accountID, "password", ini_read_string(name, "password", ""));
 ds_map_add(accountID, "socket", noone);
 ds_map_add(accountID, "action", ini_read_real(name, "action", noone));
 ds_list_add(accounts, accountID);
}

ini_close();