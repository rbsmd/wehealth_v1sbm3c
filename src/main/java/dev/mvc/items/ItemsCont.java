package dev.mvc.items;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;
import dev.mvc.category.CategoryVO;
import dev.mvc.categorygrp.CategorygrpProcInter;
import dev.mvc.categorygrp.CategorygrpVO;
import dev.mvc.order_item.Order_itemProcInter;
//import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ItemsCont {
    @Autowired
    @Qualifier("dev.mvc.categorygrp.CategorygrpProc")
    private CategorygrpProcInter categorygrpProc;

    @Autowired
    @Qualifier("dev.mvc.category.CategoryProc")
    private CategoryProcInter categoryProc;

    @Autowired
    @Qualifier("dev.mvc.items.ItemsProc")
    private ItemsProcInter itemsProc;
    
    @Autowired
    @Qualifier("dev.mvc.order_item.Order_itemProc")
    private Order_itemProcInter order_itemProc;
    
    /** 업로드 파일 절대 경로 */
    private String uploadDir = Items.getUploadDir();

    public ItemsCont() {
        System.out.println("-> ItemsCont created.");
    }

    /**
     * 새로고침 방지
     * 
     * @return
     */
    @RequestMapping(value = "/items/msg.do", method = RequestMethod.GET)
    public ModelAndView msg(String url) {
        ModelAndView mav = new ModelAndView();

        mav.setViewName(url); // forward

        return mav; // forward
    }

    /**
     * 등록폼 사전 준비된 레코드: 관리자 1번, category_no 1번, categrpgory_no 1번을 사용하는 경우 테스트 URL
     * http://localhost:9091/items/create.do?category_no=1
     * 
     * @return
     */
    @RequestMapping(value = "/items/create.do", method = RequestMethod.GET)
    public ModelAndView create(int category_no) {
        ModelAndView mav = new ModelAndView();

        CategoryVO categoryVO = this.categoryProc.read(category_no);
        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());

        mav.addObject("categoryVO", categoryVO);
        mav.addObject("categorygrpVO", categorygrpVO);

        mav.setViewName("/items/create"); // /webapp/WEB-INF/views/items/create.jsp
        // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
        // mav.addObject("content", content);

        return mav; // forward
    }

    /**
     * 등록 처리 http://localhost:9091/items/create.do
     * 
     * @return
     */
    @RequestMapping(value = "/items/create.do", method = RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, ItemsVO itemsVO) {
        ModelAndView mav = new ModelAndView();

        // ------------------------------------------------------------------------------
        // 파일 전송 코드 시작
        // ------------------------------------------------------------------------------
        String file1 = ""; // 원본 파일명 image
        String file1saved = ""; // 저장된 파일명, image
        String thumb1 = ""; // preview image
        String uploadDir = this.uploadDir; // 파일 업로드 경로
        
        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF'
        // value='' placeholder="파일 선택">
        MultipartFile mf = itemsVO.getFile1MF();

        file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        // System.out.println("-> file1: " + file1);

        long size1 = mf.getSize(); // 파일 크기

        if (size1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
            file1saved = Upload.saveFileSpring(mf, uploadDir);

            if (Tool.isImage(file1saved)) { // 이미지인지 검사
                // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                thumb1 = Tool.preview(uploadDir, file1saved, 200, 150);
            }

        }

        itemsVO.setFile1(file1);
        itemsVO.setFile1saved(file1saved);
        itemsVO.setThumb1(thumb1);
        itemsVO.setSize1(size1);
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------

        // Call By Reference: 메모리 공유, Hashcode 전달
        int cnt = this.itemsProc.create(itemsVO);

        // ------------------------------------------------------------------------------
        // 연속 입력을위한 PK의 return
        // ------------------------------------------------------------------------------
        System.out.println("-> itemsno: " + itemsVO.getItemsno());
        mav.addObject("itemsno", itemsVO.getItemsno()); // redirect parameter 적용
        // ------------------------------------------------------------------------------

        if (cnt == 1) {
            mav.addObject("code", "create_success");
            // categoryProc.increaseCnt(itemsVO.getCategory_no()); // 글수 증가
        } else {
            mav.addObject("code", "create_fail");
        }
        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

        // System.out.println("--> category_no: " + itemsVO.getCategory_no());
        // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
        mav.addObject("category_no", itemsVO.getCategory_no()); // redirect parameter 적용
        // mav.addObject("url", "/items/msg"); // msg.jsp, redirect parameter 적용

        // 추가적인 상품 정보 입력 유도
        mav.addObject("url", "/items/msg"); // msg.jsp, redirect parameter 적용

        mav.setViewName("redirect:/items/msg.do");

        return mav; // forward
    }

    /**
     * 상품 정보 수정 폼 사전 준비된 레코드: 관리자 1번, cateno 1번, categrpno 1번을 사용하는 경우 테스트 URL
     * http://localhost:9091/items/create.do?category_no=1
     * 
     * @return
     */
    @RequestMapping(value = "/items/product_update.do", method = RequestMethod.GET)
    public ModelAndView product_update(int category_no, int itemsno) {
        ModelAndView mav = new ModelAndView();

        CategoryVO categoryVO = this.categoryProc.read(category_no);
        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
        ItemsVO itemsVO = this.itemsProc.read(itemsno);

        mav.addObject("categoryVO", categoryVO);
        mav.addObject("categorygrpVO", categorygrpVO);
        mav.addObject("itemsVO", itemsVO);

        mav.setViewName("/items/product_update"); // /views/items/product_update.jsp
        // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
        // mav.addObject("content", content);

        return mav; // forward
    }
    
    /**
     * 상품 정보 수정 처리 http://localhost:9091/items/product_update.do
     * 
     * @return
     */
    @RequestMapping(value = "/items/product_update.do", method = RequestMethod.POST)
    public ModelAndView product_update(ItemsVO itemsVO) {
        ModelAndView mav = new ModelAndView();

        // Call By Reference: 메모리 공유, Hashcode 전달
        int cnt = this.itemsProc.product_update(itemsVO);

        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
        mav.addObject("category_no", itemsVO.getCategory_no()); // redirect parameter 적용

        // 연속 입력 지원용 변수, Call By Reference에 기반하여 contentsno를 전달 받음
        mav.addObject("itemsno", itemsVO.getItemsno());

        mav.addObject("url", "/items/msg"); // msg.jsp

        if (cnt == 1) {
            mav.addObject("code", "product_success");
        } else {
            mav.addObject("code", "product_fail");
        }

        mav.setViewName("redirect:/items/msg.do");

        return mav; // forward
    }
    
    /**
     * 카테고리별 목록 http://localhost:9091/items/list_by_category_no.do?category_no=1
     * 
     * @return
     */
    @RequestMapping(value = "/items/list_by_category_no.do", method = RequestMethod.GET)
    public ModelAndView list_by_category_no(int category_no) {
        ModelAndView mav = new ModelAndView(); 

        // 테이블 이미지 기반, /webapp/items/list_by_category_no.jsp
        mav.setViewName("/items/list_by_category_no");

        CategoryVO categoryVO = this.categoryProc.read(category_no);
        mav.addObject("categoryVO", categoryVO);

        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
        mav.addObject("categorygrpVO", categorygrpVO);

        List<ItemsVO> list = this.itemsProc.list_by_category_no(category_no);
        mav.addObject("list", list);

        return mav; // forward
    }
    
