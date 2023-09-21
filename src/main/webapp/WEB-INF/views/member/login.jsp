<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<%@ include file="../header.jsp" %>
<div id="container">
	<div id="contents">
		<div class="contentsStart">
			<div class="tit-heading-wrap">
				<h3>로그인</h3>
			</div>
			<div class=" w-50 m-auto mt-5">
				<p><c:out value="${error}"/></p>
				<p><c:out value="${logout}"/></p>
				<form action="/login" method="post" >
					<div class="form-group mb-2">
					  <div class="form-floating mb-3">
					    <input type="text" name="username" class="form-control" id="floatingInput">
					    <label for="floatingInput">ID</label>
					  </div>
					  <div class="form-floating">
					    <input type="password" name="password" class="form-control" id="floatingPassword" autocomplete="off">
					    <label for="floatingPassword">Password</label>
					  </div>
					</div>
					<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
						아이디 저장하기
					<div class="d-grid gap-2 mt-5">
					  <button class="btn btn-lg btn-primary" type="submit">로그인</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>