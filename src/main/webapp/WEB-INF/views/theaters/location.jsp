<%@page import="java.util.ArrayList"%>
<%@page import="org.movie.domain.TheaterDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp" %>
    <style>
        .contentsStart{
            margin-top: 80px;
        }
    </style>
</head>
<body>
<!-- 극장 -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<div id="contaniner" class="">
    <div id="contents" class="">
        <div class="theater-head contentsStart">
            <h3>극장</h3>
            <div class="theater-location-list">
                <ol>
                <c:forEach items="${locations}" var="location">
                	<li class="theaterLists">
               		<a href="#" onclick="Theatername(this)"><c:out value="${location}"/></a>
               		<input type="hidden" value="${location}" name="thaddress"/>
				        <div class="theater-head theater-location-list_lists">
				        	<ol>
				        	<% 
				        		List<TheaterDTO> thlist= (List)request.getAttribute("thlist");
				        		for(TheaterDTO t:thlist){
				        			%>
				        			<li onclick="revealthloc(<%= t.getThcode() %>,'<%= t.getThname() %>','<%= t.getThaddress()%>')"><a href="#"><%= t.getThname() %></a></li>
				        			<%
				        			
				        		}
				        	%>
				        	<!-- 
				        		<li onclick="revealthloc(${thcodes[0]},'${thnames[0]}','${thaddresses[0]}')"><a href="#">${thnames[0]}</a></li>
				        		<li onclick="revealthloc(${thcodes[1]},'${thnames[1]}','${thaddresses[1]}')"><a href="#">${thnames[1]}</a></li> -->
				        	</ol>
				        </div>
                	</li>
                </c:forEach>
                </ol>
            </div>
        </div>
        <script>
        $(document).ready(function(){
        	//alert($('.theaterLists:first-child ol li').html());
        	$('.theater-location-list_lists').html();
        	$('.theaterLists:first-child div').addClass('on');
        	//let str="";
        	//let thlist = ${thlist};
        	//for(let i=0; i<thlist.length; i++){
        	//	str="<li onclick=\"revealthloc("+thlist[i].thcode+", \'"+thlist[i].thname+"\', \'"+thlist[i].thaddress+"\')\">"+"<a href='#'>"+thlist[i].thname+"<a><input type='hidden' name='schthname' value='"+thlist[i].thname+"'></li>"
        	//	$('.theaterLists:first-child div ol').html(str);
        	//}
        	//$('.theaterLists:first-child div ol').html("<li>꺄아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ악</li>");
        	//$(".theater-schedules ol").html("");
        	
        })
       	function Theatername(location){
        	//지역명 받아오기
       		//alert($(location).siblings('input[name=thaddress]').val());
        	let locaddress = $(location).siblings('input[name=thaddress]').val();
        	let csrfHeaderName= "${_csrf.headerName}";
			let csrfTokenValue= "${_csrf.token}";
			$.ajax({
				url : "/theaters/readbycodeaction",
				type : "post",
				data : {locaddress: locaddress},
				beforeSend:function(xhr){
				       xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				   },
 			    dataType:"json",
				success : function(result){
					let addlist = result
					console.log(addlist);
					let str=""
					let str2="<h1>"+addlist[0].thname+"</h1><p>"+addlist[0].thaddress+"</p>";
					//ㅑ<= addlist.legnth 하게되면 길이가 인덱스 범위보다 많아서 에러난다.
					for(let i=0; i< addlist.length; i++){
						str+="<li onclick=\"revealthloc("+addlist[i].thcode+", \'"+addlist[i].thname+"\', \'"+addlist[i].thaddress+"\')\">"+"<a href='#'>"+addlist[i].thname+"<a><input type='hidden' name='schthname' value='"+addlist[i].thname+"'></li>"
						console.log(addlist[i].thname+"??");
					}
					console.log("내가 만든 문장을 봐바......",str);
					$(".theater-location-list_lists ol").html(str);
					let thcode= addlist[0].thcode;
					
					
					//revealthloc(thcode);
				},
				error : function(){
					alert("서버요청실패");
				}
			})
        	
       	}
        //영화관 별 상영 시간푠
        function revealthloc(thcode, thname, thaddress){
        	$(".theater-schedules ol").html("");
			//결과 배열이 result이거나 길이가 0이면 함수종료 
			if(!thcode || thcode.length==0) { return; }
			let schthname =thname;
			let schthcode= thcode;
			let schaddress = thaddress;
			alert(schaddress +schthname+ schthcode+"!!!!!!!!!!!!!!!!");
			
			////$(".theater-location-h1").html(str2);
			let thinfo = ""
			thinfo+="<h1>"+schthname+"</h1><p>"+schaddress+"</p>"
			$(".theater-location-h1").html(thinfo)
			
			let csrfHeaderName= "${_csrf.headerName}";
			let csrfTokenValue= "${_csrf.token}";
			$.ajax({
				url : "/schedules/readbythcode",
				type : "GET",
				data : {schthcode: schthcode},
				beforeSend:function(xhr){
				       xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				   },
 			    dataType:"json",
				success : function(result){
					// 각 movcode 개수 구하기
					console.log(result);
					
					let str1=""
					let str2=""
					for(let i=0; i< result.length; i++){
						if(result[i] == result[result.length-1]){
							console.log("마지막",result[result.length-1].schtime)
							return;
						}
						str1 += "<div>"+result[i].schall+"<span>"+result[i].schtime.substring(11,16)+"</span></div>";
						console.log(str1);
						if(result[i].movname != result[i+1].movname){
							str2+="<li><p>"+result[i].movname+"</p>"
							str2+=str1+"</li>";
							console.log(result[i].movname+ result[i].schtime)
							$(".theater-schedules ol").append(str2);
							str2="";
							str1="";
							
						}			
					}
					
				},
				error : function(){
					alert("서버요청실패");
				}
			})
		}
        </script>
		<c:choose>
			<%-- 만약 스케줄을 받아온다면 --%>
			<c:when test="${schedules}">
				<h3></h3>
			</c:when>
 			<%-- 맨 처음 화면 --%>
 			<c:otherwise>
				<div class="theater-location-h1">
					<h1><c:out value="${thlist[0].thname}"/></h1>
					<p><c:out value="${thlist[0].thaddress}"/></p>
				 </div>
				 <div class="theater-schedules">
				 	<ol>
				 		<h3 class="test">에옹에옹ㅇ</h3>
				 	</ol>
				 </div>
 			</c:otherwise>
 		</c:choose>
    </div>
</div>


</body>
</html>