<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/header footer.css">
</head>
<body>
<footer>
	<ul class="policy_list">
	    <li><a href="http://corp.cgv.co.kr/company/" target="_blank">회사소개</a></li>
	    <li><a href="http://corp.cgv.co.kr/company/sustainabilityStrategy/strategy.aspx" target="_blank">지속가능경영</a></li>
	    <li><a href="http://corp.cgv.co.kr/company/ir/financial/financial_list.aspx" target="_blank">IR</a></li>
	    <li><a href="http://corp.cgv.co.kr/company/recruit/step/default.aspx" target="_blank">채용정보</a></li>
	    <li><a href="http://corp.cgv.co.kr/company/advertize/ad_Default.aspx" target="_blank">광고/제휴/출점문의</a></li>
	    <li><a href="http://www.cgv.co.kr/rules/service.aspx">이용약관</a></li>
	    <li><a href="http://www.cgv.co.kr/rules/organized.aspx">편성기준</a></li>
	    <li><a href="http://www.cgv.co.kr/rules/privacy.aspx"><strong>개인정보처리방침</strong></a></li>
	    <li><a href="http://www.cgv.co.kr/rules/disclaimer.aspx">법적고지</a></li>
	    <li><a href="http://www.cgv.co.kr/rules/emreject.aspx">이메일주소무단수집거부</a></li>
	    <li><a href="http://corp.cgv.co.kr/company/ethicalManagement/ceoMessage.aspx" target="_blank">윤리경영</a></li>
	    <li><a href="/company/cyberAudit.aspx" class="empha-red">사이버감사실</a></li>
	</ul>
	<article class="company_info_wrap">
	    <section class="company_info">
	        <address>(04377)서울특별시 용산구 한강대로 23길 55, 아이파크몰 6층(한강로동)</address>
	        <dl class="company_info_list">
	            <dt>대표이사</dt>
	            <dd>허민회</dd>
	            <dt>사업자등록번호</dt>
	            <dd>104-81-45690</dd>
	            <dt>통신판매업신고번호</dt>
	            <dd>2017-서울용산-0662 <a href="#none" onclick="goFtc()" class="btn_goFtc">사업자정보확인</a><a></a></dd>
	        </dl>
	        <dl class="company_info_list">
	            <dt>호스팅사업자</dt>
	            <dd>CJ올리브네트웍스</dd>
	            <dt>개인정보보호 책임자</dt>
	            <dd>도형구</dd>
	            <dt>대표이메일</dt>
	            <dd>cjcgvmaster@cj.net</dd>
	            
	        </dl>
	        <p class="copyright">© CJ CGV. All Rights Reserved</p>
	    </section>
	    <section class="familysite_wrap">
	        <label for="familysite">CJ그룹 계열사 바로가기</label>
	        <select id="familysite">
	            <option value="" class="familysiteTitle">계열사 바로가기</option>
	            <optgroup label="CJ그룹">
					<option value="http://www.cj.net/">CJ주식회사</option>
				</optgroup>
				<optgroup label="식품 &amp; 식품서비스">
				<option value="https://www.cj.co.kr/kr/index">CJ제일제당</option>
				<option value="https://www.cjfoodville.co.kr/main.asp">CJ푸드빌</option>
				<option value="http://www.cjfreshway.com/index.jsp">CJ프레시웨이</option>
				</optgroup>
				<optgroup label="생명공학">
					<option value="https://www.cj.co.kr/kr/about/business/bio">CJ제일제당 BIO사업부문</option>
					<option value="https://www.cj.co.kr/kr/about/business/bio">CJ Feed&amp;Card</option>
				</optgroup>
				<optgroup label="물류 &amp; 신유통">
					<option value="https://www.cjlogistics.com/ko/main">CJ대한통운</option>
					<option value="http://www.cjenc.co.kr/kr/Default.asp">CJ대한통운 건설부문</option>
					<option value="https://www.oliveyoung.co.kr/store/company/brandStory.do">CJ올리브영</option>
					<option value="https://www.cjolivenetworks.co.kr:449/">CJ올리브네트웍스</option>
					<option value="https://www.cjoshopping.com:9002/index.asp">CJ ENM 커머스부문</option>
				</optgroup>
				<optgroup label="엔터테인먼트 &amp; 미디어">
					<option value="https://www.cjenm.com/ko/">CJ ENM 엔터테인먼트부문</option>
					<option value="http://corp.cgv.co.kr/">CJ CGV</option>
				</optgroup>
	        </select>
	        <a href="#none" class="btn_familysite" onclick="goFamilySite()">GO</a>
	    </section>
	</article>
<script>
    //footer GA Analytics 영역 LOG
    $('.policy_list > li > a').on({
        click: function (e) {
            gaEventLog('PC_footer', this.text, '');
        }
    });
</script>
        <!-- footer_area (e) -->

        <div class="adFloat2" style="display:none">

            <iframe src="//ad.cgv.co.kr/NetInsight/html/CGV/CGV_201401/sub@Popicon" width="154" height="182" frameborder="0" scrolling="no" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" allowtransparency="true" id="ad_float1" title="광고-셰이프 오브 워터 사랑의 모양 " style="display: none;"></iframe>
        </div>
        <script type="text/javascript">            OpenAD();</script>
        <!-- //Float Ad -->
	</footer>
</body>
</html>