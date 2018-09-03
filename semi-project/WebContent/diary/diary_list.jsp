<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/post_list.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/paging.css">
<div class="container">
<link rel='stylesheet prefetch'
		href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<div class="mail-box">
		<aside class="sm-side">
			<div class="user-head">
				<div class="user-name">
					<h5>
						<a href="#">사용자 아이디</a>
					</h5>
					<span><a href="#">이메일@gmail.com</a></span>
				</div>

			</div>
			<div class="inbox-body">
				<a href="${pageContext.request.contextPath}/front?command=registerDiaryForm"
					data-toggle="modal" title="Compose" class="btn btn-compose"> 새 글 작성 </a> <br><br>
					<c:choose>
						<c:when test="${requestScope.postName eq 'mydiary'}">
							<a href="${pageContext.request.contextPath}/front?command=publicDiaryList"
					data-toggle="modal" title="Compose" class="btn btn-compose" id="diaryChangeBtn"> 다른 사람 일지 보기 </a>
						</c:when>
						<c:when test="${requestScope.postName eq 'sharediary'}">
							<a href="${pageContext.request.contextPath}/front?command=diaryList"
					data-toggle="modal" title="Compose" class="btn btn-compose" id="diaryChangeBtn"> 내 일지 보기 </a>
						</c:when>
					</c:choose>
				
				<!-- Modal -->
				<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
					tabindex="-1" id="myModal" class="modal fade"
					style="display: none;">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button">×</button>
								<h4 class="modal-title">Compose</h4>
							</div>
							<div class="modal-body">
								<form role="form" class="form-horizontal">
									<div class="form-group">
										<label class="col-lg-2 control-label">To</label>
										<div class="col-lg-10">
											<input type="text" placeholder="" id="inputEmail1"
												class="form-control">
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-2 control-label">Cc / Bcc</label>
										<div class="col-lg-10">
											<input type="text" placeholder="" id="cc"
												class="form-control">
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-2 control-label">Subject</label>
										<div class="col-lg-10">
											<input type="text" placeholder="" id="inputPassword1"
												class="form-control">
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-2 control-label">Message</label>
										<div class="col-lg-10">
											<textarea rows="10" cols="30" class="form-control" id=""
												name=""></textarea>
										</div>
									</div>

									<div class="form-group">
										<div class="col-lg-offset-2 col-lg-10">
											<span class="btn green fileinput-button"> <i
												class="fa fa-plus fa fa-white"></i> <span>Attachment</span>
												<input type="file" name="files[]" multiple="">
											</span>
											<button class="btn btn-send" type="submit">Send</button>
										</div>
									</div>
								</form>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
			<ul class="inbox-nav inbox-divider">
				<li class="active"><a href="#"><i class="fa fa-inbox"></i>
						다이어리 게시판 </a></li>
				<li><a href="#"><i class="fa fa-envelope-o"></i> Tip 게시판</a></li>
				<li><a href="#"><i class="fa fa-bookmark-o"></i> Q&A 게시판</a></li>
				<li><a href="#"><i class=" fa fa-external-link"></i> 판매 게시판</a></li>
				<li><a href="#"><i class=" fa fa-external-link"></i> 홈 </a></li>
			</ul>
		</aside>
		<aside class="lg-side">
			<div class="inbox-head ">
				<h3>다이어리 게시판</h3>
				<form action="#" class="pull-right position">
					<div class="input-append">
						<input type="text" class="sr-input" placeholder="제목을 입력하세요">
						<button class="btn sr-btn" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>
			</div>
			<div class="inbox-body"></div>
			<table class="table table-inbox table-hover">
				<tbody>
					<c:forEach var="dvo" items="${requestScope.dList}">
					<tr class="">
						<td class="inbox-small-cells"><input type="checkbox"
							class="mail-checkbox"></td>
						<td class="inbox-small-cells"><i class="fa fa-star"></i></td>
						<td class="view-message dont-show">${dvo.vo.name}</td>
						
						<c:choose>
						<c:when test="${requestScope.postName eq 'mydiary'}">
							<td class="view-message"><a href="${pageContext.request.contextPath}/front?command=diaryDetail&dno=${dvo.dno}">
							${dvo.title}</a></td>
						</c:when>
						<c:when test="${requestScope.postName eq 'sharediary'}">
							<td class="view-message"><a href="${pageContext.request.contextPath}/front?command=publicDiaryDetail&dno=${dvo.dno}">
							${dvo.title}</a></td>
						</c:when>
					</c:choose>
						<td class="view-message inbox-small-cells"></td>
						<td class="view-message text-right">${dvo.regDate}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<br>
			<div class="container">
				<ul class="pagination">
					<li class="disabled"><a href="#">«</a></li>
					<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">»</a></li>
				</ul>
			</div>
			<br> <br> <br> <br>
	</div>
	</aside>
</div>
</html>