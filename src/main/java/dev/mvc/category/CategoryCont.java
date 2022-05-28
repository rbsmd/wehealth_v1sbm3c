package dev.mvc.category;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.categorygrp.CategorygrpProcInter;
import dev.mvc.categorygrp.CategorygrpVO;
import dev.mvc.category.CategoryVO;
import dev.mvc.items.ItemsProcInter;

@Controller
public class CategoryCont {
    @Autowired
    @Qualifier("dev.mvc.categorygrp.CategorygrpProc")
    private CategorygrpProcInter categorygrpProc;
    
    @Autowired
    @Qualifier("dev.mvc.category.CategoryProc")
    private CategoryProcInter categoryProc;
    
    @Autowired
    @Qualifier("dev.mvc.items.ItemsProc")
    private ItemsProcInter itemsProc;

    public CategoryCont() {
        System.out.println("-> CategoryCont created.");
    }
    
    /**
     * 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/category/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward
      
      return mav; // forward
    }
    
//    /**
//     * 등록폼 http://localhost:9091/category/create.do?categorygrp_no=2
//     * 
//     * @return
//     */
//    @RequestMapping(value = "/category/create.do", method = RequestMethod.GET)
//    public ModelAndView create() {
//      ModelAndView mav = new ModelAndView();
//      mav.setViewName("/category/create"); // /webapp/WEB-INF/views/category/create.jsp
//
//      return mav;
//    }
    
    /**
     * 등록처리
     * http://localhost:9091/category/create.do?categorygrp_no=2
     * Exception: FK 전달이 안됨.
     * Field error in object 'cateVO' on field 'categrpno': rejected value [];
     * codes [typeMismatch.cateVO.categrpno,typeMismatch.categrpno,typeMismatch.int,typeMismatch]; 
     * arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [cateVO.categrpno,categrpno];
     * arguments []; default message [categrpno]]; 
     * default message [Failed to convert property value of type 'java.lang.String' to required type 'int' for property 'categrpno';
     * nested exception is java.lang.NumberFormatException: For input string: ""]]
     * @return
     */
    @RequestMapping(value = "/category/create.do", method = RequestMethod.POST)
    public ModelAndView create(CategoryVO categoryVO) {
      ModelAndView mav = new ModelAndView();

      // System.out.println("-> categorygrp_no: " + categoryVO.getCategorygrp_no());
      
      int cnt = this.categoryProc.create(categoryVO);
      // System.out.println("등록 성공");

      mav.addObject("code", "create_success");
      mav.addObject("cnt", cnt);
      mav.addObject("categorygrp_no", categoryVO.getCategorygrp_no());
      mav.addObject("category_name", categoryVO.getCategory_name());
      mav.addObject("url", "/category/msg");  // /category/msg -> /category/msg.jsp
      
      // mav.setViewName("redirect:/category/msg.do");
      // response.sendRedirect("/category/msg.do");
      
      mav.setViewName("redirect:/category/list_by_categorygrpno.do");
      
      return mav;
    }
    
//    /**
//     * 전체 목록
//     * http://localhost:9091/category/list_all.do 
//     * @return
//     */
//    @RequestMapping(value="/category/list_all.do", method=RequestMethod.GET )
//    public ModelAndView list_all() {
//      ModelAndView mav = new ModelAndView();
//      
//      List<CategoryVO> list = this.categoryProc.list_all();
//      mav.addObject("list", list); // request.setAttribute("list", list);
//
//      mav.setViewName("/category/list_all"); // /category/list_all.jsp
//      return mav;
//    }
    
    /**
     * 카테고리 그룹별 전체 목록
     * http://localhost:9091/category/list_by_categorygrpno.do?categorygrp_no=1 
     * @return
     */
    @RequestMapping(value="/category/list_by_categorygrpno.do", method=RequestMethod.GET )
    public ModelAndView list_by_categorygrpno(int categorygrp_no) {
      ModelAndView mav = new ModelAndView();
      
      List<CategoryVO> list = this.categoryProc.list_by_categorygrpno(categorygrp_no);
      mav.addObject("list", list); // request.setAttribute("list", list);

      CategorygrpVO  categorygrpVO = categorygrpProc.read(categorygrp_no); // 카테고리 그룹 정보
      mav.addObject("categorygrpVO", categorygrpVO); 
      
      mav.setViewName("/category/list_by_categorygrpno"); // /category/list_by_categorygrpno.jsp
      return mav;
    }
    
//    /**
//     * Categorygrp + Category join, 연결 목록
//     * http://localhost:9091/category/list_all_join.do 
//     * @return
//     */
//    @RequestMapping(value="/category/list_all_join.do", method=RequestMethod.GET )
//    public ModelAndView list_all_join() {
//      ModelAndView mav = new ModelAndView();
//      
//      List<Categorygrp_CategoryVO> list = this.categoryProc.list_all_join();
//      mav.addObject("list", list); // request.setAttribute("list", list);
//
//      mav.setViewName("/category/list_all_join"); // /WEB-INF/views/category/list_all_join.jsp
//      return mav;
//    }
    
