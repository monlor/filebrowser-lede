<title>软件中心 - FileBrowser</title>
<content>
<style type="text/css">
input[disabled]:hover{
    cursor:not-allowed;
}
</style>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/tomato.js"></script>
<script type="text/javascript" src="/js/advancedtomato.js"></script>
<script type="text/javascript">
getAppData();
var Apps;
function getAppData(){
var appsInfo;
	$.ajax({
	  	type: "GET",
	 	url: "/_api/filebrowser_",
	  	dataType: "json",
	  	async:false,
	 	success: function(data){
	 	 	Apps = data.result[0];
	  	}
	});
}
if (Apps.filebrowser_webui == undefined||Apps.filebrowser_webui == null){
		Apps.filebrowser_webui = '--';
	}
//console.log('Apps',Apps);
//数据 -  绘制界面用 - 直接 声明一个 Apps 然后 post 到 sh 然后 由 sh 执行 存到 dbus
function verifyFields(focused, quiet){
	var port =E('_filebrowser_port').value ;
    if(port < 1024 || port > 65535){
        alert("端口应设置为1024-65535之间");
    }
	return 1;
}
function save(){
	Apps.filebrowser_enable = E('_filebrowser_enable').checked ? '1':'0';
	Apps.filebrowser_wan_enable = E('_filebrowser_wan_enable').checked ? '1':'0';
	Apps.filebrowser_port = E('_filebrowser_port').value;
	Apps.filebrowser_root = E('_filebrowser_root').value;
	//Apps.filebrowser_sk = E('_filebrowser_sk').value;
	//left>down>Apps.filebrowser_up = E('_filebrowser_up').value;
	//left>down>Apps.filebrowser_interval = E('_filebrowser_interval').value;
	//left>down>Apps.filebrowser_domain = E('_filebrowser_domain').value;
	//left>down>Apps.filebrowser_dns = E('_filebrowser_dns').value;
	//left>down>Apps.filebrowser_curl = E('_filebrowser_curl').value;
	//Apps.filebrowser_ttl = E('_filebrowser_ttl').value;
	//-------------- post Apps to dbus ---------------
	var id = 1 + Math.floor(Math.random() * 6);
	var postData = {"id": id, "method":'filebrowser_config.sh', "params":[], "fields": Apps};
	var success = function(data) {
		//
		$('#footer-msg').text(data.result);
		$('#footer-msg').show();
		setTimeout("window.location.reload()", 3000);
		//  do someting here.
		//
	};
	var error = function(data) {
		//
		//  do someting here.
		//
	};
	$('#footer-msg').text('保存中……');
	$('#footer-msg').show();
	$('button').addClass('disabled');
	$('button').prop('disabled', true);
	$.ajax({
	  type: "POST",
	  url: "/_api/",
	  data: JSON.stringify(postData),
	  success: success,
	  error: error,
	  dataType: "json"
	});
	
	//-------------- post Apps to dbus ---------------
}
</script>
<div class="box">
<div class="heading">FileBrowser <a href="#/soft-center.asp" class="btn" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">返回</a></div>
<br><hr>
<div class="content">
<div id="filebrowser-fields"></div>
<script type="text/javascript">
$('#filebrowser-fields').forms([
{ title: '开启filebrowser', name: 'filebrowser_enable', type: 'checkbox', value: ((Apps.filebrowser_enable == '1')? 1:0)},
{ title: '外网访问Web', name: 'filebrowser_wan_enable', type: 'checkbox', value: ((Apps.filebrowser_wan_enable == '1')? 1:0)},
//{ title: '运行状态', name: 'filebrowser_last_act', text: Apps.filebrowser_last_act ||'--' },
{ title: '默认访问目录', name: 'filebrowser_root', type: 'text', value: Apps.filebrowser_root || "/mnt/sdb1" },
{ title: 'Web访问端口', name: 'filebrowser_port', type: 'text', maxlen: 5, size: 5, value: Apps.filebrowser_port || "5288" },
{ title: 'Web控制页面', name: 'filebrowser_webui', text: '<a style="font-size: 14px;" href="'+Apps.filebrowser_webui+'" target="_blank">'+Apps.filebrowser_webui+'</a>' ||'--' },
//{ title: '启动方式', name: 'filebrowser_up', type: 'select', options:upoption_mode,value:Apps.filebrowser_up || '2'},
//{ title: '检查周期', name: 'filebrowser_interval', type: 'text', maxlen: 5, size: 5, value: Apps.filebrowser_interval || '5',suffix:'分钟(当启动方式为WAN UP时，此选项无效)'},
]);
</script>
</div>
</div>
<button type="button" value="Save" id="save-button" onclick="save()" class="btn btn-primary">保存 <i class="icon-check"></i></button>
<button type="button" value="Cancel" id="cancel-button" onclick="javascript:reloadPage();" class="btn">取消 <i class="icon-cancel"></i></button>
<span id="footer-msg" class="alert alert-warning" style="display: none;"></span>
<script type="text/javascript">verifyFields(null, 1);</script>
</content>