<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.Model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sentdecoder - Guide for the users</title>
<link rel="stylesheet" href="css/material.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/material.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="shortcut icon" href="icons/favicon.ico" type="image/x-icon">
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
  </header>
   <div class="demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50">
    <span class="mdl-layout-title">sentdecoder</span>
    <span class="mdl-layout-title">Hi,&nbsp;<%=checkUser==true?user.getFirstname():"Someone" %></span>
     <nav class="demo-navigation mdl-navigation mdl-color--blue-grey-800">
      <a class="mdl-navigation__link" style="font-size:16px;color:white" href="Dashboard.jsp"><i class="material-icons">dashboard</i>&nbsp;Dashboard</a>
      <a class="mdl-navigation__link" href="About.jsp" style="font-size:16px;color:white"><i class="material-icons">person</i>&nbsp;About</a>
      <a class="mdl-navigation__link" href="Guide.jsp" style="font-size:16px;color:white;background-color: #37A1E7"><i class="material-icons">description</i>&nbsp;Guide</a>
      <a class="mdl-navigation__link" href="Settings.jsp" style="font-size:16px;color:white"><i class="material-icons">settings</i>&nbsp;Settings</a>
      <a class="mdl-navigation__link" href="LogoutServlet" style="font-size:16px;color:white"><i class="material-icons">exit_to_app</i>&nbsp;Logout</a>
    </nav>
  </div>
      <div class="page-content">
	<div class="mdl-grid">
	  <div class="mdl-cell mdl-cell--10-col" style="text-align:center;margin:auto;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:35px;border:1px solid #D1D3D5">
	    <div style="padding-top:35px;text-align:center">
			<div align="center"><a href="Guide.jsp"><span id="head" style="font-size:32px">Guide </span></a></div>
	    </div>
		<div style="padding-top:30px;font-size:16px;padding-left:120px;padding-right:120px;text-align:left">
					This page will guide you how to use this web portal efficiently.
		<br><br>
		The various componenets of the application are :<br>
		<a href="#brandStart" style="text-decoration:bold;color:#37A1E7">1. Brand Analysis</a><br>
		<a href="#productStart" style="text-decoration:bold;color:#37A1E7">2. Product Analysis</a><br>
		<a href="#hashStart" style="text-decoration:bold;color:#37A1E7">3. Hastag Analysis</a><br>
		<a href="#zoneStart" style="text-decoration:bold;color:#37A1E7">4. Zonal Analysis</a>
		<br><br>
		<div id="brandStart"><b>Brand Analysis</b></div>
		<br>
		This section provides a graphical interface to help the user visualise the current sentiment or 
		public acceptance of a particular brand. This section contains three components, viz- Overall sentiment
		 analysis in a horizontal bar-chart, Overall rating of the brand, Individual tweet sentiment in vertical
		  bar-chart.
		<br><br>
		<img src="image/brandDemo.png" style="width:100%;"/>
		<br><br>
		<b><i>Steps to use :<br></i></b>
		&#8226;&nbsp; Type a particular brand-name in the text-box.<br>
		&#8226;&nbsp; Click the Analyze button.<br>
		&#8226;&nbsp; The charts will be displayed after loading ends.<br>
		<br>
		<img src="image/brandChart.png" style="width:100%;"/><br><br>
		<div id="productStart"><b>Product Analysis</b></div>
		<br>
		This section contains two graphical components for visualising the sentiments of a particular product 
		of a brand.  The 1st component contains a horizontal bar-chart for viewing the overall sentiment of the 
		product and the 2nd component has a line graph depicting the individual tweet sentiment.
		<br><br>
		<img src="image/productDemo.png" style="width:100%;"/>
		<br><br>
		<b><i>Steps to use :<br></i></b>
		&#8226;&nbsp; Type a product-name in the 1st text-box.<br>
		&#8226;&nbsp; Type a brand-name in the 2nd text-box.<br>
		&#8226;&nbsp; Click the Analyze button.<br>
		&#8226;&nbsp; The charts will be displayed after loading ends.<br>
		(Notes: If the brand-name is typed, then we suggest that the product must belong to that brand.)<br><br>
		<img src="image/productChart.png" style="width:100%;"/><br><br>
		<div id="hashStart"><b>Hashtag Analysis</b></div>
		<br>
		This section depicts two charts for visualising the stream or non-stream data of a paticular hash-tag 
		entered in the text-box. The 1st chart is a pie-chart containing the overall positive, negative and neutral
		 tweets and 2nd one is a line-chart displaying the individual tweet sentiment of the particular hash-tag. 
		 The data will get refreshed after a particular time interval depending upon the internet connection and 
		 system configuration.
		<br><br>
		<img src="image/hashDemo.png" style="width:100%;"/><br><br>
		
		<b><i>Steps to use :<br></i></b>
		&#8226;&nbsp; Type a hash-tag in the text-box. eg: #Zafin<br>
		&#8226;&nbsp; Select Stream or Non-Stream data from the combo-box.<br>
		&#8226;&nbsp; Press the Analyze button.<br>
		&#8226;&nbsp; The charts will be displayed after loading ends.<br>
		(Notes: The Streams will continue to refresh after every 1 min. If one wishes to stop the stream, press the 
		Stop button. )
		<br><br>
		<img src="image/hashChart.png" style="width:100%;"/><br><br>
		<div id="zoneStart"><b>Zonal Analysis :</b></div>
		<br>
		This section provides an interface to check the public sentiment of a particular brand in a particular zone.
		 There are two components, viz- a rating bar-chart and a line chart. The main feature of this section is that 
		 the user can compare two or more brands at a particular zone and visulaise the difference of public 
		 sentiment at that zone.
		<br><br>
		<img src="image/zoneDemo.png" style="width:100%;"/><br><br>
		
		<b><i>Steps to use:<br></i></b>
		&#8226;&nbsp; Type a particular brand name in the 1st text-box.<br>
		&#8226;&nbsp; Type a zone (i.e., country, state or city) in the 2nd text-box.<br>
		&#8226;&nbsp; Press the Analyze button.<br>
		&#8226;&nbsp; The charts will be displayed after loading ends.<br>
		&#8226;&nbsp; Once the chart is displayed, again change the brand-name or zone-name and press the 
		Add button.<br>
		<img src="image/zoneChart.png" style="width:100%;"/>
		
		</div>
	</div></div>
      </div>
</div>
</body>
</html>