#! /bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export filebrowser_`

# stop first
sh $KSROOT/scripts/filebrowser_config.sh stop

# remove dbus data in softcenter
confs=`dbus list filebrowser_|cut -d "=" -f1`
for conf in $confs
do
	dbus remove $conf
done

# remove files
rm -rf $KSROOT/filebrowser
rm -rf $KSROOT/scripts/filebrowser*
rm -rf $KSROOT/init.d/S97filebrowser.sh
rm -rf /etc/rc.d/S97filebrowser.sh >/dev/null 2>&1
rm -rf $KSROOT/webs/Module_filebrowser.asp
rm -rf $KSROOT/webs/res/icon-filebrowser.png
rm -rf $KSROOT/webs/res/icon-filebrowser-bg.png

# remove dbus data in filebrowser
dbus remove softcenter_module_filebrowser_home_url
dbus remove softcenter_module_filebrowser_install
dbus remove softcenter_module_filebrowser_md5
dbus remove softcenter_module_filebrowser_version
dbus remove softcenter_module_filebrowser_name
dbus remove softcenter_module_filebrowser_title
dbus remove softcenter_module_filebrowser_description
