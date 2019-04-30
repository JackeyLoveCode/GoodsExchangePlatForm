package servlet.admin;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import data.AjaxResult;
import data.Item;
import data.User;
import dbop.ItemDbop;
import dbop.UserDbop;
import utils.ConstantUtil;
import utils.JsonUtils;

/**
 * Servlet implementation class AdminItemUpdateServlet
 */
public class AdminItemUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		FileItemFactory factory = new DiskFileItemFactory();
        // 创建文件上传处理器
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");
        // 开始解析请求信息
        List items = null;
        try {
            items = upload.parseRequest(request);
        }
        catch (FileUploadException e) {
            e.printStackTrace();
        }
        Item item_goods = new Item();
        Date date = new Date();
        item_goods.setPublishTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
        // 对所有请求信息进行判断
        Iterator iter = items.iterator();
        String imgPath = "";
        while (iter.hasNext()) {
            FileItem item = (FileItem) iter.next();
            // 信息为普通的格式
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String value = item.getString("UTF-8");
                if("name".equals(fieldName)) {
                	item_goods.setName(value);
                }else if("typeName".equals(fieldName)) {
                	item_goods.setTypeName(value);
                }else if("desc".equals(fieldName)) {
                	item_goods.setDesc(value);
                }else if("userId".equals(fieldName)){
                	item_goods.setUserId(Integer.parseInt(value));
                	UserDbop userDbop = new UserDbop();
                	User user= userDbop.findOneById(Integer.parseInt(value));
                	item_goods.setUserName(user.getUsername());
                }else if("id".equals(fieldName)){
                	item_goods.setId(Integer.parseInt(value));
                }
                
            }
            // 信息为文件格式
            else {
                String fileName = item.getName();
                if(fileName == null || "".equals(fileName)) {
                	continue;
                }
                System.out.println(fileName);
                int index = fileName.lastIndexOf("\\");
                fileName = fileName.substring(index + 1);
                request.setAttribute("realFileName", fileName);
                String basePath = ConstantUtil.fileUploadPath;
                imgPath += basePath + "\\" +fileName + ";";
                
                File file = new File(basePath, fileName);
                try {
                    item.write(file);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        item_goods.setImgPath(imgPath);
        ItemDbop itemDbop = new ItemDbop();
        itemDbop.update(item_goods);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setStatus(200);
        ajaxResult.setMsg("修改成功");
        String jsonStr = JsonUtils.beanToJson(ajaxResult);
        response.getWriter().write(jsonStr);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
