package dbop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import data.EasyUIDatagridResult;
import data.Item;
import data.User;
import utils.JsonUtils;

public class ItemDbop {

	public String findAll(Item itemCondition) {
		//查库
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User tb_user = null;
		List<Item> items = new ArrayList<>();
		try {
			connection = ConnectDB.getConnection();
			String sql = "";
			if(itemCondition.getUserId() != null){
				sql = new String("select * from tb_item where user_id = ?");
			}else {
				sql = new String("select * from tb_item where type_name = ?");
			}
			ps = connection.prepareStatement(sql);
			if(itemCondition.getUserId() != null) {
				ps.setInt(1, itemCondition.getUserId());
			}else {
				ps.setString(1, itemCondition.getTypeName());
			}
			rs = ps.executeQuery();
			while(rs.next()) {
				Item item = new Item();
				item.setId(rs.getInt("id"));
				item.setImgPath(rs.getString("img_path"));
				item.setDesc(rs.getString("desc"));
				item.setName(rs.getString("name"));
				item.setPublishTime(rs.getString("publish_time"));
				item.setTypeName(rs.getString("type_name"));
				item.setUserId(rs.getInt("user_id"));
				item.setUserName(rs.getString("user_name"));
				items.add(item);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		//封装json
		String jsonStr = JsonUtils.listToJson(items);
		//返回
		return jsonStr;
	}

	public Integer getLastRecordId() {
		//查库
		Connection connection = null;
		PreparedStatement ps = null;
		Integer lastRecordId = null;
		ResultSet rs = null;
		try {
			connection = ConnectDB.getConnection();
			String sql = "select id from tb_item order by id desc limit 0,1";
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				lastRecordId=rs.getInt("id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		//返回
		return lastRecordId;
	}
	
	
	public void insert(Item item_goods) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "insert into tb_item(`name`,img_path,user_id,user_name,`desc`,type_name,publish_time) values(?,?,?,?,?,?,?)";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, item_goods.getName());
			ps.setString(2, item_goods.getImgPath());
			ps.setInt(3,item_goods.getUserId());
			ps.setString(4, item_goods.getUserName());
			ps.setString(5,item_goods.getDesc());
			ps.setString(6, item_goods.getTypeName());
			ps.setString(7, item_goods.getPublishTime());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		
		
	}

	public Item selectItemById(Integer id) {	
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Item item = null;
		try {
			String sql = "select * from tb_item where id = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();	
			if(rs.next()) {
				item = new Item();
				item.setId(rs.getInt("id"));
				item.setImgPath(rs.getString("img_path"));
				item.setDesc(rs.getString("desc"));
				item.setName(rs.getString("name"));
				item.setPublishTime(rs.getString("publish_time"));
				item.setTypeName(rs.getString("type_name"));
				item.setUserId(rs.getInt("user_id"));
				item.setUserName(rs.getString("user_name"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		//String jsonStr = JsonUtils.beanToJson(item);
		return item;
	}

	public EasyUIDatagridResult getPageList(Integer page, int rows) {
		EasyUIDatagridResult easyUIDatagridResult = new EasyUIDatagridResult();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Integer pageIndex = (page - 1) * rows;
		List<Item> items = new ArrayList<Item>();
		try {
			conn = ConnectDB.getConnection();
			String sql = "select * from tb_item limit ?,?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pageIndex);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()) {
				Item item = new Item();
				item.setId(rs.getInt("id"));
				item.setImgPath(rs.getString("img_path"));
				item.setDesc(rs.getString("desc"));
				item.setName(rs.getString("name"));
				item.setPublishTime(rs.getString("publish_time"));
				item.setTypeName(rs.getString("type_name"));
				item.setUserId(rs.getInt("user_id"));
				item.setUserName(rs.getString("user_name"));
				items.add(item);
			}
			sql = "select count(*) from tb_item";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int total = 0;
			while(rs.next()) {
				total = rs.getInt(1);
			}
			easyUIDatagridResult.setRows(items);
			easyUIDatagridResult.setTotal(total);
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			ConnectDB.closeConnection(conn, ps, rs);
		}
		return easyUIDatagridResult;
	}

	public void update(Item item_goods) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "update tb_item set `name` = ?,img_path = ?,user_id = ?,user_name = ?,`desc` = ?,type_name = ?,publish_time = ? where id =?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, item_goods.getName());
			ps.setString(2, item_goods.getImgPath());
			ps.setInt(3,item_goods.getUserId());
			ps.setString(4, item_goods.getUserName());
			ps.setString(5,item_goods.getDesc());
			ps.setString(6, item_goods.getTypeName());
			ps.setString(7, item_goods.getPublishTime());
			ps.setInt(8, item_goods.getId());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		
	}

	public void delete(int id) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "delete from tb_item where id = ?";
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

	public String findByItemName(String itemName) {
		//查库
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User tb_user = null;
		List<Item> items = new ArrayList<>();
		try {
			connection = ConnectDB.getConnection();
			String sql = "select * from tb_item where name like ?";
			ps = connection.prepareStatement(sql);
			ps.setString(1, "%"+itemName+"%");
			rs = ps.executeQuery();
			while(rs.next()) {
				Item item = new Item();
				item.setId(rs.getInt("id"));
				item.setImgPath(rs.getString("img_path"));
				item.setDesc(rs.getString("desc"));
				item.setName(rs.getString("name"));
				item.setPublishTime(rs.getString("publish_time"));
				item.setTypeName(rs.getString("type_name"));
				item.setUserId(rs.getInt("user_id"));
				item.setUserName(rs.getString("user_name"));
				items.add(item);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		//封装json
		String jsonStr = JsonUtils.listToJson(items);
		//返回
		return jsonStr;
	}

	
}
