<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="org.apache.log4j.LogManager" %>  
<%@ page import="org.apache.log4j.Logger" %>  

<%@ page import="com.gt.s.kos.account.vo.GtAccountVO" %>
<%@ page import="com.gt.s.common.CodeUtil" %>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
    
<% request.setCharacterEncoding("UTF-8");%>
<%
   Logger log = LogManager.getLogger(this.getClass());

   int pageSize = 0;
   int groupSize = 0;
   int curPage = 0; // curPage : 현재페이지
   int totalCount = 0;
   
   Object pagingVOObj = request.getAttribute("pagingGVO");
   GtAccountVO pagingGVO = (GtAccountVO)pagingVOObj;
   
   Object obj = request.getAttribute("listA");

   List<GtAccountVO> lista = (List<GtAccountVO>)obj;
   
   int nCnt = lista.size();
   log.info("nCntnCntnCnt : " + nCnt);
   String nCntS = ":::: 전체 조회 건수 " + nCnt + " 건";

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>거래처관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    
       $(document).ready(function(){
          
          $("#addAcc").on("click", function(){
             
              window.open("accountInsertForm.gos", "_blank", "width=571,height=660");             
          });   
       });
    
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
      <span style="margin-left:50px; font-size:20px; line-height:1; color: #337ab7;"><strong>거래처관리</strong></span>
      <div class="alert" style="background-color: whitesmoke; height: auto">
      </div>
         <span style="color: #337ab7; line-height:1; margin-left:1380px;">HOME</span><span style="line-height:1;">&nbsp;/ 프로젝트 / 거래처관리　</span>
          <table style="margin-left:auto; margin-right:auto; border-top:2px solid #1C1C1C; background-color : white; border-radius: 3px; width:1500px;">
         <tr>
            <th colspan="7" style="text-align:left;"><img src="/resources/goats_icon/project_company.png" width="15" height="15" style="position: relative; top:2px;">업체</th>
         </tr>
         <tr>
         <td colspan="7">
            <table style="width:100%">
               <tr style="text-align:left;">
                  <th style="width:15%; text-align:center;">코드</th>
                  <th style="width:15%; text-align:center;">거래처명</th>
                  <th style="width:15%; text-align:center;">사업자번호</th>
                  <th style="width:15%; text-align:center;">업태</th>
                  <th style="width:15%; text-align:center;">종목</th>
                  <th style="width:15%; text-align:center;">전화번호</th>
                  <th style="width:15%; text-align:center;">창립일</th>
               </tr>
               <%
                  if(lista == null){
               %>      
               <tr>
                  <td colspan="7" height="300" style="text-align:center;">조회된 데이터가 없습니다.</td>
               </tr>
               <%   
                  } else {
                     
                        for(int i = 0 ; i < nCnt; i++){
                           GtAccountVO _gvo = lista.get(i);
                           pageSize = Integer.parseInt(pagingGVO.getPageSize());
                           groupSize = Integer.parseInt(pagingGVO.getGroupSize());
                           curPage = Integer.parseInt(pagingGVO.getCurPage());
                           totalCount = Integer.parseInt(_gvo.getTotalCount());
                           
                        %>      <tr         
                                 <% if(i %2 == 1){
                                  %>    style="background-color: white;"
                                 <%} else {
                                  %>    style="background-color: #f0f0f0;"   
                                 <%}
                                  %>   
                              >
                                 <td style="text-align:center;"><%= _gvo.getGanum() %></td>
                                 <td style="text-align:center;"><%= _gvo.getGaname() %></td>
                                 <td style="text-align:center;"><%= _gvo.getGasnum() %></td>
                                 <td style="text-align:center;"><%= _gvo.getGabusinesstype() %></td>
                                 <td style="text-align:center;"><%= _gvo.getGaevent() %></td>
                                 <td style="text-align:center;"><%= _gvo.getGahp() %></td>
                                 <td style="text-align:center;"><%= _gvo.getGafoundation() %></td>
                              </tr>
            
               <%
                           }
                       }
               %>

            </table>
         
            </td>
            </tr>
            <tr>
               <td style="border-right:none;">(총 <%= totalCount %>건)</td>
               <td style="border-left:none;"><jsp:include page="accountPaging.jsp" flush="true">
                  <jsp:param name="url" value="accountSelectAll.gos"/>
                  <jsp:param name="str" value=""/>
                  <jsp:param name="pageSize" value="<%=pageSize%>"/>
                  <jsp:param name="groupSize" value="<%=groupSize%>"/>
                  <jsp:param name="curPage" value="<%=curPage%>"/>
                  <jsp:param name="totalCount" value="<%=totalCount%>"/>
                  </jsp:include>
               </td>
            </tr>
      </table>
      <div style="border:3px solid white"></div>
      <input type="button" value="거래처 추가" id="addAcc" class="styled-button" style="margin-left:1461px;">
      </div>
      
    </div>
    
  </body>
</html>