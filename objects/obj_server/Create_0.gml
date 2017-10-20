///Init Server

defineConstants();

server = network_create_server(network_socket_tcp, 7000, 100);

onlineAccounts = ds_list_create();

accounts = ds_list_create();

locations = ds_list_create();



// [Items]
// 0 = "phone"
// ...
// 123123 = "bottle"
itemList = ds_list_create();


// [Player1]
// 0 = 0
// 1 = 123213
// [Location]
// 0 = 0

// used for the server to serach through the list of available foods
foodSearchList = ds_list_create();

var foodCountMax = 183;
ini_open("Lists.ini");
for (var it = 0; it < foodCountMax; it++)
{
	// stores: food name and cooking durati	on
	var foodList = ds_list_create();
	ds_list_add(foodList, ini_read_string("Food", string(it), ""));
	ds_list_add(foodList, ini_read_real("FoodDuration", string(it), 1));
	
	ds_list_add(foodSearchList, foodList);
}
ini_close();


function("loadAccounts", false, false, false);

time = 480; //8 AM
alarm[10] = stepsPerMinute;