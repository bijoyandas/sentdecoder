<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.Model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sentdecoder - About the application</title>
<link rel="stylesheet" href="css/material.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/material.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
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
      <a class="mdl-navigation__link" href="About.jsp" style="font-size:16px;color:white;background-color: #37A1E7"><i class="material-icons">person</i>&nbsp;About</a>
      <a class="mdl-navigation__link" href="Guide.jsp" style="font-size:16px;color:white"><i class="material-icons">description</i>&nbsp;Guide</a>
      <a class="mdl-navigation__link" href="Settings.jsp" style="font-size:16px;color:white"><i class="material-icons">settings</i>&nbsp;Settings</a>
      <a class="mdl-navigation__link" href="LogoutServlet" style="font-size:16px;color:white"><i class="material-icons">exit_to_app</i>&nbsp;Logout</a>
    </nav>
  </div>
      <div class="page-content">
	<div class="mdl-grid">
	  <div class="mdl-cell mdl-cell--8-col" style="text-align:center;margin:auto;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:35px;border:1px solid #D1D3D5">
	    <div style="padding-top:35px;text-align:center">
			<div align="center"><a href="About.jsp"><span id="head" style="font-size:32px">About</span></a></div>
	    </div>
		<div style="padding-top:30px;font-size:16px;padding-left:120px;padding-right:120px;text-align:left">
		sentdecoder is a data analytics web application that will fetch tweets from Twitter based on a 
		particular topic specially a brand and analyze the commoner's sentiment to predict the popularity 
		of that brand or any product of that brand. This will help to understand the acceptance of that brand 
		and to determine strategies for modifying product qualities based on that sentiment.<br><br>sentdecoder
		uses various graphical representations along with review based on analysis that will help the user 
		get a better view of the public sentiment and predict more efficiently. Alongside there is provision 
		for visualizing live stream of data to make better assessment and also country-based analysis to understand 
		the zonal sentiment. This has developed mainly focusing on the needs of organizations that seek to get a 
		better view of the market and improve their relationship with their customers.
		</div>
	</div></div>
      </div>
</div>
</body>
</html>