<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<%

String username =
(String)session.getAttribute(
"username");

if(username == null){

response.sendRedirect(
"sessionExpired.jsp");

return;
}

int totalUsers = 0;
int totalDoctors = 0;
int totalPatients = 0;
int totalReports = 0;

Connection con = null;

try{

con =
DBConnection.getConnection();

PreparedStatement ps1 =
con.prepareStatement(
"select count(*) from users");

ResultSet rs1 =
ps1.executeQuery();

if(rs1.next()){

totalUsers =
rs1.getInt(1);
}

PreparedStatement ps2 =
con.prepareStatement(
"select count(*) from users where role='doctor'");

ResultSet rs2 =
ps2.executeQuery();

if(rs2.next()){

totalDoctors =
rs2.getInt(1);
}

PreparedStatement ps3 =
con.prepareStatement(
"select count(*) from users where role='patient'");

ResultSet rs3 =
ps3.executeQuery();

if(rs3.next()){

totalPatients =
rs3.getInt(1);
}

PreparedStatement ps4 =
con.prepareStatement(
"select count(*) from reports");

ResultSet rs4 =
ps4.executeQuery();

if(rs4.next()){

totalReports =
rs4.getInt(1);
}

}catch(Exception e){

e.printStackTrace();
}

String type =
request.getParameter("type");

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>

<style>

body{
margin:0;
font-family:Arial;
background:linear-gradient(to right,#4facfe,rgb(255, 255, 255), 255, 255));
}

.header{
background:#007bff;
padding:20px;
color:white;
text-align:center;
font-size:32px;
font-weight:bold;
box-shadow:0px 2px 10px rgba(0,0,0,0.2);
}

.container{
width:90%;
margin:auto;
margin-top:40px;
margin-bottom:40px;
}

.welcome{
text-align:center;
font-size:28px;
margin-bottom:40px;
color:white;
font-weight:bold;
}

.cards{
display:flex;
justify-content:space-between;
flex-wrap:wrap;
gap:20px;
}

.card{
flex:1;
min-width:200px;
background:rgb(192, 192, 192)09, 170, 213)28, 255, 255);
padding:30px;
border-radius:10px;
box-shadow:0px 0px 15px rgba(0,0,0,0.2);
text-align:center;
transition:0.3s;
text-decoration:none;
}

.card:hover{
transform:translateY(-5px);
}

.card h2{
margin:0;
font-size:40px;
color:#007bff;
}

.card p{
font-size:20px;
color:#555;
margin-top:15px;
}

.menu{
text-align:center;
margin-top:40px;
}

.menu a{
text-decoration:none;
padding:15px 25px;
background:#007bff;
color:white;
border-radius:5px;
margin:10px;
display:inline-block;
font-size:16px;
transition:0.3s;
}

.menu a:hover{
background:#0056b3;
}

.details{
margin-top:50px;
background:rgb(0, 128, 255)28, 255, 255);
padding:30px;
border-radius:10px;
box-shadow:0px 0px 15px rgba(0,0,0,0.2);
overflow:auto;
}

.details h2{
text-align:center;
margin-bottom:30px;
color:#333;
}

table{
width:100%;
border-collapse:collapse;
}

th,td{
padding:15px;
border:1px solid #ddd;
text-align:center;
}

th{
background:#007bff;
color:white;
}

tr:nth-child(even){
background:#f9f9f9;
}

tr:hover{
background:#eef5ff;
}

</style>

</head>

<body>

<div class="header">

Admin Dashboard

</div>

<div class="container">

<div class="welcome">

Welcome Admin :
<%=username%>

</div>

<div class="cards">

<a class="card"
href="admin_dashboard.jsp?type=users">

<h2>
<%=totalUsers%>
</h2>

<p>Total Users</p>

</a>

<a class="card"
href="admin_dashboard.jsp?type=doctors">

<h2>
<%=totalDoctors%>
</h2>

<p>Total Doctors</p>

</a>

<a class="card"
href="admin_dashboard.jsp?type=patients">

<h2>
<%=totalPatients%>
</h2>

<p>Total Patients</p>

</a>

<a class="card"
href="admin_dashboard.jsp?type=reports">

<h2>
<%=totalReports%>
</h2>

<p>Total Reports</p>

</a>

</div>

<div class="menu">

<a href="manageUsers.jsp">

Manage Users

</a>

<a href="viewReports.jsp">

View Reports

</a>

<a href="viewLogs.jsp">

Activity Logs

</a>

<a href="logout.jsp">

Logout

</a>

</div>

<%

if(type != null){

%>

<div class="details">

<%

if(type.equals("users")){

%>

<h2>All Users</h2>

<table>

<tr>

<th>ID</th>

<th>Username</th>

<th>Role</th>

</tr>

<%

PreparedStatement ps =
con.prepareStatement(
"select * from users");

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td>
<%=rs.getInt(1)%>
</td>

<td>
<%=rs.getString(2)%>
</td>

<td>
<%=rs.getString(4)%>
</td>

</tr>

<%
}
%>

</table>

<%
}

else if(type.equals("doctors")){

%>

<h2>Doctor List</h2>

<table>

<tr>

<th>ID</th>

<th>Doctor Name</th>

</tr>

<%

PreparedStatement ps =
con.prepareStatement(
"select * from users where role='doctor'");

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td>
<%=rs.getInt(1)%>
</td>

<td>
<%=rs.getString(2)%>
</td>

</tr>

<%
}
%>

</table>

<%
}

else if(type.equals("patients")){

%>

<h2>Patient List</h2>

<table>

<tr>

<th>ID</th>

<th>Patient Name</th>

</tr>

<%

PreparedStatement ps =
con.prepareStatement(
"select * from users where role='patient'");

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td>
<%=rs.getInt(1)%>
</td>

<td>
<%=rs.getString(2)%>
</td>

</tr>

<%
}
%>

</table>

<%
}

else if(type.equals("reports")){

%>

<h2>Uploaded Reports</h2>

<table>

<tr>

<th>ID</th>

<th>Patient Name</th>

<th>File Name</th>

</tr>

<%

PreparedStatement ps =
con.prepareStatement(
"select * from reports");

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td>
<%=rs.getInt(1)%>
</td>

<td>
<%=rs.getString(2)%>
</td>

<td>
<%=rs.getString(5)%>
</td>

</tr>

<%
}
%>

</table>

<%
}
%>

</div>

<%
}

if(con != null){

con.close();
}
%>

</div>

</body>

</html>