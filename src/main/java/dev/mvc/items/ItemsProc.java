package dev.mvc.items;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.categorygrp.CategorygrpVO;
import dev.mvc.tool.Tool;

@Component("dev.mvc.items.ItemsProc")
public class ItemsProc implements ItemsProcInter {
    @Autowired
    private ItemsDAOInter itemsDAO;

    @Override
    public int create(ItemsVO itemsVO) {
        int cnt = this.itemsDAO.create(itemsVO);
        return cnt;
    }

    /**
     * 조회
     */
    @Override
    public ItemsVO read(int itemsno) {
        ItemsVO itemsVO = this.itemsDAO.read(itemsno);

        String item_name = itemsVO.getItem_name();
        String content = itemsVO.getContent();

//        item_name = Tool.convertChar(item_name); // 특수 문자 처리
//        content = Tool.convertChar(content);

        itemsVO.setItem_name(item_name);
        itemsVO.setContent(content);

        long size1 = itemsVO.getSize1();
        itemsVO.setSize1_label(Tool.unit(size1));

        return itemsVO;
    }
    
    @Override
    public int product_update(ItemsVO itemsVO) {
        int cnt = this.itemsDAO.product_update(itemsVO);
        return cnt;
    }
    
    @Override
    public List<ItemsVO> list_by_category_no(int category_no) {
        List<ItemsVO> list = this.itemsDAO.list_by_category_no(category_no);

        for (ItemsVO itemsVO : list) {
            String content = itemsVO.getContent();

            if (content.length() > 160) { // 160 초과이면 160자만 선택
                content = content.substring(0, 160) + "...";
                itemsVO.setContent(content);
            }

            String item_name = itemsVO.getItem_name();

            item_name = Tool.convertChar(item_name); // 특수 문자 처리
            content = Tool.convertChar(content);

            itemsVO.setItem_name(item_name);
            itemsVO.setContent(content);
        }

        return list;
    }
    
    @Override
    public List<ItemsVO> list_by_categoryno_search(HashMap<String, Object> hashMap) {
        List<ItemsVO> list = itemsDAO.list_by_categoryno_search(hashMap);

        for (ItemsVO itemsVO : list) { // 내용이 160자 이상이면 160자만 선택
            String content = itemsVO.getContent();
            if (content.length() > 160) {
                content = content.substring(0, 160) + "...";
                itemsVO.setContent(content);
            }
        }

        return list;
    }
    
    @Override
    public int search_count(HashMap<String, Object> hashMap) {
        int count = itemsDAO.search_count(hashMap);
        return count;
    }
    
    @Override
    public List<ItemsVO> list_by_categoryno_search_paging(HashMap<String, Object> map) {
        /*
         * 페이지당 10개의 레코드 출력 1 page: WHERE r >= 1 AND r <= 10 2 page: WHERE r >= 11 AND r
         * <= 20 3 page: WHERE r >= 21 AND r <= 30
         * 
         * 페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작 1 페이지 시작 rownum: now_page = 1, (1
         * - 1) * 10 --> 0 2 페이지 시작 rownum: now_page = 2, (2 - 1) * 10 --> 10 3 페이지 시작
         * rownum: now_page = 3, (3 - 1) * 10 --> 20
         */
        int begin_of_page = ((Integer) map.get("now_page") - 1) * Items.RECORD_PER_PAGE;

        // 시작 rownum 결정
        // 1 페이지 = 0 + 1: 1
        // 2 페이지 = 10 + 1: 11
        // 3 페이지 = 20 + 1: 21
        int start_num = begin_of_page + 1;

        // 종료 rownum
        // 1 페이지 = 0 + 10: 10
        // 2 페이지 = 0 + 20: 20
        // 3 페이지 = 0 + 30: 30
        int end_num = begin_of_page + Items.RECORD_PER_PAGE;
        /*
         * 1 페이지: WHERE r >= 1 AND r <= 10 2 페이지: WHERE r >= 11 AND r <= 20 3 페이지: WHERE
         * r >= 21 AND r <= 30
         */
        map.put("start_num", start_num);
        map.put("end_num", end_num);

        List<ItemsVO> list = this.itemsDAO.list_by_categoryno_search_paging(map);

        for (ItemsVO itemsVO : list) { // 내용이 160자 이상이면 160자만 선택
            String content = itemsVO.getContent();
            if (content.length() > 160) {
                content = content.substring(0, 160) + "...";
                itemsVO.setContent(content);
            }

            String item_name = Tool.convertChar(itemsVO.getItem_name()); // 특수 문자 변환
            itemsVO.setItem_name(item_name);

            content = Tool.convertChar(content);
            itemsVO.setContent(content);
        }

        return list;
    }

