<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.content {
    	padding: inherit;
	}
	.panel-body {
		padding: inherit;
	}
</style>
<table class="easyui-datagrid" id="userList" title="用户列表" 
       data-options="singleSelect:false,collapsible:true,pagination:true,url:'${pageContext.request.contextPath }/admin/user/display',method:'get',pageSize:10,toolbar:toolbar">
    <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true"></th>
        	<th data-options="field:'id',width:60">用户ID</th>
            <th data-options="field:'username',width:60">昵称</th>
            <th data-options="field:'password',width:100">密码</th>
            <th data-options="field:'email',width:100">邮箱</th>
            <th data-options="field:'weixin',width:100">微信</th>
            <th data-options="field:'identity',width:100,formatter:
            function(value,row,index){
            if(value == 'user'){
				value = '普通用户';
			}else{
				value = '管理员';
			} 
				return value;
			}">角色</th>
            <th data-options="field:'simpleDesc',width:200">简述</th>
          
            
        </tr>
    </thead>
</table>
<div id="userAddWindow" class="easyui-window" title="添加用户" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath }/admin/user-add.jsp'" style="width:80%;height:80%;padding:10px;">
<div id="userEditWindow" class="easyui-window" title="编辑用户" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath }/admin/user-edit.jsp'" style="width:80%;height:80%;padding:10px;">
</div>
<script>
	function formatIdentity(value,row,index){
		
	}
	function timestampToTime(value,row,index){
		var date = new Date(value);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = date.getDate() + ' ';
        var h = date.getHours() + ':';
        var m = date.getMinutes() + ':';
        var s = date.getSeconds();
        return Y+M+D+h+m+s;
	}
    function getSelectionsIds(){
    	var itemList = $("#userList");
    	var sels = itemList.datagrid("getSelections");
    	var ids = [];
    	for(var i in sels){
    		ids.push(sels[i].id);
    	}
    	ids = ids.join(",");
    	return ids;
    }
    
    var toolbar = [{
        text:'新增',
        iconCls:'icon-add',
        handler:function(){
        	$("#userAddWindow").window({
        		width:600,
        		height:500
        	}).window('open').window('center');
        }
    },{
        text:'编辑',
        iconCls:'icon-edit',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','必须选择一个用户才能编辑!');
        		return ;
        	}
        	if(ids.indexOf(',') > 0){
        		$.messager.alert('提示','只能选择一个用户!');
        		return ;
        	}
        	
        	$("#userEditWindow").window({
        		width:500,
        		height:300,
        		onLoad :function(){
        			//回显数据
        			var data = $("#userList").datagrid("getSelections")[0];
        			$("#userEditForm").form("load",data);
        		}
        	}).window("open").window('center');
        }
    },{
        text:'删除',
        iconCls:'icon-cancel',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中用户!');
        		return ;
        	}
        	$.messager.confirm('确认','确定删除ID为 '+ids+' 的用户吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("${pageContext.request.contextPath}/admin/user/delete",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','删除用户成功!',undefined,function(){
            					$("#userList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    
    }];
</script>