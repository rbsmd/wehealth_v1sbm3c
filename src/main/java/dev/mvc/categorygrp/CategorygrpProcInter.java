package dev.mvc.categorygrp;

import java.util.List;

public interface CategorygrpProcInter {
    /**
     * 등록
     * 
     * @param categorygrpVO
     * @return 등록된 레코드 갯수
     */
    public int create(CategorygrpVO categorygrpVO);
    
    /**
     * 등록 순서별 목록
     * 
     * @return
     */
    public List<CategorygrpVO> list_categorygrpno_asc();
    
    /**
     * 출력 순서별 목록
     * 
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
     * 
     * @param categorygrpVO
     * @return 처리된 레코드 갯수
     */
    public int update(CategorygrpVO categorygrpVO);
    
    /**
     * 삭제 처리
     * 
     * @param categorygrp_no
     * @return 처리된 레코드 갯수
     */
    public int delete(int categorygrp_no);
    
    /**
     * 출력 순서 상향
     * 
     * @param categorygrp_no
     * @return 처리된 레코드 갯수
     */
    public int update_seqno_up(int categorygrp_no);
   
    /**
     * 출력 순서 하향
     * 
     * @param categorygrp_no
     * @return 처리된 레코드 갯수
     */
    public int update_seqno_down(int categorygrp_no); 
    
    /**
     * visible 수정
     * 
     * @param categorygrpVO
     * @return
     */
    public int update_visible(CategorygrpVO categorygrpVO);

}
