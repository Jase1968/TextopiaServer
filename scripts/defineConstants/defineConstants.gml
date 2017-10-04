stepsPerMinute = 40;

//u8 types
chat = 0;
register = 1;
login = 2;
timeUpdate = 3;
colorChange = 4;

//actions
initialize = -1;
queary = -2;

commands = ds_map_create();
ds_map_add(commands, "show time", "act_time");
ds_map_add(commands, "change color", "act_chooseColor");
ds_map_add(commands, "choose color", "act_chooseColor");
ds_map_add(commands, "red", "act_chooseRed");
ds_map_add(commands, "blue", "act_chooseBlue");
ds_map_add(commands, "orange", "act_chooseOrange");
ds_map_add(commands, "green", "act_chooseGreen");
ds_map_add(commands, "eat", "act_eat");
ds_map_add(commands, "cook", "act_cookSpag");
ds_map_add(commands, "cook spaghetti", "act_cookSpag");
ds_map_add(commands, "make spaghetti", "act_cookSpag");
ds_map_add(commands, "show needs", "act_showNeeds");
ds_map_add(commands, "?", "act_query");