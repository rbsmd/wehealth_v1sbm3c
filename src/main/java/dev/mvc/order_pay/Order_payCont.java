package dev.mvc.order_pay;
 
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

import dev.mvc.cart.CartProcInter;
import dev.mvc.cart.CartVO;
import dev.mvc.items.ItemsProcInter;
import dev.mvc.items.ItemsVO;
import dev.mvc.order_item.Order_itemProcInter;
import dev.mvc.order_item.Order_itemVO;
 
@Controller
public class Order_payCont {
//  @Autowired
//  @Qualifier("dev.mvc.member.MemberProc")
//  private MemberProcInter memberProc = null;
  
  @Autowired 
  @Qualifier("dev.mvc.cart.CartProc")
  private CartProcInter cartProc;
  
  @Autowired 
  @Qualifier("dev.mvc.order_pay.Order_payProc")
  private Order_payProcInter order_payProc;
  
  @Autowired 
  @Qualifier("dev.mvc.items.ItemsProc")
  private ItemsProcInter itemsProc;

  @Autowired 
  @Qualifier("dev.mvc.order_item.Order_itemProc")
  private Order_itemProcInter order_itemProc;
  
  public Order_payCont() {
    System.out.println("-> Order_payCont created.");
  }
  
  // http://localhost:9091/order_pay/create.do
  /**
  * 등록 폼
  * @return
  */
  @RequestMapping(value="/order_pay/create.do", method=RequestMethod.GET )
  public ModelAndView create(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int tot = 0;               // 할인 금액 합계 = 할인 금액 * 수량
    int tot_sum = 0;        // 할인 금액 총 합계 = 할인 금액 총 합계 + 할인 금액 합계
    int point_tot = 0;       // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
    int baesong_tot = 0;   // 배송비 합계
    int total_order = 0;     // 전체 주문 금액
    
    int memberno = (int)session.getAttribute("memberno");
    
    // 쇼핑카트에 등록된 상품 목록을 가져옴
    List<CartVO> list = this.cartProc.list_by_memberno(memberno);
    
    for (CartVO cartVO : list) {
      tot = cartVO.getTotal_price() * cartVO.getCnt();  // 할인 금액 합계 = 할인 금액 * 수량
      cartVO.setTot(tot);
      
      // 할인 금액 총 합계 = 할인 금액 총 합계 + 할인 금액 합계
      tot_sum = tot_sum + cartVO.getTot();
      // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
      point_tot = point_tot + (cartVO.getItem_point() * cartVO.getCnt());
      
    }
    
    if (tot_sum < 30000) { // 상품 주문 금액이 30,000 원 이하이면 배송비 3,000 원 부여
      baesong_tot = 3000;
    }
    
    total_order = tot_sum + baesong_tot; // 전체 주문 금액
        
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    mav.addObject("tot_sum", tot_sum);
    mav.addObject("point_tot", point_tot);
    mav.addObject("baesong_tot", baesong_tot);
    mav.addObject("total_order", total_order);
    
    mav.setViewName("/order_pay/create"); // webapp/WEB-INF/views/order_pay/create.jsp
      
    return mav; // forward
  }
  
  // http://localhost:9091/order_pay/create.do
  /**
   * 주문 결재 등록 처리
   * @param order_payVO
   * @return
   */
  @RequestMapping(value="/order_pay/create.do", method=RequestMethod.POST )
  public ModelAndView create(HttpSession session,
                                        Order_payVO order_payVO) { // order_payVO 자동 생성, Form -> VO
    ModelAndView mav = new ModelAndView();
    
    int memberno = (int)session.getAttribute("memberno");
    order_payVO.setMemberno(memberno); // 회원 번호 저장
    
    int cnt = this.order_payProc.create(order_payVO);

    /*
    // 주문 결재하고 바로 번호 수집
    <!-- 주문 결재 등록 전 order_payno를 Order_payVO에 저장  -->
    <insert id="create" parameterType="dev.mvc.order_pay.Order_payVO">
      <selectKey keyProperty="order_payno" resultType="int" order="BEFORE">
        SELECT order_pay_seq.nextval FROM dual
      </selectKey>
      
      INSERT INTO order_pay(order_payno, memberno, rname, rtel, rzipcode,
                                       raddress1, raddress2, paytype, amount, rdate)
      VALUES (#{order_payno}, #{memberno}, #{rname}, #{rtel}, #{rzipcode},
                                       #{raddress1}, #{raddress2}, #{paytype}, #{amount}, sysdate)
    </insert>
    */
    
    
    // Order_item: 주문 상세 테이블 관련 시작
    
    int order_payno = order_payVO.getOrder_payno(); // 결재 번호 수집
    
    Order_itemVO order_itemVO = new Order_itemVO();
    if (cnt == 1) { // 정상적으로 주문 결재 정보가 등록된 경우
      // 회원의 쇼핑카트 정보를 읽어서 주문 상세 테이블로 insert
      // 1. cart 읽음, SELECT
      List<CartVO> list = this.cartProc.list_by_memberno(memberno);
      for (CartVO cartVO : list) {
        int itemsno = cartVO.getItemsno();
        int cartno = cartVO.getCartno();
        
        // 2. order_item INSERT
       order_itemVO.setMemberno(memberno);
       order_itemVO.setOrder_payno(order_payno);
       order_itemVO.setItemsno(itemsno);
       order_itemVO.setCnt(cartVO.getCnt());
       
       ItemsVO itemsVO = this.itemsProc.read(itemsno); // 할인 금액 읽기용 VO
       int tot = itemsVO.getTotal_price() * cartVO.getCnt();  // 할인 금액 합계 = 할인 금액 * 수량
       
       order_itemVO.setTot(tot); // 상품 1건당 총 결재 금액
       
       // 주문 상태(stateno):  1: 결재 완료, 2: 상품 준비중, 3: 배송 시작, 4: 배달중, 5: 오늘 도착, 6: 배달 완료  
       order_itemVO.setStateno(1); // 신규 주문 등록임으로 1 
       
       this.order_itemProc.create(order_itemVO); // 주문 상세 등록

       // 3. 주문된 상품 cart에서 DELETE
       int delete_cnt = this.cartProc.delete(cartno);
       System.out.println("-> delete_cnt: " + delete_cnt + " 건 주문후 cart에서 삭제됨.");

      }
      
    } else {
      // 결재 실패했다는 에러 페이지등 제작 필요, 여기서는 생략
    }
    
    // Order_item: 주문 상세 테이블 관련 종료    
    
    mav.addObject("memberno", memberno);
    
    mav.setViewName("redirect:/order_pay/list_by_memberno.do");  // 참일 경우만 발생한다고 결정, 에러 페이지 이동 생략 

    return mav; // forward
  }

  /**
   * 회원별 전체 목록, 로그인이 안되어 있으면 로그인 후 목록 출력
   * http://localhost:9091/order_pay/list_by_memberno.do 
   * @return
   */
  @RequestMapping(value="/order_pay/list_by_memberno.do", method=RequestMethod.GET )
  public ModelAndView list_by_memberno(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      List<Order_payVO> list = this.order_payProc.list_by_memberno(memberno);
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/order_pay/list_by_memberno"); // /views/order_pay/list_by_memberno.jsp   
      
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/order_pay/list_by_memberno.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }

    return mav;
  }
  
}


