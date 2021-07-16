<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('74dc049c20df7fbe3faacde8bfe8db39');

	// SDK 초기화 여부를 판단합니다.
	console.log(Kakao.isInitialized());
</script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
	integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/login_modal.css?v=3">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>헤더</title>

<style>
@media screen and (max-width: 650px) {
	.header {
		flex-direction: column;
	}
}

html, body {
	margin: 0;
	padding: 0;
}

.header {
	width: 100%;
	height: 100px;
	display: flex;
	justify-content: space-between;
	font-size: 15pt;
	font-family: "Hi Melody", cursive;
	align-items: center;
	box-shadow: 1px 1px 10px gray;
	position: fixed;
	z-index: 3;
	background-color: white;
	top: 0;
}

#logo999 {
	color: #00c471;
	margin-left: 25px;
	font-size: 40px;
}

#logo999A {
	text-decoration: none;
}

.memberForm {
	display: flex;
	list-style: none;
}

.memberForm a {
	text-decoration: none;
	color: black;
}

.memberForm button {
	border: 0;
	background-color: white;
	font-family: "Hi Melody", cursive;
	font-size: 1.3rem;
	cursor: pointer;
}

.memberForm li {
	margin-right: 20px;
}

#logout, #login {
	font-size: 15pt;
}
</style>
<script type="text/javascript">
	function logout() {
		//연결을 끊는 메소드 다시 동의 받아야함
 		Kakao.API.request({
			url : '/v1/user/unlink',
			success : function(response) {
				console.log(response);
				location.href='${pageContext.request.contextPath}/member/logout?idx=${member.idx}';
			},
			fail : function(error) {
				alert('실패');
				console.log(error);
			},
		}); 
		//카카오 로그아웃 메소드
		 if (!Kakao.Auth.getAccessToken()) {
			console.log('카카오 로그인 되있지 않음');
			return false;
		}
		Kakao.Auth.logout(function() {
			console.log(Kakao.Auth.getAccessToken());
			
			return true;
		}); 
		
	}
</script>
</head>
<body>

	<header>
		<div class="header">
			<!-- 로고 -->
			<a href="${pageContext.request.contextPath }/index" id="logo999A"><i
				id="logo999"><span id="logoName">맛집철도999</span></i></a>
			<ul class="memberForm">
				<c:if test="${member==null }">
					<button id="login_open" type="button">
						<li id="login">로그인</li>
					</button>
				</c:if>
				<a href="${pageContext.request.contextPath }/blog/list"><li
					id="freeboard">블로그</li></a>
				<a
					href="${pageContext.request.contextPath }/member/mypage?idx=${member.idx }"><li
					id="mypage">마이페이지</li></a>
				<c:if test="${member != null }">
					<button type="button" onclick="logout()">
						<li id="logout">로그아웃</li>
					</button>
				</c:if>
			</ul>
		</div>
	</header>
	<%@ include file="./member/login_modal.jsp"%>
	<script
		src="${pageContext.request.contextPath}/resources/js/login_modal.js"></script>
	<c:if test="${login == 'do'}">
		<script type="text/javascript">
			alert('로그인이 필요한 서비스 입니다');
			openModal();
		</script>
	</c:if>
	<c:if test="${login == 'popUp'}">
		<script type="text/javascript">
			openModal();
		</script>
	</c:if>
</body>
</html>