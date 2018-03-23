<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Welcome to sentdecoder - The free online tool for brand based predictive analysis</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="js/material.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" media="screen" href="css/style2.css">
<script type="text/javascript">

$(document).ready(function() { 
	var url_string = window.location.href;
	var url = new URL(url_string);
	var m = url.searchParams.get("m");
	if (m != null) {
		document.getElementById("message").innerHTML = m;
  }
});

loginEnter = function(event) {
	if (event.keyCode == 13) {
		checkLogIn();
	}
}

registerEnter = function(event) {
	if (event.keyCode == 13) {
		checkReg();
	}
}

checkLogIn = function() {
	var email = document.getElementById("emailField").value;
	var password = document.getElementById("passField").value;
	var emailregex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/ig;
	
	if ((!emailregex.test(email)) || email === "" || email === null) {
		document.getElementById("problemTextLog").innerHTML = "*Please enter a valid email address";
		document.getElementById("emailField").focus();
		return;
	}
	if (password === null || password === "") {
		document.getElementById("problemTextLog").innerHTML = "*Please enter your password";
		document.getElementById("passField").focus();
		return;
	}
	document.getElementById("loginForm").submit();
	
}

checkReg = function() {
	var email = document.getElementById("regEmailField").value;
	var password1 = document.getElementById("regPassField1").value;
	var password2 = document.getElementById("regPassField2").value;
	var fname = document.getElementById("regFirstNameField").value;
	var lname = document.getElementById("regLastNameField").value;
	var company = document.getElementById("regCompanyField").value;
	var emailregex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/ig;
	
	if ((!emailregex.test(email)) || email === "" || email === null) {
		document.getElementById("problemTextReg").innerHTML = "*Please enter a valid email address";
		document.getElementById("regEmailField").focus();
		return;
	}
	if (password1 === null || password1 === "" || password2 === null || password2 === "") {
		document.getElementById("problemTextReg").innerHTML = "*Please enter your password";
		document.getElementById("regPassField1").focus();
		return;
	}
	if (password1 !== password2) {
		document.getElementById("problemTextReg").innerHTML = "*Passwords do not match";
		document.getElementById("regPassField2").focus();
		return;
	}
	if (fname === "" || fname === null) {
		document.getElementById("problemTextReg").innerHTML = "*Please enter your first name";
		document.getElementById("regFirstNameField").focus();
		return;
	}
	if (lname === "" || lname === null) {
		document.getElementById("problemTextReg").innerHTML = "*Please enter your last name";
		document.getElementById("regLastNameField").focus();
		return;
	}
	if (company === "" || company === null) {
		document.getElementById("problemTextReg").innerHTML = "*Please enter company name";
		document.getElementById("regCompanyField").focus();
		return;
	}
	document.getElementById("registrationForm").submit();
	
}

</script>
</head>
<body>

<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if (request.getSession().getAttribute("user") != null) {
	response.sendRedirect("Dashboard.jsp");
}
%>

<!-- particles.js container -->
<div id="particles-js" style="height:100%;width:100%"></div>


<div class="container" style="-moz-box-shadow: 0 0 3px #000;-webkit-box-shadow: 0 0 3px #000;box-shadow: 0 0 3px #000;
							position:absolute;width:420px;background-color:white;height:260px;text-align:center;
							margin-top:200px;margin-left:450px;">
  <p id="message" style="font-family:Verdana;font-size:14px;color:red"></p>
  <div style="padding-top:10px;text-align:center">
	<div align="center"><a style="text-decoration:none"><span id="head">sent</span><span id="head1">decoder</span></a></div>
  </div><br>
  <p style="font-family:Verdana;font-size:16px">A live stream sentiment prediction Engine</p>
  <br>
  <!-- Model buttons -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#registerModal" style="padding:10px;background-color:#37A1E7;width:210px">Create Account</button><br>
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#loginModal" style="background-color:#37A1E7;width:210px;margin-top:5px;margin-left:1px">Already have Account</button>
  <!-- All Modals -->
  
  <br>
  
  <div class="modal fade" id="loginModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" style="font-family:Verdana;font-size:16px">Enter your credentials</h4>
        </div>
        <div class="modal-body">
          	<form name="loginForm" method="post" action="CheckCredentials" id="loginForm">
          	  <div style="width:100%;text-align:left;padding-top:10px;color:red" id="problemTextLog"></div>
		      <div style="width:100%;text-align:left;padding-top:20px">
		      	<label for="emailField" style="font-family:Verdana;font-size:16px">Email</label>
		        <input type="text" name="email" id="emailField" placeholder="Enter your email" onkeypress="return loginEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:left;padding-top:10px">
		        <label for="passField" style="font-family:Verdana;font-size:16px">Password</label>
		        <input type="password" name="password" id="passField" placeholder="Enter your password" onkeypress="return loginEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:center;padding-top:20px">
		      <button type="button" class="btn btn-info btn-lg" onclick="checkLogIn();" style="background-color:#37A1E7;">Login</button>
		      </div>
  			</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  
  
  <div class="modal fade" id="registerModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" style="font-family:Verdana;font-size:16px">Enter your credentials</h4>
        </div>
        <div class="modal-body">
          	<form name="registrationForm" method="post" action="RegisterCredentials" id="registrationForm">
          	  <div style="width:100%;text-align:left;padding-top:10px;color:red" id="problemTextReg"></div>
		      <div style="width:100%;text-align:left;padding-top:10px">
		        <input type="text" name="email" id="regEmailField" placeholder="Enter your email" onkeypress="return registerEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:left;padding-top:5px">
		        <input type="text" name="firstname" id="regFirstNameField" placeholder="Enter your first name" onkeypress="return registerEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:left;padding-top:5px">
		        <input type="text" name="lastname" id="regLastNameField" placeholder="Enter your last name" onkeypress="return registerEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:left;padding-top:5px">
		        <input type="text" name="company" id="regCompanyField" placeholder="Enter company name" onkeypress="return registerEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:left;padding-top:5px">
		        <input type="password" name="password" id="regPassField1" placeholder="Enter your password" onkeypress="return registerEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:left;padding-top:5px">
		        <input type="password" name="password" id="regPassField2" placeholder="Enter your password again" onkeypress="return registerEnter(event);" style="font-size:16px;font-family:verdana;padding:8px;border:1px solid #37A1E7"/>
		      </div>
		      <div style="width:100%;text-align:center;padding-top:10px">
		      <button type="button" class="btn btn-info btn-lg" onclick="checkReg();" style="background-color:#37A1E7;">Create Account</button>
		      </div>
  			</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  
  
</div>
<!-- scripts -->
<script src="js/particles.js"></script>
<script src="js/app.js"></script>


</body>
</html>