//    // http://localhost:9091/items/read.do?itemsno=1
//    /**
//     * 조회
//     * @return
//     */
//    @RequestMapping(value="/items/read.do", method=RequestMethod.GET )
//    public ModelAndView read(int itemsno) {
//      ModelAndView mav = new ModelAndView();
//
//      ItemsVO itemsVO = this.itemsProc.read(itemsno);
//      mav.addObject("itemsVO", itemsVO); // request.setAttribute("itemsVO", itemsVO);
//
//      CategoryVO categoryVO = this.categoryProc.read(itemsVO.getCategory_no());
//      mav.addObject("categoryVO", categoryVO); 
//
//      CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
//      mav.addObject("categorygrpVO", categorygrpVO); 
//      
//      mav.setViewName("/items/read"); // /WEB-INF/views/items/read.jsp
//          
//      return mav;
//    }
    
    /**
     * 목록 + 검색 지원
     * http://localhost:9090/items/list_by_categoryno_search.do?category_no=1
     * @param category_no
     * @param search_word
     * @return
     */
      @RequestMapping(value = "/items/list_by_categoryno_search.do", method = RequestMethod.GET)
      public ModelAndView list_by_categoryno_search(@RequestParam(value="category_no", defaultValue="1") int category_no,
                                                                   @RequestParam(value="search_word", defaultValue="") String search_word ) {
      
      ModelAndView mav = new ModelAndView(); 
           
      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용 
      HashMap<String, Object> map = new HashMap<String, Object>(); 
      map.put("category_no", category_no); // #{category_no}
      map.put("search_word", search_word); // #{search_word}
      
      // 검색 목록 
      List<ItemsVO> list = itemsProc.list_by_categoryno_search(map);
      mav.addObject("list", list);
      
      // 검색된 레코드 갯수 
      int search_count = itemsProc.search_count(map);
      mav.addObject("search_count", search_count);
      
      CategoryVO categoryVO = categoryProc.read(category_no); 
      mav.addObject("categoryVO", categoryVO);
      
      CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
      mav.addObject("categorygrpVO", categorygrpVO);
      
      mav.setViewName("/items/list_by_categoryno_search");   // /items/list_by_categoryno_search.jsp
      
      return mav; 
    }
     
