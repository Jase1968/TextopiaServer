var words;
words[0] = 0;
var startI = 0;
for(var ch = 0; ch < string_length(argument0); ch++){
 if(string_char_at(argument0, ch) == argument1){
  var newWord = string_replace_all(string_copy(argument0, startI, ch - startI),
								   argument1, "");
  if(newWord!=""){
   words[0]++;
   words[words[0]] = newWord;
  }
  startI = ch + 1;
 }
}
newWord = string_replace_all(string_copy(argument0, startI, string_length(argument0)),
							 argument1, "");
if(newWord!=""){
 words[0]++;
 words[words[0]] = newWord;
}
return words;
