<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="./header.jsp" %>
<body>
<!-- 검색 컨텐츠 시작-->
<div id="contaniner" class="">
    <div id="contents" class="">
        <div class="contentsStart">
            <h1 class="tit-heading-wrap">검색 결과</h1>
            <div class="search-movie search-cate-title">
            <c:choose>
            	<c:when test="${not empty movresult}">
            		<h2>영화 (<span>${movresult.size()}</span>)</h2>
	            </c:when>
	            <c:otherwise>
	            	<h2>영화 (<span>0</span>)</h2>
            	</c:otherwise>
            </c:choose>
            
                <div class="search_result">
                    <ul>
                        <!--반복시작-->
                        <c:choose>
                        	<c:when test="${not empty movresult}">
                        		<c:forEach items="${movresult}" var="movList">
                        			<li>
			                            <div class="box-image">
				                            <a href="/movies/detail-view?movcode=${movList.movcode }">
				                                <img src="/display?fileName=${movList.fullname}" alt="${movList.movname} 포스터" onerror="errorImage(this)">
				                            </a>
			                            </div>
			                            
			                            <div class="box-contents">
			                                <a href="/movies/detail-view?movcode=${movList.movcode }">
			                                    <strong class="title">${movList.movname}</strong>
			                                </a>
			        
			                                <span class="txt-info">
			                                     <strong>
					                                <c:set var="today" value="<%=new java.util.Date()%>" />
					                                <fmt:parseDate value="${movList.movrelease}" var="movrelease_parse" type="date" pattern="yyyy년 MM월 dd일"/>
													<fmt:parseNumber var="today_number" value="${today.time / (1000*60*60*24)}" integerOnly="true" />
					                                <fmt:parseNumber var="movrelease_number" value="${movrelease_parse.time / (1000*60*60*24)}" integerOnly="true" />
					                                <c:out value="${movList.movrelease}"/>
					                                
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
			                            </div>    
			                        </li>
                        		</c:forEach>
                        	</c:when>
                        	<c:otherwise>
                        		<p style="color:#ddd">검색결과가 없습니다.</p>
                        	</c:otherwise>
                        </c:choose>
                        
                        <!--반복끝-->
                       
                </div>
                <p class="click_more">더보기 ></p>
            </div>
            <div class="search-theater search-cate-title">
	            <c:choose>
	            	<c:when test="${not empty thresult}">
	            		<h2>극징 (<span>${thresult.size()}</span>)</h2>
		            </c:when>
		            <c:otherwise>
		            	<h2>극장 (<span>0</span>)</h2>
	            	</c:otherwise>
	            </c:choose>
                <div class="search_result">
                    <ul>
                        <!--반복시작-->
                        <li class="theater-info">
                        <c:choose>
                        	<c:when test="${not empty thresult}">
                        		<c:forEach items="${thresult}" var="thList">
                            		<h3>${thList.thname} <span>${thList.thaddress}</span></h3>
                            	</c:forEach>
                            </c:when>
                            <c:otherwise>
                            	<p style="color:#ddd">검색결과가 없습니다.</p>
                            </c:otherwise>
						</c:choose>
                        </li>
                        <!--반복끝-->
                    </ul>
                </div>
                <p class="click_more">더보기 ></p>
            </div>
            <div class="search-director search-cate-title">
                <h2>감독 (<span>0</span>)</h2>
    
                <div class="search_result">
                    <p style="color:#ddd">검색결과가 없습니다.</p>
                </div>
                <p class="click_more">더보기 ></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>