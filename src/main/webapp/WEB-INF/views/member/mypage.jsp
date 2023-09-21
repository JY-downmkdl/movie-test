<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<%@ include file="../header.jsp" %>
<%@ include file="./myheader.jsp" %>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

<script type="text/javascript">
	$(document).ready(function(){
		let userid = $("input[name=userid]").val().trimStart();
		$("input[name=userid]").val(userid);
	})
</script>

	      <div class="cols-content" id="menu">
	       	<div class="col-aside">
	               <div class="snb">
	                   <ul>
	                       <li class="on">
	                           	<a href='#' onclick="goMypage()">MY CGV HOME <i></i></a>
	                       </li>
	                       <li>
	                           <a href='/member/reserve?userid=<sec:authentication property="principal.username"/>' title="현재 선택">나의 예매내역</a>
	                       </li>
	                       <li>
	                           <a href='/member/myinfo?userid=<sec:authentication property="principal.username"/>'>회원정보<i></i></a>
	                           <ul>
	                                <li>
	                                   <a href='/member/myinfo?userid=<sec:authentication property="principal.username"/>'>개인정보 변경</a>
	                               </li>
	                               <li>
	                                   <a href="#">회원탈퇴</a>
	                               </li>
	                           </ul>
	                       </li>
	                       
	                       <li>
	                           <a href="/member/myqna">나의 문의내역 <i></i></a>
	                           <ul>
	                               <li>
	                                   <a href="/member/myqna">1:1 문의</a>
	                               </li>
	                               <li>
	                                   <a href="#">분실물 문의</a>
	                               </li>
	                           </ul>
	                       </li>
	                       <li class="my-event"><a href="#">내가 본 영화</a></li> 
	                   </ul>
	               </div>
	           </div>
				<div class="col-detail" style="display: block;">
	                    <div class="tit-mycgv">
	                        <h3>MY 예매내역</h3>
	                        <p><em>${rvlist.size()}건</em> <a href="/member/reserve">예매내역 더보기</a></p>
	                        <span>예매번호로만 티켓을 찾을 수 있으니 반드시 확인 부탁드립니다.</span>
	                    </div>
	                    <form name="aspnetForm" method="post" action="" id="aspnetForm" novalidate="novalidate">
	                        <div>
	                        <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="">
	                        <input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="">
	                        <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTc0NzIwMTk3M2RkGpTZbHfO8pvW/Ta9En5loRX6E2E=">
	                        </div>
	                        <div>
	                            <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="F268F2D4">
	                            <input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEdAANOZtRado8flmBd6Juf8OumAAaiyC+ogOIlg3pscMtiP2lKUwCIH8TI/sjrTPJzW37qSeqQYBLB9CRMYU4y53rNrIwxzA==">
	                        </div>
	                       
	                        <input type="hidden" id="hidCancelReserveNo" name="hidCancelReserveNo">
	                        <div class="sect-base-booking">
	                            <div class="box-polaroid">
	                                <div class="box-inner">
	                                	 
			                                <c:choose>
			                                	<c:when test="${not empty rvlist}">
			                                		<div class="items-item" style="display: block;">
			                                			<c:forEach items="${rvlist}" var="rv">
			                                				<ul class="display_items" >
					                                            <li>${rv.rvmovname}</li>
					                                            <li>${rv.rvthname}/ ${rv.rvschall}</li>
					                                            <li>${rv.rvrunning}</li>
					                                            <li>${rv.rvschseats}</li>
					                                            <li>${rv.rvcode}</li>
					                                        </ul>
			                                			</c:forEach>
				                                    </div>
			                                	</c:when>
			                                	<c:otherwise>
				                                    <div class="lst-item" style="display: block;">
				                                        <ul class="display_items" >
					                                            <li>고객님의 최근 예매내역이 존재하지 않습니다.</li>
				                                        </ul>
				                                    </div>
			                                	</c:otherwise>
			                                </c:choose>
	                                    
	                                </div>
	                            </div>
	                        </div>
	                    </form>
	
	                    <div class="sect-mycgv-part">
	                        <div class="box-polaroid type1">
	                            <div class="box-inner">
	                                <div class="tit-mycgv">
	                                    <h3>MY Q&amp;A</h3>
	                                    <p><em>0건</em> <a href="#">MY Q&amp;A 더보기</a></p>
	                                </div>
	                                <div class="col-myqna">
	                                        <ul>
	                                            <li>고객님의 1:1 문의내역이 존재하지 않습니다.</li>
	                                        </ul>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                    
                    
            </div> <!-- cols contensts 끝 -->

		</div> <!-- #contents 끝-->
	</div> <!-- contaniner 끝 -->
<%@ include file="../footer.jsp" %>
</body>
</html>