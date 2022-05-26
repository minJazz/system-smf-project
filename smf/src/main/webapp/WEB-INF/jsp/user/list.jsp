<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <input type="button" value="사용자 정보 목록" />
    <br/>
    
    <h2>사용자 정보 목록</h2>
    <hr/>
    <table>
        <tr>
            <td>
              <div style="border:1; float:left; width:100px%;">
              	     검색 조건
	              <select id="name">
	                  <option value="0" selected>이름</option>
	                  <c:forEach items="${list}" var="row">
	                      <option value="${row.name}">${row.name}</option>
	                  </c:forEach>
	              </select>
	              <input type="text" id="phoneNumber" placeholder="전화번호" />
	              <input type="button" value="검색" onclick="rendering()">
              </div>
              <div style="border:1; float:right; width: 100px%;">
                  <a href="/user/form"><input type="button" value="등록"></a>
                  <input type="button" value="수정" onclick="editClick(tableValue)">
                  <a><input type="button" value="삭제" onclick="deleteClick(tableValue)"></a>
              </div>
            </td>
        </tr>
    </table>
    
    <br/>
    <div id="table"></div>
    
    <script type="text/javascript">
        function deleteClick(val) {
        	for (var i = 0; i < val.length; i++) {
        	    var radio = document.getElementById("radio" + i);
                if (radio.checked) {
                    console.log(radio);
        	        console.log(val[i].innerText.split("\t")[0]);
        	        
        	        var no = val[i].innerText.split("\t")[0];
        	        window.location.href = "http://localhost/user/" + no + "/form";
                }
        	}
        }
        function editClick(val) {
        	console.log(radio);
        	for (var i = 0; i < val.length; i++) {
        	    var radio = document.getElementById("radio" + i);
                if (radio.checked) {
                    console.log(radio);
        	        console.log(val[i].innerText.split("\t")[0]);
        	        
        	        var no = val[i].innerText.split("\t")[0];
        	        window.location.href = "http://localhost/user/" + no + "/form";
                }
        	}
        }
    
    
		function rendering() {
			xmlHttp = new XMLHttpRequest();
			
			var name = document.getElementById("name").value;
			var phoneNumber = document.getElementById("phoneNumber").value;
			
			if (name != 0 && phoneNumber == null) {
				xmlHttp.open('GET', 'http://localhost/user?name='+name, true);
			} else if (name == 0 && phoneNumber != null) {
				xmlHttp.open('GET', 'http://localhost/user?phoneNumber='+phoneNumber, true);
			} else {
				xmlHttp.open('GET', 'http://localhost/user?name='+name+'&phoneNumber='+phoneNumber, true);
			}
			
			xmlHttp.onreadystatechange = function() {
				if (this.status == 200 && this.readyState == this.DONE) {
					//sql문으로 읽어온 json 형식의 문자열
					var data = xmlHttp.responseText;
					//json문자열 파싱 작업
					var parseData = JSON.parse(data);
					console.log(parseData);
					//html 변환 작업
				    var text = "<table border='1'> <thead> <tr> <th>번호</th> <th>이름</th> <th>연락처</th> <th>이메일</th> <th>선택</th> </tr> </thead>";
					for (var i = 0; i < parseData.length; i++) {
						text += "<tbody id = 'tableValue'><tr><td>"
								+ (i+1)
								+ "</th><td><a href='/agent/" + parseData[i].no + "' >"
								+ parseData[i].name + "</a></td><td>"
								+ parseData[i].phoneNumber + "</td>"
								+ "<td>" + parseData[i].mail + "</td>"
								+ "<td><input type='radio' id=\"radio" + i +  "\" class='checkBtn' </td></tr></tbody>";
					}
					text += "</table>";
					document.getElementById("table").innerHTML = text;
				}
			}
			xmlHttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xmlHttp.send();
		}
	</script>
</body>
</html>