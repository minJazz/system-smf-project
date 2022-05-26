<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스마트 팜 관리</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	var moveCondition = "now";
</script>
<style>
.left-box {
  float: left;
}
.right-box {
  float: right;
}
</style>
<div>
	<div class="left-box">
		<table>
			<tr>
				<td><th><a href="/smartfarm"><h2>스마트 팜 목록</h2></a></th></td>
				<td> | </td>
				<td><th><a href="/setting"><h2>생장환경 설정</h2></a></th></td>
			</tr>
		</table>
	</div>
	<div class="right-box">
		<table>
			<tr><br/></tr>
			<tr>
				<td><h2>${ user.name }</h2></td>
				<td>
					<form method="get" action="/logout">
						<input type="submit" value="로그아웃" style="font-size:20px;"/>
					</form>
				</td>
			</tr>
		</table>
	</div>
</div>

<br/>
<br/>
<br/>
<br/>
<br/>


</head>
<body>

<div class="left-box">
	<form:form action="/smartfarm" method="put">
		<input type="text" name="agentName" value="${agent.agentName}" style="font-size:25px; width:200px;"/>
		<input type="hidden" name="agentIpAddress" id="agentIpAddress" value="${agent.agentIpAddress}" />
		<input type="submit" value="수정" style="font-size:20px;" />
	</form:form>
	
</div>

<br/>
<br/>
<br/>

<table>
	<tr>
	<form method="PUT" action="/control">
		<td>
			<div class="left-box">
				
			
				<table border='2' height="300">
					<tr>
						<td style="text-align:center;">생장환경 요소</td>
						<td style="text-align:center;">생장환경 값</td>
					</tr>
					<tr>
						<td style="text-align:center;">온도</td>
						<td><input type="text" id="temperature" name="temperature" value="${setting.temperature}"> °C</td>
					</tr>
					<tr>
						<td style="text-align:center;">습도</td>
						<td><input type="text" id="humidity" name="humidity" value="${setting.humidity}"> %</td>
					</tr>
					<tr>
						<td style="text-align:center;">CO2 농도</td>
						<td><input type="text" id="co2" name="co2" value="${setting.co2}"> ppm</td>
					</tr>
				</table>
			</div>
		</td>
		
		<td>
			<table height="300" style="text-align:center;">
				<tr>
					<td colspan="2" id="combo" height="60">
						<select id="selectBox" name="selectBox" onchange="changeSetting(this)">
							<option value="none" value1="0" value2="0" value3="0">생장 환경 설정</option>
							<c:forEach items="${settings}" var="row" varStatus="object">
			                    <option value1="${row.temperature}" value2="${row.humidity}" value3="${row.co2}">${row.settingName}</option>
			                </c:forEach>
						</select>
					</td>
					<script>
						function changeSetting(obj) {
							document.getElementById("temperature").value = $("#selectBox > option:selected").attr("value1");
							document.getElementById("humidity").value = $("#selectBox > option:selected").attr("value2");
							document.getElementById("co2").value = $("#selectBox > option:selected").attr("value3");
						}
						
						function initSelect() {
							$("#selectBox").val("none").prop("selected", true);
						}
					</script>
				</tr>
				<tr>
					<td width="30"><a href="#" onclick=upTemp() ><h2> + </h2></a></td>
					<script>
						function upTemp() {
							let temp = parseFloat(document.getElementById("temperature").value);
							
							document.getElementById("temperature").value = (temp + 1);
							initSelect();
						}
					</script>
					<td width="20"><a href="#" onclick=downTemp() ><h2> - </h2></a></td>
					<script>
						function downTemp() {
							let temp = parseFloat(document.getElementById("temperature").value);
							
							document.getElementById("temperature").value = (temp - 1);
							initSelect();
						}
					</script>
				</tr>
				
				<tr>
					<td width="30"><a href="#" onclick=upHumi() ><h2> + </h2></a></td>
					<script>
						function upHumi() {
							let humidity = parseFloat(document.getElementById("humidity").value);
							
							document.getElementById("humidity").value = (humidity + 1);
							initSelect();
						}
					</script>
					<td width="20"><a href="#" onclick=downHumi() ><h2> - </h2></a></td>
					<script>
						function downHumi() {
							let humidity = parseFloat(document.getElementById("humidity").value);
							
							document.getElementById("humidity").value = (humidity - 1);
							initSelect();
						}
					</script>
				</tr>
				
				<tr>
					<td width="30"><a href="#" onclick=upCo2() ><h2> + </h2></a></td>
					<script>
						function upCo2() {
							let co2 = parseFloat(document.getElementById("co2").value);
							
							document.getElementById("co2").value = (co2 + 1);
							initSelect();
						}
						
					</script>
					<td width="20"><a href="#" onclick=downCo2() ><h2> - </h2></a></td>
					<script>
						function downCo2() {
							let co2 = parseFloat(document.getElementById("co2").value);
							
							document.getElementById("co2").value = (co2 - 1);
							initSelect();
						}
						
					</script>
					<td><input type="submit" value="제어"/></td>
				</tr>
			</table>
				<input type="hidden" name="agentIpAddress" value="${agent.agentIpAddress}"/>
		</td>
	</form>
	
		<td style="vertical-align:top;">
			<table>
				<tr>
					<td id="photoName" style="text-align:center"></td>
					<td>
						<input type="date" id="photoDate" value="" onchange="nowTime();" />
						<script>
							function nowTime() {
								moveCondition = "now";
								
								photoCall();
							}
							
						</script>
						<input type="hidden" id="photoTime" value=00 />
						<input type="hidden" id="camera" value=1 />
					</td>
				</tr>
				<tr>
					<td colspan="2"><img id="photo" src="" style="width: 300px; min-width: 300px; heigtht: 300px; min-height: 300px"/>
						<div id="imageNotice"></div>
					</td>
				</tr>
				<tr style="text-align:center;">
					<td><a href="#" onclick=downTime() id="previous"><h2> <-- </h2></a></td>
					<script>
						function downTime() {
							moveCondition = "previous";
							
							photoCall();
						}
						
					</script>
					
					<td><a href="#" onclick=upTime() id="next"><h2> --> </h2></a></td>
					<script>
						function upTime() {
							moveCondition = "next";
							
							photoCall();
						}
						
					</script>
				</tr>
				<script>
					photoCall();
					
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
				            		$("#previous").removeAttr("href");
				            		
				            	} else if (obj.exist == "overFlow") {
				            		document.getElementById("imageNotice").innerText = "다음 사진이 존재하지 않습니다.";
				            		$("#next").removeAttr("href");
				            		
				            	} else if (obj.exist == "noFile") {
				            		document.getElementById("imageNotice").innerText = "해당 날짜의 사진이 존재하지 않습니다.";
				            		$("#previous").removeAttr("href");
				            		$("#next").removeAttr("href");
				            		
				            	} else {
				            		$("#photo").attr("src", "/image/" + document.getElementById("agentIpAddress").value + "/" + obj.date + "/" + obj.time + "(" + obj.camera + ").jpg");
				            		$("#previous").attr("href", "#");
				            		$("#next").attr("href", "#");
				            		
				            		document.getElementById("imageNotice").innerText = "";
				            	}
				            	
				            	document.getElementById("photoDate").value = obj.date;
				            	document.getElementById("photoTime").value = obj.time;
				            	document.getElementById("camera").value = obj.camera;
				            	
				            	document.getElementById("photoName").innerText = document.getElementById("photoTime").value + ":00 (" + document.getElementById("camera").value + "번 카메라)";
				            }
						});
					}
				</script>
				</table>
		</td>
	</tr>
</table>



</body>
</html>