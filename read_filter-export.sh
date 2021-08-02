#!/bin/bash

mgr=$(cat config.cfg | sed -n '1,1p')
echo "Line contents are : $mgr"
user=$(cat config.cfg | sed -n '2,2p')
echo "Line contents are : $user"
passwd=$(cat config.cfg | sed -n '3,3p')
echo "Line contents are : $passwd"

rm cluster_info
touch cluster_info
rm host_info
touch host_info
rm filter_info
touch filter_info

./to_nsx_mgr $mgr $user $passwd | grep "Enabled" | awk '{print $3}' > clusters_id

cat clusters_id | while read clust
do
echo "Line contents are : $clust "
./to_nsx_step2 $mgr $user $passwd $clust >> cluster_info
done

cat cluster_info | grep "Enabled" >  prepped-hosts

cat prepped-hosts |  awk '{print $3}' > hosts_lists

cat hosts_lists  | while read host
do
echo "Checking host : $host"
echo "Host: $host" >> filter_info
./to_nsx_step3 $mgr $user $passwd $host | grep "nic-" | awk  '{print $4}' >> host_info
  cat host_info | while read filter
  do
  filtertc=$(tr -dc '[[:print:]]' <<< "$filter")
  echo " Reading filter version for: $filter"
  echo " Filter: $filter" >> filter_info
  ./to_nsx_step4 $mgr $user $passwd $host $filtertc
  ./to_nsx_step4 $mgr $user $passwd $host $filtertc | grep "version" >> filter_info
  done
done
echo "End of the script"
