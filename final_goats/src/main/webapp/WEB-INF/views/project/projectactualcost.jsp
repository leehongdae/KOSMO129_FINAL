<%@page import="com.gt.s.common.CommonUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gt.s.kos.spend.vo.GtSpendVO" %>
<%
   int[] cost_ = (int[])request.getAttribute("cost_");
   DecimalFormat df = new DecimalFormat("###,###");
   List<GtSpendVO> list_ = (List<GtSpendVO>)request.getAttribute("list_");
%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>실비 관리</title>
    <link rel="stylesheet" href="resources/css/projecttactualcost.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="resources/js/common.js"></script>
    <script>
      $(document).ready(function () {
         var d = new Date();
         var s = d.getFullYear().toString() + "-" + numpad((d.getMonth()+1).toString()) + "-" + numpad(d.getDate().toString());
         $("#graph_img").prop({
            "src":"resources/Spendgraph/"+s+".png"
         });
      }); // end of ready
    </script>
    <style>
      
      #rightcon {
        width: 100%;
      }

      #table1, #table2 {
        width: 100%;
        border-collapse: collapse;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      tr td {
        border: 1px solid gray;
      }

      .container2 {
        display: flex;
      }

      .container {
         margin: 0;
        flex-direction: row;
        justify-content: space-between;
        height: 951px;
        width: 100%;
      }
      
      .th_1 {
         border: 1px solid black;
         background-color: gray;
         color: white;
      }
      
      .td_1 {
         font-size:14px;
      }

      
    </style>
  </head>
  <body style="width:100%">
    <div class="container2" style="margin: 0; width:100%;">
      <div>
        <jsp:include page="../main/mainSide-bar.jsp" />
      </div>
      <div style="margin: 0; padding: 0; width:100%;">
        <jsp:include page="../main/Top-bar.jsp"></jsp:include>
        <br>
        <span style="margin-left:50px; font-size:20px; line-height:1; color: #337ab7;"><strong>실비 조회</strong></span>
        <br>
        <span style="color: #337ab7; line-height:1; margin-left:1330px;">HOME</span><span style="line-height:1;">&nbsp;/ 프로젝트 / 실비 조회　</span>
        <div class="container" id="rightcon">
         <table style="border-top:2px solid black; border-left:1px solid #A4A4A4; border-right:1px solid #A4A4A4; width:1400px; margin-left:auto; margin-right:auto;"><tr>
         <th colspan="7" style="text-align:left;">
         <img src="/resources/goats_icon/money.png" width="15" height="15" style="position: relative; top:2px; margin-left:5px;">실비 조회</th>
         </tr></table>
           <div class="out-div" style="border:1px solid #A4A4A4; width:1400px; margin-left:auto; margin-right:auto; height:auto;">
            <div class="sideWrap">
               <div class="top-side" style="margin-top:10px;">
                  <div class="top-inner left-side" style="width:690px; margin-left:auto;">
                  <table id="table1">
                     <tr> 
                        <th class=th_1>구분</th>
                        <th class=th_1>합계</th>
                     </tr>
                     <%
                        for(int i=0; i<cost_.length; i++) {
                           String s = CommonUtils.s[i];
                           String cost = df.format(cost_[i]);
                     %>
                     <tr> <td><%=s %></td> <td class="cost"><%=cost %> 원</td> </tr>
                     <%
                        }
                     %>
                  </table>
               </div>
                  <div class="top-inner right-side" style="margin-right:auto; width:690px;">
                     <img id="graph_img">
                  </div>
               </div>

                  <table id="table2" style="width:1380px; margin-left:auto; margin-right:auto; text-align:center; margin-bottom:10px;">
                     <tr> 
                        <th class=th_1>날짜</th>
                        <th class=th_1>사원</th>
                        <th class=th_1>구분</th>
                        <th class=th_1>거래처</th>
                        <th class=th_1>제목</th>
                        <th class=th_1>적요</th>
                        <th class=th_1>수량</th>
                        <th class=th_1>단가</th>
                        <th class=th_1>금액</th>
                        <th class=th_1>결제방법</th>
                        <th class=th_1>프로젝트</th>
                     </tr>
                     <%
                        for(int i=0; i<list_.size(); i++) {
                          GtSpendVO svo = null;
                          svo = new GtSpendVO();
                          svo = list_.get(i);
                     %>
                     <tr> 
                     <td class=td_1><%=svo.getGsdate() %></td>
                     <td><%=svo.getWriter() %></td>
                     <td><%=svo.getGsgubun() %></td>
                     <td><%=svo.getGsaccount() %></td>
                     <td><%=svo.getGssubject() %></td>
                     <td class=td_1><%=svo.getGsinfo() %></td>
                     <td class="cost" style="text-align:center;"><%=svo.getGscount() %></td>
                     <td class="cost"><%=svo.getGscost() %></td>
                     <td class="cost"><%=svo.getTotalcost() %></td>
                     <td>법인카드</td>
                     <td><%=svo.getGpnum() %></td> 
                     </tr>
                     <%
                        }
                     %>
                  </table>
               </div>
            </div>
           </div>
          </div>
        </div>
  </body>
</html>
