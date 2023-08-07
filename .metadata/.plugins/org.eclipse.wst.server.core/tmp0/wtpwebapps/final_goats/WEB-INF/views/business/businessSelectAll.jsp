<%@page import="com.gt.s.kos.business.vo.GtBusinessVO"%>
<%@page import="com.gt.s.kos.project.vo.GtProjectVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>

<%
   Object obj = request.getAttribute("aListBU");
   List<GtBusinessVO> aList = (List<GtBusinessVO>) obj;
   Object obj1 = request.getAttribute("_buvo");
   GtBusinessVO _buvo = (GtBusinessVO)obj1;
	Object obj2 = request.getAttribute("aListPRB");
	List<GtProjectVO> aListPR = (List<GtProjectVO>) obj2;
  
%>

<html>
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Insert title here</title>
        <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
      <script type="text/javascript">
      
         $(document).ready(function(){
   
            var keyword = "";
            var searchfilter = "";
            
            keyword = "<%= _buvo.getKeyword()%>";
            searchfilter = "<%= _buvo.getSearchfilter()%>";
      
            
            if(searchfilter == null || searchfilter == "" || searchfilter == "null"){
               $("#searchfilter").val("-").prop("selected",true);
      
            }else{
               $("#searchfilter").val("<%= _buvo.getSearchfilter()%>").prop("selected",true);
               
            }
            
            if(keyword == null || keyword == "" || keyword == "null"){
               $("#keyword").val("")
      
            }else{
               $("#keyword").val("<%=_buvo.getKeyword()%>")
            }
               
            $(document).on('click', '#search_btn', function(){
               
               $("#business_selectall").attr({
                  "action":"gtBusinessSelectAll.gos",
                  "method":"GET"
               }).submit();
               
            });
               
         });

      </script>
        <style type="text/css">     
            
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
       border-collapse: collapse; /* 테이블 셀 경계를 병합합니다. */
     }
   
     tr {
       border: 1px solid #A4A4A4; /* 행에 경계선을 추가합니다. */
     }
   
     th, td {
       padding: 8px; /* 셀 내부 여백을 설정합니다. */
       border: 1px solid #A4A4A4;
     }
     
     .Va_Table_S tr:nth-child(even) {
         background-color: #f0f0f0;
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
      <span style="margin-left:50px; font-size:20px; line-height:1; color: #337ab7;"><strong>출장 전체 조회</strong></span>
      <div class="alert" style="background-color: whitesmoke; height: auto">
      </div>
         <span style="color: #337ab7; line-height:1; margin-left:1377px;">HOME</span><span style="line-height:1;">&nbsp;/ 출장 전체 조회</span>
          <table style="margin-left:auto; margin-right:auto; border-top:2px solid #1C1C1C; background-color : white; border-radius: 3px; width:1400px;">
         <tr>
            <th colspan="7" style="text-align:left;"><img src="/resources/goats_icon/working_from_home.png" width="15" height="15" style="position: relative; top:2px;">출장 전체 조회</th>
         </tr>
         <tr>
         <td colspan="7">
            <table style="width:100%" class=Va_Table_S>
               <tr style="text-align:left;">
                  <th style="width:5%; text-align:center;">순서</th>
                  <th style="width:15%; text-align:center;">작성자</th>
                  <th style="width:15%; text-align:center;">프로젝트명</th>
                  <th style="width:15%; text-align:center;">출장명</th>
                  <th style="width:15%; text-align:center;">시작일시</th>
                  <th style="width:15%; text-align:center;">종료일시</th>
               </tr>
                         <% for (int i = 0; i < aList.size(); i++){

                  %>
                   <tr>
                      <td style="text-align:center;"><%= i + 1 %></td>
                  <td><%=aList.get(i).getWriter()%></td>
                  <td><%=aListPR.get(i).getGpname()%></td>
                  <td><%=aList.get(i).getGbtname()%></td>
                  <td style="text-align:center;"><%=aList.get(i).getGbtstart()%></td>
                  <td style="text-align:center;"><%=aList.get(i).getGbtend() %></td>
               </tr>
               <%} %>
                </table>
                </table>
            </div>
            <div class="content paging">
            </div>                
        </div>

    </body>
</html>


