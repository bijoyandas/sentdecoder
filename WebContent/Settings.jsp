<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.Model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sentdecoder - Account Settings</title>
<link rel="stylesheet" href="css/material.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/material.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">

<script type="text/javascript">

$(document).ready(function() { 
	var url_string = window.location.href;
	var url = new URL(url_string);
	var m = url.searchParams.get("m");
	if (m != null) {
		document.getElementById("problemTextUpdate").innerHTML = m;
  }
});

updateEnter = function(event) {
	if (event.keyCode == 13) {
		checkUpdate();
	}
}

checkUpdate = function() {
	var password1 = document.getElementById("updatePassField1").value;
	var password2 = document.getElementById("updatePassField2").value;
	var fname = document.getElementById("updateFirstNameField").value;
	var lname = document.getElementById("updateLastNameField").value;
	var company = document.getElementById("updateCompanyField").value;
	var emailregex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/ig;
	
	if (password1 === null || password1 === "" || password2 === null || password2 === "") {
		document.getElementById("problemTextUpdate").innerHTML = "*Please enter your password";
		document.getElementById("updatePassField1").focus();
		return;
	}
	if (password1 !== password2) {
		document.getElementById("problemTextUpdate").innerHTML = "*Passwords do not match";
		document.getElementById("updatePassField2").focus();
		return;
	}
	if (fname === "" || fname === null) {
		document.getElementById("problemTextUpdate").innerHTML = "*Please enter your first name";
		document.getElementById("updateFirstNameField").focus();
		return;
	}
	if (lname === "" || lname === null) {
		document.getElementById("problemTextUpdate").innerHTML = "*Please enter your last name";
		document.getElementById("updateLastNameField").focus();
		return;
	}
	if (company === "" || company === null) {
		document.getElementById("problemTextUpdate").innerHTML = "*Please enter company name";
		document.getElementById("updateCompanyField").focus();
		return;
	}
	document.getElementById("updationForm").submit();
	
}

</script>


</head>
<body>

<%

User user = null;
boolean checkUser = false;

response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if (session.getAttribute("user")==null) {
	response.sendRedirect("index.jsp");
}


if (session.getAttribute("user")!=null){
	user = (User)session.getAttribute("user");
	checkUser = true;
}


%>


<!-- Simple header with fixed tabs. -->
<div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-header
            mdl-layout--fixed-tabs">
  <header class="mdl-layout__header"  style="background-color:#37A1E7">
    <div class="mdl-layout__drawer-button" style="padding-top:1px;padding-left:10px;height:30px;width:20px"><i class="material-icons">dehaze</i></div>
    <div class="mdl-layout__header-row">
      <!-- Title -->
      <span class="mdl-layout-title">sentdecoder</span>
    </div>
    <!-- Tabs -->
  </header>
   <div class="demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50">
    <span class="mdl-layout-title">sentdecoder</span>
    <span class="mdl-layout-title">Hi,&nbsp;<%=checkUser==true?user.getFirstname():"Someone" %></span>
     <nav class="demo-navigation mdl-navigation mdl-color--blue-grey-800">
      <a class="mdl-navigation__link" style="font-size:16px;color:white" href="Dashboard.jsp"><i class="material-icons">dashboard</i>&nbsp;Dashboard</a>
      <a class="mdl-navigation__link" href="About.jsp" style="font-size:16px;color:white"><i class="material-icons">person</i>&nbsp;About</a>
      <a class="mdl-navigation__link" href="Guide.jsp" style="font-size:16px;color:white"><i class="material-icons">description</i>&nbsp;Guide</a>
      <a class="mdl-navigation__link" href="Settings.jsp" style="font-size:16px;color:white;background-color: #37A1E7"><i class="material-icons">settings</i>&nbsp;Settings</a>
      <a class="mdl-navigation__link" href="LogoutServlet" style="font-size:16px;color:white"><i class="material-icons">exit_to_app</i>&nbsp;Logout</a>
    </nav>
  </div>
      <div class="page-content" style="margin-top:36px">
	<div class="mdl-grid">
	  <div class="mdl-cell mdl-cell--8-col" style="text-align:center;margin:auto;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:35px;border:1px solid #D1D3D5">
	    <div style="padding-top:35px;text-align:center">
			<div align="center"><a href="Settings.jsp"><span id="head" style="font-size:32px">Account Settings</span></a></div>
	    </div>
		<div style="padding-top:30px;font-size:14px;padding-left:120px;padding-right:120px;text-align:center">
			
			<form name="updationForm" method="post" action="UpdateCredentials" id="updationForm">
          	  <div style="width:100%;text-align:center;padding-top:10px;color:red" id="problemTextUpdate"></div>
		      <div style="width:100%;text-align:center;padding-top:5px">
		        <input type="text" name="firstname" id="updateFirstNameField" onkeypress="return updateEnter(event)" placeholder="Enter your first name" value="<%=checkUser==true?user.getFirstname():"Unknown"%>" style="width:240px;font-size:18px;font-family:verdana;padding:8px;border:1px solid #37A1E7;margin:5px;border-radius:3px"/>
		      </div>
		      <div style="width:100%;text-align:center;padding-top:5px">
		        <input type="text" name="lastname" id="updateLastNameField" onkeypress="return updateEnter(event)" placeholder="Enter your last name" value="<%=checkUser==true?user.getLastname():"Unknown"%>" style="width:240px; font-size:18px;font-family:verdana;padding:8px;border:1px solid #37A1E7;margin:5px;border-radius:3px"/>
		      </div>
		      <div style="width:100%;text-align:center;padding-top:5px">
		        <input type="text" name="company" id="updateCompanyField" onkeypress="return updateEnter(event)" placeholder="Enter company name" value="<%=checkUser==true?user.getCompany():"Unknown"%>" style="width:240px; font-size:18px;font-family:verdana;padding:8px;border:1px solid #37A1E7;margin:5px;border-radius:3px"/>
		      </div>
		      <div style="width:100%;text-align:center;padding-top:5px">
		        <input type="password" name="password" id="updatePassField1" onkeypress="return updateEnter(event)" placeholder="Enter your new password" style="width:240px; font-size:18px;font-family:verdana;padding:8px;border:1px solid #37A1E7;margin:5px;border-radius:3px"/>
		      </div>
		      <div style="width:100%;text-align:center;padding-top:5px">
		        <input type="password" name="password" id="updatePassField2" onkeypress="return updateEnter(event)" placeholder="Enter your password again" style="width:240px; font-size:18px;font-family:verdana;padding:8px;border:1px solid #37A1E7;margin:5px;border-radius:3px"/>
		      </div>
		      <div style="width:100%;text-align:center;padding-top:10px">
		      <button type="button" id="updateButton" onclick="checkUpdate();" style="background-color:#37A1E7;">Update Information</button>
		      </div>
  			</form>	
			
		</div>
	</div></div>
      </div>
</div>
</body>
</html>