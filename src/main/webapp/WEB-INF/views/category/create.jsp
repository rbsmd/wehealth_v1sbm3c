<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
 
<DIV class='title_line'>카테고리 등록</DIV>

<DIV class='content_body'>
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <!-- 
    부모테이블 categorygrp_no PK 컬럼 값 이용, FK 선언
    http://localhost:9090/category/create.do?categorygrp_no=1
     -->
    <input type="hidden" name="categorygrp_no" value="${param.categorygrp_no }"> 
    
    <div class="form-group">
       <label class="control-label col-md-3">카테고리 이름</label>
       <div class="col-md-9">
         <input type='text' name='category_name' value='' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 50%;'>
          (부모 카테고리 번호: ${param.categorygrp_no })         
       </div>
    </div>
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn btn-xs" style="background-color: #202052;color: white;">등록</button>
      <button type="button" onclick="location.href='./list_by_categrp.do'" class="btn btn-xs" style="background-color: #202052;color: white;">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>