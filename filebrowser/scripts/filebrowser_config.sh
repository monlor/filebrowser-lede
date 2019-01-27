#!/bin/sh
#2017/05/05 by kenney
#version 0.2

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export filebrowser_`
conf_Path="$KSROOT/filebrowser"
export HOME=/root

# create_conf(){
#     if [ ! -d $conf_Path ];then
#         $KSROOT/filebrowser/filebrowser -generate=$conf_Path >>/tmp/filebrowser.log
#     fi
# }
lan_ip=$(uci get network.lan.ipaddr)
weburl="http://$lan_ip:$filebrowser_port"
get_ipaddr(){
    if [ $filebrowser_wan_enable == 1 ];then
        ipaddr="0.0.0.0"
    else
        ipaddr="$lan_ip"
    fi
    # sed -i "/<gui enabled/{n;s/[0-9.]\{7,15\}:[0-9]\{2,5\}/$ipaddr/g}" $conf_Path/config.xml
}
start_filebrowser(){
    $KSROOT/filebrowser/filebrowser -a "$ipaddr" -p "$filebrowser_port" -r "$filebrowser_root" -d "$conf_Path/filebrowser.db" >>/tmp/filebrowser.log &
    sleep 2
    #cru d filebrowser
    #cru a filebrowser "*/10 * * * * sh $KSROOT/scripts/filebrowser_config.sh"
    dbus set filebrowser_webui=$weburl
    if [ -L "/etc/rc.d/S94filebrowser.sh" ];then 
        rm -rf /etc/rc.d/S97filebrowser.sh
    fi
    ln -sf $KSROOT/init.d/S97filebrowser.sh /etc/rc.d/S97filebrowser.sh
}
stop_filebrowser(){
    for i in `ps |grep filebrowser|grep -v grep|grep -v "/bin/sh"|awk -F' ' '{print $1}'`;do
        kill $i
    done
    sleep 2
    #cru d filebrowser
    if [ -L "/etc/rc.d/S94filebrowser.sh" ];then 
        rm -rf /etc/rc.d/S97filebrowser.sh
    fi
    dbus set filebrowser_webui="--"
}

case $ACTION in
start)
	if [ "$filebrowser_enable" = "1" ]; then
        # create_conf
        get_ipaddr
        start_filebrowser
	fi
	;;
stop)
	stop_filebrowser
	;;
*)
    if [ "$filebrowser_enable" = "1" ]; then
        if [ "`ps|grep filebrowser|grep -v "/bin/sh"|grep -v grep|wc -l`" != "0" ];then 
            stop_filebrowser
        fi
        # create_conf
        get_ipaddr
        start_filebrowser
	else
        stop_filebrowser
    fi
    http_response '设置已保存！切勿重复提交！页面将在3秒后刷新'
	;;
esac
