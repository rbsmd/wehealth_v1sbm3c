package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.items.ItemsVO;
import dev.mvc.tool.Tool;

@Component("dev.mvc.notice.NoticeProc")
  public class NoticeProc implements NoticeProcInter {
    @Autowired
    private NoticeDAOInter noticeDAO;

    @Override
    public int create(NoticeVO noticeVO) {
      int cnt=this.noticeDAO.create(noticeVO);
      return cnt;
    }
    
    @Override
    public List<NoticeVO> list_noticeno_desc() {
        List<NoticeVO> list = this.noticeDAO.list_noticeno_desc();
        return list;
    }
    
    @Override
    public NoticeVO read(int noticeno) {
       
        NoticeVO noticeVO = this.noticeDAO.read(noticeno);
        
        String title = noticeVO.getTitle();
        String content = noticeVO.getContent();
        
        title = Tool.convertChar(title);  // 특수 문자 처리
//        content = Tool.convertChar(content); 
        
        noticeVO.setTitle(title);
//        noticeVO.setContent(content);  
                
        return noticeVO;
    }
    
    @Override
    public int password_check(HashMap<String, Object> map) {
        int cnt = this.noticeDAO.password_check(map);
        return cnt;
    }
    
    @Override
    public NoticeVO read_update(int noticeno) {
        NoticeVO noticeVO = this.noticeDAO.read(noticeno);
        return noticeVO;
    }
    
    @Override
    public int update(NoticeVO noticeVO) {
        int cnt = this.noticeDAO.update(noticeVO);
        return cnt;
    }
    
    @Override
    public int notice_cnt() {
        int notice_cnt = this.noticeDAO.notice_cnt();
        return notice_cnt;
    }
    
    @Override
    public int delete(int noticeno) {
      int cnt = this.noticeDAO.delete(noticeno);
      return cnt;
    }
    
}
