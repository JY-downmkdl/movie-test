<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./header.jsp" %>
<script src="/resources/swiper/swiper.js"></script>

</head>
<body>
	<!-- index 시작 --------------------------------------------- -->
        <div id="container">
            <div id="ctl00_PlaceHolderContent_divMovieSelection_wrap">
                <div class="contents">
                    <div class="movieinfo">
                         <span>해리 포터와 혼혈 왕자</span>
                        <span>
                            남겨진 결전을 위한 최후의 미션,<br>
                            볼드모트와 해리 포터에 얽힌 치명적인 비밀,<br>
                            선택된 자만이 통과할 수 있는 대단원을 향한 본격적인 대결이 시작된다!
                        </span>
                    </div>
                    <div class="video_wrap">
                        <video src="/resources/video/HarryPotter-6.mp4" controls autoplay muted loop></video>
                    </div>
                    <div class="movieSelection_video_controller_wrap">
                        <a href="/movies/detail-view?movcode=10012">상세보기</a>
                    </div>    
                </div>
            </div>
            
            <div class="contents">
            	<div class="movieChartBeScreen_btn_wrap">
                    <div class="tabBtn_wrap">
                        <h3><a href="#none" class="active" id="btnMovie">무비차트</a></h3>
                    </div>
                    <a href="/movies/moviechart" id="btn_allView_Movie" class="btn_allView">전체보기</a>
                </div>
            
            
	            <!-- 스와이프 시작 -->
	            <div class="swiper-on">
	                <div #swiperRef="" class="swiper mySwiper">
	                    <div class="swiper-wrapper">
	                     	    <c:forEach items="${list}"  var="movlist">
								    	<div class="swiper-slide">
								    		<a href="/movies/detail-view?movcode=${movlist.movcode}">
							              		<img src="/display?fileName=${movlist.fullname}" alt="${movlist.movname} 포스터" >
							             	</a>
							              <p>
							              	<a href="/movies/detail-view?movcode=${movlist.movcode}">
							              	${movlist.movname}</a>	
							              </p>
							          </div>
							    </c:forEach>
	                    </div>
	                    <div class="swiper-button-next"><i class="material-icons">chevron_right</i></div>
	                    <div class="swiper-button-prev"><i class="material-icons">chevron_left</i></div>
	                    <!-- <div class="swiper-pagination"></div> -->
	                </div>
	            </div>
	           
            </div>
        </div>

    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
  
    <!-- Initialize Swiper -->
    <script>

      var swiper = new Swiper(".mySwiper", {
        slidesPerView: 5,
        centeredSlides: false,
        spaceBetween: 30,
        pagination: {
          el: ".swiper-pagination",
          type: "fraction",
        },
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
      });
    </script>
<%@ include file="./footer.jsp" %>
</body>
</html>