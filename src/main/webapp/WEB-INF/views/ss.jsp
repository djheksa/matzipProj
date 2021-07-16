<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<header>
        <div class="header">
            <!-- 로고 -->
            <a href="${pageContext.request.contextPath }/index"><i  id="logo999"><span id="logoName">맛집철도999</span></i></a>
            <ul class="memberForm">
                <button id="popup_open_btn" type="button"><li id="login">로그인</li></button>
                <a href="${pageContext.request.contextPath }/blog/list"><li id="freeboard">블로그</li></a>
                <a href="${pageContext.request.contextPath }/member/mypage?m_idx=${member.idx }"><li id="mypage">마이페이지</li></a>
                <a href="${pageContext.request.contextPath }/logout/logout"><li id="logout">로그아웃</li></a>
            </ul>
        </div>
    </header>

</body>
</html>