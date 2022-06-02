<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">

<head>

<meta charset="utf-8" />
<title>Login | SMF</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta content="Premium Multipurpose Admin & Dashboard Template"
	name="description" />
<meta content="Themesbrand" name="author" />
<!-- App favicon -->
<link rel="shortcut icon" href="/assets/images/favicon.ico">

<!-- Bootstrap Css -->
<link href="/assets/css/bootstrap.min.css" id="bootstrap-style"
	rel="stylesheet" type="text/css" />
<!-- Icons Css -->
<link href="/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
<!-- App Css-->
<link href="/assets/css/app.min.css" id="app-style" rel="stylesheet"
	type="text/css" />

</head>

<body>
	<div class="account-pages my-5 pt-sm-5">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-8 col-lg-6 col-xl-5">
					<div class="card overflow-hidden">
						<div class="bg-login text-center">
							<div class="bg-login-overlay"></div>
							<div class="position-relative">
								<h5 class="text-white font-size-20">Welcome Back !</h5>
								<p class="text-white-50 mb-0">Sign in to continue to SMF.</p>

							</div>
						</div>
						<div class="card-body pt-5">
							<div class="p-2">
								<form class="form-horizontal" action="/login" method="POST" name="login">

									<div class="mb-3">
										<label class="form-label" for="username">phoneNumber</label> <input
											type="text" class="form-control" id="phoneNumber"
											placeholder="Enter username" name = "phoneNumber" value = "${remember}">
									</div>

									<div class="mb-3">
										<label class="form-label" for="userpassword">Password</label>
										<input type="password" class="form-control" id="password"
											placeholder="Enter password" name = "password" >
									</div>

									<div class="form-check">
										<input type="checkbox" class="form-check-input"
											id="customControlInline" name = "remember" ${check}> <label
											class="form-check-label" for="customControlInline">Remember
											me</label>
									</div>

									<div class="mt-3">
										<button class="btn btn-primary w-100 waves-effect waves-light"
											type="button" onclick = "checkInfo()">Log In</button>
									</div>

								</form>
							</div>

						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>

	<script>
    	function checkInfo() {
    		var ph = document.getElementById('phoneNumber').value;
    		var pw = document.getElementById('password').value;
    		
    		if(ph == "" ) {
    			alert("핸드폰 번호를 입력하세요");
    		} else if (pw == "") {
    			alert("비밀번호를 입력하세요");
    		} else {
    			document.login.submit(); //login 폼을 송신한다.
    		}
    	}
    </script>

	<!-- JAVASCRIPT -->
	<!-- JAVASCRIPT -->
	<script src="/assets/libs/jquery/jquery.min.js"></script>
	<script src="/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/assets/libs/metismenu/metisMenu.min.js"></script>
	<script src="/assets/libs/simplebar/simplebar.min.js"></script>
	<script src="/assets/libs/node-waves/waves.min.js"></script>
	<script src="/assets/libs/jquery-sparkline/jquery.sparkline.min.js"></script>

	<script src="/assets/js/app.js"></script>

</body>

</html>