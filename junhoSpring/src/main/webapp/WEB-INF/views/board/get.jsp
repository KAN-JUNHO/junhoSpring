<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js" defer></script>
<script type="text/javascript">
	$(document).ready(function() {
		/* alert(replyService.displayTime('1653286576000')); */
		
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		

/* 		replyService.add({
			reply : "JS TEST",
			replyer : "js tester",
			bno : bnoValue
		} // 댓글 데이터
		, function(result) {
			alert("RESULT : " + result);
		}) */

/* 		replyService.getList({
			bno : bnoValue,
			page : 1
		}, function(list) {
			list.forEach(function(item) {
				console.log(item);
			});
		}) */

		/* 		replyService.remove(
		 3
		 , function (count) {
		 console.log(count);
		 if(count === "success"){
		 alert("REMOVED");
		 }
		 }, function (err) {
		 alert('error occurred...');
		 }
		 ) */

/* 		replyService.update({
			rno : 20,
			bno : bnoValue,
			reply : "modified reply..."
		}, function(result) {
			alert("수정 완료");
		}) */

		replyService.get(9, function(data) {
			console.log(data);
		})
		
		//댓글 목록의 이벤트 처리
		var replyUL = $(".chat");
		showList(1);
		function showList(page){
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
		}//showList
		
		
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		var modalCloseBtn = $("#modalCloseBtn");
		
		$("#addReplyBtn").on("click", function (e) {
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id!='modalCloseBtn']").hide();
			modalRegisterBtn.show();
			$(".modal").modal("show");
		});
		
		modalRegisterBtn.on("click", function (e) {
			var reply = {
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue
			};
			
			replyService.add(reply, function (result) {
				alert(result); 				// 댓글 등록이 정상임을 팝업으로 알림
				modal.find("input").val("");// 댓글 등록이 정상적으로 이뤄지면, 내용을 지움
				modal.modal("hide");		// 모달창 닫음
				showList(1);
			});
		});
		
		
		$(".chat").on("click", "li", function (e) {
			var rno = $(this).data("rno");
			/* console.log(rno); */
			
			replyService.get(rno, function (reply) {
				/* console.log(replyService.displayTime(reply.replyDate));
				console.log(displayTime(reply.replyDate)); */
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id!='modalCloseBtn']").hide();
				modalRemoveBtn.show();
				$(".modal").modal("show");
			});
		});
		
		modalModBtn.on("click", function (e) {
			var reply = {
				rno: modal.data("rno"),
				reply: modalInputReply.val()
			};
			replyService.update(reply, function (result) {
				modal.modal("hide");
				showList(1);
			});
		});
		
		modalRemoveBtn.on("click", function (e) {
			var rno = modal.data("rno");
			replyService.remove(rno, function (result) {
				modal.modal("hide");
				showList(1);
			});
		});
		
		modalCloseBtn.on("click", function (e) {
			modal.modal("hide");
		});

	});
</script>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="form-group">
	<label>Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly"> <label>Content</label> <input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly"> <label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
</div>

<button data-oper='modify' class="btn btn-info" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
<button data-oper='list' class="btn btn-success" onclick="location.href='/board/list'">List</button>
<br>
<br>
<div class="panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-comments fa-fw"></i> Reply
		<button id='addReplyBtn' type="button" class="btn btn-xs pull-right btn-success">New Reply</button>
	</div>
	<div class="panel-body">
		<ul class="chat">
			<li class="left clearfix" data-rno="12">
				<div>
					<div class="header">
						<strong class="primary-font">user00</strong> <small class="pull-right text-muted">2021-05-18 13:13</small>
					</div>
					<p>Good job</p>
				</div>
			</li>
		</ul>
	</div>
</div>
<!-- /.reply panel -->


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModallabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY Modal</h4>
			</div>
			<div class="modal-body">
				<div class="modal-group">
					<label>Reply</label> <input class="form-control" name="reply" value="New Reply!!!">
				</div>
				<div class="modal-group">
					<label>Replyer</label> <input class="form-control" name="replyer" value="Replyer~~">
				</div>
				<div class="modal-group">
					<label>Reply Date</label> <input class="form-control" name="replyDate" value="2016-01-05">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning" id="modalModBtn">Modify</button>
				<button type="button" class="btn btn-danger" id="modalRemoveBtn">Remove</button>
				<button type="button" class="btn btn-primary" id="modalRegisterBtn">Register</button>
				<button type="button" class="btn btn-default" id="modalCloseBtn">Close</button>
			</div>
		</div>`
	</div>
</div>




<!-- /.row -->
<%@include file="../includes/footer.jsp"%>
