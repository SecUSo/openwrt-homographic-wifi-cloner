# Wificloner

## Description
The Wificloner is a Openwrt addon. It extends the LuCI configuration interface with a function to clone wireless LANS. 
It offers the possibility to scan for wireless networks and to add a new wireless LAN which has the same SSID like the cloned one.
Because the encryption is disabled for clones wireless LANs, the cloned ones are disabled and have to be enabled in the normal Wi-Fi menu.

Important: All new wireless LANs which are cloned with this module are associated with the Interface clonedwifis which belongs to the firewall zone
clonedwifis.  The zone and the interface are created automatically. The Interface clonedwifis has the IP address 10.0.0.1 and over this interface
IP-addresses from 10.0.0.10 - 10.0.0.250 are distributed via dhcp.

## Installation
The Wificloner can be installed automatically via an ipk package or manually. 
If the packages subfolder does not contain a suitable package for your platform, you can create your own ipk package.

### Installation via opkg
1. Copy the ipk-file suitable for you platform from the package directory to your Openwrt system.
2. call opkg install wificloner_0.1.1_<platform_type>.ipk (e.g. wificloner_0.1.1_x86.ipk for the x86 version).

That’s it.

### Manual Installation
1. Copy all files/folders from package-dev/luci-wificloner/dist/ to the root folder of your Openwrt system.
2. Reboot the system.

### Create your own package
1. Build and/or install the Openwrt sdk (http://wiki.openwrt.org/doc/howto/obtain.firmware.sdk)
2. copy the Wificloner subfolder from package-dev to the packages subfolder of the sdk
3. Open command line, navigate to the sdk-folder and run make 
4. The package can be found in the folder bin/<platform name>/packages/base/

## Folders

### packages
Contains precompiled ipk-packages for some popular platforms.

### package-dev
Contains files used to create an ipk-package with the Openwrt sdk (see section "create your own package" for more information).
Does only contain stable releases created with the version from dev-folder.

### dev
This folder contains the development version of the addon. Development takes place with the luci develompent environment (http://luci.subsignal.org/trac/wiki/Documentation/DevelopmentEnvironmentHowTo).
The subfolder luci-wificloder can be directly used in the environment if you copy it to the application subfolder of the sdk.
The sdk creates a folder called distribution which can be used for the package creation (package dev). 


