<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ include file="../header.jsp" %>
<div id="contaniner" class="">
    <div id="contents" class="">
    	<div class="contentsStart">
    		<h2>회원가입</h2>
	<form action="/member/join" class="join" method="post">
		<table>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="userid" required>
					<input type="button" name="idCheck" value="중복확인">
					<p id = "checkId"></p>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td> <input type="password" name="userpw" required> </td>
			</tr>
			<tr>
				<td>이름</td>
				<td> <input type="text" name="username" required> </td>
			</tr>
			<tr>
				<td>휴대폰 번호</td>
				<td>
					<input type="hidden" name="phone" value=""/>
					<input type="text" name="phone1" required> -
					<input type="text" name="phone2" required> -
					<input type="text" name="phone3" required>
				</td>
			</tr>
			<tr>
				<td>생일</td>
				<td>
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
		<button type="submit">등록</button>
	</form>
	<button onclick="location.href='/index'">취소</button>
	
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("button[type='submit']").on("click",function(e){
			//연결된 이벤트 제거 (submit전송 제거 )
			e.preventDefault();
			let formObj = $("form.join");
			if($("#checkId").text() == ""){
				alert("아이디 중복확인 해주세요");
				return;
			}
			if($("#checkId").text() == "사용할 수 없는 아이디입니다."){
				alert("중복되지 않는 아이디를 입력해주세요");
				return;
			}
			
			let phone = $("input[name='phone1']").val()+"-"+$("input[name='phone2']").val()+"-"+$("input[name='phone3']").val();
			let birth = $("select[name='birth1']").val()+"-"+$("select[name='birth2']").val()+"-"+$("select[name='birth3']").val();
			$("input[name='phone']").attr('value', phone);
			$("input[name='birth']").attr('value', birth);
			
			formObj.submit();
		})
		
		//아이디 중복확인!!
		$("input[name='idCheck']").on("click",function(){
			let id = $("input[name='userid']").val();
			alert(id);
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
					alert(cnt);
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
    	</div>
    </div>
</div>
	
</body>
</html>