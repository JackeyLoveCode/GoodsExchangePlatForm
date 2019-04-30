<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<link rel="stylesheet" href="css/bootstrap.min.css" />
		<meta charset="utf-8" />
		<title>注册页面</title>
		<script>
			function confirm() {
				var username = $("#username").val();
				var password = $("#password").val();
				var email = $("#email").val();
				if(username == ""){
					alert("用户名不能为空");
					return false;
				}
				if(password == ""){
					alert("密码不能为空");
					return false;
				}
				if(rePassword == ""){
					alert("确认密码不能为空");
					return false;
				}
				if(ppassword != rePassword){
					alert("密码和确认密码不一致");
					return false;
				}
				if(email == ""){
					alert("邮箱不能为空");
					return false;
				}
				return true;
			}
		</script>
	</head>

	<body background="./img/QJ6112893097.jpg" style="background-position:center; background-repeat:no-repeat;" >
		<div class="container" >
		
			<div class="row">
				<div class="col-lg-12" style="text-align: center;">
					<h2>
					易物
				</h2>

				</div>
				<div style="padding-left: 800px;">
					让生活多一点点意想不到
				</div>
			</div>
			<div class="row">
				<div id="formDiv" style="padding-left: 350px;margin-top: 180px;">
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
							<label for="password" class="col-lg-2 control-label">密码:</label>
							<div class="col-lg-4">
								<input type="password" name="password" class="form-control" id="password">
							</div>
						</div>
						<div class="form-group">
							<label for="confirmPwd" class="col-lg-2 control-label">确认密码:</label>
							<div class="col-lg-4">
								<input type="password" class="form-control" id="confirmPwd">
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-12" style="padding-left: 230px;">
								<button  class="btn btn-default" onclick="register()">注册</button>
							</div>
						</div>
						<div class="form-group" style="margin-top: 100px;">
							<div class="col-lg-12">
								<a  class="btn btn-default" href="login.jsp" target="_self">登录<a> 
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div id="footerDiv" style="padding-top:20px;padding-left:600px">
			<a href="admin/login.jsp">【管理员登录】</a>
		</div>
	</body>

</html>