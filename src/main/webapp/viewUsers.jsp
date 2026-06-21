<%@page import="java.sql.*"%>

<%@page import="db.DBConnection"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>View Users</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

table{
width:90%;
margin:auto;
border-collapse:collapse;
background:white;
}

th,td{
border:1px solid black;
padding:12px;
text-align:center;
}

th{
background:#007bff;
color:white;
}

</style>

</head>

<body>

<h1 align="center">
Registered Users
</h1>

<table>

<tr>

<th>ID</th>

<th>Username</th>

<th>Role</th>

</tr>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"select * from users");

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getInt(1)%></td>

<td><%=rs.getString(2)%></td>

<td><%=rs.getString(4)%></td>

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