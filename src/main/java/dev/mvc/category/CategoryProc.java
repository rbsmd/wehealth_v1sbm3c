package dev.mvc.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.category.CategoryProc")
public class CategoryProc implements CategoryProcInter {
    @Autowired
    private CategoryDAOInter categoryDAO;
   
    public CategoryProc() {
      System.out.println("-> CategoryProc created");
    }
    
    @Override
    public int create(CategoryVO categoryVO) {
      int cnt = this.categoryDAO.create(categoryVO);
      return cnt;
    }
    
    @Override
    public List<CategoryVO> list_all() {
        List<CategoryVO> list = this.categoryDAO.list_all();
        return list;
    }
    
    @Override
    public List<CategoryVO> list_by_categorygrpno(int categorygrp_no) {
      List<CategoryVO> list = this.categoryDAO.list_by_categorygrpno(categorygrp_no);
      
      return list;
    }
    
    @Override
    public List<Categorygrp_CategoryVO> list_all_join() {
      List<Categorygrp_CategoryVO> list = this.categoryDAO.list_all_join();
      return list;
    }
    
    @Override
    public CategoryVO read(int category_no) {
      CategoryVO categoryVO = this.categoryDAO.read(category_no);
      return categoryVO;
    }

    @Override
    public int update(CategoryVO categoryVO) {
      int cnt = this.categoryDAO.update(categoryVO);
      return cnt;
    }
    
    @Override
    public int delete(int category_no) {
      int cnt = this.categoryDAO.delete(category_no);
      return cnt;
    }
    
    @Override
    public int count_by_categorygrpno(int categorygrp_no) {
      int cnt = this.categoryDAO.count_by_categorygrpno(categorygrp_no);
      return cnt;
    }
    
    @Override
    public int delete_by_categorygrpno(int categorygrp_no) {
      int cnt = this.categoryDAO.delete_by_categorygrpno(categorygrp_no);
      return cnt;
    }
    
    
}
