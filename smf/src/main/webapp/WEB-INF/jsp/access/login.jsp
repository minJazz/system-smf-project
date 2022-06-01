<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <form action = "/login" method = "POST" name = "login">
        phoneNumber : <input type = "text" name = "phoneNumber" id = "phoneNumber" value = "${remember}"/>
        PW : <input type = "password" name = "password" id = "password"/>
        <input type = "button" value = "로그인" onclick = "checkInfo()"/> </br>
        
        phoneNumber 기억하기<input type = "checkbox" name = "remember" ${check}/>
    </form>
    
    <script>
    	function checkInfo() {
    		var ph = document.getElementById('phoneNumber').value;
    		var pw = document.getElementById('password').value;
    		
    		if(ph == "" ) {
    			alert("핸드폰 번호를 입력하세요");
    		} else if (pw == "") {
    			alert("비밀번호를 입력하세요");
    		} else {
    			document.login.submit(); //login 폼을 송신한다.
    		}
    	}
    </script>


</body>
</html>