<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<%

String username =
(String)session.getAttribute("username");

String role =
(String)session.getAttribute("role");

if(username == null){

response.sendRedirect("login.jsp");

return;
}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Patient Reports</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
margin:0;
padding:0;
}

.container{
width:95%;
margin:auto;
padding-top:30px;
padding-bottom:40px;
}

h1{
text-align:center;
color:#333;
margin-bottom:30px;
}

.search-box{
background:white;
padding:20px;
border-radius:10px;
margin-bottom:20px;
box-shadow:0px 0px 10px rgba(0,0,0,0.1);
text-align:center;
}

.search-box input{
padding:12px;
width:230px;
margin:10px;
border:1px solid #ccc;
border-radius:5px;
font-size:14px;
}

.search-box button{
padding:12px 20px;
background:#007bff;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
font-size:14px;
}

.search-box button:hover{
background:#0056b3;
}

.reset-btn{
text-decoration:none;
padding:12px 20px;
background:#6c757d;
color:white;
border-radius:5px;
font-size:14px;
}

.reset-btn:hover{
background:#545b62;
}

table{
width:100%;
border-collapse:collapse;
background:white;
box-shadow:0px 0px 10px rgba(0,0,0,0.2);
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

.view-btn{
text-decoration:none;
padding:8px 15px;
background:#28a745;
color:white;
border-radius:5px;
font-size:14px;
display:inline-block;
margin:3px;
}

.view-btn:hover{
background:#218838;
}

.decrypt-btn{
padding:8px 15px;
background:#007bff;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
font-size:14px;
}

.decrypt-btn:hover{
background:#0056b3;
}

.forward-btn{
padding:8px 15px;
background:#17a2b8;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
font-size:14px;
margin-top:5px;
}

.forward-btn:hover{
background:#117a8b;
}

select{
padding:8px;
border-radius:5px;
border:1px solid #ccc;
width:180px;
}

form{
margin:0;
}

.no-data{
text-align:center;
padding:20px;
color:red;
font-size:18px;
}

.status{
background:#d4edda;
color:green;
padding:8px 12px;
border-radius:5px;
font-weight:bold;
font-size:13px;
display:inline-block;
}

.back{
display:inline-block;
margin-top:20px;
padding:12px 20px;
background:#007bff;
color:white;
text-decoration:none;
border-radius:5px;
}

.back:hover{
background:#0056b3;
}

.action-box{
display:flex;
flex-direction:column;
align-items:center;
gap:8px;
}

</style>

</head>

<body>

<div class="container">

<h1>Patient Reports</h1>

<!-- SEARCH FILTER -->

<div class="search-box">

<form method="get"
action="viewReports.jsp">

<input type="text"
name="patient"
placeholder="Search Patient Name"
value="<%=request.getParameter("patient") != null ? request.getParameter("patient") : ""%>">

<input type="text"
name="file"
placeholder="Search File Name"
value="<%=request.getParameter("file") != null ? request.getParameter("file") : ""%>">

<button type="submit">

Search

</button>

<a href="viewReports.jsp"
class="reset-btn">

Reset

</a>

</form>

</div>

<table>

<tr>

<th>ID</th>

<th>Patient Name</th>

<th>Assigned Doctor</th>

<th>Stego Status</th>

<th>Uploaded Report</th>

<th>Decrypt</th>

<%

if(role.equalsIgnoreCase("doctor")){

%>

<th>Forward Report</th>

<%
}
%>

</tr>

<%

try{

Connection con =
DBConnection.getConnection();

String patientSearch =
request.getParameter("patient");

String fileSearch =
request.getParameter("file");

String sql =
"select * from reports where 1=1";

if(role.equalsIgnoreCase("doctor")){

sql +=
" and doctor_name=?";
}

if(role.equalsIgnoreCase("patient")){

sql +=
" and patient_name=?";
}

if(patientSearch != null &&
!patientSearch.trim().equals("")){

sql +=
" and patient_name like ?";
}

if(fileSearch != null &&
!fileSearch.trim().equals("")){

sql +=
" and file_name like ?";
}

sql +=
" order by id desc";

PreparedStatement ps =
con.prepareStatement(sql);

int index = 1;

if(role.equalsIgnoreCase("doctor")){

ps.setString(index++,
username);
}

if(role.equalsIgnoreCase("patient")){

ps.setString(index++,
username);
}

if(patientSearch != null &&
!patientSearch.trim().equals("")){

ps.setString(index++,
"%" + patientSearch + "%");
}

if(fileSearch != null &&
!fileSearch.trim().equals("")){

ps.setString(index++,
"%" + fileSearch + "%");
}

ResultSet rs =
ps.executeQuery();

boolean found =
false;

while(rs.next()){

found = true;

%>

<tr>

<td>
<%=rs.getInt("id")%>
</td>

<td>
<%=rs.getString("patient_name")%>
</td>

<td>

<%

String doctorName =
rs.getString("doctor_name");

if(doctorName == null ||
doctorName.trim().equals("")){

%>

Not Assigned

<%
}
else{
%>

Dr.
<%=doctorName%>

<%
}
%>

</td>

<td>

<div class="status">

Stego Data Hidden Successfully

</div>

</td>

<td>

<a class="view-btn"

href="<%=request.getContextPath()%>/uploads/<%=rs.getString("file_name")%>"
target="_blank">

View Report

</a>

</td>

<td>

<form action="DecodeServlet"
method="post">

<input type="hidden"
name="reportId"
value="<%=rs.getInt("id")%>">

<button type="submit"
class="decrypt-btn">

Decrypt Report

</button>

</form>

</td>

<%

if(role.equalsIgnoreCase("doctor")){

%>

<td>

<div class="action-box">

<form action="ForwardReportServlet"
method="post">

<input type="hidden"
name="reportId"
value="<%=rs.getInt("id")%>">

<select name="doctorName"
required>

<option value="">

Select Doctor

</option>

<%

PreparedStatement doctorPs =
con.prepareStatement(
"select username from users where role='doctor' and username!=?");

doctorPs.setString(1,
username);

ResultSet doctorRs =
doctorPs.executeQuery();

while(doctorRs.next()){

String doctor =
doctorRs.getString("username");

%>

<option value="<%=doctor%>">

Dr. <%=doctor%>

</option>

<%
}
%>

</select>

<br>

<button type="submit"
class="forward-btn">

Forward Report

</button>

</form>

</div>

</td>

<%
}
%>

</tr>

<%
}

if(!found){

%>

<tr>

<td colspan="<%=role.equalsIgnoreCase("doctor") ? "7" : "6"%>"
class="no-data">

No Reports Found

</td>

</tr>

<%
}

con.close();

}catch(Exception e){

out.println(

"<h3 style='color:red;text-align:center;'>"

+

e.getMessage()

+

"</h3>");

e.printStackTrace();
}

%>

</table>

<br>

<div style="text-align:center;">

<%

if(role.equalsIgnoreCase("doctor")){

%>

<a href="doctor_dashboard.jsp"
class="back">

Back to Dashboard

</a>

<%
}

else if(role.equalsIgnoreCase("patient")){

%>

<a href="patient_dashboard.jsp"
class="back">

Back to Dashboard

</a>

<%
}

else{

%>

<a href="admin_dashboard.jsp"
class="back">

Back to Dashboard

</a>

<%
}
%>

</div>

</div>

</body>

</html>