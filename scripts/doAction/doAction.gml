
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

// test if the commmand is 
// - cooking (example: /cook [argument])
//if (string_length(input) > 3)
//{
	var tempInput = string_lower(input);
	
	// check ifthe comparedWord is in the first position of the input
	if (string_pos("cook", tempInput) == 1)
	{
		var foodMatch = false;
		var restWord = string_copy(tempInput, string_length("cook")+1, string_length(tempInput) - string_length("cook"));
		
		// and check if the name of the meal exists:
		for (var it = 0; it < ds_list_size(foodSearchList); it++)
		{
			var foodString = ds_list_find_value(ds_list_find_value(foodSearchList, it), 0);
			if ( string_pos(string_lower(foodString), restWord) > 0)
			{
				actions("act_cook", accountID, initialize, ds_list_find_value(foodSearchList, it));
				foodMatch = true;
				break;
			}
		}
		if(!foodMatch){
		 for (var it = 0; it < ds_list_size(foodSearchList); it++){
			var foodString = ds_list_find_value(ds_list_find_value(foodSearchList, it), 0);
			function("messageSingle", accountID, "Try /cook " + foodString, c_yellow);
		 }
		}
	}
	else if (string_pos("go", tempInput) == 1 || string_pos("go to", tempInput) == 1)
	{
		
	}else{

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
 actions(doCommand, accountID, initialize, false);
}

ds_list_destroy(tryCommands);
}
//}
}else{
 if(string_lower(input) == "cancel")
  ds_map_replace(accountID, "response", noone)
 else
  respond(response, accountID, input);
}
