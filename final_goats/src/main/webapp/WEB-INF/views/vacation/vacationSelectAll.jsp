<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="org.apache.log4j.LogManager" %>  
<%@ page import="org.apache.log4j.Logger" %>

<%@ page import='com.gt.s.kos.draft.vo.GtDraftVO'%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="com.gt.s.kos.account.vo.GtAccountVO" %>
<%@ page import="com.gt.s.common.CodeUtil" %>

<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Vacation SelectAll</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
      <span style="margin-left:50px; font-size:20px; line-height:1; color: #337ab7;"><strong>전체 휴가 현황</strong></span>
      <div class="alert" style="background-color: whitesmoke; height: auto">
      </div>
         <span style="color: #337ab7; line-height:1; margin-left:1384px;">HOME</span><span style="line-height:1;">&nbsp;/ 휴가 / 전체 휴가 현황</span>
          <table style="margin-left:auto; margin-right:auto; border-top:2px solid #1C1C1C; background-color : white; border-radius: 3px; width:1500px;">
         <tr>
            <th colspan="7" style="text-align:left;"><img src="/resources/goats_icon/vacation.png" width="15" height="15" style="position: relative; top:2px;">전체 휴가 현황</th>
         </tr>
         <tr>
         <td colspan="7">
            <table style="width:100%" class=Va_Table_S>
               <tr style="text-align:left;">
                  <th style="width:5%; text-align:center;">순번</th>
                  <th style="width:10%; text-align:center;">연도</th>
                  <th style="width:10%; text-align:center;">소속</th>
                  <th style="width:15%; text-align:center;">사번</th>
                  <th style="width:10%; text-align:center;">이름</th>
                  <th style="width:10%; text-align:center;">적치일수</th>
                  <th style="width:10%; text-align:center;">사용일수</th>
                  <th style="width:10%; text-align:center;">잔여일수</th>
                  <th style="width:10%; text-align:center;">사용율</th>
               </tr>

                  <c:if test="${fn:length(aList) > 0}">
                     <c:forEach var="item" items="${aList}" varStatus="status">
                     <fmt:parseNumber var="days" type="number" value="${item.gvdays}"/>
                        <tr>
                           <td style="text-align:center;">${status.count}</td>
                           <td style="text-align:center;">${item.insertdate}</td>
                           <td style="text-align:center;">${fn:split(item.writer, ' ')[0]}</td>
                           <td>${item.genum}</td>
                           <td style="text-align:center;">${fn:split(item.writer, ' ')[1]}</td>
                           <td style="text-align:center;">15.00</td>
                           <td style="text-align:center;"><fmt:formatNumber value="${days}" pattern="0.00"/></td>
                           <td style="text-align:center;"><fmt:formatNumber value="${15-days}" pattern="0.00"/></td>
                           <td style="text-align:center;"><fmt:formatNumber value="${days/15*100}" pattern="0.00"/>%</td>
                        </tr>
                        <c:set var="nCnt" value="${nCnt+1}"/>
                     </c:forEach>
                  </c:if>

               </table>
               </table>
            </div>
         </div>
</body>
</html>