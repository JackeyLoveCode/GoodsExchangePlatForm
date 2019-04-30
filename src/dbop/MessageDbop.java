package dbop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.Item;
import data.Message;
import data.MessageAndItems;
import data.User;

public class MessageDbop {

	public void insert(Message message) {
		Connection connection = null;
		PreparedStatement ps = null;
		Integer result = 0;
		try {
			String sql = "insert into tb_message(name,create_time,send_user_id,receive_user_id,receive_item_id,send_item_id,state,receive_user_email) values(?,?,?,?,?,?,?,?)";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setString(1, message.getName());
			ps.setString(2, message.getCreateTime());
			ps.setInt(3,message.getSendUserId());
			ps.setInt(4, message.getReceiveUserId());
			ps.setInt(5, message.getReceiveItemId());
			ps.setInt(6, message.getSendItemId());
			ps.setInt(7, 0);
			ps.setString(8, message.getReceiveUserEmail());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
	}

	public List<MessageAndItems> selectAll(User user) {
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<MessageAndItems> list = new ArrayList<MessageAndItems>();
		ItemDbop itemDbop = new ItemDbop();
		try {
			connection = ConnectDB.getConnection();
			String sql = "select * from tb_message  where send_user_id = ? or receive_user_id = ? order by create_time desc";
			ps = connection.prepareStatement(sql);
			ps.setInt(1, user.getId());
			ps.setInt(2, user.getId());
			rs = ps.executeQuery();
			while(rs.next()) {
				MessageAndItems messageAndItems = new MessageAndItems();
				Message message = new Message();
				message.setId(rs.getInt("id"));
				message.setName(rs.getString("name"));
				message.setCreateTime(rs.getString("create_time"));
				message.setReceiveItemId(rs.getInt("receive_item_id"));		
				message.setSendItemId(rs.getInt("send_item_id"));
				message.setReceiveUserId(rs.getInt("receive_user_id"));
				message.setSendUserId(rs.getInt("send_user_id"));
				message.setState(rs.getShort("state"));
				message.setReceiveUserEmail(rs.getString("receive_user_email"));
				Item receiveItem = itemDbop.selectItemById(message.getReceiveItemId());
				Item sendItem = itemDbop.selectItemById(message.getSendItemId());
				messageAndItems.setMessage(message);
				messageAndItems.setReceiveItem(receiveItem);
				messageAndItems.setSendItem(sendItem);
				list.add(messageAndItems);
				
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
		return list;
	}

	public void updateMessageState(Integer id, short state) {
		// TODO Auto-generated method stub
		Connection connection = null;
		PreparedStatement ps = null;
		
		try {
			String sql = "update tb_message set state = ? where id = ?";
			connection = ConnectDB.getConnection();
			ps = connection.prepareStatement(sql);
			ps.setShort(1, state);
			ps.setInt(2, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			ConnectDB.closeConnection(connection, ps);
		}
	}
	
}
