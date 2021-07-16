<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
    <title>회원가입 - 맛집철도999 | 맛집 플랫폼</title>
    <script src="${pageContext.request.contextPath }/resources/js/javascript.js"></script>
</head>
<body>
<c:if test="${flag=='y' }">
	<script type="text/javascript">
		var confirm = confirm('카카오로 처음 로그인시 추가정보 입력이 필요합니다 작성하시겠습니까?');
		if(confirm){
		}else{
			history.back();
		}
		
	</script>
</c:if>
<c:if test="${kakaoData == null }">
	<script type="text/javascript">
		alert('잘못된 접근 입니다');
		history.back();
	</script>
</c:if>
<%@ include file="../header.jsp" %>
<section class="signUp">
    <section class="signUp">
            <h2 class="signUp_title">카카오 회원가입</h2>

            <form action="./join" method="POST" name="frmUser" class="form" onsubmit="return valid()">

                <label for="userId" class="form_label" style="text-align: left;">아이디</label>
                <div class="form_input-block">
                    <input type="text" name="id" id="userId" placeholder="아이디" value="${kakaoData.id }" readonly="readonly">
                    <button onclick="checkId()" id="checkIcon" title="중복체크" type="button"><i class="fas fa-user-check"></i></button>
                </div>

                <div class="form_input-block">
                    <label for="userPwd">비밀번호</label>
                        <input type="password" name="password" id="userPwd" class="" placeholder="******">
                        <p class="warning">
                            <span>영문 대소문자/숫자/특수 문자 3가지 필수 조합</span>
                            <span>12자 이상 32자 이하 입력 (공백 제외)</span>
                        </p>
                </div>

                <div class="form_input-block">
                    <label for="userName">이름</label>
                    <input type="text" name="name" id="userName" placeholder="이름" value="${kakaoData.name }" readonly="readonly">
                </div>

                <div class="form_input-block">
                    <label for="userPhone">전화번호</label>
                </div>
                <div class="form_input-block" id="phone-Box">
                    <input type="text" name="phone1" id="userPhone1" placeholder="전화번호" maxlength="3" value="010">
                    <input type="text" name="phone2" id="userPhone2" placeholder="전화번호" maxlength="4">
                    <input type="text" name="phone3" id="userPhone3" placeholder="전화번호" maxlength="4">
                    <input type="hidden" name="phone" id="totalPhone">
                </div>

                <div class="form_input-block">
                    <label for="userAge">나이</label>
                    <input type="number" name="age" id="userAge" min="0" max="100" placeholder="나이">
                </div>

                <div class="btn">
                    <button class="button2" type="submit">가입</button>
                    <a href="javascript:history.back()"><button class="button2" type="button">홈</button></a>
                </div>

            </form>
        </section>
<%-- <%@ include file="../footer.jsp" %> --%>

    </body>
    </html>