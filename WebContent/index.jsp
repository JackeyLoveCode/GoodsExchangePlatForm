<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="css/bootstrap.min.css" />
		<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
		<style type="text/css">
	        *{margin:0;padding:0;}
	        ul,ol{list-style:none;}
	        #box{width:420px;height:320px;margin:10px auto;position:relative;overflow:hidden;}
	        #box li{height:630px;width:420px;}
	        #box ol{position:absolute;z-index:99;right:10px;bottom:10px;}
	        #box ol li{width:20px;height:20px;border-radius:20px;background:#ccc;float:right;margin-left:15px;float:left;}
	        #box ol li.current{background:#ff0;}
	        /*搜索框1*/
	        .bar1 input {
	            border: 2px solid #7BA7AB;
	            border-radius: 5px;
	            background: #F9F0DA;
	            color: #9E9C9C;
                height: 38px;
   				width: 380px;
	        }
	
	        .bar1 .button {
	            top: 0;
	            right: 0;
	            background: #7BA7AB;
	            border-radius: 0 5px 5px 0;
	            text-decoration: none;
	            font: 25px Arial;
	            padding-top: 0px;
	        }
	
	        .bar1 .button:before {
	
	            font-family: FontAwesome;
	            font-size: 16px;
	            color: #F9F0DA;
	        }
	
	        .conditionDiv {
	            width: 1140px;
	            background-color: #fff;
	            margin-left: 97px;
	            border: 1px solid #ddd;
	        }
    	</style>
		<script>
			$(function(){
				findAllByCon();
				$("#submitBtn").click(function(){
					$("#publishForm").submit();
				});
				$("#swapFormButton").click(function(){
					$("#swapForm").submit();	
				});
				showMsg();
			});
			/* function showMyInfoDiv() {
				$("#itemListDiv").css("display", "none");
				$("#itemDetailDiv").css("display", "none");
				$("#myPublishDiv").css("display", "none");
				$("#myMessageDiv").css("display", "none");
				$("#updateUserInfoDiv").css("display", "none");
				$("#changePasswordDiv").css("display", "none");
			} */

			function showItemList() {
				$("#itemListDiv").css("display", "block");
				$("#itemDetailDiv").css("display", "none");
				$("#myPublishDiv").css("display", "none");
				$("#myMessageDiv").css("display", "none");
				$("#updateUserInfoDiv").css("display", "none");
				$("#changePasswordDiv").css("display", "none");
			}

			function showItemDetailDiv() {
				$("#itemDetailDiv").css("display", "block");
				$("#itemListDiv").css("display", "none");
				$("#myPublishDiv").css("display", "none");
				$("#myMessageDiv").css("display", "none");
				$("#updateUserInfoDiv").css("display", "none");
				$("#changePasswordDiv").css("display", "none");
			}
			function showChangePasswordDiv(){
				$("#changePasswordDiv").css("display", "block");
				$("#itemDetailDiv").css("display", "none");
				$("#itemListDiv").css("display", "none");
				$("#myPublishDiv").css("display", "none");
				$("#myMessageDiv").css("display", "none");
				$("#updateUserInfoDiv").css("display", "none");
				
			}
			function showUserInfo(){
				var userId = ${user.id};
				$("#updateUserInfoDiv").css("display", "block");
				$("#myPublishDiv").css("display", "none");
				$("#itemDetailDiv").css("display", "none");
				$("#itemListDiv").css("display", "none");
				$("#myMessageDiv").css("display", "none");
				$("#changePasswordDiv").css("display", "none");
				$.ajax({
					type:"GET",
					url:"user/findById",
					async:true,
					data:"id="+userId,
					success:function(data){
						var user = data;
						$("input[name='id']").val(user.id);
						$("input[name='username']").val(user.username);
						$("input[name='email']").val(user.email);
						$("input[name='weixin']").val(user.weixin);
						$("input[name='simpleDesc']").val(user.simpleDesc);
					}
				});
			}
			function updateInfoValidate(){
				var username = $("input[name='username']").val();
				if(username == ''){
					alert("用户名不能为空");
					return false;
				}
				return true;
			}
			function showMyPublishDiv() {
				$("#myPublishDiv").css("display", "block");
				$("#itemDetailDiv").css("display", "none");
				$("#itemListDiv").css("display", "none");
				$("#myMessageDiv").css("display", "none");
				$("#updateUserInfoDiv").css("display", "none");
				$("#changePasswordDiv").css("display", "none");
				$.ajax({
					type:"GET",
					url:"items/display",
					async:true,
					data:"isByUser=yes",
					success:function(data){
						var items = data;
						console.log(items);
						var html = "";
						for (var i = 0; i < items.length; i++) {
						
							html += "<div style=\"display: block;overflow: hidden;float: left;border: 1px solid #ddd;margin-left: 48px;margin-top:20px\">\n" +
							"\t\t\t\t<div id=\"leftDiv\" style=\"float: left;\">\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<img src=\""+"image/display?pathName="+items[i].imgPath.split(";")[0]+"\" width=\"210px\" />\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t</div>\n" +
							"\t\t\t\t<div id=\"rightDiv\" style=\"float: left;margin-left: 20px;\">\n" +
							"\t\t\t\t\t<div style=\"margin-top: 20px ;\">\n" +
							"\t\t\t\t\t\t<span>名称："+items[i].name+"</span>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<span>发布人："+items[i].userName+"</span>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<span>发布时间："+items[i].publishTime+"</span>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<span>所属类型："+items[i].typeName+"</span>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<span>描述："+items[i].desc+"</span>\n" +
							"\t\t\t\t\t</div>\n" +
							"\n" +
							"\t\t\t\t</div>\n" +
							"\t\t\t</div>";
							
						
						}
						
						$("#myPublishDiv").empty();
						$("#myPublishDiv").append(html);
					}
				});
			
			}

			function showMyMessage() {
				var currentUserId = ${user.id};
				$("#myMessageDiv").css("display", "block");
				$("#myPublishDiv").css("display", "none");
				$("#itemDetailDiv").css("display", "none");
				$("#itemListDiv").css("display", "none");
				$("#updateUserInfoDiv").css("display", "none");
				$("#changePasswordDiv").css("display", "none");
				$.ajax({
					type:"get",
					url:"message/display",
					async:true,
					success:function(data){
						var messagesAndItems = data;
						var html = "";
						for (var i = 0; i < messagesAndItems.length; i++) {
							var sendItemImg = messagesAndItems[i].sendItem.imgPath;
							console.log(sendItemImg);
							var receiveItemImg = messagesAndItems[i].receiveItem.imgPath;
							html += "<div style=\"overflow: hidden;border: 1px solid #ddd;width: 1288px;\">\n" +
						"\t\t\t\t<div style=\"display: block;overflow: hidden;float: left;border: 1px solid #ddd;margin-left: 20px;margin-top: 10px;\">\n" +
						"\t\t\t\t\t<div id=\"sendItemDetailInfoDiv\" style=\"float: left;width: 300px;\">\n" +
						"\t\t\t\t\t\t<div id=\"leftDiv\" style=\"float: left;\">\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<img src=\""+"image/display?pathName="+sendItemImg.split(";")[0]+"\" width=\"210px\" />\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t<div id=\"rightDiv\" style=\"float: left;margin-left: 20px;\">\n" +
						"\t\t\t\t\t\t\t<div style=\"margin-top: 20px ;\">\n" +
						"\t\t\t\t\t\t\t\t<span>名称："+messagesAndItems[i].sendItem.name+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>发布人："+messagesAndItems[i].sendItem.userName+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>发布时间："+messagesAndItems[i].sendItem.publishTime+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>所属类型："+messagesAndItems[i].sendItem.typeName+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>描述："+messagesAndItems[i].sendItem.desc+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t<div id=\"arrowDiv\" style=\"float: left;margin-top: 70px;width: 100px;\">\n" +
						"\t\t\t\t\t\t<span style=\"font-size: larger;font-weight: bold;\">------></span>\n" +
						"\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t<div id=\"receiveItemDetailInfoDiv\" style=\"float: left;width: 300px;\">\n" +
						"\t\t\t\t\t\t<div id=\"leftDiv\" style=\"float: left;\">\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<img src=\""+"image/display?pathName="+receiveItemImg.split(";")[0]+"\" width=\"210px\" />\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t<div id=\"rightDiv\" style=\"float: left;margin-left: 20px;\">\n" +
						"\t\t\t\t\t\t\t<div style=\"margin-top: 20px ;\">\n" +
						"\t\t\t\t\t\t\t\t<span>名称："+messagesAndItems[i].receiveItem.name+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>发布人："+messagesAndItems[i].receiveItem.userName+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>发布时间："+messagesAndItems[i].receiveItem.publishTime+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>所属类型："+messagesAndItems[i].receiveItem.typeName+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t\t<div>\n" +
						"\t\t\t\t\t\t\t\t<span>描述："+messagesAndItems[i].receiveItem.desc+"</span>\n" +
						"\t\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t\t</div>\n" +
						"\t\t\t\t\t</div>\n" ;
						if(messagesAndItems[i].message.state == 0){
							if(messagesAndItems[i].message.sendUserId == currentUserId){
								html += "<div id=\"btnDiv\" style=\"margin-top: 50px;float: right;margin-right: 100px;\">\n" +
								"\t\t\t\t\t\t\n" +
								"\t\t\t\t\t\t<span style=\"font-size: 20px;font-weight: bold;\">对方未处理</span>\n" +
								"\t\t\t\t\t</div>";
							}else{
								html += "\t\t\t\t\t<div id=\"btnDiv\" style=\"margin-top: 50px;float: right;margin-right: 100px;\">\n" +
								"\t\t\t\t\t\t<div>\n" +
								"\t\t\t\t\t\t\t<button class=\"btn btn-success active\" id=\"acceptBtn\" onclick=\"accept("+messagesAndItems[i].message.id+")\">欣然同意</button>\n" +
								"\n" +
								"\t\t\t\t\t\t\t<button class=\"btn btn-danger active\" id=\"refuseBtn\" onclick=\"refuse("+messagesAndItems[i].message.id+")\">残忍拒绝</button>\n" +
								"\t\t\t\t\t\t</div>\n" +
								"\n" +
								"\t\t\t\t\t</div>\n" +
								"\t\t\t\t</div>\n" +
								"\t\t\t</div>";
							}
									
						}else{
							if(messagesAndItems[i].message.state == 1){
								html += "<div id=\"btnDiv\" style=\"margin-top: 50px;float: right;width:400px\">\n" +
								"\t\t\t\t\t\t\n" +
								"\t\t\t\t\t\t<p style=\"font-size: 20px;font-weight: bold;\">小伙伴已同意你的交换请求，请联系对方进行交换哦，对方email:"+messagesAndItems[i].message.receiveUserEmail+"</p>\n" +
								"\t\t\t\t\t</div>";
							}else if(messagesAndItems[i].message.state == 2){
								html += "<div id=\"btnDiv\" style=\"margin-top: 50px;float: right;width:400px\">\n" +
								"\t\t\t\t\t\t\n" +
								"\t\t\t\t\t\t<span style=\"font-size: 20px;font-weight: bold;\">小伙伴暂时不想交换，试试其他宝贝吧</span>\n" +
								"\t\t\t\t\t</div>";
							}
							
						}
						}
						console.log(html);
						$("#myMessageDiv").empty();
						$("#myMessageDiv").append(html);					
					}
				});
			}
			//同意交换
			function accept(id){
				var flag = confirm("您确定要同意此次交换吗？");
				if(flag){
					$.ajax({
						type:"get",
						url:"message/resolve",
						data:"id="+id+"&isAccept=true",
						async:false,
						success:function(data){
							console.log(data);
							$("#btnDiv").empty();
							var html = "<span style=\"font-size: 20px;font-weight: bold;font-color:green\">已同意</span>";
							$("#btnDiv").append(html);
						}
					});
				}
				
			}
			
			//拒绝交换
			function refuse(id){
				var flag = confirm("您确定要拒绝此次交换吗？");
				if(flag){
					$.ajax({
						type:"get",
						url:"message/resolve",
						data:"id="+id+"&isAccept=false",
						async:false,
						success:function(data){
							$("#btnDiv").empty();
							var html = "<span style=\"font-size: 20px;font-weight: bold;font-color:green\">已拒绝</span>";
							$("#btnDiv").append(html);
						}
					});
				}
				
			}
			function confirmForm(){
				var name = $("input[name='name']").val();
				var desc = $("textarea[name='desc']").val();
				var img = $("#uploadImg").val();
				if(name == ''){
					alert("请填写名称");
					return false;
				}
				if(desc == ''){
					alert("请填写描述");
					return false;
				}
				if(img == ''){
					alert("请选择图片上传");
					return false;
				}
				return true;
			}
			function showCarousel(){
				var index =0;
	            var timer = setInterval(function(){
	                index = (index == 2) ? 0 : index + 1;          
	                $("#box ul li").hide().eq(index).show();
	                $('#box ol li').eq(index).addClass('current').siblings().removeClass('current');
	            }, 3000);
	            $("#box ol li").hover(function(){
	                var index = $(this).index();
	                $("#box ul li").eq(index).show().siblings().hide();
	                $(this).addClass('current').siblings().removeClass('current');
	            });
			}
			function showItemDetail(id){
				var itemId = id;
				$.ajax({
					type:"GET",
					url:"item/detail",
					data:"id="+itemId,
					async:false,
					success:function(data){
						var html = "";
						var item = data;
						var imgPaths = data.imgPath.split(";");
						for(var i = 0;i < imgPaths.length;i++){
							if(imgPaths[i] == ''){
								imgPaths.pop(imgPaths[i]);
							}
						}
						if(imgPaths.length > 1){
							showCarousel();
						}
						html += "<div id=\"leftDiv\" style=\"float: left;\">\n" +
						"\t\t\t\t<div style=\"border:1px solid #ddd\">\n" +
						"\t\t\t\t\t<input name=\"id\" id=\"receiver_id\" type=\"hidden\" value=\""+item.id+"\"/>"+
						"<div id=\"box\">\n" +
						"        <ul>\n" +
						"            <li>\n" +
						"                <img src=\"image/display?pathName="+item.imgPath.split(";")[0]+"\" alt=\"\"  width=\"420\"/>\n" +
						"                \n" +
						"            </li>\n" +
						"            <li>\n" +
						"                <img src=\"image/display?pathName="+item.imgPath.split(";")[1]+"\" alt=\"\"  width=\"420\"/>\n" +
						"                      \n" +
						"            </li>\n" +
						"            <li>\n" +
						"                <img src=\"image/display?pathName="+item.imgPath.split(";")[2]+"\" alt=\"\"  width=\"420\"/>    \n" +
						"                             \n" +
						"            </li>\n" +
						"        </ul>\n" +
						"        <ol>\n" +
						"            <li class=\"current\"></li>\n" +
						"            <li></li>\n" +
						"            <li></li>\n" +
						"        </ol>\n" +
						"    </div>" +
						"\t\t\t\t</div>\n" +
						"\t\t\t</div>\n" +
						"\t\t\t<div id=\"rightDiv\" style=\"float: left;margin-left: 20px;\">\n" +
						"\t\t\t\t<div style=\"margin-top: 20px ;\">\n" +
						"\t\t\t\t\t<span>名称："+item.name+"</span>\n" +
						"\t\t\t\t</div>\n" +
						"\t\t\t\t<div style=\"margin-top:20px\">\n" +
						"\t\t\t\t\t<span>发布人："+item.userName+"</span>\n" +
						"\t\t\t\t</div>\n" +
						"\t\t\t\t<div style=\"margin-top:20px\">\n" +
						"\t\t\t\t\t<span>发布时间："+item.publishTime+"</span>\n" +
						"\t\t\t\t</div>\n" +
						"\t\t\t\t<div style=\"margin-top:20px\">\n" +
						"\t\t\t\t\t<span>所属类型："+item.typeName+"</span>\n" +
						"\t\t\t\t</div>\n" +
						"\t\t\t\t<div style=\"margin-top:20px\">\n" +
						"\t\t\t\t\t<span>描述："+item.desc+"</span>\n" +
						"\t\t\t\t</div>\n" +
						"\t\t\t\t<div style=\"margin-top:20px\">\n" +
						"\t\t\t\t\t<a class=\"btn btn-success\"  onclick=\"showSwapModal()\" ><span>交换</span></a>\n" +
						"\t\t\t\t</div>\n" +
						"\t\t\t</div>";
						$("#itemDetailDiv").empty();
						showItemDetailDiv();
						$("#itemDetailDiv").append(html);
					}
					
				});
			}
			function showSwapModal(){			
				var receiver_item_id = $("#receiver_id").val();
				var isOpenSwapModal = true;
				$.ajax({
					type:"get",
					url:"items/display",
					data:"isByUser=yes",
					async:false,
					success:function(data){
						var myPublishItems = data;
						for(var i = 0;i < myPublishItems.length;i++){
							if(receiver_item_id == myPublishItems[i].id){
								alert("您是该物品的发布者，请选择其他物品进行交换");
								isOpenSwapModal = false;
							}
						}
					}
				});
				if(isOpenSwapModal){
					$('#swapModal').modal('show');
					$("#receiver_item_id").val(receiver_item_id);
					$('#swapModal').on('shown.bs.modal', function () {
						$.ajax({
							type:"get",
							url:"items/display",
							data:"isByUser=yes",
							async:false,
							success:function(data){
								var items = data;
								var html = "<option value='-1'>"+"-请选择-"+"</option>";
								for (var i = 0; i < items.length; i++) {
									html += "<option value='"+items[i].id+"'>"+items[i].name+"</option>";
								}
								$("select[name='itemName']").empty();
								$("select[name='itemName']").append(html);
							}
						});
					});
				}
				
			}
			function findAllByCon(typeName){
				if(typeName == null || typeName == ''){
					typeName = "图书";
				};
				$.ajax({
					type:"GET",
					url:"items/display",
					async:true,
					data:"typeName="+typeName+"&isByUser=no",
					success:function(data){
						var items = data;
						console.log(items);
						var items_length = items.length;
						var rows_length = Math.ceil(items_length / 4);
						var html = "";
						for (var i = 0; i < items_length; i++) {
							if(i % 4 == 0){
								html += "<div>";
							}	
							html += "<div style=\"float: left;width: 210px;border: 1px solid #ddd;margin-right: 50px;margin-top:20px\">\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<a href=\"javascript:showItemDetail("+items[i].id+")\"><img src=\""+"image/display?pathName="+items[i].imgPath.split(";")[0]+"\" width=\"210px\" /></a>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<a href=\"javascript:showItemDetail("+items[i].id+")\"><span>"+items[i].name+"</span></a>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<span>"+items[i].desc+"</span>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t</div>";
							if((i + 1) % 4 == 0){
								html += "</div>"; 
							}
						}
						html += "</div>";
						$("#itemListDiv").empty();
						showItemList();
						$("#itemListDiv").append(html);
					}
				});
			}
			function search(){
				var itemName = $("#searchText").val();
				$.ajax({
					type:"GET",
					url:"item/displayByName",
					async:true,
					data:"itemName="+itemName,
					success:function(data){
						var items = data;
						console.log(items);
						var items_length = items.length;
						var rows_length = Math.ceil(items_length / 4);
						var html = "";
						for (var i = 0; i < items_length; i++) {
							if(i % 4 == 0){
								html += "<div>";
							}	
							html += "<div style=\"float: left;width: 210px;border: 1px solid #ddd;margin-right: 50px;margin-top:20px\">\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<a href=\"javascript:showItemDetail("+items[i].id+")\"><img src=\""+"image/display?pathName="+items[i].imgPath.split(";")[0]+"\" width=\"210px\" /></a>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<a href=\"javascript:showItemDetail("+items[i].id+")\"><span>"+items[i].name+"</span></a>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t\t<div>\n" +
							"\t\t\t\t\t\t<span>"+items[i].desc+"</span>\n" +
							"\t\t\t\t\t</div>\n" +
							"\t\t\t\t</div>";
							if((i + 1) % 4 == 0){
								html += "</div>"; 
							}
						}
						html += "</div>";
						$("#itemListDiv").empty();
						showItemList();
						$("#itemListDiv").append(html);
					}
				});
			}
			function validateSwapForm(){
				var name = $("#s_name").val();
				var s_typeName = $("#s_typeName").val();
				var s_desc = $("#s_desc").val();
				var s_uploadImg = $("#s_uploadImg").val();
				var availableItems = $("#availableItems").val();
				if(name != ""){
					
					if(s_desc == ""){
						alert("请填写描述");
						return false;
					}
					if(s_uploadImg ==""){
						alert("请选择图片上传");
						return false;
					}
				}
				if(name != "" && availableItems != "-1"){
					alert("仅能选择两种方式中的一个");
					return false;
				}
				if(name == "" && availableItems == "-1"){
					alert("请选择两种方式中的一个");
					return false;
				}
				return true;
			
			}
			function getQueryString(name) {
			    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
			    var r = window.location.search.substr(1).match(reg);
			    if (r != null) {
			        return unescape(r[2]);
			    }
			    return null;
			}
			function showMsg(){
				var msg = getQueryString("status");
				if(msg == "200"){
					alert("修改成功");
				}
			}
			function changePwdValidate(){
				var oldPassword = $("#oldPassword").val();
				var newPassword = $("#newPassword").val();
				var confirmPwd = $("#confirmPwd").val();
				if(oldPassword == ''){
					alert("原密码不能为空");
					return false;
				}
				if(newPassword == ''){
					alert("新密码不能为空");
					return false;
				}
				if(confirmPwd == ''){
					alert("确认密码不能为空");
					return false;
				}
				if(newPassword != confirmPwd){
					alert("两次输入密码不一致");
					return false;
				}
				return true;
			}
		</script>
	</head>

	<body background="img/QJ9122744327.jpg" style="background-position:center; background-repeat:no-repeat;" >
		<!--myPublishDiv-->
		<!--itemDetailDiv-->
		<!--itemListDiv-->
		<!-- swapModal -->
		<!-- updateUserInfoDiv -->
		<!-- changePasswordDiv -->
		<div style="padding-left: 50px;border: 1px solid #ddd;">
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        				<span class="sr-only">Toggle navigation</span>
        				<span class="icon-bar"></span>
        				<span class="icon-bar"></span>
        				<span class="icon-bar"></span>
      				</button>
						<a class="navbar-brand" href="#"><span>易物</span></a>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li class="active" style="margin-left: 50px;">
								<a href="javascript:findAllByCon('图书')">图书 <span class="sr-only">(current)</span></a>
							</li>
							<li style="margin-left: 100px;">
								<a href="javascript:findAllByCon('游戏')">游戏</a>
							</li>
							<li style="margin-left: 100px;">
								<a href="javascript:findAllByCon('数码')">数码</a>
							</li>
							<li style="margin-left: 100px;">
								<a href="javascript:findAllByCon('家居')">家居</a>
							</li>
							<li style="margin-left: 100px;">
								<a href="javascript:findAllByCon('其他')">其他</a>
							</li>
							<li role="presentation" class="dropdown" style="margin-left: 100px;">
							    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
							               我的 <span class="caret"></span>
							    </a>
							    <ul class="dropdown-menu">
							    	<li><a id="pubBtn" style="text-align: center;cursor: pointer;" data-toggle="modal" data-target="#publishModal">我要发布</a></li>
						            <li><a id="pubHisBtn"  style="text-align: center;cursor: pointer;" onclick="showMyPublishDiv()">我的发布</a></li>
						            <li><a id="msgBtn"  style="text-align: center;cursor: pointer;" onclick="showMyMessage()">我的消息</a></li>
						            <li><a href="javascript:showUserInfo()" style="text-align: center;cursor: pointer;">完善个人信息</a></li>
						            <li><a href="javascript:showChangePasswordDiv()" style="text-align: center;cursor: pointer;">修改密码</a></li>
							    </ul>
							</li>
							<!-- <li style="margin-left: 100px;">
								<a href="javascript:showMyInfoDiv()">我的</a>
							</li> -->
							<li style="margin-left: 100px;">
								<span>|</span>
								您好，${user.username }
								<span>|</span>
								<a href="user/logout" target="_self">安全退出</a>
							</li>
						</ul>

					</div>
					<!-- /.navbar-collapse -->
				</div>
				<!-- /.container-fluid -->
			</nav>
		</div>
		<!--搜索-->
		<div class="search bar1" style="padding-left: 500px;">
		
		    <form id="searchForm">
		
		        <input type="text" id="searchText" placeholder="请输入商品名称">
		        <a class="button" href="javascript:search()">搜索</a>
		        <!-- <button class="button" onclick="javascript:search()">搜索</button> -->
		    </form>
		</div>
		<div id="itemListDiv" style="margin-left:50px;border: 1px solid #ddd;overflow: hidden;">
			
		</div>
		<div id="itemDetailDiv" style="display: none;overflow: hidden;padding-left: 200px;margin-top: 0px;">
			<!-- <div id="leftDiv" style="float: left;">
				<div>
					<img src="img/Penguins.jpg" width="210px" />
				</div>
			</div>
			<div id="rightDiv" style="float: left;margin-left: 20px;">
				<div style="margin-top: 20px ;">
					<span>名称：茶杯</span>
				</div>
				<div>
					<span>发布人：张三</span>
				</div>
				<div>
					<span>发布时间：2019-3-26</span>
				</div>
				<div>
					<span>所属类型：家居</span>
				</div>
				<div>
					<span>描述：实用价值高</span>
				</div>
				<div>
					<a class="btn btn-success" data-toggle="modal" data-target="#swapModal"><span>交换</span></a>
				</div>
			</div> -->
		</div>
		
		<!-- 发布模态框（Modal） -->
		<div class="modal fade" id="publishModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">发布</h4>
					</div>
					<div class="modal-body">
						<div id="formDiv">
							<form class="form-horizontal" id="publishForm" onsubmit="return confirmForm()" action="item/publish" method="POST" enctype="multipart/form-data">
								<div class="form-group">
									<label for="name" class="col-lg-2 control-label">物品名称:</label>
									<div class="col-lg-4">
										<input type="text" name="name" class="form-control" id="name">
									</div>
								</div>
								<div class="form-group">
									<label for="typeName" class="col-lg-2 control-label">类别:</label>
									<div class="col-lg-4">
										<select class="form-control" name="typeName">
											<option value="图书">图书</option>
											<option value="游戏">游戏</option>
											<option value="数码">数码</option>
											<option value="家居">家居</option>
											<option value="其他">其他</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="desc" class="col-lg-2 control-label">描述:</label>
									<div class="col-lg-4">
										<textarea  class="form-control" name="desc" id="desc" rows="3"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="confirmPwd" class="col-lg-2 control-label">图片1：</label>
									<div class="col-lg-4">
										<input type="file" class="form-control" id="uploadImg01" name="uploadImg01">
									</div>
								</div>
								<div class="form-group">
									<label for="confirmPwd" class="col-lg-2 control-label">图片2：</label>
									<div class="col-lg-4">
										<input type="file" class="form-control" id="uploadImg02" name="uploadImg02">
									</div>
								</div>
								<div class="form-group">
									<label for="confirmPwd" class="col-lg-2 control-label">图片3：</label>
									<div class="col-lg-4">
										<input type="file" class="form-control" id="uploadImg02" name="uploadImg02">
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<!--交换页面模态框-->
		<div class="modal fade" id="swapModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">交换</h4>
					</div>
					<div class="modal-body" style="height: 500px;width: 600px;">
						<div>
							<span style="color:red;font: normal;font-size: 15px;font-weight: bold;">(注：以下两中方式只能选择一个)</span>
						</div>
						<div id="formDiv" style="border: 1px solid #ddd;">
							<form class="form-horizontal" id="swapForm" action="item/swap" onsubmit="return validateSwapForm()" method="POST" enctype="multipart/form-data">
								<div class="form-group">
									
									<input name="receiver_item_id" id="receiver_item_id" type="hidden"/>
									<label for="name" class="col-lg-2 control-label">物品名称:</label>
									<div class="col-lg-4">
										<input type="text" name="name" class="form-control" id="s_name">
									</div>
								</div>
								<div class="form-group">
									<label for="typeName" class="col-lg-2 control-label">类别:</label>
									<div class="col-lg-4">
										<select class="form-control" name="typeName" id="s_typeName">										
											<option value="图书">图书</option>
											<option value="游戏">游戏</option>
											<option value="数码">数码</option>
											<option value="家居">家居</option>
											<option value="其他">其他</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="desc" class="col-lg-2 control-label">描述:</label>
									<div class="col-lg-4">
										<textarea class="form-control" name="desc" id="s_desc" rows="3"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="confirmPwd" class="col-lg-2 control-label">图片1：</label>
									<div class="col-lg-4">
										<input type="file" class="form-control" id="uploadImg01" name="uploadImg01">
									</div>
								</div>
								<div class="form-group">
									<label for="confirmPwd" class="col-lg-2 control-label">图片2：</label>
									<div class="col-lg-4">
										<input type="file" class="form-control" id="uploadImg02" name="uploadImg02">
									</div>
								</div>
								<div class="form-group">
									<label for="confirmPwd" class="col-lg-2 control-label">图片3：</label>
									<div class="col-lg-4">
										<input type="file" class="form-control" id="uploadImg02" name="uploadImg02">
									</div>
								</div>

							
						</div>
						<div style="border: 1px solid #ddd;height:50px;margin-top: 10px;">						
							<div class="form-group">
								<label for="itemName" class="col-lg-2 control-label">可选物品:</label>
								<div class="col-lg-4">
									<select class="form-control" name="itemName" id="availableItems">
										
									</select>
								</div>
							</div>							
						</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary" id="swapFormButton">发送</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<div id="myPublishDiv" style="display: none;">
			
		</div>
		<div id="myMessageDiv" style="display: none;padding-left: 20px;">
			
		</div>
		<div id="updateUserInfoDiv" style="display: none;padding-left: 400px;margin-top:50px;border:1px solid #ddd">
			<form class="form-horizontal" id="userUpdateInfoForm" action="user/update" method="POST" onsubmit="return updateInfoValidate()">
				<input name="id" type="hidden" id="id"/>
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
					<label for="email" class="col-lg-2 control-label">微信:</label>
					<div class="col-lg-4">
						<input type="text" name="weixin" class="form-control" id="weixin">
					</div>
				</div>
				<div class="form-group">
					<label for="simpleDesc" class="col-lg-2 control-label">简介:</label>
					<div class="col-lg-4">
						<input type="text" name="simpleDesc" style="height: 100px;" class="form-control" id="simpleDesc">
					</div>
				</div>
				<div class="form-group">
					<div class="col-lg-12" style="padding-left: 280px;">
						<button class="btn btn-default" type="submit">确认修改</button>
					</div>
				</div>

			</form>
		</div>
		<div id="changePasswordDiv" style="display: none;padding-left: 400px;margin-top:50px;border:1px solid #ddd">
			<form class="form-horizontal" id="userChangePasswordForm" action="user/changePassword" method="POST" onsubmit="return changePwdValidate()">
				<input name="id" type="hidden" id="id"/>
				<div class="form-group">
					<label for="oldPassword" class="col-lg-2 control-label">原密码:</label>
					<div class="col-lg-4">
						<input type="password" name="oldPassword" class="form-control" id="oldPassword">
					</div>
				</div>
				<div class="form-group">
					<label for="newPassword" class="col-lg-2 control-label">新密码:</label>
					<div class="col-lg-4">
						<input type="password" name="newPassword" class="form-control" id="newPassword">
					</div>
				</div>
				<div class="form-group">
					<label for="confirmPwd" class="col-lg-2 control-label">确认密码:</label>
					<div class="col-lg-4">
						<input type="password" name="confirmPwd" class="form-control" id="confirmPwd">
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-lg-12" style="padding-left: 280px;">
						<button class="btn btn-default" type="submit">确认修改</button>
					</div>
				</div>

			</form>
		</div>
	</body>

</html>