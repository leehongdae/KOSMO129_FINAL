<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GOAT.S</title>
<link rel="stylesheet"
	href="https://webfontworld.github.io/kopus/KoPubWorldDotum.css">
<link rel="stylesheet" href="resources/css/mainSide-bar.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
                
      $(document).ready(function(){
         
    	  $(document).on("click", "#noti_click_", function(){
    		  var gename = $("#gename").text();
    		  var url="http://192.168.0.35:5000/session/"+gename;
    		  window.open(url, "_blank", "width=780,height=650");
    	  });
    	  
         $("#1").hover(function(){
             $("#project").css({"visibility":"visible","position":"static"});
           }, function(){
             $("#project").css({"visibility":"hidden","position":"fixed"});
           });
         
        $("#2").hover(function(){
          $("#appdiv").css({"visibility":"visible","position":"static"});
        }, function(){
          $("#appdiv").css({"visibility":"hidden","position":"fixed"});
        });
        

        
        $(".myLink").on("click", function() {
            window.location.href = "mainpage_draft2.gos";
          });
      
          
        $.ajax({
           url:"logincheck.gos",
           async:false,
           success:gename,
        });

       function gename(d){
          if(d != "loginx"){
             $("#gename").text(d);
             if(d == "admin") {
            	 $(".side_img").append("<li class='toggle-event'><a class='top-menu'><img src='resources/goats_icon/admin.png'><span class='arrow'>관리자</span></a>"
											+"<ul class='toggle-menu'>"
											+	"<li><a href='gtAdminSelectAll.gos'><img"
											+			"src='resources/goats_icon/hyphen.png'><span>사원 정보 수정</span></a></li>"
											+	"<li><a href='employeeInsertForm.gos'><img"
											+			"src='resources/goats_icon/hyphen.png'><span>회원가입"
											+				"</span></a></li>"
											+"</ul></li>");
             }
          }else{
             location.href="loginx.gos"
          }
          
       }
       
       $(document).on("click", ".nav-logo", function(){
    	   location.href="mainpage.gos";
       });

	  	$(document).on("click", ".nav-profile", function(){
		location.href="gtMypageSelect.gos";
		});
       
       $.ajax({
          url:"gtsidebarcheck.gos",
          async:false,
          success:appcheck
       });

      function appcheck(d) {
         if(d == "OK") {
            $(".app").css({"color":"red"});
         }
      }
       
      });



       $(function(){

         $(".toggle-event").click(function(){
            $(this).find(".toggle-menu").toggleClass("active");
            $(this).find(".arrow").toggleClass("active-arrow");
            $(this).find(".top-menu").toggleClass("top-menu-active");
          })
      })
    </script>

<style>
body {
	font-family: 'KoPubWorldDotum';
}
</style>


</head>
<body id="body">
	<!-- 사이드바 -->
	<nav class="navWrap">
		<!-- 사이드바 로고  -->
		<div class="nav-logo">
			<img src="resources/goats_icon/logo.png" />
		</div>
		<!-- 사이드바 로고  -->

		<!-- 사이드바 프로필-->
		<div class="nav-profile">
			<img src="resources/goats_icon/my.png"> <span id="gename"></span>님
			반갑습니다.
		</div>
		<!-- 사이드바 프로필-->

		<!-- 사이드바 메뉴 리스트 -->
		<div class="nav-menuWrap">
			<ul>
				<div class="side_img">
					<li><a class="top-menu" href="mainpage.gos"><img
							src="resources/goats_icon/home.png"><span>Home</span></a></li>

					<li><a class="top-menu" href="gtBusinessSelectAll.gos"><img
							src="resources/goats_icon/bisiness.png"><span>출장</span></a></li>

					<li class="toggle-event"><a class="top-menu"><img
							src="resources/goats_icon/vacation.png"><span class="arrow">휴가</span>
					</a>
						<ul class="toggle-menu">
							<li><a href="gtVacationSelect_.gos"><img
									src="resources/goats_icon/hyphen.png"><span>휴가 현황</span></a></li>
							<li><a href="gtVacationSelectAll.gos"><img
									src="resources/goats_icon/hyphen.png"><span>전체 휴가
										현황</span></a></li>
						</ul></li>

					<li class="toggle-event"><a class="top-menu"><img
							src="resources/goats_icon/project.png"><span class="arrow">프로젝트</span></a>
						<ul class="toggle-menu">
							<li><a href="ProjectSelectAll.gos"><img
									src="resources/goats_icon/hyphen.png"><span>프로젝트
										관리</span></a></li>
							<li><a href="projectactualcost.gos"><img
									src="resources/goats_icon/hyphen.png"><span>실비 관리</span></a></li>
							<li><a href="accountSelectAll.gos"><img
									src="resources/goats_icon/hyphen.png"><span>거래처 관리</span></a></li>
						</ul></li>

					<li><a class="top-menu" href="#" id="noti_click_"><img
							src="resources/goats_icon/board.png"><span>공지사항</span></a></li>

					<li class="toggle-event">
						<!-- <a class="top-menu" onclick="location.href='document.gos';"><img src="resources/goats_icon/write.png"><span class="arrow">전자결재</span></a> -->
						<a class="top-menu"><img src="resources/goats_icon/EDSM.png"><span
							class="arrow app">전자결재</span></a>
						<ul class="toggle-menu">
							<li><a href="document.gos"><img
									src="resources/goats_icon/hyphen.png"><span>문서함</span></a></li>
							<li><a href="document_approve.gos"><img
									src="resources/goats_icon/hyphen.png"><span>결재함</span></a></li>
							<li><a href="document_prog.gos"><img
									src="resources/goats_icon/hyphen.png"><span>진행함</span></a></li>
							<li><a href="document_ref.gos"><img
									src="resources/goats_icon/hyphen.png"><span>참조함</span></a></li>
							<li><a href="document_com.gos"><img
									src="resources/goats_icon/hyphen.png"><span>기안함</span></a></li>
							<li><a href="document_napp.gos"><img
									src="resources/goats_icon/hyphen.png"><span>반려함</span></a></li>
						</ul>
					</li>

					<li><a class="top-menu" href="gtOrganizationSelectAll.gos"><img
							src="resources/goats_icon/project_contractor.png"><span>조직도</span></a>
					</li>
			</ul>

		</div>
		<div class="weather3" id="weather3">
			<jsp:include page="../weather/weather.jsp"></jsp:include>
		</div>
		<!-- 사이드바 메뉴 리스트 -->

	</nav>
	<!-- 사이드바 -->

	<!-- 각 페이지마다 사용할 content 영역 -->
	<div id="content"></div>
	<!-- 각 페이지마다 사용할 content 영역 -->

</body>
</html>