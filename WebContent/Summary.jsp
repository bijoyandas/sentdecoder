<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.Model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sentdecoder - Article Summarizer</title>
<link rel="stylesheet" href="css/material.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/material.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<script src="js/summaryjs.js"></script>
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
      <a class="mdl-navigation__link" style="font-size:16px;color:white;background-color: #37A1E7" href="Summary.jsp"><i class="material-icons">chrome_reader_mode</i>&nbsp;Summarizer</a>
      <a class="mdl-navigation__link" style="font-size:16px;color:white" href="Graph.jsp"><i class="material-icons">widgets</i>&nbsp;Graph</a>
      <a class="mdl-navigation__link" href="About.jsp" style="font-size:16px;color:white;"><i class="material-icons">person</i>&nbsp;About</a>
      <a class="mdl-navigation__link" href="Guide.jsp" style="font-size:16px;color:white"><i class="material-icons">description</i>&nbsp;Guide</a>
      <a class="mdl-navigation__link" href="Settings.jsp" style="font-size:16px;color:white"><i class="material-icons">settings</i>&nbsp;Settings</a>
      <a class="mdl-navigation__link" href="LogoutServlet" style="font-size:16px;color:white"><i class="material-icons">exit_to_app</i>&nbsp;Logout</a>
    </nav>
  </div>
      <div class="page-content">
	<div class="mdl-grid" style="margin-top:10px">
	  <div class="mdl-cell mdl-cell--8-col" style="text-align:center;margin:auto;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:35px;border:1px solid #D1D3D5">
	  	<div style="padding-top:100px;text-align:center">
			<div align="center"><a><span id="head" style="font-size:50px">Article </span><span id="head1" style="font-size:50px">Summary</span></a></div>
	    </div>
		<div id="placement">
			<form name="search" onsubmit="return false;">
				<table style="margin:auto"><tr>
				<td><input  id="brandName" type="text" name="article" placeholder="Enter link of an article..." onkeypress="return summaryEnter(event)"> </td>
				<td><input id="buttonStyle" type="button" value="Summarize" name='summarize' onclick="sendLink()"></td></tr></table>
			</form>
		</div>
		<div id="summaryData" style="margin-top:50px">
			
		</div>
	  </div>
	  </div>
      </div>
</div>
<!--DESIGN OF SNACKBAR STARTS HERE-->
<div id="error_snackbar" class="mdl-js-snackbar mdl-snackbar">
  <div style="background-color:#37A1E7;font-size:16px;width:90%" class="mdl-snackbar__text"></div>
  <button class="mdl-snackbar__action" style="color:white;font-size:14px"></button>
</div>
<!--DESIGN OF SNACKBAR ENDS HERE-->
</body>
</html>