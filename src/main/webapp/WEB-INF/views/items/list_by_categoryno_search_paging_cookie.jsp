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

  $(function() {
    // var contentsno = 0;
    // $('#btn_cart').on('click', function() { cart_ajax(itemsno)});
    $('#btn_login').on('click', login_ajax);
    $('#btn_loadDefault').on('click', loadDefault);
  });
  
  function recom_ajax(itemsno, status_count) {
    console.log("-> recom_" + status_count + ": " + $('#recom_' + status_count).html());  // A tag body      
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'itemsno=' + itemsno; // 공백이 값으로 있으면 안됨.
    $.ajax(
      {
        url: '/items/update_recom_ajax.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          if (rdata.cnt == 1) {
            // $('#span_animation_' + status_count).hide();   // SPAN 태그에 animation 출력
            $('#recom_' + status_count).html('♥('+rdata.recom+')');     // A 태그에 animation 출력
          } else {
            // $('#span_animation_' + status_count).html("X");
            $('#recom_' + status_count).html('♥(X)');
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

    $('#recom_' + status_count).html("<img src='/items/images/ani04.gif' style='width: 10%;'>");
    // $('#span_animation_' + status_count).css('text-align', 'center');
    // $('#span_animation_' + status_count).html("<img src='/contents/images/ani04.gif' style='width: 10%;'>");
    // $('#span_animation_' + status_count).show(); // 숨겨진 태그의 출력
      
  }  

  function loadDefault() {
    $('#id').val('user1');
    $('#passwd').val('1234');
  } 
  
  <%-- 로그인 --%>
  function login_ajax() {
    var params = "";
    params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // params += '&${ _csrf.parameterName }=${ _csrf.token }';
    // console.log(params);
    // return;
    
    $.ajax(
      {
        url: '/member/login_ajax.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> login cnt: ' + rdata.cnt);  // 1: 로그인 성공
          
          if (rdata.cnt == 1) {
            // 쇼핑카트에 insert 처리 Ajax 호출
            $('#div_login').hide();
            alert('로그인 성공');
            $('#login_yn').val('YES');  // 로그인 성공 기록
            cart_ajax_post();  // 쇼핑카트에 insert 처리 Ajax 호출
            document.location.reload();
            
          } else {
            alert('로그인에 실패했습니다. \n잠시후 다시 시도해주세요.');
            
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  }

  <%-- 쇼핑 카트에 상품 추가 --%>
  function cart_ajax(itemsno) {
    var f = $('#frm_login');
    $('#itemsno', f).val(itemsno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장.
    
    console.log('-> itemsno: ' + $('#itemsno', f).val()); 
    
    // console.log('-> id:' + '${sessionScope.id}');
    if ('${sessionScope.id}' != '' || $('#login_yn').val() == 'YES') {  // 로그인이 되어 있다면
    	cart_ajax_post();   // 쇼핑카트에 insert 처리 Ajax 호출 
    } else {  // 로그인 안된 경우
    	$('#div_login').show();       
    }

  }

  <%-- 쇼핑카트 상품 등록 --%>
  function cart_ajax_post() {
    var f = $('#frm_login');
    var itemsno = $('#itemsno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
    
    var params = "";
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'itemsno=' + itemsno;
    params += '&${ _csrf.parameterName }=${ _csrf.token }';
    console.log('-> cart_ajax_post: ' + params);
    // return;
    
    $.ajax(
      {
        url: '/cart/create.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> cart_ajax_post cnt: ' + rdata.cnt);  // 1: 쇼핑카트 등록 성공
          
          if (rdata.cnt == 1) {
            var sw = confirm('선택한 상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?');
            if (sw == true) {
              // 쇼핑카트로 이동
              location.href='/cart/list_by_memberno.do';
            }           
          } else {
            alert('선택한 상품을 장바구니에 담지못했습니다.<br>잠시후 다시 시도해주세요.');
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  }

</script>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>
  <A href="../categorygrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../category/list_by_categorygrpno.do?categorygrp_no=${categorygrpVO.categorygrp_no }" class='title_link'>${categorygrpVO.categorygrp_name }</A> >
  <A href="./list_by_categoryno_search_paging.do?category_no=${categoryVO.category_no }" class='title_link'>${categoryVO.category_name }</A>
</DIV>

<DIV class='content_body'>
  <c:choose>
    <c:when test = "${sessionScope.id == null || sessionScope.grade  >= 11}">
      <ASIDE class="aside_right">
        <A href="javascript:location.reload();">새로고침</A>
        <span class='menu_divide' >│</span>
        <A href="./list_by_categoryno_grid.do?category_no=${categoryVO.category_no }">갤러리형</A>
      </ASIDE> 
    
      <DIV style="text-align: right; clear: both;">  
        <form name='frm' id='frm' method='get' action='./list_by_categoryno_search_paging.do'>
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
      
        <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
      <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
        <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
          <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
          <input type="hidden" name="itemsno" id="itemsno" value="itemsno">
          <input type="hidden" name="login_yn" id="login_yn" value="NO">
    
          <div class="form-group">
            <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
            <div class="col-md-8">
              <input type='text' class="form-control" name='id' id='id' 
                         value='${ck_id }' required="required" 
                         style='width: 30%;' placeholder="아이디" autofocus="autofocus">
              <Label>   
                <input type='checkbox' name='id_save' value='Y' 
                          ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
              </Label>                   
            </div>
       
          </div>   
       
          <div class="form-group">
            <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
            <div class="col-md-8">
              <input type='password' class="form-control" name='passwd' id='passwd' 
                        value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
              <Label>
                <input type='checkbox' name='passwd_save' value='Y' 
                          ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
              </Label>
            </div>
          </div>   
       
          <div class="form-group">
            <div class="col-md-offset-4 col-md-8">
              <button type="button" id='btn_login' class="btn btn-primary btn-md">로그인</button>
              <button type='button' onclick="location.href='/member/create.do'" class="btn btn-primary btn-md">회원가입</button>
              <!-- <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button> -->
              <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                          onclick="$('#div_login').hide();">취소</button>
            </div>
          </div>   
          
        </FORM>
      </DIV>
      <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
      
      
      <table class="table table-striped" style='width: 100%;'>
        <colgroup>
          <col style="width: 10%;"></col>
          <col style="width: 60%;"></col>
          <col style="width: 20%;"></col>
        </colgroup>
        <%-- table 컬럼 --%>
    <!--     <thead>
          <tr>
            <th style='text-align: center;'>파일</th>
            <th style='text-align: center;'>상품명</th>
            <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
            <th style='text-align: center;'>기타</th>
          </tr>
        
        </thead> -->
        
        <%-- table 내용 --%>
        <tbody>
          <c:forEach var="itemsVO" items="${list }" varStatus="status">
            <c:set var="itemsno" value="${itemsVO.itemsno }" />
            <c:set var="category_no" value="${itemsVO.category_no }" />
            <c:set var="item_name" value="${itemsVO.item_name }" />
            <c:set var="content" value="${itemsVO.content }" />
            <c:set var="recom" value="${itemsVO.recom_cnt }" />
            
            <c:set var="file1" value="${itemsVO.file1 }" />
            <c:set var="thumb1" value="${itemsVO.thumb1 }" />
            
            <c:set var="item_price" value="${itemsVO.item_price }" />
            <c:set var="discount" value="${itemsVO.discount }" />
            <c:set var="total_price" value="${itemsVO.total_price }" />
            <c:set var="item_point" value="${itemsVO.item_point }" />
            
            <tr> 
              <td style='vertical-align: middle; text-align: center;'>
                <c:choose>
                  <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                    <%-- /static/contents/storage/ --%>
                    <a href="./read.do?itemsno=${itemsno}&now_page=${param.now_page }"><IMG src="/items/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
                  </c:when>
                  <c:otherwise> <!-- 기본 이미지 출력 -->
                    <IMG src="/items/images/none1.png" style="width: 120px; height: 80px;">
                  </c:otherwise>
                </c:choose>
              </td>  
              <td style='vertical-align: middle;'>
                <a href="./read.do?itemsno=${itemsno}&now_page=${param.now_page }&search_word=${param.search_word}"><strong>${item_name}</strong> ${content}</a> 
              </td> 
              <td style='vertical-align: middle; text-align: center;'>
                <del><fmt:formatNumber value="${item_price}" pattern="#,###" /></del><br>
                <span style="color: #FF0000; font-size: 1.2em;">${discount} %</span>
                <strong><fmt:formatNumber value="${total_price}" pattern="#,###" /></strong><br>
                <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${item_point}" pattern="#,###" /></span>
                <span><A id="recom_${status.count }" href="javascript:recom_ajax(${itemsno }, ${status.count })" class="recom_link">♥(${recom })</A></span>
    
                <%-- <span id="span_animation_${status.count }"></span> --%>
                <br>
                <button type='button' id='btn_cart' class="btn btn-info" style='margin-bottom: 2px;'
                            onclick="cart_ajax(${itemsno })">장바 구니</button><br>
                <button type='button' id='btn_ordering' class="btn btn-info" 
                            onclick="cart_ajax(${itemsno })">바로 구매</button>  
                                        
              </td>
            </tr>
          </c:forEach>
          
        </tbody>
      </table>
      
      <!-- 페이지 목록 출력 부분 시작 -->
      <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
      <!-- 페이지 목록 출력 부분 종료 -->
    </c:when>
    <c:otherwise>
        <ASIDE class="aside_right">
    <A href="./create.do?category_no=${categoryVO.category_no }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_categoryno_grid.do?category_no=${categoryVO.category_no }">갤러리형</A>
  </ASIDE> 

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_categoryno_search_paging.do'>
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
  
    <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
    <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
      <input type="hidden" name="itemsno" id="itemsno" value="itemsno">
      <input type="hidden" name="login_yn" id="login_yn" value="NO">

      <div class="form-group">
        <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
        <div class="col-md-8">
          <input type='text' class="form-control" name='id' id='id' 
                     value='${ck_id }' required="required" 
                     style='width: 30%;' placeholder="아이디" autofocus="autofocus">
          <Label>   
            <input type='checkbox' name='id_save' value='Y' 
                      ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>                   
        </div>
   
      </div>   
   
      <div class="form-group">
        <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
        <div class="col-md-8">
          <input type='password' class="form-control" name='passwd' id='passwd' 
                    value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
          <Label>
            <input type='checkbox' name='passwd_save' value='Y' 
                      ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>
        </div>
      </div>   
   
      <div class="form-group">
        <div class="col-md-offset-4 col-md-8">
          <button type="button" id='btn_login' class="btn btn-primary btn-md">로그인</button>
          <button type='button' onclick="location.href='/member/create.do'" class="btn btn-primary btn-md">회원가입</button>
          <!-- <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button> -->
          <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                      onclick="$('#div_login').hide();">취소</button>
        </div>
      </div>   
      
    </FORM>
  </DIV>
  <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="itemsVO" items="${list }" varStatus="status">
        <c:set var="itemsno" value="${itemsVO.itemsno }" />
        <c:set var="category_no" value="${itemsVO.category_no }" />
        <c:set var="item_name" value="${itemsVO.item_name }" />
        <c:set var="content" value="${itemsVO.content }" />
        <c:set var="recom" value="${itemsVO.recom_cnt }" />
        
        <c:set var="file1" value="${itemsVO.file1 }" />
        <c:set var="thumb1" value="${itemsVO.thumb1 }" />
        
        <c:set var="item_price" value="${itemsVO.item_price }" />
        <c:set var="discount" value="${itemsVO.discount }" />
        <c:set var="total_price" value="${itemsVO.total_price }" />
        <c:set var="item_point" value="${itemsVO.item_point }" />
        
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <a href="./read.do?itemsno=${itemsno}&now_page=${param.now_page }"><IMG src="/items/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/items/images/none1.png" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?itemsno=${itemsno}&now_page=${param.now_page }&search_word=${param.search_word}"><strong>${item_name}</strong> ${content}</a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <del><fmt:formatNumber value="${item_price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${discount} %</span>
            <strong><fmt:formatNumber value="${total_price}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${item_point}" pattern="#,###" /></span>
            <span><A id="recom_${status.count }" href="javascript:recom_ajax(${itemsno }, ${status.count })" class="recom_link">♥(${recom })</A></span>

            <%-- <span id="span_animation_${status.count }"></span> --%>
            <br>
            <button type='button' id='btn_cart' class="btn btn-info" style='margin-bottom: 2px;'
                        onclick="cart_ajax(${itemsno })">장바 구니</button><br>
            <button type='button' id='btn_ordering' class="btn btn-info" 
                        onclick="cart_ajax(${itemsno })">바로 구매</button>  
                                    
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="./update_text.do?itemsno=${itemsno}&now_page=${now_page }"><span class="glyphicon glyphicon-pencil"></span></A>
            <A href="./delete.do?itemsno=${itemsno}&now_page=${now_page }&category_no=${category_no}"><span class="glyphicon glyphicon-trash"></span></A>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
    </c:otherwise>
  </c:choose>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>