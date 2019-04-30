<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath }/js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<div style="padding:10px 10px 10px 10px">
	<form id="userEditForm" class="itemForm" method="post">
	    <table cellpadding="5">
	        <tr style="margin-top:10px">
	        	<input type="hidden" name="id"/>
	            <td>用户名:</td>
	            <td>
	            	<input type="text" name="username" class="easyui-textbox" id="username">
	            </td>
	        </tr>
	        <tr style="margin-top:10px">
	            <td>邮箱:</td>
	            <td><input class="easyui-textbox" type="text" name="email"  style="width: 280px;"/></td>
	        </tr>
	        <tr style="margin-top:10px">
	            <td>微信:</td>
	            <td><input type="text" class="easyui-textbox" name="weixin"  id="weixin"/></td>
	        </tr>
	       <tr style="margin-top:10px">
	            <td>密码:</td>
	            <td><input type="text" class="easyui-textbox" name="password" id="password"/></td>
	        </tr>
	        <tr style="margin-top:10px">
	            <td>简介:</td>
	            <td><input type="text" class="easyui-textbox" name="simpleDesc" id="simpleDesc" style="height:100px"/></td>
	        </tr>
	    </table>
	   
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
</div>
<script type="text/javascript">
	
	$(function(){
		
	});
	//提交表单
	function submitForm(){
		//有效性验证
		if(!$('#userEditForm').form('validate')){
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}
		
		
		$.post("${pageContext.request.contextPath}/admin/user/update",$("#userEditForm").serialize(), function(data){
			if(data.status == 200){
				$.messager.alert('提示','修改用户成功!');
				$("#userEditWindow").window('close');
				$("#userList").datagrid('reload');
			}
		});
	}
	
	function clearForm(){
		$('#userEditForm').form('reset');
		
	}
</script>
