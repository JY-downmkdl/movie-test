<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<%@ include file="./myheader.jsp" %>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<input type="hidden" name="userid" value="﻿<sec:authentication property='principal.username'/>" />
<script type="text/javascript">
	$(document).ready(function(){
		let userid = $("input[name=userid]").val().trimStart();
		$("input[name=userid]").val(userid);
		
		$(".snb ul li:first-child a").attr("href", "/member/mypage?userid="+userid);
	})
</script>
		       
	      <div class="cols-content" id="menu">
	       	<div class="col-aside">
	               <div class="snb">
	                   <ul>
	                       <li>
	                           <a href='/member/mypage'>MY CGV HOME <i></i></a>
	                       </li>
	                       <li>
	                           <a href='/member/reserve?userid=<sec:authentication property="principal.username"/>' title="현재 선택">나의 예매내역</a>
	                       </li>
	                       <li>
	                           <a href="/member/myinfo">회원정보<i></i></a>
	                           <ul>
	                                <li>
	                                   <a href="/member/myinfo">개인정보 변경</a>
	                               </li>
	                               <li>
	                                   <a href="#">회원탈퇴</a>
	                               </li>
	                           </ul>
	                       </li>
	                       
	                       <li class="on">
	                           <a href="#">나의 문의내역 <i></i></a>
	                           <ul>
	                               <li class="on">
	                                   <a href="#">1:1 문의</a>
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
	           
				<!-- cols - detail -->
                <div class="col-detail myqna" id="mycgv_contents">
                    <form name="aspnetForm" method="post" action="./list.aspx?g=1" id="aspnetForm" novalidate="novalidate">
                        <div>
                            <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMjAyMTIyMTg0MmRku2RkFAvCkD19J2zWnHfTY+qaCQ0=">
                        </div>
                        <div>
                            <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="D1AE53DC">
                        </div>
                        <div class="tit-mycgv">
                            <h3>나의 문의내역</h3>
                        </div>
                        <div class="tit-mycgv">
                            <h4>1:1 문의</h4>
                        </div>
                        <div class="set-btn" style="display: flex; justify-content: flex-start; margin-bottom: 10px;">
                            <p>
                                <label for="searchtext"><strong>문의조회</strong></label> <input type="text" id="searchtext" name="searchtext" class="medium" value="" title="검색 키워드 입력">
                                <button type="button" id="btnSearch" class="round inblack"><span>검색하기</span></button>
                            </p>
                            <p class="del">
                                 
                                총 <strong class="txt-red">0</strong>건 
                                <button type="submit" id="btnDelete" class="round black"><span>선택삭제</span></button>
                            </p>
                        </div>
                        <div class="tbl-data">
                            <table summary="문의내역 및 답변내역에 대한 정보 제공">
                                <caption>나의 1:1 문의내역</caption>
                                <colgroup>
                                    <col width="9%">
                                    <col width="15%">
                                    <col width="5%">
                                    <col width="*">
                                    <col width="11%">
                                    <col width="10%">
                                    <col width="11%">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox" id="chkAllItem" name="chkAllItem"><label for="chkAllItem">번호</label></th>
                                        <th scope="col">문의CGV</th>
                                        <th scope="col">유형</th>
                                        <th scope="col">제목</th>
                                        <th scope="col">등록일</th>
                                        <th scope="col">상태</th>
                                        <th scope="col">만족도</th>
                                    </tr>
                                </thead>
                                <tbody id="items">
                                    <tr>
                                        <td colspan="7" class="nodata">
                                            
                                            고객님의 상담 내역이 존재하지 않습니다.
                                            
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!--?xml version="1.0" encoding="utf-8"?-->
                        <div class="paging">
                        </div>
                    
                        <div class="sect-mycgv-reserve qna">
                            <div class="box-polaroid">
                                <div class="box-inner qna">
                                    <p><strong>자주하시는 질문</strong> <a href="/support/faq/default.aspx" class="round gray on"><span>바로가기</span></a></p>
                                    <span>고객님들께서 주로 하시는 질문에 대한 답변을<br>한곳에 모아두었습니다.</span>
                                </div>
                                <div class="box-inner words">
                                    <p><strong>고객의 말씀</strong> <a href="/support/qna/default.aspx" class="round gray on"><span>문의하기</span></a></p>
                                    <span>불편사항과 문의사항을 남겨주시면 친절히<br>답변드리겠습니다.</span>
                                </div>
                            </div>
                        </div>
                    </form>
                    <script type="text/javascript">
                    //<![CDATA[
                    
                        (function ($) {
                            $(function () {
                    
                                //$('#chkAllItem').checkboxGroup({
                                //    parent: function () { return $('#items'); },
                                //    selector: 'input[name=chkItem]'
                                //});
                    
                                $('#searchtext').on('keypress', function (e) {
                                    if (e.keyCode == 13) {
                                        Search();
                                        return false;
                                    }
                                });
                    
                                $('#btnSearch').on('click', function () {
                                    Search();
                                });
                    
                                $('#btnDelete').on('click', function () {
                                    if ($("input[name=chkItem]:checked").length < 1) {
                                        alert("삭제할 문의건을 먼저 선택해 주세요.");
                                        return false;
                                    }
                    
                                    if (!confirm("선택하신 문의건을 삭제하시겠습니까?"))
                                        return false;
                    
                                    $('form').submit();
                                });
                    
                                function Search() {
                                    location.href = "./list.aspx?searchtext=" + escape($("#searchtext").val());
                                }
                            });
                        })(jQuery);
                        //]]>
                        </script>
                </div>
	                    
                    
            </div> <!-- cols contensts 끝 -->

		</div> <!-- #contents 끝-->
	</div> <!-- contaniner 끝 -->
<%@ include file="../footer.jsp" %>
</body>
</html>