<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Search Patient</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
text-align:center;
}

.container{
margin-top:100px;
}

input{
padding:10px;
width:250px;
}

button{
padding:10px 20px;
background:#007bff;
color:white;
border:none;
}

</style>

</head>

<body>

<div class="container">

<h1>Search Patient Reports</h1>

<form action="SearchServlet"
method="post">

<input type="text"
name="patient"
placeholder="Enter Patient Name">

<br><br>

<button type="submit">

Search

</button>

</form>

</div>

</body>
</html>