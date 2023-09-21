<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<style>
.contentsStart {
	margin-top: 80px;
}
</style>
<title>예매하기</title>
</head>
<body>
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}">
	<input type="hidden" name="userid"
		value="﻿<sec:authentication property="principal.username"/>" />
<script type="text/javascript">
	$(document).ready(function(){
		let userid = $("input[name=userid]").val().trimStart();
		$("input[name=userid]").val(userid);
	})
</script>
	<!-- -------------------------------------------------------------- -->
	<!-- 예매 페이지 시작-->
	<div id="contaniner" class="">
		<div id="contents" class="">
			<div class="contentsStart">
				<div class="tit-heading-wrap">
					<h3>예매</h3>
				</div>
			</div>
			<div id="ticket">
				<div class="steps">
					<!-- step1-------------------- -->
					<div class="step step1" style="height: 600px; display: block;">
						<!--영화선택하기-->
						<div class="section section-movie">
							<div class="col-head" id="skip_movie_list">
								<h3>영화</h3>
							</div>

							<div class="col-body" style="height: 565px;">
								<div class="movie-select">
									<div class="sortmenu">
										<a class="button btn-rank selected">전체</a>
									</div>
									<div class="sortmenu">
										<a class="button btn-rank">가나다순</a>
									</div>
									<!------->

									<div class="movie-list nano has-scrollbar-y" id="movie_list">
										<ul class="content scroll-y"
											onscroll="movieSectionScrollEvent();" tabindex="-1">

											<!--영화 제목 반복-->
											<c:forEach items='${movList}' var="movlist">
												<li class="" onclick="movselect(this)"
													data-movcode="${movlist.movcode}"><a href="#"
													onclick="return false;" title="${movlist.movname}"
													alt="${movlist.movname}"> <i
														class="cgvIcon etc age${movlist.movgrade}">${movlist.movgrade}세</i>
														<span class="text">${movlist.movname}</span> <span
														class="sreader"></span>
												</a></li>
											</c:forEach>
											<!--영화 제목 반복 끝-->
											<script>
                                         	function movselect(movli) {
                                         		$(".date-list ul li.day").removeClass("selected");
                                        		$(".section-time .time-list .content").empty();
                                        		$(".btn-right").removeClass("on");
                                         		
                                         		//$(".content li").each((index, li)=>{
                                         		//	li.removeClass("selected");
                                         		//})
                                         		$(".movie-list .content li").removeClass("selected");
                                         		$(movli).addClass("selected")
                                         		
                                         		let movname = $(movli).find(".text").html();
                                         		//alert(movname);
                                         		let movcode = $(movli).data("movcode");
                                         		//alert("영화관 번호" + movcode);
                                         		
                                         		//영화 진행상황에 포스터 이미지, 몇 세 관람가인지 나타내기
                                         		$.ajax({
                                    				url: '/tickets/detail-view',
                                    				data: {movcode: movcode},
                                    				type: 'GET',
                                    				dataType: 'json',
                                    				success: function(result){
                                    					console.log("영화 클릭 ajax 결과 : " +result);
                                    					console.log("상영ㅅ간 : " + result.movrunningtime);
                                    					
                                    					//영화 포스터 받아오기
                                    					$(".movie").find(".movie_poster img").attr("src", "/display?fileName="+result.fullname+" ").css("display","inline");
                                    					//영화명에 디테일뷰로 이동시키기
                                    					$(".movie").find(".movie_title span a").attr("href","/movies/detail-view?movcode="+result.movcode+" ").html(result.movname)
                                    					$(".movie").find(".movie_rating span").attr("title", result.movgrade+"세 관람가").html(result.movgrade+"세 관람가");
                                    					
                                    					//$(".movie").find(".movie_title").css("display","block");
                                    					$(".movie").find(".movie_title, .movie_type, .movie_rating").css("display","block");
                                    					$(".movie").find(".placeholder").css("display","none");
                                    					
                                    					// 종료시간
                                    					$("input[name=endTime]").val(result.movrunningtime);
                                    					
                                    					// movcode
                                    					$("input[name=movcode]").val(result.movcode);
                                    				}
												})
                                   				selectTime();
                                         	}
                                         </script>
										</ul>
										<div class="pane pane-y"
											style="display: block; opacity: 1; visibility: visible;">
											<div class="slider slider-y" style="height: 50px; top: 0px;">
											</div>
										</div>
										<div class="pane pane-x"
											style="display: none; opacity: 1; visibility: visible;">
											<div class="slider slider-x" style="width: 50px;"></div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- 극장 선택하기 -->
						<div class="section section-theater">
							<div class="col-head" id="skip_theater_list">
								<h3>극장</h3>
							</div>

							<div class="col-body" style="height: 565px;">
								<div class="theater-select" style="height: 554px;">

									<!------->
									<div class="theater-list" style="height: 513px;">
										<div class="theater-area-list" id="theater_area_list">
											<ul>
												<!--반복시작-->
												<c:forEach items="${locations}" var="location">
													<li class=""><a href="#"
														onclick="theaterAreaClickListener(this)"> <span
															class="name">${location}</span> <span class="count">(110)</span>
													</a>
														<div
															class="area_theater_list nano has-scrollbar-y selected">
															<ul class="content scroll-y">
																<!--지 점명 반복 시작-->
																<li class="" style="display: list-item;"><a
																	href="#" data-thcode="${thcodes[0]}"
																	onclick="theaterListClickListener(this, ${thcodes[0]}, '${thnames[0]}', '${thaddresses[0]}')">
																		${thnames[0]} </a></li>
																<!--지점명 반복 끝-->
																<!--지점명 반복 시작-->
																<li class="" style="display: list-item;"><a
																	href="#" data-thcode="${thcodes[1]}"
																	onclick="theaterListClickListener(this, ${thcodes[1]}, '${thnames[1]}', '${thaddresses[1]}')">
																		${thnames[1]} </a></li>
																<!--지점명 반복 끝-->
															</ul>
														</div></li>
												</c:forEach>

												<!--반복 끝!~!-->
												<script>
                                               $(document).ready(function(){
                                            	   $(".theater-area-list ul > li").first().addClass("selected");
                                            		//alert($("input[name=userid]").val());
                                               })
                                               
                                               //지역명 클릭할 때
                                               //영화관 명 나오도록 하기
                                               function theaterAreaClickListener(event){
                                            	   //alert("좀 돼라");
	                                            	// li > a(event) > span.name = 지점명
	                                            	let locname = $(event).find(".name").html();
	                                            	$(".theater-area-list ul li").removeClass("selected");
	                                        		$(event).parent().addClass("selected");
	
	                                        		
	                                            	let csrfHeaderName= "${_csrf.headerName}";
	                                    			let csrfTokenValue= "${_csrf.token}";
	                                    			$.ajax({
	                                    				url : "/theaters/readbynameaction",
	                                    				type : "GET",
	                                    				data : {locname: locname},
	                                    				beforeSend:function(xhr){
	                                    				       xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	                                    				   },
	                                     			    dataType:"json",
	                                    				success : function(result){
	                                    					let addlist = result
	                                    					console.log(addlist);
	                                    					let str=""
	                                    					//let str2="<h1>"+addlist[0].thname+"</h1><p>"+addlist[0].thaddress+"</p>";
	                                    					//ㅑ<= addlist.legnth 하게되면 길이가 인덱스 범위보다 많아서 에러난다.
	                                    					for(let i=0; i< addlist.length; i++){
	                                    						str+="<li style='display: list-item;'>"
	                                    						+"<a href='#'  data-thcode='"+addlist[i].thcode+"' onclick=\"theaterListClickListener(this, "+addlist[i].thcode+", \'"+addlist[i].thname+"\', \'"+addlist[i].thaddress+"\')\" >"+addlist[i].thname+"</a>"
	                                    						+"</li>"
	                                    						console.log(addlist[i].thname+"??");
	                                    					}
	                                    					console.log("내가 만든 문장을 봐바......",str);
	                                    					$(".area_theater_list .content").html(str);
	                                    					//let thcode= addlist[0].thcode;
	                                    					
	                                    					
	                                    					//revealthloc(thcode);
	                                    				},
	                                    				error : function(){
	                                    					alert("서버요청실패");
	                                    				}
	                                    			})
	                                        		
                                               }
                                               
                                               //영화관명 클릭하면 색깔 바꾸ㅠㅣ고 아래에 극장 정보 뜨게
                                               function theaterListClickListener(event, thcode, thname, thaddress) {
                                            	   //alert("thname : " + thaddress);
                                            	    $(".date-list ul li.day").removeClass("selected");
                                           			$(".section-time .time-list .content").empty();
                                           			$(".btn-right").removeClass("on");
                                            	   
													//alert("우우우"+ event);
													$(".theater .name").css("display", "block");
													$(".theater .placeholder").css("display", "none");
													$(".theater .date").css("display", "block");
													$(".theater .number").css("display", "block");
													$(".theater .screen").css("display", "block");
													$(".theater .header").css("display", "block");
													$(".theater .name .data a").html(thname).attr("href", "/theaters/location?thname="+thaddress.substring(0,2));
													
													$(".area_theater_list ul li").removeClass("selected");
	                                        		$(event).parent().addClass("selected");
	                                        		$(".date-list ul li.day").removeClass("selected");
	                                        		
	                                        		//alert(thname);
	                                        		//step2에 입력
                                					$(".step2 span.site").html(thname);
	                                        		
	                                        		selectTime();
												}
                                               
                                               </script>
											</ul>

										</div>
									</div>

								</div>
							</div>
						</div>
						<!--극장 선택 끝-->

						<!--날짜 선택-->
						<div class="section section-date">
							<div class="col-head" id="skip_date_list">
								<h3>날짜</h3>
								<a href="#" onclick="return false;" class="skip_to_something">날짜
									건너뛰기</a>
							</div>
							<div class="col-body" style="height: 565px;">
								<!-- 날짜선택 -->
								<div class="date-list nano has-scrollbar-y" id="date_list">
									<ul class="content scroll-y" tabindex="-1">
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

									</ul>
									<div class="pane pane-y"
										style="display: block; opacity: 1; visibility: visible;">
										<div class="slider slider-y" style="height: 50px; top: 0px;">
										</div>
									</div>
									<div class="pane pane-x"
										style="display: none; opacity: 1; visibility: visible;">
										<div class="slider slider-x" style="width: 50px;"></div>
									</div>
								</div>
							</div>
						</div>
						<!--날짜 선택-->

						<!--영화 시간 선택하기-->
						<div class="section section-time">
							<div class="col-head" id="skip_time_list">
								<h3>시간</h3>
								<a href="#" class="skip_to_something"
									onclick="skipToSomething('tnb_step_btn_right');return false;">시간선택
									건너뛰기</a>
							</div>
							<div class="col-body" style="height: 565px;">
								<!-- 시간선택 -->
								<div class="time-option">
									<span class="morning">모닝</span><span class="night">심야</span>
								</div>
								<div class="placeholder">영화, 극장, 날짜를 선택해주세요.</div>
								<div class="time-list nano">
									<div class="content scroll-y" tabindex="-1"></div>
									<div class="pane pane-y"
										style="display: none; opacity: 1; visibility: visible;">
										<div class="slider slider-y" style="height: 50px;"></div>
									</div>
									<div class="pane pane-x"
										style="display: none; opacity: 1; visibility: visible;">
										<div class="slider slider-x" style="width: 50px;"></div>
									</div>
								</div>
							</div>
						</div>
						<!--영화 시간 선택하기-->
						<script>
                      		//만약 영화와 날짜가 선택되었다면??
            			   //let thdata = $(".theater .data a").html();
                        	function selectTime(){
                        		$(".date-list ul li.day").removeClass("selected");
                        		$(".section-time .time-list .content").empty();
                        		$(".btn-right").removeClass("on");
                        		
                        		
	            			   let movdata = $(".movie-list > ul > li.selected a .text").html();
	            			   let thdata = $(".theater-area-list .selected div > ul > li.selected a").html();
                        		if(movdata ===undefined || thdata ===undefined){
	                        		return;
                        		}
                        		
                        		let movcode = $(".movie-list > ul > li.selected").data("movcode");
                        		let thcode = $(".theater-area-list .selected div > ul > li.selected a").data("thcode");
                        		//alert("두개 다 알럿해라고"+movcode+","+ thcode);
                        		
                        		//스케쥴 테이블에서 극장코드와 무비코드로 찾기
                        		$.ajax({
                       				url: '/tickets/readbycodes',
                       				data: {movcode: movcode, thcode:thcode},
                       				type: 'GET',
                       				dataType: 'json',
                       				success: function(result){
                       					console.log(result);
                       					datastyle(result);
                       					
                       				},
                    				error : function(){
                    					alert("서버요청실패");
                    				}
                       			})
                       			
                        	}
                        	//dimmed 주는 함수
                   			function datastyle(schlist){
                   				let listitems = $(".date-list ul li.day");
                       			listitems.addClass("dimmed");
                        		if(schlist.length<1){
                        			$(".section-time .col-body .placeholder").removeClass("hidden");
                        			return;
                        		}
                        		
                        		for(let j=0; j<listitems.length; j++){
               						console.log("j가 뭔데 : " + j)
               						let dateli = $(".date-list ul li.day:eq("+j+")");
               						let date =$(".date-list ul li.day:eq("+j+")").data("date").split(" ")[0];
               						for(let i=0; i<schlist.length; i++){
               							let text = schlist[i].schtime.substring(0,10);
	               						if(date == text){
			               					console.log("akfwha",date);
			               					dateli.removeClass("dimmed");
			               					console.log(dateli);
	               						}
               						}
               					}
                        		
                   				<%--
                        		for(let i=0; i<schlist.length; i++){
                   					let text = schlist[i].schtime.substring(0,10);
                   					listitems.addClass("dimmed");
                   					
                   					for(let j=0; j<listitems.length; j++){
                   						console.log("j가 뭔데 : " + j)
                   						let dateli = $(".date-list ul li.day:eq("+j+")");
                   						let date =$(".date-list ul li.day:eq("+j+")").data("date")
                   						if(date == text){
    		               					console.log("akfwha",date);
    		               					dateli.removeClass("dimmed");
    		               					console.log(dateli);
                   						}
                   					}
                   				}--%>
                   			}
                   			
                   			//선택할 수 잇는 날짜 중 하나 아무거나 클릭 햇다면
                   			function dateClickListener(dateLi) {
                   				//n관 정보 삭제
                        		$(".section-time .time-list .content").empty();
                   				
								let movcode = $(".movie-list > ul > li.selected").data("movcode");
                        		let thcode = $(".theater-area-list .selected div > ul > li.selected a").data("thcode");
								let schtime = $(dateLi).parent().data("date");
                        		
								console.log("schtime : " ,schtime);
                        		$(".date-list ul li.day").removeClass("selected");
                        		$(dateLi).parent().addClass("selected");
                        		
                        		//진행 정보에 일시 넣어주기
                        		$(".theater .date .data").html(schtime);
                        		
                        		//상영관 정보 나오게
                        		$.ajax({
                       				url: '/tickets/readbytimes',
                       				data: {movcode: movcode, thcode:thcode, schtime:schtime.split(" ")[0]},
                       				type: 'GET',
                       				dataType: 'json',
                       				success: function(result){
                       					console.log("상영관 정보" , result);
                       					if(result.length >0){
	                       					showmovth(result);
                       					}
                       					else return;
                       				},
                    				error : function(){
                    					alert("서버요청실패");
                    				}
                       			})
							}
                   			
                   			
                   			//상영관 나타내기
                   			function showmovth(result) {
                   				console.log("결과내놔!!!!!!!!!!!!!!!!!!!!!!!: ",result);
                   				$(".section-time .col-body .placeholder").addClass("hidden");
                   				let str1="";
                   				let str2="";
                   				for(let i=0; i<result.length; i++){
	                   				console.log(result[i].schtime.substring(11,16));
	                   				console.log("대체 길이가 얼만데 : " + result.length);
	                                
	                   				if(result[i].schtime.substring(11,13) == '09'){
	                   					console.log("조조입니당");
	                   					str1 += "<li data-index='"+i+"' data-remain_seat='110' class='morning'"
	                   					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
	                   					 +"<a class='button' href='#'>"
	                   					 +"<span class='time'><span>"+result[i].schtime.substring(11,16)+"</span></span>"
	                   					 +"<span class='count'>"+result[i].seatcount+"</span>"
	                   					 +"<div class='seatlist sreader'>"+result[i].seatlist+"</div>"
	                   					 +"<span class='sreader mod'></span>"
	                   					 +"</a></li>";
	                   				}
	                   				else if(result[i].schtime.substring(11,13) == '00' ||result[i].schtime.substring(11,13) == '01'){
	                   					console.log("심야입니당");
	                   					str1 += "<li data-index='"+i+"' data-remain_seat='110' class='night'"
	                   					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
	                   					 +"<a class='button' href='#'>"
	                   					 +"<span class='time'><span>"+result[i].schtime.substring(11,16)+"</span></span>"
	                   					 +"<span class='count'>"+result[i].seatcount+"</span>"
	                   					 +"<div class='seatlist sreader'>"+result[i].seatlist+"</div>"
	                   					 +"<span class='sreader mod'></span>"
	                   					 +"</a></li>";
	                   				}
	                   				else{
		                   				str1 += "<li data-index='"+i+"' data-remain_seat='110'"
		                   					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
		                   					 +"<a class='button' href='#'>"
		                   					 +"<span class='time'><span>"+result[i].schtime.substring(11,16)+"</span></span>"
		                   					 +"<span class='count'>"+result[i].seatcount+"</span>"
		                   					 +"<div class='seatlist sreader'>"+result[i].seatlist+"</div>"
		                   					 +"<span class='sreader mod'></span>"
		                   					 +"</a></li>";
	                   				}
	                   				
	                   				
	                   				if(result[i] == result[result.length-1]){
            							console.log("마지막",result[result.length-1].schtime);
            							str2+="<div class='theater'>"
	                   						+"<span class='title'><span class='floor'>"+result[i].schall+"</span>"
											+"<span class='seatcount'>(총110석)</span>"
											+"</span><ul>";
											
	                   					str2+=str1+"</ul></div>";
	                   					$(".section-time .time-list .content").append(str2);
	                   					str2="";
										str1="";
            							return;
            						}
	                   					 
	                   				if(result[i].schall != result[i+1].schall){
		                   				console.log(str1);	 
	                   					str2+="<div class='theater'>"
	                   						+"<span class='title'><span class='floor'>"+result[i].schall+"</span>"
											+"<span class='seatcount'>(총110석)</span>"
											+"</span><ul>";
											
	                   					str2+=str1+"</ul></div>";
	                   					$(".section-time .time-list .content").append(str2);
	                   					str2="";
										str1="";
	                   				}
                   					
                   				}
									
							}
                   			
                   			//상영관 선택 및 영화 상영 정보 진행 목록에 입력
                   			function screenTimeClickListener(select) {
                   				//이미 선택한 상영관이면
                   				if($(select).closest("li").hasClass("selected")){
                   					return;
                   				}
                   				
                   				//alert("클릭3");
                   				$(".time-list .theater ul li").removeClass("selected");
                   				
                   				
                   			 <%--"<li data-index='"+i+"' data-remain_seat='110'"
           					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
           					 +"<a class='button' href='#'>" --%>
           					 	let schtime1 = $(".theater .date .data").html().substring(0,14);
                   				let schtime2 = $(select).find(".time span").html();
                   				let schall = $(select).closest(".theater").find(".floor").html();
                   				console.log("상영관 : " + schall);
                   				
                   				//셀렉트 클래스 넣기
                   				$(select).closest("li").addClass("selected");
                   
                   			   //진행 정보에 시간 넣어주기
                        		$(".theater .date .data").html(schtime1 + " " + schtime2).attr("title",schtime1+" "+schtime2);
                        		$(".theater .screen .data").html(" " + schall).attr("title", schall);
                        		$(".btn-right").addClass("on");
                        		
                        		//step 2에 시간 넣어주기
                   			    let datedata = $(".theater .date .data").html().split(" ");
                        		//2023-00-00
                        		$("p.playYMD-info b").eq(0).html(datedata[0])
                        		//(요일)
                        		$("p.playYMD-info b").eq(1).html(datedata[1])
                        		// 상영 시간
                        		// 종료시간 구하기
                        		let runningTime = Number($("input[name=endTime]").val());
                        		let startTime = new Date(datedata[0] + " " + datedata[2]);
                        		let endTime = new Date(Date.parse(startTime) + (runningTime * 1000 * 60 ));
                        		console.log("endTime : " + endTime);
                        		//("0"+(endTime.getMinutes()+1)).slice(-2)
                        		$("p.playYMD-info b").eq(2).html(datedata[2] + " ~ " + ("0"+(endTime.getHours())).slice(-2) + ":" + ("0"+(endTime.getMinutes())).slice(-2) )
                        		// 상영관
                        		$("p.theater-info .screen").html(schall);
                        		
                        		//좌석수 받아오기
                        		let seatcount = $(select).find(".count").html();
                        		let seatlist = $(select).find(".seatlist").html();
            					$("input[name=seatcount]").val(seatcount);
            					$("input[name=seatlist]").val(seatlist);
                        		
                        		
							}
                        	
                        </script>
					</div>
					<!-- step1 끝-------------------- -->

					<!-- step2-------------------- -->
					<div class="step step2" style="display: none;">
						<!-- SEAT 섹션 -->
						<div class="section section-seat dimmed">
							<div class="col-head" id="skip_seat_list">
								<h3>
									인원 / 좌석 <span class="sreader">인원/좌석선택은 레이어로 서비스 되기 때문에
										가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</span>
								</h3>
								<a href="#" class="skip_to_something"
									onclick="skipToSomething('tnb_step_btn_right');return false;">인원/좌석선택
									건너뛰기</a>
							</div>
							<div class="col-body">
								<div class="person_screen">
									<!-- NUMBEROFPEOPLE 섹션 -->
									<div class="section section-numberofpeople">
										<div class="col-body">
											<div id="nopContainer" class="numberofpeople-select"
												style="min-width: 426px;">
												<!-- 2021.05.25 - 좌석 거리두기 -->
												<!-- 최대 선택 가능 인원 표기 -->
												<div id="maximum_people"
													style="padding-bottom: 5px; text-align: right; font-size: 11px !important; color: red;">*
													최대 8명 선택 가능</div>

												<div class="group adult" id="nop_group_adult"
													style="display: block;">
													<span class="title">일반</span>
													<ul>
													</ul>
												</div>
												<script>
	                                       		$(document).ready(function(){
	                                                let str="";
	                                                for(let i=0; i<=8; i++){
	                                                    str +="<li data-count='"+i+"'' class='' type='' onclick='numberofpeople2(this)'>"
	                                                        +"<a href='#'>"
	                                                        +"<span class='sreader mod'></span>"
	                                                        +i+"<span class='sreader'>명</span>"
	                                                        +"</a></li>";
	                                                }
	                                                $(".person_screen .adult ul").html(str);
	                                                $(".person_screen .adult ul li .mod").html("일반");
	                                                $(".person_screen .adult ul li").attr("type", "adult");
	                                                $(".person_screen .adult ul li").first().addClass("selected");
	
	                                                $(".person_screen .youth ul").html(str);
	                                                $(".person_screen .youth ul li .mod").html("청소년");
	                                                $(".person_screen .youth ul li").attr("type", "youth");
	                                                $(".person_screen .youth ul li").first().addClass("selected");
	
	                                                $(".person_screen .child ul").html(str);
	                                                $(".person_screen .child ul li .mod").html("어린이");
	                                                $(".person_screen .child ul li").attr("type", "child");
	                                                $(".person_screen .child ul li").first().addClass("selected");
	
	                                                $(".person_screen .senior ul").html(str);
	                                                $(".person_screen .senior ul li .mod").html("경로");
	                                                $(".person_screen .senior ul li").attr("type", "senior");
	                                                $(".person_screen .senior ul li").first().addClass("selected");
	
	
	                                                let str2 = "<input type='hidden' name='selectCount' value='0' />";
	                                                $("#ticket .section").append(str2)
	                                            });
	                                            
	                                            
	                                            function numberofpeople2(list){
	                                            	//좌석리스트 초기화
	                                            	$(".info .seat_no .data").html("");
	                                            	$("input[name=seatlist]").val("");
	                                            	
	                                                //죄석 selected 클래스 제거
	                                                $("#seats_list .row .seat").removeClass("selected")
	                                                let fseleted = $(list).siblings(".selected");
	                                                let num = $(list).data("count");
	                                                let type = $(list).attr("type");
	                                                $(".person_screen ul li[type="+type+"]").removeClass("selected");
	                                                $(list).addClass("selected")
	                                                
	
	                                                let adultCount = $(".adult .selected").data("count");
	                                                let youthCount = $(".youth .selected").data("count");
	                                                let childCount = $(".child .selected").data("count");
	                                                let seniorCount = $(".senior .selected").data("count");
	
	                                                // 모든 카운트 합이 8을 넘지 않게
	                                                let selectCount = 0;
	                                                let data = $(".group .selected")
	                                                
	                                                for(let i =0; i<4; i++){
	                                                    //alert( $(data[i]).data("count"))
	                                                    selectCount += Number($(data[i]).data("count"));
	                                                    console.log("selectCpunt: " + selectCount);
	                                                    if(selectCount > 8){
	                                                        //selectCount=8;
	                                                        selectCount -= Number($(data[i]).data("count"));
	                                                        num
	                                                        alert("최대 선택 좌석은 8명입니다");
	                                                        $(list).removeClass("selected");
	                                                        $(fseleted).addClass("selected");
	                                                        return false;
	                                                    }
	                                                }
	                                                
	                                                console.log("벗어낫음", selectCount)
	                                                $("input[name='selectCount']").val(selectCount);
	                                                //는 나중에
	
	                                                let adult = adultCount>0? $(".adult .selected .mod").html() + " " + $(".adult .selected").data("count")+"명" : null;
	                                                let youth = youthCount>0? $(".youth .selected .mod").html() + " " + $(".youth .selected").data("count")+"명" : null
	                                                let child = childCount >0? $(".child .selected .mod").html() + " " + $(".child .selected").data("count")+"명" : null
	                                                let senior = seniorCount >0? $(".senior .selected .mod").html() + " " + $(".senior .selected").data("count")+"명" : null
	
	                                                
	                                                // 타입 n명, 타입 n명, ...
	                                                let array = [adult, youth, child, senior];
	                                                let array2 = []
	                                                for( let i in array){
	                                                    array[i] != null? array2.push(array[i]) : false;
	                                                }
	                                                console.log(array2);
	                                                let str2 = array2.join();
	                                                console.log(str2);
	                                                $(".tnb .info.theater .number .data").html(str2);
	
	                                                // 가격 정보 display 하는 함수 실행
	                                                displayPrice(str2);
	                                                return;
	                                            }
	
	                                        </script>
												<div class="group youth" id="nop_group_youth"
													style="display: block;">
													<span class="title">청소년</span>
													<ul>
													</ul>
												</div>
												<div class="group child" id="nop_group_child"
													style="display: block;">
													<span class="title">어린이</span>
													<ul>
													</ul>
												</div>
												<div class="group senior" id="nop_group_senior"
													style="display: block;">
													<span class="title">경로</span>
													<ul>
													</ul>
												</div>

											</div>
										</div>
										<a href="javascript:void(0)"></a>
									</div>
									<!-- NUMBEROFPEOPLE 섹션 -->
									<div class="section section-screen-select">
										<div id="user-select-info">
											<p class="theater-info">
												<span class="site">CGV 울산삼산</span> <span class="screen">IMAX관[9관]
													8층</span> <span class="seatNum">남은좌석 <b class="restNum">110</b>/<b
													class="totalNum">110</b></span>
											</p>
											<p class="playYMD-info">
												<b>2023.08.31</b><b class="exe">(목)</b><b>12:30 ~ 15:40</b>
											</p>
										</div>
									</div>
								</div>
								<!-- THEATER -->
								<div class="theater_minimap">
									<div class="theater nano" id="seat_minimap_nano">
										<div class="content" tabindex="-1">
											<div class="screen" title="SCREEN" style="width: 652px;">
												<span class="text"></span>
											</div>
											<div class="seats" id="seats_list"
												style="width: 450px; height: 224px;">
												<script>
	                                        function step2Start(){
	                                        	
	                                        	//예약된 좌석 목록
		                                        //const reservated = ["A1", "K7"];
		                                        let reservated = $("input[name=seatlist]").val().split(",");
		                                        console.log("예약된 좌석 목록 : "+ reservated)
		                                        
		                                        //A열 ~ K열 까지 : 11 row
	                                            //숫자는 10까지
	                                            const seatTR = ["A","B","C","D","E","F","G","H","I","J","K"];
	                                        
	                                            let str1="";
	                                            let str2="";
	                                            for(let a in seatTR){
	                                                //A열
	                                                str1 = "<div class='row'><div class='label'>"+seatTR[a] + "</div>"
	                                                for(let i=1; i<=10; i++){
	                                                    str2 += "<div data-seatnum='"+(seatTR[a]+i)+"' class='seat"
	                                
	                                                    for(let b in reservated){
	                                                        if((seatTR[a]+i)===reservated[b]){
	                                                            str2+=" reserved";
	                                                        }
	                                                    }
	                                                    
	                                                    str2 +="'><a href='#'><span class='no'>"+(seatTR[a]+i)+"</span></a></div>";
	                                                }
	                                                //console.log(str2);
	                                                $(".seats").append(str1+ str2+"</div>");
	                                                str1="";
	                                                str2="";
	                                            }
	                                            $(".row").find(".seat:eq(1)").css("margin-right","50px");
	                                            $(".row").find(".seat:eq(7)").css("margin-right","50px");
	                                
	                                            // 남은 좌석 나타내기
	                                            let seat = document.querySelectorAll("#seats_list .row .reserved");
	                                            console.log(seat);
	                                            let reservedSeat = seat.length;
	                                            console.log(reservedSeat);
	                                            let remainSeat = Number($(".seatNum .totalNum").html()) - reservedSeat;
	                                            $(".seatNum .restNum").html(remainSeat);
	
	
	                                            
	                                          //클릭 시 빨간색 되고, 죄석 정보에 나타내기
	                                            $("#seats_list .row .seat").on("click", function () {
	                                                $(".info.seat .placeholder").css("display", "none");
	                                                
	                                                let sc = Number($("input[name='selectCount']").val());
	                                                //내가 선택한 좌석
	                                                let selected = $(this).find(".no").html()
	                                                
	                                                //선택한 좌석 배열
	                                                let selectSeats = $(".info .seat_no .data").html().split(",")
	                                                console.log("selectSeats : " + selectSeats);
	
	                                                //예약된 좌석이면 return
	                                                if($(this).hasClass("reserved")){
	                                                    return;
	                                                }
	                                                if($(this).hasClass("selected")){
	                                                    $(this).removeClass("selected");
	                                                    $(".btn-right").removeClass("on");
	                                                    let selectSeats2 = selectSeats.filter((s)=> s != selected).sort();
	                                                    $(".info .seat_no .data").html(selectSeats2.join(","))
	                                                    $("input[name='selectCount']").val(sc+1);
	                                                    console.log("선택 해제 : " + selectSeats2.length);
	
	                                                    selectSeats2.length <=1 ? 
	                                                        $(".info.seat .placeholder").css("display", "block")
	                                                        + $(".info .seat_no").css("display", "none")
	                                                        : false;
	                                                    //진행목록에 좌석선택 다시 보이게
	                                                    return;
	                                                }
	                                                console.log("함수실행", sc)
	                                                let seatSeleted = document.querySelectorAll("#seats_list .row .selected").length;
	                                                if(sc == 0){
	                                                    if(seatSeleted ==0 ){
	                                                        alert("인원을 선택해주세요");
	                                                    }
	                                                    if(seatSeleted>0){
	                                                        alert("좌석을 모두 선택하셨습니다");
	                                                    }
	                                                    return;
	                                                }
	                                                
	                                                $(this).addClass("selected");
	                                                //진행상황 좌석 display block;
	                                                $(".info .seat_no").css("display", "block");
	
	                                                //진행상황 좌석선택에 넣기
	                                                selectSeats.push(selected);
	                                                selectSeats.sort();
	                                                $(".info .seat_no .data").html(selectSeats.join(","));
	                                                $("input[name='selectCount']").val(sc-1);
	                                                
	                                                // 결제 버튼 활성화
	                                                if(sc-1 == 0){
	                                                    $(".btn-right").addClass("on");
	                                                }
	                                            });
	                                        }
	
	                                        
	                                    </script>
											</div>

										</div>
										<div class="pane pane-y"
											style="display: none; opacity: 1; visibility: visible;">
											<div class="slider slider-y" style="height: 50px;"></div>
										</div>
										<div class="pane pane-x"
											style="display: none; opacity: 1; visibility: visible;">
											<div class="slider slider-x" style="width: 50px;"></div>
										</div>
									</div>
									<div class="legend" style="width: 125px;">
										<div class="seat-icon-desc">
											<span class="icon selected"><span class="icon"></span>선택</span>
											<span class="icon reserved"><span class="icon"></span>예매완료</span>
											<span class="icon notavail"><span class="icon"></span>선택불가</span>
											<!-- 2021.05.25 - 좌석 거리두기 -->
											<!-- 거리두기 좌석 범례 표기 -->
											<span class="icon distanced" style="display: none;"><span
												class="icon"></span>거리두기 좌석</span>
										</div>
										<div class="mouse_block"></div>
									</div>
								</div>
							</div>
							<a class="btn-refresh" href="#"> <span>다시하기</span>
							</a>
						</div>
					</div>
					<!-- step2 끝-------------------- -->

					<!-- step3-------------------- -->
					<div class="step step3" style="display: none;">
						<div class="ticket_payment_method">
							<!-- 최종결제 -->
							<div id="lastPayMethod">
								<h4 class="ts3_titlebar ts3_t1">
									<span class="header">결제하기 </span> <span class="title">최종결제
										수단</span>
								</h4>

								<div class="tpm_wrap tpm_last_pay">
									<div class="tpm_body">
										<div>
											<div class="payment_select radio_group" id="lastPayCon">
												<span style="opacity: 1;"> <input type="radio"
													id="creditpay_btn" name="last_pay_radio" value="0"
													checked="checked"> <label for="last_pay_radio0">신용카드
												</label>
												</span> <span style="opacity: 1;"> <input type="radio"
													id="kakaopay_btn" name="last_pay_radio" value="1">
													<label for="last_pay_radio1">카카오페이</label>
												</span>
											</div>

											<script>
	                                    $("input[type=radio]").change(function(){
	                                        if($("#creditpay_btn").is(":checked")){
	                                            $(".payment_card").css("display", "block");
	                                            $(".payment_kakao").css("display", "none");
	                                        }
	                                        else if($("#kakaopay_btn").is(":checked")){
	                                            $(".payment_card").css("display", "none");
	                                            $(".payment_kakao").css("display", "block");
	                                        }
	                                        
	                                    })
	                                    
	                                </script>
											<div class="payment_form">
												<!-- 신용카드 -->
												<div id="payCredit" class="payment_input payment_card"
													style="display: block;">
													<div class="table_wrap transfer_wrap"></div>
													<!-- card_default -->
													<div class="payment_input_exp" id="savePointCon">
														<span>※ 신용카드 결제 가능 최소 금액은 1,000원 이상입니다.</span> <span>
															<span class="desc"> <a href="#"
																onclick="return false;" class="btn_savePoint">삼성U포인트
																	적립</a>&nbsp;&nbsp;<a href="#" onclick="return false;"
																class="btn_savePoint">OK캐쉬백 적립</a>&nbsp;&nbsp;&nbsp;&nbsp;
														</span><br> <span class="option"> (삼성U포인트, OK캐쉬백 포인트는
																포인트 중복 적립 불가) </span>
														</span>
													</div>
													<div class="banner_wrap" style="display: none;">
														<a target="_blank" href=""><img src="" alt=""
															style="visibility: hidden;"></a>
													</div>
												</div>

												<!-- 카카오페이 -->
												<div class="payment_input payment_kakao"
													style="display: none;">
													<div class="table_wrap transfer_wrap">
														<h6>카카오페이 결제 순서</h6>
														<div>
															1. 우측 하단에 있는 "결제하기"버튼을 클릭해주세요.<br> 2. 예매내역 확인 후 결제하기
															버튼 클릭 시 '토스' 결제 인증창이 뜹니다.<br> 3. '토스'결제 인증창에서 정보를
															입력하신 후 결제해주세요.
														</div>
													</div>
													<div class="payment_input_exp">
														<span class="alert">'카카오페이'는 신용카드 선할인과 카드사 포인트는 이용이
															불가능하며,<br> 신용카드별 청구할인은 이용이 가능합니다.
														</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="ticket_payment_summary">
							<div class="tps_wrap" style="top: 0px;">
								<!--<div class="tps_header"><div><span>10분</span> 안에<br/>예매를 완료해 주세요</div></div>-->
								<div class="tps_body">
									<div class="summary_box total_box">
										<div class="payment_header">결제하실 금액</div>
										<div class="payment_footer">
											<div class="result">
												<span class="num verdana" id="summary_total_amount">24,000</span><span
													class="won">원</span>
											</div>
										</div>
									</div>
								</div>
								<div class="tps_footer no_english">
									<ul>
										<li><a
											href="http://www.cgv.co.kr/culture-event/event/detailViewUnited.aspx?seq=30014"
											target="_blank"
											onmousedown="javascript:logClick('신용카드 프로모션 텍스트배너');"> <img
												src="/resources/img/ticket/16249345262810.png"
												alt="10포인트부터 티켓 전액 결제가능!"> <span class="desc">10포인트부터
													티켓 전액 결제가능!</span>
										</a></li>
										<li><a
											href="http://www.cgv.co.kr/culture-event/event/detailViewUnited.aspx?seq=31426"
											target="_blank"
											onmousedown="javascript:logClick('신용카드 프로모션 텍스트배너');"> <img
												src="/resources/img/ticket/16249334008850.png"
												alt="M포인트 사용하고 즉시 할인받자"> <span class="desc">M포인트
													사용하고 즉시 할인받자</span>
										</a></li>
										<li><a
											href="http://www.cgv.co.kr/culture-event/event/detailViewUnited.aspx?seq=30018"
											target="_blank"
											onmousedown="javascript:logClick('신용카드 프로모션 텍스트배너');"> <img
												src="/resources/img/ticket/16249345262650.png"
												alt="현금처럼 꿀머니 사용 가능!"> <span class="desc">현금처럼
													꿀머니 사용가능!</span>
										</a></li>
									</ul>
								</div>
								<div id="timerView" class="tps_footer "
									style="height: 50px; font-weight: bold;"></div>
							</div>
						</div>
					</div>
					<!-- step3 끝-------------------- -->

					<!-- step4 시작 ------------------- -->
					<div class="step step4" style="display: none;">
						<!-- complement of payment 섹션 -->
						<div class="section section-complement">
							<div class="col-head">
								<!--<img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/title_complement.png" alt="예매 완료" />-->
							</div>
							<div class="col-body">
								<div class="article result">
									<div class="text_complement">
										<img
											src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step4/text_complement.png"
											alt="예매가 완료 되었습니다.">
									</div>
									<div class="ticket_summary_wrap">
										<div class="ticket_summary">
											<div class="poster">
												<img src="#" alt=""
													style="visibility: visible; display: inline;">
											</div>
											<table>
												<caption>예매정보</caption>
												<thead></thead>
												<tbody>
													<tr class="ticket_no">
														<th scope="row">예매번호</th>
														<td><span class="red">0128-0911-3208-049</span></td>
													</tr>
													<tr class="movie_name">
														<th scope="row">영화</th>
														<td><em>아이유 콘서트 - 더 골든 아워(♥이 지금♥,IMAX 2D)</em></td>
													</tr>
													<tr class="theater">
														<th scope="row">극장</th>
														<td><em><span class="theater_name">CGV
																	울산삼산</span> / <span class="theater_loc">IMAX관[9관] 8층</span></em></td>
													</tr>
													<tr class="movie_date">
														<th scope="row">일시</th>
														<td><em>상영시간<em></td>
													</tr>
													<tr class="people">
														<th scope="row">인원</th>
														<td><em>청소년 1명</em></td>
													</tr>
													<tr class="seat">
														<th scope="row">좌석</th>
														<td><em>A7</em></td>
													</tr>
													<tr class="payment_price">
														<th scope="row">결제금액</th>
														<td><span class="price">24,000</span> 원</td>
													</tr>
													<tr class="payment_method">
														<th scope="row">결제수단</th>
														<td>
															<div class="row">
																<span class="title"><em>카카오페이</em></span> <span
																	class="content"><span class="price">24,000</span>
																	원</span>
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="ticket_button_group">
										<div>
											<a class="btn_step4 btn_red btn_ticket_print" href="#"
												onclick="printHomeTicket()" style="margin: 0px 5px;"><span>예매정보
													출력</span></a> <a class="btn_step4 btn_ticket_check" href="#"
												onclick="confirmCancelTicketResult()"
												style="margin: 0px 5px;"><span>예매확인/취소</span></a>
										</div>
									</div>
									<div class="ticket_instructions">
										<dl>
											<dt>
												<img
													src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step4/text_ticket_instructions.png"
													alt="예매 유의 사항">
											</dt>
											<dd>

												<ul>
													<li>CJ ONE 포인트는 상영일 익일 적립됩니다.<em>(영화관람권, 비회원 예매
															제외)</em></li>
													<!--li>홈티켓 출력 시, 별도의 티켓 발권 없이 바로 입장 가능합니다.<br /><em>(그 외에는 신분증 소지 후, 티켓판매기 혹은 매표소에서 티켓을 발권 받으셔야 합니다)</em></li-->
													<li>영화 상영 스케줄은 영화관사정에 의해 변경될 수 있습니다.</li>
													<li>비회원 예매하신 경우는 예매내역이 이메일로 발송되지 않습니다.</li>
												</ul>

											</dd>
										</dl>
									</div>
								</div>
							</div>
						</div>
					</div>
					<script>
                //step4세팅
           	     function complement(result){
           	    	//alert("rvcode : " + result.rvcode) 
                	// tnb에 display none;
           	    	 $(".tnb").css("display", "none");
           	    	 
           	    	 $(".ticket_summary .poster").find("img").attr("src",  $(".tnb .info .movie_poster").find("img").attr("src"));
           	    	 $(".ticket_summary .ticket_no").find("span").html(result.rvcode);
           	    	 $(".ticket_summary .movie_name").find("em").html(result.rvmovname);
           	    	 $(".ticket_summary .theater_name").html(result.rvthname);
           	    	 $(".ticket_summary .theater_loc").html(result.rvschall);
           	    	 $(".ticket_summary .movie_date").find("em").html($(".step2 .playYMD-info b").eq(0).html()+$(".step2 .playYMD-info b").eq(1).html()+$(".step2 .playYMD-info b").eq(2).html());
           	    	 $(".ticket_summary .people em").html(result.rvlist);
           	    	 $(".ticket_summary .seat em").html(result.rvschseats);
           	    	 $(".ticket_summary .payment_price .price").html(result.rvprice);
           	    	 $(".ticket_summary .payment_method .title").html(result.paymethod);
           	    	 $(".ticket_summary .payment_method .price").html(result.rvprice);
           	    	 
           	    	 //step3 display none, step4 display block;
           	    	$("#ticket .steps .step3").css("display", "none");
                    $("#ticket .steps .step4").css("display", "block");
           	    	 
           	     }
                
                function confirmCancelTicketResult(){
                	let userid =  $("input[name=userid]").val();
                	location.href = "/member/reserve?userid="+userid;
                }
                </script>
					<!-- step4 끝 ------------------- -->


				</div>
			</div>
		</div>
	</div>
	<!-- 예매 페이지 끝-->
	<!-- 진행상황 목록 -->
	<div id="ticket_tnb" class="tnb_container ">
		<div class="tnb step1">
			<!-- btn-left -->
			<a class="btn-left" href="#" onclick="OnTnbLeftClick()" title="영화선택">이전단계로
				이동</a>
			<div class="info movie">
				<span class="movie_poster"> <!-- display inline으로 바뀌어야 한다. -->
					<img src="/display?fileName=${board.fullname}" alt="영화 포스터"
					style="display: none;">
				</span>
				<div class="row movie_title colspan2" style="display: none;">
					<!-- display block으로 바뀌어야 한다. -->
					<span class="data letter-spacing-min ellipsis-line2"> <a
						href="/movies/detail-view?movcode=${board.movcode}"
						target="_blank"
						onmousedown="javascript:logClick('SUMMARY/영화상세보기');" title="">
					</a></span>
				</div>
				<div class="row movie_type" style="display: none;">
					<!-- display block으로 바뀌어야 한다. -->
					<span class="data ellipsis-line1" title="2D">2D</span>
				</div>
				<div class="row movie_rating" style="display: none;">
					<!-- display block으로 바뀌어야 한다. -->
					<span class="data" title="${board.movgrade}세 관람가">${board.movgrade}세
						관람가</span>
				</div>
				<input type="hidden" name="endTime" /> <input type="hidden"
					name="movcode" />
				<div class="placeholder" title="영화선택"></div>
				<!--  영화 선책 하는 순간style="display: none;"으로 바뀐다 -->
			</div>
			<div class="info theater">
				<div class="row name" style="display: none;">
					<!-- display block으로 바뀌어야 한다. -->
					<span class="header">극장</span> <span
						class="data letter-spacing-min ellipsis-line1"> <a
						href="http://www.cgv.co.kr/theaters/?theaterCode=0229"
						target="_blank"
						onmousedown="javascript:logClick('SUMMARY/극장상세보기');" title=""></a></span>
				</div>
				<div class="row date" style="display: none;">
					<!-- display block으로 바뀌어야 한다. -->
					<span class="header">일시</span> <span class="data" title=""></span>
				</div>
				<div class="row screen" style="display: none;">
					<!-- display block으로 바뀌어야 한다. -->
					<span class="header">상영관</span> <span class="data" title=""></span>
				</div>
				<div class="row number" style="display: none;">
					<!-- display block으로 바뀌어야 한다. -->
					<span class="header">인원</span> <span class="data"></span>
				</div>
				<div class="placeholder" title="극장선택" style="display: block;"></div>
				<!-- 영화 클릭하는 순간 display none으로 바뀌어야 한다. -->
			</div>
			<div class="info seat">
				<input type="hidden" name="seatcount" /> <input type="hidden"
					name="seatlist" />
				<div class="row seat_name" style="display: none;">
					<!--  display: block; -->
					<span class="header">좌석명</span> <span class="data">일반석</span>
				</div>
				<div class="row seat_no colspan3" style="display: none;">
					<!--  display: block; -->
					<span class="header">좌석번호</span> <span class="data ellipsis-line3"></span>
				</div>
				<div class="placeholder" title="좌석선택"></div>
			</div>
			<div class="info payment-ticket">
				<div class="row payment-adult">
					<span class="header">일반</span> <span class="data"><span
						class="price">8000</span>원 x <span class="quantity"></span></span>
				</div>
				<div class="row payment-youth">
					<span class="header">청소년</span> <span class="data"><span
						class="price">6000</span>원 x <span class="quantity"></span></span>
				</div>
				<div class="row payment-child">
					<span class="header">어린이</span> <span class="data"><span
						class="price">3000</span>원 x <span class="quantity"></span></span>
				</div>
				<div class="row payment-senior">
					<span class="header">경로</span> <span class="data"><span
						class="price">3000</span>원 x <span class="quantity"></span></span>
				</div>
				<div class="row payment-final">
					<span class="header">총금액</span> <span class="data"><span
						class="price">0</span><span class="won">원</span></span>
				</div>
			</div>

			<script>
            $(document).ready(function () {
                $(".payment-ticket .row").css("display" , "none");
                $(".payment-ticket .payment-final").css("display" , "block");
            })
            function displayPrice(array) {
                let arr = array.split(",");
                let totalPrice = 0;
                console.log("displayPriceArray : ", arr);
                for(let a in arr){
                    let type = arr[a].split(" ")[0];
                    console.log("type :  "+ type);
                    let num = arr[a].split(" ")[1].substring(0,1);

                    let typespan = $(".payment-ticket span:contains('"+type+"')")
                    let price = $(typespan).siblings(".data").find(".price").html();
                    totalPrice += price * num;
                    console.log("총금액 :" + totalPrice)
                    
                    console.log($(typespan).html());
                    $(typespan).siblings(".data").find(".quantity").html(num);
                    $(typespan).parent(".row").css("display", "block");
                    $(".payment-ticket .payment-final .price").html(totalPrice);
                    $("#summary_total_amount").html(totalPrice);
                }
            }
        </script>

			<div class="info path">
				<div class="row colspan4">
					<span class="path-step2" title="좌석선택"></span> <span
						class="path-step3" title="결제"></span>
				</div>
			</div>
			<!-- btn-right -->
			<div class="tnb_step_btn_right_before" id="tnb_step_btn_right_before"></div>
			<em class="tooltip_notice"> <a href="#none"
				data-popup="pop_incomeDeduction"> <strong>영화관람료 소득공제</strong> <i
					class="cgvIcon system notice">notice</i><br> <span></span> 대상
					상품입니다.
			</a>
			</em> <a class="btn-right" id="tnb_step_btn_right" href="#"
				onclick="OnTnbRightClick()" title="좌석선택">다음단계로 이동 - 레이어로 서비스 되기
				때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</a>
		</div>
	</div>
	<script>
	     $(document).ready(function () {
	         $("#ticket .steps .step1").css("display", "block");
	         $("#ticket .steps .step2").css("display", "none");
	         $(".tnb .step1 .btn-right").removeClass("on");
	         //$("#ticket .steps .step3").css("display", "block");
	     });
	     
	     function OnTnbLeftClick(){
             //alert("클릭");
             if($(".tnb").hasClass("step2")){
                 console.log("step1으로 이동");
                 $("#ticket .steps .step2").css("display", "none");
                 $("#ticket .steps .step1").css("display", "block");
                 $(".tnb").removeClass("step2");
	             $(".tnb").addClass("step1");
             }
             else if($(".tnb").hasClass("step3")){
                 console.log("step2으로 이동");
                 $("#ticket .steps .step3").css("display", "none");
                 $("#ticket .steps .step2").css("display", "block");
                 $(".tnb").removeClass("step3");
	             $(".tnb").addClass("step2");
	             $(".info .row.colspan4 span").css({"width":"0","height":"0"});
             }
         }
	     
	     // 다음으로 가기
	     function OnTnbRightClick(){
             if($(".tnb").hasClass("step1")){
                 console.log("stpe2로 이동");
                 $("#ticket .steps .step1").css("display", "none");
                 $("#ticket .steps .step2").css("display", "block");
                 $(".tnb").removeClass("step1");
	             $(".tnb").addClass("step2");
	             //$("#ticket .section").css("height","0");
	             $(".info .row.colspan4 span").css({"width":"0","height":"0"});
	             $(".btn-right").removeClass("on");
	             
	             //선택햇던 인원 초기화
	             $("#nopContainer .group ul li").removeClass("selected");
	             $(".person_screen .adult ul li").first().addClass("selected");
	             $(".person_screen .youth ul li").first().addClass("selected");
	             $(".person_screen .child ul li").first().addClass("selected");
	             $(".person_screen .senior ul li").first().addClass("selected");
	             
	             // 선택햇던 좌석들 초기화
                 //$("#seats_list .row .seat").removeClass("selected");
                 step2Start();
             }
             else if($(".tnb").hasClass("step2") && $(".btn-right").hasClass("on")){
                 console.log("step3으로 이동")
                 //$("#ticket .steps .step3").css("display", "block");
                 $("#ticket .steps .step2").css("display", "none");
                 $("#ticket .steps .step3").css("display", "flex");
                 $(".tnb").removeClass("step2");
	             $(".tnb").addClass("step3");
             }
             else if($(".tnb").hasClass("step3")){
                 console.log("결제");
                 let t_name = "영화명";
                 let t_amount =
                 IMP.init('imp35275814');
                 if($("#creditpay_btn").is(":checked")){
                     //kg 이니시스 실행
                     paymentInisis();
                 }
                 else if($("#kakaopay_btn").is(":checked")){
                     //카카오 페이 실행
                     paymentKaKao();
                     //test();
                     
                 }
             }
         }
	     
	     
	     function test(){
	    	// 영화이름, 가격, id
	    	 let t_movname = $(".movie_title span a").html();
	         let t_amount = $(".payment-ticket .payment-final .price").html();
	         let t_name= $("input[name=userid]").val();
	         //alert("확인!!!!!!!!!!!!!!",t_name);
	         //alert("확인!!!!!!!!!!!!!!2"+t_name);
	         
	         // 영화 코드, 영화관 코드, 영화 상영시간(20230000), 영화관(4), 선택좌석리스트
	         let schmovcode = $("input[name=movcode]").val();
	         let schthcode = $(".theater-area-list .selected div > ul > li.selected a").data("thcode");
	         //2023-00-00 (요일) 00:00
	         //데베에는 schtime.split(" ")[0]+" "+schtime.split(" ")[2]
	         let schtime = $(".theater .date .data").html();
	         let rvrunning = $("p.playYMD-info b").eq(0).html()+" "+$("p.playYMD-info b").eq(2).html();
	         //데베에는 schall.substring(1) : 몇 관
	         let schall = $(".theater .screen .data").html();
	         // 구매 좌석  나열(일반 n명, ...)
	         let seatList = $(".theater .number .data").html();
	         
	         // 데베에는 schseats.substring(1); : E2,D2..
	         let schseats = $(".seat .seat_no .data").html();
	         
	         // 영화관 이름
	         let schthname = $(".theater .name .data a").html();
	         let t_merchant_uid = schmovcode+schtime.substring(0,10).replace(/-/gi, "")+
	         					schall.substring(1,2)+schseats.replace(/,/gi, "").substring(0,4);
	         //------------------------------------------------------
	         let formData = new FormData();
	        
             formData.append("rvcode",t_merchant_uid);
             formData.append("rvuserid",t_name);
             formData.append("rvmovcode",schmovcode);
             formData.append("rvmovname",t_movname);
             formData.append("rvthcode ",schthcode);
             formData.append("rvthname",schthname);
             formData.append("rvschtime",schtime.split(" ")[0]+" "+schtime.split(" ")[2]);
             formData.append("rvrunning",rvrunning);
             formData.append("rvschall",schall.substring(1));
             formData.append("rvschseats",schseats.substring(1));
             formData.append("rvlist",seatList);
             formData.append("rvprice",t_amount); 
             
             let csrfHeaderName= "${_csrf.headerName}";
			let csrfTokenValue= "${_csrf.token}";
            $.ajax({
				url : "/tickets/successorder",
				type : "post",
				processData : false,
				contentType: false,
				data : formData,
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
 			    dataType:"json",
				success : function(result){
					alert("성공");
					location.href = "/ticket/successorder";
				},
				error : function(){
					alert("서버요청실패");
				}
			})
	     }
	     
	     
	     //이니시스 결제
	     function paymentInisis(data) {
			    // 영화이름, 가격, id
	    	 let t_movname = $(".movie_title span a").html();
	         let t_amount = $(".payment-ticket .payment-final .price").html();
	         let t_name= $("input[name=userid]").val();
	         
	         // 영화 코드, 영화관 코드, 영화 상영시간(20230000), 영화관(4), 선택좌석리스트
	         let schmovcode = $("input[name=movcode]").val();
	         let schthcode = $(".theater-area-list .selected div > ul > li.selected a").data("thcode");
	         //2023-00-00 (요일) 00:00
	         //데베에는 schtime.split(" ")[0]+" "+schtime.split(" ")[2]
	         let schtime = $(".theater .date .data").html();
	         let rvrunning = $("p.playYMD-info b").eq(0).html()+" "+$("p.playYMD-info b").eq(2).html();
	         
	         //데베에는 schall.substring(1) : 몇 관
	         let schall = $(".theater .screen .data").html();
	         // 구매 좌석  나열(일반 n명, ...)
	         let seatList = $(".theater .number .data").html();
	         
	         // 데베에는 schseats.substring(1); : E2,D2..
	         let schseats = $(".seat .seat_no .data").html();
	         
	         // 영화관 이름
	         let schthname = $(".theater .name .data a").html();
	         let t_merchant_uid = schmovcode+schtime.substring(2,10).replace(/-/gi, "")
	         						+new Date()+schseats.replace(/,/gi, "").substring(0,4);
	         //------------------------------------------------------
	            IMP.request_pay({
	                pg : 'html5_inicis', // version 1.1.0부터 지원.
	                pay_method : 'card',
	                merchant_uid : t_merchant_uid,
	                name : t_movname,
	                amount : t_amount, //판매 가격
	                buyer_name : t_name
	            }, function(rsp) {
	                if ( rsp.success ) {
	                	//alert("결제가 완료되었습니다.");
	                    let formData = new FormData();
	                    formData.append("rvcode",t_merchant_uid);
	                    formData.append("rvuserid",t_name);
	                    formData.append("rvmovcode",schmovcode);
	                    formData.append("rvmovname",t_movname);
	                    formData.append("rvthcode ",schthcode);
	                    formData.append("rvthname",schthname);
	                    formData.append("rvschtime",schtime.split(" ")[0]+" "+schtime.split(" ")[2]);
	                    formData.append("rvrunning",rvrunning);	     
	                    formData.append("rvschall",schall.substring(1));
	                    formData.append("rvschseats",schseats.substring(1));
	                    formData.append("rvlist",seatList);
	                    formData.append("rvprice",t_amount); 
	                    formData.append("paymethod","신용카드"); 
	                    
	                    let csrfHeaderName= "${_csrf.headerName}";
	       				let csrfTokenValue= "${_csrf.token}";
		                   $.ajax({
			       				url : "/tickets/successorder",
			       				type : "post",
				       			processData : false,
				       			contentType: false,
			       				data : formData,
			       				beforeSend:function(xhr){
				       				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				       			},
		        			    dataType:"json",
			       				success : function(result){
			       					alert("결제가 완료되었습니다.");
			       					complement(result);
			       				},
			       				error : function(){
			       					alert("서버요청실패");
			       				}
			       			})
	                } else {
	                    var msg = '결제에 실패하였습니다.';
	                    msg += '에러내용 : ' + rsp.error_msg;
	                    location.reload();
	                }
	                //alert(msg);
	            });
	        }
	     
	     //카카오페이 결제
	     function paymentKaKao(data) {
		    // 영화이름, 가격, id
	    	 let t_movname = $(".movie_title span a").html();
	         let t_amount = $(".payment-ticket .payment-final .price").html();
	         let t_name= $("input[name=userid]").val();
	         
	         // 영화 코드, 영화관 코드, 영화 상영시간(20230000), 영화관(4), 선택좌석리스트
	         let schmovcode = $("input[name=movcode]").val();
	         let schthcode = $(".theater-area-list .selected div > ul > li.selected a").data("thcode");
	         //2023-00-00 (요일) 00:00
	         //데베에는 schtime.split(" ")[0]+" "+schtime.split(" ")[2]
	         let schtime = $(".theater .date .data").html();
	         let rvrunning = $("p.playYMD-info b").eq(0).html()+" "+$("p.playYMD-info b").eq(2).html();
	         
	         //데베에는 schall.substring(1) : 몇 관
	         let schall = $(".theater .screen .data").html();
	         // 구매 좌석  나열(일반 n명, ...)
	         let seatList = $(".theater .number .data").html();
	         
	         // 데베에는 schseats.substring(1); : E2,D2..
	         let schseats = $(".seat .seat_no .data").html();
	         
	         // 영화관 이름
	         let schthname = $(".theater .name .data a").html();
	         let now = new Date();
	         let t_merchant_uid = schmovcode+schtime.substring(2,10).replace(/-/gi, "")
									+now.getMinutes()+now.getSeconds()+schseats.replace(/,/gi, "").substring(0,4);
	         
	         //------------------------------------------------------
	         
	            IMP.request_pay({// param
	                pg: "kakaopay.TC0ONETIME", //pg사명 or pg사명.CID (잘못 입력할 경우, 기본 PG사가 띄워짐)
	                pay_method: "card", //지불 방법
	                merchant_uid : t_merchant_uid,
	                name : t_movname,
	                amount : t_amount, //판매 가격
	                buyer_name : t_name
	            }, function (rsp) { // callback
	                if (rsp.success) {
	                    //alert("결제가 완료되었습니다.");
	                    let formData = new FormData();
	                    formData.append("rvcode",t_merchant_uid);
	                    formData.append("rvuserid",t_name);
	                    formData.append("rvmovcode",schmovcode);
	                    formData.append("rvmovname",t_movname);
	                    formData.append("rvthcode ",schthcode);
	                    formData.append("rvthname",schthname);
	                    formData.append("rvschtime",schtime.split(" ")[0]+" "+schtime.split(" ")[2]);
	                    formData.append("rvrunning",rvrunning);	                    
	                    formData.append("rvschall",schall.substring(1));
	                    formData.append("rvschseats",schseats.substring(1));
	                    formData.append("rvlist",seatList);
	                    formData.append("rvprice",t_amount); 
	                    formData.append("paymethod","카카오페이"); 
	                    
	                    let csrfHeaderName= "${_csrf.headerName}";
	       				let csrfTokenValue= "${_csrf.token}";
		                   $.ajax({
			       				url : "/tickets/successorder",
			       				type : "post",
				       			processData : false,
				       			contentType: false,
			       				data : formData,
			       				beforeSend:function(xhr){
				       				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				       			},
		        			    dataType:"json",
			       				success : function(result){
			       					alert("결제가 완료되었습니다.");
			       					complement(result);
			       				},
			       				error : function(){
			       					alert("서버요청실패");
			       				}
			       			})
	                } else {
	                    alert("실패 : 코드("+rsp.error_code+") / 메세지(" + rsp.error_msg + ")");
	                    location.reload();
	                }
	            });
	        }
	     
	     

	 </script>
	<!-- 진행상황 목록 -->

	<%@ include file="../footer.jsp"%>
</body>
</html>