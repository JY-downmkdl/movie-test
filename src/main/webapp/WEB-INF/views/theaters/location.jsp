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
				        			<li onclick="revealthloc(<%= t.getThcode() %>,'<%= t.getThname() %>','<%= t.getThaddress()%>')">
				        				<a href="#"><%= t.getThname() %></a>
				        			</li>
				        			<%
				        		}
				        	%>
				        	</ol>
				        </div>
                	</li>
                </c:forEach>
                </ol>
            </div>
        </div>
        <script>
              //일 단위로 만들기 : 원하는 일수 * 1000 * 60 * 60 * 24
              $(document).ready(function(){
                  $(".date-list ul").html();
                  let now = new Date();
                  let arrDayStr = ['일','월','화','수','목','금','토'];
                  //가장 첫 머리에 첫 달 넣기
                  let str1 = "<li class='month dimmed'><div><span class='year'>"
                              +now.getFullYear()+"</span><span class='month'>"
                                  +(now.getMonth()+1)+"</span><div></li>";
                  $(".date-list ul").append(str1);

                  //let rday = '2023/08/31';
                  //let rrday = new Date(rday);
                  let afterday = new Date(Date.parse(now));
                  for(let i=0; i<10; i++){
                  	 let daystr = "<li data-date='"+afterday.getFullYear()+"-"
                  	 +("0"+(afterday.getMonth()+1)).slice(-2)+"-"+("0"+(afterday.getDate())).slice(-2)+" ("+ arrDayStr[afterday.getDay()]+")"+
                       "' class='day'><a href='#' onclick='dateClickListener(this)'><span class='dayweek'>"+arrDayStr[afterday.getDay()]
                           +"</span><span class='day'>"+afterday.getDate()+"</li><span class='sreader'></span></a></li>";
                       $(".date-list ul").append(daystr);
                      afterday = new Date(Date.parse(afterday)+ 1 * 1000 * 60 * 60 * 24);
                      
                      if (afterday.getDate()=='1'){
                          //console.log(beforeday.getDate());
                          let str = "<li class='month dimmed'><div><span class='year'>"
                              +afterday.getFullYear()+"</span><span class='month'>"
                                  +(afterday.getMonth()+1)+"</span><div></div></div></li>";
                          $(".date-list ul").append(str);
                      }
                  }
              })
      
       	</script>
        <script>
        $(document).ready(function(){
        	//alert($('.theaterLists .on ol li').first().find("a").html());
        	//영화관명
        	$('.theater-location-list_lists ol li').first().click();
        	
        	$('.theaterLists:first-child div').addClass('on');
        	
        	//revealthloc(thcode, thname, thaddress);
        	
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
					//i<= addlist.legnth 하게되면 길이가 인덱스 범위보다 많아서 에러난다.
					for(let i=0; i< addlist.length; i++){
						str+="<li onclick=\"revealthloc("+addlist[i].thcode+", \'"+addlist[i].thname+"\', \'"+addlist[i].thaddress+"\')\">"
						+"<a href='#'>"+addlist[i].thname+"<a><input type='hidden' name='schthname' value='"+addlist[i].thname+"'></li>"
						console.log(addlist[i].thname+"??");
					}
					console.log("내가 만든 문장을 봐바......",str);
					$(".theater-location-list_lists ol").html(str);
					let thcode= addlist[0].thcode;
					
					//revealthloc(thcode);
				},
				error : function(){
					alert("서버요청실패?");
				}
			})
        	
       	}
        //영화관 별 상영 시간푠
        function revealthloc(thcode, thname, thaddress){
        	$(".theater-schedules ol").html("");
			//결과 배열이 result이거나 길이가 0이면 함수종료 
			if(!thcode || thcode.length==0) { return; }
			
			let schthname = thname;
			let schthcode= thcode;
			let schaddress = thaddress;
			alert(schaddress +schthname+ schthcode+"!!!!!!!!!!!!!!!!");
			
			////$(".theater-location-h1").html(str2);
			let thinfo = ""
			thinfo+="<h1>"+schthname+"</h1><p>"+schaddress+"</p>"
			+"<input type='hidden' name='thcode' value='"+schthcode+"'>"
			$(".theater-location-h1").html(thinfo)
			
			// 날짜에 dimmed 주기
			let listitems = $(".date-list ul li.day");
			listitems.addClass("dimmed");
			
			$.ajax({
				url : "/schedules/readbythcode",
				type : "GET",
				data : {schthcode: schthcode},
 			    dataType:"json",
				success : function(result){
					// 각 movcode 개수 구하기
					console.log(result);
					
					let str1=""
					let str2=""
					<%--
					for(let i=0; i< result.length; i++){
						if(result[i] == result[result.length-1]){
							console.log("마지막",result[result.length-1].schtime);
							str1 += "<div>"+result[i].schall+"<span>"+result[i].schtime.substring(11,16)+"</span></div>";
							str2+="<li><p>"+result[i].movname+"</p>"
							str2+=str1+"</li>";
							console.log(result[i].movname+ result[i].schtime)
							$(".theater-schedules ol").append(str2);
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
					} --%>
					for(let j=0; j<listitems.length; j++){
   						console.log("j가 뭔데 : " + j)
   						let dateli = $(".date-list ul li.day:eq("+j+")");
   						let date =$(".date-list ul li.day:eq("+j+")").data("date").split(" ")[0];
   						for(let i=0; i<result.length; i++){
   							let text = result[i].schtime.substring(0,10);
       						if(date == text){
               					console.log("akfwha",date);
               					dateli.removeClass("dimmed");
               					console.log(dateli);
       						}
   						}
   					}
					
					let firstday = result[0].schtime.substring(0,10);
					viewfirst(schthcode,firstday);
					
				},
				error : function(){
					alert("서버요청실패");
				}
			})
		}
        
     	 //영화관 선택시 사용할 함수
		function viewfirst(schthcode, schtime) {
     		 let thcode = schthcode;
     		 let firstday= schtime;
     		 alert(thcode +"?"+ firstday);
	    	//상영관 정보 나오게
	    		$.ajax({
	   				url: '/tickets/readbytimes',
	   				data: {movcode: '', thcode:thcode, schtime:firstday},
	   				type: 'GET',
	   				dataType: 'json',
	   				success: function(result){
	   					console.log("상영관 정보" , result);
	   					if(result.length >0){
	   						for(let i=0; i<result.length; i++){
	   							
	   						}
	   					}
	   					else return;
	   				},
					error : function(){
						alert("서버요청실패");
					}
	   			})
		}
			
     	 //선택할 수 잇는 날짜 중 하나 아무거나 클릭 햇다면
		function dateClickListener(dateLi) {
			let thcode = $("input[name='thcode']").val();
			let schtime = $(dateLi).parent().data("date").substring(0,10);
    		alert(thcode +"?"+ schtime);
    	//상영관 정보 나오게
    		$.ajax({
   				url: '/tickets/readbytimes',
   				data: {movcode: '', thcode:thcode, schtime:schtime},
   				type: 'GET',
   				dataType: 'json',
   				success: function(result){
   					console.log("상영관 정보" , result);
   					if(result.length >0){
       					//showmovth(result);
   					}
   					else return;
   				},
				error : function(){
					alert("서버요청실패");
				}
   			})
		}
        </script>
		<div class="theater-location-h1">
			<h1><c:out value="${thlist[0].thname}"/></h1>
			<p><c:out value="${thlist[0].thaddress}"/></p>
			
		 </div>
		 <div class="theater-schedules">
		 	<div class="theater-date date-list">
		 		<ul class="">
		 		</ul>
		 	</div>
		 	<div class="sect-showtimes">
		 		<ul>
		 		</ul>
		 	</div>
		 </div>
		
    </div>
</div>

    <%@ include file="../footer.jsp" %>
</body>
</html>