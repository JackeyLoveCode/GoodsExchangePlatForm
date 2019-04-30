<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>易物后台管理系统</title>
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<!-- -->
<script>var __links = document.querySelectorAll('a');function __linkClick(e) { parent.window.postMessage(this.href, '*');} ;for (var i = 0, l = __links.length; i < l; i++) {if ( __links[i].getAttribute('data-t') == '_blank' ) { __links[i].addEventListener('click', __linkClick, false);}}</script>
<script src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script>
$(document).ready(function(c) {
	$('.alert-close').on('click', function(c){
		$('.message').fadeOut('slow', function(c){
	  		$('.message').remove();
		});
	});	  
});
//表单验证
function validateForm(){
	var username = $("input[name='username']").val();
	var password = $("input[name='password']").val();
	if(username == '请输入用户名'){
		$("#messageError p").text("请输入用户名");
		$("#messageError").css("display","block");
		return false;		
		
	}else if(password == '请输入密码'){
		$("#messageError p").text("请输入密码");
		$("#messageError").css("display","block");
		return false;
	}
	//action="${pageContext.request.contextPath }/admin/doLogin.do"
	$("#messageError").css("display","none");
	return true;
	
}
function accpetMsg(){
	if(${not empty msg}){
		alert("${msg}");
	}
}
</script>
</head>
<body onload="accpetMsg()">
<!-- contact-form -->	
<div class="message warning">
<div class="inset">
	<div class="login-head">
		<h1>易物后台管理系统</h1>
		 <div class="alert-close"> </div> 			
	</div>
		<form id="loginForm" action="${pageContext.request.contextPath }/user/login" onsubmit="return validateForm()"  method="POST">
			<input name="identity" value="admin" type="hidden"/>
			<!-- 错误消息提示 -->
			<div id="messageError" style="border:1px solid #ffb4a8;display: none;height:20px">
				<p style="white-space: normal;word-wrap: break-word;"></p>
			</div>
			<li>
				<input type="text" name="username" class="text" value="请输入用户名" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '请输入用户名';}"><a href="#" class=" icon user"></a>
			</li>
				<div class="clear"> </div>
			<li>
				<input type="password" name="password" value="请输入密码" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '请输入密码';}"> <a href="#" class="icon lock"></a>
			</li>
			<div class="clear"> </div>
			<div class="submit">
				<input  type="submit" onclick="submitForm()"  value="登录"></button>
						  <div class="clear">  </div>	
			</div>
				
		</form>
		</div>					
	</div>
	</div>
	
	<div class="clear"> </div>
<!--- footer --->
<div class="footer">
	<p>Copyright &copy; 2018.</p>
</div>

</body>
</html>