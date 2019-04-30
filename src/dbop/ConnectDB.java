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
			// ��������
			Class.forName("com.mysql.jdbc.Driver");
			// ��ȡ����
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		// �������ӽ��
		return con;
	}

	/**
	 * �ر����� ������������
	 * 
	 * @param con
	 *            ���Ӷ���
	 * @param sta
	 *            Statement����
	 * @param res
	 *            ���������
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
	 * �ر����� ������������
	 * 
	 * @param con
	 *            ���Ӷ���
	 * @param sta
	 *            Statement����
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
