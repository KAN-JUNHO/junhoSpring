<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp" %>
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
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-6 -->
        <!-- /.row -->
 <%@include file="../includes/footer.jsp" %>       