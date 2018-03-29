graphEnter = function(event) {
	if (event.keyCode == 13) {
		sendGraph();
	}
}

function errorSnackBar(error) 
{
	'use strict';
	var snackbarContainer = document.querySelector('#error_snackbar');
	var showToastButton = document.querySelector('#demo-show-toast');
	'use strict';
	  var data = {
		      message: error,
		      timeout: 2000,
		      actionHandler: function(){},
		      actionText: 'OK'
		    };
	snackbarContainer.MaterialSnackbar.showSnackbar(data);
}


function sendGraph() {
	var pageName = document.search.pageName.value;
	var accessToken = document.search.accessToken.value;
	if (pageName == null || pageName=="")
		errorSnackBar('Enter a page name to analyse');
	else if (accessToken == null || accessToken == "")
		errorSnackBar('Enter your access token');
	else {
		var progress="<div class='progress' style='width:600px;margin:auto'><div class='indeterminate'></div></div>";
		document.getElementById('graphData').innerHTML=progress;
		document.search.pageName.disabled = true;
		document.search.accessToken.disabled = true;
		document.search.graphAnalyse.disabled = true;
		var url="GraphAnalyser?pageName="+encodeURIComponent(pageName)+"&accessToken="+encodeURIComponent(accessToken);  
		  
		if(window.XMLHttpRequest){  
			request=new XMLHttpRequest();  
		}  
		else if(window.ActiveXObject){  
			request=new ActiveXObject("Microsoft.XMLHTTP");  
		}  
		  
		try  
		{  
			request.onreadystatechange=getInfo;  
			request.open("GET",url,true);  
			request.send();  
		}  
		catch(e)  
		{  
			alert("Unable to connect to server");  
		}  
	}
}


function getInfo() {
	if(request.readyState==4){ 
		document.search.pageName.disabled = false;
		document.search.accessToken.disabled = false;
		document.search.graphAnalyse.disabled = false;
		var val=request.responseText;
		var posts = val.split('$$###$$');
		var messages = [];
		var sentiments = [];
		var comments = [];
		var likes = [];
		for(var i=0;i<posts.length;i++) {
			var info = posts[i].split("##$$$##");
			messages.push(info[0]);
			sentiments.push(info[1]);
			comments.push(info[2]);
			likes.push(info[3]);
		}
		var tableData = '<table class="messageTable"><tr><th>Messages</th><th>Comments</th></tr>';
		for(var i=0,j=0;i<messages.length;i++,j++) {
			if (i%2==0)
				tableData += '<tr style="background-color:#e3eff7"><td>'+ messages[i] + '</td><td>' + comments[j] + '</td></tr>';
			else
				tableData += '<tr style="background-color:#edf1f7"><td>'+ messages[i] + '</td><td>' + comments[j] + '</td></tr>';
		}
		tableData += '</table>';
		var allCharts = '<div class="mdl-grid"><div class="mdl-cell mdl-cell--12-col" style="text-align:center;margin:auto;box-shadow: 1px 1px 1px 1px #D1D3D5;border:1px solid #D1D3D5">'+tableData+'</div></div><div class="mdl-grid"><div class="mdl-cell mdl-cell--6-col" style="text-align:center;margin:auto;box-shadow: 1px 1px 1px 1px #D1D3D5;border:1px solid #D1D3D5"><canvas id="sentimentChart" width="550px" height="400px" style="margin:auto"></canvas></div><div class="mdl-cell mdl-cell--6-col" style="text-align:center;margin:auto;box-shadow: 1px 1px 1px 1px #D1D3D5;border:1px solid #D1D3D5"><canvas id="likeChart" width="550px" height="400px" style="margin:auto"></canvas></div></div>';
		document.getElementById('graphData').innerHTML=allCharts;
		sentimentPrint(sentiments);
		likePrint(likes,comments);
	}
}

function sentimentPrint(sentiments){
	var ctx = document.getElementById("sentimentChart");
	var mLabels = [];
	var colorList = [];
	for(var i=0;i<sentiments.length;i++) {
		mLabels.push((i+1).toString());
		sentiments[i] = Math.round(sentiments[i]*100);
		if(sentiments[i] >= 0) 
			colorList.push('rgba(255, 99, 132, 0.7)');
		else
			colorList.push('rgba(54, 162, 235, 0.5)');
	}
	Chart.plugins.register({
		beforeDraw: function(chartInstance) {
		var context = chartInstance.chart.ctx;
		context.fillStyle = "white";
		context.fillRect(0, 0, chartInstance.chart.width, chartInstance.chart.height);
		}
		});
	var myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: mLabels,
	        datasets: [{
	        	label: "Post Sentiment",
	            data: sentiments,
	            backgroundColor: colorList,
	        }]
	    },
	    options: {
	    	responsive:false
	    }
	});

}  


function likePrint(likes,comments){
	var ctx = document.getElementById("likeChart");
	var mLabels = [];
	for(var i=0;i<likes.length;i++) {
		mLabels.push((i+1).toString());
	}
	Chart.plugins.register({
		beforeDraw: function(chartInstance) {
		var context = chartInstance.chart.ctx;
		context.fillStyle = "white";
		context.fillRect(0, 0, chartInstance.chart.width, chartInstance.chart.height);
		}
		});
	var myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: mLabels,
	        datasets: [{
	        	label: "Post Likes",
	            data: likes,
	            backgroundColor:'rgba(206, 30, 30, 0.6)',
	        },
	        {
	        	label: "Post Comments",
	        	data: comments,
	        	backgroundColor:'rgba(10, 255, 255, 0.6)'
	        }
	        ]
	    },
	    options: {
	    	responsive:false
	    }
	});

}  
