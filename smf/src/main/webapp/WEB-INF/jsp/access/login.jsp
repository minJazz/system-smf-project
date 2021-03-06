<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">

<head>

	<title>Login | SMF</title>
	<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>

</head>

<body>
	<div class="account-pages my-1 pt-sm-5">
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
										<label class="form-label" for="username">PhoneNumber</label> <input
											type="text" class="form-control" id="phoneNumber"
											placeholder="Enter phoneNumber" name = "phoneNumber" value = "${remember}">
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
    			alert("????????? ????????? ???????????????");
    		} else if (pw == "") {
    			alert("??????????????? ???????????????");
    		} else {
    			document.login.submit(); //login ?????? ????????????.
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