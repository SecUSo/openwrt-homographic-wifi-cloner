# Copyright 2015 Daniel Franke
# Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

include $(TOPDIR)/rules.mk

PKG_NAME:=wificloner
PKG_RELEASE:=0.1.0

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/wificloner
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Luci application enables the user to scan for Wi-Fis and clone their SSID.
endef

define Package/wificloner/description
The Wificloner offers the possibility to create a new wireless LAN which has the same SSID like the cloned one.
Because the encryption is disabled for clones wireless LANs, the cloned ones are disabled and have to be enabled in the normal Wi-Fi menu.
Important: All new wireless LANs which are cloned with this module are associated with the Interface clonedwifis which belongs to the firewall zone
clonedwifis_zone. The zone and the interface are created automatically. The Interface clonedwifis has the IP address 10.0.0.1 and over this interface
IP-addresses from 10.0.0.10 - 10.0.0.250 are distributed via dhcp
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/wificloner/install
	$(CP) ./dist/* $(1)/
endef

$(eval $(call BuildPackage,wificloner))
