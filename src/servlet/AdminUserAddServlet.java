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
 * Servlet implementation class AdminUserAddServlet
 */
public class AdminUserAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String simpleDesc = request.getParameter("simpleDesc");
		String weixin = request.getParameter("weixin");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setSimpleDesc(simpleDesc);
		user.setWeixin(weixin);
		UserDbop userDbop = new UserDbop();
		int result = userDbop.insert(user);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setStatus(200);
		ajaxResult.setMsg("Ìí¼Ó³É¹¦");
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
