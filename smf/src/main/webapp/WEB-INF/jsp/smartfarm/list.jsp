<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style>
.left-box {
  float: left;
}
.right-box {
  float: right;
}
</style>

<head>
<meta charset="UTF-8">
<title>스마트 팜 목록</title>

</head>
<body>
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

<div class="left-box">
	<h1>스마트 팜 목록</h1>
</div>

<br/>
<br/>
<br/>
<br/>
<br/>

<div class="right-box">
<table>
	<tr>
		<td>
			<input type="text" palceholder="스마트 팜 이름" id="agentName">
		</td>
		<td>
			<button onclick="search()">검색</button>
		</td>
		
	</tr>
</table>
</div>

<br/>
<br/>
<br/>

<div id="table" class="left-box"></div>

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<div id="pageTable"></div>

<br/>
<br/>
<br/>

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
		if(xmlRequest.status == 200) {
			text = xmlRequest.responseText;
			list = JSON.parse(text);
        }
           
        var tag = "<table border='2'>" 
       		+ "<tr>"
       		    + "<td>번호</td>"
       		    + "<td>스마트 팜 이름</td>"
       		    + "<td>구분</td>"
       		    + "<td>온도 (°C)</td>"
       		    + "<td>습도 (%)</td>"
       		    + "<td>CO2 농도 (ppm)</td>"
       		+ "</tr>"
        for (var i = 0; i < list.length; i++) {
        	tag += 
        		"<tr>"
        			+ "<td rowspan='2'>" + (i + 1) + "</td>"
        			+ "<td rowspan='2'><a href='/smartfarm/" + list[i].agentNo + "'>" 
        				+ list[i].agentName + "</a>"
        			+ "</td>" 
        			+ "<td>설정</td>"
        			+ "<td>" + list[i].settingTemperature + "</td>"
        			+ "<td>" + list[i].settingHumidity + "</td>"
        			+ "<td>" + list[i].settingCo2 + "</td>"
        		+ "</tr>"
        		+ "<tr>"
         			+ "<td>현재</td>"
        			+ "<td>" + list[i].measureTemperature + "</td>"
        			+ "<td>" + list[i].measureHumidity + "</td>"
        			+ "<td>" + list[i].measureCo2 + "</td>"
        		+ "</tr>";
        }
        
        tag += "</table>";
       	document.getElementById("table").innerHTML = tag;

       	console.log("navi : " + list[0].navigator);
       	document.getElementById("pageTable").innerHTML = list[0].navigator;
	}
	
	function search() { 
		console.log(pageNo);
		
		xmlRequest = new XMLHttpRequest();
		
		xmlRequest.open("GET", "/smartfarm?" 
				+ "agentName=" + document.getElementById('agentName').value
				// + "&userPhoneNumber=" + ${user.phoneNumber}
				+ "&pageNo=" + pageNo
				, true);
		xmlRequest.onreadystatechange = getData;
		xmlRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xmlRequest.send();
	}
</script>

</body>
</html>