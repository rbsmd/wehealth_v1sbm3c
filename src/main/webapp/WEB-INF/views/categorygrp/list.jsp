<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dev.mvc.categorygrp.CategorygrpVO" %>
 
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
 
<DIV class='title_line'>카테고리 그룹</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <label>그룹 이름</label>
      <input type='text' name='categorygrp_name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seq_no' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='print_mode'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
    
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">출력 순서</TH>
      <TH class="th_bs">이름</TH>
      <TH class="th_bs">그룹 생성일</TH>
      <TH class="th_bs">출력 모드</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <%
    // Scriptlet
    // List<CategorygrpVO> list = (List<CategorygrpVO>)(request.getAttribute("list"));
    // for (CategorygrpVO categorygrpVO: list) {
    //    out.println(categorygrpVO.getName() + "<br>");
    // }
    %>
    <c:forEach var="categorygrpVO" items="${list}">
      <c:set var="categorygrp_no" value="${categorygrpVO.categorygrp_no }" />
      <c:set var="seq_no" value="${categorygrpVO.seq_no }" />
      <c:set var="categorygrp_name" value="${categorygrpVO.categorygrp_name }" />
      <c:set var="cdate" value="${categorygrpVO.cdate.substring(0, 10) }" />
      <c:set var="print_mode" value="${categorygrpVO.print_mode }" />
      <TR>
        <TD class="td_bs">${seq_no }</TD>
        <TD class="td_bs_left"><A href="../category/list_by_categorygrpno.do?categorygrp_no=${categorygrp_no }" >${categorygrp_name }</A></TD>
        <TD class="td_bs">${cdate }</TD>
        <TD class="td_bs">
          <c:choose>
            <c:when test="${print_mode == 'Y'}">
              <A href="./update_visible.do?categorygrp_no=${categorygrp_no }&print_mode=${print_mode }"><IMG src="/categorygrp/images/open.png" style='width: 18px;'></A>
            </c:when>
            <c:otherwise>
              <A href="./update_visible.do?categorygrp_no=${categorygrp_no }&print_mode=${print_mode }"><IMG src="/categorygrp/images/close.png" style='width: 18px;'></A>
            </c:otherwise>
          </c:choose>
        </TD>   
        
        <TD class="td_bs">
          <A href="./read_update.do?categorygrp_no=${categorygrp_no }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?categorygrp_no=${categorygrp_no }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
          <A href="./update_seqno_up.do?categorygrp_no=${categorygrp_no }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
          <A href="./update_seqno_down.do?categorygrp_no=${categorygrp_no }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
 