#!/bin/sh /etc/rc.common
#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 fw867 <ffkykzs@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

START=98
STOP=15

source /koolshare/scripts/base.sh
eval `dbus export filebrowser_`

start(){
	[ "$filebrowser_enable" == "1" ] && sh /koolshare/scripts/filebrowser_config.sh start
}

stop(){
	sh /koolshare/scripts/filebrowser_config.sh stop
}
