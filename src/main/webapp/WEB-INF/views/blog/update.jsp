<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>블로그 글쓰기</title>
<script type="text/javascript">
function saveWrite(){
	var frm=document.frm1;
	var c = confirm('이대로 수정 하시겠습니까?');
	if(c){
		frm.submit();
	}else{
		return;
	}
}
	$(function(){
		//imgDelete();
	});
	function imgDelete(idx){
	        $.ajax({
	            url: 'imgDelete/'+idx,
	            contentType: 'application/json;',
	            dataType: 'json',
	            data: JSON.stringify({idx:idx}),
	            type: 'POST',
	            success: function(res) {
	            	alert('삭제 완료!');
	            	location.reload();
	            	//recomSelect();
	            }
	        });
	}
	/*    function imgSelect() {
	    	var idx = ${bean.idx};
	        $.ajax({
	            url: 'imgSelect/'+idx,
	            type: 'GET',
	            success: function (res) {
	                $('#recomNum').html(res.count);
	            }
	        });
	    } */
</script>
<style type="text/css">
@font-face {
    font-family: 'twaysky';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_tway@1.0/twaysky.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
h1,h2,h3,h4,h5{
	font-family: twaysky;
}
body {
/*  	background-image: url("./backImg/freeboardList.jpg");
 	background-size:cover; */
}
form{
	background-color: white;
}
.container{

}
.container1{
	width: 100%;
	opacity: 0.9;
	margin-top: 80px;
}
</style>
</head>
<body>

<div class="container1" style="width:100%">

<div class="container" style="text-align: right;">
<br>
<h3>블로그 글수정입니다.</h3>
<hr>

<form:form action="./update" name="frm1" method="post"> 

<input type="hidden" name="idx" value="${bean.idx}">
<input type="hidden" name="pDto.page" value="${page}"/>

<div class="container" style="margin-bottom: 0px">

 <table class="table" style="text-align: center;">
 	<tr><td width="25%" class="td1" style="vertical-align: middle;">제목</td>
 		<td><input type="text" class="form-control validate" name="subject" value="${bean.subject}" size="70" class="input1" required="required"></td>
 	</tr>
 	<tr><td class="td1" style="vertical-align: middle;">작성자</td>
 		<td><input type="text" class="form-control" name="=id" value="${member.id}" size="70" class="input1" required="required"></td>
 	</tr>
 		<tr><td class="td1" style="vertical-align: middle;">가게이름</td>
 		<td class="left"><input type="text" class="form-control" name="s_name" value="${bean.s_name}" size="70" class="input1" required="required"></td>
 	</tr>
 	 <tr><td class="td1" style="vertical-align: middle;">역</td>
 	 	<td class="left"><select name="station" class="form-control" required="required">
							<option value="선유도">선유도</option>
							<option value="신논현" selected>신논현</option>
							<option value="신목동">신목동</option>
							<option value="석촌">석촌</option>
							<option value="김포공항">김포공항</option>
							<option value="여의도">여의도</option>
							<option value="노량진">노량진</option>
							<option value="종합운동장">종합운동장</option>
			</select></td>
 	</tr>
 	<tr><td class="td1" style="vertical-align: middle;">내용</td> 
 		<td><textarea class="form-control" rows="15" cols="80" name="content" class="input1" style="resize:none" required="required">${bean.content}</textarea></td>
 	</tr>
 	<tr>
<td class="left" colspan="2">
 		<c:forEach var="img" items="${bean.imgList}" varStatus="i">
 		<input type="hidden" name ="imgList[${i.index }].idx" id="idx" value="${img.idx }">
   		<img src="<spring:url value='/image/${img.img_name }'/>" width="200px" />
   		<span title="이미지삭제">
   		<input type="button" id="imgDeleteButton" onclick="imgDelete('${img.idx}')" value="X">
		</span>
		</c:forEach>
		</td>
 	</tr>
 	<tr><td colspan="2" align="center">
 	<button type="submit" class="btn btn-default" >
      <span class="glyphicon glyphicon-check"></span>저장
    </button>
   <span title="다시쓰기">
    <button type="reset" class="btn btn-default">
      <span class="glyphicon glyphicon-repeat"></span>
    </button>
    </span>
 	<a class="btn btn-default"  href="javascript:history.back()"> 
 		<span class="glyphicon glyphicon-align-left"></span>뒤로가기</a>
 	</td></tr>
 </table>
 </div>
 </form:form>
</div>
</div>
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>
</body>
</html>