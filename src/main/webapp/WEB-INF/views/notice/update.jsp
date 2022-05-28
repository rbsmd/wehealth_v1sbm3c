<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="noticeno" value= "${noticeVO.noticeno }" />
<c:set var="title" value="${noticeVO.title }" />
<c:set var="name" value= "${noticeVO.name }" />
<c:set var="content" value="${noticeVO.content }" />
         
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
    
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script> <!-- /static 기준 -->
 
<script type="text/JavaScript">
  // window.onload=function(){
  //  CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  // };

  $(function() {
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  }); 
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>
공지사항 > ${noticeVO.title } 수정
</DIV>

<DIV class='content_body'>
   <ASIDE class="aside_right">
    <button type='button' id='btn_cart' onclick="location.href='./create.do'" style='padding: 0; border: none; background: none;'>등록</button>
    <span class='menu_divide' >│</span>
    <button type="button" onclick="location.href='././list.do'" style='padding: 0; border: none; background: none;'>목록</button>
    <span class='menu_divide' >│</span>
    <A href="./delete.do?noticeno=${noticeno}">삭제</A>  
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>
  
  <DIV class='content_body'>
  <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
  <input type='hidden' name='noticeno' value='${noticeno }'>
    <div class="form-group">
       <label class="control-label col-md-2">제목</label>
       <div class="col-md-10">
         <input type='text' name='title' value='${title }' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 100%;'>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">내용</label>
       <div class="col-md-10">
         <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>${content }</textarea>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">이름</label>
       <div class="col-md-10">
         <input type='text' name='name' value='${name }' required="required" class="form-control" style='width: 50%;'>
       </div>
    </div>
        
    <div class="form-group">
       <label class="control-label col-md-2">패스워드</label>
       <div class="col-md-10">
         <input type='password' name='password' value='' required="required" 
                    class="form-control" style='width: 50%;'>
       </div>
    </div>     
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-sm" style="background-color: #202052;color: white;">등록</button>
      <button type="button" onclick="history.back();" class="btn btn-sm" style="background-color: #202052;color: white;">취소</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>