    /**
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
     * 18 19 20 [다음]
     *
     * @param list_file    목록 파일명
     * @param category_no       카테고리번호
     * @param search_count 검색(전체) 레코드수
     * @param now_page     현재 페이지
     * @param search_word         검색어
     * @return 페이징 생성 문자열
     */
    @Override
    public String pagingBox(int category_no, int search_count, int now_page, String search_word) {
        int total_page = (int) (Math.ceil((double) search_count / Items.RECORD_PER_PAGE)); // 전체 페이지 수
        int total_grp = (int) (Math.ceil((double) total_page / Items.PAGE_PER_BLOCK)); // 전체 그룹 수
        int now_grp = (int) (Math.ceil((double) now_page / Items.PAGE_PER_BLOCK)); // 현재 그룹 번호

        // 1 group: 1, 2, 3 ... 9, 10
        // 2 group: 11, 12 ... 19, 20
        // 3 group: 21, 22 ... 29, 30
        int start_page = ((now_grp - 1) * Items.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작 페이지
        int end_page = (now_grp * Items.PAGE_PER_BLOCK); // 특정 그룹의 마지막 페이지

        StringBuffer str = new StringBuffer();

        str.append("<style type='text/css'>");
        str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
        str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
        str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}");
        str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
        str.append("  .span_box_1{");
        str.append("    text-align: center;");
        str.append("    font-size: 1em;");
        str.append("    border: 1px;");
        str.append("    border-style: solid;");
        str.append("    border-color: #cccccc;");
        str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
        str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
        str.append("  }");
        str.append("  .span_box_2{");
        str.append("    text-align: center;");
        str.append("    background-color: #668db4;");
        str.append("    color: #FFFFFF;");
        str.append("    font-size: 1em;");
        str.append("    border: 1px;");
        str.append("    border-style: solid;");
        str.append("    border-color: #cccccc;");
        str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
        str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
        str.append("  }");
        str.append("</style>");
        str.append("<DIV id='paging'>");
//      str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

        // 이전 10개 페이지로 이동
        // now_grp: 1 (1 ~ 10 page)
        // now_grp: 2 (11 ~ 20 page)
        // now_grp: 3 (21 ~ 30 page)
        // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
        // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
        int _now_page = (now_grp - 1) * Items.PAGE_PER_BLOCK;
        if (now_grp >= 2) { // 현재 그룹번호가 2이상이면 페이지수가 11페이 이상임으로 이전 그룹으로 갈수 있는 링크 생성
            str.append("<span class='span_box_1'><A href='" + Items.LIST_FILE + "?&search_word=" + search_word + "&now_page="
                    + _now_page + "&category_no=" + category_no + "'>이전</A></span>");
        }

        // 중앙의 페이지 목록
        for (int i = start_page; i <= end_page; i++) {
            if (i > total_page) { // 마지막 페이지를 넘어갔다면 페이 출력 종료
                break;
            }

            if (now_page == i) { // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
                str.append("<span class='span_box_2'>" + i + "</span>"); // 현재 페이지, 강조
            } else {
                // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
                str.append("<span class='span_box_1'><A href='" + Items.LIST_FILE + "?search_word=" + search_word + "&now_page="
                        + i + "&category_no=" + category_no + "'>" + i + "</A></span>");
            }
        }

        // 10개 다음 페이지로 이동
        // nowGrp: 1 (1 ~ 10 page), nowGrp: 2 (11 ~ 20 page), nowGrp: 3 (21 ~ 30 page)
        // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
        // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
        // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
        _now_page = (now_grp * Items.PAGE_PER_BLOCK) + 1; // 최대 페이지수 + 1
        if (now_grp < total_grp) {
            str.append("<span class='span_box_1'><A href='" + Items.LIST_FILE + "?&search_word=" + search_word + "&now_page="
                    + _now_page + "&category_no=" + category_no + "'>다음</A></span>");
        }
        str.append("</DIV>");

        return str.toString();
    }
    
    @Override
    public ItemsVO read_update_text(int itemsno) {
        ItemsVO itemsVO = this.itemsDAO.read(itemsno);
        return itemsVO;
    }
    
    @Override
    public int update_text(ItemsVO itemsVO) {
        int cnt = this.itemsDAO.update_text(itemsVO);
        return cnt;
    }

    @Override
    public int password_check(HashMap<String, Object> map) {
        int cnt = this.itemsDAO.password_check(map);
        return cnt;
    }

    @Override
    public int update_file(ItemsVO itemsVO) {
        // System.out.println("-> ContentsProc update_file executed.");
        // System.out.println("-> ContentsProc getItemsno(): " + itemsVO.getItemsno());
        int cnt = this.itemsDAO.update_file(itemsVO);
        // System.out.println("-> ItemsProc cnt: " + cnt);
        
        return cnt;
    }
    
    @Override
    public int delete(int itemsno) {
      int cnt = this.itemsDAO.delete(itemsno);
      return cnt;
    }
    
    @Override
    public int update_recom(int itemsno) {
      int cnt = this.itemsDAO.update_recom(itemsno);
      return cnt;
    }
    
    @Override
    public int count_by_all_category_no(Map<String, Object> category_nos) {
      int cnt = this.itemsDAO.count_by_all_category_no(category_nos);
      return cnt;
    }
    
    @Override
    public List<ItemsVO> main_list() {
      List<ItemsVO> list = this.itemsDAO.main_list();
      return list;
    }
    
    @Override
    public int increaseReplycnt(int itemsno) {
      int count = itemsDAO.increaseReplycnt(itemsno);
      return count;
    }

    @Override
    public int decreaseReplycnt(int itemsno) {
      int count = itemsDAO.decreaseReplycnt(itemsno);
      return count;
    }
    
    
}


