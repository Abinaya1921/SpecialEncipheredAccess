<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<%
String doctor =
(String)session.getAttribute("username");

if(doctor == null){

response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Shared Reports</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

.container{
width:95%;
margin:auto;
margin-top:40px;
}

table{
width:100%;
border-collapse:collapse;
background:white;
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

a{
padding:8px 15px;
background:#28a745;
color:white;
text-decoration:none;
border-radius:5px;
}

</style>

</head>

<body>

<div class="container">

<h1 align="center">

Shared Medical Reports

</h1>

<table>

<tr>

<th>Report ID</th>

<th>Shared By</th>

<th>Patient</th>

<th>View Report</th>

<th>Decrypt</th>

</tr>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(

"SELECT r.*, s.sender_doctor FROM reports r JOIN shared_reports s ON r.id=s.report_id WHERE s.receiver_doctor=?");

ps.setString(1, doctor);

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td>
<%=rs.getInt("id")%>
</td>

<td>
Dr. <%=rs.getString("sender_doctor")%>
</td>

<td>
<%=rs.getString("patient_name")%>
</td>

<td>

<a href="<%=request.getContextPath()%>/uploads/<%=rs.getString("file_name")%>"
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

<button type="submit">

Decrypt

</button>

</form>

</td>

</tr>

<%
}

con.close();

}catch(Exception e){

e.printStackTrace();
}
%>

</table>

</div>

</body>

</html>