<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Wehealth</title>
<%-- /static/css/style.css --%> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>카테고리 > 알림</DIV>
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.code == 'create_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">새로운 카테고리 [${param.category_name }] 등록했습니다.</span>
          </LI>                                                                      
        </c:when>
        <c:when test="${param.code == 'create_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">새로운 카테고리 [${param.category_name }] 등록에 실패했습니다.</span>
          </LI>                                                                      
        </c:when>
        <c:when test="${param.code == 'update_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">카테고리 [${param.category_name }] 수정에 실패했습니다.</span>
          </LI>                                                                      
        </c:when>
        <c:when test="${param.code == 'delete_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">[${param.category_name }] 카테고리 삭제에 성공했습니다.</span>
          </LI>                                                                      
        </c:when>        
        <c:when test="${code == 'delete_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">[${param.categoryname }] 카테고리 삭제에 실패했습니다.</span>
          </LI>                                                                      
        </c:when> 
        <c:when test="${param.msg == 'child_record_found' }">
            삭제하려는 카테고리에 속한 상품이 있습니다.<br>
            하위 상품을 모두 삭제해야 카테고리를 삭제할 수 있습니다.<br>
            상품을 모두 삭제해주세요.<br>
            『<A href="../items/list_by_categoryno_search_paging.do?category_no=${param.category_no }">소속된 상품 삭제</A>』
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">알 수 없는 에러로 작업에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:choose>
            <c:when test="${param.cnt == 0 }">
                <button type='button' onclick="history.back()" class="btn btn-sm" style="background-color: #202052;color: white;">다시 시도</button>    
            </c:when>
        </c:choose>
        
        <button type='button' onclick="location.href='./list_by_categorygrpno.do?categorygrp_no=${param.categorygrp_no }'" class="btn btn-sm" style="background-color: #202052;color: white;">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>