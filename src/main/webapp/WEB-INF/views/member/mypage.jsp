<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageStyle.css?v=3">
    <title>마이페이지</title>
    <script src="${pageContext.request.contextPath}/resources/js/javascript.js"></script>
    <script type="text/javascript">
    	function memberDelete(idx){
    		var c= confirm('정말로 탈퇴 하시겠습니까? 탈퇴 시 삭제된 정보는 복구되지 않습니다');
    		if(c){
    			location.href='./deleteMember?idx='+idx;
    		}else{
    			return false;
    		}
    	}
    </script>
</head>
<body>



<!-- Section -->
<div>
    <div id="mypage_Title">마이페이지</div>
    <hr>

    <!-- 내정보 수정 -->
    <div class="info_container">
        <div id="Title">내정보 수정</div>
         <form action="./mypage" method="POST" onsubmit="return infoValid()">
         <input type="hidden" name="idx" value="${member.idx }">
            <ul class="info_container2">
                <li><span>아이디</span></li>
                <li><input type="text" placeholder="아이디" readonly="readonly" value="${member.id }"></li>
                <li><span>비밀번호</span></li>
                <li><button type="button" class="info_btn" id="pwd_open">비밀번호 변경</button></li>
                <li><span>이름</span></li>
                <li><input type="text" placeholder="이름" readonly="readonly" value="${member.name }"></li>
                <li><span>전화번호</span></li>
                <li class="myPhone">
                    <input type="text" value="010" maxlength="3" id="myPhone1">
                    <input type="text" maxlength="4" id="myPhone2" value="${fn:substring(member.phone,3,7) }">
                    <input type="text" maxlength="4" id="myPhone3"value="${fn:substring(member.phone,7,12) }">
                    <input type="hidden" name="phone" id="totalPhone">
                </li>
                <li><span>나이</span></li>
                <li><input type="number" name="age" id="myAge" min="1" max="100" value="${member.age }"></li>
                <li><button class="info_btn" type="submit">변경하기</button></li>
                <li><button class="info_btn" type="button" onclick="memberDelete('${member.idx}')">회원탈퇴</button></li>
            </ul>
        </form>
    </div>

    <hr>
    <!-- ----------------------------------------------------------------------------------------------------------------------- -->
    <div class="list_container">
        <!-- 찜 목록 -->
        <ul class="heart_container2">
                <form action="" class="formBox">
                    
                    <div id="Title">찜 목록</div>
                    
                    <li class="heart_item">
                        <c:forEach var="sList" items="${ storeList}">
                        <div class="heart_item2">
                        <!-- 사진 -->
                        <!-- 제목 -->
                        <div class="subBox">
                            <a href="../store/store?s_idx=${sList.s_idx}" class="subTitle">${sList.s_name}</a> 
                        </div>
                        <!-- x버튼 -->
                        <div><button class="deleteBtn"><i class="fas fa-times pwd_close"></i></button></div>
                        </div>
                        </c:forEach>


                </li>
            </form>
            </ul>


        <!-- 내가 쓴 글 -->

        <ul class="freeboard_container2">
            <form action="" class="formBox">
                <!-- 타이틀 제목 -->
                <div id="Title">글 목록</div>

                <li class="freeboard_item">
<c:forEach var="blogList" items="${blogList }">
                    <!----------틀------------>
                    <div class="freeboard_item2">
                        <!-- 사진 -->
                       <a href="../blog/detail?idx=${blogList.idx }&page=1">
                    <img src="<spring:url value='/image/${blogList.imgList[0].img_name }'/>" alt="오류" class="mypage_img">
                    </a>
                        <!-- 제목 -->
                        <div class="subBox">
                            <a href="../blog/detail?idx=${blogList.idx }&page=1" class="subTitle">${blogList.subject }</a> 
                        </div>
                        <!-- x버튼 -->
                        <div><button class="deleteBtn"><i class="fas fa-times pwd_close"></i></button></div>
                        </div>
</c:forEach>
            </li>

        </form>
        </ul>

    </div>
    
</div>

<!-----------------------------------푸터 & 모달 부분--------------------------------->
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>

<%@ include file="./pwd_modal.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/pwd_modal.js"></script>

</body>
</html>