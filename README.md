
# nsxv-get-export-fw-version
## Disclaimer
>**THE DEVELOPER WORK'S PRODUCT IS PROVIDED “AS IS” WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED, INCLUDING WITHOUT ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT.**

>**The installation steps described in this document are restricted to development environments only and must not be used in production environments.**

### Overview

 Retrieve DFW export version using NSXV Central CLI

 The script is aim to retrieve export version on each FW enabled host of each prepped V clusters

### Install Guide

 copy these scripts in a folder on a ubuntu machine (or any linux machine but tested on ubuntu) files named to_nsx* are expect scripts

 On your ubuntu machine, install expect 
 
`apt-get install expect`

 do a chmod of the files  (to_nsx* and *.sh) to be executables.

 Read_filter-export.sh connects to the NSX-V Manager using informations you have to include in a config.yml in the same folder where the bash script is.
#### config.yml:
```
<IP_address_of_mgr>
<SSH_User>
<SSH_Passwd>
````
 Results are stored in generated file:
 
 filter_info

### Comments
 If no fw on vnic -> RPC error -> Timeout but the script continues. Just taking more time to complete 

 #### Optimisation -> reduce the number of ssh to the nsx manager. Currently ssh open/close for each and every command
 
 -> Improvement: connect once and send commands in a loop (loop has to be defined in the expect script, then)


### Result Example:
```
Host: host-18 /
 Filter: nic-2337685-eth1-vmware-sfw.2
filter version: 1000
 Filter: nic-2337685-eth0-vmware-sfw.2
filter version: 1000
 Filter: nic-2443174-eth1-vmware-sfw.2
filter version: 1000
 Filter: nic-2443174-eth0-vmware-sfw.2
filter version: 1000
Host: host-20
 Filter: nic-2337685-eth1-vmware-sfw.2
 Filter: nic-2337685-eth0-vmware-sfw.2
 Filter: nic-2443174-eth1-vmware-sfw.2
 Filter: nic-2443174-eth0-vmware-sfw.2
 Filter: nic-2781215-eth0-vmware-sfw.2
filter version: 1000
...
```

