<%--
  Created by IntelliJ IDEA.
  User: kim-yina
  Date: 2021/05/08
  Time: 10:46 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp"%>




<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Forms</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">Board Read Page</div>

            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6">

            <%-- hidden값 보내기
                 1. modify작업을 위한  bno
                 2. list로 다시 이동 시) 1페이지가 아니라
                    내가 보고있던 그 페이지로 다시 이동하기 위해 받아왔던 Criteria에 들어가는
                    pageNum ,amount
            --%>
            <form id="operForm" action="/board/modify" method="get">
                <input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
                <input type="hidden" id="pageNum" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                <input type="hidden" id="amount" name="amount" value="<c:out value='${cri.amount}'/>">

                <input type="hidden" id="type" name="type" value="<c:out value='${cri.type}'/>">
                <input type="hidden" id="keyword" name="keyword" value="<c:out value='${cri.keyword}'/>">

            </form>

                <script type="text/javascript" src="/resources/js/reply.js"></script>
                <script type="text/javascript">
                    $(document).ready(function(){
                        console.log("==================");
                        console.log("JS TEST");

                        var bnoValue = '<c:out value="${board.bno}"/>';

                        // [1] replyService Obj에서 add함수 테스트
                        // 이걸쓰면 왜좋은지? get.jsp내부에서는 Ajax 호출은 replyService라는 이름의 js객체에 감춰져있음 -> 필요한 파라미터만 전달하는 형태로 간결해짐
                        replyService.add(
                            {
                                reply:"add로 들어가는댓글"
                                ,replyer:"addadd"
                                ,bno:bnoValue
                            },
                            function(result){
                                alert("RESULT : "+result);
                            }
                        );

                        console.log("글번호 : "+bnoValue);

                        // [2] replyService Obj에서 댓글목록을 출력하는 getList
                        replyService.getList(
                            {bno:bnoValue, page:1}
                            ,function(list){
                                for(var i = 0, len = list.length || 0 ; i<len ; i++){
                                    console.log(list[i]);
                                }
                            }
                        ); //replyService.getList
                            console.log("getList지남  : ");

                        // [3] replyService Obj에서 댓글을 삭제하는 remove
                       /* replyService.remove(
                             18 // rno=18로 테스트
                            ,function(count){
                                console.log(count);
                                if(count=="success"){alert("------REMOVED------")}
                            }
                            ,function(err){
                                alert("------REMOVE ERROR------");
                            }
                        );//replyService.remove
*/

                        //[4] replyService Obj에서 댓글을 수정하는 update
                        replyService.update({
                             rno : 20
                            ,bno : bnoValue
                            ,reply : "replyService의 update로 댓글수정"
                            }
                            ,function(result){alert("update로 댓글수정 완료")}

                        );//replyService.update

                    });
                </script>

                <script type="text/javascript">
                    $(document).ready(function(){
                        var operForm = $("#operForm");
                        console.log("operForm / hidden값 : ...."+operForm);

                        // modify 버튼 누르면 hidden값으로 bno 가지고 ----> submit()
                        $("button[data-oper='modify']").on("click",function(e){
                            operForm.attr("action","/board/modify").submit();
                        });

                        //list버튼 누르면 id="bno" 값 없애고 ----> submit() (list로 이동)
                        $("button[data-oper='list']").on("click",function(e){
                            operForm.find("#bno").remove();
                            operForm.attr("action","/board/list");
                            operForm.submit();
                        });

                    });
                </script>

                        <%-- 번호로 조회 : 반드시 모든 input을 readonly="readonly"로 속성지정 --%>

                        <%-- BNO --%>
                            <div class="form-group">
                                <label>Bno</label>
                                <input class="form-control" name="bno" value="<c:out value='${board.bno}'/>"
                                       readonly="readonly"/>
                            </div>
                        <%-- 제목 --%>
                            <div class="form-group">
                                <label>Title</label>
                                <input class="form-control" name="title" value="<c:out value='${board.title}'/>"
                                       readonly="readonly"/>
                            </div>

                        <%-- 내용 --%>
                            <div class="form-group">
                                <label>Content</label>
                                <textarea class="form-control" rows="3" name="content"
                                readonly="readonly"><c:out value='${board.content}'/>
                                </textarea>
                            </div>

                        <%-- 작성자 --%>
                            <div class="form-group">
                                <label>Writer</label>
                                <input class="form-control" name="writer" value="<c:out value='${board.writer}'/>"
                                       readonly="readonly"/>
                            </div>
<hr>
                        <%-- 버튼 modify : 수정화면으로 이동 --%>
                            <button data-oper='modify'
                                    class="btn btn-default"
                                    onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'"
                            >Modify</button>

                        <%-- 버튼 modify : 수정화면으로 이동 --%>
                            <button data-oper='list'
                                    class="btn btn-info"
                                    onclick="location.href='/board/list'"
                            >List</button>

                    </div>


<%@include file="../includes/footer.jsp"%>
