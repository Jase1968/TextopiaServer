/// Time

time++;
if(time == 1440) time = 0;

if(time % 60 == 0){
 var buffer = buffer_create(1024, buffer_grow, 1);
 buffer_write(buffer, buffer_u8, timeUpdate);
 buffer_write(buffer, buffer_u16, time);
 for(var a = 0; a < ds_list_size(onlineAccounts); a++){
  var accountID = ds_list_find_value(onlineAccounts, a);
  network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
 }
 buffer_delete(buffer);
 function("messageAll", function("getTime", time, false, false), false, false);
}

updateAction();
alarm[10] = stepsPerMinute;