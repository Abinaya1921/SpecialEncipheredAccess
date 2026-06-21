<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>
body{
font-family:Arial;
background:linear-gradient(to right,#8360c3,#2ebf91);
display:flex;
justify-content:center;
align-items:center;
height:100vh;
margin:0;
}
.container{
background:white;
padding:40px;
border-radius:10px;
width:350px;
text-align:center;
}

input{
width:100%;
padding:10px;
margin:10px 0;
}

button{
background:#007bff;
color:white;
padding:10px 20px;
border:none;
width:100%;
}
</style>
</head>

<body>

<div class="container">

<h2>Medical Report Security System</h2>

<form action="LoginServlet" method="post">

<input type="text" name="username"
placeholder="Username" required>

<input type="password" name="password"
placeholder="Password" required>
<button type="submit">Login</button>

</form>

<br>

<a href="forgotPassword.jsp">

Forgot Password?

</a>

<br>

<a href="register.jsp">New User Register</a>

</div>

</body>
</html>