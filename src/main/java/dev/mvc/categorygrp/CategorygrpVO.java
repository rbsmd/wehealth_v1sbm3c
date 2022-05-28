package dev.mvc.categorygrp;

/*
categorygrp_no NUMERIC(10) NOT NULL PRIMARY KEY,
categorygrp_name VARCHAR(50) NOT NULL,
seq_no NUMERIC(7) NOT NULL,
print_mode CHAR(1) NOT NULL,
cdate DATE NOT NULL
*/

public class CategorygrpVO {
    /** 카테고리 그룹 번호 */
    private int categorygrp_no;
    /**  카테고리 이름 */
    private String categorygrp_name;
    /** 출력 순서 */
    private int seq_no;
    /** 출력 모드 */
    private String print_mode;
    /** 등록일 */
    private String cdate;
       
    public CategorygrpVO() {
        
    }
    
    public CategorygrpVO(int categorygrp_no, String categorygrp_name, int seq_no, String print_mode, String cdate) {
        this.categorygrp_no = categorygrp_no;
        this.categorygrp_name = categorygrp_name;
        this.seq_no = seq_no;
        this.print_mode = print_mode;
        this.cdate = cdate;
    }

    @Override
    public String toString() {
        return "CategorygrpVO [categorygrp_no=" + categorygrp_no + ", categorygrp_name=" + categorygrp_name
                + ", seq_no=" + seq_no + ", print_mode=" + print_mode + ", cdate=" + cdate + "]";
    }

    public int getCategorygrp_no() {
        return categorygrp_no;
    }

    public void setCategorygrp_no(int categorygrp_no) {
        this.categorygrp_no = categorygrp_no;
    }

    public String getCategorygrp_name() {
        return categorygrp_name;
    }

    public void setCategorygrp_name(String categorygrp_name) {
        this.categorygrp_name = categorygrp_name;
    }

    public int getSeq_no() {
        return seq_no;
    }

    public void setSeq_no(int seq_no) {
        this.seq_no = seq_no;
    }

    public String getPrint_mode() {
        return print_mode;
    }

    public void setPrint_mode(String print_mode) {
        this.print_mode = print_mode;
    }

    public String getCdate() {
        return cdate;
    }

    public void setCdate(String cdate) {
        this.cdate = cdate;
    }

}
