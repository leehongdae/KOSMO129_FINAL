<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import='com.gt.s.kos.draft.vo.GtDraftVO' %>
<%@ page import= "java.util.Arrays" %>
<%@ page import= "java.util.List" %>
<%@ page import= "com.gt.s.kos.approvalline.vo.GtApprovalLineVO" %>
<%@ page import= "com.gt.s.common.CodeUtil" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <% request.setCharacterEncoding("UTF-8");%>
   <% 
   		List<GtApprovalLineVO> list = (List<GtApprovalLineVO>)request.getAttribute("list");
   		String apryn = (String)request.getAttribute("apryn");
   %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    
		$(document).ready(function(){
            $(".appselect").hover(function(){
            	$(this).find(".appsel").addClass("selec");
              }, function(){
            	  $(".appselect").find(".appsel").removeClass("selec");
              });
            
            $(document).on("click", ".delbtn", function(){
            	var tdText = $(".selec").parent().find('td:first input').val();
            	$("#appnum").val(tdText);
            	$("#deleteform").attr({
            		"action":"gtDelete.gos",
            		"method":"POST"
            	}).submit();
            });
			
            $(document).on("click", ".selec",function() {
            	  var tdText = $(this).parent().find('td:first input').val();
            	  var url = "";
  					if(tdText.substring(0,2) == 'BU') {
  						url = "gtBusinessSelect.gos?appnum="+tdText;
  					}
  					if(tdText.substring(0,2) == 'VA') {
  						url = "gtVacationSelect.gos?appnum="+tdText;     		  
  					}
  					if(tdText.substring(0,2) == 'SP') {
  						url = "gtSpendSelect.gos?appnum="+tdText;
  					}
  					if(tdText.substring(0,2) == 'DR') {
  						url = "gtDraftSelect.gos?appnum="+tdText;
  					}
  					if(tdText.substring(0,2) == 'CO') {
  						url = "gtContractSelect.gos?appnum="+tdText;
  					}
  					if(tdText.substring(0,2) == 'RE') {
  						url = "gtResignationSelect.gos?appnum="+tdText;
  					}
           	        var windowFeatures = 'width=1033,height=600,left=100,top=200,resizable=no';
           	        window.open(url, '_blank', windowFeatures);
            	});
            $(document).on("click", "#searchbtn", function(){
            	$("#search_form").attr({
            		"action":"document_napp.gos",
            		"method":"GET",
            		"enctype":"application/x-www-form-urlencoded"
            	}).submit();
            });
		});
    </script>
    <style>
	    .selec {
		background: #e2e2e2;
		}
        html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      body {
        display: flex;
        flex-direction: column;
      }
      body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
      }
      .con {
        flex: 1;
     }

      .container2 {
        display: flex;
        height: 100px;
        width: 100%;
      }

      
      .container {
       display: flex; /* Flexbox를 적용하여 요소들을 가로로 배치합니다 */
       flex-direction: row; /* 요소들을 가로 방향으로 배치합니다 */
       justify-content: space-between; /* 각 요소를 좌우로 최대한 벌립니다 */
       height: 430.43; 
     }

      .container > div {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        
      }

      .container h3 {
        margin: 0;
        padding: 10px 0;
        font-size: 18px;
        font-weight: bold;
      }

      .calendar {
        height: 200px;
      }

      .alert table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 10px;
      }

      .alert th,
      .alert td {
        padding: 10px;
        text-align: left;
      }

      .alert th {
        background-color: #f0f0f0;
      }

      .work {
        height: 300px;
      }
      
      #maindiv{
         width:100%;
         height:100%;
      }
      
      table {
         border:1px solid black;
         margin:50px auto;
      }

      .custom-button {
         background-color: #337ab7;
         color: white;
         border: none;
         padding: 13px 22px;
         text-align: center;
         text-decoration: none;
         display: inline-block;
         font-size: 13px;
         margin: 4px 2px;
         cursor: pointer;
      }
  
     td {
         border-top: none;
         border-bottom: none;
         border-left: none;
         border-right: none;
         text-align:center;

      }
      
      th{
      	text-ailgn:center;
      }
      
      input[type="date"] {
        width: 203px;
        height: 38px;

     }
      
      .input-box {
        position: relative;
     }
   
     .faint-input {
        border-color:#f2f2f2;
        padding: 10px;
        opacity: 0.6;
     }
   
     .faint-input::placeholder {
        opacity: 0.6;
        color: #000;
     }
     .table_div{
     	height:500px;
     	overflow: auto;
}

     
    </style>
  </head>
  <body>
    <div class="container2" style="margin: 0; height:100%;">
      <div style="height:100%; max-height:970px;">
         <jsp:include page="../main/mainSide-bar.jsp" />
      </div>
         <div style="margin: 0; padding: 0; width:100%;">
             <jsp:include page="../main/Top-bar.jsp"></jsp:include>
        <br>
         　<img src="resources/goats_icon/home.png" alt="home" width="20" height="20"><b><span style="color: #2E2E2E;"> Home > 전자결재 > </span></b><span style="color: #337ab7;"><b>반려함</b></span>

        <div class="alert" style="background-color: whitesmoke; height: auto">
        </div>
        
        <div class="input-box">
  
	<form id="search_form" >
				<table
					style="width: 1570px; height: 20px; background-color: white; padding: 13px; margin: 20px;">
					<tr>
						<td><input type="text" class="faint-input" placeholder="문서번호"
							style="width: 12%;" name="appnum" id="s_appnum"> <input type="text"
							class="faint-input" placeholder="문서제목"
							style="margin-left: 5px; width: 26%;" name="subject" id="subject"> <input type="text"
							class="faint-input" placeholder="작성자"
							style="margin-left: 5px; width: 26%;" name="s_writer" id="s_writer"> <input type="text"
							class="faint-input" placeholder="양식명"
							style="margin-left: 5px; width: 26%;" name="formname" id="formname"></td>
					</tr>
					<tr>
						<td><input type="date" name="appstartdate" id="appstartdate">
						<input type="date" style="margin-left: 10px;" name="appenddate" id="appenddate">
							<input type="button" value="검색" class="custom-button" style="margin-left: 10px;" id="searchbtn">
					</tr>
				</table>
				</form>
      </div>
      <br>
      <div style="font-size:14px; width:1592px;">
         　<span style="color: #337ab7;"><b><%= list.size() %>개</b></span><span style="color: #2E2E2E;"><b>의 문서가 검색되었습니다.</b></span>
      </div>
      <div class="table_div">
      <table style="width:1570px; height:20px; background-color: white; padding:10px; margin:20px; border-left:none; border-right:none; border-top:3px solid gray; text-align:left; padding:0px;">
         <tr>
         <td style="border-left:none;"><input type="checkbox"></td>
         <td>문서번호</td>
         <td>양식명</td>
         <td>제목</td>
         <td>상태</td>
         <td>작성자</td>
         <td>부서</td>
         <td>제출일</td>
         </tr>
         <%
            
            if(list.size() == 0){
           
         %>   
         <tr>
         <td style="border-top:2px solid #A4A4A4; text-align:center" colspan="8" height="200px;">조회된 데이터가 없습니다.</td>
         </tr>
         
         <%
            } else {
            	
            	for(int i=0; i<list.size(); i++) {
            	GtApprovalLineVO avo = list.get(i);
         %>
         	<tr class="appselect" style="border:1px solid #2e2e2e">
         		<td class="appsel"><input type="checkbox" id="checkbox" name="checkbox" class="checkbox" value="<%=avo.getAppnum()%>"></td>
	         	<td class="appsel"><%= avo.getAppnum()%></td> 
	         	<td class="appsel"><%=CodeUtil.formname(avo.getAppnum()) %></td>
	         	<td class="appsel"><%= avo.getSubject() %> </td>
	         	<td class="appsel">반려</td>
	         	<td class="appsel"><%= avo.getWriter().split(" ")[1] %> </td>
	         	<td class="appsel"><%= avo.getWriter().split(" ")[0] %> </td>
	         	<td class="appsel"><%= avo.getDate() %></td>
	         	<td ><input type="button" class="delbtn" value="삭제"></td>
         	</tr>
         	
         <%
            	}
            }
         %>
         
      </table>
      </div>
      <form id="deleteform" accept-charset="utf-8">
      <input type="hidden" id="appnum" name="appnum">
      </form>
      </div>
    </div>
  </body>
</html>