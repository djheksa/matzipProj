<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8"/>
   <title>Kakao 지도 시작하기</title>
           <!-- 제이쿼리 라이브러리 가져오기 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>       
</head>
<body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=74dc049c20df7fbe3faacde8bfe8db39&libraries=services"></script>
<script>
// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  
 var station='';
 var arr= [];
 var stationStr = '';

<c:forEach items="${stations}" var="stations">
		arr.push("${stations.st_name}");
</c:forEach>

var sid ='';
var sname ='';
var sphone= '';
var saddr='';                              
var surl = '';
var a_idx=0;
var sx ='';
var sy='';

  function searchPlaces() {
// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	for(var x=0;x<arr.length;x++){
	   ps.keywordSearch( arr[x]+' 맛집', displayPlaces); 
	  alert(arr[x]);
	}
}  
 
 
//검색 결과 목록과 마커를 표출하는 함수입니다
  function displayPlaces(places) {
     for ( var i=0; i<15; i++ ) {
    	
		sid += places[i].id +'/';
    	 sname += places[i].place_name+'/';
    	 sphone += places[i].phone + '/';
    	 stationStr+= arr[a_idx]+'/';
         saddr += places[i].address_name + '/';                          
         surl += places[i].place_url + ',';     
         sx += places[i].x + '/';
         sy += places[i].y + '/';
         if(i>=14){
        	 if(a_idx == arr.length-1){	
           		getListItem(sid, sname,sphone,stationStr,saddr,surl,sx,sy); 
           	}else{
         		a_idx++;
           	} 
         }
     }
 }    
 

function getListItem(sid, sname,sphone,stationStr,saddr,surl,sx,sy){
	var places ={
			 s_idx : sid,
             s_name : sname,
             s_phone : sphone,
             station : stationStr,
             s_addr : saddr,                                
             s_url : surl,
             x: sx,
             y: sy
	};
            $.ajax({
                            url: 'map',
    					    type: 'POST',  
                            dataType: 'json',
                            data: JSON.stringify(places),
                            contentType : 'application/json',
                            mimeType: 'application/json',
                            complete:function(xhr, status, msg) { 
                            window.location.href = './station?stationmap=${stationmap}';
					    } 
            });
            
} 
searchPlaces();

</script>
</body>
</html>