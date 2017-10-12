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
ds_map_add(commands, "look", "act_lookAround");
ds_map_add(commands, "look around", "act_lookAround");
ds_map_add(commands, "where am i", "act_lookAround");
ds_map_add(commands, "show time", "act_time");
ds_map_add(commands, "change color", "act_chooseColor");
ds_map_add(commands, "choose color", "act_chooseColor");
ds_map_add(commands, "go to the park", "act_goToPark");
ds_map_add(commands, "go home", "act_goHome");
ds_map_add(commands, "eat", "act_eat");
ds_map_add(commands, "cook", "act_cookSpag");
ds_map_add(commands, "cook spaghetti", "act_cookSpag");
ds_map_add(commands, "make spaghetti", "act_cookSpag");
ds_map_add(commands, "show needs", "act_showNeeds");
ds_map_add(commands, "?", "act_query");

colors = ds_map_create();
ds_map_add(colors, "aqua", c_aqua);
ds_map_add(colors, "blue", c_blue);
ds_map_add(colors, "fuchsia", c_fuchsia);
ds_map_add(colors, "gray", c_gray);
ds_map_add(colors, "green", c_green);
ds_map_add(colors, "lime", c_lime);
ds_map_add(colors, "light gray", c_ltgray);
ds_map_add(colors, "maroon", c_maroon);
//ds_map_add(colors, "navy", c_navy);   //too dark
ds_map_add(colors, "olive", c_olive);
ds_map_add(colors, "orange", c_orange);
ds_map_add(colors, "purple", c_purple);
ds_map_add(colors, "red", c_red);
ds_map_add(colors, "silver", c_silver);
ds_map_add(colors, "teal", c_teal);
ds_map_add(colors, "white", c_white);
ds_map_add(colors, "yellow", c_yellow);