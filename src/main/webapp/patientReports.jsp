<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>My Reports</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

table{
width:95%;
margin:auto;
border-collapse:collapse;
background:white;
margin-top:40px;
}

th,td{
border:1px solid black;
padding:12px;
text-align:center;
}

th{
background:#28a745;
color:white;
}

h1{
text-align:center;
margin-top:30px;
}

a{
text-decoration:none;
color:blue;
font-weight:bold;
}

</style>

</head>

<body>

<h1>My Uploaded Reports</h1>

<table>

<tr>

<th>ID</th>

<th>Encrypted Text</th>

<th>View Report</th>

</tr>

<%

String username =

(String)session.getAttribute("username");

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(

"select * from reports where patient_name=?");

ps.setString(1, username);

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getInt(1)%></td>

<td><%=rs.getString(4)%></td>

<td>

<a href="uploads/<%=rs.getString("file_name")%>"
target="_blank">

View My Report

</a>

</td>

</tr>

<%
}

}catch(Exception e){

e.printStackTrace();
}
%>

</table>

</body>
</html>