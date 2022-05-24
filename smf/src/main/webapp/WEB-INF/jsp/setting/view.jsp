<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>view</title>
</head>
<body>

	<div>
		<style>
		.left-box {
		  float: left;
		}
		.right-box {
		  float: right;
		}
		</style>
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
			<tr>
				<td><h2>${user.phoneNumber}</h2></td>
				<td>
					<form method="get" action="/logout">
						<input type="submit" value="로그아웃" style="font-size:20px;"/>
					</form>
				</td>
			</tr>
		</table>
		</div>	
	</div>
	
<br>
<br>
<br>
<br>

	<div id = settingList>
		<select name="settingName" id="settingName" onchange="sendSettingName(this.value);">
			<option value="add" selected>생장환경 설정 추가</option>
			<c:forEach items="${settingList}" var="list">
				<option value="${list.settingName}">${list.settingName}</option>
			</c:forEach>
		</select>
	</div>
	
	<div id = settingTable class = "left-box">
	    <table border = "1">
	    	<tr>
				<th>생장환경 설정 명</th>
				<th>온도</th>
				<th>습도</th>
				<th>CO2 농도</th>
			</tr>
			<tr>
				<td>
					<input type= "text" name="settingName"/>
				</td>
				<td>
					<input type= "text" name="temperature"/>
				</td>
				<td>
					<input type= "text" name="humidity"/>
				</td>
				<td>
					<input type= "text" name="co2"/>
				</td>				
			</tr>
	    </table>
    </div>
	
	<script>
		function sendSettingName(settingName) {
			xmlRequest = new XMLHttpRequest();
			var num = '${user.phoneNumber}';//'' 안 붙이면 번호의 맨 앞자리 0이 사라지는 현상이 발생
			var numString = num.toString();
			
			console.log(numString)
			
			xmlRequest.open("GET","/setting/?userPhoneNumber="+numString +"&settingName="+ settingName,true);
			xmlRequest.onreadystatechange = getSettingData;
			xmlRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xmlRequest.send();
		}
	</script>
	
	<script>
		function getSettingData() {
			if(xmlRequest.status == 200){
				var text = xmlRequest.responseText
				var json = JSON.parse(text);
			}
			
			var tag = "";
			tag += 
			"<table border = '1'>" +
		    	"<tr>"+
					"<th>생장환경 설정 명</th>"+
					"<th>온도</th>"+
					"<th>습도</th>"+
					"<th>CO2 농도</th>"+
				"</tr>"+
				"<tr>"+
					"<td>"+
						"<input type= 'text' "+ "name = 'settingName'" + "value = '" + json.settingName + "' />"+
					"</td>"+
					"<td>"+
						"<input type= 'text' "+ "name = 'temperature'" + "value = '" + json.temperature + "'/>"+
					"</td>"+
					"<td>"+
						"<input type= 'text' "+ "name = 'humidity'" + "value = '" + json.humidity + "'/>"+
					"</td>"+
					"<td>"+
						"<input type= 'text' "+ "name = 'co2'" + "value='" + json.co2 + "'/>"+
					"</td>"+				
				"</tr>"+
    		"</table>";
			document.getElementById("settingTable").innerHTML = tag;
		}
	</script>
	
</body>
</html>