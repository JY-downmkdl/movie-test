<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp" %>
<div id="container">
	<div id="contents">
		<div class="contentsStart">
			<h2>로그인</h2>
			<p><c:out value="${error}"/></p>
			<p><c:out value="${logout}"/></p>
			<form action="/login" method="post">
				<p><input type="text" name="username" /></p>
				<p><input type="password" name="password" /></p>
				<p><input type="checkbox" name="remember-me">아이디 저장하기</p>
				<p><input type="submit" value="로그인" /></p>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>