package dev.mvc.notice;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*        
        noticeno NUMBER(10) NOT NULL PRIMARY KEY,
        seqno NUMBER(7) NOT NULL,
        id           VARCHAR2(20)     NOT NULL,
        name      VARCHAR2(30)    NOT NULL,
        title VARCHAR(100) NOT NULL,
        content VARCHAR2(4000) NOT NULL,
        rdate DATE NOT NULL,
        FOREIGN KEY (id) REFERENCES member (id)
*/

public class NoticeVO {
    /** 공지사항 번호 */
    private int noticeno;
    /** 관리자 아이디 */
    private String id;
    /** 글쓴이 */
    private String name;
    /** 제목 */
    private String title="";
    /** 내용 */
    private String content="";
    /** 패스워드 */
    private String password="";
    /** 날짜 */
    private String rdate;
    public int getNoticeno() {
        return noticeno;
    }
    public void setNoticeno(int noticeno) {
        this.noticeno = noticeno;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getRdate() {
        return rdate;
    }
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    
    

}
