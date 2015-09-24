--[[
Wi-Fi-Cloner addon for Luci
Copyright 2015 Daniel Franke
Some functions are inspired by the Wireless Setup of the original Luci Pages.
Especially the Page which lists the available Wlans contains some lines from the "Join-Wlan" function from original luci admin panel.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$

]]--

module("luci.controller.wificloner", package.seeall)

local cloned_wifis_nw_name = "clonedwifis"
local cloned_wifiss_zone_name = "clonedwifis_zone"

function index()
--[[	if not nixio.fs.access("/etc/config/wificloner") then
		return
	end
]]--

	entry({"admin", "services", "wificloner"}, template("wificloner_listdevices"), _("WiFiCloner"))
	entry({"admin", "services", "wificloner", "listwlans"}, call("list_and_clone"), nil)
end

function postvalue(name)
    return luci.http.formvalue(name)
end

function list_and_clone()
  local device  = postvalue("device")
  local clonessid = postvalue("ssid")
  local bssid = postvalue("bssid")
  local channel = postvalue("channel")

  if device and clonessid then
    local network = require "luci.model.network".init()

    device = network:get_wifidev(device)
    if device then
      local net = device:add_wifinet({
        mode       = "ap",
        ssid       = clonessid,
        encryption = "none",
        network = cloned_wifis_nw_name
      })
      network:commit("wireless")
      --create network and firewall zone if necessary
      create_nw_and_zone(cloned_wifis_nw_name, cloned_wifiss_zone_name)
      luci.http.redirect(luci.dispatcher.build_url("admin/network/wireless"))
    end
  else
    luci.template.render("wificloner_listwlans")
  end
end

-- creates nw and firewall zone with the given names if zone or network with given name do not exist.
function create_nw_and_zone (nw_name, zone_name)
  local uci  = require "luci.model.uci".cursor()
  local network   = require "luci.model.network"
  local firewall   = require "luci.model.firewall"
  local fs   = require "nixio.fs"
  
  local has_firewall = fs.access("/etc/config/firewall")
  network.init(uci)
  firewall.init(uci)
  
  --test if nw exists
  local wifinet = network:get_network(nw_name)
  if not wifinet then
    wifinet = network:add_network(nw_name, { 
    proto = "static",
    ipaddr = "10.0.0.1",
    netmask = "255.255.255.0" })
    --store and apply network settings
    network:commit("network")
    
   -- set dhcp options for created network 
    uci:section("dhcp", "dhcp", nw_name, {
    interface = nw_name,
    start     = "10",
    limit     = "250",
    leasetime = "2h"
  })
  --store and apply dhcp settings
  uci:commit("dhcp")
  end
  --test if fw rules exist
  if has_firewall then
    local fwzone = firewall:get_zone(zone_name)
    if not fwzone then
      fwzone = firewall:add_zone(zone_name) 
      fwzone:add_network(nw_name)  
      --store and apply firewall settings 
      firewall:commit("firewall")  
    end
  end
  
end
