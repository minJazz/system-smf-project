<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
											class="nav-link dropdown-toggle arrow-none" href="/smartfarm"
											id="topnav-dashboard" role="button"> 스마트 팜 목록 </a></li>

										<li class="nav-item dropdown"><a
											class="nav-link dropdown-toggle arrow-none" href="/setting"
											id="topnav-dashboard" role="button"> 생장환경 설정 </a></li>
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
								<h4 class="page-title mb-0 font-size-18">스마트 팜 목록</h4>
							</div>
						</div>
					</div>
					<!-- end page title -->
					<input type="hidden" id="userPhone" value="${user.phoneNumber}"></input>

					<div class="row">
						<div class="col-xl-12">
							<div class="card">
								<div class="card-body">
									<div class="col-sm-12 col-md-12 row" style="text-align: right">
									<div class="col-sm-12 col-md-5"></div>
										<label class="col-md-3 col-form-label">스마트 팜 이름 : </label>
										<div class="col-sm-12 col-md-3">
											<input class="form-control" type="search"
												palceholder="스마트 팜 이름" id="agentName" style="float: right;">
										</div>
										<div class="col-sm-12 col-md-1">
											<button type="button"
												class="btn btn-outline-dark waves-effect waves-light"
												onclick="search()" style="float: right;">검색</button>
										</div>
									</div>
									<br />

									<div class="table-responsive" id="table"></div>

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
	<script>
		var pageNo = 0;

		search();

		function changePage(pageButtonId) {
			pageNo = parseInt(pageButtonId);

			search();
		}

		function getData() {
			var text;
			var list;
			if (xmlRequest.status == 200) {
				text = xmlRequest.responseText;
				list = JSON.parse(text);
			}

			var tag = "<table class='table mb-0'>"
					+ "<thead class='table-light' style='text-align:center;'>" + "<tr>" + "<th>번호</th>"
					+ "<th>스마트 팜 이름</th>" + "<th>구분</th>" + "<td>온도 (°C)</td>"
					+ "<th>습도 (%)</th>" + "<th>CO2 농도 (ppm)</th>" + "</tr>"
					+ "</thead>" + "<tbody id = 'tableValue'>";
			for (var i = 0; i < list.length; i++) {
				if (list[i].agentName == null) {
					break;
				}

				tag += "<tr>" + "<td rowspan='2'>"
						+ (i + 1)
						+ "</td>"
						+ "<td rowspan='2'><a href='/smartfarm/" + list[i].agentNo + "'>"
						+ list[i].agentName + "</a>" + "</td>" + "<td>설정</td>"
						+ "<td style='text-align:center;'>" + list[i].settingTemperature + "</td>"
						+ "<td style='text-align:center;'>" + list[i].settingHumidity + "</td>"
						+ "<td style='text-align:center;'>"+ list[i].settingCo2 + "</td>" + "</tr>" + "<tr>"
						+ "<td>현재</td>" + "<td style='text-align:center;'>" + list[i].measureTemperature
						+ "</td>" + "<td style='text-align:center;'>" + list[i].measureHumidity + "</td>"
						+ "<td style='text-align:center;'>" + list[i].measureCo2 + "</td>" + "</tr>";
				+"</tbody>"
			}

			tag += "</table>";
			document.getElementById("table").innerHTML = tag;

			document.getElementById("pageTable").innerHTML = list[0].navigator;
		}

		function search() {
			xmlRequest = new XMLHttpRequest();

			xmlRequest.open("GET", "/smartfarm?" + "agentName="
					+ document.getElementById('agentName').value
					+ "&userPhoneNumber="
					+ document.getElementById('userPhone').value + "&pageNo="
					+ pageNo, true);
			xmlRequest.onreadystatechange = getData;
			xmlRequest.setRequestHeader("Content-Type",
					"application/json;charset=UTF-8");
			xmlRequest.send();
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