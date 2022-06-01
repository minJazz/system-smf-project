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
    <h2>${user.name}님의 에이전트 목록</h2> 
    </div>
    
    <hr/>
  	    	          
    <table>
        <tr>
            <td>
              <div style="border:1; float:right; width: 100px%;">
                  <input type="hidden" id="no" value="${no}"/>
                  <a><input type="button" value="삭제" onclick="deleteClick()"></a>
              </div>
            </td>
        </tr>
    </table>
    
    <br/>
    <div id="table"></div>
    
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
    
    <script type="text/javascript" >
        getData();
    
    	function getData() {
    		var no = document.getElementById("no").value;
        	
    		var item = {
                	"no" : no
            }
    		
    		$.ajax({
                url: "${pageContext.request.contextPath}/agent",
                method: "POST",
                contentType : "application/json; charset=UTF-8",
                dataType: "JSON",
                data: JSON.stringify(item),
                success: function (data) {
                    rendering(data);
                }
            });
    	}
    	
    	function deleteClick() {
			var radioVal = $('input[name="radio"]:checked').val();
        	
        	var no = "" + (radioVal+"").split("/")[1];
        	
        	console.log(radioVal);
        	console.log(no);
        	var item = {
            	"no" : no
            }
    		$.ajax({
                url: "${pageContext.request.contextPath}/agent",
                method: "DELETE",
                contentType : "application/json; charset=UTF-8",
                dataType: "JSON",
                data: JSON.stringify(item), 
                success: function (data) {
                    rendering(data);
                }
            });
    	}
    	
		function rendering(data) {
/* 			var no = document.getElementById("no").value;
			console.log("--->" + no);
			xmlHttp = new XMLHttpRequest();
			
			xmlHttp.open('GET', 'http://localhost/agent?no=' + no , true);
			
			xmlHttp.onreadystatechange = function() {
				if (this.status == 200 && this.readyState == this.DONE) {
					//sql문으로 읽어온 json 형식의 문자열
					var data = xmlHttp.responseText;
					//json문자열 파싱 작업 */
					//console.log("--->" + data);
					//var parseData = JSON.parse(data);
					//console.log("===>" + parseData);
					//html 변환 작업
					var text = 
						"<table border='1'>"
						+ "<thead>"
						+    "<tr>"
						+	    "<th>"
						+		    "번호"
						+		"</th>"
						+		"<th>"
						+		    "에이전트 이름"
						+		"</th>"
						+		"<th>"
						+		    "IP주소"
						+		"</th>"
					    +        "<th>"
					    +           "선택"   
					    +        "</th>"
					    + "</thead>"			
						+ "<tbody id = 'tableValue'>";
					for (var i = 0; i < data.length; i++) {
					    text +=  
					    	"<tr>"
						+	    "<th>"
						+		    (i+1)
						+		"</th>"
						+		"<td>"
						+		    data[i].agentName
						+		"</td>"
						+		"<td>"
						+		    data[i].nowAgentIpAddress
						+		"</td>"
						+		"<th>"
						+		    "<input type='radio' value=\"radio/" + data[i].no + "\" id=\"radio/" + data[i].no + "\" name='radio'/>"
						+		"</th>"
						+	"</tr>"
						+ "</tbody>"
					}
					    + "</table>";
			    document.getElementById("table").innerHTML = text;
			}
			
		
	</script>
</body>
</html>