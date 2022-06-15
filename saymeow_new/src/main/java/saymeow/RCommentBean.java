package saymeow;

public class RCommentBean {
	private int rcNum; // 코멘트 순번
	private int rnum; // 리뷰 순번
	private String cid; // 코멘트 작성 아이디
	private int pnum; // 상품번호
	private String rcDate; // 코멘트 작성 날짜
	private String comment; // 코멘트 내용
	
	
	public int getRcNum() {
		return rcNum;
	}
	public void setRcNum(int rcNum) {
		this.rcNum = rcNum;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getRcDate() {
		return rcDate;
	}
	public void setRcDate(String rcDate) {
		this.rcDate = rcDate;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

	
	
	
}
