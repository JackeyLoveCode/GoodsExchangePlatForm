package dbop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.EasyUIDatagridResult;
import data.User;

public class UserDbop {
//	`id` int(16) NOT NULL AUTO_INCREMENT,
//	  `username` varchar(128) NOT NULL,
//	  `password` varchar(128) NOT NULL,
//	  `email` varchar(255) DEFAULT NULL,
	public Integer insert(User user) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "insert into tb_users(username,password,email,simple_desc,weixin) values(?,?,?,?,?)";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3,user.getEmail());
			ps.setString(4, user.getSimpleDesc());
			ps.setString(5, user.getWeixin());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return result;
	}
	
	public User findOneByMultiCon(User user){
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User tb_user = null;
		try {
			String sql = "select * from tb_users where `username`= ? and `password` = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2,user.getPassword());
			rs = ps.executeQuery();
			if(rs.next()) {
				tb_user = new User();
				tb_user.setId(rs.getInt("id"));
				tb_user.setUsername(rs.getString("username"));
				tb_user.setPassword(rs.getString("password"));
				tb_user.setEmail(rs.getString("email"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return tb_user;
	
	}

	public EasyUIDatagridResult findAll(Integer page, Integer rows) {
		EasyUIDatagridResult easyUIDatagridResult = new EasyUIDatagridResult();
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User tb_user = null;
		List<User> users = new ArrayList<User>();
		try {
			connection = ConnectDB.getConnection();
			String sql = "select * from tb_users limit ?,?";
			ps = connection.prepareStatement(sql);
			if(page < 1) {
				page = 1;
			}
			if(rows < 0) {
				rows = 99999999;
			}
			int pageIndex = (page - 1) * rows;
			ps.setInt(1,pageIndex);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()) {
				tb_user = new User();
				tb_user.setId(rs.getInt("id"));
				tb_user.setIdentity(rs.getString("identity"));
				tb_user.setUsername(rs.getString("username"));
				tb_user.setSimpleDesc(rs.getString("simple_desc"));
				tb_user.setWeixin(rs.getString("weixin"));
				tb_user.setPassword(rs.getString("password"));
				tb_user.setEmail(rs.getString("email"));
				users.add(tb_user);
			}
			sql = "select count(*) from tb_users";
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();
			int total = 0;
			if(rs.next()) {
				total = rs.getInt(1);
			}
			easyUIDatagridResult.setRows(users);
			easyUIDatagridResult.setTotal(total);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return easyUIDatagridResult;
		
	}

	public User findOneById(int id) {
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User tb_user = null;
		try {
			String sql = "select * from tb_users where id = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setInt(1,id);
			rs = ps.executeQuery();
			if(rs.next()) {
				tb_user = new User();
				tb_user.setId(rs.getInt("id"));
				tb_user.setIdentity(rs.getString("identity"));
				tb_user.setUsername(rs.getString("username"));
				tb_user.setSimpleDesc(rs.getString("simple_desc"));
				tb_user.setWeixin(rs.getString("weixin"));
				tb_user.setPassword(rs.getString("password"));
				tb_user.setEmail(rs.getString("email"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return tb_user;
	}

	public int update(User user) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "update tb_users set username = ?,password = ?,email = ?,simple_desc = ?,weixin = ? where id = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3,user.getEmail());
			ps.setString(4, user.getSimpleDesc());
			ps.setString(5, user.getWeixin());
			ps.setInt(6, user.getId());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return result;
	}

	public void delete(int id) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "delete from tb_users where id = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		
	}

	public void changePassword(String newPassword) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "update tb_users set password = ? where username = 'admin' and identity = 'admin'";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, newPassword);
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		
	}

	public int updateInfo(User user) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "update tb_users set username = ?,email = ?,simple_desc = ?,weixin = ? where id = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2,user.getEmail());
			ps.setString(3, user.getSimpleDesc());
			ps.setString(4, user.getWeixin());
			ps.setInt(5, user.getId());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return result;
	}

	public List<User> selectByIdentity(User user) {
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<User> users = new ArrayList<User>();
		try {
			String sql = "select * from tb_users where identity = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1,user.getIdentity());
			rs = ps.executeQuery();
			if(rs.next()) {
				User tb_user = new User();
				tb_user.setId(rs.getInt("id"));
				tb_user.setIdentity(rs.getString("identity"));
				tb_user.setUsername(rs.getString("username"));
				tb_user.setSimpleDesc(rs.getString("simple_desc"));
				tb_user.setWeixin(rs.getString("weixin"));
				tb_user.setPassword(rs.getString("password"));
				tb_user.setEmail(rs.getString("email"));
				users.add(tb_user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return users;
	}
	

}
