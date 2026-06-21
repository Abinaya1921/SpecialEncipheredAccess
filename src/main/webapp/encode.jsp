<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("username")==null){

response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Encode Medical Report</title>

<style>

body{

font-family:Arial;

background:#f2f2f2;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

margin:0;
}

.container{

background:white;

padding:40px;

width:550px;

border-radius:15px;

box-shadow:0 4px 15px rgba(0,0,0,0.2);
}

h1{

text-align:center;

color:#333;

margin-bottom:30px;
}

label{

font-weight:bold;

display:block;

margin-top:15px;

color:#444;
}

input[type=text],
textarea,
input[type=file],
select{

width:100%;

padding:12px;

margin-top:8px;

border:1px solid #ccc;

border-radius:8px;

box-sizing:border-box;

font-size:14px;
}

textarea{

resize:none;
}

button{

width:100%;

padding:14px;

margin-top:25px;

background:#007bff;

color:white;

border:none;

border-radius:8px;

font-size:16px;

cursor:pointer;

transition:0.3s;
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

font-weight:bold;
}

.info{

background:#e9f5ff;

padding:12px;

border-radius:8px;

margin-bottom:20px;

color:#333;

font-size:14px;

line-height:24px;
}

</style>

</head>

<body>

<div class="container">

<h1>Encode Medical Report</h1>



<form action="EncodeServlet"

method="post"

enctype="multipart/form-data">

<label>Patient Name</label>

<input type="text"

name="patient"

value="<%=session.getAttribute("username")%>"

readonly>

<label>Select Doctor</label>

<select name="doctor" required>

<option value="">

-- Select Doctor --

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

String doctorName =
rs.getString("username");

%>

<option value="<%=doctorName%>">

Dr. <%=doctorName%>

</option>

<%

}

con.close();

}catch(Exception e){

e.printStackTrace();
}
%>

</select>

<label>Secret Medical Message</label>

<textarea name="message"

rows="5"

placeholder="Enter sensitive medical information..."

required></textarea>

<label>Upload Medical Report</label>

<input type="file"

name="reportFile"

required>

<button type="submit">

Encrypt & Upload Report

</button>

</form>

<a class="back"

href="patient_dashboard.jsp">

Back to Dashboard

</a>

</div>

</body>

</html>