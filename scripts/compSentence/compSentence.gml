if(argument0 == argument1) return 1;
var sim = 0;
var words1 = split(argument0, " ");
var words2 = split(argument1, " ");
if(words1[0] == 0 || words2[0] == 0)
 return 0;
for(var w1 = 0; w1 < words1[0]; w1++){
 var simWord = 0;
 for(var w2 = 0; w2 < words2[0]; w2++){
  var comp = compWord(words1[w1 + 1], words2[w2 + 1]);
  if(comp > simWord)
   simWord = comp;
 }
 sim += simWord;
}
return sim / sqrt(words1[0] * words2[0]);
