<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Manage Users</title>

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
color:#333;
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

button{
padding:8px 15px;
border:none;
border-radius:5px;
cursor:pointer;
color:white;
}

.deleteBtn{
background:red;
}

.updateBtn{
background:green;
}

input,select{
padding:8px;
width:90%;
}

</style>

</head>

<body>

<div class="container">

<h1>Manage Users</h1>

<table>

<tr>

<th>ID</th>

<th>Username</th>

<th>Password</th>

<th>Role</th>

<th>Update</th>

<th>Delete</th>

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

<form action="UpdateUserServlet"
method="post">

<td>

<input type="hidden"
name="id"

value="<%=rs.getInt(1)%>">

<%=rs.getInt(1)%>

</td>

<td>

<input type="text"
name="username"

value="<%=rs.getString(2)%>">

</td>

<td>

<input type="text"
name="password"

value="<%=rs.getString(3)%>">

</td>

<td>

<select name="role">

<option value="patient"
<%=rs.getString(4).equals("patient")
? "selected" : ""%>>

Patient

</option>

<option value="doctor"
<%=rs.getString(4).equals("doctor")
? "selected" : ""%>>

Doctor

</option>

<option value="admin"
<%=rs.getString(4).equals("admin")
? "selected" : ""%>>

Admin

</option>

</select>

</td>

<td>

<button type="submit"
class="updateBtn">

Update

</button>

</td>

</form>

<td>

<form action="DeleteUserServlet"
method="post">

<input type="hidden"
name="id"

value="<%=rs.getInt(1)%>">

<button type="submit"
class="deleteBtn">

Delete

</button>

</form>

</td>

</tr>

<%

}

con.close();

}catch(Exception e){

out.println(e);
}
%>

</table>

</div>

</body>
</html>