<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>易物后台管理系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.4.1/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/taotao.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-easyui-1.4.1/plugins/jquery.validatebox.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/common.js"></script>
<style type="text/css">
	.content {
		padding: 10px 10px 10px 10px;
	}
</style>
<script type="text/javascript">
	function openChangePassword(){
		$("#changePasswordDialog").dialog({    
		    title: '修改密码',    
		    width: 600,    
		    height: 400,    
		    closed: false, 
		    minimizable:true,
			maximizable:true,
		    href:"${pageContext.request.contextPath}/admin/changePassword.jsp", 
		    modal: true   
		},'open');    

	}
	 // 刷新图片
    function changeImg() {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", changeUrl(src));
    }
    //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
    function changeUrl(url) {
        var timestamp = (new Date()).valueOf();
        var index = url.indexOf("?",url);
        if (index > 0) {
            url = url.substring(0, url.indexOf(url, "?"));
        }
        if ((url.indexOf("&") >= 0)) {
            url = url + "×tamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }

	function cancle(){
		$("#changePasswordDialog").dialog('close');
	}
</script>
</head>
<body class="easyui-layout">
	<!-- 布局 -->
	<div data-options="region:'north',title:'',split:true" style="height:100px;background-color:#2fd6dc">
	
		<div style="float:left;padding-top: 10px">
			<span style="font-family: serif;font-weight: bold;font-size: 20px">易物后台管理系统</span>
		</div>
		<div style="float:left;margin-top:5px;margin-left:900px">
			<span style="font-size: 15px">
				当前用户:${user.username }  身份:超级管理员   <a href="#" onclick="openChangePassword()">修改密码</a>
				<a href="${pageContext.request.contextPath }/admin/login.jsp">【注销退出】</a>
			</span>
		</div>
	</div>
	
	<div id="changePasswordDialog"></div>
    <div data-options="region:'west',title:'菜单',split:true" style="width:180px;">
    	<ul id="menu" class="easyui-tree" style="margin-top: 10px;margin-left: 5px;">
         	<li>
         		<span>商品管理</span>
         		<ul>
	         		<li data-options="attributes:{'url':'${pageContext.request.contextPath }/admin/item-add.jsp'}">新增商品</li>
	         		<li data-options="attributes:{'url':'${pageContext.request.contextPath }/admin/item-list.jsp'}">商品列表</li>
	         	</ul>
         	</li>
         	
         	<li>
         		<span>用户管理</span>
         		<ul>
	         		<li data-options="attributes:{'url':'${pageContext.request.contextPath }/admin/user-list.jsp'}">用户列表</li>
	         	</ul>
         	</li>
         </ul>
    </div>
    <div data-options="region:'center',title:''">
    	<div id="tabs" class="easyui-tabs">
		    <div title="首页" style="padding:20px;">
		        	
		    </div>
		</div>
    </div>

<script type="text/javascript">
//表单验证
function validateForm(){
	var password = $("input[name='password']").val();
	var newPassword = $("input[name='newPassword']").val();
	var rePassword = $("input[name='rePassword']").val();
	var validateCode = $("#validateCode").val();
	if(password == ''){
		$("#messageError p").text("请输入密码");
		$("#messageError").css("display","block");
		return false;		
		
	}else if(newPassword == ''){
		$("#messageError p").text("请输入新密码");
		$("#messageError").css("display","block");
		return false;
	}else if(newPassword != rePassword){
		$("#messageError p").text("两次密码输入不一致");
		$("#messageError").css("display","block");
		return false;
	}else if(validateCode == ''){
		$("#messageError p").text("验证码不能为空");
		$("#messageError").css("display","block");
		return false;
	}
	//action="${pageContext.request.contextPath }/admin/doLogin.do"
	$("#messageError").css("display","none");
	return true;
	
}
var base_url = "http://localhost:8080";
//提交表单
function changePassword(){
	$("#changePasswordForm").form('submit',{
		url:"${pageContext.request.contextPath}/admin/changePassword",
		onSubmit:validateForm,
		success:function(data){
			var result = $.parseJSON(data);
			if(result.status == 202){
				$("#messageError p").text("验证码不正确");
				$("#messageError").css("display","block");
			}else if(result.status == 201){
				window.location.href = base_url + "${pageContext.request.contextPath}/admin/login.jsp";
			}else{
				alert("修改成功");
				$("#changePasswordDialog").window('close');
				window.location.reload();
			}
		}
	});
}

$(function(){
	$('#menu').tree({
		onClick: function(node){
			if($('#menu').tree("isLeaf",node.target)){
				var tabs = $("#tabs");
				var tab = tabs.tabs("getTab",node.text);
				if(tab){
					tabs.tabs("select",node.text);
				}else{
					tabs.tabs('add',{
					    title:node.text,
					    href: node.attributes.url,
					    closable:true,
					    bodyCls:"content"
					});
				}
			}
		}
	});
});
</script>
</body>
</html>