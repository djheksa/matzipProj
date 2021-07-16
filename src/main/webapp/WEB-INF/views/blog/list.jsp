<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>블로그 리스트 view</title>
<style type="text/css">
/* table,td,tr,div{
	border : 1px soild red;
} */
@font-face {
    font-family: 'twaysky';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_tway@1.0/twaysky.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
h1,h3,h4,h5{
	font-family: twaysky;
}

body {
}
.container{

}
.container1{
	opacity: 0.9;
 	margin-top: 100px;
}
.span1,.span2{
	position: relative;
	top: 28px;
}
.glyphicon-thumbs-up{
	position: relative;
	top: 28px;
	float: right;
	margin-left:30px;
}
.glyphicon-eye-open{
	position: relative;
	top: 27px;
	float: right;
}


</style>
<script type="text/javascript">
	function insert(page){
		var idx ='${member.idx}';
		if(idx==''){
			alert('로그인한 사용자만 글을 작성할 수 있습니다');
			return;
		}else{
			location.href='insert?page='+page;
		}
	}
	function searchCheck(){
		var frm = document.frmSearch;
		var d1 = frm.findText.value;
		if(d1==""){
			alert('검색어를 입력해주세요.!!');
		}else{
			frm.submit();
		}
	}
	$(function(){
		$('.sort1').on('click',listSort)
		$('.sort2').on('click',listSort)
		$('.sort3').on('click',listSort)
		if('${category}'==$('.sort1').val()){
			$('.sort1').prop('checked',true);
		}else if('${category}'==$('.sort2').val()){
			$('.sort2').prop('checked',true);
		}else if('${category}'==$('.sort3').val()){
			$('.sort3').prop('checked',true);
		}
	})
	function listSort(){
		var page=${page.currentPage};
		var findText=$('#findText').val();
		var field=$('#field').val();
		var category=$(this).val();
		location.href='list?category='+category+'&findText='+findText+'&field='+field+'&page='+page;
	}
</script>
</head>
<body>

<div class="container1">

<div class="container" style="text-align: right;"><br>
<h3>블로그 리스트입니다.</h3>
<hr>
<form action="list"name="frmSearch">

<input type="radio" name="category" id="lastest" class="sort1" checked value="idx"> 
	<label for="lastest">최신순</label>
<input type="radio" name="category" id="b_count" class="sort2" value="b_count"> 
	<label for="b_count">조회순</label>
<input type="radio" name="category" id="b_recom" class="sort3" value="b_recom"> 
	<label for="b_recom">추천순</label>
	
<select style="width:10%; display:inline-block;" id = "field" name="field" class="form-control">
	<option value="역이름" <c:if test="${field=='역이름' }"> selected </c:if>>역이름</option>
	<option value="맛집이름" <c:if test="${field=='맛집이름' }"> selected </c:if>>맛집이름</option>
</select>

	<input style="width:30%; display:inline-block;" type="text" class="form-control" id="findText" name="findText" value="${findText}" placeholder="검색어를 입력하세요.">
	<button type="button" class="btn btn-default" onclick="searchCheck()">
      <span class="glyphicon glyphicon-search"></span>검색
    </button>
</form>
<hr>
</div>
<div class="container" style="margin-bottom: 0px">
<table class="table table-hover">
 <c:forEach var="vo" items="${list}">
	<tr>
 		<td>
 			<img src='<spring:url value='/image/${vo.imgList[0].img_name }'/>' width="200px" height="150px" />
 		</td>
 		<td ><a href="detail?idx=${vo.idx}&page=${page.currentPage}&findText=${findText}&field=${field}" class="subject">
 		<span style="font-weight: bold; font-size: 1.2em;" >${vo.subject }</span></a>
 		<br><br>
 		<c:set var="content" value="${vo.content}"/>
 		<a href="detail?idx=${vo.idx}&page=${page.currentPage}">${fn:substring(content,0,120)} ....</a>
 		<br><br>
 		<div> 
 			<span class="span1">#${vo.station } | #${vo.s_name } | 
			<fmt:parseDate pattern="yyyy-MM-dd'T'HH:mm" value="${vo.wdate }" var="wdate"/>
 			<fmt:formatDate value="${wdate }" pattern="yyyy-MM-dd"/></span>
 			<span class="glyphicon glyphicon-thumbs-up">	추천수: ${vo.b_recom } </span>
			<span class="glyphicon glyphicon-eye-open">	조회수: ${vo.b_count }</span>
		</div>
 		</td>
 	</tr>
 	</c:forEach>
 	
 </table>
 	<div>
 		<a class="btn btn-default" href="javascript:insert(${page.currentPage });">
 			<span class="glyphicon glyphicon-pencil"></span>글쓰기</a>
 		<a class="btn btn-default" href="${pageContext.request.contextPath }">홈</a>
 		<%-- <td>작성글 총 개수 : ${blists.totalCount}</td> --%>
	</div>
</div>
<!-- 페이지 이동 : 전체보기 -->
 <c:if test="${findText==null}">
 <div style="text-align: center;">
	<a class="pagenum" href="?page=1">&lt;&lt;</a>   <!-- 요청url은 동일하고 파라미터만 변경됩니다. -->
	<a class="${page.startPage>1? 'pagenum':'none'}" href="?page=${page.startPage-1 }">&lt;</a>  
	<!-- 현재페이지값을 변경 : blists.getStartPage() -1 -->
	
	<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">  <!-- 페이지목록의 범위  -->
		<a class="pagenum" href="?page=${i}">${i}</a>     <!-- 현재페이지 i값으로 변경  -->
	</c:forEach>
	
	<!-- 현재페이지값을 변경 : blists.getEndPage() +1 -->
	<a class="${page.endPage!=page.totalPage? 'pagenum':'none'}" href="?page=${page.endPage+1 }">&gt;</a> 
	<a class="pagenum" href="?page=${page.totalPage }">&gt;&gt;</a>
</div>
</c:if>

<!-- 페이지 이동 : 검색결과보기 -->
<c:if test="${findText!=null}">
<div style="text-align: center;">
	<a class="pagenum" href="?page=1&field=${field}&findText=${findText}&category=${category}">&lt;&lt;</a>   <!-- 요청url은 동일하고 파라미터만 변경됩니다. -->
	<a class="${page.startPage>1? 'pagenum':'none'}" href="?page=${page.startPage-1 }&field=${field}&findText=${findText}&category=${category}">&lt;</a>  
	<!-- 현재페이지값을 변경 : blists.getStartPage() -1 -->
	
	<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">  <!-- 페이지목록의 범위  -->
		<a class="pagenum" href="?page=${i}&field=${field}&findText=${findText}&category=${category}">${i}</a>     <!-- 현재페이지 i값으로 변경  -->
	</c:forEach>
	
	<!-- 현재페이지값을 변경 : blists.getEndPage() +1 -->
	<a class="${page.endPage!=page.totalPage? 'pagenum':'none'}" href="?page=${page.endPage+1 }&field=${field}&findText=${findText}&category=${category}">&gt;</a> 
	<a class="pagenum" href="?page=${page.totalPage }&field=${field}&findText=${findText}&category=${category}">&gt;&gt;</a>
</div>
</c:if>
</div>
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>
</body>
</html>