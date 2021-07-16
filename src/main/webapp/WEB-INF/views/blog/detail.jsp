<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath}/resources/js/javascript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
<title>블로그 상세 View</title>
<style type="text/css">
@font-face {
    font-family: 'twaysky';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_tway@1.0/twaysky.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
h1,h3,h4,h5{
	font-family: twaysky;
	font-size:1.3em;
}

body {
 	/* background-image: url("./backImg/freeboardList.jpg"); */
 	/* background-size:cover; */
}
form{
	background-color: white;
}
.container{
}
.container1{
	background-color: white;
	opacity: 0.9;
 	margin-top: 80px;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
//메인글 삭제 확인
function deleteOk(idx){
    var yn= confirm( '글을 삭제하시겠습니까?');

    if(yn){
        //alert('글 ' + idx +'를 삭제합니다.');
        location.href='delete?idx='+idx;
    }
}
	$(function(){
		recomUpdate();
		//recomSelect();
	});
	function recomUpdate(){
	$('#recomUp').on('click',function(){
			if('${member}' == ''){
				alert('로그인한 회원만 사용 가능한 서비스 입니다');		
				return false;
			}else{
				
		   var b_idx='${bean.idx}';
		   var m_idx='${member.idx}';
	        $.ajax({
	            url: 'recom/'+b_idx,
	            contentType: 'application/json;',
	            dataType: 'json',
	            data: JSON.stringify({m_idx:m_idx,b_idx:b_idx}),
	            type: 'POST',
	            success: function(res) {
	            	if(res.flag){
	            	alert(res.message);
	            	recomSelect();
	            	}else{
	            		alert(res.message);
	            		return;
	            	}
	            },
	            error : function(error){
	            	alert(error);
	            }
	            
	        });
			}
	});
	}
	   function recomSelect() {
	    	var idx = ${bean.idx};
	        $.ajax({
	            url: 'recomCount/'+idx,
	            type: 'GET',
	            success: function (res) {
	                $('#recomNum').html(res.count);
	            }
	        });
	    }

</script>
</head>
<body>

<div class="container1">

<br>
<hr>
<div class="container">
<h3 style="text-align: right;">블로그입니다.</h3>
<table class="table" style="table-layout: fixed;">
		<tr>
			<td class="td1" style="width: 15%;">제목</td>
			<td class="input1" style="font-weight: bold;">${bean.subject}</td>
			<td class="td1">역</td>
			<td class="input1" style="font-weight: bold;">${bean.station}</td>
		</tr>
		<tr>
			<td class="td1">가게이름</td>
			<td class="input1" style="font-weight: bold;">${bean.s_name}
			<td class="td1">추천수</td>
			<td class="input1" id="recomNum" style="font-weight: bold;">${bean.b_recom}</td>
		</tr>
		<tr>
			<td class="td1" style="vertical-align: middle;">내용</td>
			<td colspan="3" class="input1" style="text-align: left;">
				<div style="height: auto;" >
				<textarea class="form-control" rows="15" cols="80" name="bDto.content" class="input1" readonly="readonly" style="pointer-events: none;resize:none;background-color: white">${bean.content }</textarea>
					<%-- <pre style="background-color: white;overflow: hidden;" >${bean.content }</pre> --%>
					<br>
					<c:forEach var="img" items="${bean.imgList}">
   					<img src="<spring:url value='/image/${img.img_name }'/>" width="200px" />
					</c:forEach></div>
			</td>
			<!-- 엔터,탭,기호 등 텍스트 그대로 출력할 때 사용 -->
		</tr>
		<tr>
			<td colspan="4" align="center"><br>
			<button class="btn btn-default" id="recomUp">
				<span class="glyphicon glyphicon-thumbs-up">추천</span>	
			</button>
			
			 <c:if test="${bean.m_idx == member.idx || member.id == 'admin'}">
				<a class="btn btn-default"  href="update?func=view&idx=${bean.idx }&page=${page}">
					<span class="glyphicon glyphicon-edit"></span>수정</a>
				<a class="btn btn-default"  onclick="javascript:deleteOk(${bean.idx });">
					<span class="glyphicon glyphicon-trash"></span>삭제</a> 
			</c:if>
				<a class="btn btn-default"  href="list?page=${page }&findText=${findText}&field=${field}">
					<span class="glyphicon glyphicon-align-left"></span>목록</a><br> <br>
				<br>
			</td>
		</tr>
	</table>
</div>
</div>
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>
</body>
</html>