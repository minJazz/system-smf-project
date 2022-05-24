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
	              <select name="name" placeholder="이름">
	                  <option value="0">이름</option>
	                  <c:forEach items="${list}" var="row" varStatus="object">
	                      <option value="${object.count}">${row.name}</option>
	                  </c:forEach>
	              </select>
	              <input type="text" id="phoneNumber" placeholder="전화번호" />
	              <input type="button" value="검색" onclick="rendering()">
              </div>
              <div style="border:1; float:right; width: 100px%;">
                  <a href="/user/form"><input type="button" value="등록"></a>
                  <a href="/user/${no}/form"><input type="button" value="수정"></a>
                  <a><input type="button" value="삭제"></a>
              </div>
            </td>
        </tr>
    </table>
    
    <br/>
    <div id="table"></div>
    <table border=1>
        <th>번호</th>
        <th>이름</th>
        <th>연락처</th>
        <th>이메일</th>
        <th>선택</th>
    </table>
    
    <script type="text/javascript">
		function rendering() {
			xmlHttp = new XMLHttpRequest();
			
// 			var input = {
// 				title : document.getElementById("input").value
// 			};

// 			var json = JSON.stringify(input);
// 			console.log(json);

			xmlHttp.open('GET', 'http://localhost/topics?title='+document.getElementById("input").value, true);
			xmlHttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xmlHttp.send();
			xmlHttp.onreadystatechange = function() {
				if (this.status == 200 && this.readyState == this.DONE) {
					//sql문으로 읽어온 json 형식의 문자열
					var data = xmlHttp.responseText;
					//json문자열 파싱 작업
					var parseData = JSON.parse(data);
					console.log(parseData);
					//html 변환 작업
					var text = "<table border='1'> <tr> <th>번호</th> <th>제목</th> <th>내용</th> </tr>";
					for (var i = 0; i < parseData.length; i++) {
						text += "<tr><td>"
								+ parseData[i].no
								+ "</th><td><a href='/topics/" + parseData[i].no + "' >"
								+ parseData[i].title + "</a></td><td>"
								+ parseData[i].note + "</td></tr>";
					}
					text += "</table>";
					document.getElementById("table").innerHTML = text;
					//Object.keys(parseData[i]) -> no, title, note
					//Object.values(parseData[i]) -> 내용
				}
			}
		}
	</script>
    
</body>
</html>