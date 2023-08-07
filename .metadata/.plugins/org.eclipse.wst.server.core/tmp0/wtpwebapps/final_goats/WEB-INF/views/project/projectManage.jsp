<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.gt.s.kos.project.vo.*" %>
<%@ page import="org.apache.log4j.LogManager" %>  
<%@ page import="org.apache.log4j.Logger" %>  
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
   Logger log = LogManager.getLogger(this.getClass());
   log.info("projectManage.jsp");
   
   Date now = new Date();
   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
   String currentDate = dateFormat.format(now);
%>  

<%
   Object obj = request.getAttribute("aList");
      
   List<GtProjectVO> aList = (List<GtProjectVO>)obj;
   
   
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script>
      $(document).ready(function () {
        
        var ss = new moment();
        
        var formatteDate = ss.format('YYYY-MM-DD');
        
        
        var status = "";
        
        <% if(aList != null && !aList.isEmpty()) {
           
           %>

        <%
           for(int i = 0; i < aList.size(); i++) {
           GtProjectVO pvo = aList.get(i);     
      %>       
          
           // 프로젝트 시작일 < 현재날짜 보다 
         
         if(<%=pvo.getGpstartdate()%> <  <%=currentDate%>){
              status = "개발";
                  
              
                 // 프로젝트 시작일 > 현재날짜
           }else if(<%=pvo.getGpstartdate()%> >  <%=currentDate%>){
              
              status = "프로젝트 시작";
              
           }else if(<%=pvo.getGpstartdate()%> <  <%=currentDate%> && <%=pvo.getGpenddate()%> < <%=currentDate%> ){
              
              status = "개발완료";
           }
              
            // end of if   
              
          $("#pmtable").append("<tr><td>"+status+"</td>"
                      + "<td style='text-align:center;'><%= pvo.getGpcontr() %></td>"
                      + "<td style='text-align:center;' class='getgpnum'><%= pvo.getGpnum() %> </td>"
                      + "<td><%= pvo.getGpname() %> </td>"
                      + "<td style='text-align:center;'><%= pvo.getGpticman() %> </td>"
                      + "<td style='text-align:center;'><%= pvo.getGpstartdate() %> </td>"
                      + "<td style='text-align:center;'><%= pvo.getGpenddate() %> </td>"
                      + "</tr>");
           
          
           
      <%        
           }
      }else{
         
         
      } %>    
      
      
      
        
        $(document).on('click','#pinsert',function(){
           location.href = "projectInsertForm.gos";
           
        });
        
        $(document).on('click','.getgpnum',function(){
           var carrypnum = $(this).text();
           
           location.href = "projectInsertForm.gos";
           
        });
        
      }); // end of ready
    </script>
    
   <style>
    
    
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
     
     .styled-button {
        background-color: #585858; /* 배경색 */
        border: none; /* 테두리 없음 */
        color: white; /* 텍스트 색상 */
        padding: 10px 20px; /* 안쪽 여백 */
        text-align: center; /* 텍스트 가운데 정렬 */
        text-decoration: none; /* 텍스트 밑줄 없음 */
        display: inline-block; /* 인라인 블록 요소로 설정 */
        font-size: 16px; /* 폰트 크기 */
        border-radius: 4px; /* 테두리 둥글기 */
        cursor: pointer; /* 마우스 커서가 올라갔을 때 손가락 커서로 변경 */
        font-weight: bold;
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
      <span style="margin-left:50px; font-size:20px; line-height:1; color: #337ab7;"><strong>프로젝트 관리</strong></span>
      <div class="alert" style="background-color: whitesmoke; height: auto">
      </div>
         <span style="color: #337ab7; line-height:1; margin-left:1360px;">HOME</span><span style="line-height:1;">&nbsp;/ 프로젝트 / 프로젝트 관리　</span>
          <table style="margin-left:auto; margin-right:auto; border-top:2px solid #1C1C1C; background-color : white; border-radius: 3px; width:1500px;">
         <tr>
            <th colspan="7" style="text-align:left;"><img src="/resources/goats_icon/project.png" width="15" height="15" style="position: relative; top:2px;">프로젝트 관리</th>
         </tr>
         <tr>
         <td colspan="7">
            <table style="width:100%" class="Va_Table_S" id="pmtable" style="overflow:scroll;">
               <tr style="text-align:left;">
                  <th style="width:10%; text-align:center;">상태</th>
                  <th style="width:10%; text-align:center;">고객명</th>
                  <th style="width:10%; text-align:center;">프로젝트코드</th>
                  <th style="width:15%; text-align:center;">프로젝트명</th>
                  <th style="width:10%; text-align:center;">관리자</th>
                  <th style="width:10%; text-align:center;">시작일자</th>
                  <th style="width:10%; text-align:center;">종료일자</th>
               </tr>
            </table>
      </table>
      <div style="border:3px solid white"></div>
      <input type="button" value="프로젝트 등록" id="pinsert" class="styled-button" style="margin-left:1445px;">
      </div>
      
    </div>
    
  </body>
</html>