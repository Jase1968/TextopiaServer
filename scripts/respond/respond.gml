
accountID = argument1;
input = argument2;

switch(argument0){ //the response type
 case "chooseColor":
  var chosenColor = function("getColor", input, false, false);
 if(chosenColor == noone){
  function("messageSingle", accountID, "Invalid color. Input a color name or rgb values between 0 and 255 that average over 50.", c_yellow);
 }else{
    var buffer = buffer_create(1024, buffer_grow, 1);
    buffer_write(buffer, buffer_u8, colorChange);
    buffer_write(buffer, buffer_u32, chosenColor);
    network_send_packet(ds_map_find_value(accountID, "socket"),
  					  buffer, buffer_tell(buffer));
    buffer_delete(buffer);
    ds_map_replace(accountID, "color", chosenColor);
	ds_map_replace(accountID, "response", noone);
 }
 break;
}