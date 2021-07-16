<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>로그인 모달창</title>
<script>
	// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('74dc049c20df7fbe3faacde8bfe8db39');

	// SDK 초기화 여부를 판단합니다.
	console.log(Kakao.isInitialized());
</script>
<script type="text/javascript">
	var frm = document.getElementById(frm);
	function goJoin() {
		location.href = 'join';
	}
	//window.onload=
	function loginWithKakao() {
		Kakao.Auth
				.login({
					success : function(authObj) {
						Kakao.API
								.request({
									url : '/v2/user/me',
									success : function(res) {
										var nameTag = $(
												"<input type=\'hidden\' name=\'name\'>")
												.val(res.properties.nickname);
										$('#id').val(res.kakao_account.email);
										$('#frm').append(nameTag);
										$('#frm')
												.attr("action",
														"${pageContext.request.contextPath }/member/kakaoLogin");
										$('#frm').submit();
									},
									fail : function(error) {
										alert('login success, but failed to request user information: '
												+ JSON.stringify(error))
									},
								})
					},
					fail : function(err) {
						alert(JSON.stringify(err))
					},
				})
	}
	//연결끊기
	/* function logout(){Kakao.API.request({
		  url: '/v1/user/unlink',
		  success: function(response) {
		    console.log(response);
		  },
		  fail: function(error) {
		    console.log(error);
		  },
		});
	} */
	//정보 가져오기
	function getData() {
		Kakao.API
				.request({
					url : '/v2/user/me',
					data : {
						property_keys : [ "kakao_account.email",
								"kakao_account.gender" ]
					},
					success : function(response) {
						//alert(response.toStrig());
					},
					fail : function(error) {
						console.log(error);
					}
				});
	}
</script>

</head>
<body>

	<!-- 로그인 창 -->
	<!-- 로그인 창 -->
	<div class="loginModal hide">
		<div class="login_bg"></div>
		<form action="./member/login" method="POST" accept-charset="utf-8"
			id="frm">
			<div class="login_content">
				<!-- 로그인 창 -->
				<!-- 닫기버튼 -->
				<div>
					<button class="loginModal_close" title="끄기" type="button">
						<i class="fas fa-times login_close"></i>
					</button>
				</div>
				<!-- 로고 & 타이틀 -->
				<h2 id="title_box">
					<i id="logo999"></i><span id="login_title">맛집철도999</span>
				</h2>
				<!-- 아이디 -->
				<input type="text" id="id" name="id" placeholder="아이디 입력">
				<!-- 비밀번호 -->
				<input type="password" name="password" id="pw" placeholder="비밀번호">
				<!-- 아이디 찾기 & 회원가입 -->
				<p class="login_box">
					<a href="${pageContext.request.contextPath }/member/findId"
						class="login_addr">아이디 찾기</a>&nbsp;&nbsp; | &nbsp;&nbsp; <a
						href="${pageContext.request.contextPath }/member/findPw"
						class="login_addr">비밀번호 찾기</a>&nbsp;&nbsp; | &nbsp;&nbsp; <a
						href="${pageContext.request.contextPath }/member/join"
						class="login_addr">회원가입</a>
				</p>
				<!-- 로그인 버튼 -->
				<button type="submit" class="login_change">로그인</button>
				<a id="custom-login-btn" onclick="javascript:loginWithKakao()"
					class="kakao_login"> <img
					src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
					width="250" class="kakao_img" /></a>
			</div>
		</form>
	</div>

</body>
</html>