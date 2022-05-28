package dev.mvc.categorygrp;

import java.util.List;

//MyBATIS의 <mapper namespace="dev.mvc.categorygrp.CategorygrpDAOInter">에 선언
//스프링이 자동으로 구현
public interface CategorygrpDAOInter {
    /**
     * 등록
     * insert id="create" parameterType="dev.mvc.categorygrp.CategorygrpVO"
     * @param categorygrpVO
     * @return 등록된 레코드 갯수
     */
    public int create(CategorygrpVO categorygrpVO);
       
    /**
     * 등록 순서별 목록
     * select id="list_categrpno_asc" resultType="dev.mvc.categorygrp.CategorygrpVO"
     * @return
     */
    public List<CategorygrpVO> list_categorygrpno_asc();
    
    /**
     * 출력 순서별 목록
     * select id="list_seqno_asc" resultType="dev.mvc.categorygrp.CategorygrpVO"
     * @return
     */
    public List<CategorygrpVO> list_seqno_asc();
    
    /**
     * 조회, 수정폼
     * select id="read" resultType="dev.mvc.categorygrp.CategorygrpVO" parameterType="int"
     * @param categorygrp_no 카테고리 그룹 번호, PK
     * @return
     */
    public CategorygrpVO read(int categorygrp_no);
    
    /**
     * 수정 처리
     * update id="update" parameterType="dev.mvc.categorygrp.CategorygrpVO"
     * @param categorygrpVO
     * @return 처리된 레코드 갯수
     */
    public int update(CategorygrpVO categorygrpVO);
    
    /**
     * 삭제 처리
     * delete id="delete" parameterType="int"
     * @param categorygrp_no
     * @return 처리된 레코드 갯수
     */
    public int delete(int categorygrp_no);
    
    /**
     * 출력 순서 상향
     * update id="update_seqno_up" parameterType="int"
     * @param categorygrp_no
     * @return 처리된 레코드 갯수
     */
    public int update_seqno_up(int categorygrp_no);
   
    /**
     * 출력 순서 하향
     * update id="update_seqno_down" parameterType="int"
     * @param categorygrp_no
     * @return 처리된 레코드 갯수
     */
    public int update_seqno_down(int categorygrp_no); 
    
    /**
     * visible 수정
     * update id="update_visible" parameterType="dev.mvc.categrp.CategrpVO
     * @param categorygrpVO
     * @return
     */
    public int update_visible(CategorygrpVO categorygrpVO);
    

    
}
