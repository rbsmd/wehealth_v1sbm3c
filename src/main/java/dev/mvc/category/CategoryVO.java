package dev.mvc.category;

/*
category_no NUMERIC(10) NOT NULL PRIMARY KEY,
categorygrp_no NUMERIC(10) NOT NULL,
category_name VARCHAR(30) NOT NULL,
cdate DATE NOT NULL,
product_cnt NUMERIC(10) NOT NULL,
 FOREIGN KEY (categorygrp_no) REFERENCES categorygrp (categorygrp_no)
 */

public class CategoryVO {
    /** 카테고리 번호 */
    private int category_no;  
    /** 카테고리 그룹 번호 */
    private int categorygrp_no;
    /** 카테고리 이름 */
    private String category_name;
    /** 등록일 */
    private String cdate;
    /** 등록된 글 수 */
    private int product_cnt;
    
    
    public int getCategory_no() {
        return category_no;
    }
    public void setCategory_no(int category_no) {
        this.category_no = category_no;
    }
    public int getCategorygrp_no() {
        return categorygrp_no;
    }
    public void setCategorygrp_no(int categorygrp_no) {
        this.categorygrp_no = categorygrp_no;
    }
    public String getCategory_name() {
        return category_name;
    }
    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }
    public String getCdate() {
        return cdate;
    }
    public void setCdate(String cdate) {
        this.cdate = cdate;
    }
    public int getProduct_cnt() {
        return product_cnt;
    }
    public void setProduct_cnt(int product_cnt) {
        this.product_cnt = product_cnt;
    }
    
    
    @Override
    public String toString() {
        return "CategoryVO [category_no=" + category_no + ", categorygrp_no=" + categorygrp_no + ", category_name="
                + category_name + ", cdate=" + cdate + ", product_cnt=" + product_cnt + "]";
    }
     
}
