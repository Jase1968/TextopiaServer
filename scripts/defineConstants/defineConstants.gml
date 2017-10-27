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
ds_map_add(commands, "where am i?", "act_lookAround");
ds_map_add(commands, "show time", "act_time");
ds_map_add(commands, "change color", "act_chooseColor");
ds_map_add(commands, "choose color", "act_chooseColor");
ds_map_add(commands, "show needs", "act_showNeeds");
ds_map_add(commands, "?", "act_query");

ds_map_add(commands, "add friend", "act_addFriend");
ds_map_add(commands, "view friend list", "act_viewFriends");
ds_map_add(commands, "view friends", "act_viewFriends");
ds_map_add(commands, "send message", "act_sendMessage");
ds_map_add(commands, "send mail", "act_sendMessage");
ds_map_add(commands, "send message", "act_sendMessage");
ds_map_add(commands, "read mail", "act_readMail");
ds_map_add(commands, "check mail", "act_readMail");
ds_map_add(commands, "read messages", "act_readMail");
ds_map_add(commands, "check messages", "act_readMail");

// ds_map_add(commands, "go to the park", "act_goToPark");
// ds_map_add(commands, "go home", "act_goHome");

ds_map_add(commands, "eat", "act_eat");
ds_map_add(commands, "cook (food)", "act_showRecipes");
ds_map_add(commands, "go to (location)", "act_showLocations");
ds_map_add(commands, "go to (player)'s house", "act_showLocations");
ds_map_add(commands, "logout", "act_logout");
ds_map_add(commands, "exit", "act_quitGame");
ds_map_add(commands, "windowed", "act_fullscreen");
ds_map_add(commands, "fullscreen", "act_fullscreen");

colors = ds_map_create();
ds_map_add(colors, "aqua", c_aqua);
ds_map_add(colors, "blue", make_color_rgb(50, 100, 255));
ds_map_add(colors, "pink", c_fuchsia);
ds_map_add(colors, "gray", c_gray);
ds_map_add(colors, "green", c_green);
ds_map_add(colors, "lime", c_lime);
ds_map_add(colors, "maroon", c_maroon);
ds_map_add(colors, "olive", c_olive);
ds_map_add(colors, "orange", c_orange);
ds_map_add(colors, "purple", c_purple);
ds_map_add(colors, "red", c_red);
ds_map_add(colors, "salmon", make_color_rgb(255, 100, 100));
ds_map_add(colors, "silver", c_silver);
ds_map_add(colors, "teal", c_teal);
ds_map_add(colors, "white", c_white);
ds_map_add(colors, "yellow", c_yellow);

npcs = ds_list_create();
var manfred = ds_map_create();
ds_list_add(npcs, manfred);
ds_map_add(manfred, "name", "Manfred");
ds_map_add(manfred, "color", c_gray);
ds_map_add(manfred, "loction", "the park");
ds_map_add(manfred, "init", "Can you help me please? 'What do you want?', 'I can't right now', or 'Get lost!'");
ds_map_add(manfred, "initTime", 600); //(10:00 am)
var quest = ds_map_create();
ds_map_add(quest, "hello", "Can you help me please? 'What do you want?', 'I can't right now', or 'Get lost!'");
ds_map_add(quest, "what do you want?", "I need my kite that's stuck in that tree! 'I'll get it for you' or 'I don't think I can reach it'");
ds_map_add(quest, "i can't right now", "Maybe someone else can help me then.");
ds_map_add(quest, "get lost!", "Thanks for nothing!");
ds_map_add(quest, "i'll get it for you", "Thank you so much!");
ds_map_add(manfred, "quest", quest); 