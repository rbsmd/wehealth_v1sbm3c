package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryVO;
import dev.mvc.categorygrp.CategorygrpVO;
import dev.mvc.items.ItemsVO;

@Controller
public class NoticeCont {
    @Autowired
    @Qualifier("dev.mvc.notice.NoticeProc")
    private NoticeProcInter noticeProc;
    
    public NoticeCont() {
        System.out.println("-> NoticeCont created.");
    }
    
    /**
     * 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/notice/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); 
      
      return mav; 
    }
    
    /**
     * 등록폼
     * 사전 준비된 레코드: 관리자 1번, cateno 1번, categrpno 1번을 사용하는 경우 테스트 URL
     * http://localhost:9091/notice/create.do
     * 
     * @return
     */
    @RequestMapping(value = "/notice/create.do", method = RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();

      mav.setViewName("/notice/create");

      return mav; // forward
    }
    
    /**
     * 등록 처리
     * 
     * @param categorygrpVO
     * @return
     */
    @RequestMapping(value = "/notice/create.do", method = RequestMethod.POST)
    public ModelAndView create(NoticeVO noticeVO) { 

        ModelAndView mav = new ModelAndView();
        
        int cnt = this.noticeProc.create(noticeVO); // 등록 처리
//         cnt = 0; // error test
                
        mav.addObject("cnt", cnt);
                     
        if (cnt == 1) {
            mav.addObject("code", "create_success");
            mav.setViewName("/notice/msg");
//            mav.setViewName("redirect:/notice/list.do");
        } else {
            mav.addObject("code", "create_fail"); 
            mav.setViewName("/notice/msg");
        }

        return mav; // forward
    }
    
    /**
     * 목록 처리
     * @param NoticeVO
     * @return
     */
    @RequestMapping(value="/notice/list.do", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView();
        
        List<NoticeVO> list = this.noticeProc.list_noticeno_desc();
        mav.addObject("list", list);
        
        int notice_cnt = this.noticeProc.notice_cnt();
        mav.addObject("notice_cnt", notice_cnt); 
        
        mav.setViewName("/notice/list");
                      
        return mav;
        
    }
    
    /**
     * 조회
     * @return
     */
    @RequestMapping(value="/notice/read.do", method=RequestMethod.GET )
    public ModelAndView read(int noticeno) {
      ModelAndView mav = new ModelAndView();

      NoticeVO noticeVO = this.noticeProc.read(noticeno);
      mav.addObject("noticeVO", noticeVO); 
                 
      mav.setViewName("/notice/read");
          
      return mav;
    }
    
    /**
     * 수정 폼
     * http://localhost:9091/notice/update.do?noticeno=1
     * 
     * @return
     */
    @RequestMapping(value = "/notice/update.do", method = RequestMethod.GET)
    public ModelAndView update(int noticeno) {
      ModelAndView mav = new ModelAndView();
      
      NoticeVO noticeVO = this.noticeProc.read_update(noticeno);
      
      mav.addObject("noticeVO", noticeVO);
      
      mav.setViewName("/notice/update");

      return mav; // forward
    }

    /**
     * 수정 처리
     * http://localhost:9091/notice/update.do?noticeno=1
     * 
     * @return
     */
    @RequestMapping(value = "/notice/update.do", method = RequestMethod.POST)
    public ModelAndView update(NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("noticeno", noticeVO.getNoticeno());
      map.put("password", noticeVO.getPassword());
      
      int cnt=0;
      
      int password_cnt = this.noticeProc.password_check(map);
      if (password_cnt == 1) {
          cnt = this.noticeProc.update(noticeVO); // 수정 처리
          
          mav.addObject("noticeno", noticeVO.getNoticeno());
          mav.setViewName("redirect:/notice/read.do");             
      } else {
          mav.addObject("cnt", cnt);
          mav.addObject("code", "password_fail");
          mav.setViewName("redirect:/notice/msg.do");
      }

      return mav; // forward
    }
    
    /**
     * 조회 + 삭제폼 http://localhost:9091/notice/delete.do
     * 
     * @return
     */
    @RequestMapping(value = "/notice/delete.do", method = RequestMethod.GET)
    public ModelAndView read_delete(int noticeno) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/notice/delete"); // read_delete.jsp

      NoticeVO noticeVO = this.noticeProc.read(noticeno);
      mav.addObject("noticeVO", noticeVO);      
      
      int notice_cnt = this.noticeProc.notice_cnt();
      mav.addObject("notice_cnt", notice_cnt);

      List<NoticeVO> list = this.noticeProc.list_noticeno_desc();
      mav.addObject("list", list);

      return mav; // forward
    }
 
    /**
     * 삭제 처리
     * 
     * @param categoryVO
     * @return
     */
    @RequestMapping(value = "/notice/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(int noticeno) {
      ModelAndView mav = new ModelAndView();
      
      // 삭제될 레코드 정보를 삭제하기전에 읽음
      NoticeVO noticeVO = this.noticeProc.read(noticeno); 
      
      int cnt = this.noticeProc.delete(noticeno);
      
      if (cnt == 1) {
          mav.setViewName("redirect:/notice/list.do");
      } else {
          mav.addObject("code", "delete_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("title", noticeVO.getTitle());
          mav.addObject("url", "/notice/msg");  // /cate/msg -> /cate/msg.jsp로 최종 실행됨.
          
          mav.setViewName("redirect:/notice/msg.do"); // 새로고침 문제 해결, request 초기화
          
      }
      
      return mav;
    }
    

}
