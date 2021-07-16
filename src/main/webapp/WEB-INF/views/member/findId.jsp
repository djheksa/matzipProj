<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../header.jsp"  %>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<title>아이디 찾기</title>
</head>
<script type="text/javascript">
	function combiPhone(){
		var frm = document.frmFindId;
		if (frm.name.value == "") {
			alert("이름을 입력해주세요!");
			frm.name.focus();
			return false;
		}else if (frm.phone2.value == "" || frm.phone3.value == "") {
				alert("전화번호를 입력해주세요!");
				frm.phone.focus();
				return false;
		}
		
		phone1=document.getElementById('userPhone1');
		phone2=document.getElementById('userPhone2');
		phone3=document.getElementById('userPhone3');
		totalPhone=document.getElementById('totalPhone');
		var result = phone1.value+phone2.value+phone3.value;
		totalPhone.value=result;
	}
</script>
</head>
<body>
<section class="findId" style="width: 300px; height: 500px; margin:auto; margin-top: 10%;">
 <h2 class="findId_title" style="text-align: left;">아이디찾기</h2>
<form action="findId" method="post" name="frmFindId">
  	 <div class="form_input-block">
     	<label for="userName" class="form_label">이름</label><br>
        <input type="text" name="name" id="userName" placeholder="이름을 입력해주세요.">
      </div>
      
       <div class="form_input-block">
       	<label for="userPhone" class="form_label">전화번호</label><br>
       </div>
       <div class="form_input-block" id="phone-Box">
          <input type="text" name="phone1" id="userPhone1" placeholder="전화번호" maxlength="3" value="010" readonly="readonly">
          <input type="text" name="phone2" id="userPhone2" placeholder="****" maxlength="4">
          <input type="text" name="phone3" id="userPhone3" placeholder="****" maxlength="4">
          <input type="hidden" name="phone" id="totalPhone">
       </div>
       	
       <div class="btn">
       	<button class="button2" onclick="return combiPhone()" type="submit">아이디찾기</button>
       	<a href="../index"><button class="button2" type="button">홈</button></a>
       </div>

</form>
</section>
<c:if test="${findId!=null && findId != '' }">
<script type="text/javascript">
var findId = '${findId}';
alert('회원님의 아이디는 '+findId+' 입니다');
var confirm = confirm('로그인 하시겠습니까?');
if(confirm){
	location.href="../index?login=popUp";
}
</script>
</c:if>
</body>
</html>