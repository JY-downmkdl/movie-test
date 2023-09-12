<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./header.jsp" %>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"
/>
<style>
	 swiper-container {
      width: 100%;
      height: 100%;
    }

    swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    swiper-slide img {
      display: block;
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    swiper-container {
      width: 100%;
      height: 300px;
      margin: 20px auto;
    }

    .append-buttons {
      text-align: center;
      margin-top: 20px;
    }

    .append-buttons button {
      display: inline-block;
      cursor: pointer;
      border: 1px solid #007aff;
      color: #007aff;
      text-decoration: none;
      padding: 4px 10px;
      border-radius: 4px;
      margin: 0 10px;
      font-size: 13px;
    }
</style>
</head>
<body>
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
	
			<div class="movieChartBeScreen_wrap">
                <div class="contents">

			  <swiper-container class="mySwiper" slides-per-view="3" centered-slides="true" space-between="30" pagination="true"
			    pagination-type="fraction" navigation="true">
				
		<div class="swiper-slide">Slide 1</div>
		    <div class="swiper-slide">Slide 2</div>
		    <div class="swiper-slide">Slide 3</div>
				    
				    <div class="swiper-button-prev"></div>
  					<div class="swiper-button-next"></div>
			  </swiper-container>
			
			  <p class="append-buttons">
				    <button class="prepend-2-slides">Prepend 2 Slides</button>
				    <button class="prepend-slide">Prepend Slide</button>
				    <button class="append-slide">Append Slide</button>
				    <button class="append-2-slides">Append 2 Slides</button>
			  </p>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper(".mySwiper", {
      slidesPerView: 3,
      centeredSlides: true,
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

    var appendNumber = 4;
    var prependNumber = 1;
    document
      .querySelector(".prepend-2-slides")
      .addEventListener("click", function (e) {
        e.preventDefault();
        swiper.prependSlide([
          '<div class="swiper-slide">Slide ' + --prependNumber + "</div>",
          '<div class="swiper-slide">Slide ' + --prependNumber + "</div>",
        ]);
      });
    document
      .querySelector(".prepend-slide")
      .addEventListener("click", function (e) {
        e.preventDefault();
        swiper.prependSlide(
          '<div class="swiper-slide">Slide ' + --prependNumber + "</div>"
        );
      });
    document
      .querySelector(".append-slide")
      .addEventListener("click", function (e) {
        e.preventDefault();
        swiper.appendSlide(
          '<div class="swiper-slide">Slide ' + ++appendNumber + "</div>"
        );
      });
    document
      .querySelector(".append-2-slides")
      .addEventListener("click", function (e) {
        e.preventDefault();
        swiper.appendSlide([
          '<div class="swiper-slide">Slide ' + ++appendNumber + "</div>",
          '<div class="swiper-slide">Slide ' + ++appendNumber + "</div>",
        ]);
      });
  </script>
                </div> <!-- contents 끝 -->
            </div>
	</div>
<%@ include file="./footer.jsp" %>
</body>
</html>