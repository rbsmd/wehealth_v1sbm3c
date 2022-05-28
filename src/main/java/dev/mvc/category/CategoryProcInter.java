package dev.mvc.category;

import java.util.List;

public interface CategoryProcInter {
    /**
     * 등록
     * insert id="create" parameterType="dev.mvc.category.CategoryVO"
     * @param categoryVO
     * @return 등록된 갯수
     */
    public int create(CategoryVO categoryVO);
    
    /**
     *  전체 목록
     * @return
     */
    public List<CategoryVO> list_all();  
    
    /**
     *  categorygrp_no별 목록
     * @return
     */
    public List<CategoryVO> list_by_categorygrpno(int categorygrp_no);  
    
    /**
     * Categorygrp + Category join, 연결 목록
     * @return
     */
    public List<Categorygrp_CategoryVO> list_all_join(); 
    
    /**
     * 조회, 수정폼
     * @param category_no 카테고리 번호, PK
     * @return
     */
    public CategoryVO read(int category_no);
    
    /**
     * 수정 처리
     * @param categoryVO
     * @return
     */
    public int update(CategoryVO categoryVO);
    
    /**
     * 삭제 처리 
     * @param category_no
     * @return
     */
    public int delete(int category_no);
    
    /**
     * 특정 그룹에 속한 레코드 갯수 산출
     * @param categorygrp_no
     * @return
     */
    public int count_by_categorygrpno(int categorygrp_no);
    
    /**
     * categorygrp_no가 같은 모든 레코드 삭제
     * @param categorygrp_no
     * @return
     */
    public int delete_by_categorygrpno(int categorygrp_no);
    
}