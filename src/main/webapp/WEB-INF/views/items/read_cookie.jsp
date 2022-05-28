<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="itemsno" value="${itemsVO.itemsno }" />
<c:set var="category_no" value="${itemsVO.category_no }" />
<c:set var="item_name" value="${itemsVO.item_name }" />        
<c:set var="item_price" value="${itemsVO.item_price }" />
<c:set var="discount" value="${itemsVO.discount }" />
<c:set var="total_price" value="${itemsVO.total_price }" />
<c:set var="item_point" value="${itemsVO.item_point }" />
<c:set var="item_cnt" value="${itemsVO.item_cnt }" />
<c:set var="file1" value="${itemsVO.file1 }" />
<c:set var="file1saved" value="${itemsVO.file1saved }" />
<c:set var="thumb1" value="${itemsVO.thumb1 }" />
<c:set var="content" value="${itemsVO.content }" />
<c:set var="recom" value="${itemsVO.recom_cnt }" />
<c:set var="search_word" value="${itemsVO.search_word }" />
<c:set var="size1" value="${itemsVO.size1 }" />
 
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
      $('#btn_recom').on("click", function() { update_recom_ajax(${itemsno}); });
    $('#btn_login').on('click', login_ajax);
    $('#btn_loadDefault').on('click', loadDefault);

  });

  function update_recom_ajax(itemsno) {
    // console.log('-> contentsno:' + contentsno);
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
          // console.log('-> rdata: '+ rdata);
          var str = '';
          if (rdata.cnt == 1) {
            // console.log('-> btn_recom: ' + $('#btn_recom').val());  // X
            // console.log('-> btn_recom: ' + $('#btn_recom').html());
            $('#btn_recom').html('♥('+rdata.recom+')');
            $('#span_animation').hide();
          } else {
            $('#span_animation').html("지금은 추천을 할 수 없습니다.");
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

    // $('#span_animation').css('text-align', 'center');
    $('#span_animation').html("<img src='/items/images/ani04.gif' style='width: 8%;'>");
    $('#span_animation').show(); // 숨겨진 태그의 출력
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
            // alert('로그인 성공');
            $('#login_yn').val('YES'); // 로그인 성공 기록
            cart_ajax_post(); // 쇼핑카트에 insert 처리 Ajax 호출     
            
          } else {
            alert('로그인에 실패했습니다.\n잠시후 다시 시도해주세요.');
            
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
      cart_ajax_post();
    } else { // 로그인 안된 경우
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
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>
  <A href="../categorygrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../category/list_by_categorygrpno.do?categorygrp_no=${categorygrpVO.categorygrp_no }" class='title_link'>${categorygrpVO.categorygrp_name }</A> >
  <A href="./list_by_categoryno_search_paging.do?category_no=${categoryVO.category_no }" class='title_link'>${categoryVO.category_name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <c:choose>
        <c:when test = "${sessionScope.id == null || sessionScope.grade  >= 11}">
            <A href="javascript:location.reload();">새로고침</A>
            <span class='menu_divide' >│</span>
            <A href="./list_by_categoryno_search_paging.do?category_no=${categoryVO.category_no }&now_page=${param.now_page}&search_word=${param.search_word }">기본 목록형</A>    
            <span class='menu_divide' >│</span>
            <A href="./list_by_categoryno_grid.do?category_no=${categoryVO.category_no }">갤러리형</A>
        </c:when>
        <c:otherwise>
            <A href="./create.do?category_no=${categoryVO.category_no }">등록</A>
            <span class='menu_divide' >│</span>
            <A href="javascript:location.reload();">새로고침</A>
            <span class='menu_divide' >│</span>
            <A href="./list_by_categoryno_search_paging.do?category_no=${categoryVO.category_no }&now_page=${param.now_page}&search_word=${param.search_word }">기본 목록형</A>    
            <span class='menu_divide' >│</span>
            <A href="./list_by_categoryno_grid.do?category_no=${categoryVO.category_no }">갤러리형</A>
            <span class='menu_divide' >│</span>
            <A href="./update_text.do?itemsno=${itemsno}&now_page=${param.now_page}">수정</A>
            <span class='menu_divide' >│</span>
            <A href="./update_file.do?itemsno=${itemsno}&now_page=${param.now_page}">파일 수정</A>  
            <span class='menu_divide' >│</span>
            <A href="./delete.do?itemsno=${itemsno}&now_page=${param.now_page}&category_no=${category_no}">삭제</A> 
        </c:otherwise>
    </c:choose>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_categoryno_search.do'>
      <input type='hidden' name='category_no' value='${categoryVO.category_no }'>
      <c:choose>
        <c:when test="${param.search_word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='search_word' id='search_word' value='${param.search_word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='search_word' id='search_word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.search_word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_categoryno_search.do?category_no=${categoryVO.category_no}&search_word='">검색 취소</button>  
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
        <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
        <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                    onclick="$('#div_login').hide();">취소</button>
      </div>
    </div>   
    
  </FORM>
  </DIV>
  <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <c:set var="file1saved" value="${file1saved.toLowerCase() }" />
        <DIV style="width: 50%; float: left; margin-right: 10px;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <IMG src="/items/storage/${file1saved }" style="width: 100%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/items/images/none1.png" style="width: 100%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
        <DIV style="width: 47%; height: 260px; float: left; margin-right: 10px; margin-bottom: 30px;">
          <span style="font-size: 1.5em; font-weight: bold;">${item_name }</span><br>
          <span style="color: #FF0000; font-size: 2.0em;">${discount} %</span>
          <span style="font-size: 1.5em; font-weight: bold;"><fmt:formatNumber value="${total_price}" pattern="#,###" /> 원</span>
          <del><fmt:formatNumber value="${item_price}" pattern="#,###" /> 원</del><br>
          <span style="font-size: 1.2em;">포인트: <fmt:formatNumber value="${item_point}" pattern="#,###" /> 원</span><br>
          <span style="font-size: 1.0em;">(보유수량: <fmt:formatNumber value="${item_cnt}" pattern="#,###" /> 개)</span><br>
          <span style="font-size: 1.0em;">수량</span><br>
          <form>
          <input type='number' name='ordercnt' value='1' required="required" 
                     min="1" max="99999" step="1" class="form-control" style='width: 30%;'><br>
                     <button type='button' onclick="cart_ajax(${itemsno })" class="btn btn-info">바로 구매</button>
          <button type='button' onclick="cart_ajax(${itemsno })" class="btn btn-info">장바구니</button>           
          <button type='button' onclick="cart_ajax(${itemsno })" class="btn btn-info">바로 구매</button>
          <button type='button' id="btn_recom" class="btn btn-info">♥(${recom })</button>
          <span id="span_animation"></span>
          </form>
        </DIV> 

        <DIV>${content }</DIV>
      </li>
      <li class="li_none">
        <DIV style='text-decoration: none;'>
          검색어(키워드): ${search_word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/items/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1})  
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>