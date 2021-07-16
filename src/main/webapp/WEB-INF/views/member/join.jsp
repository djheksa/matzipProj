<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <title>회원가입 - 맛집철도999 | 맛집 플랫폼</title>
    <script src="${pageContext.request.contextPath}/resources/js/javascript.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <script type="text/javascript">
    $(function (){
    	checkId();
    });
    function checkId(){
    	$('#checkIcon').on('click',function(){
    		var id = document.getElementById('userId').value;
    		$.ajax({
	            url: './idDoubleCheck',
	            contentType: 'application/json;',
	            dataType: 'json',
	            
	            data: JSON.stringify({id:id}),
	            type: 'POST',
	            success: function(res) {
	            	alert(res.id+' 는 사용가능한 아이디 입니다');
	            	$('#idDouble').val('y');
	            },
	            error: function(error) {
	            	alert('이미 사용중인 아이디 입니다');
	            }
	        });
    		
    	});
    }
    </script>
</head>
<body>
<%@ include file="../header.jsp"  %>
        <section class="signUp">
            <h2 class="signUp_title">회원가입</h2>

           <form action="./join" method="POST" name="frmUser" class="form" onsubmit="return valid()">

                <label for="userId" class="form_label" style="text-align: left;">아이디</label>
                <div class="form_input-block">
                    <input type="text" name="id" id="userId" placeholder="아이디를 입력해주세요.">
                    <button id="checkIcon" title="중복체크" type="button"><i class="fas fa-user-check"></i></button>
                    <input type="hidden" id="idDouble">
                </div>

                <div class="form_input-block">
                    <label for="userPwd" class="form_label">비밀번호</label>
                        <input type="password" name="password" id="userPwd" class="" placeholder="******">
                </div>

                <div class="form_input-block">
                    <label for="userName" class="form_label">이름</label>
                    <input type="text" name="name" id="userName" placeholder="이름">
                </div>

                <div class="form_input-block">
                    <label for="userPhone" class="form_label">전화번호</label>
                </div>
                <div class="form_input-block" id="phone-Box">
                    <input type="text" name="phone1" id="userPhone1" placeholder="전화번호" maxlength="3" value="010">
                    <input type="text" name="phone2" id="userPhone2" placeholder="전화번호" maxlength="4">
                    <input type="text" name="phone3" id="userPhone3" placeholder="전화번호" maxlength="4">
                    <input type="hidden" name="phone" id="totalPhone">
                </div>

                <div class="form_input-block">
                    <label for="userAge" class="form_label">나이</label>
                    <input type="number" name="age" id="userAge" min="1" max="100" placeholder="나이">
                </div>

                <div class="btn">
                    <button class="button2" type="submit">가입</button>
                     <a href="${pageContext.request.contextPath }/index"><button class="button2" type="button">홈</button></a>
                </div>

            </form>
        </section>

        <%@ include file="../footer.jsp" %>
    </body>
    </html>