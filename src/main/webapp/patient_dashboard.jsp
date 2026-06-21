<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%

String username =
(String)session.getAttribute(
"username");

if(username == null){

response.sendRedirect(
"sessionExpired.jsp");

return;
}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Patient Dashboard</title>

<style>

body{
margin:0;
padding:0;
font-family:Arial;
background:linear-gradient(to right,#4facfe,#00f2fe);
}

.header{
background:#007bff;
color:white;
padding:20px;
text-align:center;
font-size:32px;
font-weight:bold;
box-shadow:0px 2px 10px rgba(0,0,0,0.2);
}

.container{
width:85%;
margin:auto;
margin-top:50px;
background:white;
padding:50px;
border-radius:10px;
box-shadow:0px 0px 15px rgba(0,0,0,0.2);
text-align:center;
}

h2{
color:#444;
margin-bottom:40px;
}

.cards{
display:flex;
justify-content:center;
flex-wrap:wrap;
gap:30px;
margin-top:30px;
}

.card{
width:260px;
background:#f8f9fa;
padding:30px;
border-radius:10px;
box-shadow:0px 0px 10px rgba(0,0,0,0.1);
transition:0.3s;
}

.card:hover{
transform:translateY(-5px);
}

.card h3{
color:#007bff;
margin-bottom:20px;
}

.card a{
display:inline-block;
padding:12px 20px;
background:#007bff;
color:white;
text-decoration:none;
border-radius:5px;
font-size:15px;
}

.card a:hover{
background:#0056b3;
}

.footer{
margin-top:40px;
font-size:14px;
color:#777;
}

</style>

</head>

<body>

<div class="header">

Patient Dashboard

</div>

<div class="container">

<h2>

Welcome
<%=username%>

</h2>

<div class="cards">

<div class="card">

<h3>
Upload & Encode Report
</h3>

<a href="encode.jsp">

Open

</a>

</div>

<div class="card">

<h3>
View My Reports
</h3>

<a href="patientReports.jsp">

View

</a>

</div>

<div class="card">

<h3>
Logout
</h3>

<a href="logout.jsp">

Logout

</a>

</div>

</div>

<div class="footer">

Secure Medical Data Sharing System

</div>

</div>

</body>

</html>