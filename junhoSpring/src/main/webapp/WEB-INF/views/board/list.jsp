<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp" %>

<script type="text/javascript">
	$(document).ready( function () {
		console.log("sd")
		var result = '<c:out value = "${result}"/>';
		checkModal(result);
		function checkModal(result) {
			if (result === '') {
				return;
			}
			if(parseInt(result)>0){
				$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.")
			}
			$("#myModal").modal("show");
		}
		$("#regBtn").on("click",function(){
			self.location = "/board/register"
		})
	})
	var searchForm = $('#searchForm');
	$("#searchForm button").on("click",function(e){
		if (!searchForm.find("option:selected").val()) {
			alert("검색종류 선택");
			return false;
		}
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요")
			return false;
		}
		e.preventDefault();
		searchForm.submit();
	})
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
                        <div class="panel-heading"><i class="fa fa-comments fa-fw"></i> Reply</div>
                        <div class="panel-body">
                            <ul class="chat"> 
                                <li class="left clearfix" data-rno="12">
                                    <div>
                                        <div class="header">
                                                <strong class="primary-font">user00</strong> 
                                                <small class="pull-right text-muted">2021-05-18 13:13</small>
                                        </div>
                                        <p>Good job</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <tbody>
								<c:forEach items="${list}" var="board">               
                                  <tr class="odd gradeX">
                                        <td>${board.bno }</td>
                                        <td><a href="/board/get?bno=${board.bno }">${board.title}</a></td>
                                        <td>${board.writer }</td>
                                        <td>${board.regDate }</td>
                                        <td>${board.updateDate }</td> 
    
                                    </tr>
                                  </c:forEach>
                                </tbody>
                            </table>
	                        <form id='searchForm' action="/board/list" method="get">
			                	<select class="form-group" name="type">
			                		<option value="" <c:out value="${criteria.type==null?'selected':''}"/>>--</option>
			               			<option value="T"<c:out value="${criteria.type eq 'T'?'selected':''}"/>>제목</option>
			                		<option value="TC"<c:out value="${criteria.type eq 'TC'?'selected':''}"/>>제목 OR 내용</option>
			                		
			                	</select>
			                	<input type="text" class="form-control" name='keyword' value='<c:out value="${criteria.keyword}"/>'>
			                	<span class="input-group-btn">
			                		<button class="btn btn-info" type="button"></button>
			                	</span>
		                	</form>
                            <!-- /.table-responsive -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModallabel" aria-hidden="true">
							   <div class="modal-dialog">
							       <div class="modal-content">
							           <div class="modal-header">
							                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
							           </div>
							           <div class="modal-body">처리가 완료되었습니다.</div>
							           <div class="modal-footer">
							                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							                <button type="button" class="btn btn-default" >Save Changes</button>
							           </div>
							      </div>
							   </div>
							</div> <!-- /.modal fade -->
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->

                    </div>
                    <!-- /.panel -->
                    
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            
 <%@include file="../includes/footer.jsp" %>       