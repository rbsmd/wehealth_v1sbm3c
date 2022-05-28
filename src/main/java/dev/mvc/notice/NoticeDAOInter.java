package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;

import dev.mvc.items.ItemsVO;

public interface NoticeDAOInter {
    /**
     * 등록
     * @param noticeVO
     * @return
     */
    public int create(NoticeVO noticeVO);
    
    /**
     * 목록
     * <select id="list_noticeno_desc" resultType="dev.mvc.notice.NoticeVO">
     */
    public List<NoticeVO> list_noticeno_desc();
    
    /**
     * 조회
     * <select id="read" resultType="dev.mvc.notice.NoticeVO" parameterType="int">
     */
    public NoticeVO read(int noticeno);
    
    /**
     * 패스워드 체크
     * @param map
     * @return
     */
    public int password_check(HashMap<String, Object> map);
    
    /**
     * 수정
     * @param itemsVO
     * @return
     */
    public int update(NoticeVO noticeVO);
    
    /**
     * 공지사항 개수
     * @param int
     */
    public int notice_cnt();
    
    /**
     * 삭제 처리
     * delete id="delete" parameterType="int"
     * @param notice_no
     * @return 처리된 레코드 갯수
     */
    public int delete(int noticeno);
    

}
