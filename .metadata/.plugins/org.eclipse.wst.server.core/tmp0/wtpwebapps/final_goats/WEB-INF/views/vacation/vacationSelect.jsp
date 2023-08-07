<%@page import="java.util.List"%>
<%@ page import="com.gt.s.kos.vacation.vo.GtVacationVO"%>
<%@page import="com.gt.s.common.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   GtVacationVO vvo = (GtVacationVO)request.getAttribute("vvo");
   String app = vvo.getApprover();
   String count = vvo.getCount();
   String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
   rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

<script type="text/javascript">
            $(document).ready(function(){
               var app = '<%=vvo.getApprover()%>';
               var dept = '<%=vvo.getDept()%>';
               var pro = '<%=vvo.getProval()%>';
               var appcount = '<%=vvo.getCount()%>';
               var s = '<%=s%>';
               var app_ = app.split("/");
               var dept_ = dept.split("/");
				if(pro != 'null') {
					var pro_ = pro.split("/");
				}else {
					var pro_ = "";
				}
				console.log("s > : " + s);
				if(appcount < 0) {
					var nappcount = Number(appcount) + 10;
					for(var i=0; i<app_.length; i++) {
						if(app_[i] != "-"){
							if(app_[i] != "-"){
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(1)").text("결재");
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(2)").text(app_[i]);
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(3)").text(dept_[i]);
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(5)").text(pro_[i]);
								if($("#table1").find("tr:eq("+(i+1)+")").find("td:eq(5)").text() != "") {
									$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(4)").text("결재완료");
								}
							}
							if(nappcount == i) {
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(1)").text("결재");
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(2)").text(app_[i]);
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(3)").text(dept_[i]);
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(5)").text(pro_[i]);
								if($("#table1").find("tr:eq("+(i+1)+")").find("td:eq(5)").text() != "") {
									$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(4)").text("반려");
								}
							}

						}
					}
				}else {
					if(s != '') {
						for(var i=0; i<app_.length; i++) {
							if(app_[i] != "-"){
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(1)").text("결재");
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(2)").text(app_[i]);
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(3)").text(dept_[i]);
								$("#table1").find("tr:eq("+(appcount-9)+")").find("td:eq(5)").text(pro_[0]);
								if($("#table1").find("tr:eq("+(i+1)+")").find("td:eq(5)").text() != "") {
									$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(4)").text("전결");
								}
							}
						}
					}else {
						for(var i=0; i<app_.length; i++) {
							if(app_[i] != "-"){
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(1)").text("결재");
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(2)").text(app_[i]);
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(3)").text(dept_[i]);
								$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(5)").text(pro_[i]);
								if($("#table1").find("tr:eq("+(i+1)+")").find("td:eq(5)").text() != "") {
									$("#table1").find("tr:eq("+(i+1)+")").find("td:eq(4)").text("결재완료");
								}
							}
						}
					}
				}
				
            
               var num = '<%=vvo.getGvnum() %>';

            $.ajax({
               url : "gvfileDownloadlist.gos",
               type : "GET",
               data : {
                  "gvnum" : num
               },
               success : whens
            });

            function whens(d) {
               var filename = d.split(",");
               for (var i = 0; i < filename.length - 1; i++) {
                  $("#table3").find("tr:eq(0)").find("td:eq(0)").append(
                        "<a href='gvfileDownload?file=" + filename[i]
                              + "&num=" + num + "' target='_blank'>"
                              + filename[i] + "</a><br>");

               }
            }
         });
</script>

   <style type="text/css">
      .button-container {
         text-align: right;
      }
      
      .initial-size {
         min-height: 200px;
      }
      
      th {
         background-color: #f2f2f2;
      }
      
      table {
         border-collapse: collapse;
         width: 1000px;
      }
      
      th, td {
         border: 1px solid black;
         padding: 8px;
      }
      
      #date {
         text-align: center;
      }
      
      #approval {
         visibility: hidden;
         position: absolute;
         background-color: #fff;
         width: 100%;
         height: 100%;
         margin: auto;
      }
   </style>
