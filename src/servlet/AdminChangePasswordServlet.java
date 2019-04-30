package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.AjaxResult;
import data.User;
import dbop.UserDbop;
import utils.JsonUtils;

/**
 * Servlet implementation class AdminChangePasswordServlet
 */
public class AdminChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		AjaxResult ajaxResult = new AjaxResult();
		String code = request.getParameter("code");
		String newPassword = request.getParameter("newPassword");
		HttpSession httpSession = request.getSession();
		User admin = (User) httpSession.getAttribute("user");
		UserDbop userDbop = new UserDbop();
		if(admin == null) {
			ajaxResult.setStatus(201);
			ajaxResult.setMsg("登录失效");
		}else {
			String session_code = (String) httpSession.getAttribute("code");
			if(session_code.equalsIgnoreCase(code)) {
				userDbop.changePassword(newPassword);
				ajaxResult.setMsg("修改成功");
				ajaxResult.setStatus(200);
			}else {
				ajaxResult.setStatus(202);
				ajaxResult.setMsg("验证码不正确");
			}
		}
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
