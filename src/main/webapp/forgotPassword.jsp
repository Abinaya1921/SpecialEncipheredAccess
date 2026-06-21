<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Forgot Password</title>

<style>

body{
font-family:Arial;
background:linear-gradient(to right,#4facfe,#00f2fe);
margin:0;
padding:0;
}

.container{
width:400px;
margin:auto;
margin-top:100px;
background:white;
padding:40px;
border-radius:10px;
box-shadow:0px 0px 10px rgba(0,0,0,0.2);
}

h2{
text-align:center;
margin-bottom:30px;
}

input{
width:100%;
padding:12px;
margin-top:10px;
margin-bottom:20px;
border:1px solid #ccc;
border-radius:5px;
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

a{
display:block;
text-align:center;
margin-top:20px;
text-decoration:none;
}

</style>

</head>

<body>

<div class="container">

<h2>Forgot Password</h2>

<form action="ForgotPasswordServlet"
method="post">

<input type="text"
name="username"
placeholder="Enter Username"
required>

<input type="password"
name="newPassword"
placeholder="Enter New Password"
required>

<button type="submit">

Reset Password

</button>

</form>

<a href="login.jsp">

Back to Login

</a>

</div>

</body>

</html>