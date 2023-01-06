# matzipProj
맛집철도999 프로젝트

● 카카오API를 활용한 맛집정보 지도 마킹, 관련 사이트 정보를 활용해 데이터 가공 , 로그인 , 회원관리(카카오로그인) 기능 구현 , 게시판 구현 및 일부 기능 ajax 처리
  
 ### 프로젝트설명
 <img src="https://user-images.githubusercontent.com/86863254/127944684-4c971497-3955-4bcc-903c-575e976a37a1.png" width="49%"> <img src="https://user-images.githubusercontent.com/86863254/127944687-1d0cc8ed-0acf-4da3-b1cb-d2bb34bc14bd.png" width="49%">


### 1. 카카오 로그인 구현
  
  <img src="https://user-images.githubusercontent.com/86863254/127943613-3d6055bc-e819-474f-8bd3-cdedc0f0c6ad.png" width="80%">
  
### 2. 카카오맵 구현

<img src="https://user-images.githubusercontent.com/86863254/127943547-91bbbf71-43f2-41fc-b4b2-d12a1aec4a64.png" width="80%">

### 3. 글쓰기 이미지 미리보기

<img src="https://user-images.githubusercontent.com/86863254/127943185-99e8658c-2e9a-41bb-a0a2-4347fb424ca2.png" width="80%">

### API ###

--blog 관련 요청--
GET /blog/list - result : array 블로그 리스트
GET /blog/detail - result : object 블로그 상세보기
POST /blog/insert - result : boolean 글쓰기
POST /blog/update - result : boolean 수정
POST /blog/delete - result : boolean 삭제

--blog 추천기능 요청--
POST /blog/recom/{idx} - result : map 블로그 글 추천
GET blog/recomCount/{idx} -result : map 블로그 글 추천수

-- like 상품 찜하기 기능 요청 -- 
GET /like/insertLike result : boolean 찜목록 추가
GET /like/deleteLike result : boolean 찜목록 삭제 --> 클릭 이벤트 페이지에 따라 경로 구분되었음

-- member 회원 관련 요청 -- 
POST /member/kakaoLogin --> 첫 로그인시 추가정보 작성을 위한 회원가입 페이지로 이동
GET /member/login --> 일반 로그인
GET /member/join --> 회원가입 페이지
POST /member/join --> 회원가입 실행
GET /member/mypage --> 마이페이지 view
POST /member/mypage --> 마이페이지 정보 수정
POST /member/findId --> 아이디 찾기
POST /member/findPw --> 비밀번호 찾기
POST /member/changePassword --> 비밀번호 변경
POST /member/deleteMember --> 회원탈퇴 
GET /member/logout --> 로그아웃
POST /member/idDoubleCheck --> 중복체크

--review 관련요청 --
POST /store/store_review --> 리뷰작성
POST /store/review_delete --> 리뷰삭제

-- store 관련요청 --


