<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
        // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('74dc049c20df7fbe3faacde8bfe8db39');

        // SDK 초기화 여부를 판단합니다.
        console.log(Kakao.isInitialized());
    </script>
    <script type="text/javascript">
    var frm = document.getElementById(frm);
	function goJoin() {
		location.href='join';	
	}
	//window.onload=
		function loginWithKakao() {
	    Kakao.Auth.login({
	      success: function(authObj) {
	        Kakao.API.request({
        url: '/v2/user/me',
        success: function(res) {
        var nameTag = $("<input type=\'hidden\' name=\'name\'>").val(res.properties.nickname);
        //var nameTag = $("<input type=\'hidden\' name=\'name\'>").val('한글테스트');
         $('#id').val(res.kakao_account.email);
         $('#frm').append(nameTag);
         $('#frm').attr("action","./member/kakaoLogin");
         $('#frm').submit();
        },
        fail: function(error) {
          alert(
            'login success, but failed to request user information: ' +
              JSON.stringify(error)
          )
        },
      })
	      },
	      fail: function(err) {
	        alert(JSON.stringify(err))
	      },
	    })
	  }
	//연결끊기
		function logout(){Kakao.API.request({
			  url: '/v1/user/unlink',
			  success: function(response) {
			    console.log(response);
			  },
			  fail: function(error) {
			    console.log(error);
			  },
			});
		}
	//정보 가져오기
	function getData(){
		Kakao.API.request({
    url: '/v2/user/me',
    data: {
        property_keys: ["kakao_account.email","kakao_account.gender"]
    },
    success: function(response) {
        //alert(response.toStrig());
    },
    fail: function(error) {
        console.log(error);
    }
});
	}
	</script>
<title>Insert title here</title>
</head>
<body>

<form action="./member/login" method=post id="frm" accept-charset="utf-8">
  <div id="my_modal">
      <div class="modal_close_btn"><a href="#"><i class="fas fa-times"></i></a></div>
      <h2 id="title_box"><i class="fab fa-goodreads" id="logo999"></i><span id="login_title">맛집철도999</span></h2>
              <p class="login_box"><input type="text" name="id" placeholder="아이디 입력" id="id"></p>
              <p class="login_box"><input type="password" name="password" placeholder="비밀번호" id="password"></p>
              <p class="login_box"><input type="submit" value="로그인" id="login_btn"></p>
              	<!-- 카카오톡으로 로그인 -->
				<a id="custom-login-btn" onclick="javascript:loginWithKakao()">
 					 <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" />
</a>
<br>
<a onclick="javascript:logout()">카톡로그아웃</a>
<br>
<a onclick="javascript:getData()">정보가져오기</a>

              <p class="login_box">
                  <a href="./member/findId">아이디 찾기</a>&nbsp;&nbsp; | &nbsp;&nbsp;
                  <a href="./member/join">회원가입</a>
              </p>
  </div>
</form>

</body>
</html>