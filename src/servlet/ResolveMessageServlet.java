package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.AjaxResult;
import dbop.MessageDbop;
import utils.JsonUtils;

/**
 * Servlet implementation class ResolveMessageServlet
 */
public class ResolveMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		Integer id = Integer.parseInt((String)request.getParameter("id"));
		String isAcceptStr = request.getParameter("isAccept");
		boolean isAccept = Boolean.parseBoolean(isAcceptStr);
		MessageDbop messageDbop = new MessageDbop();
		if(isAccept) {
			messageDbop.updateMessageState(id,(short)1);
		}else {
			messageDbop.updateMessageState(id,(short)2);
		}
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setMsg("³É¹¦");
		ajaxResult.setStatus(200);
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
