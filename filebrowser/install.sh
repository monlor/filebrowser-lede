#!/bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

mkdir -p $KSROOT/init.d
mkdir -p /tmp/upload

cp -r /tmp/filebrowser/* $KSROOT/
chmod a+x $KSROOT/filebrowser/filebrowser
chmod a+x $KSROOT/scripts/filebrowser_*
chmod a+x $KSROOT/init.d/S97filebrowser.sh

# add icon into softerware center
dbus set softcenter_module_filebrowser_install=1
dbus set softcenter_module_filebrowser_version=0.1
dbus set softcenter_module_filebrowser_name=filebrowser
dbus set softcenter_module_filebrowser_title=FileBrowser
dbus set softcenter_module_filebrowser_description="Web文件管理工具"
rm -rf $KSROOT/install.sh

# apply aliddns
sh $KSROOT/scripts/filebrowser_config.sh start