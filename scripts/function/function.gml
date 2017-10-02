switch(argument0){

case "split":
var words;
words[0] = 0;
var startI = 0;
for(var ch = 0; ch < string_length(argument1); ch++){
 if(string_char_at(argument1, ch) == argument2){
  var newWord = string_replace_all(string_copy(argument1, startI, ch - startI),
								   argument2, "");
  if(newWord!=""){
   words[0]++;
   words[words[0]] = newWord;
  }
  startI = ch + 1;
 }
}
newWord = string_replace_all(string_copy(argument1, startI, string_length(argument1)),
							 argument2, "");
if(newWord!=""){
 words[0]++;
 words[words[0]] = newWord;
}
return words;

case "searchList":
var list = argument1;
var key = argument2;
var val = argument3;

for(var m = 0; m < ds_list_size(list); m++){
 var mapID = ds_list_find_value(list, m);
 if(ds_map_find_value(mapID, key) == val)
  return mapID;
}

return noone;

case "getTime":
var hour = (argument1 % 720) div 60;
if(hour == 0) hour = 12;
var minute = argument1 % 60;
if(minute < 10) minute = "0" + string(minute);
var timeOfDay;
if(argument1 < 720) timeOfDay = "am";
else timeOfDay = "pm";

return string(hour) + ":" + string(minute) + timeOfDay;

case "compSentence":
if(argument1 == argument2) return 1;
var sim = 0;
var words1 = function("split", argument1, " ", false);
var words2 = function("split", argument2, " ", false);
if(words1[0] == 0 || words2[0] == 0)
 return 0;
for(var w1 = 0; w1 < words1[0]; w1++){
 var simWord = 0;
 for(var w2 = 0; w2 < words2[0]; w2++){
  var comp = function("compWord", words1[w1 + 1], words2[w2 + 1], false);
  if(comp > simWord)
   simWord = comp;
 }
 sim += simWord;
}
return sim / sqrt(words1[0] * words2[0]);

case "compWord":
if(argument1 == argument2) return 1;
var Ldistance = abs(string_length(argument1) - string_length(argument2));
if(string_length(argument2) < string_length(argument1)){
 var shortString = argument2;
 var longString = argument1;
}else{
 var shortString = argument1;
 var longString = argument2;
}
for(var c = 0; c < string_length(shortString); c++){
 if(string_char_at(shortString, c) != string_char_at(longString, c)){
  if(string_char_at(string_lower(shortString), c) == string_char_at(string_lower(longString), c))
   Ldistance += .2;
  else
   Ldistance++;
 }
}

return 1 - Ldistance / string_length(longString);

case "messageSingle":
var buffer = buffer_create(1024, buffer_grow, 1);
buffer_write(buffer, buffer_u8, chat);
buffer_write(buffer, buffer_string, argument2);

network_send_packet(ds_map_find_value(argument1, "socket"), buffer, buffer_tell(buffer));
 
buffer_delete(buffer);
break;

case "messageAll":
var buffer = buffer_create(1024, buffer_grow, 1);
buffer_write(buffer, buffer_u8, chat);
buffer_write(buffer, buffer_string, argument1);

for(var a = 0; a < ds_list_size(onlineAccounts); a++){
 var accountID = ds_list_find_value(onlineAccounts, a);
 var socket = ds_map_find_value(accountID, "socket");
 network_send_packet(socket, buffer, buffer_tell(buffer));
}

buffer_delete(buffer);
break;

case "createAccount":
var accountID = argument1;
ds_map_add(accountID, "name", argument2);
ds_map_add(accountID, "password", argument3);
ds_map_add(accountID, "socket", noone);
ds_map_add(accountID, "action", noone);
ds_map_add(accountID, "timer", -1);
ds_map_add(accountID, "hunger", 100);
break;

case "saveAccounts":
ini_open("Accounts.ini");

ini_write_real("Global", "numAccounts", ds_list_size(obj_server.accounts));

for(var a = 0; a < ds_list_size(obj_server.accounts); a++){
 var accountID = ds_list_find_value(obj_server.accounts, a);
 var name = ds_map_find_value(accountID, "name");
 ini_write_string("AccountNames", string(a), name);
 ini_write_string(name, "password", ds_map_find_value(accountID, "password"));
}

ini_close();
break;

case "loadAccounts":
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
break;
}