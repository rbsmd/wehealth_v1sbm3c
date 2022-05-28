<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Wehealth</title>
<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script type="text/javascript">
    window.onload = function() {

    }

    function recommend_exercise(){
      var url = '/tensorflow/recommend_exercise/start.do';
      var win = window.open(url, 'AI 서비스', 'width=1600px, height=560px');

      var x = (screen.width - 1600) / 2;
      var y = (screen.height - 560) / 2;

      win.moveTo(x, y); // 화면 중앙으로 이동
    }

    function chatting(){
        var url = '/tensorflow/chatbot/chatting.do/';
        var win = window.open(url, '챗봇', 'width=700px, height=630px');

        var x = (screen.width - 700) / 2;
        var y = (screen.height - 630) / 2;

        win.moveTo(x, y); // 화면 중앙으로 이동
      }
</script>
    
</head>
<body>
<jsp:include page="./menu/top.jsp" flush='false' />

  <DIV style='width: 100%; margin: 30px auto; text-align: center;'>
    <%-- /static/images/resort01.jpg --%>
    <IMG src='/images/wehealth.jpg' style='width: 100%;'>
  </DIV>
  
  <DIV style='width: 90%; margin: 30px auto; text-align: center;'>
 <jsp:include page="./items/main_list.jsp" flush='false' />
 </DIV>

<DIV style='width: 100%; margin: 30px auto; text-align: center; clear:both;'>
    <!-- 추천 시스템 프로젝트 -->
    <br><br>
    <button type="button" onclick="location.href='javascript: recommend_exercise()'" style="font-size: 20px; background-color: yellow;">🦾맞춤형 운동 추천 시스템🦾</button>
    <button type="button" onclick="location.href='javascript: chatting()'" style="font-size: 20px; background-color: #79ECFF;">💬실시간 문의(챗봇)💬</button>
    <H2 style="text-align: center; font-size:17px;">Tensorflow 2 model + Python + Django + Ajax + JSon 요청 처리</H2>
</DIV>

<jsp:include page="./menu/bottom.jsp" flush='false' />
 
</body>
</html>