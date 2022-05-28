<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="item_name" value="${itemsVO.item_name }" />
<c:set var="content" value="${itemsVO.content }" />
<c:set var="search_word" value="${itemsVO.search_word }" />
<c:set var="item_price" value="${itemsVO.item_price }" />
<c:set var="discount" value="${itemsVO.discount }" />
<c:set var="total_price" value="${itemsVO.total_price }" />
<c:set var="item_point" value="${itemsVO.item_point }" />
<c:set var="item_cnt" value="${itemsVO.item_cnt }" />
<c:set var="itemsno" value="${itemsVO.itemsno }" />
         
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>wehealth</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
 
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
  <A href="../categorygrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../category/list_by_categorygrpno.do?categorygrp_no=${categorygrpVO.categorygrp_no }" class='title_link'>${categorygrpVO.categorygrp_name }</A> >
  <A href="./list_by_categoryno_search_paging.do?category_no=${categoryVO.category_no }" class='title_link'>${categoryVO.category_name }</A> >
  ${title } 수정
</DIV>

<DIV class='content_body'>
   <ASIDE class="aside_right">
      <A href="./create.do?categoryno=${categoryVO.category_no }">등록</A>
      <span class='menu_divide' >│</span>
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span>
      <A href="./list_by_categoryno_search_paging.do?category_no=${categoryVO.category_no }">기본 목록형</A>    
      <span class='menu_divide' >│</span>
     <A href="./list_by_categoryno_grid.do?category_no=${categoryVO.category_no }">갤러리형</A>
    </ASIDE> 
  
    <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_categoryno_search.do'>
      <input type='hidden' name='category_no' value='${categoryVO.category_no }'>
      <input type='text' name='search_word' id='search_word' value='${param.search_word }' style='width: 20%;'>
      <button type='submit'>검색</button>
      <c:if test="${param.search_word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_categoryno_search_paging.do?category_no=${categoryVO.category_no}&search_word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./update_text.do' class="form-horizontal">
    <input type='hidden' name='itemsno' value='${itemsno }'>
    <input type="hidden" name="category_no" value="${categoryVO.category_no }">
    <input type="hidden" name="adminno" value="1"> <%-- 관리자 개발후 변경 필요 --%>
    <input type='hidden' name='now_page' value='${param.now_page }'>
    
    <div class="form-group">
       <label class="control-label col-md-2">상품명</label>
       <div class="col-md-10">
         <input type='text' name='item_name' value='${item_name }' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 100%;'>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">상품 설명</label>
       <div class="col-md-10">
         <textarea name='content' required="required" class="form-control" rows="20" style='width: 100%;'>${content }</textarea>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">검색어</label>
       <div class="col-md-10">
         <input type='text' name='search_word' value='${search_word }' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 100%;'>
       </div>
    </div>  
    <div class="form-group">
       <label class="control-label col-md-2">정가</label>
       <div class="col-md-10">
         <input type='number' name='item_price' value='${item_price }' required="required" autofocus="autofocus"
                    min="0" max="10000000" step="100" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>   
    <div class="form-group">
       <label class="control-label col-md-2">할인률</label>
       <div class="col-md-10">
         <input type='number' name='discount' value='${discount }' required="required"
                    min="0" max="100" step="1" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div> 
    <div class="form-group">
       <label class="control-label col-md-2">판매가</label>
       <div class="col-md-10">
         <input type='number' name='total_price' value='${total_price }' required="required"
                    min="0" max="10000000" step="100" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>         
    <div class="form-group">
       <label class="control-label col-md-2">포인트</label>
       <div class="col-md-10">
         <input type='number' name='item_point' value='${item_point }' required="required"
                    min="0" max="10000000" step="10" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>        
      
    <div class="form-group">
       <label class="control-label col-md-2">보유 수량</label>
       <div class="col-md-10">
         <input type='number' name='item_cnt' value='100' required="required" 
                    min="0" max="99999" step="1" class="form-control" style='width: 100%;'>
       </div>
    </div>

    <div class="form-group">
       <label class="control-label col-md-2">패스워드</label>
       <div class="col-md-10">
         <input type='password' name='password' value='' required="required" class="form-control" style='width: 100%;'>
       </div>
    </div>

    <div class="content_body_bottom">
      <button type="submit" class="btn btn-sm" style="background-color: #202052;color: white;">저장</button>
      <button type="button" onclick="history.back();" class="btn btn-sm" style="background-color: #202052;color: white;">취소</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>


