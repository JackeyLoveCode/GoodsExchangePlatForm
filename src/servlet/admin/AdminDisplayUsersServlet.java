package servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.EasyUIDatagridResult;
import data.User;
import dbop.UserDbop;
import utils.JsonUtils;

/**
 * Servlet implementation class AdminDisplayUsersServlet
 */
public class AdminDisplayUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		Integer page = Integer.parseInt(request.getParameter("page") == null ? "-1":request.getParameter("page"));
		Integer rows = Integer.parseInt(request.getParameter("rows") == null ? "-1":request.getParameter("rows"));
		UserDbop userDbop = new UserDbop();
		EasyUIDatagridResult easyUIDatagridResult =  userDbop.findAll(page,rows);
		String jsonStr = JsonUtils.beanToJson(easyUIDatagridResult);
		if(page == -1) {
			jsonStr = JsonUtils.listToJson(easyUIDatagridResult.getRows());
		}
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
