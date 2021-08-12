#!/bin/sh

SERVER1=jupiter
SERVER2=saturno

command_list_domains="sqlite3 /etc/pihole/gravity.db \"select domain from vw_whitelist;\""

echo "Sincronizando whitelists que están en $SERVER2 y no en $SERVER1 -> $SERVER1"

for dns in `ssh $SERVER2 $command_list_domains`
do
  command_is_in_list="sqlite3 /etc/pihole/gravity.db \"select count(*) from vw_whitelist where domain='$dns';\""
  dns_en_server1=`ssh $SERVER1 $command_is_in_list`
  if [ $dns_en_server1 -eq 0 ]
  then
     echo $dns
     ssh $SERVER1 "pihole -w " $dns
  fi
done


echo "Sincronizando whitelists que están en $SERVER1 y no en $SERVER2 -> $SERVER2"

for dns in `ssh $SERVER1 $command_list_domains`
do
  command_is_in_list="sqlite3 /etc/pihole/gravity.db \"select count(*) from vw_whitelist where domain='$dns';\""
  dns_en_server2=`ssh $SERVER2 $command_is_in_list`
  if [ $dns_en_server2 -eq 0 ]
  then
     echo $dns
     ssh $SERVER2 "pihole -w " $dns
  fi
done
