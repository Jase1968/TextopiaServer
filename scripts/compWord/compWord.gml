if(argument0 == argument1) return 1;
var Ldistance = abs(string_length(argument0) - string_length(argument1));
if(string_length(argument1) < string_length(argument0)){
 var shortString = argument1;
 var longString = argument0;
}else{
 var shortString = argument0;
 var longString = argument1;
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
