package dev.mvc.categorygrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

//Autowired 기능에의해 자동 할당될 때 사용되는 이름
@Component("dev.mvc.categorygrp.CategorygrpProc")
public class CategorygrpProc implements CategorygrpProcInter {
    // DI: 객체가 필요한 곳에 객체를 자동으로 생성하여 할당
    // Autowired: DI 사용 선언
    // Spring이 자동으로 CategorygrpDAOInter를 구현하여 DAO class 생성후 객체를 만들어 할당
    @Autowired 
    private CategorygrpDAOInter categorygrpDAO;
    // private CategorygrpDAOInter categorygrpDAO = new CategorygrpDAO();

    public CategorygrpProc() {
        System.out.println("-> categoryProc created.");
    }
    
    @Override
    public int create(CategorygrpVO categorygrpVO) {
      int cnt = categorygrpDAO.create(categorygrpVO);
      
      return cnt;
    }

    @Override
    public List<CategorygrpVO> list_categorygrpno_asc() {
      List<CategorygrpVO> list = this.categorygrpDAO.list_categorygrpno_asc();
      return list;
    }
    
    @Override
    public List<CategorygrpVO> list_seqno_asc() {
      List<CategorygrpVO> list = this.categorygrpDAO.list_seqno_asc();
      return list;
    }
    
    @Override
    public CategorygrpVO read(int categorygrp_no) {
      CategorygrpVO categorygrpVO = this.categorygrpDAO.read(categorygrp_no);
      return categorygrpVO;
    }
    
    @Override
    public int update(CategorygrpVO categorygrpVO) {
      int cnt = this.categorygrpDAO.update(categorygrpVO);
      return cnt;
    }
    
    @Override
    public int delete(int categorygrp_no) {
      int cnt = this.categorygrpDAO.delete(categorygrp_no);
      return cnt;
    }
    
    @Override
    public int update_seqno_up(int categorygrp_no) {
      int cnt = this.categorygrpDAO.update_seqno_up(categorygrp_no);
      return cnt;
    }

    @Override
    public int update_seqno_down(int categorygrp_no) {
      int cnt = this.categorygrpDAO.update_seqno_down(categorygrp_no);    
      return cnt;
    }
    
    @Override
    public int update_visible(CategorygrpVO categorygrpVO) {
      int cnt = 0;
      
      if (categorygrpVO.getPrint_mode().toUpperCase().equals("Y")) {
        categorygrpVO.setPrint_mode("N");
      } else {
        categorygrpVO.setPrint_mode("Y");
      }
      
      cnt = this.categorygrpDAO.update_visible(categorygrpVO);
      
      return cnt;
    }
    
    
}