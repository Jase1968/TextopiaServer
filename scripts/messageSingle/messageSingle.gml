
var buffer = buffer_create(1024, buffer_grow, 1);
buffer_write(buffer, buffer_u8, chat);
buffer_write(buffer, buffer_string, argument1);

network_send_packet(ds_map_find_value(argument0, "socket"), buffer, buffer_tell(buffer));
 
buffer_delete(buffer);
