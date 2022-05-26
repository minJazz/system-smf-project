<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
    <hr/>
    <br/>
    <div style="border:1; float:left; width:100px%;">
    <form action="/user" method="POST">
	    <table>
	        <tr>
	            <th>이름               :</th>
	            <td><input type="text" name="name" /></td>
	        </tr>
	        <tr>
	            <th>전화번호         :</th>
	            <td><input type="text" name="phoneNumber" /></td>
	        </tr>
	        <tr>
	            <th>비밀번호         :</th>
	            <td><input type="text" name="password" /></td>
	        </tr>
	        <tr>
	            <th>이메일            :</th>
	            <td><input type="text" name="mail" /></td>
	        </tr>
	        <tr>
	            <th>관리자 여부     :</th>
	            <td><input type="checkbox" name="permission" value="M" /></td>
	        </tr>
	    </table>
    <input type="submit" value="등록" >
    </form>
    <a href="/user"><input type="button" value="목록"></a>
    </div>
</body>
</html>