
var accountID = argument0;
var input = argument1;
var name = ds_map_find_value(accountID, "name");

var doCommand = noone;
var closestCommand = 0.6;
var tryCommands = ds_list_create();
var key = ds_map_find_first(commands);
var comp;
for(var k = 0; k < ds_map_size(commands); k++){
 comp = function("compSentence",key, input, false);
 if(comp > closestCommand){
  doCommand = ds_map_find_value(commands, key);
  closestCommand = comp;
 }else if(comp>.3)
  ds_list_add(tryCommands, key);
 key = ds_map_find_next(commands, key);
}

if(doCommand == noone){
 function("messageSingle", accountID, "Unrecognized.", false);
 for(var k = 0; k < ds_list_size(tryCommands); k++)
  function("messageSingle", accountID, "Try /" + ds_list_find_value(tryCommands, k), false);
}else{
 script_execute(doCommand, accountID, initialize);
}

ds_list_destroy(tryCommands);