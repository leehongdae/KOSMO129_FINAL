<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.gt.s.common.DateFormatUtil"%>
<%@ page import="com.gt.s.kos.spend.vo.GtSpendVO"%>
<%@ page import="com.gt.s.common.CodeUtil"%>
<%
	GtSpendVO svo = (GtSpendVO)request.getAttribute("svo");
	String app = svo.getApprover();
	String count = svo.getCount();
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
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="resources/js/common.js"></script>
<script type="text/javascript">
			$(document).ready(function(){
				
				// -------------------------------------------------------------------------------------------------------------------결재 관련~~
				var app = '<%=svo.getApprover()%>';
				var dept = '<%=svo.getDept()%>';
				var pro = '<%=svo.getProval()%>';
				var gu = '<%=svo.getGsgubun()%>';
				var acc = '<%=svo.getGsaccount()%>';
				var info = '<%=svo.getGsinfo()%>';
				var count = '<%=svo.getGscount()%>';
				var cost = '<%=svo.getGscost()%>';
				var date = '<%=svo.getGsdate()%>';
				var appcount = '<%=svo.getCount()%>';
				var s = '<%=s%>';
				var app_ = app.split("/");
				var dept_ = dept.split("/");
				var gu_ = gu.split(",");
				var acc_ = acc.split(",");
				var info_ = info.split(",");
				var count_ = count.split(",");
				var cost_ = cost.split(",");
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
				
				// ----------------------------------------------------------------------------------------------------------------------------
				
				}
				for(var i=0; i<gu_.length; i++) {
					if(gu_[i] != "-선택-") {
						$("#table2").find("tr:eq("+(i+1)+")").find("td:eq(0)").text(gu_[i]);
						$("#table2").find("tr:eq("+(i+1)+")").find("td:eq(1)").text(acc_[i]);
						$("#table2").find("tr:eq("+(i+1)+")").find("td:eq(2)").text(info_[i]);
						$("#table2").find("tr:eq("+(i+1)+")").find("td:eq(3)").text(count_[i]);
						$("#table2").find("tr:eq("+(i+1)+")").find("td:eq(4)").text(comma(cost_[i]));
						$("#table2").find("tr:eq("+(i+1)+")").find("td:eq(6)").text('법인카드');
						var sumcost = Number($("#table2").find("tr:eq("+(i+1)+")").find("td:eq(3)").text()) *
								Number(comma_replace($("#table2").find("tr:eq("+(i+1)+")").find("td:eq(4)").text()));
						$("#table2").find("tr:eq("+(i+1)+")").find("td:eq(5)").text(comma(sumcost) + " 원");
					}
				}
				var tcost = Number(comma_replace($("#table2").find("tr:eq(1)").find("td:eq(5)").text().replace(" ", "").replace("원", ""))) +
							Number(comma_replace($("#table2").find("tr:eq(2)").find("td:eq(5)").text().replace(" ", "").replace("원", ""))) +
							Number(comma_replace($("#table2").find("tr:eq(3)").find("td:eq(5)").text().replace(" ", "").replace("원", ""))) +
							Number(comma_replace($("#table2").find("tr:eq(4)").find("td:eq(5)").text().replace(" ", "").replace("원", ""))) +
							Number(comma_replace($("#table2").find("tr:eq(5)").find("td:eq(5)").text().replace(" ", "").replace("원", "")));
				$("#tcost").text(comma(tcost.toString()) + " 원");
					if($("#tcost").text() == 0) {
						$("tcost").text("");
					}
				var num = '<%=svo.getGsnum() %>';

				$.ajax({
					url:"fileDownloadlist.gos",
					type:"GET",
					data:{"gsnum":num},
					success:whens
				});
				
				function whens(d) {
					var filename = d.split(",");
					for(var i=0; i<filename.length-1; i++) {
						$("#table3").find("tr:eq(0)").find("td:eq(0)").append("<a href='fileDownload?file="+filename[i]+"&num="+num+"' target='_blank'>"+filename[i]+"</a><br>");
						
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
</style>

</head>
<body>
	<h2 align="center">지출결의서</h2>
	<br>
	<table>
		<tr>
			<th width="120px">문서번호</th>
			<td width="230px" id="gsnum1"><%=svo.getGsnum()%></td>
			<th width="120px">보안구분</th>
			<td width="230px">비공개</td>
			<th width="120px">보존연한</th>
			<td width="230px">5년</td>
		</tr>
		<tr>
			<th width="100px">작성자</th>
			<td width="230px" id="gsname1"><%=svo.getWriter()%></td>
			<th width="100px">작성일자</th>
			<td colspan="3" id="date"><%=svo.getInsertdate()%></td>
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
           	<% if(svo.getReference() == null) {
           		svo.setReference(" ");
            } %>
			<th width="133px">참 조</th>
			<td id="cham"><%=svo.getReference()%></td>
		</tr>
	</table>
	<br>
	<table>
		<tr>
			<th width="133px">제 목</th>
			<td><%=svo.getGssubject()%></td>
		</tr>
	</table>
	<br>
	<table>
		<tr>
			<th width="15%">프로젝트</th>
			<td>
				<div align="center">
					<%=svo.getGpnum()%>
				</div>
			</td>
		</tr>
	</table>
	<br>
	<table>
		<tr>
			<th width="15%">시행일자</th>
			<td style="align: left;"><input type="date" name="gsdate"
				id="gsdate" value="<%=svo.getGsdate()%>"></td>
		</tr>
	</table>
	<br>
	<table id="table2" style="height:300px;">
		<tr>
			<th width="120px">구분</th>
			<th width="120px">거래처</th>
			<th width="300px">적요</th>
			<th width="10px">수량</th>
			<th width="20px">단가</th>
			<th width="100px">금액</th>
			<th width="130px">결제방법</th>
		</tr>

		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<!-- 거래처 -->
			<td align="center"></td>
			<!-- 적요 -->
			<td align="center"></td>
			<!-- 수량 -->
			<td align="center"></td>
			<!-- 단가 -->
			<td align="center" class="stcost"></td>
			<!-- 금액 -->
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<!-- 거래처 -->
			<td align="center"></td>
			<!-- 적요 -->
			<td align="center"></td>
			<!-- 수량 -->
			<td align="center"></td>
			<!-- 단가 -->
			<td align="center" class="stcost"></td>
			<!-- 금액 -->
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<!-- 거래처 -->
			<td align="center"></td>
			<!-- 적요 -->
			<td align="center"></td>
			<!-- 수량 -->
			<td align="center"></td>
			<!-- 단가 -->
			<td align="center" class="stcost"></td>
			<!-- 금액 -->
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<!-- 거래처 -->
			<td align="center"></td>
			<!-- 적요 -->
			<td align="center"></td>
			<!-- 수량 -->
			<td align="center"></td>
			<!-- 단가 -->
			<td align="center" class="stcost"></td>
			<!-- 금액 -->
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<!-- 거래처 -->
			<td align="center"></td>
			<!-- 적요 -->
			<td align="center"></td>
			<!-- 수량 -->
			<td align="center"></td>
			<!-- 단가 -->
			<td align="center" class="stcost"></td>
			<!-- 금액 -->
			<td align="center"></td>
		</tr>
		<tr>
			<td colspan="3"
				style='text-align: center; background-color: #f2f2f2; font-weight: bold;'
				width="475px">합 계</td>
			<td colspan="3" style='text-align: center;' width="475px" id="tcost"></td>
			<th width="50px"></th>
		</tr>
	</table>
	<br>
	<table id="table3">
		<tr>
			<th width="120px">첨부파일</th>
			<td></td>
		</tr>
	</table>
	<br>
</body>
</html>