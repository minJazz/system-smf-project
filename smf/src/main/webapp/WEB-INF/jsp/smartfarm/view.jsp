<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">

<head>
<title>SmartFarm management | SMF</title>
<jsp:include page="/WEB-INF/jsp/common/top.jsp" />
<script>
	var moveCondition = "now";
</script>
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
								<h4 class="page-title mb-0 font-size-18">스마트팜 관리</h4>
							</div>
						</div>
					</div>
					<!-- end page title -->

					<div class="row">
						<div class="col-xl-12">
							<div class="card">
								<div class="card-body">
									<div class="col row">

										<form class="custom-validation">
											<div class="col-sm-12 col-md-3"
												style="float: left; margin-left: 0px; padding-left: 0px;">
												<div class="col-sm-12 col-md-12 row"
													style="text-align: left;">
													<div>
														<input type="text" name="agentName" id="agentName"
															class="form-control" required
															placeholder="Type something" value="${agent.agentName}"
															javascript:if(event.keyCode==13) {}" />
													</div>
													<div>
														<input type="hidden" name="agentIpAddress"
															id="agentIpAddress" value="${agent.agentIpAddress}"
															 />
													</div>
												</div>
											</div>

											<div class="col-sm-12 col-md-7">
												<input type="submit"
													class="btn btn-outline-dark waves-effect waves-light"
													value="수정" onclick="edit()" /> <input type="text"
													style="display: none;" />
											</div>
										</form>
									</div>
									<script>
										function edit() {
											$
													.ajax({
														url : "${pageContext.request.contextPath}/smartfarm",
														method : "put",
														data : {
															agentIpAddress : document
																	.getElementById("agentIpAddress").value,
															agentName : document
																	.getElementById("agentName").value
														}
													});
										}
									</script>

									<br /> <br />

									<div class="col-sm-12 col-md-6" style="float: left;">
										<div class="col-md-6 row"
											style="margin-left: 2px; margin-right: 0px;">
											<select class="form-select" id="selectBox" name="selectBox"
												onchange="changeSetting(this)">
												<option value="none" value1="0" value2="0" value3="0">생장
													환경 설정</option>
												<option value="now" value1="${setting.temperature}"
													value2="${setting.humidity}" value3="${setting.co2}"
													selected>현재 설정 된 값</option>
												<c:forEach items="${settings}" var="row" varStatus="object">
													<option value1="${row.temperature}"
														value2="${row.humidity}" value3="${row.co2}">${row.settingName}</option>
												</c:forEach>
											</select>

											<script>
											function changeSetting(obj) {
												document
														.getElementById("temperature").value = $(
														"#selectBox > option:selected")
														.attr("value1");
												document
														.getElementById("humidity").value = $(
														"#selectBox > option:selected")
														.attr("value2");
												document.getElementById("co2").value = $(
														"#selectBox > option:selected")
														.attr("value3");
											}

											var initCount = 0;
											function initSelect() {
												if (initCount < 3) {
													initCount++;
													nowSelect();
												} else {
													$("#selectBox").val("none")
															.prop("selected", true);
												}
											}
											
											function nowSelect() {
												$("#selectBox").val("now")
														.prop("selected", true);
											}
										</script>
										</div>


										<br />

										<div class="col-md-11 row" style="margin-left: 5px;">
											<table class="table mb-0" height="400">
												<thead class='table-light'>
													<tr>
														<td style="text-align: center;">생장환경 요소</td>
														<td style="text-align: center;">생장환경 값</td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td style="text-align: center;">온도 :</td>
														<td>
															<div class="mb-3 row">
																<input data-toggle="touchspin" id="temperature"
																	value="${setting.temperature}" type="text"
																	data-step="1.0" data-decimals="1" data-bts-postfix="°C"
																	onchange=initSelect()>
															</div>
														</td>
													</tr>
													<tr>
														<td style="text-align: center;">습도 :</td>
														<td>
															<div class="mb-3 row">
																<input data-toggle="touchspin" id="humidity"
																	value="${setting.humidity}" type="text" data-step="1.0"
																	data-bts-postfix="%" onchange=initSelect()>
															</div>
														</td>
													</tr>
													<tr>
														<td style="text-align: center;">CO2 농도 :</td>
														<td>
															<div class="mb-3 row">
																<input data-toggle="touchspin" id="co2"
																	value="${setting.co2}" type="text" data-step="100.0"
																	data-bts-postfix="ppm" onchange=initSelect()>
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
										<div class="col-sm-12 col-md-2" style="float: right;">
											<button type="button"
												class="btn btn-lg btn-outline-dark waves-effect waves-light"
												onclick="control()" style="float: center;">제어</button>
										</div>
										<script>
											function control() {
												$
														.ajax({
															url : "${pageContext.request.contextPath}/control",
															method : "put",
															data : {
																agentIpAddress : document
																		.getElementById("agentIpAddress").value,
																temperature : document
																		.getElementById("temperature").value,
																humidity : document
																		.getElementById("humidity").value,
																co2 : document
																		.getElementById("co2").value
															}
														});
											}
										</script>
									</div>

									<div class="col-sm-12 col-md-6" style="float: left;">
										<div class="col-sm-12 col-md-12" style="float: right;">
											<label id="photoName" for="example-date-input"
												class="col-md-4 col-form-label"></label>

											<div class="col-sm-8 col-md-8" style="float: right;">
												<input class="form-control" id="photoDate" type="date"
													value="" onchange="nowTime();" />
												<script>
													function nowTime() {
														moveCondition = "now";
														
														document.getElementById("photoTime").value = "00";
														document.getElementById("camera").value = "1";
														
														photoCall();
													}
													
												</script>

												<input type="hidden" id="photoTime" value=00 /> <input
													type="hidden" id="camera" value=1 />
											</div>
										</div>
										<br /> <br /> <br />
										<div class="mb-12 row">
											<img id="photo" class="rounded mr-2" style="height: 400px;"
												data-holder-rendered="true">
										</div>
										<br />
										<div class="mb-12 row" style="text-align: center;">
											<p>
												<strong id="imageNotice"></strong>
											</p>
										</div>
										<div class="mb-3 row" style="text-align: center;">
											<div class="col-sm-12 col-md-6" style="text-align: center;">
												<button type="button"
													class="btn btn-link btn-lg btn-rounded waves-effect"
													onclick=downTime() id="previous" style="float: center;">previous</button>
												<script>
												function downTime() {
													moveCondition = "previous";
													
													photoCall();
												}
											</script>
											</div>
											<div class="col-sm-12 col-md-6" style="text-align: center;">
												<button type="button"
													class="btn btn-link btn-lg btn-rounded waves-effect"
													onclick=upTime() id="next" style="float: center;">next</button>
												<script>
												function upTime() {
													moveCondition = "next";
													
													photoCall();
												}
											</script>
											</div>
										</div>
									</div>

									<div class="col-sm-12 col-md-12">
										<div id="chart-container">FusionCharts XT will load
											here!</div>
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
		
		
	</script>

	<script type="text/javascript"
		src="https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
	<script type="text/javascript"
		src="https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>
	<script type="text/javascript">
	photoCall();
	measure();
	
	function photoCall() {
		$.ajax({
            url: "${pageContext.request.contextPath}/photo",
            type: "GET",
            data: {
            	ipAddress : document.getElementById("agentIpAddress").value, 
            	date : document.getElementById("photoDate").value,
            	time : document.getElementById("photoTime").value,
            	camera : document.getElementById("camera").value, 
            	move : moveCondition
            },
            success: function (obj) {
            	if (obj.exist == "underFlow") {
            		document.getElementById("imageNotice").innerText = "전 사진이 존재하지 않습니다.";
            		$("#photo").attr("src", "/image/noimg.png");
            		$("#previous").attr("disabled", true);
            		
            	} else if (obj.exist == "overFlow") {
            		document.getElementById("imageNotice").innerText = "다음 사진이 존재하지 않습니다.";
            		$("#photo").attr("src", "/image/noimg.png");
            		$("#next").attr("disabled", true);
            		
            	} else if (obj.exist == "noFile") {
            		document.getElementById("imageNotice").innerText = "해당 날짜의 사진이 존재하지 않습니다.";
            		$("#photo").attr("src", "/image/noimg.png");
            		$("#previous").attr("disabled", true);
            		$("#next").attr("disabled", true);
            		
            	} else {
            		$("#photo").attr("src", "/image/" + document.getElementById("agentIpAddress").value + "/" + obj.date + "/" + obj.time + "(" + obj.camera + ").jpg");
            		$("#previous").attr("disabled", false);
            		$("#next").attr("disabled", false);
            		
            		document.getElementById("imageNotice").innerText = "";
            	}
            	
            	document.getElementById("photoDate").value = obj.date;
            	document.getElementById("photoTime").value = obj.time;
            	document.getElementById("camera").value = obj.camera;
            	
            	document.getElementById("photoName").innerText = document.getElementById("photoTime").value + ":00 (" + document.getElementById("camera").value + "번 카메라)";
            }
		});
	}
	
	function leftPad(value) {
	    if (value >= 10) {
	        return value;
	    }

	    return '0' + value;
	}
	
	var category = "";
	
	var datasetString = "";
	var dataset = [{}, {}, {}];
	
	var startTime;
	var now;
	
	function measure() {
		now = new Date();
		let nowFormat = now.getFullYear() + "-" + leftPad(now.getMonth() + 1) + "-" + leftPad(now.getDate());
		
		startTime = new Date();
		startTime.setFullYear(startTime.getFullYear() - 1);
		let startTimeFormat = startTime.getFullYear() + "-" + leftPad(startTime.getMonth() + 1) + "-" + leftPad(startTime.getDate());
		
		const months = [
			  'Jan',
			  'Feb',
			  'Mar',
			  'Apr',
			  'May',
			  'Jun',
			  'Jul',
			  'Aug',
			  'Sep',
			  'Oct',
			  'Nov',
			  'Dec'
			];
		
		$.ajax({
            url: "${pageContext.request.contextPath}/measurement",
            type: "GET",
            data: {
            	agentIpAddress : document.getElementById("agentIpAddress").value, 
            	startTime : startTimeFormat,
            	endTime : nowFormat
            },
            success: function (rows) {
            	let time = startTime;
            	for (let i = 0; i < rows.length; i++) {
            		category += rows[i].measureTime + "|"  
            	}
            	
            	category = category.slice(0, -1);
            		            	
            	dataset[0].seriesname = "Temperature";
            	dataset[1].seriesname = "Humidity";
            	dataset[2].seriesname = "Co2";
            	
            	dataset[0].data = "";
        		dataset[1].data = "";
        		dataset[2].data = "";
            	
            	for (let i=0; i<rows.length; i++) {
            		dataset[0].data += "" + rows[i].temperature + "|";
            		dataset[1].data += "" + rows[i].humidity + "|";
            		dataset[2].data += "" + rows[i].co2 + "|";
            	}
            	dataset[0].data = dataset[0].data.slice(0, -1);
            	dataset[1].data = dataset[1].data.slice(0, -1);
            	dataset[2].data = dataset[2].data.slice(0, -1);
            	dataset[2].parentYAxis = "S";
            	
        		FusionCharts.ready(function(){
        			console.log(datasetString);
        			console.log(category); 
        			
        			var chartObj = new FusionCharts({
        				type: 'zoomlinedy',
        				renderAt: 'chart-container',
        				width: '100%',
        				height: '390',
        				dataFormat: 'json',
        				dataSource: {
        				    "chart": {
        				        "caption": "생장환경 그래프",
        				        "pYAxisName": "Temperatur, Humidity",
        				        "sYAxisName": "Co2",
        				        "compactDataMode": "1",
        				        "pixelsPerPoint": "0",
        				        "lineThickness": "1",
        				        "dataSeparator": "|",
        				        "pYAxisMaxValue": "100",
        				        "pYAxisMinValue": "0",
        				        "sYAxisMaxValue": "1000",
        				        "sYAxisMinValue": "0",
        				        "theme": "fusion"
        				    },
        				    "categories": [{
        				        "category": category
        				    }],
        				    "dataset": dataset
        				}
        				});
        						chartObj.render();
        			});
            }
		});
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

	<script src="/assets/libs/select2/js/select2.min.js"></script>

	<script
		src="/assets/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
	<script
		src="/assets/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.js"></script>
	<script
		src="/assets/libs/bootstrap-maxlength/bootstrap-maxlength.min.js"></script>

	<!-- App js -->
	<script src="/assets/js/app.js"></script>

	<!-- form advanced init -->
	<script src="/assets/js/pages/form-advanced.init.js"></script>

</body>

</html>