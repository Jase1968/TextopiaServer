
var buffer = buffer_create(1024, buffer_grow, 1);
buffer_write(buffer, buffer_u8, chat);
buffer_write(buffer, buffer_string, argument0);

for(var a = 0; a < ds_list_size(onlineAccounts); a++){
 var accountID = ds_list_find_value(onlineAccounts, a);
 var socket = ds_map_find_value(accountID, "socket");
 network_send_packet(socket, buffer, buffer_tell(buffer));
}

buffer_delete(buffer);