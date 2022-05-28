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
 
<DIV class='title_line'><A href="../categorygrp/list.do" class='title_link'>카테고리 그룹</A> > ${categorygrpVO.categorygrp_name }</DIV>

<DIV class='content_body'>

    <c:choose>
        <c:when test = "${sessionScope.id == null || sessionScope.grade  >= 11}">
                
          <TABLE class='table'>
            <colgroup>
              <col style='width: 10%;'/>
              <col style='width: 10%;'/>
              <col style='width: 45%;'/>
              <col style='width: 20%;'/>    
            </colgroup>
           
            <thead>  
            <TR>
              <TH class="th_bs">카테고리<br> 번호</TH>
              <TH class="th_bs">카테고리<br> 그룹 번호</TH>
              <TH class="th_bs">카테고리 이름</TH>
              <TH class="th_bs">등록일</TH>
            </TR>
            </thead>
            
            <tbody>
            <c:forEach var="categoryVO" items="${list}">
              <c:set var="category_no" value="${categoryVO.category_no }" />
              <c:set var="categorygrp_no" value="${categoryVO.categorygrp_no }" />
              <c:set var="category_name" value="${categoryVO.category_name }" />
              <c:set var="cdate" value="${categoryVO.cdate.substring(0, 10) }" />
              <TR>
                <TD class="td_bs">${category_no }</TD>
                <TD class="td_bs">${categorygrp_no }</TD>
                <TD class="td_bs_left"><A href="../items/list_by_categoryno_search_paging.do?category_no=${category_no }">${category_name }</A></TD>
                <TD class="td_bs">${cdate }</TD>  
              </TR>   
            </c:forEach> 
            </tbody>
           
          </TABLE>
    </c:when>
    <c:otherwise>
        <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
            <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
              <label>카테고리 그룹 번호</label>
              <input type='hidden' name='categorygrp_no' value='${param.categorygrp_no }' >
              ${param.categorygrp_no } 
            
              <label>카테고리 이름</label>
              <input type='text' name='category_name' value='' required="required" style='width: 25%;'
                         autofocus="autofocus">
          
              <button type="submit" id='submit' class="btn btn-xs" style="background-color: #202052;color: white;">등록</button>
              <button type="button" onclick="cancel();" class="btn btn-xs" style="background-color: #202052;color: white;">취소</button>
            </FORM>
          </DIV>
        
          <TABLE class='table'>
            <colgroup>
              <col style='width: 10%;'/>
              <col style='width: 10%;'/>
              <col style='width: 45%;'/>
              <col style='width: 20%;'/>   
              <col style='width: 15%;'/>
            </colgroup>
           
            <thead>  
            <TR>
              <TH class="th_bs">카테고리<br> 번호</TH>
              <TH class="th_bs">카테고리<br> 그룹 번호</TH>
              <TH class="th_bs">카테고리 이름</TH>
              <TH class="th_bs">등록일</TH>
              <TH class="th_bs">기타</TH>
            </TR>
            </thead>
            
            <tbody>
            <c:forEach var="categoryVO" items="${list}">
              <c:set var="category_no" value="${categoryVO.category_no }" />
              <c:set var="categorygrp_no" value="${categoryVO.categorygrp_no }" />
              <c:set var="category_name" value="${categoryVO.category_name }" />
              <c:set var="cdate" value="${categoryVO.cdate.substring(0, 10) }" />
              <TR>
                <TD class="td_bs">${category_no }</TD>
                <TD class="td_bs">${categorygrp_no }</TD>
                <TD class="td_bs_left"><A href="../items/list_by_categoryno_search_paging.do?category_no=${category_no }">${category_name }</A></TD>
                <TD class="td_bs">${cdate }</TD>
                <TD class="td_bs">
                  <A href="./read_update.do?category_no=${category_no }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
                  <A href="./read_delete.do?category_no=${category_no }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
                </TD>   
              </TR>   
            </c:forEach> 
            </tbody>
           
          </TABLE>
      </c:otherwise>
  </c:choose>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>