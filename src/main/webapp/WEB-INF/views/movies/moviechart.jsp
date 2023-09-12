<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
	<div id="contaniner" class="">
    <div id="contents" class="">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <div class="wrap-movie-chart contentsStart">
        <!-- Heading Map Multi -->
            <div class="tit-heading-wrap">
                <h3>무비차트</h3>
                <div class="submenu">
                    <ul>
                        <li class="on"><a href="/movies/" title="선택">무비차트</a></li>
                        <li><a href="/movies/pre-movies.aspx">상영예정작</a></li>
                        <!--<li><a href="/movies/?lt=3">CGV아트하우스</a></li>//-->
                    </ul>
                </div>
            </div>
            <div class="sect-sorting">
                <div class="nowshow">
                           <input type="checkbox" id="chk_nowshow" title="현재 선택됨" checked="">
               
                   <label for="chk_nowshow">현재 상영작만 보기</label>                
               </div>
               <label for="order_type" class="hidden">정렬</label>
               <select id="order_type" name="order-type">
                   <option title="현재 선택됨" selected="" value="1">예매율순</option>
                   <option value="2">평점순</option>
                   <option value="3">관람객순</option>
               </select>
               <button type="button" class="round gray"><span>GO</span></button>
           </div> 
           <!-- 어드민일경우 등록가능 -->
           <sec:authentication property="principal" var="principal" />
           <sec:authorize access="hasRole('ROLE_ADMIN')">
		           <div class="register-button">
		                <a href="/admin/register_movie">등록하기</a>
		           </div>       
			</sec:authorize>
           <!-- 어드민일경우 등록가능 끝-->
            <div class="sect-movie-chart">
                <h4 class="hidden">
                    무비차트 - 예매율순
                </h4>
                <ol>
                	<c:forEach items='${list}' var="movlist">
	                    <!-- 한 리스트에 한가지 작품 -->
	                    <li>
	                        <div class="box-image">
	                            <a href="/movies/detail-view?movcode=${movlist.movcode}">
	                                <span class="thumb-image">
	                                    <img src="/display?fileName=${movlist.fullname}" alt="${movlist.movname} 포스터" onerror="errorImage(this)">
	                                    <!-- 영상물 등급 노출 변경 2022.08.24 -->
	                                    <i class="cgvIcon etc age${movlist.movgrade}">${movlist.movgrade}세</i>
	                                    <!-- <span class="ico-grade 15">15</span> -->
	                                </span>
	                                
	                            </a>
	                            <span class="screentype">
	                                    <a class="" href="#" title="IMAX 상세정보 바로가기" data-regioncode="07"></a>
	                            </span>
	                        </div>
	                        
	                        <div class="box-contents">
	                            <a href="/movies/detail-view?movcode=${movlist.movcode }">
	                                <strong class="title">${movlist.movname}</strong>
	                            </a>
	
	                            <div class="score">
	                                <strong class="percent">예매율<span>54.3%</span></strong>
	                                <!-- 2020.05.07 개봉전 프리에그 노출, 개봉후 골든에그지수 노출변경 (적용 범위1~ 3위)-->
	                                <div class="egg-gage small">
	                                    <span class="sprite_preegg default"></span>
	                                    <span class="percent">99%</span>
	                                </div>
	                            </div>
	                            <span class="txt-info">
	                                <strong>
		                                <c:set var="today" value="<%=new java.util.Date()%>" />
		                                <fmt:parseDate value="${movlist.movrelease}" var="movrelease_parse" type="date" pattern="yyyy년 MM월 dd일"/>
										<fmt:parseNumber var="today_number" value="${today.time / (1000*60*60*24)}" integerOnly="true" />
		                                <fmt:parseNumber var="movrelease_number" value="${movrelease_parse.time / (1000*60*60*24)}" integerOnly="true" />
		                                <c:out value="${movlist.movrelease}"/>
		                                
		                                <c:choose>
		                                	<c:when test="${(movrelease_number - today_number) >=1}">
		                                		<span>D-${movrelease_number - today_number}</span>
		                                	</c:when>
		                                	<c:otherwise>
		                                		<span>개봉</span>
		                                	</c:otherwise>
		                                </c:choose>
	                                </strong>
	                            </span>
	                            <span class="like"> 
	                                <a class="link-reservation" href="/tickets/ticket?movcode=${movlist.movcode}">예매</a>
	                            </span>
	                        </div>    
	                    </li>
                	
                	</c:forEach>
                </ol>
                <button class="btn-more-fontbold">더보기 <i class="link-more">더보기</i></button>
            </div><!-- .sect-moviechart -->
        </div>
    </div>
</div>

<!--
  2016-
- Fried : 0 ~69
- Good :  70 ~ 84
- Great : 85 ~ 100  
//-->
<script id="temp_movie" type="text/x-jquery-tmpl">
    <li>
        <div class="box-image" >
            <a href="/movies/detail-view/?midx=${MovieIdx}">
                <span class="thumb-image">
                    <img src="${PosterImage.LargeImage}" alt="${Title}" onerror="errorImage(this)"/>
                    <!-- 영상물 등급 노출 변경 2022.08.24 -->
                    <i class="cgvIcon etc age${MovieGrade.StyleClassName}">${MovieGrade.GradeText}</i>
                    <!--<span class="ico-grade ${MovieGrade.StyleClassName}">${MovieGrade.GradeText}</span>-->
                </span>
            </a>
            <span class="screentype">
                {{each MovieKindList}}
                <a class="${StyleClassName}" href="#" data-regioncode="${RegionCode}">${KindName}</a>
                {{/each}}
            </span>
        </div>
                    
        <div class="box-contents">
            <a href="/movies/detail-view/?midx=${MovieIdx}">
                <strong class="title">${Title}</strong>
            </a>

            <div class="score">
                <strong class="percent">예매율<span>${TicketRate}%</span></strong>
                <!--2020.05.07 개봉일 12시 30분전 프리에그, 개봉일 12시 30분후 골든에그지수 노출 기준변경-->
                <div class="egg-gage small">
                    <span class="${StarPoint}"></span>
                    <span class="percent">${EggPoint}</span>
                </div>
            </div>

            <span class="txt-info">
                <strong>
                    ${OpenDate}
                    <span>${OpenText}</span>
                    {{if D_Day > 0}}
                        <em class="dday">D-${D_Day}</em>
                    {{/if}}
                </strong>
            </span>
            <span class="like"> 
                {{if (IsTicketing)}}<a class="link-reservation" href="http://www.cgv.co.kr/ticket/?MOVIE_CD=${CGVCode}&MOVIE_CD_GROUP=${MovieGroupCode}">예매</a>{{/if}}
            </span>
        </div>    
    </li>
</script>

<script type="text/javascript">

</script>
            <!--/ Contents End -->
		 </div>
		<!-- /Contents Area -->
	</div>
	
	    <%@ include file="../footer.jsp" %>
</body>
</html>