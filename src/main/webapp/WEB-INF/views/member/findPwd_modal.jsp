<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 모달창</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypageStyle.css?v=3">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/pwd_modal.js?v=3">
</head>
<body>

<!-- 모달창 -->
<div class="pwModal hidden">
    <div class="pwBg"></div>
    <form action="./changePassword?findPw=y" method="POST" onsubmit="return modal_PwdValid()">
     <input type="hidden" id = "pwIdx" name="idx">
        <div class="content">
            <div><button class="closePwModal" title="끄기" type="button"><i class="fas fa-times pwd_close"></i></button></div>
            <h2 class="pwd_title">비밀번호 변경</h2>
            <input type="password" name="newPassword" id="newPassword" placeholder="새로운 비밀번호">
            <button type="submit" class="pwd_change">변경하기</button>
        </div>
    </form>
</div>
</body>
</html>