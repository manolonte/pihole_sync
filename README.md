# pihole_sync
Synchonizes domain lists in two pi.hole servers

- place the script into /usr/local/bin of any server, can be one of the two pi.hole servers
- change the names of the servers in the script (SERVER1 and SERVER2 variables)
- for unattended execution via cron, establish a trust relationship between server executing the script and the two pi.hole servers (or simply between the two pihole servers if the script is going to be executed by one of them). I have tested it just with root.

At this moment, the script synchronizes the whitelisted domains from one server to the other, two ways, there is no need to have a "master" server.
