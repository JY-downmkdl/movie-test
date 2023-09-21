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
		           <!-- 어드민일경우 등록가능 -->
		           <sec:authentication property="principal" var="principal" />
		           <sec:authorize access="hasRole('ROLE_ADMIN')">
				           <div class="register-button">
				                <a href="/admin/register_movie">등록하기</a>
				           </div>       
					</sec:authorize>
		           <!-- 어드민일경우 등록가능 끝-->
                </div>
            </div>
            <!-- 
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
			 -->
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
	                            	<sec:authorize access="hasRole('ROLE_ADMIN')">
	                            		<c:choose>
											<c:when test="${movlist.thstates eq 1}">
			                            		<a class="link-reservation" href="/admin/thstateOFF?movcode=${movlist.movcode}">상영중지</a>
											</c:when>
											<c:otherwise>
			                            		<a class="link-reservation" href="/admin/thstateON?movcode=${movlist.movcode}">상영/재개봉</a>
											</c:otherwise>
	                            		</c:choose>
	                            	</sec:authorize>
	                            	<sec:authorize access="!hasRole('ROLE_ADMIN')">
		                                <a class="link-reservation" href="/tickets/ticket?movcode=${movlist.movcode}">예매</a>
	                            	</sec:authorize>
	                            </span>
	                        </div>    
	                    </li>
                	
                	</c:forEach>
                </ol>
            </div><!-- .sect-moviechart -->
        </div>
    </div>
</div>
	
	    <%@ include file="../footer.jsp" %>
</body>
</html>