<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.Model.User" %>
<!DOCTYPE html>
<html>
<head>
<title>sentdecoder - Dashboard</title>
<link rel="stylesheet" href="css/material.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/material.min.js"></script>
<script src="js/Chart.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="shortcut icon" href="icons/favicon.ico" type="image/x-icon">
<script src='js/brandjs.js'></script>
<script src='js/countryjs.js'></script>
<script src='js/hashtagjs.js'></script>
<Script src='js/productjs.js'></Script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="js/jspdf.min.js"></script>
<script type="text/javascript" src="js/html2canvas.min.js"></script>

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

else if (session.getAttribute("user")!=null){
	user = (User)session.getAttribute("user");
	checkUser = true;
}

%>

<div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-header
            mdl-layout--fixed-tabs">
  <header class="mdl-layout__header"  style="background-color:#37A1E7">
    <div class="mdl-layout__drawer-button" style="padding-top:1px;padding-left:10px;height:30px;width:20px"><i class="material-icons">dehaze</i></div>
    <div class="mdl-layout__header-row">
      <!-- Title -->
      <span class="mdl-layout-title">sentdecoder</span>
    </div>
    <!-- Tabs -->
    <div class="mdl-layout__tab-bar mdl-js-ripple-effect"  style="background-color:#37A1E7">
      <a href="#Brand" class="mdl-layout__tab is-active" style="font-size:14px"><b>Brand Analysis</b></a>
      <a href="#Product" class="mdl-layout__tab" style="font-size:14px"><b>Product Analysis</b></a>
      <a href="#Hashtag" class="mdl-layout__tab" style="font-size:14px"><b>Hashtag Analysis</b></a>
      <a href="#Country" class="mdl-layout__tab" style="font-size:14px"><b>Zonal Analysis</b></a>
    </div>
  </header>
   <div class="demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50">
    <span class="mdl-layout-title">sentdecoder</span>
    <span class="mdl-layout-title">Hi,&nbsp;<%=checkUser==true?user.getFirstname():"Someone" %></span>
     <nav class="demo-navigation mdl-navigation mdl-color--blue-grey-800">
      <a class="mdl-navigation__link" href="Dashboard.jsp" style="font-size:16px;color:white;background-color: #37A1E7"><i class="material-icons">dashboard</i>&nbsp;Dashboard</a>
      <a class="mdl-navigation__link" style="font-size:16px;color:white" href="Summary.jsp"><i class="material-icons">chrome_reader_mode</i>&nbsp;Summarizer</a>
      <a class="mdl-navigation__link" style="font-size:16px;color:white" href="Graph.jsp"><i class="material-icons">widgets</i>&nbsp;Graph</a>
      <a class="mdl-navigation__link" href="About.jsp" style="font-size:16px;color:white"><i class="material-icons">person</i>&nbsp;About</a>
      <a class="mdl-navigation__link" href="Guide.jsp" style="font-size:16px;color:white"><i class="material-icons">description</i>&nbsp;Guide</a>
      <a class="mdl-navigation__link" href="Settings.jsp" style="font-size:16px;color:white"><i class="material-icons">settings</i>&nbsp;Settings</a>
      <a class="mdl-navigation__link" href="LogoutServlet" style="font-size:16px;color:white"><i class="material-icons">exit_to_app</i>&nbsp;Logout</a>
    </nav>
  </div>
  <div class="mdl-layout__content">
  
  
  <!--DESIGN OF BRAND ANALYSIS STARTS HERE-->
    <section class="mdl-layout__tab-panel is-active" id="Brand">
      <div class="page-content">
	<div class="mdl-grid">
	  <div class="mdl-cell mdl-cell--12-col" style="text-align:center;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:100px;border:1px solid #D1D3D5">
	    
	    <div style="padding-top:100px;text-align:center">
			<div align="center"><a><span id="head">Brand </span><span id="head1">analysis</span></a></div>
	    </div>
		<div id="placement">
		<form name="search" onsubmit="return false;">
			<table style="margin:auto"><tr>
			<td><input  id="brandName" type="text" name="brand" placeholder="Enter brand i.e. google" onkeypress="return brandEnter(event)"> </td>
			<td><input id="buttonStyle" type="button" value="Analyze" name='brandAnalyze' onclick="sendInfo()"></td>
			<td><button id="reportStyle" type="button" name='reportGenBrand' onclick="generateBrandReport()"><i class="material-icons">picture_as_pdf</i></button></td></tr></table>
		</form>
	</div>	
	</div>
	</div>
	<div class="mdl-grid" id="brandCharts">
    
    </div>
      </div>
    </section>
    <!--DESIGN OF BRAND ANALYSIS ENDS HERE-->
    
    <!--DESIGN OF PRODUCT ANALYSIS STARTS HERE-->
    <section class="mdl-layout__tab-panel" id="Product">
      <div class="page-content">
      <div class="mdl-grid">
	  <div class="mdl-cell mdl-cell--12-col" style="text-align:center;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:100px;border:1px solid #D1D3D5">
	    <div style="padding-top:100px;text-align:center">
			<div align="center"><a><span id="head">Product </span><span id="head1">analysis</span></a></div>
	    </div>
		<div id="placement">
		<form name="searchProduct" onsubmit="return false;">
			<table style="margin:auto"><tr>
			<td><input  id="brandName" type="text" name="productName" placeholder="Enter product i.e. headphone" onkeypress="return productEnter(event)"> </td>
			<td><input  id="brandName" type="text" name="productBrand" value="" placeholder="Enter brand i.e. sony" onkeypress="return productEnter(event)"></td>
			<td><input id="buttonStyle" type="button" name="productAnalyze" value="Analyze" onclick="sendProduct()"></td>
			<td><button id="reportStyle" type="button" name='reportGenProduct' onclick="generateProductReport()"><i class="material-icons">picture_as_pdf</i></button></td></tr></table>
		</form>
	</div>	
	</div>
	</div>
	<div class="mdl-grid" id="productCharts">
		
	</div>
      </div>
    </section>
   <!--DESIGN OF PRODUCT ANALYSIS ENDS HERE-->
   
   <!--DESIGN OF HASHTAG ANALYSIS STARTS HERE-->
    <section class="mdl-layout__tab-panel" id="Hashtag">
     <div class="page-content">
		<div class="mdl-grid">
	  <div class="mdl-cell mdl-cell--12-col" style="text-align:center;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:100px;border:1px solid #D1D3D5">
	    <div style="padding-top:100px;text-align:center">
			<div align="center"><a><span id="head">Hashtag </span><span id="head1">analysis</span></a></div>
	    </div>
		<div id="placement">
		<form name="searchHash" onsubmit="return false;">
			<table style="margin:auto"><tr>
			<td><input id="brandName" type="text" name="hashtag" placeholder="Enter hashtag i.e. #sony" onkeypress="return hashEnter(event)"> </td>
			<td><select id="brandName" name="isStream"><option>Non-Stream</option><option>Stream</option></select></td>
			<td><input id="buttonStyle" type="button" value="Analyze" name="hashanalyze" onclick="streamClick()"></td>
			<td><button id="reportStyle" type="button" name='reportGenHash' onclick="generateHashReport()"><i class="material-icons">picture_as_pdf</i></button></td></tr></table>
		</form>
	</div>	
	</div>
	</div>
	<div class="mdl-grid" id='hashCharts'>
	  
	</div>
	</div>
    </section>
    	<!--DESIGN OF HASHTAG ANALYSIS ENDS HERE-->
    
    <!--DESIGN OF ZONAL ANALYSIS STARTS HERE-->
     <section class="mdl-layout__tab-panel" id="Country">
      <div class="page-content">
		<div class="mdl-grid">
	  	<div class="mdl-cell mdl-cell--12-col" style="text-align:center;box-shadow: 1px 1px 1px 1px #D1D3D5;padding-bottom:100px;border:1px solid #D1D3D5">
	    <div style="padding-top:100px;text-align:center">
			<div align="center"><a><span id="head">Zonal </span><span id="head1">analysis</span></a></div>
	    </div>
		<div id="placement">
		<form name="searchCountry" onsubmit="return false;">
			<table style="margin:auto"><tr>
			<td><input  id="brandName" type="text" name="brandCountry" placeholder="brand or product i.e. google" onkeypress="return countryEnter(event)"> </td>
			<td><input  id="countryName" type="text" name="countryName" placeholder="Enter country i.e. india" onkeypress="return countryEnter(event)"> </td>
			<td><input id="buttonStyle" type="button" name="countryAnalyze" value="Add" onclick="sendCountry()"></td>
			<td><button id="reportStyle" type="button" name='reportGenZone' onclick="generateZonalReport()"><i class="material-icons">picture_as_pdf</i></button></td></tr></table>
		</form>
	</div>	
	</div>
	</div>
	<div class="mdl-grid" id='countryCharts'>
	
	</div>
	</div>
    </section>
    	<!--DESIGN OF ZONAL ANALYSIS ENDS HERE-->
    	
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