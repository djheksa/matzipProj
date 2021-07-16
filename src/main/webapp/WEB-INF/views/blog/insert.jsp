<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>블로그 글쓰기</title>
<script type="text/javascript">
	function saveWrite(){
		var frm=document.frm1;
		var subject = $('#subject');
		var s_name = $('#s_name');
		var content = $('#content');
		var file = $('#inputImgs');
		if(subject.val() == ''){
			alert('제목을 입력해 주십시오');
			subject.focus();
			return;
		}else if(s_name.val() == ''){
			alert('가게이름을 입력해 주십시오');
			s_name.focus();
			return;
		}else if(content.val() == ''){
			alert('내용을 입력해 주십시오');
			content.focus();
			return;
		}else if(file.val()==0){
		alert('사진은 1개 이상 등록해야 합니다');
		return;
		}
		var c = confirm('이대로 작성 하시겠습니까?');
		if(c){
		frm.submit();
		}else{
			return;
		}
	}
    var sel_files = [];
    $(function() {
		  $("#inputImgs").on("change", handleImgFileSelect);
	})
        // 이미지 정보들을 담을 배열
        function handleImgFileSelect(e) {
            // 이미지 정보들을 초기화
            sel_files = [];
            $("#imgs_wrap").empty();
 
            var files = e.target.files;
            if(files.length > 5){
					alert('사진은 5개까지 넣을 수 있습니다');
					$("#inputImgs").val("");
					return;
				}
            var filesArr = Array.prototype.slice.call(files);
            var index = 0;
            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("이미지 파일만 가능합니다");
                    return;
                }
                sel_files.push(f);
                var reader = new FileReader();
                reader.onload = function(e) {
                    var html = "<img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' width='200px' height='190px'>&nbsp&nbsp";
                    $("#imgs_wrap").append(html);
                    index++;
                }
                
                reader.readAsDataURL(f);
                
            });
        }
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
 	width:100%;
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
/* .td1{
	text-align: center;
} */
</style>
</head>
<body>

<div class="container1" style="width:100%">

<div class="container" style="text-align: right;">>
<br>
<h3>블로그 글쓰기입니다.</h3>
<hr>

<form action="insert" name="frm1" method="post" enctype="multipart/form-data"> 
<%-- <input type="hidden" name="bDto.midx" value="${member.idx }"> --%>
<input type="hidden" name="bDto.m_idx" value="${member.idx }">
<input type="hidden" name="page" value="${page }"/>

<div class="container" style="margin-bottom: 0px">

 <table class="table" style="text-align: center;">
 	<tr><td width="25%" class="td1">제목</td>
 		<td><input type="text" class="form-control validate" id = "subject" name="bDto.subject" placeholder="제목을 입력해주세요."size="70" class="input1" required="required"></td>
 	</tr>
 	<tr><td class="td1">작성자</td>
 		<td><input type="text" class="form-control" name="name" id = "name" value="${member.name }" size="70" class="input1" required="required"></td>
 	</tr>
 		<tr><td class="td1">가게이름</td>
 		<td class="left"><input type="text" class="form-control" name="bDto.s_name" id = "s_name" placeholder="가게이름을 입력해주세요."size="70" class="input1" required="required"></td>
 	</tr>
 	 <tr><td class="td1">역</td>
 	 	<td class="left"><select name="bDto.station" id = "station" class="form-control" required="required">
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
 	<tr><td class="td1">내용</td>  <!-- textarea 의 크기 : rows="20" cols="80" -->
 		<td><textarea placeholder="내용을 입력해주세요." class="form-control" rows="15" cols="80" name="bDto.content" class="input1" required="required"></textarea></td>
 	</tr>
 	<tr>
 		<td class="left" colspan="2">
 		*파일은 5개까지 추가 가능합니다.
 			<input type="file" name="iDto.file" id="inputImgs" multiple="multiple"><br>
 			<div id="imgs_wrap">
 			</div>
 		</td>
 	</tr>
 	<tr><td colspan="2" align="center">
 	<button type="button" class="btn btn-default" onclick="saveWrite()">
      <span class="glyphicon glyphicon-check"></span>저장
    </button>
   <span title="다시쓰기">
    <button type="reset" class="btn btn-default">
      <span class="glyphicon glyphicon-repeat"></span>
    </button>
    </span>
 	<a class="btn btn-default"  href="javascript:history.back();">
 		<span class="glyphicon glyphicon-align-left"></span>목록</a>
 	</td></tr>
 </table>
 </div>
 </form>
</div>
</div>
<%@ include file="../header.jsp" %>
<%@ include file="../footer.jsp" %>
</body>
</html>