package servlet;

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

import data.Item;
import data.User;
import dbop.ItemDbop;
import utils.ConstantUtil;

/**
 * Servlet implementation class PublishItemServlet
 */
public class PublishItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		User user = (User) request.getSession().getAttribute("user");
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
        item_goods.setUserId(user.getId());
        item_goods.setUserName(user.getUsername());
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
        itemDbop.insert(item_goods);
        response.sendRedirect(request.getServletContext().getContextPath()+"/index.jsp");


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
