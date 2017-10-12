switch(argument0){

//word[] returns the sentence broken into words
case "split": //("split", String sentence, char splitCharacter)
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

//ds_map returns a map by matching a key to a value or noone if it doesn't find a match
case "searchList": //("searchList", ds_list dsList, String dsKey, var value)
var list = argument1;
var key = argument2;
var val = argument3;

for(var m = 0; m < ds_list_size(list); m++){
 var mapID = ds_list_find_value(list, m);
 if(ds_map_find_value(mapID, key) == val)
  return mapID;
}

return noone;

//String returns the time of day as a string e.g. "10:27pm"
case "getTime": //("getTime", int timeInMinutes)
var hour = (argument1 % 720) div 60;
if(hour == 0) hour = 12;
var minute = argument1 % 60;
if(minute < 10) minute = "0" + string(minute);
var timeOfDay;
if(argument1 < 720) timeOfDay = "am";
else timeOfDay = "pm";

return string(hour) + ":" + string(minute) + timeOfDay;

//double returns the L distance between 2 sentences
case "compSentence": //("compSentence", String firstSentence, String secondSentence) 
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

//double returns the Ldistance between 2 words
case "compWord": //("compWord", String firstWord, String secondWord)
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

//void messages a single person privately
case "messageSingle": //("messageSingle", ds_map accountID, String message, int color)
var buffer = buffer_create(1024, buffer_grow, 1);
buffer_write(buffer, buffer_u8, chat);
buffer_write(buffer, buffer_string, argument2);
buffer_write(buffer, buffer_u32, argument3);

network_send_packet(ds_map_find_value(argument1, "socket"), buffer, buffer_tell(buffer));
 
buffer_delete(buffer);
break;

//messages everyone in a location
case "messageLocation": //("messageLocation", ds_map accountID, String message, int color)
var buffer = buffer_create(1024, buffer_grow, 1);
buffer_write(buffer, buffer_u8, chat);
buffer_write(buffer, buffer_string, argument2);
buffer_write(buffer, buffer_u32, argument3);

var accountID = argument1;
for(var a = 0; a < ds_list_size(onlineAccounts); a++){
 var otherID = ds_list_find_value(onlineAccounts, a);
 var location = ds_map_find_value(otherID, "location");
 var sublocation = ds_map_find_value(otherID, "sublocation");
 var socket = ds_map_find_value(otherID, "socket");
 if(location == ds_map_find_value(accountID, "location") && sublocation == ds_map_find_value(accountID, "sublocation"))
  network_send_packet(socket, buffer, buffer_tell(buffer));
}
break;

//messages everyone online
case "messageAll": //("messageAll", String message, int color)
var buffer = buffer_create(1024, buffer_grow, 1);
buffer_write(buffer, buffer_u8, chat);
buffer_write(buffer, buffer_string, argument1);
buffer_write(buffer, buffer_u32, argument2);

for(var a = 0; a < ds_list_size(onlineAccounts); a++){
 var accountID = ds_list_find_value(onlineAccounts, a);
 var socket = ds_map_find_value(accountID, "socket");
 network_send_packet(socket, buffer, buffer_tell(buffer));
}

buffer_delete(buffer);
break;

case "sendLetter":
 var sender = argument1;
 var recipient = argument2;
 var message = argument3;
 ds_list_add(ds_map_find_value(recipient, "mail"), "new;" + ds_map_find_value(sender, "name") + ";" + message);
 if(ds_map_find_value(recipient, "socket") != noone){
  function("messageSingle", recipient, "You've got mail!", c_yellow);
 }
break;

case "hasNewMail":
 var accountID = argument1;
 var mail = ds_map_find_value(accountID, "mail");
 for(var m = 0; m < ds_list_size(mail); m++){
  if(string_copy(ds_list_find_value(mail, m), 0, 3) == "new")
   return true;
 }
return false;

//void adds variables to a newly created account
case "createAccount":
var accountID = argument1;
ds_map_add(accountID, "name", argument2);
ds_map_add(accountID, "password", argument3);
ds_map_add(accountID, "socket", noone);
ds_map_add(accountID, "location", "house");
ds_map_add(accountID, "sublocation", argument2);
ds_map_add(accountID, "mail", ds_list_create());
//ds_map_add(accountID, "address", (100 + ds_list_size(accounts)) + " Main Street");
ds_map_add(accountID, "action", "none");
ds_map_add(accountID, "response", noone);
ds_map_add(accountID, "color", c_white);
ds_map_add(accountID, "timer", -1);
ds_map_add(accountID, "hunger", 100);
break;

//void saves the game
case "saveAccounts":
ini_open("Accounts.ini");

ini_write_real("Global", "numAccounts", ds_list_size(obj_server.accounts));

for(var a = 0; a < ds_list_size(obj_server.accounts); a++){
 var accountID = ds_list_find_value(obj_server.accounts, a);
 var name = ds_map_find_value(accountID, "name");
 ini_write_string("AccountNames", string(a), name);
 ini_write_string(name, "password", ds_map_find_value(accountID, "password"));
 ini_write_real(name, "color", ds_map_find_value(accountID, "color"));
 ini_write_string(name, "location", ds_map_find_value(accountID, "location"));
 ini_write_string(name, "sublocation", ds_map_find_value(accountID, "sublocation"));
 //ini_write_string(name, "address", ds_map_find_value(accountID, "address"));
 ini_write_string(name, "action", ds_map_find_value(accountID, "action"));
 ini_write_real(name, "timer", ds_map_find_value(accountID, "timer"));
 ini_write_real(name, "hunger", ds_map_find_value(accountID, "hunger"));
 ini_write_string(name, "mail", ds_list_write(ds_map_find_value(accountID, "mail")));
}

ini_close();
break;

//void loads the game
case "loadAccounts":
ini_open("Accounts.ini");

var numAccounts = ini_read_real("Global", "numAccounts", 0);

for(var a = 0; a < numAccounts; a++){
 var accountID = ds_map_create();
 var name = ini_read_string("AccountNames", string(a), "");
 ds_map_add(accountID, "name", name);
 ds_map_add(accountID, "password", ini_read_string(name, "password", ""));
 ds_map_add(accountID, "socket", noone);
 ds_map_add(accountID, "location", ini_read_string(name, "location", "house"));
 ds_map_add(accountID, "sublocation", ini_read_string(name, "sublocation", name));
 //ds_map_add(accountID, "address", ini_read_string(name, "address", (100 + ds_list_find_index(accounts, accountID)) + " Main Street"));
 ds_map_add(accountID, "action", ini_read_string(name, "action", "none"));
 ds_map_add(accountID, "response", noone);
 ds_map_add(accountID, "color", ini_read_real(name, "color", c_white));
 ds_map_add(accountID, "timer", ini_read_real(name, "timer", -1));
 ds_map_add(accountID, "hunger", ini_read_real(name, "hunger", 100));
 var mail = ds_list_create();
 ds_map_add(accountID, "mail", mail);
 var mailString = ini_read_string(name, "mail", "");
 if(mailString != "")
  ds_list_read(mail, mailString);
 ds_list_add(accounts, accountID);
}

ini_close();
break;

case "getColor":
  var input = argument1;
  var chosenColor = noone;
  var rgb = function("split", input, ",", false);
  if(rgb[0] == 3){
   var red = real(string_digits(rgb[1]));
   var green = real(string_digits(rgb[2]));
   var blue = real(string_digits(rgb[3]));
   if(red >= 0 && red < 256 &&
      green >= 0 && green < 256 &&
   	  blue >= 0 && blue < 256 &&
	  (red + green + blue) / 3 >= 50)
    var chosenColor = make_color_rgb(red, green, blue);
 }else{
  key = ds_map_find_first(colors);
  for(var k = 0; k < ds_map_size(colors); k++){
   if(input == key){
	chosenColor = ds_map_find_value(colors, key);
	break;
   }
  key = ds_map_find_next(colors, key);
  }
 }
 return chosenColor;
break;
}