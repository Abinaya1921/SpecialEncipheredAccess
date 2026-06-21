<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>User Registration</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial, sans-serif;
}

body{

height:100vh;

display:flex;

justify-content:center;

align-items:center;

background:linear-gradient(
to right,
#4facfe,
#00f2fe);

}

.container{

width:400px;

background:white;

padding:40px;

border-radius:15px;

box-shadow:0px 0px 15px rgba(0,0,0,0.3);

text-align:center;

animation:fadeIn 1s ease;
}

@keyframes fadeIn{

from{
opacity:0;
transform:translateY(-20px);
}

to{
opacity:1;
transform:translateY(0);
}
}

h1{

margin-bottom:25px;

color:#333;
}

.input-box{

margin-bottom:20px;

text-align:left;
}

label{

font-weight:bold;

color:#555;

display:block;

margin-bottom:8px;
}

input, select{

width:100%;

padding:12px;

border:1px solid #ccc;

border-radius:8px;

font-size:15px;

outline:none;

transition:0.3s;
}

input:focus,
select:focus{

border-color:#007bff;

box-shadow:0px 0px 5px rgba(0,123,255,0.5);
}

button{

width:100%;

padding:12px;

background:#007bff;

border:none;

color:white;

font-size:16px;

border-radius:8px;

cursor:pointer;

transition:0.3s;
}

button:hover{

background:#0056b3;
}

.login-link{

margin-top:20px;

display:block;

text-decoration:none;

color:#007bff;

font-weight:bold;
}

.login-link:hover{

text-decoration:underline;
}

</style>

</head>

<body>

<div class="container">

<h1>Create Account</h1>

<form action="RegisterServlet"
method="post">

<div class="input-box">

<label>Username</label>

<input type="text"
name="username"
placeholder="Enter Username"
required>

<input type="email"
name="email"
placeholder="Enter Email"
required>

</div>

<div class="input-box">

<label>Password</label>

<input type="password"
name="password"
placeholder="Enter Password"
required>

</div>

<div class="input-box">

<label>Select Role</label>

<select name="role" required>

<option value="">-- Select Role --</option>

<option value="admin">Admin</option>

<option value="doctor">Doctor</option>

<option value="patient">Patient</option>

</select>

</div>

<button type="submit">

Register

</button>

</form>

<a href="login.jsp"
class="login-link">

Already have an account? Login

</a>

</div>

</body>

</html>