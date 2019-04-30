<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.min.css" />
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<title>登录页面</title>
<script>
			$(function(){
				var status = GetQueryString("status");
				if(status == '-1'){
					alert("用户名或密码错误");
				}
			});
			function confirm() {
				var username = $("#username").val().trim();
				var password = $("#password").val().trim();
				if(username == ""){
					alert("用户名不能为空");
					return false;
				}
				if(password == ""){
					alert("密码不能为空");
					return false;
				}
				return true;
				
			}
			function showMsg(){
				if(${not empty msg}){
					alert("${msg}");
				}
				
			}
			function GetQueryString(name) { 
				var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
				var r = window.location.search.substr(1).match(reg); //获取url中"?"符后的字符串并正则匹配
				var context = ""; 
				if (r != null) 
				context = r[2]; 
				reg = null; 
				r = null; 
				return context == null || context == "" || context == "undefined" ? "" : context; 
			}
		</script>
</head>

<body background="./img/QJ6764360791.jpg" onload="showMsg()">
	<div class="container">

		<div class="row">
			<div class="col-lg-12" style="text-align: center;">
				<h2>易物</h2>

			</div>
			<div style="padding-left: 800px;">让生活多一点点意想不到</div>
		</div>
		<div class="row">
			<div id="formDiv" style="padding-left: 400px;margin-top: 180px;">
				<form class="form-horizontal" id="loginForm" action="user/login"
					onSubmit="return confirm()">
					<input name="identity" value="user" type="hidden"/>
					<div class="form-group">
						<label for="username" class="col-lg-2 control-label">用户名:</label>
						<div class="col-lg-4">
							<input type="text" name="username" class="form-control"
								id="username">
						</div>
					</div>

					<div class="form-group">
						<label for="password" class="col-lg-2 control-label">密码:</label>
						<div class="col-lg-4">
							<input type="password" class="form-control" name="password"
								id="password">
						</div>
					</div>

					<div class="form-group">
						<div class="col-lg-12" style="padding-left: 230px;">
							<button class="btn btn-default" onclick="javascript:login()">登录</button>
						</div>
					</div>
					<div class="form-group" style="margin-top: 100px;">
							<div class="col-lg-12">
								<a class="btn btn-default" href="register.jsp" target="_self">注册</a>
							</div>
						</div>
				</form>
			</div>
		</div>
	</div>
	<div id="footerDiv" style="padding-top:50px;padding-left:600px">
			<a href="admin/login.jsp">【管理员登录】</a>
	</div>
</body>

</html>