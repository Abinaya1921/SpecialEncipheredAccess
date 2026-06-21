<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>System Logs</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
margin:0;
padding:0;
}

.container{
width:90%;
margin:auto;
margin-top:40px;
}

h1{
text-align:center;
margin-bottom:30px;
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

</style>

</head>

<body>

<div class="container">

<h1>Activity Logs</h1>

<table>

<tr>

<th>ID</th>

<th>Username</th>

<th>Activity</th>

<th>Time</th>

</tr>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"select * from logs order by id desc");

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
<%=rs.getString(3)%>
</td>

<td>
<%=rs.getTimestamp(4)%>
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