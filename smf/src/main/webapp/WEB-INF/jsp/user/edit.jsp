<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h4>사용자 정보 목록</h4>
    
    <br/>
    <br/>
    
    <h2>사용자 등록</h2>
    
    <br/>
    <br/>
    <div style="border:1; float:left; width:100px%;">
        <form:form action="/user" method="PUT">
	        <table>
            <tr>
	            <th>이름               :</th>
	            <td>
	                ${ user.name } 
	            </td>
	        </tr>
	        <tr>
	            <th>전화번호         :</th>
	            <td>
	                ${ user.phoneNumber }
	            </td>
	        </tr>
	        <tr>
	            <th>비밀번호         :</th>
	            <td><input type="text" name="password" value="${ user.password }"/></td>
	        </tr>
	        <tr>
	            <th>이메일            :</th>
	            <td><input type="text" name="mail" value="${ user.mail }" /></td>
	        </tr>
	        </table>
	        
	        <input type="hidden" name="name" value="${ user.name }"/>
	        <input type="submit" value="수정">
        </form:form>
        <a href="/user"><input type="button" value="목록"/></a>
    </div>
</body>
</html>