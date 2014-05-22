<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="secure"/>
		<title>Annotopia Pulse</title>
		
		
		<script type="text/javascript" src="${resource(dir: 'js/chart', file: 'Chart.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/amcharts', file: 'amcharts.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/amcharts', file: 'serial.js')}"></script>
		<script>

		var chart;
		
		var chartData = [
		    {
		        "year": 2005,
		        "income": 23.5
		    },
		    {
		        "year": 2006,
		        "income": 26.2
		    },
		    {
		        "year": 2007,
		        "income": 30.1
		    },
		    {
		        "year": 2008,
		        "income": 29.5
		    },
		    {
		        "year": 2009,
		        "income": 24.6
		    }
		];

		AmCharts.ready(function () {
		    // SERIAL CHART
		    
		});

			$( document ).ready(function() {
				console.log( "Pulse page ready to roll" );
				laadNumberOfAnnotations();
				laadNumberOfAnnotationSets();
				laadNumberOfAnnotatedResources();
				laadNumberOfAnnotationByResource();
				laadNumberOfAnnotationByUser();
			});

			function laadNumberOfAnnotations() {
				console.log( "Loading number of annotations..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotations"
				}).done(function( data ) {
					console.log( "Number of annotations " + data);
					$('#numberOfAnnotations').text(data);
				}).fail(function() {
					console.log( "FAILED loading number of annotations" );
				})
				.always(function() {
					
				});	
			}

			function laadNumberOfAnnotationSets() {
				console.log( "Loading number of annotation sets..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotationSets"
				}).done(function( data ) {
					console.log( "Number of annotation sets " + data);
					$('#numberOfAnnotationSets').text(data);
				}).fail(function() {
					console.log( "FAILED loading number of annotations" );
				})
				.always(function() {
					
				});				
			}

			function laadNumberOfAnnotatedResources() {
				console.log( "Loading number of annotated resources..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotatedResources"
				}).done(function( data ) {
					console.log( "Number of annotated resources " + data);
					$('#numberOfAnnotatedResources').text(data);
				}).fail(function() {
					console.log( "FAILED loading number of annotations" );
				})
				.always(function() {
					
				});				
			}

			function laadNumberOfAnnotationByResource() {
				console.log( "Loading number of annotation by resource..." );

				$.ajax({
					type: "GET",
					dataType: "text",
					url: "getNumberOfAnnotationByResource"
				}).done(function( results ) {
					console.log( "Number of annotation by resource " + results);
					$('#numberOfAnnotationByResource').text(results);

					var labels = []
					var dataset = []
					
					var counters = JSON.parse(results);
					for(var i=0; i<counters.length; i++) {
						console.log('yolo: ' + counters[i]);
						labels[i] = counters[i].resource
						dataset[i] = counters[i].counter
					}
					
<%--					var options = {scaleStartValue: 0, scaleStepWidth:1, scaleOverlay:true}--%>
<%--					var data = {--%>
<%--						labels : labels,--%>
<%--						datasets : [--%>
<%--							{--%>
<%--								fillColor : "rgba(220,220,220,0.5)",--%>
<%--								strokeColor : "rgba(220,220,220,1)",--%>
<%--								data : dataset--%>
<%--							}--%>
<%--							/*,--%>
<%--							{--%>
<%--								fillColor : "rgba(151,187,205,0.5)",--%>
<%--								strokeColor : "rgba(151,187,205,1)",--%>
<%--								data : dataset--%>
<%--							}--%>
<%--							*/--%>
<%--						]--%>
<%--					}--%>
<%--					--%>
<%--					//Get context with jQuery - using jQuery's .get() method.--%>
<%--					var ctx = $("#chartNumberOfAnnotationByResource").get(0).getContext("2d");--%>
<%--					new Chart(ctx).Bar(data, options);--%>

					chart = new AmCharts.AmSerialChart();
					chart.dataProvider = chartData;
					chart.categoryField = "year";
					// this single line makes the chart a bar chart,
					// try to set it to false - your bars will turn to columns
					chart.rotate = true;
					// the following two lines makes chart 3D
					chart.depth3D = 20;
					chart.angle = 30;
					
					// AXES
					// Category
					var categoryAxis = chart.categoryAxis;
					categoryAxis.gridPosition = "start";
					categoryAxis.axisColor = "#DADADA";
					categoryAxis.fillAlpha = 1;
					categoryAxis.gridAlpha = 0;
					categoryAxis.fillColor = "#FAFAFA";
					
					// value
					var valueAxis = new AmCharts.ValueAxis();
					valueAxis.axisColor = "#DADADA";
					valueAxis.title = "Income in millions, USD";
					valueAxis.gridAlpha = 0.1;
					chart.addValueAxis(valueAxis);
					
					// GRAPH
					var graph = new AmCharts.AmGraph();
					graph.title = "Income";
					graph.valueField = "income";
					graph.type = "column";
					graph.balloonText = "Income in [[category]]:[[value]]";
					graph.lineAlpha = 0;
					graph.fillColors = "#ccc";
					graph.fillAlphas = 1;
					chart.addGraph(graph);
					
					chart.creditsPosition = "top-right";
					
					// WRITE
					chart.write("chartdiv");

				}).fail(function() {
					console.log( "FAILED loading number of annotation by resource" );
				})
				.always(function() {
					
				});				
			}

			function laadNumberOfAnnotationByUser() {
				console.log( "Loading number of annotation by user..." );

				$.ajax({
					type: "GET",
					dataType: "text",
					url: "getNumberOfAnnotationByUser"
				}).done(function( results ) {
					console.log( "Number of annotation by user " + results);
					$('#numberOfAnnotationByUser').text(results);

					var labels = []
					var dataset = []
					
					var counters = JSON.parse(results);
					for(var i=0; i<counters.length; i++) {
						console.log('yolo: ' + counters[i]);
						labels[i] = counters[i].user
						dataset[i] = counters[i].counter
					}
					
					var options = {scaleStartValue: 0, scaleStepWidth:1, scaleOverlay:true}
					var data = {
						labels : labels,
						datasets : [
							{
								fillColor : "rgba(220,220,220,0.5)",
								strokeColor : "rgba(220,220,220,1)",
								data : dataset
							}
							/*,
							{
								fillColor : "rgba(151,187,205,0.5)",
								strokeColor : "rgba(151,187,205,1)",
								data : dataset
							}
							*/
						]
					}
					
					//Get context with jQuery - using jQuery's .get() method.
					var ctx = $("#chartNumberOfAnnotationByUser").get(0).getContext("2d");
					new Chart(ctx).Bar(data, options);
				}).fail(function() {
					console.log( "FAILED loading number of annotation by user" );
				})
				.always(function() {
					
				});				
			}
		</script>
	</head>
	<body>
		<div class="container">
			<h3>Annotopia Hub Counters</h3>
			<table class="pinterest">
				<tr>
					<td style="width: 220px;">Number of Annotations</td>
					<td><div id="numberOfAnnotations"></div></td>
				</tr>
				<tr>
					<td>Number of Annotation Sets</td>
					<td><div id="numberOfAnnotationSets"></div></td>
				</tr>
				<tr>
					<td>Annotated resources</td>
					<td><div id="numberOfAnnotatedResources"></div></td>
				</tr>
			</table>
			
			<h3>Annotations by Resource</h3>
			<div id="numberOfAnnotationByResource"></div>
<%--			<canvas id="chartNumberOfAnnotationByResource" width="400" height="600"></canvas>--%>
			 <div id="chartdiv" style="width: 500px; height: 600px;"></div>
			
			<h3>Annotations by Users</h3>
			<div id="numberOfAnnotationByUser"></div>
			<canvas id="chartNumberOfAnnotationByUser" width="400" height="600"></canvas>
			
			<h3>Annotations by Client</h3>
			<div id="numberOfAnnotationByClient"></div>
		</div>
	</body>
</html>