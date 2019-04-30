<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.panel-body{
		padding:0px	
	}
</style>
<table class="easyui-datagrid" id="movieList" title="商品列表" 
       data-options="fitColumns:true,singleSelect:false,collapsible:true,pagination:true,url:'${pageContext.request.contextPath }/admin/items/display',method:'get',pageSize:10,toolbar:toolbar">
    <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true"></th>
        	<th data-options="field:'id',align:'center'">商品ID</th>
            <th data-options="field:'name',align:'center'">商品名称</th>
            <th data-options="field:'userName',align:'center'">发布人</th>
            <th data-options="field:'desc',align:'center'">描述</th>
            <th data-options="field:'typeName',align:'center'">类型</th>
            <th data-options="field:'publishTime',align:'center'">发布日期</th>
            <th data-options="field:'imgPath',align:'center',hidden:true">图片路径</th>
        </tr>
    </thead>
</table>
<div id="movieEditWindow" class="easyui-window" title="编辑电影" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath }/admin/item-edit.jsp'" style="width:60%;height:80%;padding:10px;">
</div>
<script>
	
    function getSelectionsIds(){
    	var itemList = $("#movieList");
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
        	$(".tree-title:contains('新增商品')").parent().click();
        }
    },{
        text:'编辑',
        iconCls:'icon-edit',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','必须选择一个才能编辑!');
        		return ;
        	}
        	if(ids.indexOf(',') > 0){
        		$.messager.alert('提示','只能选择一个!');
        		return ;
        	}
        	
        	$("#movieEditWindow").window({
        		width:1000,    
        	    height:600,
        		onLoad :function(){
        			//回显数据
        			var data = $("#movieList").datagrid("getSelections")[0];
        			$.getJSON("${pageContext.request.contextPath}/item/detail?id="+data.id, function(data){
        				console.log(data);
        				$("#movieEditForm").form("load",data);
        				var images = data.imgPath.split(";");
        				for(var i = 0;i < images.length;i++){
        					if(images[i] == ''){
        						images.pop(images[i]);
        					}
        				}
        				for(var i = 0;i < images.length;i++){
        					$("#Img"+(parseInt(i)+1)).attr('src','${pageContext.request.contextPath}/image/display?pathName='+images[i]);
        				}
        				/* if(images.length == 2){
        					$("#Img2").attr('src','${pageContext.request.contextPath}/image/display?pathName='+images[1]);		
        				}
        				
        				$("#Img3").attr('src','${pageContext.request.contextPath}/image/display?pathName='+images[2]); */
        			});
        		}
        	}).window("open");
        }
    },{
        text:'删除',
        iconCls:'icon-cancel',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中!');
        		return ;
        	}
        	$.messager.confirm('确认','确定删除ID为 '+ids+' 的商品吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("${pageContext.request.contextPath}/admin/item/delete",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','删除商品成功!',undefined,function(){
            					$("#movieList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    }];
</script>