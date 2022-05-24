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
    <form action = "/login" method = "POST">
        phoneNumber : <input type = "text" name = "phoneNumber" value = "${remember}"/>
        PW : <input type = "password" name = "password"/>
        <input type = "submit" value = "로그인"/> </br>
        
        <input type = "checkbox" name = "remember" ${check}/>
    </form>


</body>
</html>