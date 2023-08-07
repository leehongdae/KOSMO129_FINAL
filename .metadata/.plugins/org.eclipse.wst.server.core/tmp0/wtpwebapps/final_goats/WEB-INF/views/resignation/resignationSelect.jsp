

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="com.gt.s.common.chabun.service.GtChabunServiceImpl"%>
<%@page import="com.gt.s.common.DateFormatUtil"%>
<%@page import="com.gt.s.common.ChabunUtil"%>
<%@page import="com.gt.s.common.chabun.dao.GtChabunDAOImpl"%>
<%@page import="com.gt.s.common.chabun.dao.GtChabunDAO"%>
<%@page import="com.gt.s.common.chabun.service.GtChabunService"%>
<%@page import="com.gt.s.kos.resignation.vo.GtResignationVO"%>
<%@ page import="com.gt.s.common.CodeUtil"%>
<%
	GtResignationVO rvo = (GtResignationVO)request.getAttribute("rvo");
	String app = rvo.getApprover();
	String count = rvo.getCount();
	String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
%>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert title here</title>
	<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
	<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<script type="text/javascript">
		
	$(document).ready(function() {
			var app = '<%=rvo.getApprover()%>';
			var dept = '<%=rvo.getDept()%>';
			var pro = '<%=rvo.getProval()%>';
			var appcount = '<%=rvo.getCount()%>';
			var writer = '<%=rvo.getWriter()%>';
			var s = '<%=s%>';
			var app_ = app.split("/");
			var dept_ = dept.split("/");

			var info = '<%=rvo.getGrmemo()%>';
			var info_ = info.split(",");
			$('#memo').html(info);
			
			
			var writer01 = writer.split(" ");
			$('#name').text(writer01[1]);
			$('#dept').text(writer01[2]);
			
			
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
			var num = '<%= rvo.getGrnum()%>';
			$.ajax({
				url:"refileDownloadlist.gos",
				type:"GET",
				data:{"grnum":num},
				success:whens
			});
			
			function whens(d) {
				var filename = d.split(",");
				for(var i=0; i<filename.length-1; i++) {
					$("#table3").find("tr:eq(0)").find("td:eq(0)").append("<a href='fileDownloadref?file="+filename[i]+"&num="+num+"' target='_blank'>"+filename[i]+"</a><br>");
					
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
	<div id="approval" style="width:1033px;">
		<jsp:include page="../approvalline/select.jsp" />
	</div>
	 <form id="form01" name="form01">
		<div class="button-container">
			<button type="button" id="line12">결재선지정</button>
			<button type="button" id="btnSend">상신</button>
			<button type="button" id="btnCancle" onclick="javascript:btnCancle()">취소</button>
		</div>
		<div align="center">
			<span class="sp"><strong>사 직 서</strong></span>
		</div>
		<br>
		<table class="table1">
			<tr>
				<th width="120px">문서번호</th>
				<td width="230px" id="grnum"><%= rvo.getGrnum() %></td>
				<th width="120px">보안구분</th>
				<td width="230px">비공개</td>
				<th width="120px">보존연한</th>
				<td width="230px">5년</td>
			</tr>
			<tr>
				<th width="100px">작성자</th>
				<td width="230px" id="writer"><%= rvo.getWriter() %></td>
				<th width="100px">작성일자</th>
				<td colspan="3" id="currentDate"><%= rvo.getInsertdate() %></td>
			</tr>
		</table>
		<br>
		<table id="table1">
			<tr>
				<th width="50px">순서</th>
				<th width="80px">구분</th>
				<th width="170px">결재자</th>
				<th width="170px">부서</th>
				<th width="80px">상태</th>
				<th width="100px">결재일</th>
				<th width="350px">결재의견</th>
			</tr>
			<tr>
				<td align="center">1</td>
				<td id="snag1"></td>
				<td id="hu1" class="approver"></td>
				<td id="dept1" class="dept"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td id="snag2"></td>
				<td id="hu2" class="approver"></td>
				<td id="dept2" class="dept"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="center">3</td>
				<td id="snag3"></td>
				<td id="hu3" class="approver"></td>
				<td id="dept3" class="dept"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="center">4</td>
				<td id="snag4"></td>
				<td id="hu4" class="approver"></td>
				<td id="dept4" class="dept"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td align="center">5</td>
				<td id="snag5"></td>
				<td id="hu5" class="approver"></td>
				<td id="dept5" class="dept"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<br>
		<table id="cham1">
			<tr>
           	<% if(rvo.getReference() == null) {
           		rvo.setReference(" ");
            } %>
				<th width="133px">참 조</th>
				<td id="cham"><%= rvo.getReference() %></td>
			</tr>
		</table>
		<br>
		<table class="tab t04">
			<tr>
				<th width="120px">제 목</th>
				<td><%= rvo.getGrsubject() %></td>
			</tr>
		</table>
		<br>
		<table class="tab t05">
			
			<tr>
				<th width="120px">직 급</th>
				<td id="dept"></td>
			</tr>
			<tr>
				<th width="120px">성 명</th>
				<td id="name"></td>
			</tr>
			<tr>
				<th width="120px">입 사 일</th>
				<td><%= rvo.getGrstartdate() %></td>
			</tr>
			<tr>
				<th width="120px" >퇴 사 일</th>
				<td><%= rvo.getGrenddate() %></td>
			</tr>
		</table>
		
		<br>
		<table class="tab t06">
			<th>비고</th>
			<tr>
				<td id="memo"  style="text-align:left"></td>
			</tr>
			
		</table>
		<br>

	</form>
	<form id="form02" name="form02">
		<table  class="table3" id="table3">
			<tr>
				<th width="120px">첨부파일</th>
				<td></td>
			</tr>
		</table>
		<br>
	</form>
	
	</body>
</html>
