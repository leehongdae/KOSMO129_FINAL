<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="com.gt.s.common.chabun.service.GtChabunServiceImpl"%>
<%@ page import="com.gt.s.common.DateFormatUtil"%>
<%@ page import="com.gt.s.common.ChabunUtil"%>
<%@ page import="com.gt.s.common.chabun.dao.GtChabunDAOImpl"%>
<%@ page import="com.gt.s.common.chabun.dao.GtChabunDAO"%>
<%@ page import="com.gt.s.common.chabun.service.GtChabunService"%>
<%@ page import="com.gt.s.kos.resignation.vo.GtResignationVO"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사직서</title>
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">   
   // ready() 시작
   $(document).ready(function() {

      //실행시 채번 가져오기
      $.ajax({
         url : "gtResignationChanbun.gos",
         success: function(res) {               
            console.log(">>> res : " + res);
            
            $('#grnum1').text(res);
            $('#grnum').val(res);
         },
         error: function(e) {
            console.log(e.reponseText);
         }
      }); // 채번 화면에 표시
      
      // btnSend 클릭시
      $(document).on('click', '#btnSend', function() {            
         // 결재선
         var hu1 = $("#hu1").text()
         var hu2 = $("#hu2").text()
         var hu3 = $("#hu3").text()
         var hu4 = $("#hu4").text()
         var hu5 = $("#hu5").text()
         
         $("#hu1_1").val(hu1);
         $("#hu2_1").val(hu2);
         $("#hu3_1").val(hu3);
         $("#hu4_1").val(hu4);
         $("#hu5_1").val(hu5);
         
         var dep1 = $("#dep1").text()
         var dep2 = $("#dep2").text()
         var dep3 = $("#dep3").text()
         var dep4 = $("#dep4").text()
         var dep5 = $("#dep5").text()
         
         $("#dept1_1").val(dep1);
         $("#dept2_1").val(dep2);
         $("#dept3_1").val(dep3);
         $("#dept4_1").val(dep4);
         $("#dept5_1").val(dep5);
         
         // input 히든에 벨류 값 보냄
         var cc = $("#reference01").text();            
         
         $("#reference").val(cc);
         alert(">>> reference :" + $("#reference").val());
         
         
         // editor 데이터 세팅
         var ql = $('.ql-editor').html();   
         var qui = $("#grmemo").val(ql);
         
         // 데이터 세팅
         let dataParam = $("#form01").serialize();  
         // 텍스트 먼저 전송
         $.ajax({
            url: 'resignationInsert.gos',
            type: 'GET',
            data: dataParam,
            success: function(res) {
               console.log(">>> Success !!!" + res);
               
               if(res == 'YES') {                     
                  $('#form02').attr({
                     'action':'gtResignationInsertFile.gos',
                     'method':'POST',
                     'encType':'multipart/form-data'
                  }).submit();                     
               }else {
                  alert(">>> grfile Insert Fail");
               }
            },
            error: function(e) {
               alert(e.responseText);
            }
         });            
      }); // end of btnSend.click()
      
      // 결재선지정 버튼
      $(document).on("click", "#btnapro", function() {
         
         $("#approval").css({
            "visibility" : "visible"
         });
         
         $("#hide_div").hide();
      });
      
      // 취소 버튼
      $("#btnCancle").click(function(){
         window.close();
      });
      
      // 작성일자 자동입력
      document.getElementById('currentDate').innerText = new Date().toISOString().slice(0,10);
      
   }); // end of ready()
      
   </script>

   <style type="text/css">
   .button-container {
      text-align: right;
      width:1000px;
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
   <div id="approval" >
      <jsp:include page="../approvalline/select.jsp"></jsp:include>
   </div>
   <c:set var="writer01" value="${writer}"></c:set>
   <div id="hide_div" class="hide_div">
      <form id="form01" name="form01">
         <div class="button-container">
            <button type="button" id="btnapro">결재선지정</button>
            <button type="button" id="btnSend">상신</button>
            <button type="button" id="btnCancle">취소</button>
         </div>
         <div align="center">
            <span class="sp"><strong>사 직 서</strong></span>
         </div>
         <br>
         <table>
            <tr>
               <th width="120px">문서번호</th>
               <td width="230px" id="grnum1"></td>
               <th width="120px">보안구분</th>
               <td width="230px">비공개</td>
               <th width="120px">보존연한</th>
               <td width="230px">5년</td>
            </tr>
            <tr>
               <th width="100px">작성자</th>
               <td width="230px" id="writer01">${fn:replace(writer01, '/', ' ')}</td>
               <th width="100px">작성일자</th>
               <td colspan="3" id="currentDate"></td>
            </tr>
         </table>
         <br>
         <table class="table1" id="table1">
            <tr>
               <th width="20px">순서</th>
               <th width="80px">구분</th>
               <th width="17px">결재자</th>
               <th width="17px">부서</th>
               <th width="8px">상태</th>
               <th width="10px">결재일</th>
               <th width="35px">결재의견</th>
            </tr>
            <tr align="center">
               <td>1</td>
               <td id="snag1"></td>
               <td id="hu1"></td>
               <td id="dep1"></td>
               <td></td>
               <td></td>
               <td></td>
            </tr>
            <tr align="center">
               <td>2</td>
               <td id="snag2"></td>
               <td id="hu2"></td>
               <td id="dep2"></td>
               <td></td>
               <td></td>
               <td></td>
            </tr>
            <tr align="center">
               <td>3</td>
               <td id="snag3"></td>
               <td id="hu3"></td>
               <td id="dep3"></td>
               <td></td>
               <td></td>
               <td></td>
            </tr>
            <tr align="center">
               <td>4</td>
               <td id="snag4"></td>
               <td id="hu4"></td>
               <td id="dep4"></td>
               <td></td>
               <td></td>
               <td></td>
            </tr>
            <tr align="center">
               <td>5</td>
               <td id="snag5"></td>
               <td id="hu5"></td>
               <td id="dep5"></td>
               <td></td>
               <td></td>
               <td></td>
            </tr>
         </table>
         <br>
         <table id="cham1" class="cham1">
            <tr>
               <th width="120px">참 조</th>
               <td id="reference01"></td>
            </tr>
         </table>
         <br>
         <table class="tab t04">
            <tr>
               <th width="120px">제 목</th>
               <td><input type="text" name="grsubject" id="grsubject"
                  style="width: 820px"></td>
            </tr>
         </table>
         <br>
         <table class="tab t05">         
            
            <tr>
               <th width="120px">직 급</th>
               <td>${fn:split(writer01,'/')[0]}</td>
            </tr>
            <tr>
               <th width="120px">성 명</th>
               <td>${fn:split(writer01,'/')[1]}</td>
            </tr>
            <tr>
               <th width="120px">입 사 일</th>
               <td><input type="date" name="grstartdate"></td>
            </tr>
            <tr>
               <th width="120px">최종근무일</th>
               <td><input type="date" name="grenddate"></td>
            </tr>
         </table>
   
   
         <table class="tab t06">
            <th>비고</th>
            <br>
         </table>
   
         <div id="editor" class="initial-size"></div>
         <script>
            var quill = new Quill('#editor', {
            // Quill 설정 옵션
            });
      
            // 작성 영역 클릭 시 이벤트 처리
            var editorContainer = document.querySelector('#editor');
               editorContainer.addEventListener('click', function() {
                  quill.focus(); // 작성 영역으로 포커스 이동
            });
      
            var toolbarOptions = [  [ 'bold', 'italic', 'underline', 'strike' ],
                              [ 'link', 'image' ], 
                              [ {'list' : 'ordered'}, {'list' : 'bullet'} ],
                              [ {'header' : [ 1, 2 ]} ] 
                            ];
      
            var quill = new Quill('#editor', {
               modules : {toolbar : toolbarOptions},theme : 'snow'
               });
      
            function myFunction() {
               alert("gd");
            }
         </script>
   
         <br>
      
         <!-- 가공값 세팅 -->      
         <input type="hidden" name="grnum"    id="grnum">
         <input type="hidden" name="grmemo"   id="grmemo" >
         <!-- session에서 받아올 값 -->
         <input type="hidden" name="genum"      id="genum"  value="${genum}"> 
         <input type="hidden" name="writer"     id="writer" value="${fn:replace(writer01, '/', ' ')}">
         <!-- 결재선 지정 받을 곳 -->
         <input type="hidden" name="proval"   id="proval"    >
         <input type="hidden" name="reference"id="reference" >
         
         <input type="hidden" name="approver"id="hu1_1"     >
         <input type="hidden" name="approver"id="hu2_1"     >
         <input type="hidden" name="approver"id="hu3_1"     >
         <input type="hidden" name="approver"id="hu4_1"     >
         <input type="hidden" name="approver"id="hu5_1"     >
         <input type="hidden" name="dept"    id="dept1_1"     >
         <input type="hidden" name="dept"    id="dept2_1"     >
         <input type="hidden" name="dept"    id="dept3_1"     >
         <input type="hidden" name="dept"    id="dept4_1"     >
         <input type="hidden" name="dept"    id="dept5_1"     >
      </form>
      
      <!-- 파일업로드  -->
      <form id="form02" name="form02">
         <table class="tab t07">
            <tr>
               <th width="120px">첨부파일</th>
               <td><input type="file" name="grfile" id="grfile" size="100%"></td>
            </tr>
         </table>
         <br>
      </form>
   </div>
</body>
</html>