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
					<input type= "text" name="settingName" id="nameText"/>
				</td>
				<td>
					<input type= "text" name="temperature" value = "0" id="temperatureText"/>
				</td>
				<td>
					<input type= "text" name="humidity" value = "0" id="humidityText"/>
				</td>
				<td>
					<input type= "text" name="co2" value = "0" id="co2Text"/>
				</td>				
			</tr>
	    </table>
    </div>
    
    <div id = udpateButton>
	    <table border = "1">
	    	<tr>
				<td>
					<input type = "button" value = "갱신" onclick = "updateSetting()"/>
				</td> 
				<td>
					<input type = "button" value = "삭제" onclick = "deleteSetting()"/>
				</td>  
	   		</tr>
	    </table>
    </div>
    
    <script>
    	function updateSetting() {
    		xmlRequest = new XMLHttpRequest();
    		
    		var setting = {
    			userPhoneNumber : '${user.phoneNumber}',
    			settingName : document.getElementById('nameText').value,
    			temperature : document.getElementById('temperatureText').value,
    			humidity : document.getElementById('humidityText').value,
    			co2 : document.getElementById('co2Text').value
    		};
    		var settingJson = JSON.stringify(setting);
    		
			xmlRequest.open("PUT","/setting",true);
			xmlRequest.onreadystatechange = getUpdateSettingList;
			xmlRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xmlRequest.send(settingJson);
    		
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
        		
        		xmlRequest.open("DELETE","/setting", true);
        		xmlRequest.onreadystatechange = getDeleteSettingList;
    			xmlRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    			xmlRequest.send(settingJson);
    	}
    
    </script>
    
    <script>
    	function getUpdateSettingList() {
			if(xmlRequest.status == 200) {
				var text = xmlRequest.responseText;
				var json = JSON.parse(text);
			}
			
			var tag = "<select name = 'settingName'" + "id = 'settingName' " + "onchange= 'sendSettingName(this.value);'>"+
			"<option value = 'add'" + " 'selected' >생장환경 설정 추가</option>"
			
			for (var i = 0; i < json.length; i++) {
				tag +=
					"<option value="+json[i].settingName+ ">" + json[i].settingName+ "</option>"
			}
			tag += "</select>"
			document.getElementById("settingList").innerHTML = tag;
    	}
    </script>
    
    <script>
    	function getDeleteSettingList() {
			if(xmlRequest.status == 200) {
				var text = xmlRequest.responseText;
				var json = JSON.parse(text);
			}
			
			var tag = "<select name = 'settingName'" + "id = 'settingName' " + "onchange= 'sendSettingName(this.value);'>"+
			"<option value = 'add'" + " 'selected' >생장환경 설정 추가</option>"
			
			for (var i = 0; i < json.length; i++) {
				tag +=
					"<option value="+json[i].settingName+ ">" + json[i].settingName+ "</option>"
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
						"<input type= 'text' "+ "name = 'settingName'" + "id= 'nameText'"+ "value = '" + json.settingName + "' />"+
					"</td>"+
					"<td>"+
						"<input type= 'text' "+ "name = 'temperature'" + "id= 'temperatureText'"+ "value = '" + json.temperature + "'/>"+
					"</td>"+
					"<td>"+
						"<input type= 'text' "+ "name = 'humidity'" + "id= 'humidityText'"+ "value = '" + json.humidity + "'/>"+
					"</td>"+
					"<td>"+
						"<input type= 'text' "+ "name = 'co2'" + "id= 'co2Text'"+ "value='" + json.co2 + "'/>"+
					"</td>"+				
				"</tr>"+
    		"</table>";
			document.getElementById("settingTable").innerHTML = tag;
		}
	</script>
	
</body>
</html>