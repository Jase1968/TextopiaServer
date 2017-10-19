
switch(argument0){
 case "location":
  var accountID = argument1;
  var name = ds_map_find_value(accountID, "name");
  var location = ds_map_find_value(accountID, "location");
  var locID = function("searchList", locations, "#", location);
  var type = ds_map_find_value(locID, "type");
  var owner = ds_map_find_value(locID, "owner");
  var desc = ds_map_find_value(locID, "desc");
  return "You are at " + desc;
}
  /*var sublocation = ds_map_find_value(accountID, "sublocation")
  if(location == "house"){
   if(sublocation == name)
    return "You are at your home. There is a television, sofa, computer, kitchen, bathroom, and bedroom here.";
   else
    return "Your are at " + sublocation + "'s home. There is a television, sofa, computer, kitchen, bathroom, and bedroom here.";
  }else if(location == "park"){
   return "You are at the park. There is a slide, a swingset, a sandbox, and a pond here.";
  }else if(location == "beach"){
   return "You are at the beach. The sky is clear, the sand is warm, there are lots of waves and there is a volleyball net here. Also, Jim's Food Truck is here.";
  }
}