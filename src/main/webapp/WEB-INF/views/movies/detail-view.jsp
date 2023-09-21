<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<div id="contaniner" class="">
    <div id="contents" class="">
    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="contentsStart">
				<div class="tit-heading-wrap">
					<h3>상세정보</h3>
				</div>
			</div>
			<div class="sect-base-movie" style="display: flex;">
		    	<h3><strong>영화제목</strong>기본정보</h3>
			    <div class="box-image">
			        <a href="#" title="포스터 크게 보기 새창" target="_blank">
			            <span class="thumb-image"> 
			                <img src="/display?fileName=${board.fullname}" alt="${board.movname} 포스터 새창" onerror="errorImage(this)">
			                <i class="cgvIcon etc age${board.movgrade}"><c:out value="${board.movgrade}" /></i>
			            </span> 
			        </a> 
			    </div>
			    <div class="box-contents">
			        <div class="title"> 
			        	<strong>${board.movname}</strong>
			        	 <c:set var="today" value="<%=new java.util.Date()%>" />
						<fmt:parseDate value="${board.movrelease.substring(0,10)}" var="movrelease_parse" pattern="yyyy-MM-dd"/>
						<fmt:parseNumber var="today_number" value="${today.time / (1000*60*60*24)}" integerOnly="true" />
						<fmt:parseNumber var="movrelease_number" value="${movrelease_parse.time / (1000*60*60*24)}" integerOnly="true" />
						<%--<c:out value="${board.movrelease.substring(0,10)}"/> --%>
						<c:choose>
							<c:when test="${(movrelease_number - today_number) >=1}">
								<em class="round brown"><span>예매중</span></em>
								<em class="round red"><span>D-${movrelease_number - today_number}</span></em>
							</c:when>
							<c:otherwise>
								<span>현재상영중</span>
							</c:otherwise>
						</c:choose>
			        </div>
			        <div class="score"> 
			            <strong class="percent">예매율&nbsp;<span>40.8%</span></strong>
			            <div class="egg-gage small">
			                <span class="sprite_preegg default"></span>
			                <span class="percent">99%</span>
			            </div>
			        </div>
			        <!-- 떨어지는 얘 이전 요소에 class=on을 넣는다 -->
			        <div class="spec">
			            <dl>
			                <dt>감독 :&nbsp;</dt>
				                <dd>
			                        <a href="/movies/persons/?pidx=11015"><c:out value="${board.movdirector}"/></a>                    
				                </dd>
			                <dt>장르 :<c:out value="${board.movgenre}"/></dt> 
			           	    	<dd></dd>
			                <dt>&nbsp;/ 기본 정보 :&nbsp;</dt>
			                <!-- 2023.04.27 영화상세 등급 표기 수정--> 
			                <!--<dd class="on">15,&nbsp;180분,&nbsp;미국, 영국</dd>-->
			                <dd class="on">${board.movgrade }세이상관람가,&nbsp;${board.movrunningtime }분</dd>
			                <dt>개봉 :&nbsp;</dt>
			                <dd class="on"><c:out value="${board.movrelease.substring(0,10)}"/></dd>
			            </dl>
			        </div>
			        <sec:authorize access="!hasRole('ROLE_ADMIN')">
				        <span class="like">
				            <a class="link-reservation" href="/tickets/ticket">예매하기</a> 
				        </span>
			        </sec:authorize>
					<!-- 어드민일경우 수정가능 -->
			         <sec:authentication property="principal" var="principal" />
			         <sec:authorize access="hasRole('ROLE_ADMIN')">
			           		<span class="like">
						            <a class="link-reservation" href="/admin/modify_movie?movcode=${board.movcode}">수정하기</a> 
					        </span>
					</sec:authorize>
			         <!-- 어드민일경우 수정가능 끝-->
			    </div>	
			</div>
	</div>
</div>

    <%@ include file="../footer.jsp" %>
</body>
</html>