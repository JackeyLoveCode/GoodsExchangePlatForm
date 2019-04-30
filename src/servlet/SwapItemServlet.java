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
import data.Message;
import data.User;
import dbop.ItemDbop;
import dbop.MessageDbop;
import dbop.UserDbop;
import utils.ConstantUtil;

/**
 * Servlet implementation class SwapItemServlet
 */
public class SwapItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		User user = (User) request.getSession().getAttribute("user");
		FileItemFactory factory = new DiskFileItemFactory();
        // �����ļ��ϴ�������
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");
        // ��ʼ����������Ϣ
        List items = null;
        try {
            items = upload.parseRequest(request);
        }  catch (FileUploadException e) {
            e.printStackTrace();
        }
        Item item_goods = new Item();
        item_goods.setUserId(user == null ? null:user.getId());
        item_goods.setUserName(user == null ? null:user.getUsername());
        Date date = new Date();
        item_goods.setPublishTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
        String sendName = null;
        Integer itemId = null;
        Integer receiverItemId = null;
        Item sendItem = new Item();
        Iterator iterator = items.iterator();
        //�ж��Ƿ񷢲�
        boolean isPublish = true;
        String imgPath = "";
        while(iterator.hasNext()) {
        	 FileItem item = (FileItem) iterator.next();
             // ��ϢΪ��ͨ�ĸ�ʽ
             if (item.isFormField()) {
                 String fieldName = item.getFieldName();
                 String value = item.getString("UTF-8");
                 if("name".equals(fieldName) && !"".equals(value)) {
                 	item_goods.setName(value);
                 	sendName = value;
                 }else if("typeName".equals(fieldName) && !"".equals(value)) {
                 	item_goods.setTypeName(value);                 	
                 }else if("desc".equals(fieldName) && !"".equals(value)) {
                 	item_goods.setDesc(value);
                 }else if("itemName".equals(fieldName) && !"-1".equals(value)) {
                	itemId = Integer.parseInt(value);//��������Ʒʱʹ��
                	isPublish = false;
                	break;
                	
                 }else if("receiver_item_id".equals(fieldName)) {
                	 receiverItemId = Integer.parseInt(value);
                 }                 
             }
             // ��ϢΪ�ļ���ʽ
             else {
                 String fileName = item.getName();
                 if("".equals(fileName)) {
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
		//���ܲ���
		//����id��ѯ�����ߵ���Ʒ
		//Integer nextRecordId = itemDbop.getLastRecordId();
		Item receiverItem = itemDbop.selectItemById(receiverItemId);
		//�����������ѯ���һ�����ݵ�id
		if(isPublish) {
			itemId = itemDbop.getLastRecordId();
		}
		sendItem = itemDbop.selectItemById(itemId);
		Message message = new Message();
		String messageName = "";
		//������Ϣ����
		MessageDbop messageDbop = new MessageDbop();	
		messageName = sendItem.getName()+"->"+receiverItem.getName();
		message.setName(messageName);
		message.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		message.setReceiveItemId(receiverItemId);
		message.setSendItemId(sendItem.getId());
		message.setReceiveUserId(receiverItem.getUserId());
		UserDbop userDbop = new UserDbop();
		User receiveUser = userDbop.findOneById(message.getReceiveUserId());
		message.setReceiveUserEmail(receiveUser.getEmail());
		message.setSendUserId(sendItem.getUserId());
		messageDbop.insert(message);
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