//    /**
//    * 목록 + 검색 + 페이징 지원
//    * http://localhost:9090/items/list_by_categoryno_search_paging.do?category_no=1&search_word=런닝&now_page=1
//    * 
//    * @param category_no
//    * @param search_word
//    * @param now_page
//    * @return
//    */
//   @RequestMapping(value = "/items/list_by_categoryno_search_paging.do", method = RequestMethod.GET)
//   public ModelAndView list_by_cateno_search_paging(@RequestParam(value = "category_no", defaultValue = "2") int category_no,
//                                                                          @RequestParam(value = "search_word", defaultValue = "") String search_word,
//                                                                          @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
//     System.out.println("-> now_page: " + now_page);
//
//     ModelAndView mav = new ModelAndView();
//
//     // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
//     HashMap<String, Object> map = new HashMap<String, Object>();
//     map.put("category_no", category_no); // #{category_no}
//     map.put("search_word", search_word); // #{search_word}
//     map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용
//
//     // 검색 목록
//     List<ItemsVO> list = itemsProc.list_by_categoryno_search_paging(map);
//     mav.addObject("list", list);
//
//     // 검색된 레코드 갯수
//     int search_count = itemsProc.search_count(map);
//     mav.addObject("search_count", search_count);
//
//     CategoryVO categoryVO = categoryProc.read(category_no);
//     mav.addObject("categoryVO", categoryVO);
//
//     CategorygrpVO categorygrpVO = categorygrpProc.read(categoryVO.getCategorygrp_no());
//     mav.addObject("categorygrpVO", categorygrpVO);
//
//     /*
//      * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
//      * 18 19 20 [다음]
//      * @param category_no 카테고리번호
//      * @param search_count 검색(전체) 레코드수
//      * @param now_page 현재 페이지
//      * @param search_word 검색어
//      * @return 페이징 생성 문자열
//      */
//     String paging = itemsProc.pagingBox(category_no, search_count, now_page, search_word);
//     mav.addObject("paging", paging);
//
//     mav.addObject("now_page", now_page);
//
//     // /items/list_by_categoryno_table_img1_search_paging.jsp
//     mav.setViewName("/items/list_by_categoryno_search_paging");
//
//     return mav;
//   }
   
   /**
    * 목록 + 검색 + 페이징 + Cookie 지원
    * http://localhost:9091/contents/list_by_categoryno_search_paging.do?cateno=1&word=스위스&now_page=1
    * 
    * @param category_no
    * @param search_word
    * @param now_page
    * @return
    */
   @RequestMapping(value = "/items/list_by_categoryno_search_paging.do", method = RequestMethod.GET)
   public ModelAndView list_by_categoryno_search_paging_cookie(
       @RequestParam(value = "category_no", defaultValue = "1") int category_no,
       @RequestParam(value = "search_word", defaultValue = "") String search_word,
       @RequestParam(value = "now_page", defaultValue = "1") int now_page,
       HttpServletRequest request) {
     System.out.println("-> list_by_categoryno_search_paging now_page: " + now_page);

     ModelAndView mav = new ModelAndView();

     // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("category_no", category_no); // #{category_no}
     map.put("search_word", search_word); // #{search_word}
     map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

     // 검색 목록
     List<ItemsVO> list = itemsProc.list_by_categoryno_search_paging(map);
     mav.addObject("list", list);

     // 검색된 레코드 갯수
     int search_count = itemsProc.search_count(map);
     mav.addObject("search_count", search_count);

     CategoryVO categoryVO = categoryProc.read(category_no);
     mav.addObject("categoryVO", categoryVO);

     CategorygrpVO categorygrpVO = categorygrpProc.read(categoryVO.getCategorygrp_no());
     mav.addObject("categorygrpVO", categorygrpVO);

     /*
      * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
      * 18 19 20 [다음]
      * @param categoryno 카테고리번호
      * @param search_count 검색(전체) 레코드수
      * @param now_page 현재 페이지
      * @param search_word 검색어
      * @return 페이징 생성 문자열
      */
     String paging = itemsProc.pagingBox(category_no, search_count, now_page, search_word);
    
     mav.addObject("paging", paging);

     mav.addObject("now_page", now_page);

     // /views/contents/list_by_cateno_search_paging_cookie.jsp
     mav.setViewName("/items/list_by_categoryno_search_paging_cookie");

     // -------------------------------------------------------------------------------
     // 쇼핑 카트 장바구니에 상품 등록전 로그인 폼 출력 관련 쿠기  
     // -------------------------------------------------------------------------------
     Cookie[] cookies = request.getCookies();
     Cookie cookie = null;

     String ck_id = ""; // id 저장
     String ck_id_save = ""; // id 저장 여부를 체크
     String ck_passwd = ""; // passwd 저장
     String ck_passwd_save = ""; // passwd 저장 여부를 체크

     if (cookies != null) {  // Cookie 변수가 있다면
       for (int i=0; i < cookies.length; i++){
         cookie = cookies[i]; // 쿠키 객체 추출
         
         if (cookie.getName().equals("ck_id")){
           ck_id = cookie.getValue();                                 // Cookie에 저장된 id
         }else if(cookie.getName().equals("ck_id_save")){
           ck_id_save = cookie.getValue();                          // Cookie에 id를 저장 할 것인지의 여부, Y, N
         }else if (cookie.getName().equals("ck_passwd")){
           ck_passwd = cookie.getValue();                          // Cookie에 저장된 password
         }else if(cookie.getName().equals("ck_passwd_save")){
           ck_passwd_save = cookie.getValue();                  // Cookie에 password를 저장 할 것인지의 여부, Y, N
         }
       }
     }
     
     System.out.println("-> ck_id: " + ck_id);
     
     mav.addObject("ck_id", ck_id); 
     mav.addObject("ck_id_save", ck_id_save);
     mav.addObject("ck_passwd", ck_passwd);
     mav.addObject("ck_passwd_save", ck_passwd_save);
     // -------------------------------------------------------------------------------
     
     return mav;
   }
      
      /**
       * Grid 형태의 화면 구성 http://localhost:9091/items/list_by_categoryno_grid.do
       * 
       * @return
       */
      @RequestMapping(value = "/items/list_by_categoryno_grid.do", method = RequestMethod.GET)
      public ModelAndView list_by_categoryno_grid(int category_no) {
        ModelAndView mav = new ModelAndView();
        
        CategoryVO categoryVO = this.categoryProc.read(category_no);
        mav.addObject("categoryVO", categoryVO);
        
        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
        mav.addObject("categorygrpVO", categorygrpVO);
        
        List<ItemsVO> list = this.itemsProc.list_by_category_no(category_no);
        mav.addObject("list", list);

        // 테이블 이미지 기반, /webapp/items/list_by_categoryno_grid.jsp
        mav.setViewName("/items/list_by_categoryno_grid");

        return mav; // forward
      }
      
      /**
       * 수정 폼
       * http://localhost:9091/items/update_text.do?itemsno=1
       * 
       * @return
       */
      @RequestMapping(value = "/items/update_text.do", method = RequestMethod.GET)
      public ModelAndView update_text(int itemsno) {
        ModelAndView mav = new ModelAndView();
        
        ItemsVO itemsVO = this.itemsProc.read_update_text(itemsno);
        CategoryVO categoryVO = this.categoryProc.read(itemsVO.getCategory_no());
        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
        
        mav.addObject("itemsVO", itemsVO);
        mav.addObject("categoryVO", categoryVO);
        mav.addObject("categorygrpVO", categorygrpVO);
        
        mav.setViewName("/items/update_text"); // /WEB-INF/views/items/update_text.jsp
        // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
        // mav.addObject("content", content);

        return mav; // forward
      }

      /**
       * 수정 처리
       * http://localhost:9091/items/update_text.do?itemsno=1
       * 
       * @return
       */
      @RequestMapping(value = "/items/update_text.do", method = RequestMethod.POST)
      public ModelAndView update_text(ItemsVO itemsVO,
                                                      @RequestParam(value = "search_word", defaultValue = "") String search_word,
                                                      @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
        ModelAndView mav = new ModelAndView();
        
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("itemsno", itemsVO.getItemsno());
        map.put("password", itemsVO.getPassword());
        
        int cnt = 0;
        int password_cnt = this.itemsProc.password_check(map);
        if (password_cnt == 1) {
            cnt = this.itemsProc.update_text(itemsVO); // 수정 처리
            
            mav.addObject("now_page", now_page);
            mav.addObject("itemsno", itemsVO.getItemsno());
            mav.setViewName("redirect:/items/read.do");             
        } else {
            mav.addObject("cnt", cnt);
            mav.addObject("code", "password_fail");
            mav.setViewName("redirect:/items/msg.do");
        }

        return mav; // forward
      }
      
      /**
       * 파일 수정 폼
       * http://localhost:9091/items/update_file.do?itemsno=1
       * 
       * @return
       */
      @RequestMapping(value = "/items/update_file.do", method = RequestMethod.GET)
      public ModelAndView update_file(int itemsno) {
        ModelAndView mav = new ModelAndView();
        
        ItemsVO itemsVO = this.itemsProc.read(itemsno);
        CategoryVO categoryVO = this.categoryProc.read(itemsVO.getCategory_no());
        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
        
        mav.addObject("itemsVO", itemsVO);
        mav.addObject("categoryVO", categoryVO);
        mav.addObject("categorygrpVO", categorygrpVO);
        
        mav.setViewName("/items/update_file"); // /WEB-INF/views/items/update_file.jsp

        return mav; // forward
      }

      /**
       * 파일 수정 처리 http://localhost:9091/items/update_file.do
       * 
       * @return
       */
      @RequestMapping(value = "/items/update_file.do", method = RequestMethod.POST)
      public ModelAndView update_file(HttpServletRequest request, ItemsVO itemsVO, 
                                                      @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
        ModelAndView mav = new ModelAndView();
        String uploadDir = this.uploadDir; // 파일 업로드 경로        
        
        // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
        ItemsVO itemsVO_old = itemsProc.read(itemsVO.getItemsno());
        
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("itemsno", itemsVO.getItemsno());
        map.put("password", itemsVO.getPassword());
        
        int cnt = 0;
        int password_cnt = this.itemsProc.password_check(map);
        if (password_cnt == 1) { // 패스워드 일치 -> 등록된 파일 삭제 -> 신규 파일 등록
            // -------------------------------------------------------------------
            // 파일 삭제 코드 시작
            // -------------------------------------------------------------------
//            System.out.println("itemsno: " + vo.getItemsno());
//            System.out.println("file1: " + vo.getFile1());
            
            String file1saved = itemsVO_old.getFile1saved();
            String thumb1 = itemsVO_old.getThumb1();
            long size1 = 0;
            boolean sw = false;
            
            // 완성된 경로 F:/kd1/ws_frame/wehealth_v1sbm3a/src/main/resources/static/items/storage/
            // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/items/storage/"; // 절대 경로

            sw = Tool.deleteFile(uploadDir, file1saved);  // Folder에서 1건의 파일 삭제
            sw = Tool.deleteFile(uploadDir, thumb1);     // Folder에서 1건의 파일 삭제
            // System.out.println("sw: " + sw);
            // -------------------------------------------------------------------
            // 파일 삭제 종료 시작
            // -------------------------------------------------------------------
            
            // -------------------------------------------------------------------
            // 파일 전송 코드 시작
            // -------------------------------------------------------------------
            String file1 = "";          // 원본 파일명 image

            // 완성된 경로 F:/kd1/ws_frame/rwehealth_v1sbm3a/src/main/resources/static/items/storage/
            // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/items/storage/"; // 절대 경로
            
            // 전송 파일이 없어도 fnamesMF 객체가 생성됨.
            // <input type='file' class="form-control" name='file1MF' id='file1MF' 
            //           value='' placeholder="파일 선택">
            MultipartFile mf = itemsVO.getFile1MF();
            
            file1 = mf.getOriginalFilename(); // 원본 파일명
            size1 = mf.getSize();  // 파일 크기
            
            if (size1 > 0) { // 파일 크기 체크
              // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
              file1saved = Upload.saveFileSpring(mf, uploadDir); 
              
              if (Tool.isImage(file1saved)) { // 이미지인지 검사
                // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
                thumb1 = Tool.preview(uploadDir, file1saved, 250, 200); 
              }
              
            } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
                file1="";
                file1saved="";
                thumb1="";
                size1=0;
            }
            
            itemsVO.setFile1(file1);
            itemsVO.setFile1saved(file1saved);
            itemsVO.setThumb1(thumb1);
            itemsVO.setSize1(size1);
            // -------------------------------------------------------------------
            // 파일 전송 코드 종료
            // -------------------------------------------------------------------
            
            // Call By Reference: 메모리 공유, Hashcode 전달
            cnt = this.itemsProc.update_file(itemsVO);
            System.out.println("-> cnt: " + cnt);
            
            mav.addObject("now_page", now_page);
            mav.addObject("itemsno", itemsVO.getItemsno());
            mav.setViewName("redirect:/items/read.do"); 
            
        } else { // 패스워드 오류
            mav.addObject("cnt", cnt);
            mav.addObject("code", "password_fail");
            mav.setViewName("redirect:/items/msg.do");
        }

        mav.addObject("categoryno", itemsVO_old.getCategory_no());
        System.out.println("-> categoryno: " + itemsVO_old.getCategory_no());
        
        return mav; // forward
      }   
      
      /**
       * 삭제 폼
       * @param itemsno
       * @return
       */
      @RequestMapping(value="/items/delete.do", method=RequestMethod.GET )
      public ModelAndView delete(int itemsno) { 
        ModelAndView mav = new  ModelAndView();
        
        // 삭제할 정보를 조회하여 확인
        ItemsVO itemsVO = this.itemsProc.read(itemsno);
        CategoryVO categoryVO = this.categoryProc.read(itemsVO.getCategory_no());
        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
        
        mav.addObject("itemsVO", itemsVO);
        mav.addObject("categoryVO", categoryVO);
        mav.addObject("categorygrpVO", categorygrpVO);
        
        mav.setViewName("/items/delete");  // items/delete.jsp
        
        return mav; 
      }
      
      /**
       * 삭제 처리 http://localhost:9091/items/delete.do
       * 
       * @return
       */
      @RequestMapping(value = "/items/delete.do", method = RequestMethod.POST)
      public ModelAndView delete(HttpServletRequest request, ItemsVO itemsVO, 
                                              int now_page,
                                              @RequestParam(value="search_word", defaultValue="") String search_word) {
        ModelAndView mav = new ModelAndView();
        String uploadDir = this.uploadDir; // 파일 업로드 경로
        
        int itemsno = itemsVO.getItemsno();
        
        HashMap<String, Object> password_map = new HashMap<String, Object>();
        password_map.put("itemsno", itemsVO.getItemsno());
        password_map.put("password", itemsVO.getPassword());
        
        int cnt = 0;
        int password_cnt = this.itemsProc.password_check(password_map);
        
        int order_item_cnt = 1;
        order_item_cnt = this.order_itemProc.order_item_cnt(itemsno);
        
        if (password_cnt ==1) { // 패스워드 일치 -> 등록된 파일 삭제 -> 신규 파일 등록
            try {
                if(order_item_cnt >= 1) {
                    mav.addObject("msg", "child_record_found");
                    mav.setViewName("redirect:/items/msg.do");
                } else {
                 // -------------------------------------------------------------------
                    // 파일 삭제 코드 시작
                    // -------------------------------------------------------------------
                    // 삭제할 파일 정보를 읽어옴.
                    ItemsVO vo = itemsProc.read(itemsno);
//                    System.out.println("itemsno: " + vo.getItemsno());
//                    System.out.println("file1: " + vo.getFile1());
                    
                    String file1saved = vo.getFile1saved();
                    String thumb1 = vo.getThumb1();
                    long size1 = 0;
                    boolean sw = false;
                    
                    sw = Tool.deleteFile(uploadDir, file1saved);  // Folder에서 1건의 파일 삭제
                    sw = Tool.deleteFile(uploadDir, thumb1);     // Folder에서 1건의 파일 삭제
                    // System.out.println("sw: " + sw);
                    // -------------------------------------------------------------------
                    // 파일 삭제 종료 시작
                    // -------------------------------------------------------------------
                    
                    cnt = this.itemsProc.delete(itemsno); // DBMS 삭제
                    
                    // -------------------------------------------------------------------------------------
                    System.out.println("-> category_no: " + vo.getCategory_no());
                    System.out.println("-> search_word: " + search_word);
                    
                    // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
                    HashMap<String, Object> page_map = new HashMap<String, Object>();
                    page_map.put("category_no", vo.getCategory_no());
                    page_map.put("search_word", search_word);
                    // 10번째 레코드를 삭제후
                    // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
                    // 페이지수를 4 -> 3으로 감소 시켜야함.
                    if (itemsProc.search_count(page_map) % Items.RECORD_PER_PAGE == 0) {
                      now_page = now_page - 1;
                      if (now_page < 1) {
                        now_page = 1; // 시작 페이지
                      }
                    }
                    // -------------------------------------------------------------------------------------
                    
                    mav.addObject("now_page", now_page);
                    mav.setViewName("redirect:/items/list_by_categoryno_search_paging.do"); 
                }
             
            } catch(Exception e) {
                mav.addObject("msg", "child_record_found");
                mav.setViewName("redirect:/items/msg.do");
            }

        } else { // 패스워드 오류
            mav.addObject("cnt", cnt);
            mav.addObject("code", "password_fail");
            mav.setViewName("redirect:/items/msg.do");
        }
        mav.addObject("category_no", itemsVO.getCategory_no());
        System.out.println("-> category_no: " + itemsVO.getCategory_no());
        
        return mav; // forward
      }   
      
      /**
       * 추천수 Ajax 수정 처리
       * http://localhost:9091/items/update_recom_ajax.do?itemsno=1
       * 
       * @return
       */
      @RequestMapping(value = "/items/update_recom_ajax.do", 
                               method = RequestMethod.POST)
      @ResponseBody
      public String update_recom_ajax(int itemsno) {
        try {
          Thread.sleep(3000);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }

        int cnt = this.itemsProc.update_recom(itemsno); // 추천수 증가
        int recom = this.itemsProc.read(itemsno).getRecom_cnt(); // 새로운 추천수 읽음
            
        JSONObject json = new JSONObject();
        json.put("cnt", cnt);
        json.put("recom", recom);
        
        return json.toString();
      }
      
      /**
       * 다수의 category_no를 전달하여 관련 items 레코드 개수 산출
       * @param category_nos
       * @return
       */
      @RequestMapping(value="/items/count_by_all_category_no.do", method=RequestMethod.GET)
      @ResponseBody
      public String count_by_all_category_no(int categorygrp_no) {
        int cnt = 0;
        List<Integer> category_nos_list = new ArrayList<Integer>();
        
        List<CategoryVO> list = this.categoryProc.list_by_categorygrpno(categorygrp_no);
        for(CategoryVO categoryVO : list) {
            category_nos_list.add(categoryVO.getCategory_no());
        }
        
        Map<String, Object> category_nos_map = new HashMap<String, Object>();
        category_nos_map.put("category_nos_list", category_nos_list);
        
        cnt = this.itemsProc.count_by_all_category_no(category_nos_map);

        JSONObject json = new JSONObject();
        json.put("cnt", cnt);
        
        return json.toString(); 
      }
      
      //http://localhost:9091/items/read.do
      /**
       * 조회
       * @return
       */
      @RequestMapping(value="/items/read.do", method=RequestMethod.GET )
      public ModelAndView read_ajax(HttpServletRequest request, int itemsno) {
//         public ModelAndView read(int itemsno, int now_page) {
//         System.out.println("-> now_page: " + now_page);
        
        ModelAndView mav = new ModelAndView();
        
        ItemsVO itemsVO = this.itemsProc.read(itemsno);
        mav.addObject("itemsVO", itemsVO); // request.setAttribute("contentsVO", contentsVO);

        CategoryVO categoryVO = this.categoryProc.read(itemsVO.getCategory_no());
        mav.addObject("categoryVO", categoryVO); 

        CategorygrpVO categorygrpVO = this.categorygrpProc.read(categoryVO.getCategorygrp_no());
        mav.addObject("categorygrpVO", categorygrpVO); 
        
       // 단순 read
        // mav.setViewName("/items/read"); // /WEB-INF/views/items/read.jsp
        
        // 쇼핑 기능 추가
        // mav.setViewName("/items/read_cookie"); // /WEB-INF/views/items/read_cookie.jsp
        
        // 댓글 기능 추가 
        // mav.setViewName("/items/read_cookie_reply"); // /WEB-INF/views/items/read_cookie_reply.jsp

        // 댓글 + 더보기 버튼 기능 추가 
        mav.setViewName("/items/read_cookie_reply_add"); // /WEB-INF/views/items/read_cookie_reply_add.jsp
        
        // -------------------------------------------------------------------------------
        // 쇼핑 카트 장바구니에 상품 등록전 로그인 폼 출력 관련 쿠기  
        // -------------------------------------------------------------------------------
        Cookie[] cookies = request.getCookies();
        Cookie cookie = null;

        String ck_id = ""; // id 저장
        String ck_id_save = ""; // id 저장 여부를 체크
        String ck_passwd = ""; // passwd 저장
        String ck_passwd_save = ""; // passwd 저장 여부를 체크

        if (cookies != null) {  // Cookie 변수가 있다면
          for (int i=0; i < cookies.length; i++){
            cookie = cookies[i]; // 쿠키 객체 추출
            
            if (cookie.getName().equals("ck_id")){
              ck_id = cookie.getValue();                                 // Cookie에 저장된 id
            }else if(cookie.getName().equals("ck_id_save")){
              ck_id_save = cookie.getValue();                          // Cookie에 id를 저장 할 것인지의 여부, Y, N
            }else if (cookie.getName().equals("ck_passwd")){
              ck_passwd = cookie.getValue();                          // Cookie에 저장된 password
            }else if(cookie.getName().equals("ck_passwd_save")){
              ck_passwd_save = cookie.getValue();                  // Cookie에 password를 저장 할 것인지의 여부, Y, N
            }
          }
        }
        
        System.out.println("-> ck_id: " + ck_id);
        
        mav.addObject("ck_id", ck_id); 
        mav.addObject("ck_id_save", ck_id_save);
        mav.addObject("ck_passwd", ck_passwd);
        mav.addObject("ck_passwd_save", ck_passwd_save);
        // -------------------------------------------------------------------------------
        
        return mav;
      }
      

      
      
}



