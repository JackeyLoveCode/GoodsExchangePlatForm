package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.Item;
import data.User;
import dbop.ItemDbop;

/**
 * Servlet implementation class DisplayAllItemsServlet
 */
public class DisplayAllItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		User user =  (User) request.getSession().getAttribute("user");
		Integer userId = null;
		if(user != null) {
			userId = user.getId();
		}
		ItemDbop itemDbop = new ItemDbop();
		String typeName = request.getParameter("typeName");
		String isByUser = request.getParameter("isByUser");
		Item itemCondition = new Item();
		if(isByUser != null && "yes".equals(isByUser)) {
			itemCondition.setUserId(userId);
		}
		if(typeName == null || "".equals(typeName)) {
			typeName = "Õº È";
		}
		itemCondition.setTypeName(typeName);
		String jsonStr = itemDbop.findAll(itemCondition);
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
