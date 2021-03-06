package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.AjaxResult;
import dbop.ItemDbop;
import dbop.UserDbop;
import utils.JsonUtils;

/**
 * Servlet implementation class AdminUserDeleteServlet
 */
public class AdminUserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		String idsStr = request.getParameter("ids");
		String[] ids = idsStr.split("[,]");
		UserDbop userDbop = new UserDbop();
		for (String id : ids) {
			userDbop.delete(Integer.parseInt(id));
		}
		AjaxResult ajaxResult= new AjaxResult();
		ajaxResult.setStatus(200);
		ajaxResult.setMsg("ɾ���ɹ�");
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
