///Init Server

defineConstants();

server = network_create_server(network_socket_tcp, 7000, 100);

onlineAccounts = ds_list_create();

accounts = ds_list_create();

locations = ds_list_create();

function("loadAccounts", false, false, false);

time = 480; //8 AM
alarm[10] = stepsPerMinute;