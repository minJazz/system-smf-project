<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">

<head>
<title>Setting | SMF</title>
<jsp:include page="/WEB-INF/jsp/common/top.jsp" />

<!-- jquery.vectormap css -->
<link
	href="/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css"
	rel="stylesheet" type="text/css" />

<link href="/assets/libs/select2/css/select2.min.css" rel="stylesheet"
	type="text/css" />
<link
	href="/assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css"
	rel="stylesheet">
<link
	href="/assets/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.css"
	rel="stylesheet" />

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
								<h4 class="page-title mb-0 font-size-18">생장환경 설정</h4>
							</div>
						</div>
					</div>
					<!-- end page title -->

					<div class="row">
						<div class="col-xl-12">
							<div class="card">
								<div class="card-body">
									<div id=settingList class="col-3">
										<select class="form-control select2" name="settingName"
											id="settingName" onchange="sendSettingName(this.value);">
											<option value="add">Select</option>
											<c:forEach items="${settingList}" var="list">
												<option value="${list.settingName}">${list.settingName}</option>
											</c:forEach>
										</select>
									</div>
									
									<br/>

									<div id=settingTable class="left-box">
										<table class="table mb-0">
											<thead class="table-light">
												<tr>
													<th>생장환경 설정 명</th>
													<th>온도</th>
													<th>습도</th>
													<th>CO2 농도</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input type="text" class="form-control" required
														placeholder="Type something" name="settingName"
														id="nameText" /></td>
													<td>
														<div>
															<input data-parsley-type="number" type="text"
																class="form-control" required
																placeholder="Enter only numbers" name="temperature"
																id="temperatureText" />
														</div>
													</td>
													<td>
														<div>
															<input data-parsley-type="number" type="text"
																class="form-control" required
																placeholder="Enter only numbers" name="humidity"
																id="humidityText" />
														</div>
													</td>
													<td>
														<div>
															<input data-parsley-type="number" type="text"
																class="form-control" required
																placeholder="Enter only numbers" name="co2"
																id="co2Text" />
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>

									<div id=updateButton style="float: right;">
										<button type="button"
											class="btn btn-outline-dark waves-effect waves-light"
											onclick="updateSetting()">갱신</button>
										<button type="button"
											class="btn btn-outline-dark waves-effect waves-light"
											onclick="deleteSetting()">삭제</button>
										</tr>
										</table>
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
								<div class="text-sm-end d-none d-sm-block">
								Design & Develop by KKH</div>
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
		function updateSetting() {
			var settingName = document.getElementById('nameText').value;
			var temperature = document.getElementById('temperatureText').value;
			var humidity = document.getElementById('humidityText').value;
			var co2 = document.getElementById('co2Text').value;

			if (settingName == "") {
				alert("생장환경 설정 이름을 입력하시오");
			} else if (temperature == "") {
				alert("온도를 입력하시오");
			} else if (humidity == "") {
				alert("습도를 입력하시오");
			} else if (co2 == "") {
				alert("co2를 입력하시오");
			} else {
				xmlRequest = new XMLHttpRequest();

				var setting = {
					userPhoneNumber : '${user.phoneNumber}',
					settingName : document.getElementById('nameText').value,
					temperature : document.getElementById('temperatureText').value,
					humidity : document.getElementById('humidityText').value,
					co2 : document.getElementById('co2Text').value
				};
				var settingJson = JSON.stringify(setting);

				xmlRequest.open("PUT", "/setting", true);
				xmlRequest.onreadystatechange = getUpdateSettingList;
				xmlRequest.setRequestHeader("Content-Type",
						"application/json;charset=UTF-8");
				xmlRequest.send(settingJson);

			}

		}
	</script>

	<script>
		function deleteSetting() {
			xmlRequest = new XMLHttpRequest();

			var setting = {
				userPhoneNumber : '${user.phoneNumber}',
				settingName : document.getElementById('nameText').value,
				temperature : document.getElementById('temperatureText').value,
				humidity : document.getElementById('humidityText').value,
				co2 : document.getElementById('co2Text').value
			};
			var settingJson = JSON.stringify(setting);

			xmlRequest.open("DELETE", "/setting", true);
			xmlRequest.onreadystatechange = getDeleteSettingList;
			xmlRequest.setRequestHeader("Content-Type",
					"application/json;charset=UTF-8");
			xmlRequest.send(settingJson);
		}
	</script>

	<script>
		function getUpdateSettingList() {
			if (xmlRequest.status == 200) {
				var text = xmlRequest.responseText;
				var json = JSON.parse(text);
			}

			var settingName = document.getElementById('nameText').value;

			var tag = "<select name = 'settingName'" + "id = 'settingName' "
					+ "onchange= 'sendSettingName(this.value);'>"
					+ "<option value = 'add'>생장환경 설정 추가</option>"

			for (var i = 0; i < json.length; i++) {
				console.log(settingName);
				console.log(json[i].settingName);
				console.log(settingName == json[i].settingName);
				if (settingName == json[i].settingName) {
					tag += "<option selected value="+json[i].settingName+ ">"
							+ json[i].settingName + "</option>"
				} else {
					tag += "<option value="+json[i].settingName+ ">"
							+ json[i].settingName + "</option>"
				}
			}
			tag += "</select>"
			document.getElementById("settingList").innerHTML = tag;
		}
	</script>

	<script>
		function getDeleteSettingList() {
			if (xmlRequest.status == 200) {
				var text = xmlRequest.responseText;
				var json = JSON.parse(text);
			}

			var tag = "<select name = 'settingName'"
					+ "id = 'settingName' "
					+ "onchange= 'sendSettingName(this.value);'>"
					+ "<option value = 'add'" + " 'selected' >생장환경 설정 추가</option>"

			for (var i = 0; i < json.length; i++) {
				tag += "<option value="+json[i].settingName+ ">"
						+ json[i].settingName + "</option>"
			}
			tag += "</select>"
			document.getElementById("settingList").innerHTML = tag;
			sendSettingName("add");
		}
	</script>

	<script>
		function sendSettingName(settingName) {
			xmlRequest = new XMLHttpRequest();
			var num = '${user.phoneNumber}';//'' 안 붙이면 번호의 맨 앞자리 0이 사라지는 현상이 발생
			var numString = num.toString();

			xmlRequest.open("GET", "/setting/?userPhoneNumber=" + numString
					+ "&settingName=" + settingName, true);
			xmlRequest.onreadystatechange = getSettingData;
			xmlRequest.setRequestHeader("Content-Type",
					"application/json;charset=UTF-8");
			xmlRequest.send();
		}
	</script>

	<script>
		function getSettingData() {
			if (xmlRequest.status == 200) {
				var text = xmlRequest.responseText
				var json = JSON.parse(text);
			}

			var tag = "";
			tag += "<table class='table mb-0'>"
					+ "<thead class='table-light'>"
					+ "<tr>"
					+ "<th>생장환경 설정 명</th>"
					+ "<th>온도</th>"
					+ "<th>습도</th>"
					+ "<th>CO2 농도</th>"
					+ "</tr>"
					+ "</thead>"
					+ "<tbody>"
					+ "<tr>"
					+ "<td>"
					+ "<input type= 'text' "+ "name = 'settingName'" + "id= 'nameText'"+ "value = '" + json.settingName + "' />"
					+ "</td>"
					+ "<td>"
					+ "<input type= 'text' "+ "name = 'temperature'" + "id= 'temperatureText'"+ "value = '" + json.temperature + "'/>"
					+ "</td>"
					+ "<td>"
					+ "<input type= 'text' "+ "name = 'humidity'" + "id= 'humidityText'"+ "value = '" + json.humidity + "'/>"
					+ "</td>"
					+ "<td>"
					+ "<input type= 'text' "+ "name = 'co2'" + "id= 'co2Text'"+ "value='" + json.co2 + "'/>"
					+ "</td>" + "</tr>" + "</tbody>" + "</table>";
			document.getElementById("settingTable").innerHTML = tag;
		}
	</script>

	<!-- JAVASCRIPT -->
	<script src="/assets/libs/jquery/jquery.min.js"></script>
	<script src="/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/assets/libs/metismenu/metisMenu.min.js"></script>
	<script src="/assets/libs/simplebar/simplebar.min.js"></script>
	<script src="/assets/libs/node-waves/waves.min.js"></script>
	<script src="/assets/libs/jquery-sparkline/jquery.sparkline.min.js"></script>


	<script src="/assets/libs/select2/js/select2.min.js"></script>
	<script
		src="/assets/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
	<script
		src="/assets/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.js"></script>
	<script
		src="/assets/libs/bootstrap-maxlength/bootstrap-maxlength.min.js"></script>


	<!-- parsley plugin -->
	<script src="/assets/libs/parsleyjs/parsley.min.js"></script>

	<!-- validation init -->
	<script src="/assets/js/pages/form-validation.init.js"></script>
	<!-- jquery.vectormap map -->
	<script
		src="/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
	<script
		src="/assets/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-us-merc-en.js"></script>

	<!-- form advanced init -->
	<script src="/assets/js/pages/form-advanced.init.js"></script>

	<script src="/assets/js/app.js"></script>

</body>

</html>