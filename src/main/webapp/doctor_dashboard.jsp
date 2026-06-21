<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%

String username =
(String)session.getAttribute("username");

String role =
(String)session.getAttribute("role");

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

<title>Doctor Dashboard</title>

<style>

body{
margin:0;
padding:0;
font-family:Arial;
background:#f2f2f2;
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
font-size:22px;
}

.card p{
color:#666;
font-size:14px;
margin-bottom:20px;
line-height:22px;
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
margin-top:50px;
font-size:14px;
color:#777;
}

</style>

</head>

<body>

<div class="header">

Doctor Dashboard

</div>

<div class="container">

<h2>

Welcome Dr.
<%=username%>

</h2>

<div class="cards">

<!-- VIEW REPORTS -->

<div class="card">

<h3>

View Reports

</h3>

<p>

View patient medical reports,
decrypt secured reports and
access uploaded files securely.

</p>

<a href="viewReports.jsp">

Open

</a>

</div>

<!-- SEARCH PATIENT -->

<div class="card">

<h3>

Search Patient

</h3>

<p>

Search patient details,
medical reports and
uploaded records instantly.

</p>

<a href="search.jsp">

Search

</a>

</div>

<!-- FORWARDED REPORTS -->

<div class="card">

<h3>

Forward Reports

</h3>

<p>

Forward secured reports
to another doctor using
the referral sharing system.

</p>

<a href="viewReports.jsp">

Forward

</a>

</div>

<!-- ACTIVITY LOGS -->

<div class="card">

<h3>

Activity Logs

</h3>

<p>

View recent doctor activities,
secure access logs and
report actions.

</p>

<a href="viewLogs.jsp">

View Logs

</a>

</div>

<!-- LOGOUT -->

<div class="card">

<h3>

Logout

</h3>

<p>

Securely logout from
the medical data sharing
system safely.

</p>

<a href="logout.jsp">

Logout

</a>

</div>

</div>

<div class="footer">

Secure Medical Data Sharing System using
Encryption and Text Steganography

</div>

</div>

</body>

</html>