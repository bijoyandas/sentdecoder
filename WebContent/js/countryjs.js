/* CODE FOR ZONAL */
var countryList= [];
var sentimentList = [];
var countryTweetList = [];
var colorList = [];  
var crequest;
var countryName;
var bZonalQuery;
var countryWithRating = [];
var doneZonalAnalyse = false;
var totalTweets = 0;
var countryInfoList = [];
var geoChartUri;

countryEnter = function(event) {
	if (event.keyCode == 13) {
		sendCountry();
	}
}  


function toTitleCase(str)
{
    var text = str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    text = text.replace(/\sAnd\s/, " and ");
    return text.replace(/\sOf\s/, " of ");
}

function sendCountry(){
	var brand = document.searchCountry.brandCountry.value;
	if (brand==null || brand=='')
		errorSnackBar('Enter a Brand or Product Name to Analyze');
	else {
		doneZonalAnalyse = false;
		bZonalQuery = brand;
		var progress="<div class='progress' style='width:600px;margin:auto'><div class='indeterminate'></div></div>";
		document.getElementById('countryCharts').innerHTML=progress;
		//document.searchCountry.brandCountry.disabled = true;
		countryName = document.searchCountry.countryName.value;
		document.searchCountry.brandCountry.disabled = true;
		document.searchCountry.countryName.disabled = true;
		document.searchCountry.countryAnalyze.disabled = true;
		countryList.push(brand+","+countryName);
		var url="CountryAnalysis?brandName="+encodeURIComponent(brand)+"&countryName="+encodeURIComponent(countryName);  
		  
		if(window.XMLHttpRequest){  
			crequest=new XMLHttpRequest();  
		}  
		else if(window.ActiveXObject){  
			crequest=new ActiveXObject("Microsoft.XMLHTTP");  
		}  
		  
		try  
		{  
			crequest.onreadystatechange=getCountry;  
			crequest.open("GET",url,true);  
			crequest.send();  
		}  
		catch(e)  
		{  
			alert("Unable to connect to server");  
		}  
	}
}
function getCountry()
{
	if(crequest.readyState==4){
		doneZonalAnalyse = true;
		document.searchCountry.brandCountry.disabled = false;
		document.searchCountry.countryName.disabled = false;
		document.searchCountry.countryAnalyze.disabled = false;
		var arr = [];
		var val=crequest.responseText; 
		var rows = val.split("<br>");
		var i,value,sum=0;
		for(i=0;i<rows.length-1;i++){
			value = parseFloat(rows[i]);
			sum+=value;
			arr.push(value);
			totalTweets += 1;
		}
		countryInfoList.push({'country':countryName,'rating':sum});
		countryTweetList.push(arr);
		sentimentList.push(sum);
		color = 'rgb('+Math.floor(255*Math.random())+','+Math.floor(255*Math.random())+','+255+')';
		var allcharts = "<div id='countryChartHolder' class='mdl-cell mdl-cell--4-col' style='text-align:center;box-shadow: 1px 1px 1px 1px #D1D3D5;border:1px solid #D1D3D5'><canvas id='countryChart' width='400px' height='400px' style='margin:auto'></canvas></div><div id='countryTweetHolder' class='mdl-cell mdl-cell--8-col' style='text-align:center;box-shadow: 1px 1px 1px 1px #D1D3D5;border:1px solid #D1D3D5'><canvas id='countryTweets' width='400px' height='400px' style='margin:auto'></canvas></div><div id='countryChartHolder' class='mdl-cell mdl-cell--12-col' style='text-align:center;box-shadow: 1px 1px 1px 1px #D1D3D5;border:1px solid #D1D3D5;text-align:center'><div id='regions_div' style='height:600px;width:100%;text-align:center'></div></div>";
		var charts = document.getElementById("countryCharts");
		charts.innerHTML = allcharts;
		colorList.push(color);
		countryPlot();
		countryTweetPlot();
		
		countryWithRating.push([toTitleCase(countryName),sum]);
		
		google.charts.load('current', {
		  'packages':['geochart'],
		  // Note: you will need to get a mapsApiKey for your project.
		  // See: https://developers.google.com/chart/interactive/docs/basic_load_libs#load-settings
		  'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
		});
		google.charts.setOnLoadCallback(drawRegionsMap);

		document.getElementById('countryCharts').scrollIntoView();
	}
}

