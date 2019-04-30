package servlet.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.AjaxResult;
import dbop.ItemDbop;
import utils.JsonUtils;

/**
 * Servlet implementation class AdminItemDeleteServlet
 */
public class AdminItemDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		String idsStr = request.getParameter("ids");
		String[] ids = idsStr.split("[,]");
		ItemDbop itemDbop = new ItemDbop();
		for (String id : ids) {
			itemDbop.delete(Integer.parseInt(id));
		}
		AjaxResult ajaxResult= new AjaxResult();
		ajaxResult.setStatus(200);
		ajaxResult.setMsg("É¾³ý³É¹¦");
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
