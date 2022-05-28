<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<div class="top_menu" style="text-align: right; padding-right: 1%; background-color: #E9ECEF; height: 30px;line-height: 30px;">
    <c:choose>
        <c:when test="${sessionScope.id != null}"> <%-- 로그인 한 경우 --%>
           ${sessionScope.id } <A class='menu_link'  href='/member/logout.do' style="color: black;">Logout</A><span class='top_menu_sep'> </span>
        </c:when>
        <c:otherwise>
          <A class='menu_link'  href='/member/login.do'  style="color: black;">Login</A><span class='top_menu_sep'> </span>
          <A class='menu_link'  href='/member/create.do' style="color: black;">회원가입</A><span class='top_menu_sep'> </span>
        </c:otherwise>
    </c:choose> 
    <c:choose>
        <c:when test="${sessionScope.id == null || sessionScope.grade >=11}"> 
        </c:when>
        <c:otherwise>
          <A class='menu_link'  href='/member/list.do' style="color: black;">회원목록</A><span class='top_menu_sep'> </span>
        </c:otherwise>
      </c:choose>
    <A class='menu_link'  href='/cart/list_by_memberno.do' style="color: black;">쇼핑카트</A><span class='top_menu_sep'> </span>
    <A class='menu_link'  href='/order_pay/list_by_memberno.do' style="color: black;">주문결제</A><span class='top_menu_sep'> </span>  
  </div>

<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top'>
    <DIV class='top_menu_label'><A href="/"><img src="/css/images/logo_2.png" /></A></DIV>
  </DIV>
  <HR>
  <DIV class='top_sec'>
    <NAV class='top_menu'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link'  href='/' >Home</A><span class='top_menu_sep'> </span> 
      <A class='menu_link'  href='/categorygrp/list.do'>카테고리 그룹</A><span class='top_menu_sep'> </span>
      <%-- <A class='menu_link'  href='/category/list_all.do'>카테고리 전체 목록</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/category/list_all_join.do'>카테고리 전체 목록 Join</A><span class='top_menu_sep'> </span> --%>              
      <A class='menu_link'  href='/cart/list_by_memberno.do'>쇼핑카트</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/order_pay/list_by_memberno.do'>주문결제</A><span class='top_menu_sep'> </span> 
      <c:choose>
        <c:when test="${sessionScope.id == null}" >
            <A class='menu_link'  href='/member/create.do'>회원가입</A><span class='top_menu_sep'> </span>
        </c:when>
        <c:when test="${sessionScope.id == null || sessionScope.grade >=11}"> <%-- 로그인 한 경우 --%>
        </c:when>
        <c:otherwise>
          <A class='menu_link'  href='/member/list.do'>회원목록</A><span class='top_menu_sep'> </span>
        </c:otherwise>
      </c:choose>
      <A class='menu_link'  href='/notice/list.do'>공지사항</A><span class='top_menu_sep'> </span>    
    </NAV>
 </DIV>

  
  <%-- 내용 --%> 
  <DIV class='content'>