</head>
<body>
   <div id="approval">
      <jsp:include page="../approvalline/select.jsp"></jsp:include>
   </div>
   <form name="form01" id="form01">
      <div>
         <h2 align="center">휴가 신청서</h2>
      </div>
      <br>
      <table id="gv_form">


         <tr align="center">
            <th width="120px">문서번호</th>
            <td width="230px"><%=vvo.getGvnum()%></td>
            <th width="120px">보안구분</th>
            <td width="230px">비공개</td>
            <th width="120px">보존연한</th>
            <td width="230px">5년</td>
         </tr>
         <tr align="center">
            <th width="100px">작성자</th>
            <td width="230px%"><%=vvo.getWriter()%></td>
            <th width="100px">작성일자</th>
            <td width="230px"><%=vvo.getInsertdate()%></td>
            <th width="120px">대결자</th>
            <td width="230px"><%=vvo.getDecianother()%></td>
            <!-- 작성일자 -->
         </tr>
      </table>
      <br>
      <table id="table1">
         <tr>
            <th width="19px">순서</th>
            <th width="83px">구분</th>
            <th width="14px">결재자</th>
            <th width="14px">부서</th>
            <th width="14px">상태</th>
            <th width="14px">결재일</th>
            <th width="14px">결재의견</th>
         </tr>
         <tr align="center">
            <td>1</td>
            <td id="snag1"></td>
            <td id="hu1" class="approver"></td>
            <td id="dep1" class="dept"></td>
            <td></td>
            <td></td>
            <td></td>
         </tr>
         <tr align="center">
            <td>2</td>
            <td id="snag2"></td>
            <td id="hu2"  class="approver"></td>
            <td id="dep2" class="dept"></td>
            <td></td>
            <td></td>
            <td></td>
         </tr>
         <tr align="center">
            <td>3</td>
            <td id="snag3"></td>
            <td id="hu3"  class="approver"></td>
            <td id="dep3" class="dept"></td>
            <td></td>
            <td></td>
            <td></td>
         </tr>
         <tr align="center">
            <td>4</td>
            <td id="snag4"></td>
            <td id="hu4" class="approver"></td>
            <td id="dep4" class="dept"></td>
            <td></td>
            <td></td>
            <td></td>
         </tr>
         <tr align="center">
            <td>5</td>
            <td id="snag5"></td>
            <td id="hu5" class="approver"></td>
            <td id="dep5" class="dept"></td>
            <td></td>
            <td></td>
            <td></td>
         </tr>
      </table>
      <br>
      <table id="cham1">
         <tr>
          	<% if(vvo.getReference() == null) {
          		vvo.setReference(" ");
            } %>
            <th width="120px">참 조</th>
            <td id="reference"><%=vvo.getReference()%></td>
         </tr>
      </table>
      <br>
      <table>
         <tr align="left">
            <th width="120px" style="text-align: center;">제 목</th>
            <td><%=vvo.getGvsubject()%></td>
         </tr>
      </table>
      <br>
      <table>
         <tr align="left">
            <th width="120px" style="text-align: center;">일 시</th>
            <td width="346px" colspan="3"><%=vvo.getGvstartdate()%> ~ <%=vvo.getGvenddate()%></td>
         </tr>
         <tr>
            <th width="120px">기 간</th>
            <td width="700px" id="gvdays1"><%=vvo.getGvdays()%></td>
            <th width="100px">구 분</th>
            <td align="center"><%=vvo.getGvtype()%></td>
         </tr>
      </table>
      <table>
         <br>
         <tr>
            <th width="120px">사 유</th>
            <td colspan="3"><%=vvo.getGvreasons()%></td>

         </tr>
         <tr>
            <th width="120px">연 락 처</th>
            <td id="gehp1"><%=vvo.getGehp()%></td>
         </tr>
         <br>
      </table>
      <table>
         <th width="120px">비고</th>
         <br>
         <tr>
            <td><%=vvo.getGvmemo()%></td>
         </tr>
      </table>
   </form>
   <br>
   <form id="gvfile_form">
      <table id="table3"> 
         <tr>
            <th width="120px">첨부파일</th>
            <td></td>
         </tr>
      </table>
   </form>
   <br>
</body>
</html>