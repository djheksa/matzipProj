// 회원가입 유효성 검사
const valid = function(){
    const userId = document.getElementById('userId');
    const userPwd = document.getElementById('userPwd');
    const userName = document.getElementById('userName');
    const phone1 = document.getElementById('userPhone1'); 
    const phone2 = document.getElementById('userPhone2'); 
    const phone3 = document.getElementById('userPhone3'); 
    const age = document.getElementById('userAge');
    const idDouble = document.getElementById('idDouble');

    // 정규식
    const expIdText = /^[A-Za-z0-9+]*$/;
    const expNameText = /^[가-힣]+$/;
    const expPwdText = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,16}$/;
    const expHpText = /^[0-9]*$/;
	
	//폰번호 합치기
	const totalPhone = phone1.value+phone2.value+phone3.value;
    document.getElementById('totalPhone').value=totalPhone;
    
    //아이디 유효성 검사
    if(userId.value == '') {
        alert('아이디를 입력하세요.');
        userId.focus();
        return false;
    }
    //else if(!expIdText.test(userId.value)) {
   //     alert('영문 및 영문+숫자만 입력 가능합니다.');
   //     userId.focus();
   //     return false;
  //  }
   // else if(userId.value.length < 4 || userId.value.length > 20) {
     //   alert('아이디를 4자이상 20자 이하로 입력하세요');
    //    userId.focus();
     //   return false;
    //}

    //비밀번호 유효성 검사
    if(userPwd.value == ''){
        alert('비밀번호를 입력하세요.');
        userPwd.focus();
        return false;
    }else if(!expPwdText.test(userPwd.value)) {
        alert('비밀번호는 8자 이상 16자 이하이어야 하며,\n영문,숫자,특수문자 포함하여야 합니다.');
        userPwd.focus();
        return false;
    }
    
    //이름 유효성 검사
    if(userName.value.length < 2) {
        alert('이름의 형식을 확인해주세요.');
        userName.focus();
        return false;
    }else if(!expNameText.test(userName.value)) {
        alert('이름은 필수 입력입니다.\n공백없이 한글만 입력 가능합니다.');
        userName.focus();
        return false;
    }

    //휴대폰 번호 유효성 검사
    if(phone1.value == '' || phone1.value != '010'){
        alert('휴대폰번호 앞 3자리를 입력해주세요.');
        phone1.focus();
        return false;
    }else if(phone2.value == '' || phone2.value.length != 4 || !expHpText.test(phone2.value)){
        alert('휴대폰번호 숫자 4자리를 입력해주세요.');
        phone2.focus();
        return false;
    }else if(phone3.value == '' || phone3.value.length != 4 || !expHpText.test(phone3.value)){
        alert('휴대폰번호 숫자 4자리를 입력해주세요.');
        phone3.focus();
        return false;

    }

    if(age.value == ''){
        alert('나이를 입력하세요');
        age.focus();
        return false;
    }
    
    return true;
}

// 내정보 수정 유효성 검사
function infoValid() {
    const phone1 = document.getElementById('myPhone1'); 
    const phone2 = document.getElementById('myPhone2'); 
    const phone3 = document.getElementById('myPhone3');
    const age = document.getElementById('myAge');
	//폰번호 합치기
	const totalPhone = phone1.value+phone2.value+phone3.value;
    document.getElementById('totalPhone').value=totalPhone;
    const expHpText = /^[0-9]*$/;

    //전화번호 유효성
    if(phone1.value == '' || phone1.value != '010'){
        alert('휴대폰번호 앞 3자리를 입력해주세요.');
        phone1.focus();
        return false;
    }else if(phone2.value == '' || phone2.value.length != 4 || !expHpText.test(phone2.value)){
        alert('휴대폰번호 숫자 4자리를 입력해주세요.');
        phone2.focus();
        return false;
    }else if(phone3.value == '' || phone3.value.length != 4 || !expHpText.test(phone3.value)){
        alert('휴대폰번호 숫자 4자리를 입력해주세요.');
        phone3.focus();
        return false;
    }

    // 나이 유효성
    if(age.value == ''){
        alert('나이를 입력하세요');
        age.focus();
        return false;
    }
    return true;
}
//비밀번호 변경 모달 유효성
function modal_PwdValid() {
    const newPassword = document.getElementById('newPassword');
    const expPwdText = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,16}$/;

    if(newPassword.value == ''){
        alert('비밀번호를 입력하세요.');
        newPassword.focus();
        return false;
    }else if(!expPwdText.test(newPassword.value)) {
   		alert(newPassword.value);
        alert('비밀번호는 8자 이상 16자 이하이어야 하며,\n영문,숫자,특수문자 포함하여야 합니다.');
        newPassword.focus();
        return false;
    }
}
//뒤로가기
function back() {
    history.back();
}