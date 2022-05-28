package dev.mvc.reply;

import java.util.List;
import java.util.Map;

public interface ReplyProcInter {
  /**
   * 등록
   * @param replyVO
   * @return
   */
  public int create(ReplyVO replyVO);
  
  public List<ReplyVO> list();
  
  public List<ReplyMemberVO> list_member_join();
  
  public List<ReplyMemberVO> list_by_itemsno_join(int itemsno);
  
  public int checkPasswd(Map<String, Object> map);

  public int delete(int replyno);
  
  /**
   * 특정글 관련 전체 댓글 목록
   * @param itemsno
   * @return
   */
  public List<ReplyMemberVO> list_by_itemsno_join_add(int itemsno);
  
}