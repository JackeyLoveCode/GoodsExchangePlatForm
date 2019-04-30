package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.AjaxResult;
import data.User;
import dbop.UserDbop;
import utils.JsonUtils;

/**
 * Servlet implementation class UserUpdateServlet
 */
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("utf-8");
		Integer id = Integer.parseInt(request.getParameter("id"));
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String simpleDesc = request.getParameter("simpleDesc");
		String weixin = request.getParameter("weixin");
		User user = new User();
		user.setId(id);
		user.setUsername(username);
		user.setEmail(email);
		user.setSimpleDesc(simpleDesc);
		user.setWeixin(weixin);
		UserDbop userDbop = new UserDbop();
		int result = userDbop.updateInfo(user);
		response.sendRedirect(request.getServletContext().getContextPath()+"/index.jsp?status=200");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
