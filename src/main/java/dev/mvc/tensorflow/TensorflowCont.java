package dev.mvc.tensorflow;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
 
@Controller
public class TensorflowCont {
  @Autowired
  public TensorflowCont(){
    System.out.println("-> TenworflowCont created.");
  }

// http://localhost:9091/tensorflow/start.do
  @RequestMapping(value = {"/tensorflow/recommend_exercise/start.do"}, method = RequestMethod.GET)
  public ModelAndView start() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend_exercise/start");  // /WEB-INF/views/tensorflow/recommend_exercise/start.jsp
    
    return mav;
  }

  // http://localhost:9091/tensorflow/form1.do
  @RequestMapping(value = {"/tensorflow/recommend_exercise/form1.do"}, method = RequestMethod.GET)
  public ModelAndView form1() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend_exercise/form1");  // /WEB-INF/views/tensorflow/recommend_exercise/form1.jsp
    
    return mav;
  }

  // http://localhost:9091/tensorflow/form2.do
  @RequestMapping(value = {"/tensorflow/recommend_exercise/form2.do"}, method = RequestMethod.GET)
  public ModelAndView form2() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend_exercise/form2");  // /WEB-INF/views/tensorflow/recommend_exercise/form2.jsp
    
    return mav;
  }

  // http://localhost:9091/tensorflow/form3.do
  @RequestMapping(value = {"/tensorflow/recommend_exercise/form3.do"}, method = RequestMethod.GET)
  public ModelAndView form3() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend_exercise/form3");  // /WEB-INF/views/tensorflow/recommend_exercise/form3.jsp
    
    return mav;
  }
  
  // http://localhost:9091/tensorflow/form4.do
  @RequestMapping(value = {"/tensorflow/recommend_exercise/form4.do"}, method = RequestMethod.GET)
  public ModelAndView form4() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend_exercise/form4");  // /WEB-INF/views/tensorflow/recommend_exercise/form4.jsp
    
    return mav;
  }
  
  // http://localhost:9091/tensorflow/form5.do
  @RequestMapping(value = {"/tensorflow/recommend_exercise/form5.do"}, method = RequestMethod.GET)
  public ModelAndView form5() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend_exercise/form5");  // /WEB-INF/views/tensorflow/recommend_exercise/form5.jsp
    
    return mav;
  }
  
  // http://localhost:9091/tensorflow/end_ajax.do
  @RequestMapping(value = {"/tensorflow/recommend_exercise/end.do"}, method = RequestMethod.GET)
  public ModelAndView end() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend_exercise/end");  // /WEB-INF/views/tensorflow/recommend_exercise/end.jsp
    
    return mav;
  }
}