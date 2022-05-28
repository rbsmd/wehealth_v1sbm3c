<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Wehealth</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>
공지사항 > ${noticeVO.title } 삭제
</DIV>

<DIV class='content_body'>

  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <div class="msg_warning">공지사항을 삭제하시겠습니까?</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type='hidden' name='noticeno' id='noticeno' value="${noticeVO.noticeno }">

      <label>제목</label>: ${noticeVO.title}  
       
      <button type="submit" id='submit' class="btn btn-xs" style="background-color: #202052;color: white;">삭제</button>
      <button type="button" class="btn btn-xs" style="background-color: #202052;color: white;" onclick="location.href='././list.do'">취소</button>
    </FORM>
  </DIV>

  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 35%;'/>
      <col style='width: 15%;'/>
      <col style='width: 15%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">공지사항<br> 번호</TH>
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">작성자</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="noticeVO" items="${list}" varStatus="status">
      <c:set var="noticeno" value="${noticeVO.noticeno }" />
      <c:set var="title" value="${noticeVO.title }" />
      <c:set var="name" value="${noticeVO.name }" />
      <c:set var="rdate" value="${noticeVO.rdate.substring(0, 10) }" />
      <c:set var="notice_cnt" value="${notice_cnt }" />
      
      <TR>
        <TD class="td_bs"><p>${notice_cnt - status.index}</p></TD>
        <TD class="td_bs_left"><A href="./read.do?noticeno=${noticeno}" >${title }</A></TD>
        <TD class="td_bs">${name }</TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">
          <button type='button' id='update' onclick="notice_ajax(this.id, ${noticeno})" style='padding: 0; border: none; background: none;'><span class="glyphicon glyphicon-pencil"></span></button>
          <button type='button' id='delete' onclick="notice_ajax(this.id, ${noticeno})" style='padding: 0; border: none; background: none;'><span class="glyphicon glyphicon-trash"></span></button>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>