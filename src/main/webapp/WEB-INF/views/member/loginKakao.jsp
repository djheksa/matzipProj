<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	   
    
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript">
	function goJoin() {
		location.href='join';	
	}
	//window.onload=
		function loginWithKakao() {
	    Kakao.Auth.login({
	      success: function(authObj) {
	        alert(JSON.stringify(authObj))
	        Kakao.API.request({
        url: '/v2/user/me',
        success: function(res) {
          alert(JSON.stringify(res.account_email))
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
	function getData(){Kakao.API.request({
    url: '/v2/user/me',
    data: {
        property_keys: ["kakao_account.email","kakao_account.gender"]
    },
    success: function(response) {
        alert(response.kakao_account.email);
    },
    fail: function(error) {
        console.log(error);
    }
});
	}
	</script>
<style type="text/css">
/*  body,div,table,th,tr,td,input{  */
/*      border:1px solid red;  */
/*  }  */



td{
width: 250px;

}
body {
 	    background-image: url("./backImg/scale_1201.jpg");
 	 	 background-size:cover;
	   	 width:100%;
			margin-top: 150px;
}
.container{
	margin-top:150px;
	width:90%;
}
table,tr{
 	border:none; 
	display: block;
	position: relative;
 	margin: 20px 30px;
}
form {
 	opacity: 0.9;
  width: 80%;
  margin: 60px auto;
  background: #efefef;
  padding: 60px 120px 80px 120px;
  text-align: center;
  -webkit-box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
  box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
}
input{
	border:none;
	outline: none;
	width: 100%;
	padding: 10px;
	background: transparent;
}
.line-box {
  position: relative;
  width: 100%;
  height: 2px;
  background: #BCBCBC;
  display: block;
}

.line {

  position: absolute;
  width: 0%;
  height: 2px;
  top: 0px;
  left: 50%;
  transform: translateX(-50%);
  background: purple;
  transition: ease .6s;
}

.input:focus + .line-box .line {
  width: 100%;
}
button {
text-align: center;
  display: inline-block;
  padding: 12px 24px;
  background: rgb(220,220,220);
  font-weight: bold;
  color: rgb(120,120,120);
  border: none;
  outline: none;
  border-radius: 3px;
  cursor: pointer;
  transition: ease .3s;
}

button:hover {
  background: purple;
  color: #ffffff;
}

.frmLogin{
 position:absolute;
 width:40%;
 left:30%;
   

}
img{
  width: 80%;
  height: 60%;
  margin: 60px auto;
 }
 .a{
width: 10px; 
 }
</style>
</head>

<body>
<div class="container">



<div class="frmLogin">
<form action="login" name="frmLogin" method="post">
<h5 style="text-align: center; font-family: 'twaysky'; font-size: 16px;">맛집철도999</h5>
<table>
		<tr>
			<td class="a"><span class="glyphicon glyphicon-user"></span></td>
			<td><input type="text" class="input" name="id" placeholder="아이디" required>
			<span class="line-box"> 
			<span class="line"></span> 
			</span> </td>
		</tr>
		<tr>
			<td class="a"><span class="glyphicon glyphicon-lock"></span></td>
			<td><input type="password" class="input" name="password" placeholder="비밀번호" required>
			<span class="line-box"> 
			<span class="line"></span> 
			</span> </td>
		</tr>
</table>		
	<button type="submit">로그인</button> 
	<!-- 카카오톡으로 로그인 -->
	<a id="custom-login-btn" onclick="javascript:loginWithKakao()">
  <img
    src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
    width="222"
  />
</a>
<br>
<a onclick="javascript:logout()">카톡로그아웃</a>
<br>
<a onclick="javascript:getData()">정보가져오기</a>
	<hr>
	
	<div>
		<a href="findId">아이디찾기</a> |
	</div>
		
	<div>
	아직 회원이 아니신가요?
	<button type="button" class="btn btn-link" onclick="goJoin()">회원가입</button> 
	</div>
	</form>
</div>
</div>
</body>
</html>

