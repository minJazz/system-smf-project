<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">

<head>
<title>User Register | SMF</title>
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
								<h4 class="page-title mb-0 font-size-18">사용자 등록</h4>
							</div>
						</div>
					</div>
					<!-- end page title -->

					<div class="row">
						<div class="col-xl-2"></div>
						<div class="col-xl-8" style="float: center;">
							<form class="custom-validation" action="/user" method="POST">
								<div class="card">
									<div class="card-body">

										<div class="col-sm-12 col-md-10" style="float: center;">
											<div class="mb-3 row">
												<label for="example-text-input"
													class="col-md-2 col-form-label">이름 </label>
												<div class="col-md-10">
													<input class="form-control" placeholder="Type something"
														type="text" name="name" />
												</div>
											</div>

											<div class="mb-3 row">
												<label for="example-tel-input"
													class="col-md-2 col-form-label">전화번호 </label>
												<div class="col-md-10">
													<input class="form-control" data-parsley-type="number"
														placeholder="Enter only numbers" type="tel" data-parsley-length="[11,11]"
														name="phoneNumber" />
												</div>
											</div>

											<div class="mb-3 row">
												<label for="example-tel-input"
													class="col-md-2 col-form-label">비밀번호 </label>
												<div class="col-md-10">
													<div>
														<input type="password" id="pass2" class="form-control"
															required placeholder="Password" name="password" data-parsley-length="[8,16]"/>
													</div>
													<div class="mt-2">
														<input type="password" class="form-control" required
															data-parsley-equalto="#pass2"
															placeholder="Re-Type Password" data-parsley-length="[8,16]"/>
													</div>
												</div>
											</div>

											<div class="mb-3 row">
												<label for="example-tel-input"
													class="col-md-2 col-form-label">이메일 </label>
												<div class="col-md-10">
													<input type="email" class="form-control" required
														parsley-type="email" placeholder="Enter a valid e-mail"
														name="mail" />
												</div>
											</div>

											<div class="mb-3 row">
												<label for="example-tel-input"
													class="col-md-2 col-form-label" style="padding-right:0px">관리자 여부 </label>
												<div class="col-md-10">
													<div class="form-check form-switch" style="font-size: 25px">
														<input class="form-check-input" type="checkbox"
															id="flexSwitchCheckChecked" name="permission" value="M"
															checked>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<a href="/user">
                                <button type="button" style="float:right;" class="btn btn-secondary waves-effect">
                                                목록
                                </button>
                                </a>
                                <button type="submit" style="float:right;" class="btn btn-primary waves-effect waves-light me-1">
                                                등록
                                </button>
							</form>
						</div>

					</div>
					<!-- end row -->

				</div>
				<!-- End Page-content -->
				
				<br/>
				
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


	<!-- parsley plugin -->
	<script src="/assets/libs/parsleyjs/parsley.min.js"></script>

	<!-- validation init -->
	<script src="/assets/js/pages/form-validation.init.js"></script>

	<script src="/assets/js/app.js"></script>

</body>

</html>