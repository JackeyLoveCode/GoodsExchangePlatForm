package data;

public class Message {
	private Integer id;
	private String name;
	private String createTime;
	private Integer sendUserId;
	private Integer receiveUserId;
	private String receiveUserEmail;
	private Integer receiveItemId;
	private Integer sendItemId;
	private Short state;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getReceiveUserEmail() {
		return receiveUserEmail;
	}
	public void setReceiveUserEmail(String receiveUserEmail) {
		this.receiveUserEmail = receiveUserEmail;
	}
	public Integer getReceiveItemId() {
		return receiveItemId;
	}
	public void setReceiveItemId(Integer receiveItemId) {
		this.receiveItemId = receiveItemId;
	}
	public Integer getSendItemId() {
		return sendItemId;
	}
	public void setSendItemId(Integer sendItemId) {
		this.sendItemId = sendItemId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getSendUserId() {
		return sendUserId;
	}
	public void setSendUserId(Integer sendUserId) {
		this.sendUserId = sendUserId;
	}
	public Integer getReceiveUserId() {
		return receiveUserId;
	}
	public void setReceiveUserId(Integer receiveUserId) {
		this.receiveUserId = receiveUserId;
	}
	public Short getState() {
		return state;
	}
	public void setState(Short state) {
		this.state = state;
	}
	

}
