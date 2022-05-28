package dev.mvc.order_item;

import java.util.HashMap;
import java.util.List;

public interface Order_itemProcInter{
  /**
   * 등록
   * @param order_itemVO
   * @return
   */
  public int create(Order_itemVO order_itemVO);
  
  /**
   * 회원별 주문 결재 목록
   * @param order_payno
   * @return
   */
  public List<Order_itemVO> list_by_memberno(HashMap<String, Object> map);
  
  /**
   * 상품별 주문 갯수
   * <select id="order_item_cnt" resultType="int" parameterType="int" >
   */
  public int order_item_cnt(int itemsno);
  
}

