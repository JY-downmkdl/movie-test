<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
    <style>
        .contentsStart{
            margin-top: 80px;
        }
    </style>
<title>예매하기</title>
</head>
<body>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
                                        <ul class="content scroll-y" onscroll="movieSectionScrollEvent();" tabindex="-1">
                                        
                                            <!--영화 제목 반복-->
                                            <c:forEach items='${movList}' var="movlist">
	                                            <li class=""  onclick="movselect(this)" data-movcode="${movlist.movcode}"><a href="#" onclick="return false;"
	                                            title="${movlist.movname}" alt="${movlist.movname}">
	                                            	<i class="cgvIcon etc age${movlist.movgrade}">${movlist.movgrade}세</i>
	                                            	<span class="text">${movlist.movname}</span>
	                                            	<span class="sreader"></span>
	                                            </a></li>
                                            </c:forEach>
                                            <!--  
                                            <li class=""><a href="#" onclick="return false;"
                                                title="오펜하이머" alt="오펜하이머">
                                                <i class="cgvIcon etc age15">15세</i>
                                                <span class="text">오펜하이머</span>
                                                <span class="sreader"></span>
                                            </a></li>-->
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
                                    					console.log(result)
                                    					//영화 포스터 받아오기
                                    					$(".movie").find(".movie_poster img").attr("src", "/display?fileName="+result.fullname+" ").css("display","inline");
                                    					//영화명에 디테일뷰로 이동시키기
                                    					$(".movie").find(".movie_title span a").attr("href","/movies/detail-view?movcode="+result.movcode+" ").html(result.movname)
                                    					$(".movie").find(".movie_rating span").attr("title", result.movgrade+"세 관람가").html(result.movgrade+"세 관람가");
                                    					
                                    					//$(".movie").find(".movie_title").css("display","block");
                                    					$(".movie").find(".movie_title, .movie_type, .movie_rating").css("display","block");
                                    					$(".movie").find(".placeholder").css("display","none");
                                    				}
                                    			})
                                    			selectTime();
                                         		
                                         		
												
											}
                                         </script>
                                        </ul>
                                        <div class="pane pane-y" style="display: block; opacity: 1; 
                                        visibility: visible;">
                                            <div class="slider slider-y" style="height: 50px; top: 0px;">
                                            </div>
                                        </div>
                                        <div class="pane pane-x" style="display: none; opacity: 1;
                                        visibility: visible;">
                                            <div class="slider slider-x" style="width: 50px;">
                                            </div>
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
                                                <li class="">
                                                    <a href="#" onclick="theaterAreaClickListener(this)">
                                                        <span class="name">${location}</span>
                                                        <span class="count">(200)</span>
                                                    </a>
                                                    <div class="area_theater_list nano has-scrollbar-y selected">
                                                        <ul class="content scroll-y">
                                                            <!--지 점명 반복 시작-->
                                                            <li class="" style="display: list-item;">
                                                                <a href="#" data-thcode="${thcodes[0]}" onclick="theaterListClickListener(this, ${thcodes[0]}, '${thnames[0]}', '${thaddresses[0]}')">
                                                                   ${thnames[0]}
                                                                </a>
                                                            </li>
                                                            <!--지점명 반복 끝-->
                                                            <!--지점명 반복 시작-->
                                                            <li class="" style="display: list-item;">
                                                                <a href="#" data-thcode="${thcodes[1]}" onclick="theaterListClickListener(this, ${thcodes[1]}, '${thnames[1]}', '${thaddresses[1]}')">
                                                                    ${thnames[1]}
                                                                </a>
                                                            </li>
                                                            <!--지점명 반복 끝-->
                                                        </ul>
                                                    </div>
                                                </li>
                                           </c:forEach>
                                                <!--반복 끝!~!-->
                                               <script>
                                               $(document).ready(function(){
                                            	   $(".theater-area-list ul > li").first().addClass("selected");
                                            		
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
                                            	    $(".date-list ul li.day").removeClass("selected");
                                           			$(".section-time .time-list .content").empty();
                                           			$(".btn-right").removeClass("on");
                                            	   
													//alert("우우우"+ event)
													$(".theater .name").css("display", "block");
													$(".theater .placeholder").css("display", "none");
													$(".theater .date").css("display", "block");
													$(".theater .number").css("display", "block");
													$(".theater .screen").css("display", "block");
													$(".theater .header").css("display", "block");
													$(".theater .name .data a").html(thname).attr("href", "/theater/location?"+thname.substring(2));
													
													$(".area_theater_list ul li").removeClass("selected");
	                                        		$(event).parent().addClass("selected");
	                                        		$(".date-list ul li.day").removeClass("selected");
	                                        		
	                                        		selectTime();
												}
                                               
                                               </script>
                                                 <%--<!--반복시작-->
                                                <li class="">
                                                    <a href="#" onclick="theaterAreaClickListener(event);return false;">
                                                        <span class="name">지역명</span>
                                                        <span class="count">(잔여석)</span>
                                                    </a>
                                                    <div class="area_theater_list nano has-scrollbar-y selected">
                                                        <ul class="content scroll-y">
                                                            <!--지 점명 반복 시작-->
                                                            <li class="" style="display: list-item;">
                                                                <a href="#" onclick="theaterListClickListener(event);return false;">
                                                                    울산삼산
                                                                </a>
                                                            </li>
                                                            <!--지점명 반복 끝-->
                                                            <!--지점명 반복 시작-->
                                                            <li></li>
                                                            <!--지점명 반복 끝-->
                                                        </ul>
                                                        <!--스크롤 보이기-->
                                                        <div class="pane pane-y" 
                                                        style="display: block; opacity: 1; visibility: visible;">
                                                            <div class="slider slider-y" 
                                                            style="height: 50px; top: 0px;">
                                                                <div class="slider slider-y" 
                                                                style="height: 50px; top: 0px;">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="pane pane-x" style="display: none;
                                                         opacity: 1; visibility: visible;">
                                                            <div class="slider slider-x" style="width: 50px;">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <!--반복 끝!~!--> --%>
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
                                <a href="#" onclick="return false;" class="skip_to_something">날짜 건너뛰기</a>
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
                                                	 +("0"+(afterday.getMonth()+1)).slice(-2)+"-"+("0"+(afterday.getDate())).slice(-2)+
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
                                    <div class="pane pane-y" style="display: block; opacity: 1; 
                                    visibility: visible;">
                                        <div class="slider slider-y" style="height: 50px; top: 0px;">
                                        </div>
                                    </div>
                                    <div class="pane pane-x" style="display: none; opacity: 1;
                                    visibility: visible;">
                                        <div class="slider slider-x" style="width: 50px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--날짜 선택-->

                        <!--영화 시간 선택하기-->
                        <div class="section section-time">
                            <div class="col-head" id="skip_time_list">
                                <h3>시간</h3>
                                <a href="#" class="skip_to_something" onclick="skipToSomething('tnb_step_btn_right');return false;">시간선택 건너뛰기</a>
                            </div>
                            <div class="col-body" style="height: 565px;">
                                <!-- 시간선택 -->
                                <div class="time-option">
                                    <span class="morning">모닝</span><span class="night">심야</span>
                                </div>
                                <div class="placeholder">영화, 극장, 날짜를 선택해주세요.</div>
                                <div class="time-list nano">
                                    <div class="content scroll-y" tabindex="-1">
                                    <%--
                                        <!--한 극장 시작-->
                                        <div class="theater">
                                            <span class="title">
                                                <span class="name">2D</span>
                                                <span class="floor">1관 3층</span>
                                                <span class="seatcount">(총140석)</span>
                                            </span>
                                            <ul>
                                                <!--한 타임 시작-->
                                                <li data-index="0" data-remain_seat="140" 
                                                play_start_tm="1235" play_num="2">
                                                    <a class="button" href="#" 
                                                    onclick="screenTimeClickListener(event);
                                                    return false;" title="">
                                                        <span class="time">
                                                            <span>12:35</span>
                                                        </span>
                                                        <span class="count">38석</span>
                                                        <div class="sreader">종료시간 14:44</div>
                                                        <span class="sreader mod"></span>
                                                    </a>
                                                </li>
                                                <!--한 타임 끝-->
                                                <li data-index="1" data-remain_seat="140" 
                                                play_start_tm="1500" play_num="3" class="selected">
                                                <a class="button" href="#"
                                                onclick="screenTimeClickListener(event);
                                                return false;" title="">
                                                    <span class="time">
                                                        <span>15:00</span>
                                                    </span>
                                                    <span class="count">125석</span>
                                                    <div class="sreader">종료시간 17:09</div>
                                                    <span class="sreader mod"></span>
                                                </a></li>
                                                <li data-index="2" data-remain_seat="140"
                                                play_start_tm="2000"
                                                play_num="5">
                                                <a class="button" href="#"
                                                onclick="screenTimeClickListener(event);
                                                return false;" title="">
                                                    <span class="time">
                                                        <span>20:00</span>
                                                    </span>
                                                    <span class="count">134석</span>
                                                    <div class="sreader">종료시간 22:09</div>
                                                    <span class="sreader mod"></span>
                                                </a></li>
                                                <li data-index="3" data-remain_seat="140"
                                                play_start_tm="2225" play_num="6">
                                                <a class="button" href="#"
                                                onclick="screenTimeClickListener(event);
                                                return false;" title="">
                                                    <span class="time">
                                                        <span>22:25</span>
                                                    </span>
                                                    <span class="count">136석</span>
                                                    <div class="sreader">종료시간 24:34</div>
                                                    <span class="sreader mod"></span>
                                                </a></li>
                                            </ul>
                                        </div>
                                        <!--한 극장 끝-->
                                        <div class="theater" screen_cd="004"
                                        movie_cd="20033341" style="border: none;">
                                            <span class="title">
                                                <span class="name">2D</span>
                                                <span class="floor">4관 4층</span>
                                                <span class="seatcount">(총127석)</span>
                                            </span>
                                            <ul>
                                                <li data-index="4" data-remain_seat="127"
                                                play_start_tm="0900" 
                                                play_num="1" class="morning">
                                                <a class="button" href="#"
                                                onclick="screenTimeClickListener(event);
                                                return false;" title="">
                                                    <span class="time">
                                                        <span>09:00</span>
                                                    </span>
                                                    <span class="count">123석</span>
                                                    <div class="sreader">종료시간 11:09</div>
                                                    <span class="sreader mod"> 조조</span>
                                                </a></li>
                                            </ul>
                                        </div>
                                         --%>
                                    </div>
                                    <div class="pane pane-y" style="display: none;
                                    opacity: 1; visibility: visible;">
                                        <div class="slider slider-y" style="height: 50px;"></div>
                                    </div>
                                    <div class="pane pane-x" style="display: none;
                                    opacity: 1; visibility: visible;">
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
               						let date =$(".date-list ul li.day:eq("+j+")").data("date")
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
                       				data: {movcode: movcode, thcode:thcode, schtime:schtime},
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
	                                
	                   				if(result[i].schtime[12] == '9'){
	                   					console.log("조조입니당");
	                   					str1 += "<li data-index='"+i+"' data-remain_seat='140' class='morning'"
	                   					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
	                   					 +"<a class='button' href='#'>"
	                   					 +"<span class='time'><span>"+result[i].schtime.substring(11,16)+"</span></span>"
	                   					 +"<span class='count'>140석</span>"
	                   					 +"<div class='sreader'>종료시간 /*기입안했음*/</div>"
	                   					 +"<span class='sreader mod'></span>"
	                   					 +"</a></li>";
	                   				}
	                   				else if(result[i].schtime[12] == '00' ||result[i].schtime[12] == '01'){
	                   					console.log("심야입니당");
	                   					str1 += "<li data-index='"+i+"' data-remain_seat='140' class='night'"
	                   					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
	                   					 +"<a class='button' href='#'>"
	                   					 +"<span class='time'><span>"+result[i].schtime.substring(11,16)+"</span></span>"
	                   					 +"<span class='count'>140석</span>"
	                   					 +"<div class='sreader'>종료시간 /*기입안했음*/</div>"
	                   					 +"<span class='sreader mod'></span>"
	                   					 +"</a></li>";
	                   				}
	                   				else{
		                   				str1 += "<li data-index='"+i+"' data-remain_seat='140'"
		                   					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
		                   					 +"<a class='button' href='#'>"
		                   					 +"<span class='time'><span>"+result[i].schtime.substring(11,16)+"</span></span>"
		                   					 +"<span class='count'>140석</span>"
		                   					 +"<div class='sreader'>종료시간 /*기입안했음*/</div>"
		                   					 +"<span class='sreader mod'></span>"
		                   					 +"</a></li>";
	                   				}
	                   				
	                   				
	                   				if(result[i] == result[result.length-1]){
            							console.log("마지막",result[result.length-1].schtime);
            							str2+="<div class='theater'>"
	                   						+"<span class='title'><span class='floor'>"+result[i].schall+"</span>"
											+"<span class='seatcount'>(총140석)</span>"
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
											+"<span class='seatcount'>(총140석)</span>"
											+"</span><ul>";
											
	                   					str2+=str1+"</ul></div>";
	                   					$(".section-time .time-list .content").append(str2);
	                   					str2="";
										str1="";
	                   				}
                   					
                   				}
									
							}
                   			
                   			
                   			function screenTimeClickListener(select) {
                   				//이미 선택한 상영관이면
                   				if($(select).closest("li").hasClass("selected")){
                   					return;
                   				}
                   				
                   				$(".section-time .time-list .content > li").removeClass("selected");
                   			 <%--"<li data-index='"+i+"' data-remain_seat='140'"
           					 +" play_num='"+result[i].schall+"' onclick='screenTimeClickListener(this)'>"
           					 +"<a class='button' href='#'>" --%>
           					 	let schtime1 = $(".theater .date .data").html();
                   				let schtime2 = $(select).find(".time span").html();
                   				let schall = $(select).closest(".theater").find(".floor").html();
                   				console.log("상영관 : " + schall);
                   				
                   				//셀렉트 클래스 넣기
                   				$(select).closest("li").addClass("selected");
                   
                   			   //진행 정보에 시간 넣어주기
                        		$(".theater .date .data").append(" " + schtime2).attr("title",schtime1+" "+schtime2);
                        		$(".theater .screen .data").html(" " + schall).attr("title", schall);
                        		$(".btn-right").addClass("on");
							}
                        	
                        </script>
                    </div>
                
                <!-- step2-------------------- -->
                
                </div>

            </div>
        </div>
    </div>
    <!-- 예매 페이지 끝-->
    <!-- 진행상황 목록 -->
    <div id="ticket_tnb" class="tnb_container ">
        <div class="tnb step1">
            <!-- btn-left -->
            <a class="btn-left" href="#" onclick="OnTnbLeftClick(); return false;" title="영화선택">이전단계로 이동</a>
            <div class="info movie">
                <span class="movie_poster">
                <!-- display inline으로 바뀌어야 한다. -->
                	<img src="/display?fileName=${board.fullname}" alt="영화 포스터" style="display: none;">
                </span>
                <div class="row movie_title colspan2" style="display: none;"><!-- display block으로 바뀌어야 한다. -->
                    <span class="data letter-spacing-min ellipsis-line2">
                    	<a href="/movies/detail-view?movcode=${board.movcode}" target="_blank" onmousedown="javascript:logClick('SUMMARY/영화상세보기');" title="">
                   	</a></span>
                </div>
                <div class="row movie_type" style="display: none;"><!-- display block으로 바뀌어야 한다. -->
                    <span class="data ellipsis-line1" title="2D">2D</span>
                </div>
                <div class="row movie_rating" style="display: none;"><!-- display block으로 바뀌어야 한다. -->
                    <span class="data" title="${board.movgrade}세 관람가">${board.movgrade}세 관람가</span>
                </div>
                <div class="placeholder" title="영화선택"></div><!--  영화 선책 하는 순간style="display: none;"으로 바뀐다 -->
            </div>

            <div class="info theater">
                <div class="row name" style="display: none;"><!-- display block으로 바뀌어야 한다. -->
                    <span class="header">극장</span>
                    <span class="data letter-spacing-min ellipsis-line1">
                    	<a href="http://www.cgv.co.kr/theaters/?theaterCode=0229" target="_blank"
                    	 onmousedown="javascript:logClick('SUMMARY/극장상세보기');" title=""></a></span>
                </div>
                <div class="row date" style="display: none;"><!-- display block으로 바뀌어야 한다. -->
                    <span class="header">일시</span>
                    <span class="data" title=""></span>
                </div>
                <div class="row screen" style="display: none;"><!-- display block으로 바뀌어야 한다. -->
                    <span class="header">상영관</span>
                    <span class="data" title=""></span>
                </div>
                <div class="row number" style="display: none;"><!-- display block으로 바뀌어야 한다. -->
                    <span class="header">인원</span>
                    <span class="data"></span>
                </div>
                <div class="placeholder" title="극장선택" style="display: block;"></div><!-- 영화 클릭하는 순간 display none으로 바뀌어야 한다. -->
            </div>
            <div class="info seat">
                <div class="row seat_name">
                    <span class="header">좌석명</span>
                    <span class="data">일반석</span>
                </div>
                <div class="row seat_no colspan3">
                    <span class="header">좌석번호</span>
                    <span class="data ellipsis-line3"></span>
                </div>
                <div class="placeholder" title="좌석선택"></div>
            </div>
            <div class="info payment-ticket">
                <div class="row payment-adult">
                    <span class="header">일반</span>
                    <span class="data"><span class="price"></span>원 x <span class="quantity"></span></span>
                </div>
                <div class="row payment-youth">
                    <span class="header">청소년</span>
                    <span class="data"><span class="price"></span>원 x <span class="quantity"></span></span>
                </div>
                <div class="row payment-child">
                    <span class="header">어린이</span>
                    <span class="data"><span class="price"></span>원 x <span class="quantity"></span></span>
                </div>						
                <div class="row payment-senior">
                    <span class="header">경로</span>
                    <span class="data"><span class="price"></span>원 x <span class="quantity"></span></span>
                </div>
                <div class="row payment-special">
                    <span class="header">우대</span>
                    <span class="data"><span class="price"></span>원 x <span class="quantity"></span></span>
                </div>
                <div class="row payment-final">
                    <span class="header">총금액</span>
                    <span class="data"><span class="price">0</span><span class="won">원</span></span>
                </div>
            </div>
            <div class="info path">
                <div class="row colspan4">
                    <span class="path-step2" title="좌석선택"></span>
                    <span class="path-step3" title="결제"></span>
                </div>
            </div>
            <!-- btn-right -->
            <div class="tnb_step_btn_right_before" id="tnb_step_btn_right_before"></div>
            <em class="tooltip_notice">
                <a href="#none" data-popup="pop_incomeDeduction">
                    <strong>영화관람료 소득공제</strong>
                    <i class="cgvIcon system notice">notice</i><br>
                    <span></span> 대상 상품입니다.
                </a>
            </em>
            <a class="btn-right on" id="tnb_step_btn_right" href="#" onclick="OnTnbRightClick(); return false;" title="좌석선택">다음단계로 이동 - 레이어로 서비스 되기 때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</a>
        </div>
    </div>
    <!-- 진행상황 목록 -->
</body>
</html>