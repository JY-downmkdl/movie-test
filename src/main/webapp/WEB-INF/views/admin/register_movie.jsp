<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록하기</title>
<link rel="stylesheet" href="/resources/css/bootstrap.css">
    <style>
    	.movinsert .form-control{
    		display:inline;
    		width: 10%;
    	}
    	.movinsert p {
        	padding-left: 10px;
    	}
        .movinsert span{
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
 <div id="contaniner" class="">
        <div id="contents" class="">
            <div class="contentsStart">
                <div class="tit-heading-wrap">
                    <h3>영화 등록하기</h3>
                </div>
            </div>
            <div class="movinsert mx-auto">
	            <form action="/admin/register_movie" method="post" class="mr">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<table>
						<tr>
							<td class="py-3">영화 이름</td>
							<td class="py-3"> <input name="movname"> </td>
						</tr>
						<tr>
							<td class="py-3">감독</td>
							<td class="py-3"> <input name="movdirector"> </td>
						</tr>
						<tr>
							<td class="py-3">장르</td>
							<td class="py-3"> <input name="movgenre"> </td>
						</tr>
						<tr>
							<td class="py-3">등급</td>
							<td class="py-3">
								<select id="movgrade" name="movgrade">
				                   <option selected="" value="0">전체</option>
				                   <option value="7">7세</option>
				                   <option value="12">12세</option>
				                   <option value="15">15세</option>
				                   <option value="19">19세</option>
				               </select>
							</td>
						</tr>
						<tr>
							<td class="py-3">러닝타임</td>
							<td class="py-3"> <input type="text" name="movrunningtime"> 분 </td>
						</tr>
						<tr>
							<td class="py-3">상영일</td>
							<td class="py-3"><input type="date" name="movrelease"></td>
						</tr>
						<tr>
							<td class="py-3">포스터</td>
							<td class="py-3">
								<div class="uploadDiv">
								 	<input type="file" name="movposter">
								</div>
								<div class="uploadResult">
									<ul></ul>
								</div>
							</td>
						</tr>
					</table>
					<div class="buttons">
						<button type="submit" class="btn btn-primary">등록하기</button>
						<button type="button" class="btn btn-secondary" onclick="location.href='/admin/moviechart'">취소</button>
					</div>
				</form>
            </div>
            
        </div>
 </div>

<script type="text/javascript">
	$(document).ready(function(){
		$("button[type='submit']").on("click",function(e){
			//연결된 이벤트 제거 (submit전송 제거 )
			e.preventDefault();
			//폼선택 formObj할당
			let formObj = $("form.mr");
			console.log("submmit클릭")
			let str = "";
			let li = $(".uploadResult ul li");
			str += "<input type='hidden' name='fileName' value='"+li.data("filename")+"'/>";
			str += "<input type='hidden' name='uploadPath' value='"+li.data("path")+"'/>";			
			str += "<input type='hidden' name='fullname' value='"+li.data("fullname")+"'/>";			
			//폼에 데이터 추가 append()메소드 submit()전송하기 
			formObj.append(str).submit();
		})
		
		
		//input태그중 type이 file요소 선택
		//요소의 변경이 있으면 콜백함수실행 
		$("input[type='file']").change(function(){
			//가상의 폼을 생성(폼태그)
			let formData = new FormData();
			let inputFile = $("input[name='movposter']");
			let files = inputFile[0].files;
			console.log(files);
			for(let i=0; i<files.length; i++){
				formData.append("uploadFile", files[i]);
			}
			let csrfHeaderName= "${_csrf.headerName}";
			let csrfTokenValue= "${_csrf.token}";
			$.ajax({
				url: '/uploadAjaxAction',
				processData : false,
				contentType: false,
				data: formData,
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type: 'POST',
				dataType: 'json',
				success : function(result){
					console.log(result);
					showUploadResult(result);
				}
			})
		})
		function showUploadResult(uploadResultArr){
			//결과 배열이 null이거나 길이가 0이면 함수종료 
			if(!uploadResultArr || uploadResultArr.length==0) { return; }
			let uploadul = $(".uploadResult ul");
			let str = "";
			$(uploadResultArr).each(function(i, obj){
				console.log(obj);
				let fileCallpath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				let filePullpath = encodeURIComponent(obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-filename='"+obj.uuid+"_"+obj.fileName+"'"
				+"data-fullname='"+filePullpath+"'>"
				+"<img src='/display?fileName="+fileCallpath+"'/>"
			    +"<button class='btn' data-file=\'"+fileCallpath+"\' data-type='image'>"
				+"삭제</button>"
			    +"</li>"
			})
			uploadul.append(str);
		}
	})
</script>
<%@ include file="../footer.jsp" %>
</body>
</html>