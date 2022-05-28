<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="noticeno" value="${noticeVO.noticeno }" />
<c:set var="title" value="${noticeVO.title }" />
<c:set var="name" value="${noticeVO.name }" />
<c:set var="content" value="${noticeVO.content }" />
<c:set var="rdate" value="${noticeVO.rdate.substring(0, 10) }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Wehealth</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'><A href="../notice/list.do" class='title_link'>공지사항</A> > 조회</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <button type='button' id='btn_cart' onclick="location.href='./create.do'" style='padding: 0; border: none; background: none;'>등록</button>
    <span class='menu_divide' >│</span>
    <button type="button" onclick="location.href='././list.do'" style='padding: 0; border: none; background: none;'>목록</button>
    <span class='menu_divide' >│</span>
    <A href="./update.do?noticeno=${noticeno }">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./delete.do?noticeno=${noticeno}">삭제</A>  
  </ASIDE> 
  
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%; height: 100px; margin-right: 10px; margin-bottom: 30px;">
          <div style="font-size: 1.5em; text-align: center; font-weight: bold;">${title }</div><br>
          <p style="font-size:1em; text-align: right;">작성자: ${name } <span class='menu_divide' >│</span> 등록일: ${rdate }</p>
          <hr style="height: 2px; background: #000000;">
        </DIV> 
        <DIV><br>${content }<br><hr style="height: 1.5px; background: #444444;"></DIV>
        <DIV>
        <div class="content_body_bottom" style="padding-right: 50%;">
            <button type="button" onclick="location.href='./list.do'" class="btn btn-sm" style="background-color: #202052;color: white;">목록</button>
        </div>
      </li> 
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