    /**
     * 조회 + 수정폼 http://localhost:9091/category/read_update.do
     * 
     * @return
     */
    @RequestMapping(value = "/category/read_update.do", method = RequestMethod.GET)
    public ModelAndView read_update(int category_no) {
      // int categoryno = Integer.parseInt(request.getParameter("category_no"));

      ModelAndView mav = new ModelAndView();
      mav.setViewName("/category/read_update"); // read_update.jsp

      // 카테고리 정보
      CategoryVO categoryVO = this.categoryProc.read(category_no);
      mav.addObject("categoryVO", categoryVO);
      // request.setAttribute("categoryVO", categoryVO);
      
      int categorygrp_no = categoryVO.getCategorygrp_no();
      
      // 카테고리 그룹 정보
      CategorygrpVO categorygrpVO = this.categorygrpProc.read(categorygrp_no);
      mav.addObject("categorygrpVO", categorygrpVO);

      // 카테고리 목록
      List<CategoryVO> list = this.categoryProc.list_by_categorygrpno(categorygrp_no);
      mav.addObject("list", list);

      return mav; // forward
    }
    
    /**
     * 수정 처리
     * 
     * @param categoryVO
     * @return
     */
    @RequestMapping(value = "/category/update.do", method = RequestMethod.POST)
    public ModelAndView update(CategoryVO categoryVO) {
      ModelAndView mav = new ModelAndView();

      int cnt = this.categoryProc.update(categoryVO);
      
      if (cnt == 1) {
          mav.addObject("categorygrp_no", categoryVO.getCategorygrp_no());
          mav.setViewName("redirect:/category/list_by_categorygrpno.do");
      } else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("category_no", categoryVO.getCategory_no());
          mav.addObject("categorygrp_no", categoryVO.getCategorygrp_no());
          mav.addObject("category_name", categoryVO.getCategory_name());
          mav.addObject("url", "/category/msg");  // /cate/msg -> /cate/msg.jsp로 최종 실행됨.
          
          mav.setViewName("redirect:/category/msg.do"); // 새로고침 문제 해결, request 초기화
          
      }
      
      return mav;
    }
    
    /**
     * 조회 + 삭제폼 http://localhost:9091/category/read_delete.do
     * 
     * @return
     */
    @RequestMapping(value = "/category/read_delete.do", method = RequestMethod.GET)
    public ModelAndView read_delete(int category_no) {
      // int category_no = Integer.parseInt(request.getParameter("category_no"));
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/category/read_delete"); // read_delete.jsp

      CategoryVO categoryVO = this.categoryProc.read(category_no);
      mav.addObject("categoryVO", categoryVO);
      // request.setAttribute("categoryVO", categoryVO);
      int categorygrp_no = categoryVO.getCategorygrp_no();
      
      CategorygrpVO categorygrpVO = this.categorygrpProc.read(categorygrp_no);
      mav.addObject("categorygrpVO", categorygrpVO);
      

      List<CategoryVO> list = this.categoryProc.list_by_categorygrpno(categorygrp_no);
      mav.addObject("list", list);

      return mav; // forward
    }
    
    /**
     * 삭제 처리
     * 
     * @param categoryVO
     * @return
     */
    @RequestMapping(value = "/category/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(int category_no) {
      ModelAndView mav = new ModelAndView();
      
      // 삭제될 레코드 정보를 삭제하기전에 읽음
      CategoryVO categoryVO = this.categoryProc.read(category_no); 
      
      int cnt = 0;
      
      try {
          cnt = this.categoryProc.delete(category_no);
      } catch(Exception e) {
          mav.addObject("msg", "child_record_found");
      }
      
      if (cnt == 1) {
          mav.addObject("categorygrp_no", categoryVO.getCategorygrp_no());
          mav.setViewName("redirect:/category/list_by_categorygrpno.do");
      } else {
          mav.addObject("code", "delete_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("category_no", categoryVO.getCategory_no());
          mav.addObject("categorygrp_no", categoryVO.getCategorygrp_no());
          mav.addObject("category_name", categoryVO.getCategory_name());
          mav.addObject("url", "/category/msg");  // /cate/msg -> /cate/msg.jsp로 최종 실행됨.
          
          mav.setViewName("redirect:/category/msg.do"); // 새로고침 문제 해결, request 초기화
          
      }
      
      return mav;
    }
 
    /**
     * categorygrp_no가 같은 모든 레코드 삭제
     * http://localhost:9091/category/delete_by_categorygrp_no.do
     * @param categoryVO
     * @return
     */
    @RequestMapping(value = "/category/delete_by_categorygrpno.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete_by_categorygrp_no(int categorygrp_no) {
      
      int cnt = 0;
      try {
        cnt = this.categoryProc.delete_by_categorygrpno(categorygrp_no);  
      } catch (Exception e) {
        // pass  
      }
      
      JSONObject json = new JSONObject();
      json.put("cnt", cnt);
      
      return json.toString();
      
    }
    
    
    
}
