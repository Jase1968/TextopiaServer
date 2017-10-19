
var accountID = argument0;
var input = argument1;
var name = ds_map_find_value(accountID, "name");
var response = ds_map_find_value(accountID, "response");
if(response == noone){
var doCommand = noone;
//var closestCommand = 1;
var tryCommands = ds_list_create();
var key = ds_map_find_first(commands);
var comp;
for(var k = 0; k < ds_map_size(commands); k++){
 comp = function("compSentence",key, input, false);
 //if(comp > closestCommand){
 if(string_lower(input) == key){
  doCommand = ds_map_find_value(commands, key);
  //closestCommand = comp;
 }else if(comp>.6)
  ds_list_add(tryCommands, key);
 key = ds_map_find_next(commands, key);
}

if(doCommand == noone){
 function("messageSingle", accountID, "Unrecognized.", c_yellow);
 ini_open("ServerData.ini");
 ini_write_real("Commands", input, ini_read_real("Commands", input, 0) + 1);
 ini_close();
 for(var k = 0; k < ds_list_size(tryCommands); k++)
  function("messageSingle", accountID, "Try /" + ds_list_find_value(tryCommands, k), c_yellow);
}else{
 actions(doCommand, accountID, initialize);
}

ds_list_destroy(tryCommands);
}else{
 if(string_lower(input) == "cancel")
  ds_map_replace(accountID, "response", noone)
 else
  respond(response, accountID, input);
}