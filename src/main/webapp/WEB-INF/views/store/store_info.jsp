<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
        rel="stylesheet">
    <!-- 제이쿼리 라이브러리 가져오기 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/resources/css/store_info.css"
        rel="stylesheet" type="text/css" />
    <!--Google Material Icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <title>${bean.s_name }</title>
</head>

<script>
    var form = document.createElement('form'); // set attribute (form) 
    form.name = 'form';
    form.method = 'post';

    kakaoImgApiInsert();
    function kakaoImgApiInsert() {
        $.ajax({
            type: "GET",
            url: "https://dapi.kakao.com/v2/search/image",
            headers: {
                'Authorization': 'KakaoAK 67e2c5177668932b3430e88db49758b8'  // 'KakaoAK 0000000000000000000000000000000000'
            },
            data: {
                'query': '${bean.s_name}' + ' ${bean.station}',
                'sort': '', //accuracy(정확도순) 또는 recency(최신순)
                'page': 1, //결과 페이지 번호, 1~50 사이의 값, 기본 값 1
                'size': 4//한 페이지에 보여질 문서 수, 1~80 사이의 값, 기본 값 80
            },
            success: function (jdata) {
                //console.log(jdata);
                $(jdata.documents).each(function (index) {
                    $("div#img").append('<a href="' + this.doc_url + '"><img src="' + this.thumbnail_url + '" width="300px" height="300px"/></a>');
                });
            },
            error: function (xhr, textStatus) {
                console.log(xhr.responseText);
                console.log("에러");
                return;
            }
        });
    }

    function btnlike(mid, sid, st) {
        if (mid == '') {
            alert('로그인 해주세요');
        } else {
            var s_idx = document.createElement("input");
            s_idx.type = "hidden";
            s_idx.name = "s_idx";
            s_idx.value = sid;

            var state = document.createElement("input");
            state.type = "hidden";
            state.name = "state";
            if (st == 'unlike') {
                state.value = 'like';
            } else {
                state.value = 'unlike';
            }
            form.action = 'store_like';
            form.appendChild(s_idx);
            form.appendChild(state);
            document.body.appendChild(form);
            form.submit();
        }

    }

    var star_val = 0;
    function clickstar(idx) {
        star_val = idx;
        for (var x = 0; x < 5; x++) {
            document.getElementById('star' + x).classList.remove('clicked');
            document.getElementById('star' + x).classList.remove('unclick');
        }
        for (var x = 0; x <= idx; x++) {
            document.getElementById('star' + x).classList.add('clicked');
        }
        star_val++;
    }

    function reviewWrite(mid, sid, midx) { //글쓰기 버튼
        if (mid == '') {
            alert('로그인 해주세요');
        }
        else if (star_val == 0) {
            alert('별점을 선택해 주세요');
        }
        else if ($('input:text[name="content"]').val() == '') {
            alert('내용을 입력해 주세요');
        }
        else {
            //리뷰작성 컨트롤러로
            form.action = 'store_review';

            //맛집 인덱스 값
            var s_idx = document.createElement("input");
            s_idx.type = "hidden";
            s_idx.name = "s_idx";
            s_idx.value = sid;

            //리뷰 내용
            var content = document.createElement("input");
            content.type = "hidden";
            content.name = "content";
            content.value = $('textarea[name="content"]').val();

            //회원 아이디 값
            var m_id = document.createElement("input");
            m_id.type = "hidden";
            m_id.name = "id";
            m_id.value = mid;

            //회원 인덱스 값
            var m_idx = document.createElement("input");
            m_idx.type = "hidden";
            m_idx.name = "m_idx";
            m_idx.value = midx;


            var star = document.createElement("input");
            star.type = "hidden";
            star.name = "star";
            star.value = star_val;

            form.appendChild(s_idx);
            form.appendChild(m_id);
            form.appendChild(m_idx);

            form.appendChild(content);
            form.appendChild(star);

            document.body.appendChild(form);
            form.submit();

        }

    }
    function delete_review(ridx, sid) {
        if (confirm("정말 삭제하시겠습니까?") == true) {
            alert("삭제되었습니다.");
            form.action = 'review_delete';


            var r_idx = document.createElement("input");
            r_idx.type = "hidden";
            r_idx.name = "r_idx";
            r_idx.value = ridx;
            form.appendChild(r_idx);

            var s_idx = document.createElement("input");
            s_idx.type = "hidden";
            s_idx.name = "s_idx";
            s_idx.value = sid;
            form.appendChild(s_idx);

            document.body.appendChild(form);
            form.submit();
        }
        else {
            return;
        }
    }