generateZonalReport = function() {
	if (!doneZonalAnalyse)
		errorSnackBar('Please do some analysis to generate report');
	else {
		var doc = new jsPDF();
		doc.setFont('Times');
		doc.setFontSize(10);
		doc.text(5,10,"This report is generated by the sentdecoder engine for social media based predictive analysis based on your analysis query");
		doc.setFontSize(12);
		doc.setFontType("bold");
		doc.line(0, 15, 300, 15);
		doc.text(10,25,"Countries with rating: ");
		doc.setFontType("normal");
		var j = 0;
		for(var i=0;i<countryInfoList.length;i++) {
			j = 35+i*5;
			doc.text(10,j,toTitleCase(countryInfoList[i].country)+": "+Math.round(countryInfoList[i].rating));
		}
		doc.text(10,j+5,"Total tweets collected: "+totalTweets);
		var canvas1 = document.getElementById("countryChart");
		var canvas2 = document.getElementById("countryTweets");
		var data1 = canvas1.toDataURL('image/jpeg');
		var data2 = canvas2.toDataURL('image/jpeg');
		var image1 = new Image();
		var image2 = new Image();
		var image3 = new Image();
		image1.src = data1;
		image2.src = data2;
		image3.src = geoChartUri;
		doc.setFontType("bold");
		doc.text(10,j+15,"Emotions Chart");
		doc.setFontType("normal");
		doc.addImage(image1, 'JPEG', 30, j+25, 150, 110);
		doc.line(0, 280, 300, 280);
		doc.setFontSize(10);
		doc.text(5,290,"copyright @sentdecoder 2018");
		doc.addPage();
		doc.setFontSize(12);
		doc.setFontType("bold");
		doc.text(10,20,"Emotions Tweets");
		doc.setFontType("normal");
		doc.addImage(image2, 'JPEG', 10, 30, 190, 120);
		doc.line(0, 280, 300, 280);
		doc.setFontSize(10);
		doc.text(5,290,"copyright @sentdecoder 2018");
		doc.addPage();
		doc.setFontSize(12);
		doc.setFontType("bold");
		doc.text(10,20,"Geoplot");
		doc.addImage(image3, 'PNG',10,30,190,120);
		doc.setFontType("normal");
		doc.line(0, 280, 300, 280);
		doc.setFontSize(10);
		doc.text(5,290,"copyright @sentdecoder 2018");
		doc.save("zonal_report_"+Date.now());
	}
	
}

function drawRegionsMap() {
	
	var chartData = [
	      ['Country', 'Rating']
	    ];
	
	chartData.push(...countryWithRating);
	
	var	data = google.visualization.arrayToDataTable(chartData);

    
    var options = {
    	title: 'Geographical Plot of Country rating',
    	colors: ['#FF4900','#37A1E7']
    };

    var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));
    google.visualization.events.addListener(chart, 'ready', function () {
        var imgUri = chart.getImageURI();
        // do something with the image URI, like:
        geoChartUri = imgUri;
    });
    chart.draw(data, options);
}    

function countryPlot(){
	document.getElementById("countryChart").remove();
	document.getElementById('countryChartHolder').innerHTML="<canvas id='countryChart' width='400' height='400' style='margin:auto'>";
	var ctx = document.getElementById("countryChart");
	Chart.plugins.register({
		beforeDraw: function(chartInstance) {
		var context = chartInstance.chart.ctx;
		context.fillStyle = "white";
		context.fillRect(0, 0, chartInstance.chart.width, chartInstance.chart.height);
		}
		});
	var myChart = new Chart(ctx, {
	    type: 'horizontalBar',
	    data: {
	        labels: countryList,
	        datasets: [{
	        	label: 'Rating Plot',
	            data: sentimentList,
	            backgroundColor: colorList,
	            borderColor:colorList,
	            borderWidth: 1
	        }]
	    },
	    options: {
	    	responsive:false,
	        scales: {
	            xAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	});

}

function countryTweetPlot(){
	document.getElementById("countryTweets").remove();
	document.getElementById('countryTweetHolder').innerHTML="<canvas id='countryTweets' width='750px' height='400' style='margin:auto'>";
	var ctx = document.getElementById("countryTweets");
	var i;
	var set = [];
	var lbls = [];
	for(i=0;i<countryTweetList[countryList.length-1].length;i++){
		lbls.push(i+1);
	}
	for(i=0;i<countryList.length;i++){
		setObj = {
			label: countryList[i],
			borderColor: colorList[i],
            data: countryTweetList[i],
            borderWidth: 1
		}
		set.push(setObj);
	}
	var chart = new Chart(ctx, {	    
		type: 'line',
	    data: {
	        labels: lbls,
	        datasets: set
	    },

	    // Configuration options go here
	    options: {
	    	responsive:false,
	    }
	});
}
