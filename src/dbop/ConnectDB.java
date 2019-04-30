package dbop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectDB {
	private ConnectDB() {}

	private static String url = "jdbc:mysql://localhost:3306/gep";
	private static String user = "root";
	private static String password = "158337";

	public static void main(String[] args) {
		Connection connection = ConnectDB.getConnection();
		System.out.println(connection);
	}
	
	public static Connection getConnection() {
		Connection con = null;
		try {
			// 加载驱动
			Class.forName("com.mysql.jdbc.Driver");
			// 获取连接
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		// 返回连接结果
		return con;
	}

	/**
	 * 关闭连接 包含三个参数
	 * 
	 * @param con
	 *            连接对象
	 * @param sta
	 *            Statement对象
	 * @param res
	 *            结果集对象
	 */
	public static void closeConnection(Connection con, Statement sta, ResultSet res) {
		try {
			if (res != null)
				res.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (sta != null)
				sta.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 关闭连接 包含两个参数
	 * 
	 * @param con
	 *            连接对象
	 * @param sta
	 *            Statement对象
	 */
	public static void closeConnection(Connection con, Statement sta) {
		try {
			if (sta != null)
				sta.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