</script>

<body>

    <!-- 가게 상세 페이지 -->
    <div>
        <h2 class="store_Title">가게 상세 페이지</h2>          
<button class="material-icons back" onclick="location.href='./station?stationmap=${bean.station}'" >
arrow_back
</button>
    </div>
    </div>

    <div class="storeBg">
        <!-- 가게 약도 파트 -->
        <div id="store_img" class="box">
            <span class="subTitle">${bean.s_name}</span>
            <c:if test="${state eq 'like'}">
                <button id="btn_like" class="material-icons"
                    onclick="btnlike('${member.id}',${bean.s_idx},'like')"
                    style="color: pink; ">favorite</button>
            </c:if>
            <c:if test="${state eq 'unlike'}">
                <button id="btn_like" class="material-icons"
                    onclick="btnlike('${member.id}',${bean.s_idx},'unlike')"
                    style="background-color:#333;">favorite</button>
            </c:if>
            <hr>

            <div id="img"></div>
        </div>

        <!-- 가게 설명 파트 -->
        <div id="store_desc" class="box">
            <div>
                <span class="subTitle">${bean.s_name}</span>
                <hr>
            </div>
             <ul class="descContainer">
                <li class="descItem"><div class="head">별점</div>총:${star_avg} 
                    <c:if test="${star_avg>0}">
                        <c:forEach begin="0" end="${Math.round(star_avg)-1}">
                            <span class="material-icons star clicked">
                                star
                            </span>
                        </c:forEach>
                    </c:if>
                </li>
                <li class="descItem"><div class="head">맛집 주소 </div> ${bean.s_addr }</li>
                <li class="descItem"><div class="head">맛집 번호 </div> ${bean.s_phone }</li>
                <li class="descItem"><div class="head">상세페이지 </div> <a href="${bean.s_url}">${bean.s_name}으로 이동</a></li>
            </ul>
        </div>

        <!-- 가게리뷰 파트 -->
        <div id="store_review" class="box">
            <div id="review_title">

                <span class="subTitle">리 뷰</span>
                <hr>
                <div id="review_write">
                    <!-- <input type="text" value="" name="review" maxlength="50" placeholder="내용을 입력해주세요."> -->
                    <textarea name="content" id="review" maxlength="50"
                        placeholder="내용을 입력해주세요."></textarea>
                   <button id="btnReview" class="material-icons wirte" onclick="reviewWrite('${member.id }','${bean.s_idx}',${member.idx})" >
					edit
				</button>

                    <c:forEach var="i" begin="0" end="4">
                        <button id="star${i}" class="material-icons star unclick"
                            onclick="clickstar('${i}')">
                            star
                        </button>
                    </c:forEach>
                </div>

                <div id="reviews" class="box">
                    <c:forEach var="reviews" items="${reviews}">
                        <li class="reviewsItem">
                            <div id="content">
                                ${reviews.id} : ${reviews.content}
                            </div>
                            <div id="star">
                                <c:forEach begin="0" end="${reviews.star-1}">
                                    <span class="material-icons star clicked">
                                        star
                                    </span>
                                </c:forEach>
                                <c:if test="${reviews.id==member.id}">
                                    <button id="delete" class="material-icons"
                                        onclick="delete_review(${reviews.idx},'${bean.s_idx}')">delete_outline</button>
                                </c:if>
                            </div>
                        </li>
                    </c:forEach>
                </div>

            </div>
        </div>

    </div>
    <%@ include file="../header.jsp" %>
    <%@ include file="../footer.jsp" %>
</body>

</html>