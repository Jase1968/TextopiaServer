
for(var a = 0; a < ds_list_size(onlineAccounts); a++){
 var accountID = ds_list_find_value(onlineAccounts, a);
 var action = ds_map_find_value(accountID, "action");
 var timer = ds_map_find_value(accountID, "timer");
 var hunger = ds_map_find_value(accountID, "hunger");
 if(action != "none")
  actions(action, accountID, timer, false);
 if(timer > 0)
  ds_map_replace(accountID, "timer", timer - 1);
 else
  ds_map_replace(accountID, "action", "none");
 if(hunger > 100)
  ds_map_replace(accountID, "hunger", 100);
 if(hunger > 0)
  ds_map_replace(accountID, "hunger", hunger - .1);
}
for(var n = 0; n < ds_list_size(npcs); n++){
 var npc = ds_list_find_value(npcs, n);
 var quest = ds_map_find_value(npc, "quest");
 if(time = ds_map_find_value(npc, "initTime")){
  function("messageAll", ds_map_find_value(npc, "name") + ">" + ds_map_find_value(npc, "init"), ds_map_find_value(npc, "color"), false); 
 }
}