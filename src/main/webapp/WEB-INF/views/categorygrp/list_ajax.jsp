<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dev.mvc.categorygrp.CategorygrpVO" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>wehealth</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
  $(function() {
    $('#btn_update_cancel').on('click', cancel);
    $('#btn_delete_cancel').on('click', cancel);
  });

  function cancel() {
    $('#panel_create').css("display","");  
    $('#panel_update').css("display","none"); 
    $('#panel_delete').css("display","none");
  }
  
// 수정폼
function read_update_ajax(categorygrp_no) {
  $('#panel_create').css("display","none"); // hide, 태그를 숨김 
  $('#panel_delete').css("display","none"); // hide, 태그를 숨김
  $('#panel_update').css("display",""); // show, 숨겨진 태그 출력 
  
  // console.log('-> categorygrp_no:' + categorygrp_no);
  var params = "";
  // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  params = 'categorygrp_no=' + categorygrp_no; // 공백이 값으로 있으면 안됨.

  $.ajax(
    {
      url: '/categorygrp/read_ajax.do',
      type: 'get',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
        // {"categrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
        var categorygrp_no = rdata.categorygrp_no;
        var categorygrp_name = rdata.categorygrp_name;
        var seq_no = rdata.seq_no;
        var print_mode = rdata.print_mode;
        var cdate = rdata.cdate;

        var frm_update = $('#frm_update');
        $('#categorygrp_no', frm_update).val(categorygrp_no);
        $('#categorygrp_name', frm_update).val(categorygrp_name);
        $('#seq_no', frm_update).val(seq_no);
        $('#print_mode', frm_update).val(print_mode);
        $('#cdate', frm_update).val(cdate);
        
        // console.log('-> btn_recom: ' + $('#btn_recom').val());  // X
        // console.log('-> btn_recom: ' + $('#btn_recom').html());
        // $('#btn_recom').html('♥('+rdata.recom+')');
        // $('#span_animation').hide();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    }
  );  //  $.ajax END

  // $('#span_animation').css('text-align', 'center');
  // $('#span_animation').html("<img src='/contents/images/ani04.gif' style='width: 8%;'>");
  // $('#span_animation').show(); // 숨겨진 태그의 출력
} 

// 삭제 폼(자식 레코드가 없는 경우의 삭제)
function read_delete_ajax(categorygrp_no) {
  $('#panel_create').css("display","none"); // hide, 태그를 숨김
  $('#panel_update').css("display","none"); // hide, 태그를 숨김  
  $('#panel_delete').css("display",""); // show, 숨겨진 태그 출력 
  // return;
  
  // console.log('-> categrpno:' + categrpno);
  var params = "";
  // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  params = 'categorygrp_no='+categorygrp_no; // 공백이 값으로 있으면 안됨.
  
  $.ajax(
    {
      url: '/categorygrp/read_ajax3.do',
      type: 'get',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
        // {"categrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
        var categorygrp_no = rdata.categorygrp_no;
        var categorygrp_name = rdata.categorygrp_name;
        var seq_no = rdata.seq_no;
        var print_mode = rdata.print_mode;
        // var rdate = rdata.rdate;
        var count_by_categorygrpno = parseInt(rdata.count_by_categorygrpno); // 카테고리 그룹에 속한 카테고리수
        console.log('count_by_categorygrpno: ' + count_by_categorygrpno);

        var frm_delete = $('#frm_delete');
        $('#categorygrp_no', frm_delete).val(categorygrp_no);
        
        $('#frm_delete_categorygrp_name').html(categorygrp_name);  // <label>그룹 이름</label><span id='frm_delete_name'></span>  
        $('#frm_delete_seq_no').html(seq_no);
        $('#frm_delete_print_mode').html(print_mode);
        
        if (count_by_categorygrpno > 0) { // 자식 레코드가 있다면
          // $('#frm_delete_count_by_categrpno').html(count_by_categrpno)  // X
          // $('#frm_delete_count_by_categrpno').append(count_by_categrpno) // 마지막 자식으로 추가
          // $('#frm_delete_count_by_categrpno').prepend('관련 카테고리 ' + count_by_categrpno + ' 건') // 처음부분에 추가
          $('#frm_delete_count_by_categorygrpno_panel').html('관련 카테고리 ' + count_by_categorygrpno + ' 건');
          $('#frm_delete_count_by_categorygrpno').show();

          // alert($('#a_list_by_categrpno').attr('href')); // ../cate/list_by_categrpno.do?categrpno=
          // $('#a_list_by_categrpno').attr('href', '../cate/list_by_categrpno.do?categrpno=' + categrpno); // A 태그 href 속성 변경
          $('#a_list_by_categorygrpno').attr('data-pk', categorygrp_no); // A 태그 data-pk 속성에 삭제할 categrpno pk 저장
          $('#a_delete_category_by_categorygrpno').attr('data-pk', categorygrp_no);
          $('#a_delete_items_by_all_categoryno').attr('data-pk', categorygrp_no);
        } else {
          $('#frm_delete_count_by_categorygrpno').hide();
        }
        // console.log('-> btn_recom: ' + $('#btn_recom').val());  // X
        // console.log('-> btn_recom: ' + $('#btn_recom').html());
        // $('#btn_recom').html('♥('+rdata.recom+')');
        // $('#span_animation').hide();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    }
  );  //  $.ajax END

  // 다수의 cateno를 전달하여 관련 contents 레코드 개수 산출
  $.ajax(
    {
      url: '/items/count_by_all_category_no.do',
      type: 'get',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
        // alert(rdata.cnt);

        if (rdata.cnt > 0) { // 자식 레코드가 있다면
            $('#count_by_all_category_no').show(); 
        } else {
          $('#count_by_all_category_no').hide();
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    }
  );  //  $.ajax END
} 

// 관련 카테고리 확인
function list_by_categorygrpno() {
  let categorygrp_no = $('#a_list_by_categorygrpno').attr('data-pk')  // A 태그 data-pk 속성의 값을 categrpno에 저장
  let url = '../category/list_by_categorygrpno.do?categorygrp_no='+categorygrp_no;

  let win = window.open(url, '카테고리 삭제', 'width=1000px, height=600px');
  let x = (screen.width - 1000) / 2;
  let y = (screen.height - 600) / 2;
   
  win.moveTo(x, y); // 화면 중앙으로 이동    
}

// 관련 카테고리 삭제(복구 안됨)
function delete_category_by_categorygrpno() {
  let sw = confirm('관련된 모든 카테고리가 삭제됩니다. 삭제후 복구 할 수 없습니다.\n 삭제를 진행하시겠습니까?')
    if (sw == true) {
          let categorygrp_no = $('#a_delete_category_by_categorygrpno').attr('data-pk')  // A 태그 data-pk 속성의 값을 categrpno에 저장
          // console.log('-> categrpno:' + categrpno);
          var params = "";
          // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
          params = 'categorygrp_no=' + categorygrp_no; // 공백이 값으로 있으면 안됨.
          
          $.ajax(
            {
              url: '/category/delete_by_categorygrpno.do',
              type: 'post',  // get, post
              cache: false, // 응답 결과 임시 저장 취소
              async: true,  // true: 비동기 통신
              dataType: 'json', // 응답 형식: json, html, xml...
              data: params,      // 데이터
              success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
                var cnt = parseInt(rdata.cnt);
            if (cnt > 0) {
              alert('관련 카테고리 ' + cnt + ' 건을 삭제했습니다.');  
                $('#a_delete_category_by_categorygrpno').hide();              
            } else {
                alert('관련 카테고리 삭제에 실패했습니다. \n관련 글이 존재하는 것 같습니다. \n관련 글을 모두 삭제해야 카테고리 그룹을 삭제 할 수 있습니다.');  
                  // $('#a_list_by_categorygrpno_proc').show();
                }
              },
              error: function(request, status, error) { // callback 함수
                console.log(error);
              }
            }
          );  //  $.ajax END       
  }    
}

</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>카테고리 그룹</DIV>

<DIV class='content_body'>
  <c:choose>
    <c:when test = "${sessionScope.id == null || sessionScope.grade  >= 11}">
      <TABLE class='table table-striped'>
        <colgroup>
          <col style='width: 10%;'/>
          <col style='width: 40%;'/>
        </colgroup>
       
        <thead>  
        <TR>
          <TH class="th_bs">출력 순서</TH>
          <TH class="th_bs">이름</TH>
        </TR>
        </thead>
        
        <tbody>
        <c:forEach var="categorygrpVO" items="${list}">
          <c:set var="categorygrp_no" value="${categorygrpVO.categorygrp_no }" />
          <c:set var="seq_no" value="${categorygrpVO.seq_no }" />
          <c:set var="categorygrp_name" value="${categorygrpVO.categorygrp_name }" />
          <TR>
            <TD class="td_bs">${seq_no }</TD>
            <TD class="td_bs_left"><A href="../category/list_by_categorygrpno.do?categorygrp_no=${categorygrp_no }">${categorygrp_name }</A></TD>   
          </TR>   
        </c:forEach> 
        </tbody>
       
      </TABLE>
    </c:when>
    <c:otherwise>
        <%-- 신규 등록 --%>
      <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
        <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
          <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">      
        
          <label>그룹 이름</label>
          <input type='text' name='categorygrp_name' id='categorygrp_name' value='' required="required" style='width: 25%;'
                     autofocus="autofocus">
      
          <label>순서</label>
          <input type='number' name='seq_no' id='seq_no' value='1' required="required" 
                    min='1' max='1000' step='1' style='width: 5%;'>
      
          <label>형식</label>
          <select name='print_mode' id='print_mode'>
            <option value='Y' selected="selected">Y</option>
            <option value='N'>N</option>
          </select>
           
          <button type="submit" id='submit' class='btn btn-xs' style="height: 22px; margin-bottom: 3px; background-color: #202052;color: white;">등록</button>
          <button type="button" onclick="cancel();" class='btn btn-xs' style="height: 22px; margin-bottom: 3px; background-color: #202052;color: white;">취소</button>
        </FORM>
      </DIV>
       
      <%-- 수정 --%>
      <DIV id='panel_update' 
              style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; 
                        text-align: center; display: none;'>
        <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
          <input type='hidden' name='categorygrp_no' id='categorygrp_no' value=''>
          <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">      
    
          <label>그룹 이름</label>
          <input type='text' name='categorygrp_name' id='categorygrp_name' value='' required="required" style='width: 25%;'
                     autofocus="autofocus">
      
          <label>순서</label>
          <input type='number' name='seq_no' id='seq_no' value='1' required="required" 
                    min='1' max='1000' step='1' style='width: 5%;'>
      
          <label>형식</label>
          <select name='print_mode' id='print_mode'>
            <option value='Y' selected="selected">Y</option>
            <option value='N'>N</option>
          </select>
           
          <button type="submit" id='submit' class='btn btn-xs' style="height: 22px; margin-bottom: 3px; background-color: #202052;color: white;">저장</button>
          <button type="button" id='btn_update_cancel' class='btn btn-xs' style="height: 22px; margin-bottom: 3px; background-color: #202052;color: white;">취소</button>
        </FORM>
      </DIV>
      
      <%-- 삭제 --%>
      <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
              width: 100%; text-align: center; display: none;'>
        <div class="msg_warning">카테고리 그룹을 삭제하면 복구 할 수 없습니다.</div>
        <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
          <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
          <input type='hidden' name='categorygrp_no' id='categorygrp_no' value=''>
            
          <label>그룹 이름</label>: <span id='frm_delete_categorygrp_name'></span>  
          <label>순서</label>: <span id='frm_delete_seq_no'></span>
          <label>출력 형식</label>: <span id='frm_delete_print_mode'></span>
          
          <%-- 자식 레코드 갯수 출력 --%>
          <div id='frm_delete_count_by_categorygrpno' 
                 style='color: #FF0000; font-weight: bold; display: none; margin: 10px auto;'>
            <span id='frm_delete_count_by_categorygrpno_panel'></span>     
            <br>
            <span id='count_by_all_categoryno'>『관련 카테고리의 글이 존재합니다 모두 삭제해주세요.』</span>
                  
            <%-- 『<A id='a_list_by_categrpno' href="" target='_blank'>관련 자료 삭제하기</A>』 --%>
            <A id='a_list_by_categorygrpno' href="javascript:list_by_categorygrpno();" data-pk='' >『관련 카테고리 확인』</A>
            
            <A id='a_delete_category_by_categorygrpno' 
                  href="javascript:delete_category_by_categorygrpno();" data-pk='' >『관련 카테고리 삭제(복구 안됨)』</A>
            
    
          </div>
           
          <button type="submit" id='submit' class='btn btn-xs' style="height: 22px; margin-bottom: 3px; background-color: #202052;color: white;">삭제</button>
          <button type="button" id='btn_delete_cancel' class='btn btn-xs' style="height: 22px; margin-bottom: 3px; background-color: #202052;color: white;">취소</button>
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
        // List<CategrpVO> list = (List<CategrpVO>)(request.getAttribute("list"));
        // for (CategrpVO categrpVO: list) {
        //    out.println(categrpVO.getName() + "<br>");
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
            <TD class="td_bs_left"><A href="../category/list_by_categorygrpno.do?categorygrp_no=${categorygrp_no }">${categorygrp_name }</A></TD>
            <TD class="td_bs">${cdate}</TD>
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
              <%-- <A href="./read_update.do?categrpno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A> --%>
              <%-- Ajax 기반 수정폼--%>
              <A href="javascript: read_update_ajax(${categorygrp_no })" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
              
              <%-- <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A> --%>
              <%-- Ajax 기반 Delete폼--%>
              <A href="javascript: read_delete_ajax(${categorygrp_no })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
              
              <A href="./update_seqno_up.do?categorygrp_no=${categorygrp_no }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
              <A href="./update_seqno_down.do?categorygrp_no=${categorygrp_no }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
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

