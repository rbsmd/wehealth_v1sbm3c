<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
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

<DIV style="margin-top:50px;">   
<DIV class='menu_line'></DIV><br><br>
<DIV style="text-align:left; font-size: 23px; font-weight:bold; color: black;"> 베스트 상품</DIV>

    <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="itemsVO" items="${list }" varStatus="status">
      <c:set var="itemsno" value="${itemsVO.itemsno }" />
      <c:set var="item_name" value="${itemsVO.item_name }" />
      <c:set var="content" value="${itemsVO.content }" />
      <c:set var="file1" value="${itemsVO.file1 }" />
      <c:set var="size1" value="${itemsVO.size1 }" />
      <c:set var="thumb1" value="${itemsVO.thumb1 }" />
      
      <c:set var="item_price" value="${itemsVO.item_price }" />
      <c:set var="discount" value="${itemsVO.discount }" />
      <c:set var="total_price" value="${itemsVO.total_price }" />
      <c:set var="item_point" value="${itemsVO.item_point }" />

      <%-- 하나의 행에 이미지를 4개씩 출력후 행 변경, index는 0부터 시작 --%>
      <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if>
      
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%;  text-align: center;'>
        <c:choose>
          <c:when test="${size1 > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="./items/read.do?itemsno=${itemsno}">               
                  <IMG src="./items/storage/${thumb1 }" style='width: 100%; height: 150px;'>
                </a><br><br>
                ${item_name} <br>
                <del><fmt:formatNumber value="${item_price}" pattern="#,###" />원</del>
                <span style="color: #FF0000; font-size: 1.0em;">${discount} %</span><br>
                <strong><fmt:formatNumber value="${total_price}" pattern="#,###" />원</strong>
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                    <a href="./items/read.do?itemsno=${itemsno}">${file1}</a><br>
                  </DIV>
                </DIV>
                ${item_name} (${product_cnt})              
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <!-- 파일이 없는 경우 기본 이미지 출력 -->
            <a href="./items/read.do?itemsno=${itemsno}">
              <img src='/items/images/none1.png' style='width: 100%; height: 150px;'>
            </a><br><br>
            ${item_name} <br>
                <del><fmt:formatNumber value="${item_price}" pattern="#,###" />원</del>
                <span style="color: #FF0000; font-size: 1.0em;">${discount} %</span><br>
                <strong><fmt:formatNumber value="${total_price}" pattern="#,###" />원</strong>
          </c:otherwise>
        </c:choose>         
      </DIV>  
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>

</DIV>

 
</body>
 
</html>