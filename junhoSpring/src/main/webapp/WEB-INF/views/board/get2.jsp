<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/resources/js/reply.js"></script>
<%@include file="../includes/header.jsp" %>
<script>

$(document).ready(function () {
                   var bnoValue = '${board.bno}';
                   console.log("bnoValue "+bnoValue);
               


                   

                //    replyService.add(
                //        {
                //            reply:"Js Test",
                //            replyer:"js tester",
                //            bno:bnoValue
                //        },
                //        result =>{
                //            alert(`RESULT: ${'${result}'}`);
                //        }
                //    )
                //    replyService.getList(
                //         {bno: bnoValue, page:1}
                //         ,function(list){
                        	
                //         	console.log("list " +list);
                //             list.forEach(function (item) {
                //                 console.log(item);
                //             })
                //         }
                //     );
    /*                 replyService.remove(
                        3,
                        count => {
                            console.log(count);
                            if (count==="success") {
                                alert("REMOVED");
                            }
                        }
                        ,err => {
                            alert("error occurred...");
                        }
                    ) */
                   /*  replyService.update({
                        rno:4,
                        bno:bnoValue,
                        reply:"modified reply...."
                    }, function (result) { 
                        alert("수정완료");
                     });
                    replyService.get(5,function(data){
                        console.log(data)
                    });
                    
 */
                    const replyUL = $('.chat');
                    //댓글 목록의 이벤트 처리
/*                       showList(1);
                    function showList(page){
                        console.log("----------"+'${board.bno}')
                        replyService.getList(
                            {bno:bnoValue, page:page||1},
                            function(list){
                                var str="";
                                if(list == null || list.length==0){
                                replyUL.html("");
                                return;
                                }
                                for(var i=0, len=list.length || 0; i<len; i++){
                                    str +="<li class='left clearfix' data-rno='" +list[i].rno+"'>";
                                    str +="<div><div class='header'><strong class='primary-font'>"
                                    +list[i].replyer+"</strong>";
                                    str +="<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate)+"</small><div>";
                                    str +="<p>" + list[i].reply + "</p><div></li>";
                                }
                            replyUL.html(str);
                            }//function call
                        );
                    }//showList  */
                    replyService.getList(
                        { bno: bnoValue, page: 1 },
                        list => {
                            let str =""

                            list.forEach(element => {
                            var time = replyService.displyaTime(element.replyDate);
                            str += `
                            <li class="left clearfix" data-rno="${'${element.rno}'}">
                                    <div>
                                        <div class="header">
                                            <strong class="primary-font">${'${element.replyer}'}</strong>
                                            <small class="pull-right text-muted">${'${time}'}</small>
                                        </div>
                                        <p>${'${element.reply}'}</p>
                                    </div>
                                </li>`
                            });
                            replyUL.html(str);
                        } 
                    );

                   /// alert("ert1111");
                    var modal = $(".modal");
                    var modalInputReply = modal.find("input[name='reply']");
                    var modalInputReplyer = modal.find("input[name='replyer']")
                    var modalInputReplyDate = modal.find("input[name='replyDate']")

                    var modalModBtn = $("#modalModBtn");
                    var modalRemoveBtn = $("#modalRemoveBtn");
                    var modalRegisterBtn = $("#modalRegisterBtn");


                    $("#addReplyBtn").on("click", function (e){
                        modal.find("input").val("");
                        modalInputReplyDate.closest("div").hide();
                        modal.find("button[id!='modalCloseBtn']").hide();
                        modalRegisterBtn.show();
                        $(".modal").modal("show"); 
                     });

                     modalRegisterBtn.on("click",function (e) {
                         var reply={
                             reply:modalInputReply.val(),
                             replyer:modalInputReplyer.val(),
                             bno:bnoValue
                         };
                         replyService.add(reply, function(result) {
                             alert(result);//댓글 등록이 정상임을 팝업으로 알ㄹ미
                             modal.find("input").val("");//댓글 등록이 정상적으로 이뤄지면 내용을 지움
                             modal.modal("hide"); //모달창 닫음
                         })
                     })

                     $(".chat").on("click","li",function(e){
                         var rno=$(this).data("rno");
                         console.log(rno);
                         replyService.get(rno,function (reply) {
                             modalInputReply.val(reply.reply);
                             modalInputReplyer.val(reply.replyer);
                             modalInputReplyDate.val(replyService.displyaTime(reply.replyDate))
                             .attr("readonly","readonly");

                             modal.find("button[id!='modalCloseBtn']").hide();
                             modalModBtn.show();
                             modalRemoveBtn.show();
                             $(".modal").modal("show");
                         })
                     })
                     modalModBtn.on("click",function(e){
                         var reply = {rno:modal.data("rno"),reply:modalInputReply.val()};
                         replyService.update(reply,function (result) {
                            alert("1")

                             modal.modal("hide");
                             showList(1);
                           });
                     });
                     modalRemoveBtn.on("click",function(e){
                         var rno = modal.data("rno");
                         console.log(rno);
                         replyService.remove(rno,function (result) {
                            alert("2")
                             modal.modal("hide");
                    
                             showList(1);
                           });
                     });

                     
               });
               


