package dev.mvc.category;

public class Categorygrp_CategoryVO {
    /** 카테고리 그룹 번호 */
    private int r_categorygrp_no;
    /**  카테고리 이름 */
    private String r_categorygrp_name;
    
    
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
    
    
    public int getR_categorygrp_no() {
        return r_categorygrp_no;
    }
    public void setR_categorygrp_no(int r_categorygrp_no) {
        this.r_categorygrp_no = r_categorygrp_no;
    }
    public String getR_categorygrp_name() {
        return r_categorygrp_name;
    }
    public void setR_categorygrp_name(String r_categorygrp_name) {
        this.r_categorygrp_name = r_categorygrp_name;
    }
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
        return "Categorygrp_CategoryVO [r_categorygrp_no=" + r_categorygrp_no + ", r_categorygrp_name="
                + r_categorygrp_name + ", category_no=" + category_no + ", categorygrp_no=" + categorygrp_no
                + ", category_name=" + category_name + ", cdate=" + cdate + ", product_cnt=" + product_cnt + "]";
    }
        

}
