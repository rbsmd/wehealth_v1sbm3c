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

    $(function() {
        $('#btn_login').on('click', login_ajax);
      });

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
              $('#div_login').hide();
              alert('로그인 성공');
              document.location.reload();

            } else {
              alert('로그인에 실패했습니다.');

            }
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        }
      );  //  $.ajax END

    }

    <%-- 공지사항 글 등록 --%>
    function notice_ajax(clicked_id, noticeno) {
      var f = $('#frm_login');

      // console.log('-> id:' + '${sessionScope.id}');
      if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
        $('#div_login').show();
      } else {  // 로그인 한 경우
          if ('${sessionScope.grade}' >= 1 && '${sessionScope.grade}' <= 10 ) {
        	 // create_ajax_post();   // 쇼핑카트에 insert 처리 Ajax 호출
              alert('관리자 계정 접속 확인');
              if(clicked_id == 'create'){
            	  location.href='/notice/create.do?';
              } else if(clicked_id == 'update') {
            	  location.href='/notice/update.do?noticeno='+noticeno;
              } else if(clicked_id == 'delete') {
            	  location.href='/notice/delete.do?noticeno='+noticeno;
              }

          } else{
        	  alert('권한이 없습니다.');
          }
      }

    }





</script>

</head>

<body>
<jsp:include page="../menu/top.jsp" />

<DIV class='title_line'>공지사항 > 목록</DIV>

<DIV class='content_body'>
    <ASIDE class="aside_right">
    <button type='button' id='create' onclick="notice_ajax(this.id)" style='padding: 0; border: none; background: none;'>등록</button>
  </ASIDE>

    <DIV class='menu_line'></DIV>

    <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
    <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
      <input type="hidden" name="contentsno" id="contentsno" value="contentsno">

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
          <button type='button' onclick="location.href='../member/create.do'" class="btn btn-primary btn-md">회원가입</button>
          <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                      onclick="$('#div_login').hide();">취소</button>
        </div>
      </div>

    </FORM>
  </DIV>
  <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>

  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 35%;'/>
      <col style='width: 15%;'/>
      <col style='width: 15%;'/>
      <col style='width: 20%;'/>
    </colgroup>

    <thead>
    <TR>
      <TH class="th_bs">공지사항<br> 번호</TH>
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">작성자</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>

    <tbody>
    <c:forEach var="noticeVO" items="${list}" varStatus="status">
      <c:set var="noticeno" value="${noticeVO.noticeno }" />
      <c:set var="title" value="${noticeVO.title }" />
      <c:set var="name" value="${noticeVO.name }" />
      <c:set var="rdate" value="${noticeVO.rdate.substring(0, 10) }" />
      <c:set var="notice_cnt" value="${notice_cnt }" />

      <TR>
        <TD class="td_bs"><p>${notice_cnt - status.index}</p></TD>
        <TD class="td_bs_left"><A href="./read.do?noticeno=${noticeno}" >${title }</A></TD>
        <TD class="td_bs">${name }</TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">
          <button type='button' id='update' onclick="notice_ajax(this.id, ${noticeno})" style='padding: 0; border: none; background: none;'><span class="glyphicon glyphicon-pencil"></span></button>
          <button type='button' id='delete' onclick="notice_ajax(this.id, ${noticeno})" style='padding: 0; border: none; background: none;'><span class="glyphicon glyphicon-trash"></span></button>
        </TD>
      </TR>
    </c:forEach>
    </tbody>

  </TABLE>
</DIV>


<jsp:include page="../menu/bottom.jsp" />
</body>

</html>