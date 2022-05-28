package dev.mvc.cart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.cart.CartProc")
public class CartProc implements CartProcInter {
  @Autowired
  private CartDAOInter cartDAO;
  
  @Override
  public int create(CartVO cartVO) {
    int cnt = this.cartDAO.create(cartVO);
    return cnt;
  }
  
  @Override
  public List<CartVO> list_by_memberno(int memberno) {
    List<CartVO> list = this.cartDAO.list_by_memberno(memberno);
    return list;
  }
  
  @Override
  public int delete(int cartno) {
    int cnt = this.cartDAO.delete(cartno);
    return cnt;
  }
  
  @Override
  public int update_cnt(CartVO cartVO) {
    int cnt = this.cartDAO.update_cnt(cartVO);
    return cnt;
  }

}