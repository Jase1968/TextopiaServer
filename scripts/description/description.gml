
switch(argument0){
 case "location":
  var accountID = argument1;
  var name = ds_map_find_value(accountID, "name");
  var tag = ds_map_find_value(accountID, "location");
  var locID = function("searchList", locations, "tag", tag);
  if(locID == noone){
   locID = function("searchList", locations, "tag", name + "'s house");
   tag = ds_map_find_value(locID, "tag");
   ds_map_replace(accountID, "location", tag);
  }
  var type = ds_map_find_value(locID, "type");
  var owner = ds_map_find_value(locID, "owner");
  var desc = ds_map_find_value(locID, "desc");
  if(owner != "public"){
   if(name == owner)
    return "You are at your " +  ds_map_find_value(locID, "type") + ". " + ds_map_find_value(locID, "desc");
   else
    return "You are at " + owner + "'s " + ds_map_find_value(locID, "type") + ". " + ds_map_find_value(locID, "desc");
  }
  return "You are at " + tag + ". " + ds_map_find_value(locID, "desc");
}