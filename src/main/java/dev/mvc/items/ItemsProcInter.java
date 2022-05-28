package dev.mvc.items;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dev.mvc.category.CategoryVO;

public interface ItemsProcInter {
    /**
     * 등록
     * 
     * @param itemsVO
     * @return
     */
    public int create(ItemsVO itemsVO);

    /**
     * 조회
     * 
     * @param itemsno
     * @return
     */
    public ItemsVO read(int itemsno);
    
    /**
     * 상품 정보 수정 처리
     * 
     * @param itemsVO
     * @return
     */
    public int product_update(ItemsVO itemsVO);
    
    /**
     * 특정 카테고리의 등록된 글목록
     * @return
     */
    public List<ItemsVO> list_by_category_no(int category_no);
    
    /**
     * 카테고리별 검색 목록
     * @param hashMap
     * @return
     */
    public List<ItemsVO> list_by_categoryno_search(HashMap<String, Object> hashMap);

    /**
     * 검색 + 페이징 목록
     * @param map
     * @return
     */
    public List<ItemsVO> list_by_categoryno_search_paging(HashMap<String, Object> map);
    
    /**
     * 페이지 목록 문자열 생성, Box 형태
     * @param categorygrp_no 카테고리번호
     * @param search_count 검색 갯수
     * @param now_page 현재 페이지, now_page는 1부터 시작
     * @param search_word 검색어
     * @return
     */
    public String pagingBox(int categorygrp_no, int search_count, int now_page, String search_word);
   
    /**
     * 카테고리별 검색 레코드 갯수
     * @param hashMap
     * @return
     */
    public int search_count(HashMap<String, Object> hashMap);
    
    /**
     * 텍스트 수정용 조회
     * @param itemsno
     * @return
     */
    public ItemsVO read_update_text(int itemsno);

    /**
     * 텍스트 정보 수정
     * @param itemsVO
     * @return
     */
    public int update_text(ItemsVO itemsVO);
    
    /**
     * 패스워드 체크
     * @param map
     * @return
     */
    public int password_check(HashMap<String, Object> map);
    
    /**
     * 파일 정보 수정
     * @param itemsVO
     * @return
     */
    public int update_file(ItemsVO itemsVO);
    
    /**
     * 삭제
     * @param itemsno
     * @return
     */
    public int delete(int itemsno);
    
    /**
     * 추천수 증가
     * @param itemsno
     * @return
     */
    public int update_recom(int itemsno);
    
    /**
     * 다수의 categoryno를 전달하여 관련 items 레코드 개수 산출
     * @param categorynos
     * @return
     */
    public int count_by_all_category_no(Map<String, Object> category_nos);
    
    /**
     * 인덱스 페이지에 출력할 추천수 내림차순 정렬
     * select id="main_list" resultType="dev.mvc.items.ItemsVO"
     * @return
     */
    public List<ItemsVO> main_list();
    
    /**
     * 글 수 증가
     * @param 
     * @return
     */ 
    public int increaseReplycnt(int itemsno);
   
    /**
     * 글 수 감소
     * @param 
     * @return
     */   
    public int decreaseReplycnt(int itemsno);
    
}



