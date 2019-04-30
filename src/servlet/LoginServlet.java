package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.User;
import dbop.UserDbop;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String identity = request.getParameter("identity");	
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setIdentity(identity);
		UserDbop userDbop = new UserDbop();
		if(user.getIdentity().equals("admin")) {
			List<User> users = userDbop.selectByIdentity(user);
			if(users.get(0).getUsername().equals(username) && users.get(0).getPassword().equals(password)) {
				request.getSession().setAttribute("user", users.get(0));
				response.sendRedirect(request.getServletContext().getContextPath()+"/admin/index.jsp");
			}else {
				request.setAttribute("msg", "用户名或密码错误");
				request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
			}
		}else {
			
			user = userDbop.findOneByMultiCon(user);
			if(user != null) {
				request.getSession().setAttribute("user", user);
				response.sendRedirect(request.getServletContext().getContextPath()+"/index.jsp");
			}else {
				response.setStatus(307);//可以携带参数
				//request.setAttribute("msg", "用户名或密码错误");
				response.sendRedirect(request.getServletContext().getContextPath()+"/login.jsp?status=-1");
				//request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		}
		
	}


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}
	
	public static void main(String[] args) {
		System.out.println(1.91 * 400 + 1.93 * 200);
		System.out.println(1.95 * 620);
	}

}
