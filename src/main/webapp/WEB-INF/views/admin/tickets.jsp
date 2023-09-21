<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<%@ include file="../header.jsp"%>
<style>
.contentsStart {
	margin-top: 80px;
}

.admin .section {
	width: 100%;
}

.admin td {
	padding: 10px 0;
}

.admin button {
	font-size: 12px;
}
</style>
<title>예매 내역 조회</title>
</head>
<body>
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}">
	<input type="hidden" name="userid"
		value="﻿<sec:authentication property="principal.username"/>" />
	<!-- -------------------------------------------------------------- -->
	<!-- 예매 페이지 시작-->
	<div id="contaniner" class="">
		<div id="contents" class="">
			<div class="contentsStart">
				<div class="tit-heading-wrap">
					<h3>예매 내역 조회</h3>
				</div>
			</div>

			<div id="ticket">
				<div class="steps admin">
					<!-- step1-------------------- -->
					<div class="step" style="height: 600px; display: block;">
						<!--영화선택하기-->
						<div class="section">
							<script>
                                    $(document).on('click','#checkAll',function(){ 
                                        $('.checkGroup:not(:disabled)').not(this).prop('checked', this.checked);
                                    });
                                    $(document).on('click','.checkGroup',function(){ 
                                        if($('.checkGroup:not(:disabled)').length == $('.checkGroup:checked').length){
                                            $('#checkAll').prop('checked',true);
                                        }else{
                                            $('#checkAll').prop('checked',false);
                                        }
                                    });
                                </script>
							<table>
								<tr class="col-head">
									<th>
										<p>전체선택</p> <input type="checkbox" id="checkAll" />
									</th>
									<th>예매번호</th>
									<th>ID</th>
									<th>영화명</th>
									<th>관람극장</th>
									<th>관람일시</th>
									<th>관람인원</th>
									<th>관 / 좌석 번호</th>
									<th>가격 / 결제방식</th>
									<th></th>
								</tr>
								<c:choose>
									<c:when test="${not empty rvlist}">
										<c:forEach items="${rvlist}" var="rv">
											<tr>
												<td><input type="checkbox" class="checkGroup" /></td>
												<td class="selectdata">${rv.rvcode}</td>
												<td class="selectdata">${rv.rvuserid}</td>
												<td class="selectdata">${rv.movList.getMovname()} <input type="hidden" name= "rvmovcode" value="${rv.movList.getMovcode()}" /></td>
												<td class="selectdata">${rv.rvthname} <input type="hidden" name= "rvthcode" value="${rv.rvthcode}" /></td>
												<td class="selectdata">${rv.rvschtime}</td>
												<td class="selectdata">${rv.rvcount}</td>
												<td class="selectdata">${rv.rvschall} / ${rv.rvschseats}</td>
												<td class="selectdata">${rv.rvprice} / ${rv.paymethod}</td>
												<td>
													<button id="selectCL" class="btn btn-dark"
														onclick="Cancel1RV(this)">취소</button>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="10">예매 내역이 존재하지 않습니다</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					<script>
						function Cancel1RV(b) {
							let items = $(b).parents().siblings(".selectdata");
							console.log($(items).eq(0).html());
							let rtolist = new Array();
							let rto = {
								"rvcode" : $(items).eq(0).html(),
								"rvmovcode" : $(items).eq(2).find("input[name=rvmovcode]").val(),
								"rvthcode" : $(items).find("input[name=rvthcode]").val(),
								"rvschtime" : $(items).eq(4).html().substring(0,16),
								"rvschall" :$(items).eq(6).html().split(" / ")[0],
								"rvschseats" : $(items).eq(6).html().split(" / ")[1]
							};
							rtolist.push(rto);
							let csrfHeaderName= "${_csrf.headerName}";
							let csrfTokenValue= "${_csrf.token}";
							$.ajax({
								url : "/admin/cancel",
								type : "POST",
								dataType: "json",
								data : JSON.stringify(rtolist),
								contentType: 'application/json',
								beforeSend:function(xhr){
								       xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
								   },
								   success: function(result){
                   					alert("삭제되었습니다");
                   					if(result >= 1){
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
					<div class="deleterv">
						<button type="button" class="btn btn-primary"
							onclick="CancelAllRV()">선택 삭제</button>
					</div>
					<script>
						function CancelAllRV() {
							//체크 되어 있는 애들만 선택
							let itemslength = $("input.checkGroup:checked");
							console.log(itemslength)
							let rtolist = new Array();
							for(let i =0; i< itemslength.length; i ++){
								console.log(itemslength[i])								
							}
							for(let i =0; i< itemslength.length; i ++){
								console.log(itemslength[i]);
								let items = $(itemslength).eq(i).parents("td").siblings(".selectdata");
								//alert($(items).eq(0).html());
								
								let rto = {
									"rvcode" : $(items).eq(0).html(),
									"rvmovcode" : $(items).eq(2).find("input[name=rvmovcode]").val(),
									"rvthcode" : $(items).find("input[name=rvthcode]").val(),
									"rvschtime" : $(items).eq(4).html().substring(0,16),
									"rvschall" :$(items).eq(6).html().split(" / ")[0],
									"rvschseats" : $(items).eq(6).html().split(" / ")[1]
								};
								rtolist.push(rto);
							}
							
							console.log(rtolist);
							let csrfHeaderName= "${_csrf.headerName}";
							let csrfTokenValue= "${_csrf.token}";
							$.ajax({
								url : "/admin/cancel",
								type : "POST",
								dataType: "json",
								data : JSON.stringify(rtolist),
								contentType: 'application/json',
								beforeSend:function(xhr){
								       xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
								   },
								   success: function(result){
									alert("삭제되었습니다");
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
		</div>
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>