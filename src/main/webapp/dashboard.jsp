<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String username =
(String)session.getAttribute("username");

if(username == null){

response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Patient Dashboard</title>

<style>

body{
font-family:Arial;
background:linear-gradient(to right,#43e97b,#38f9d7);
margin:0;
}

.container{
width:80%;
margin:auto;
margin-top:80px;
background:white;
padding:40px;
border-radius:10px;
text-align:center;
}

a{
text-decoration:none;
padding:15px 25px;
background:green;
color:white;
border-radius:5px;
margin:10px;
display:inline-block;
}

a:hover{
background:darkgreen;
}

</style>

</head>

<body>

<div class="container">

<h1>Patient Dashboard</h1>

<h2>Welcome <%=username%></h2>

<br>

<a href="encode.jsp">

Upload & Encode Report

</a>

<a href="patientReports.jsp">

View My Reports

</a>

<a href="logout.jsp">

Logout

</a>

</div>

</body>
</html>