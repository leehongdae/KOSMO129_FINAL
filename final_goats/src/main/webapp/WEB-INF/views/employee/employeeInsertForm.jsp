<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GOATS | 사원정보 등록</title>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
	href="https://webfontworld.github.io/kopus/KoPubWorldDotum.css">
<link rel="stylesheet" href="resources/css/emp.css">

<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$.ajax({
							url : "getGtEmployeeChabun.gos",
							success : function(res) {

								var genum = res;

								$("#genum").val(genum);

							},
							error : function(e) {
								console.log(e.responseText)
							}

						});

						$("#geidbtn").click(function() {
							let idurl = "gtEmployeeIdcheck.gos";
							let idtype = "GET";
							let iddataParam = {
								geid : $("#geid").val(),
							};

							$.ajax({
								url : idurl,
								type : idtype,
								data : iddataParam,
								success : whenSuccess,
								error : whenError

							});

							function whenSuccess(resData) {
								alert(resData);
								if ("ID_YES" == resData) {
									alert("아이디 사용이 가능합니다.");

									$("#geid").attr("readonly", true);
									$("#gepw").focus();

								} else {
									alert("아이디가 이미 사용중입니다.");
									$("#geid").val('');
									$("#geid").focus();
								}

							}

							function whenError(e) {
								alert("e >>> : " + e.responseText)
							}

						});



						$("#gepwbtn").click(
								function() {

									if ($("#gepw").val() != ""
											&& $("#gepw_r").val() != "") {
										if ($("#gepw").val() == $("#gepw_r")
												.val()) {
											alert("비밀번호가 같습니다.");
											$("#gepw_r").val("");
										} else {
											alert("비밀번호가 틀립니다.");
											$("#gepw_r").val("");
											$("#gepw").val("");
											$("#gepw").focus();
										}
									} else {
										alert("비밀번호를 입력해주세요");
									}
								});

						$("#zonecode").click(function() {
							new daum.Postcode({
								oncomplete : function(data) {
									$("#gezone").val(data.zonecode);
									$("#geroad").val(data.roadAddress);
									$("#gejibun").val(data.jibunAddress);
								}
							}).open();

						});

			            $("#btn").click(function(){
			                
			                var gehp1 = $("#gehp1").val();
			                var geemail = $("#geemail0").val() + "@" + $("#geemail1").val();
			                
			                if(gehp1.length == 11){
			                var gehp = gehp1.substr(0,3) + "-" + gehp1.substr(3,4) + "-" + gehp1.substr(7);
			                
			                $("#gehp").val(gehp);
			                $("#geemail").val(geemail);
			                
			                let dataParam = $("#empForm").serialize();

			                $.ajax({
			                     url : "gtEmployeeInsert.gos",
			                     data : dataParam,
			                     success : function(res){
			                        alert(res);
			                      if(res == "OK"){
			                               $("#gefile_form").attr({
			                               "action" : "gtEmployeeFileInsert.gos",
			                               "method" : "POST",
			                               "enctype": "multipart/form-data"
			                               }).submit();
			                            
			                      }else{
			                         alert("입력 실패");
			                      }
			                     },
			                     error : function(e){
			                        console.log(e.responseText);
			                     }
			                  });
			                
			                }else{
			                	alert("전화번호는 11자리 입니다.");
			                }
			             });
			          });
			       </script>
			    </head>

</head>
<body>
	<div class="container2">
		<!--  사이드바 -->
		<div>
		<jsp:include page="../main/mainSide-bar.jsp" />

		<!-- 탑바 -->
		<!-- <div style="margin: 0; padding: 0; width: 100%"> -->
		<jsp:include page="../main/Top-bar.jsp"></jsp:include>

		<form id="empForm">
		<div class="registerWrap">
			<div class="registerTitle">
				<h1>사원 등록</h1>
			</div>
			<!--  -->

			<!--  -->
			<div class="registerInputWrap">
				<div class="inputWrap">
					<p>회원번호</p>
					<input type="text" name="genum" id="genum" readonly>
				</div>
				<div class="inputWrap">
					<p>이름</p>
					<input type="text" name="gename" id="gename" />
				</div>
				<div class="inputWrap">
					<p>부서명</p>
					<select name="gedept" id="gedept">
						<option value="개발1팀">개발1팀</option>
						<option value="개발2팀">개발2팀</option>
						<option value="개발3팀">개발3팀</option>
						<option value="영업팀">영업팀</option>
						<option value="인사팀">안사팀</option>
					</select>
				</div>
				<div class="inputWrap">
					<p>직급</p>
					<select name="title" id="title">
						<option value="사원">사원</option>
						<option value="대리">대리</option>
						<option value="과장">과장</option>
						<option value="차장">차장</option>
					</select>
				</div>
				<div class="inputWrap">
					<p>아이디</p>
				</div>
				<div class="inputWrap">	
					<input type="text" name="geid" id="geid" />
					<input type="button" name="geidbtn" id="geidbtn" value="아이디 중복 확인" class="speacialArea"/>
				</div>
				<div class="inputWrap">
					<p>비밀번호</p>
						<input type="text" name="gepw" id="gepw" >
				</div>
				<div>
				<br>
					<div class="inputWrap">
						<input type="text" name="gepw_r" id="gepw_r" placeholder="비밀번호를 한 번 더 눌러주세요"	>
						<input type="button" name="gepwbtn" id="gepwbtn" value="비밀번호 확인" class="speacialArea"/>
					</div>
				</div>
				<div class="inputWrap gender">
					<p>성별</p>
					<label for="female">남자</label> 
					<input type="radio" name="gegender" id="gegender_m" value="1" checked> 
					<label for="male">여자</label>
					<input type="radio" name="gegender" id="gegender_f" value="2">
				</div>
				<div class="inputWrap">
					<p>생년월일</p>
					<input type="date" name="gebirth" id="gebirth">
				</div>
				<div class="inputWrap">
					<p>연봉</p>
					<input type="text" name="salary" id="salary">
				</div>
				<div class="inputWrap">
					<p>핸드폰 번호</p>
					<input type="hidden" name="gehp" id="gehp">
					<input type="number" name="gehp1" id="gehp1"
						placeholder="010 - 0000 - 0000" >
				</div>
				<div class="inputWrap speacialArea">
					<p>이메일 주소</p>
					<input type="hidden" name="geemail" id="geemail">
					<input type="text" name="geemail0" id="geemail0" style="width: 125px;" />@ 
					<input type="text" name="geemail1" id="geemail1" style="width: 125px;" placeholder="직접입력" />
				</div>
				<div class="inputWrap">
					<p class="zipCode">주소</p>
					<input type="text" name="gezone" id="gezone" placeholder="우편번호" class="speacialArea"/>
					<input type="button" name="zonecode" id="zonecode" value="우편번호 찾기" class="speacialArea"/><br>
				</div>
				<div class="inputWrap">
					<input type="text" name="geroad" id="geroad" placeholder="도로명주소"><br>
				</div>
				<div class="inputWrap">	
					<input type="text" name="geroaddetail" id="geroaddetail" placeholder="도로명상세주소"><br> 
				</div>
				<div class="inputWrap">	
					<input type="text" name="gejibun" id="gejibun" placeholder="지번주소">
				</div>
				</form>
				<form id="gefile_form">
				<div class="inputWrap">
					<p>사진</p>
					<input type="file" name="gephoto" id="gephoto">
				</div>
				<br><br><br>
				</form>
				<div class="registerBtnWrap">
					<button type="button" id="btn">등록하기</button>
				</div>

				<br><br>
			</div>
			</div>
		</div>
		
	</div>
	
</body>
</html>