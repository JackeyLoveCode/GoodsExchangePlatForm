package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.Message;
import data.MessageAndItems;
import data.User;
import dbop.MessageDbop;
import utils.JsonUtils;

/**
 * Servlet implementation class DisplayAllMessage
 */
public class DisplayAllMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		User user = (User) request.getSession().getAttribute("user");
		if(user == null) {
			response.sendRedirect(request.getServletContext().getContextPath()+"/login.jsp");
		}
		MessageDbop messageDbop = new MessageDbop();
		List<MessageAndItems> messages = messageDbop.selectAll(user);
		String jsonStr = JsonUtils.listToJson(messages);
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
