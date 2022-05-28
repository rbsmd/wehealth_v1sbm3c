package dev.mvc.cart;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// cartno                        NUMBER(10) NOT NULL PRIMARY KEY,
// itemsno                 NUMBER(10) NULL ,
// memberno                 NUMBER(10) NOT NULL,
// cnt                            NUMBER(10) DEFAULT 0 NOT NULL,
// rdate                          DATE NOT NULL,
// FOREIGN KEY (itemsno) REFERENCES items (itemsno),
// FOREIGN KEY (memberno) REFERENCES member (memberno)

// SELECT t.cartno, c.itemsno, c.item_name, c.thumb1, c.item_price, c.discount, c.total_price, c.item_point, t.memberno, t.cnt, t.rdate 

@Getter @Setter @ToString
public class CartVO {
    public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public int getItemsno() {
		return itemsno;
	}
	public void setItemsno(int itemsno) {
		this.itemsno = itemsno;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getThumb1() {
		return thumb1;
	}
	public void setThumb1(String thumb1) {
		this.thumb1 = thumb1;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getItem_point() {
		return item_point;
	}
	public void setItem_point(int item_point) {
		this.item_point = item_point;
	}
	public int getMemberno() {
		return memberno;
	}
	public void setMemberno(int memberno) {
		this.memberno = memberno;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public int getTot() {
		return tot;
	}
	public void setTot(int tot) {
		this.tot = tot;
	}
	/** 쇼핑 카트 번호 */
    private int cartno;
    /** 아이템 번호 */
    private int itemsno;
    /** 상품명 */
    private String item_name = "";
    /** 메인 이미지 Preview */
    private String thumb1="";
    /** 정가 */
    private int item_price;
    /** 할인율 */
    private int discount;
    /** 판매가 */
    private int total_price;
    /** 포인트 */
    private int item_point;
    /** 회원 번호 */
    private int memberno;
    /** 수량 */
    private int cnt;
    /** 날짜 */
    private String rdate;
    /** 금액 = 판매가 x 수량 */
    private int tot;
    
    
}

