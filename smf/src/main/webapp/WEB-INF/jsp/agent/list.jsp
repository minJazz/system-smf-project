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
    <a href="/user"><input type="button" value="사용자 정보 목록" /></a>
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
                  <input type="hidden" id="phoneNumber" value="${user.phoneNumber}"/>
                  <a><input type="button" value="삭제" onclick="deleteClick()"></a>
              </div>
            </td>
        </tr>
    </table>
    
    <br/>
    <div id="table"></div>
    
    <br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>

	<div id="pageTable"></div>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
    
    <script type="text/javascript" >
        var pageNo = 0;
        getData();
    
    	function changePage(pageButtonId) {
            pageNo = parseInt(pageButtonId);

            search();
        }
    	
    	function getData() {
    		var userPhoneNumber = document.getElementById("phoneNumber").value;
    		
    		var item = {
                	"userPhoneNumber" : userPhoneNumber,
                	"pageNo" : pageNo
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
        	
        	var item = {
            	"no" : no,
            	"pageNo" : pageNo
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
			console.log(data)
			
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
			for (var i = 1; i < data.length; i++) {
			    text +=  
			    	"<tr>"
				+	    "<th>"
				+		    (i)
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
	        document.getElementById("pageTable").innerHTML = data[0].agentName;
		}
	</script>
</body>
</html>