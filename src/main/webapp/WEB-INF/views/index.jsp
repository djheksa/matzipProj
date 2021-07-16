<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css?v=3">
    <script src="${pageContext.request.contextPath}/resources/js/javascript.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <title>맛집철도999 - 찐맛집들만 모아놓은 맛집추천 사이트</title>
    <script>
    // 왼쪽 버튼 toggle
    $(document).ready(function(){
        $(".leftBtn").click(function(){
            $(".A").toggle();
            $(".B").toggle();
        });
    });
    // 오른쪽 버튼 toggle
    $(document).ready(function(){
        $(".rightBtn").click(function(){
            $(".A").toggle();
            $(".B").toggle();
        });
    });

    // 마우스 오버
    $(document).ready(function() {
        $(".text").mouseover(function() {
            $(this).css("color","red");
        });
        $(".text").mouseout(function(){
            $(this).css("color","black");
            $(".A").css("border","5px solid #c09f1e");
        });
    });
</script>
</head>
<body>
    <%@ include file="header.jsp" %>
 

    <!-- section -->
    <section>
        <div class="bg">

            <div class="box">
                <button class="leftBtn mainBtn" type="button">이전</button>
                <span class="line">
                
                <c:forEach var="stations" begin="0" end="3" items="${stations}">
                  <div class="circle A">
                    <a href="store/station?stationmap=${stations.st_name}">
                      <p class="text" id="st"><strong >${stations.st_name} </strong></p>
                    </a>
                       </div>
                </c:forEach>    
                 <c:forEach var="stations" begin="4" end="${fn:length(stations)}" items="${stations}">
                 <div class="circle B">
                    <a href="store/station?stationmap=${stations.st_name}">
                      <p class="text" id="st"><strong>${stations.st_name} </strong></p>
                    </a>
                       </div>
                </c:forEach>    
                </span>
                <button class="rightBtn mainBtn">다음</button>

    </div>
    </section>
       <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <%@ include file="footer.jsp" %>

</body>
</html>




