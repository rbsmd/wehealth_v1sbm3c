<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>
  <A href="../categorygrp/list.do" class='title_link'>카테고리 그룹</A> > 
  ${categorygrpVO.categorygrp_name } > ${categoryVO.category_name } >
  상품 정보 등록(수정)
</DIV>

<DIV class='content_body'>
  <FORM name='frm' method='POST' action='./product_update.do' class="form-horizontal">
    <input type="hidden" name="categorygrp_no" value="${categoryVO.categorygrp_no }"> 
    <input type="hidden" name="category_no" value="${param.category_no }">
    <input type="hidden" name="itemsno" value="${itemsVO.itemsno}"> 
    
    <div class="form-group">
       <label class="control-label col-md-2">상품명</label>
       <div class="col-md-10">
         ${itemsVO.item_name }
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">정가</label>
       <div class="col-md-10">
         <input type='number' name='item_price' value='${itemsVO.item_price }' required="required" autofocus="autofocus"
                    min="0" max="10000000" step="100" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>   
    <div class="form-group">
       <label class="control-label col-md-2">할인률</label>
       <div class="col-md-10">
         <input type='number' name='discount' value='${itemsVO.discount }' required="required"
                    min="0" max="100" step="1" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div> 
    <div class="form-group">
       <label class="control-label col-md-2">판매가</label>
       <div class="col-md-10">
         <input type='number' name='total_price' value='${itemsVO.total_price }' required="required"
                    min="0" max="10000000" step="100" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>         
    <div class="form-group">
       <label class="control-label col-md-2">포인트</label>
       <div class="col-md-10">
         <input type='number' name='item_point' value='${itemsVO.item_point }' required="required"
                    min="0" max="10000000" step="10" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">보유 수량</label>
       <div class="col-md-10">
         <input type='number' name='item_cnt' value='${itemsVO.item_cnt }' required="required" 
                    min="0" max="99999" step="1" class="form-control" style='width: 100%;'>
    </div>
    </div>
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-sm" style="background-color: #202052;color: white;">저장</button>
      <button type="button" onclick="location.href='./read.do?category_no=${param.category_no}&itemsno=${param.itemsno }'" class="btn btn-primary">취소</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>