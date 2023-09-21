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
<input type="hidden" name="userid" value="﻿<sec:authentication property='principal.username'/>" />
<script type="text/javascript">
	$(document).ready(function(){
		let userid = $("input[name=userid]").val().trimStart();
		$("input[name=userid]").val(userid);
		
	})
</script>
       
       <div class="cols-content">
       	<div class="col-aside">
               <div class="snb">
                   <ul>
                       <li>
                           	<a href='#' onclick="goMypage()">MY CGV HOME <i></i></a>
                       </li>
                       <li class="on">
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
                       <li class="my-event"><a href="/user/movielog/watched.aspx">내가 본 영화</a></li> 
                   </ul>
               </div>
           </div>
			<div class="col-detail" id="mycgv_contents">
                <div class="tit-mycgv type2">
                    <h3>나의 예매내역</h3>
                    <p>지난 <em>1개월</em>까지의 예매내역을 확인하실 수 있으며, 영수증은 <em>신용카드 결제 내역</em>만 출력 가능합니다.</p>
                    <a href="/user/movielog/watched.aspx" class="round inblack"><span>내가 본 영화</span></a>
                </div>
                <input type="hidden" id="isIPIN" name="isIPIN" value="QLXGtkCq20XmWyDAHXmoe7IRoD8j2jlegugljiHxO4FIN36GrmaZ+ulOEU1DD081KWS0maca9lKh2akmADpMdA==">
                <div class="cols-mycgv-booking">
                    <div class="sect-register booking">
                        <p>
                            <strong>현장에서 발권하실 경우 꼭 <em>예매번호</em>를 확인하세요.</strong>
                            <span>티켓판매기에서 예매번호를 입력하면 티켓을 발급받을 수 있습니다.</span>
                        </p>
                    </div>
                    <div class="lst-item">
                    	<c:choose>
				              <c:when test="${not empty rvlist}">
				              <c:forEach items="${rvlist}" var="rv">
									<div class="lst-item">
			                            <div class="box-set-info">
			                                <div class="box-number">
			                                    <em>예매번호</em>
			                                    <strong>${rv.rvcode}</strong>
			                                    <input type="hidden" name="movcode" value="${rv.rvmovcode}">
			                                    <input type="hidden" name="thcode" value="${rv.rvthcode}">
			                                </div>
			                                <div class="box-info">
			                                    <div class="box-image">
			                                        <a href="/movies/detail-view/?midx=87246">
			                                            <span class="thumb-image">
			                                                <img src="/display?fileName=${rv.movList.getFullname()}" alt="${rv.movList.getMovname()}" onerror="errorImage(this)">
			                                            </span>
			                                        </a>
			                                    </div>
			                                                    
			                                    <div class="detail-area">
			                                        <div class="reservation-info-wrap">
			                                            <h2 class="box-contents artHouse">
			                                                <a href="/movies/detail-view?movcode=${rv.movList.getMovcode()}" class="res-title">${rv.movList.getMovname()}</a>
			                                                <span class="res-price">${rv.rvprice}원</span>
			                                            </h2>
			                                            <ul class="reservation-mv-info">
			                                                <li>
			                                                    <dl>
			                                                        <dt>관람극장</dt>
			                                                        <dd>${rv.rvthname}
			                                                            <a href="/theater/location?${rv.rvthname}">[극장정보]</a>
			                                                        </dd>
			                                                    </dl>
			                                                </li>
			                                                <li>
			                                                    <dl>
			                                                        <dt>관람인원</dt>
			                                                        <dd>${rv.rvlist}</dd>
			                                                    </dl>
			                                                </li>
			                                                <li>
			                                                    <dl>
			                                                        <dt>관람일시</dt>
			                                                        <dd class="myrvschtime txt-red">${rv.rvschtime}</dd>
			                                                    </dl>
			                                                </li>
			                                                <li>
			                                                    <dl>
			                                                        <dt>관람좌석</dt>
			                                                        <dd class="myrvschseats">${rv.rvschseats}</dd>
			                                                    </dl>
			                                                </li>
			                                                <li>
			                                                    <dl>
			                                                        <dt>상영관</dt>
			                                                        <dd class="myrvschall">${rv.rvschall}</dd>
			                                                    </dl>
			                                                </li>
			                                                <li>
			                                                    <dl>
			                                                        <dt>매수</dt>
			                                                        <dd>${rv.rvcount}</dd>
			                                                    </dl>
			                                                </li>
			                                            </ul>
			                                        </div>
			                                    </div>
			                                </div>
			
			                                <div class="set-btn">
			                                    <input type="hidden" class="reserve-no" name="reserve-no" value="E7XuLUd8l9w/J2EnY1kBs+H8iJKCt/Zi5WOHI1Red2c=">
			                                    <div class="col-edit"></div><div class="col-print">
			                                        <button type="button" class="round inblack hometicket">
			                                            <span>예매정보 출력</span>
			                                        </button>
			                                        <button type="button" data-status="94" onclick="CancelReservation(this)"
			                                        class="round black cancel">
			                                            <span>예매취소</span>
			                                        </button>
			                                    </div>
			                                </div>
											<script>
												function CancelReservation(html) {
													const userid = $("input[name=userid]").val();
													const rvcode = $(html).closest(".lst-item").find(".box-number strong").html();
													
													const rvmovcode = $(html).closest(".lst-item").find("input[name=movcode]").val();
													const rvthcode = $(html).closest(".lst-item").find("input[name=thcode]").val();
													
													const rvschall = $(html).closest(".lst-item").find(".myrvschall").html();
													const rvschtime = $(html).closest(".lst-item").find(".myrvschtime").html().substring(0,10);
													const rvschseats = $(html).closest(".lst-item").find(".myrvschseats").html();
													
													//alert(rvmovcode+"/"+rvthcode+"/"+rvschtime+"/"+rvschseats);
													
													$.ajax({
	                                    				url: '/member/cancel',
	                                    				data: {rvcode: rvcode, rvmovcode:rvmovcode, rvthcode:rvthcode,
	                                    					rvschall:rvschall, rvschtime:rvschtime, rvschseats:rvschseats},
	                                    				type: 'GET',
	                                    				dataType: 'json',
	                                    				success: function(result){
	                                    					//alert("결과좀 알려줄래" + result)
	                                    					if(result == 1){
		                                    					//console.log("영화 클릭 ajax 결과 : " +result);
		                                    					location.reload();
	                                    					}
	                                    					else{
	                                    						alert("잠시후 다시 시도해주세요");
	                                    					}
	                                    				},
	                                    				error : function(){
	                                    					alert("서버요청실패");
	                                    				}
													})
												}
											</script>
			                            </div>
			                        </div>
	                         </c:forEach>			              
				              </c:when>
				              <c:otherwise>
				              		<div class="box-set-info nodata" style="display: none;">
			                            고객님의 최근 예매내역이 존재하지 않습니다.
			                        </div>
				              </c:otherwise>
			             </c:choose>
                        
                        
                        
                    </div>
                </div>
                <div class="sect-mycgv-cancle">
	                 <div class="tit-mycgv">
	                     <h4>MY 취소내역</h4>
	                     <p>상영일 기준 지난 7일 동안의 취소내역입니다.</p>
	                 </div>
	                 <div class="tbl-data">
	                     <table summary="상영일 기준 지난 7일 동안의 취소내역">
	                         <caption>MY 취소내역</caption>
	                         <thead>
	                             <tr>
	                                 <th scope="col">관람 영화/매점</th>
	                                 <th scope="col">관람CGV</th>
	                                 <th scope="col">관람 일시</th>
	                                 <th scope="col">취소일</th>
	                                 <th scope="col">결제취소 금액</th>
	                             </tr>
	                         </thead>
	                         <tbody>
	                             <tr><td colspan="5" class="nodata">고객님의 최근 취소내역이 존재하지 않습니다.</td></tr>
	                         </tbody>
	                     </table>
	                 </div>
                </div>
                        <!-- CGV 예매 관련 정책 안내 Box Type -->
                        <div class="sect-box-descri">
                            <h4>CGV 예매 관련 정책 안내</h4>
                            <!-- Box Moudle -->
                            <div class="box-polaroid">
                                <div class="box-inner">
                                    <ul>
                                        <li>
                                            <dl>
                                                <dt>이용안내</dt>
                                                <dd>
                                                    <ul>
                                                        <li>예매 변경은 불가능하며, 취소 후 재 예매를 하셔야만 합니다.</li>
                                                        <li>영수증은 상영 시간 전까지 My CGV 에서 출력하실 수 있습니다. 단, 신용카드로 예매하신 경우만 한합니다.</li>
                                                        <li>상영 시간 이후 관람하신 영화의 영수증 출력을 원하실 경우, 1544-1122로 문의 주시기 바랍니다.</li>
                                                        <li>취소하신 내역이 나타나지 않거나 궁금하신 사항이 있으시면, 고객센터로 문의해 주시기 바랍니다.</li>
                                                    </ul>
                                                </dd>
                                            </dl>
                                        </li>
                                        <li>
                                            <dl>
                                                <dt>티켓 교환방법</dt>
                                                <dd>
                                                    <ul>
                                                        <li>
                                                            <p><strong>티켓판매기(ATM)에서 발권하실 경우</strong><br>예매번호 또는 고객인증번호 (법정생년월일 6자리 + 휴대폰번호 뒷 7~8자리)를 입력하시면 티켓을 편하게 발권하실 수 있습니다.</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>매표소에서 발권하실 경우</strong><br>티켓교환권을 출력하여 매표소에 방문하시면 티켓으로 교환하실 수 있습니다.<br>
                                                            (티켓교환권 출력이 어려운 경우, 예매번호와 신분증을 지참하시면 매표소에서 티켓을 수령하실 수 있습니다.)</p>
                                                        </li>
                                                    </ul>
                                                </dd>
                                            </dl>
                                        </li>
                                        <li>
                                            <dl>
                                                <dt>예매 취소 안내</dt>
                                                <dd>
                                                    <ul>
                                                        
                                                        <li>
                                                            <p><strong>신용카드</strong><br> 결제 후 3일 이내 취소 시 승인 취소 가능, 3일 이후 매입 취소시 영업일 기준 3~5일 소요</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>체크카드</strong><br>결제 후 3일 이내 취소 시 당일 카드사에서 환불처리. 3일 이후 매입 취소 시 카드사에 따라 3~10일 이내 카드사에서 환불</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>휴대폰 결제</strong><br> 
                                                                결제 일자 기준 당월(1~말일)취소만 가능. 익월 취소 관련 문의는 CGV고객센터(1544-1122) 연락 요망<br>
                                                                예매취소 후 당일 환불이 원칙이나 현장 취소 시 경우에 따라 익일 처리 될 수 있음.</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>카카오페이</strong><br>
                                                                카카오페이머니나 카카오포인트를 사용하신 경우 각각의 잔액으로 원복되며, 카드 결제를 하신 경우는 카드사 정책에 따라 승인취소가 진행되며 3일 이후 매입 취소시 영업일 기준 3~10일 소요됩니다.</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>PAYCO</strong><br>
                                                                PAYCO 쿠폰/포인트를 사용하신 경우 각각의 쿠폰/포인트로 원복되며 쿠폰의 경우 조건에 따라 재사용이 불가 할 수 있습니다. 카드 결제금액은&nbsp;카드사 정책에 따라 승인취소가 진행되며&nbsp;3일 이후 매입 취소시 영업일 기준 3~10일 소요됩니다.</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>스마일페이</strong><br> 
                                                                스마일캐시를 사용하신 경우 스마일캐시로 원복되며, 카드 결제금액은 카드사 정책에 따라 승인취소가 진행되며 3일 이후 매입취소 시 영업일 기준 3~10일 소요됩니다.</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>NAVER Pay</strong><br>
                                                                NAVER Pay 포인트를 사용하신 경우 NAVER Pay 포인트로 원복되며, 카드사 결제를 하신 경우는 카드사 정책에 따라 승인취소가 진행되며 3일 이후 매입 취소시 영업일 기준 3~10일 소요됩니다.</p>
                                                        </li>
                                                        <li>
                                                            <p><strong>카카오톡 선물하기 복합상품</strong><br>
                                                                카카오톡 선물하기 복합상품 (2인 PKG / 1인 PKG)은 매점쿠폰 사용 시, 예매 티켓 환불 불가.<br>
                                                                ※ 단, 매점 쿠폰 미 사용 시, 예매 티켓 환불 가능하며 재 예매 시, 새로운 매점 쿠폰 발급.</p>                                        
                                                        </li>
                                                        <li>
                                                            <p><strong>계좌이체</strong><br> 
                                                                1. 예매일 이후 7일 이내 취소 시<br>
                                                                - 자동 환불 은행: 취소 후 즉시 처리가능<br>
                                                                - 조흥, 신한, 외한, 한미, 우리, 우체국, 전북, 경남, 광주, 대구, 새마을, 제주<br>
                                                                - 우리은행의 경우 당일 취소분만 즉시 처리 가능<br>
                                                                - 수동 환불 은행: 농협(취소 후 2~3일 이내 입금), 부산/제일/우리(취소 후 3~5일 이내 입금)<br><br>
                        
                                                                2. 예매 7일 이후~상영시간 30분 전 취소 시(단, 일부 당일 취소 불가 행사의 경우 전일 취소 시)<br>
                                                                - 환불은 환불 요청일로부터 7일 이상 소요됨<br><br>
                        
                                                                ※ 기타 환불 관련 문의는 CGV고객센터 1544-1122로 연락바랍니다.
                                                            </p>
                                                        </li>
                                                    </ul>
                                                </dd>
                                            </dl>
                                        </li>
                        
                                        <li>
                                            <dl>
                                                <dt>환불 규정 안내</dt>
                                                <dd>
                                                    <ul>
                                                        <li>
                                                            <p><strong>현장 취소를 하는 경우</strong><br>상영시간 이전까지만 가능하며, 상영시간 이후 취소나 환불은 되지 않습니다.</p>
                                                                            
                                                        </li>
                                                        <li>
                                                            <p>
                                                                <strong>홈페이지에서 예매 취소할 경우</strong><br>
                                                                부분 취소는 불가능합니다. (ex. 4장을 인터넷으로 예매한 경우 4장 모두 취소만 가능)<br>
                                                                홈페이지 예매 취소는 상영시간 20분전까지 가능합니다.<br>
                                                                <em style="color:#0000FF" ;="">(단, 씨네&amp;포레관, 씨네&amp;리빙룸, SUITE CINEMA 제외)</em><br>
                                                                상영시간 이후 취소나 환불은 되지 않습니다</p>	            					
                                                        </li>
                                                        <li>
                                                            <p>
                                                                <strong>모바일 앱/웹(m.cgv.co.kr)에서 예매 취소할 경우</strong><br>
                                                                부분 취소는 불가합니다.(ex. 4장을 인터넷으로 예매한 경우 4장 모두 취소만 가능)<br> 
                                                                모바일 앱/웹 예매 취소는 상영시간 15분전까지 가능합니다.<br>
                                                                <em style="color:#0000FF" ;="">(단, 씨네&amp;포레관, 씨네&amp;리빙룸, SUITE CINEMA 제외)</em><br> 
                                                                상영시간 이후 취소나 환불은 되지 않습니다.
                                                            </p>
                                                        </li>
                                                        <li>
                                                            <p><strong>단, 일부 행사의 경우 행사 당일 취소, 변경 불가 합니다.</strong></p>
                                                        </li>
                                                    </ul>
                                                </dd>
                                            </dl>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <form name="targetform" id="targetform" method="post" novalidate="novalidate">
                            <input type="hidden" name="reverse_no" id="reverse_no">
                            <input type="hidden" name="theater_code" id="theater_code">
                        </form>
           </div>
            </div> <!-- cols contensts 끝 -->
		</div> <!-- #contents 끝-->
	</div> <!-- contaniner 끝 -->
<%@ include file="../footer.jsp" %>
</body>
</html>