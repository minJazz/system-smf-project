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
    
    <div style="float:right;">
    	${user.name} 님
    	<a href="/logout"><input type="button" value="로그아웃"/></a>
    </div>
    
    <div>
    <h2>사용자 정보 목록</h2> 
    
    </div>
    
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
                  <a><input type="button" value="삭제" id="deleteBtn" onclick="deleteClick()" /></a>
              </div>
            </td>
        </tr>
    </table>
    
    <br/>
    <div id="table"></div>
    
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
    
    <script type="text/javascript" >
    	rendering();
    	
    	function deleteClick() {
			var radioVal = $('input[name="radio"]:checked').val();
        	
        	var uniqueNo = "" + (radioVal+"").split("/")[1];
        	
        	var item = {
            	"no" : uniqueNo
            }
    		$.ajax({
                url: "${pageContext.request.contextPath}/user",
                method: "DELETE",
                contentType : "application/json; charset=UTF-8",
                dataType: "JSON",
                data: JSON.stringify(item), 
                success: function (data) {
                    rendering();
                }
            });
    	}
    	
        function editClick(val) {
        	var radioVal = $('input[name="radio"]:checked').val();
        	
        	var no = (radioVal+"").split("/")[1];
     	    window.location.href = "http://localhost/user/" + no + "/form";
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
						text += "<tbody id = 'tableValue'><tr><th>"
								+ (i+1)
								+ "</th><td><a href='/agent/" + parseData[i].no + "' >"
								+ parseData[i].name + "</a></td><td>"
								+ parseData[i].phoneNumber + "</td>"
								+ "<td>" + parseData[i].mail + "</td>"
								+ "<th><input type='radio' value=\"radio/" + parseData[i].no + "\" id=\"radio/" + parseData[i].no +  "\" name=\"radio\" class='checkBtn' </th></tr></tbody>";
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