</script>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">List Page</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            게시글 조회
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

                            <<%-- div class="form-group">
                                <label>Bno</label><input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly"> 
                                <label>Title</label><input class="form-control" name="title" value='<c:out value=" ${board.title}"/>' >
                                <label>writer</label><input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' >
                                <label>regDate</label><input class="form-control" name="regDate" value='<c:out value="${board.regDate }"/>' >
                                <label>updateDate</label><input class="form-control" name="updateDate" value='<c:out value="${board.updateDate } "/>' >
                            </div> --%>
	                       <div class="form-group">
	                           <label>Bno</label>
	                           <input class="form-control" name="bno" value='<c:out value="${board.bno }"></c:out>' readonly="readonly">
                           </div>
                           <div class="form-group">
	                           <label>Title</label>
	                           <input class="form-control" name="title" value='<c:out value="${board.title }"></c:out>' readonly="readonly">
                           </div>
                           <div class="form-group">
                             <label>Content</label>
                             <textarea rows="3" name="content" class="form-control" readonly="readonly"><c:out value="${board.content }"></c:out></textarea>
                           </div>
                           <div class="form-group">
                             <label>Writer</label>
                             <input class="form-control" name="writer" value='<c:out value="${board.writer }"></c:out>' readonly="readonly">
                           </div>
                           
							<button data-oper='modify' class="btn btn-default" 
                       				onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">
                       				Modify
						    </button>
						    
							<button data-oper="list" class="btn btn-default"
							    	onclick="location.href='/board/list'">
							    	List
							</button>
                        </div>
                        <!-- /.table-responsive -->
                    	
                    </div>
                    
                    
                    
                    <!-- /.panel-body -->
                    <div class="panel panel-default">  
                        <div class="panel-heading"><i class="fa fa-comments fa-fw"></i> Reply <button type="button" id="addReplyBtn" >new Reply </button></div>
                        
                        <div class="panel-body">
                           <ul class="chat"> 
                                <li class="left clearfix" data-rno="12">
                                    <div>
                                       <div class="header">
                                             <strong class="primary-font">user00</strong> 
                                             <small
                     class="pull-right text-muted">2021-05-18 13:13</small>
                                      </div>
                                      <p>Good job</p>
                                   </div>
                                </li>
                          </ul>
                        </div>
                     </div> <!-- /.reply panel -->
                     
                     
                     <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModallabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label> <input class="form-control" name='reply'value='New Reply!!!!'>
					</div>
					<div class="form-group">
						<label>Replyer</label> <input class="form-control" name='replyer'value='replyer'>
					</div>
					<div class="form-group">
						<label>Reply Date</label> <input class="form-control"name='replyDate' value=''>
					</div>

				</div>
				<div class="modal-footer">
					<button id='modalModBtn' type="button"
						class="btn btn-outline btn-warning">Modify</button>
					<button id='modalRemoveBtn' type="button"
						class="btn btn-outline btn-danger">Remove</button>
					<button id='modalRegisterBtn' type="button"
						class="btn btn-outline btn-primary">Register</button>
					<button id='modalCloseBtn' type="button"
						class="btn btn-outline btn-success">Close</button>
				</div>
			</div>
		</div>
	</div>
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-6 -->
        <!-- /.row -->
 <%@include file="../includes/footer.jsp" %>       