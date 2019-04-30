<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
</script>
</head>
<body>
	<!-- 修改密码窗口 --> 
	<div id="changePasswordDialog" >
		<div>
			<form id="changePasswordForm" action="${pageContext.request.contextPath }/admin/changePassword" method="POST">
				<!-- 错误消息提示 -->
				<div id="messageError" style="border:1px solid #ffb4a8;display: none;height:20px">
					<p style="white-space: normal;word-wrap: break-word;font-size:15px;text-align: center"></p>
				</div>
			  <div class="form-group">
			    <label for="exampleInputEmail1">原密码:</label>
			    <input type="password" class="form-control" name="password" id="exampleInputEmail1" >
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">新密码:</label>
			    <input type="password" class="form-control" name="newPassword" id="exampleInputPassword1">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword2">确认密码:</label>
			    <input type="password" class="form-control" name="rePassword" id="rePassword">
			  </div>
			  <div class="form-group">
			  	<div>
			  		<label for="validateCode">验证码:</label>
			  	</div>
			  	<div style="float:left">
			  		<input type="text" name="code" class="form-control" id="validateCode" style="width: 100px"/>
			  	</div>
			  	<div style="float:left">
			  		<img alt="验证码" id="imgObj" src="${pageContext.request.contextPath }/admin/validateCode" onclick="changeImg()"><a href="#" onclick="changeImg()">换一张</a>
			  	</div>	
			  </div>
			  <div style="margin-top:50px;">
			  	<span>
			  		<button type="button" class="btn btn-primary" onclick="changePassword()">保存</button>
			  	</span>
			  	<span style="margin-left:10px">
			  		<button type="button" class="btn btn-info" onclick="cancle()">取消</button>
			  	</span>
			  </div>	
		</div>
	</div>    
</body>
</html>