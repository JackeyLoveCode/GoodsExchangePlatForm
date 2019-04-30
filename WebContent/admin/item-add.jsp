<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<div>
<div style="border:1px solid #ddd">
	<form id="movieAddForm" action="${pageContext.request.contextPath }/admin/item/save" class="itemForm" enctype="multipart/form-data" method="post">
	    <table cellpadding="5">
	        <tr >
	            <td>商品名称:</td>
	            <td>
	        
	            	<input type="text" class="easyui-textbox" name="name" style="width: 280px;"></input>
	            </td>
	        </tr>
	        <tr>
	            <td>发布人:</td>
	            <td><input id="userId" class="easyui-combobox" name="userId" data-options="valueField:'id',textField:'username',url:'user/display'" /></td>
	        </tr>
	        <tr>
	            <td>描述:</td> 
	            <td><input name="desc" id="desc" class="easyui-textbox" style="height:100px"/></td>
	        </tr>
	        
	        <tr>
	            <td>类型:</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="typeName"/>
	            </td>
	        </tr>
	        
	        
	        <tr>
	            <td style="padding-top: 10px">图片:</td>
	            <td>
	            	<div style="overflow:hidden">
	            	 <div style="float:left;">
	            	 	 <div >
	                	 	<input class="easyui-filebox" style="width:300px" data-options='onChange:change_photo1' id="file_upload1" name="imageFile1"/>
	                	 </div>
	                	 <div >
	                	 	<div id="Imgdiv1">
						        <img id="Img1" width="200px" height="200px"/>
						    </div>
	                	 </div>
	                 </div>
	                 <div style="float:left;">
	            	 	 <div >
	                	 	<input class="easyui-filebox" style="width:300px" data-options='onChange:change_photo2' id="file_upload2" name="imageFile2"/>
	                	 </div>
	                	 <div >
	                	 	<div id="Imgdiv2">
						        <img id="Img2" width="200px" height="200px"/>
						    </div>
	                	 </div>
	                 </div>
	                 <div style="float:left;">
	            	 	 <div >
	                	 	<input class="easyui-filebox" style="width:300px" data-options='onChange:change_photo3' id="file_upload3" name="imageFile3"/>
	                	 </div>
	                	 <div >
	                	 	<div id="Imgdiv3">
						        <img id="Img3" width="200px" height="200px"/>
						    </div>
	                	 </div>
	                 </div>
	               </div>
	            </td>
	        </tr>
	       
	        
	    </table>
	    
	</form>
	</div>
	<div style="padding:50px">
	    <a href="javascript:submitForm()" class="btn btn-success" >提交</a>
	    <a href="javascript:clearForm()" class="btn btn-danger">重置</a>
	</div>
</div>
<script type="text/javascript">
	
	//页面初始化完毕后执行此方法
	$(function(){
		$("table tr").css("height","50px");
		
		$('#type').combobox({    
		    url:'${pageContext.request.contextPath}/movie/findAllTypes.do',    
		    valueField:'id',    
		    textField:'text'   
		});  


	});
	function change_photo1(){
        PreviewImage($("input[name='imageFile1']")[0], 'Img1', 'Imgdiv1');
    }
	function change_photo2(){
        PreviewImage($("input[name='imageFile2']")[0], 'Img2', 'Imgdiv2');
    }
	function change_photo3(){
        PreviewImage($("input[name='imageFile3']")[0], 'Img3', 'Imgdiv3');
    }
	
	//提交表单
	function submitForm(){
		//有效性验证
		if(!$('#movieAddForm').form('validate')){
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}
		
		$('#movieAddForm').form('submit', {
		    success: function(data){
		    	console.log(data);
		        var data = eval('(' + data + ')');  // change the JSON string to javascript object    
		        if (data.status == 200){    
		            alert(data.msg);    
		        }    
		    }    
		});  


	}
	
	function clearForm(){
		$('#movieAddForm').form('reset');
	}
	//预览图片
	function PreviewImage(fileObj,imgPreviewId,divPreviewId){  
	    var allowExtention=".jpg,.bmp,.gif,.png";//允许上传文件的后缀名document.getElementById("hfAllowPicSuffix").value;  
	    var extention=fileObj.value.substring(fileObj.value.lastIndexOf(".")+1).toLowerCase();              
	    var browserVersion= window.navigator.userAgent.toUpperCase();  
	    if(allowExtention.indexOf(extention)>-1){   
	        if(fileObj.files){//HTML5实现预览，兼容chrome、火狐7+等  
	            if(window.FileReader){  
	                var reader = new FileReader();   
	                reader.onload = function(e){  
	                    document.getElementById(imgPreviewId).setAttribute("src",e.target.result);  
	                }    
	                reader.readAsDataURL(fileObj.files[0]);  
	            }else if(browserVersion.indexOf("SAFARI")>-1){  
	                alert("不支持Safari6.0以下浏览器的图片预览!");  
	            }  
	        }else if (browserVersion.indexOf("MSIE")>-1){  
	            if(browserVersion.indexOf("MSIE 6")>-1){//ie6  
	                document.getElementById(imgPreviewId).setAttribute("src",fileObj.value);  
	            }else{//ie[7-9]  
	                fileObj.select();  
	                if(browserVersion.indexOf("MSIE 9")>-1)  
	                    fileObj.blur();//不加上document.selection.createRange().text在ie9会拒绝访问  
	                var newPreview =document.getElementById(divPreviewId+"New");  
	                if(newPreview==null){  
	                    newPreview =document.createElement("div");  
	                    newPreview.setAttribute("id",divPreviewId+"New");  
	                    newPreview.style.width = document.getElementById(imgPreviewId).width+"px";  
	                    newPreview.style.height = document.getElementById(imgPreviewId).height+"px";  
	                    newPreview.style.border="solid 1px #d2e2e2";  
	                }  
	                newPreview.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + document.selection.createRange().text + "')";                              
	                var tempDivPreview=document.getElementById(divPreviewId);  
	                tempDivPreview.parentNode.insertBefore(newPreview,tempDivPreview);  
	                tempDivPreview.style.display="none";                      
	            }  
	        }else if(browserVersion.indexOf("FIREFOX")>-1){//firefox  
	            var firefoxVersion= parseFloat(browserVersion.toLowerCase().match(/firefox\/([\d.]+)/)[1]);  
	            if(firefoxVersion<7){//firefox7以下版本  
	                document.getElementById(imgPreviewId).setAttribute("src",fileObj.files[0].getAsDataURL());  
	            }else{//firefox7.0+                      
	                document.getElementById(imgPreviewId).setAttribute("src",window.URL.createObjectURL(fileObj.files[0]));  
	            }  
	        }else{  
	            document.getElementById(imgPreviewId).setAttribute("src",fileObj.value);  
	        }           
	    }else{  
	        alert("仅支持"+allowExtention+"为后缀名的文件!");  
	        fileObj.value="";//清空选中文件  
	        if(browserVersion.indexOf("MSIE")>-1){                          
	            fileObj.select();  
	            document.selection.clear();  
	        }                  
	        fileObj.outerHTML=fileObj.outerHTML;  
	    }  
	}
</script>
