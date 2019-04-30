<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath }/js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<div style="padding:10px 10px 10px 10px">
	<div id="formDiv" >
					<form class="form-horizontal" id="registerForm" action="user/register" onSubmit="confirm()">
						<div class="form-group">
							<label for="username" class="col-lg-2 control-label">用户名:</label>
							<div class="col-lg-4">
								<input type="text" name="username" class="form-control" id="username">
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-lg-2 control-label">邮箱:</label>
							<div class="col-lg-4">
								<input type="email" name="email" class="form-control" id="email">
							</div>
						</div>
						<div class="form-group">
							<label for="weixin" class="col-lg-2 control-label">微信:</label>
							<div class="col-lg-4">
								<input type="text" name="weixin" class="form-control" id="weixin">
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-lg-2 control-label">密码:</label>
							<div class="col-lg-4">
								<input type="text" name="password" class="form-control" id="password">
							</div>
						</div>
						<div class="form-group">
							<label for="simpleDesc" class="col-lg-2 control-label">简介:</label>
							<div class="col-lg-4">
								<input type="text" name="simpleDesc" style="height: 100px" class="form-control" id="simpleDesc">
							</div>
						</div>
					</form>
				</div>
				<div style="padding:50px">
				    <a href="javascript:submitForm()" class="btn btn-success" >提交</a>
				    <a href="javascript:clearForm()" class="btn btn-danger">重置</a>
				</div>
</div>
<script type="text/javascript">
	
	$(function(){
		
	});
	//提交表单
	function submitForm(){
		//有效性验证
		if(!$('#registerForm').form('validate')){
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}
		
		
		$.post("${pageContext.request.contextPath}/admin/user/add",$("#registerForm").serialize(), function(data){
			if(data.status == 200){
				$.messager.alert('提示','新增用户成功!');
				$("#userAddWindow").window('close');
				$("#userList").datagrid('reload');
			}
		});
	}
	
	function clearForm(){
		$('#userAddForm').form('reset');
		itemAddEditor.html('');
	}
</script>
