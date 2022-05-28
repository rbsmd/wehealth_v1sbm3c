package dev.mvc.wehealth_v1sbm3c;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.items.ItemsProcInter;
import dev.mvc.items.ItemsVO;

@Controller
public class HomeCont {
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }
  
  @Autowired
  @Qualifier("dev.mvc.items.ItemsProc")
  private ItemsProcInter itemsProc;

  // http://localhost:9091
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/index");  // /WEB-INF/views/index.jsp
    
    // 추천수 내림차순
    List<ItemsVO> list = this.itemsProc.main_list();
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    return mav;
  }
}