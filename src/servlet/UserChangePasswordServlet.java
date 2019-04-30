package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.User;
import dbop.UserDbop;

/**
 * Servlet implementation class UserChangePasswordServlet
 */
public class UserChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String password = request.getParameter("newPassword");
		User user = (User) request.getSession().getAttribute("user");
		if(user == null) {
			response.sendRedirect(request.getServletContext().getContextPath()+"/login.jsp");
		}else {
			user.setPassword(password);
			UserDbop userDbop = new UserDbop();
			userDbop.update(user);
			response.sendRedirect(request.getServletContext().getContextPath()+"/index.jsp?status=200");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
