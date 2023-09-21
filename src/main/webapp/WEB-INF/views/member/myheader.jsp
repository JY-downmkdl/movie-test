<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<input type="hidden" name="userid" value="﻿<sec:authentication property='principal.username'/>" />
<script type="text/javascript">
	$(document).ready(function(){
		let userid = $("input[name=userid]").val().trimStart();
		$("input[name=userid]").val(userid);
		
		$(".person-info strong").html(userid + " 님");
	})
</script>
    <!--마이 페이지 시작-->
    <div id="contaniner" class="">
        <div id="contents" class="">
            <div class="mycgv-info-wrap contentsStart">
                <div class="sect-person-info">
                    <div class="box-image">
                        <span class="thumb-image">
                            <img src="/resources/img/myPage/default_profile.gif" alt="하지영님 프로필 사진">
                            <span class="profile-mask"></span>
                        </span>
                    </div>
			     	<div class="box-contents newtype">
			     		<div class="person-info">
			     			<strong>님</strong>
			     			<em><sec:authentication property="principal.username"/></em>
			     			<a href='/member/myinfo?userid=<sec:authentication property="principal.username"/>'>나의 정보 변경<i></i></a>
			     		</div>
	                    <div class="sect-my-info">
		                       <div class="col-my-ticket"><a href='/member/reserve?userid=<sec:authentication property='principal.username'/>'>
	                           		<h3>예매내역 확인</h3>
	                        	</a></div>
		                       <div class="col-my-board"><a href='/member/myqna'>
		                           <h3>나의 문의내역</h3>
		                       </a></div>
	                    </div>
			     	</div>
		    	</div>
       		</div>

		       
