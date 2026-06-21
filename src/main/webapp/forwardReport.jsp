<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<%
String username =
(String)session.getAttribute("username");

if(username == null){

response.sendRedirect("login.jsp");

return;
}

String reportId =
request.getParameter("reportId");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Forward Report</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
margin:0;
padding:0;
}

.container{
width:500px;
margin:auto;
margin-top:80px;
background:white;
padding:40px;
border-radius:10px;
box-shadow:0px 0px 10px rgba(0,0,0,0.2);
}

h2{
text-align:center;
color:#007bff;
margin-bottom:30px;
}

select{
width:100%;
padding:12px;
border:1px solid #ccc;
border-radius:5px;
font-size:15px;
margin-bottom:20px;
}

button{
width:100%;
padding:12px;
background:#007bff;
color:white;
border:none;
border-radius:5px;
font-size:16px;
cursor:pointer;
}

button:hover{
background:#0056b3;
}

.back{
display:block;
text-align:center;
margin-top:20px;
text-decoration:none;
color:#007bff;
}

</style>

</head>

<body>

<div class="container">

<h2>Forward Report to Doctor</h2>

<form action="ForwardReportServlet"
method="post">

<input type="hidden"
name="reportId"
value="<%=reportId%>">

<select name="doctorName"
required>

<option value="">
Select Doctor
</option>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"select username from users where role='doctor'");

ResultSet rs =
ps.executeQuery();

while(rs.next()){

String doctor =
rs.getString("username");
%>

<option value="<%=doctor%>">

Dr. <%=doctor%>

</option>

<%
}

con.close();

}catch(Exception e){

e.printStackTrace();
}
%>

</select>

<button type="submit">

Forward Report

</button>

</form>

<a href="viewReports.jsp"
class="back">

Back

</a>

</div>

</body>

</html>