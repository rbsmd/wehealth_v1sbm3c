package dev.mvc.items;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
        itemsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        adminno                              NUMBER(10)     NOT NULL ,
        category_no                                NUMBER(10)         NOT NULL ,
        item_name                                 VARCHAR2(300)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom_cnt                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        view_cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        comment_cnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        password                                VARCHAR2(15)         NOT NULL,
        search_word                                  VARCHAR2(300)         NULL ,
        cdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,
        file1saved                            VARCHAR(100)          NULL,
        thumb1                              VARCHAR(100)          NULL,
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  
        item_price                                 NUMBER(10)      DEFAULT 0 NULL,  
        discount                                    NUMBER(10)      DEFAULT 0 NULL,  
        total_price                            NUMBER(10)      DEFAULT 0 NULL,  
        item_point                                 NUMBER(10)      DEFAULT 0 NULL,  
        item_cnt                               NUMBER(10)      DEFAULT 0 NULL,  
 */

@Getter @Setter @ToString
public class ItemsVO {
  public int getItemsno() {
		return itemsno;
	}

	public void setItemsno(int itemsno) {
		this.itemsno = itemsno;
	}

	public int getAdminno() {
		return adminno;
	}

	public void setAdminno(int adminno) {
		this.adminno = adminno;
	}

	public int getCategory_no() {
		return category_no;
	}

	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getRecom_cnt() {
		return recom_cnt;
	}

	public void setRecom_cnt(int recom_cnt) {
		this.recom_cnt = recom_cnt;
	}

	public int getView_cnt() {
		return view_cnt;
	}

	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}

	public int getComment_cnt() {
		return comment_cnt;
	}

	public void setComment_cnt(int comment_cnt) {
		this.comment_cnt = comment_cnt;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSearch_word() {
		return search_word;
	}

	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}

	public String getCdate() {
		return cdate;
	}

	public void setCdate(String cdate) {
		this.cdate = cdate;
	}

	public String getFile1() {
		return file1;
	}

	public void setFile1(String file1) {
		this.file1 = file1;
	}

	public String getFile1saved() {
		return file1saved;
	}

	public void setFile1saved(String file1saved) {
		this.file1saved = file1saved;
	}

	public String getThumb1() {
		return thumb1;
	}

	public void setThumb1(String thumb1) {
		this.thumb1 = thumb1;
	}

	public long getSize1() {
		return size1;
	}

	public void setSize1(long size1) {
		this.size1 = size1;
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

	public int getItem_cnt() {
		return item_cnt;
	}

	public void setItem_cnt(int item_cnt) {
		this.item_cnt = item_cnt;
	}

	public MultipartFile getFile1MF() {
		return file1MF;
	}

	public void setFile1MF(MultipartFile file1mf) {
		file1MF = file1mf;
	}

	public String getSize1_label() {
		return size1_label;
	}

	public void setSize1_label(String size1_label) {
		this.size1_label = size1_label;
	}

/** 컨텐츠 번호 */
  private int itemsno;
  /** 관리자 번호 */
  private int adminno;
  /** 카테고리 번호*/
  private int category_no;
  /** 제목 */
  private String item_name = "";
  /** 내용 */
  private String content = "";
  /** 추천수 */
  private int recom_cnt;
  /** 조회수 */
  private int view_cnt = 0;
  /** 댓글수 */
  private int comment_cnt = 0;
  /** 패스워드 */
  private String password = "";
  /** 검색어 */
  private String search_word = "";
  /** 등록 날짜 */
  private String cdate = "";
  
  /** 메인 이미지 */
  private String file1 = "";
  /** 실제 저장된 메인 이미지 */
  private String file1saved = "";  
  /** 메인 이미지 preview */
  private String thumb1 = "";
  /** 메인 이미지 크기 */
  private long size1;

  /** 정가 */
  private int item_price;
  /** 할인률 */
  private int discount;
  /** 판매가 */
  private int total_price;
  /** 포인트 */
  private int item_point;
  /** 재고 수량 */
  private int item_cnt;
  
  /** 
  이미지 MultipartFile 
  <input type='file' class="form-control" name='file1MF' id='file1MF' 
                   value='' placeholder="파일 선택">
  */
  private MultipartFile file1MF;

  /**
   * 파일 크기 단위 출력
   */
  private String size1_label;
}






