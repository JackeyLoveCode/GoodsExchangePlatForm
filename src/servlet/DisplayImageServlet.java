package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DisplayImageServlet
 */
public class DisplayImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathName = request.getParameter("pathName");
		File imgFile = new File(pathName);
		FileInputStream fin = null;
		OutputStream output=null;
		try {
			fin = new FileInputStream(imgFile);
			output = response.getOutputStream();
			byte[] bytes = new byte[1024 * 10];
			int n = 0;
			while((n = fin.read(bytes)) != -1) {
				output.write(bytes, 0, n);
			}
			output.flush();
			output.close();
		} catch (Exception e) {
			  
			// TODO Auto-generated catch block  
			e.printStackTrace();  
			
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
