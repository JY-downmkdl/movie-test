<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="/resources/css/bootstrap.css">
    <style>
    	.join .form-control{
    		display:inline;
    		width: 10%;
    	}
    	.join p {
        	padding-left: 10px;
    	}
        .join span{
       		color: #666;
       		font-size:12px;
       	}
        td:not(:first-child).py-3 {
            text-align: start;
        }

        .buttons{
            text-align: center;
        }
        
    </style>
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
	<div class="cols-content">
       	<div class="col-aside">
               <div class="snb">
                   <ul>
                       <li>
                           	<a href='#' onclick="goMypage()">MY CGV HOME <i></i></a>
                       </li>
                       <li>
                           <a href='/member/reserve?userid=<sec:authentication property="principal.username"/>' title="현재 선택">나의 예매내역</a>
                       </li>
                       <li class="on">
                           <a href='/member/myinfo?userid=<sec:authentication property="principal.username"/>'>회원정보<i></i></a>
                           <ul>
                                <li class="on">
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
	      <!-- cols - detail -->
                <div class="col-detail" id="mycgv_contents">
                    <div class="tit-mycgv">
                        <h3>정보 변경</h3>
                    </div>
                    <div class="join mx-auto">
                    	<c:set var="list" value="${list}"/>
                        <form action="/member/update" class="update" method="post">
                            <table>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <tr>
                                    <td class="py-3">아이디</td>
                                    <td class="py-3">
                                        <div style="display: flex;align-items: center;">
                                        	<input type="text" name="userid" value="﻿<sec:authentication property='principal.username'/>" disabled/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
		                            <td class="py-3">비밀번호</td>
		                            <td class="py-3"> <input type="password" name="userpw" required maxlength="20"> </td>
		                        </tr>
		                        <tr>
		                            <td class="py-3">비밀번호 확인</td>
		                            <td class="py-3"> <input type="password" name="userpwck" required maxlength="20"> </td>
		                        </tr>
                                <tr>
                                    <td class="py-3">이름</td>
                                    <td class="py-3"> <input type="text" name="username" value="${list.username}" required> </td>
                                </tr>
                                <tr>
                                    <td class="py-3">휴대폰 번호</td>
		                            <td class="py-3">
		                                <input type="hidden" name="phone" value=""/>
		                                <input type="text" name="phone1" required maxlength="3"
		                                	oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> -
		                                <input type="text" name="phone2" required maxlength="4"
		                                	oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> -
		                                <input type="text" name="phone3" required maxlength="4"
		                                	oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
		                            </td>
                                </tr>
                                <tr>
                                    <td class="py-3">생일</td>
                                    <td class="py-3">
                                        <input type="hidden" name="birth" value=""/>
                                        <select name="birth1" class="form-control">
                                        <option value="">년</option>
                                        <c:forEach var="i" begin="1900" end="2023">
                                            <option value="${i}">${i}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="birth2" class="form-control">
                                        <option value="">월</option>
                                        <c:forEach var="i" begin="1" end="12">
                                            <c:choose>
                                                <c:when test="${i lt 10 }">
                                                <option value="0${i}">0${i}</option>
                                                </c:when>
                                                <c:otherwise>
                                                <option value="${i}">${i}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                    <select name="birth3" class="form-control">
                                        <option value="">일</option>
                                            <c:forEach var="i" begin="1" end="31">
                                                <c:choose>
                                                <c:when test="${i lt 10 }">
                                                    <option value="0${i}">0${i}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${i}">${i}</option>
                                                </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                    </select>
                                    </td>
                                </tr>
                            </table>
                            <div class="buttons">
                                <button type="submit" class="btn btn-primary">등록</button>
                                <button class="btn btn-secondary" onclick="location.href='/index'">취소</button>
                            </div>
                        </form>
                    </div>
                </div>
				<script type="text/javascript">
					$(document).ready(function(){
						$("button[type='submit']").on("click",function(e){
							let phone = $("input[name='phone1']").val()+"-"+$("input[name='phone2']").val()+"-"+$("input[name='phone3']").val();
							let birth = $("select[name='birth1']").val()+"-"+$("select[name='birth2']").val()+"-"+$("select[name='birth3']").val();
							$("input[name='phone']").attr('value', phone);
							$("input[name='birth']").attr('value', birth);
							
							//연결된 이벤트 제거 (submit전송 제거 )
							e.preventDefault();
							let formObj = $("form.update");
							
							if($("input[name=userpw]").val() == ""){
								alert("비밀번호를 입력해주세요");
								$("input[name=userpw]").focus();
								return false;
							}
							if($("input[name=userpwck]").val() == ""){
								alert("비밀번호를 확인해주세요");
								$("input[name=userpwck]").focus();
								return false;
							}
							
							if($("input[name=username]").val() == ""){
								alert("이름을 입력해주세요");
								$("input[name=username]").focus();
								return false;
							}
							if($("input[name='phone1']").val() == ""||$("input[name='phone2']").val() == ""||$("input[name='phone3']").val() == ""){
								alert("휴대폰번호를 입력해주세요");
								$("input[name=phone1]").focus();
								return false;
							}
							if($("input[name='birth1']").val() == ""||$("input[name='birth2']").val() == ""||$("input[name='birth3']").val() == ""){
								alert("생년월일을 입력해주세요");
								$("input[name=birth1]").focus();
								return false;
							}
							if($("input[name=userpw]").val() != $("input[name=userpwck]").val()){
								alert("비밀번호를 다시 확인 해주세요");
								return false;
							}
							
							$("input[name=userid]").attr("disabled", false);
							formObj.submit();
						})
						
					})
					</script>
			</div> <!-- cols contensts 끝 -->				
		</div> <!-- #contents 끝-->
	</div> <!-- contaniner 끝 -->
<%@ include file="../footer.jsp" %>
</body>
</html>