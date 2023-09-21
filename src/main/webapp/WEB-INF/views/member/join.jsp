<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
<%@ include file="../header.jsp" %>

 <div id="contaniner" class="">
        <div id="contents" class="">
            <div class="contentsStart">
                <div class="tit-heading-wrap">
                    <h3>회원가입</h3>
                </div>
            </div>
            <div class="join mx-auto">
                <form action="/member/join" class="join" method="post">
                    <table>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <tr>
                            <td class="py-3">아이디</td>
                            <td class="py-3">
                            	<div style="display: flex;align-items: center;">
	                                <input type="text" name="userid" required maxlength="12">
	                                <input type="button" name="idCheck" class="btn btn-primary btn-sm" value="중복확인">
	                                <p id = "checkId"></p>
                            	</div>
                                <span>*아이디는 영소문자 조합 8자리 이상으로 입력</span>
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
                            <td class="py-3"> <input type="text" name="username" required> </td>
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
			let formObj = $("form.join");
			if($("input[name=userid]").val() == ""){
				alert("아이디를 입력해주세요");
				$("input[name=userid]").focus();
				return false;
			}
			if($("#checkId").text() == ""){
				alert("아이디 중복확인 해주세요");
				return false;
			}
			if($("#checkId").text() == "사용할 수 없는 아이디입니다."){
				alert("중복되지 않는 아이디를 입력해주세요");
				return false;
			}
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
			
			
			
			formObj.submit();
		})
		
		//아이디 중복확인!!
		$("input[name='idCheck']").on("click",function(){
			let reg = /^(?=.*?[A-z])(?=.*?[0-9]).{8,}$/;
			let id = $("input[name='userid']").val();
			if(!reg.test(id)){
				alert("아이디는 영소문자 조합 8자리 이상 입력해주세요");
				return;
			}
			let csrfHeaderName= "${_csrf.headerName}";
			let csrfTokenValue= "${_csrf.token}";
			$.ajax({
				url : "/member/IdCheckService",
				type : "post",
				data : {id: id},
				beforeSend:function(xhr){
				       xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				   },
				success : function(cnt){
					if(cnt != "1"){
						$("#checkId").html('사용 가능한 아이디입니다.');
						$("#checkId").css('color','green');
					} else{
						$("#checkId").html('사용할 수 없는 아이디입니다.');
						$("#checkId").css('color','red');
					} 
				},
				error : function(){
					alert("서버요청실패");
				}
			})
			
		})
	})
	</script>
<%@ include file="../footer.jsp" %>
</body>
</html>