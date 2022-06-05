<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">

<head>
<title>Agent List | SMF</title>
<jsp:include page="/WEB-INF/jsp/common/top.jsp" />

<!-- jquery.vectormap css -->
<link
	href="/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css"
	rel="stylesheet" type="text/css" />

</head>

<body data-layout="horizontal">
	<div class="container-fluid">
		<!-- Begin page -->
		<div id="layout-wrapper">

			<header id="page-topbar">
				<div class="navbar-header">
					<div class="d-flex">
						<button type="button"
							class="btn btn-sm px-3 font-size-16 d-lg-none header-item waves-effect waves-light"
							data-bs-toggle="collapse" data-bs-target="#topnav-menu-content">
							<i class="fa fa-fw fa-bars"></i>
						</button>

						<div class="topnav">
							<nav class="navbar navbar-light navbar-expand-lg topnav-menu">

								<div class="collapse navbar-collapse" id="topnav-menu-content">
									<ul class="navbar-nav">
										<li class="nav-item dropdown"><a
											class="nav-link dropdown-toggle arrow-none" href="/user"
											id="topnav-dashboard" role="button"> 사용자 정보 목록 </a></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>

					<div class="d-flex">
						<div class="dropdown d-none d-lg-inline-block ms-1">
							<button type="button"
								class="btn header-item noti-icon waves-effect"
								data-toggle="fullscreen">
								<i class="mdi mdi-fullscreen"></i>
							</button>
						</div>

						<div class="dropdown d-inline-block">
							<span class="d-none d-xl-inline-block ms-1">${user.name} 님</span>

							<button type="button" class="btn header-item waves-effect"
								id="page-header-user-dropdown" data-bs-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"
								onclick="location.href='/logout'">
								<span class="d-none d-xl-inline-block ms-1">로그아웃</span>
							</button>
						</div>


					</div>
				</div>
			</header>

			<!-- ============================================================== -->
			<!-- Start right Content here -->
			<!-- ============================================================== -->
			<div class="main-content">

				<div class="page-content">

					<!-- start page title -->
					<div class="row">
						<div class="col-12">
							<div
								class="page-title-box d-flex align-items-center justify-content-between">
								<h4 class="page-title mb-0 font-size-18">${agentUser.name}님의
									에이전트 목록</h4>
							</div>
						</div>
					</div>
					<!-- end page title -->

					<div class="row">
						<div class="col-xl-12">
							<div class="card">
								<div class="card-body">
									<input type="hidden" id="phoneNumber"
										value="${agentUser.phoneNumber}" />

									<div class="row">
										<div class="col-sm-12 col-md-12 col-xl-12">
											<div class="my-12 text-center" style="float:right;">
												<button type="button" value="삭제" id="deleteBtn"
													data-bs-toggle="modal"
													data-bs-target=".bs-example-modal-center"
													class="btn btn-outline-dark waves-effect waves-light"
													style="float: right; margin-right: 10px;">삭제</button>
											</div>

											<div class="modal fade bs-example-modal-center" tabindex="-1"
												role="dialog" aria-labelledby="mySmallModalLabel"
												aria-hidden="true">
												<div class="modal-dialog modal-dialog-centered">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title mt-0">삭제 확인</h5>
															<button type="button" class="btn-close"
																data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body" style="text-align: center;">
															<p>해당 에이전트를 정말로 삭제하시겠습니까?</p>
															<button type="button" onclick="deleteClick()"
																class="btn btn-outline-dark waves-effect waves-light"
																data-bs-dismiss="modal" aria-label="Close">예</button>
															<button type="button"
																class="btn btn-outline-dark waves-effect waves-light"
																data-bs-dismiss="modal" aria-label="Close">아니요</button>
														</div>
													</div>
													<!-- /.modal-content -->
												</div>
												<!-- /.modal-dialog -->
											</div>
											<!-- /.modal -->
										</div>
									</div>

									<br />
									<div class="row">
										<div class="table-responsive" id="table"></div>
									</div>
									<br /> <br />

									<div class="row">
										<div class="col-sm-12 col-md-12">
											<div class="dataTables_paginate paging_simple_numbers"
												id="datatable_paginate">
												<ul class="pagination justify-content-center" id="pageTable">
												</ul>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>

					</div>
					<!-- end row -->

				</div>
				<!-- End Page-content -->

				<footer class="footer">
					<div class="container-fluid">
						<div class="row">
							<div class="col-sm-12">
								<div class="text-sm-end d-none d-sm-block">Design &
									Develop by KKH</div>
							</div>
						</div>
					</div>
				</footer>
			</div>
			<!-- end main content-->

		</div>
		<!-- END layout-wrapper -->

	</div>
	<!-- end container-fluid -->

	<!-- JAVASCRIPT -->
	<script type="text/javascript">
		var pageNo = 0;
		getData();

		function changePage(pageButtonId) {
			pageNo = parseInt(pageButtonId);

			search();
		}

		function getData() {
			var userPhoneNumber = document.getElementById("phoneNumber").value;

			var item = {
				"userPhoneNumber" : userPhoneNumber,
				"pageNo" : pageNo
			}

			$.ajax({
				url : "${pageContext.request.contextPath}/agent",
				method : "POST",
				contentType : "application/json; charset=UTF-8",
				dataType : "JSON",
				data : JSON.stringify(item),
				success : function(data) {
					rendering(data);
				}
			});
		}

		function deleteClick() {
			var radioVal = $('input[name="radio"]:checked').val();

			var no = "" + (radioVal + "").split("/")[1];

			var item = {
				"no" : no,
				"pageNo" : pageNo
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/agent",
				method : "DELETE",
				contentType : "application/json; charset=UTF-8",
				dataType : "JSON",
				data : JSON.stringify(item),
				success : function(data) {
					rendering(data);
				}
			});
		}

		function rendering(data) {
			console.log(data)

			var text = "<table class='table mb-0'>"
					+ "<thead class='table-light'>" + "<tr>" + "<th>" + "번호"
					+ "</th>" + "<th>" + "에이전트 이름" + "</th>" + "<th>" + "IP주소"
					+ "</th>" + "<th style='text-align: center;'>" + "선택"
					+ "</th>" + "</tr>" + "</thead>"
					+ "<tbody id = 'tableValue'>";
			for (var i = 1; i < data.length; i++) {
				text += "<tr>"
						+ "<th>"
						+ (i)
						+ "</th>"
						+ "<td>"
						+ data[i].agentName
						+ "</td>"
						+ "<td>"
						+ data[i].agentIpAddress
						+ "</td>"
						+ "<th style='text-align: center;'>"
						+ "<input class='form-check-input' type='radio' value=\"radio/" + data[i].no + "\" id=\"radio/" + data[i].no + "\" name='radio'/>"
						+ "</th>" + "</tr>" + "</tbody>"
			}
			+"</table>";
			document.getElementById("table").innerHTML = text;
			document.getElementById("pageTable").innerHTML = data[0].agentName;
		}
	</script>

	<!-- JAVASCRIPT -->


	<script src="/assets/libs/jquery/jquery.min.js"></script>
	<script src="/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/assets/libs/metismenu/metisMenu.min.js"></script>
	<script src="/assets/libs/simplebar/simplebar.min.js"></script>
	<script src="/assets/libs/node-waves/waves.min.js"></script>
	<script src="/assets/libs/jquery-sparkline/jquery.sparkline.min.js"></script>


	<!-- jquery.vectormap map -->
	<script
		src="/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
	<script
		src="/assets/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-us-merc-en.js"></script>


	<script src="/assets/js/app.js"></script>

</body>

</html>