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

<%--  모달창  --%>
                <!-- Modal -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
                            </div>
                    <%--모달바디--%>
                            <div class="modal-body">

                                <div class="form-group">
                                    <label>Reply</label>
                                    <input class="form-control" name="reply" value="New Reply!!">
                                </div>

                                <div class="form-group">
                                    <label>Replyer</label>
                                    <input class="form-control" name="replyer" value="replyer">
                                </div>

                                <div class="form-group">
                                    <label>Reply</label>
                                    <input class="form-control" name="replyDate" value="">
                                </div>
                            </div>
                    <%--모달바디:e--%>
                            <div class="modal-footer">
                                <%-- 댓글 수정 Btn --%>
                                <button id="modalModBtn" type="button" class="btn btn-warning">댓글수정</button>

                                <%-- 댓글 삭제 Btn --%>
                                <button id="modalRemoveBtn" type="button" class="btn btn-danger">댓글삭제</button>

                                <%-- 댓글 추가 Btn --%>
                                <button id="modalRegisterBtn" type="button" class="btn btn-default" data-dismiss="modal">댓글등록</button>

                                <%-- 댓글 모달닫기 Btn --%>
                                <button id="modalCloseBtn" type="button" class="btn tbn-warning" data-dismiss="modal">Close</button>

                                <%-- 댓글 ?? Btn --%>
                                <button id="modalClassBtn" type="button" class="btn tbn-warning" data-dismiss="modal">Close</button>

                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->

<%--  모달창 :e  --%>


                <script type="text/javascript" src="/resources/js/reply.js"></script>
                <script type="text/javascript">
                    $(document).ready(function(){
                        console.log("==================");
                        console.log("JS TEST");

                        var bnoValue = '<c:out value="${board.bno}"/>';

                        /*************************************** 댓글 보여주기
                         * 브라우저에서 DOM처리가 끝나면 자동으로 showList()가 호출되면서
                         * <ul>태그 내에 내용으로 처리된다. 만일 1페이지가 아닌 경우, 기존의 <ul>에 <li>들이 추가되는 형태
                         *
                         *   [+] 모달 관련 객체들은 여러 함수에서 사용할 것 ------> 바깥쪽으로 빼두어 매번 jQuery를 호출하지 않도록 한다.
                         * */
                        var replyUL = $(".chat");
                        showList(1);
                        function showList(page){    // showList : 페이지번호를 받아서 리스트 보여줌
                            replyService.getList(
                                {bno:bnoValue, page:page||1}    // 파라미터 없는 경우 페이지번호 1로 설정
                                ,function (list) {
                                    var str = "";
                                    if(list == null || list.length == 0){
                                        replyUL.html("");
                                        return;
                                    }

                                    for(var i=0, len = list.length || 0; i<len; i++){
                                        str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
                                        str += "<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
                                        str += "<small class='pull-right text-muted'>"+list[i].replyDate+"</small></div>";
                                        str += "<p>"+list[i].reply+"<p></div></li>";
                                    }//for

                                    replyUL.html(str);
                            });//getList
                        }//showList

                        /* 1. 새로운댓글 추가 */
                        var modal = $(".modal");

                        var modalInputReply = modal.find("input[name='reply']");
                        var modalInputReplyer = modal.find("input[name='replyer']");
                        var modalInputReplyDate = modal.find("input[name='replyDate']");

                        var modalModBtn = $("#modalModBtn");
                        var modalRemoveBtn = $("#modalRemoveBtn");
                        var modalRegisterBtn = $("#modalRegisterBtn");

                        $("#addReplyBtn").on("click",function(e){

                            modal.find("input").val("");
                            modalInputReplyDate.closest("div").hide();
                            modal.find("button[id != 'modalCloseBtn']").hide();

                            modalRegisterBtn.show();

                            $(".modal").modal("show");

                            modalRegisterBtn.on("click",function (e){

                                // reply Obj
                                var reply = {
                                     reply : modalInputReply.val()
                                    ,replyer : modalInputReplyer.val()
                                    ,bno : bnoValue

                                };

                                replyService.add(reply,function (result) {
                                    console.log("add들어옴");
                                    alert(result);

                                    modal.find("input").val();
                                    modal.modal("hide");
                                });//add
                            });//modalRegisterBtn클릭

                        }); //댓글추가Btn

                        /* 2. 댓글 등록 / 목록갱신 */




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


                        //[5]replyService Obj에서 댓글을 조회하는 get
                        replyService.get(
                            20  // rno=20 번 댓글 조회
                            ,function(data){
                                console.log("replyService.get으로 댓글조회--------");
                                console.log(data);
                            }
                        );//replyService.get

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

                   <%-- 댓글창 div --%>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                            <%--heading--%>
                                <div class="panel-heading">
                                    <i class="fa fa-comments fa-fw"></i> Reply
                                <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">NEW REPLY</button>
                                </div>
                            <%--reply body--%>
                                <div class="panel-body">
                                    <ul class="chat">
                                      <li class="left clearfix" data-rno='22'><%-- 22번 --%>
                                        <div>
                                            <div class="header">
                                                <strong class="primary-font">user00</strong>
                                                <small class="pull-right text-muted">2018-01-01 13:13</small>

                                            </div>
                                                <p>Good job!</p>
                                        </div>
                                      </li>
                                    </ul>
                                </div>
                           <%-- reply body :e --%>

                            </div>

                        </div>
                    </div>
<%@include file="../includes/footer.jsp"%>
