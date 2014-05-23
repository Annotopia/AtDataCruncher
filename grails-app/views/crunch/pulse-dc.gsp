<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="secure"/>
		<title>Annotopia Pulse</title>

		<link rel="stylesheet" href="${resource(dir: 'js/dc', file: 'dc.css', plugin: 'at-data-cruncher')}" type="text/css">
		
		<script type="text/javascript" src="${resource(dir: 'js/dc', file: 'd3.js', plugin: 'at-data-cruncher')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/dc', file: 'crossfilter.js', plugin: 'at-data-cruncher')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/dc', file: 'dc.js', plugin: 'at-data-cruncher')}"></script>
		<script>

			$( document ).ready(function() {
				console.log( "Pulse page ready to roll" );
				laadNumberOfAnnotations();
				laadNumberOfAnnotationSets();
				laadNumberOfAnnotatedResources();
				laadNumberOfAnnotationByResource();
				laadNumberOfAnnotationByUser();
				laadNumberOfAnnotationByClient();
				laadNumberOfAnnotationSetsByResource();
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
					//$('#numberOfAnnotationByResource').text(results);

					var data = []
					var counters = JSON.parse(results);
					for(var i=0; i<counters.length; i++) {
						var datum = {
							Name: counters[i].resource, Spent: counters[i].counter, Year: 2015
						}
						data.push(datum);
					}

					// normalize/parse data
					data.forEach(function(d) {
					    d.Spent = d.Spent.match(/\d+/);
					});
					
					var chart = dc.rowChart("#chartNumberOfAnnotationByResource");
					// set crossfilter
					var ndx = crossfilter(data),
					    yearDim = ndx.dimension(function(d) {return +d.Year;}),
					    spendDim = ndx.dimension(function(d) {return Math.floor(d.Spent/10);}),
					    nameDim = ndx.dimension(function(d) {return d.Name;}),
					    spendPerYear = yearDim.group().reduceSum(function(d) {return +d.Spent;}),
					    spendPerName = nameDim.group().reduceSum(function(d) {return +d.Spent;}),
					    spendHist = spendDim.group().reduceCount();
					         
					chart
					    .width(700).height(500)
					    .dimension(nameDim)
					    .group(spendPerName)
					    .elasticX(true);

					chart.render();
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

					var data = []
					var counters = JSON.parse(results);
					for(var i=0; i<counters.length; i++) {
						var datum = {
							Name: counters[i].user, Spent: counters[i].counter, Year: 2015
						}
						data.push(datum);
					}

					// normalize/parse data
					data.forEach(function(d) {
					    d.Spent = d.Spent.match(/\d+/);
					});
					
					var chart = dc.rowChart("#chartNumberOfAnnotationByUser");
					// set crossfilter
					var ndx = crossfilter(data),
					    yearDim = ndx.dimension(function(d) {return +d.Year;}),
					    spendDim = ndx.dimension(function(d) {return Math.floor(d.Spent/10);}),
					    nameDim = ndx.dimension(function(d) {return d.Name;}),
					    spendPerYear = yearDim.group().reduceSum(function(d) {return +d.Spent;}),
					    spendPerName = nameDim.group().reduceSum(function(d) {return +d.Spent;}),
					    spendHist = spendDim.group().reduceCount();
					         
					chart
					    .width(700).height(500)
					    .dimension(nameDim)
					    .group(spendPerName)
					    .elasticX(true);

					chart.render();
				}).fail(function() {
					console.log( "FAILED loading number of annotation by user" );
				})
				.always(function() {
					
				});				
			}

			function laadNumberOfAnnotationByClient() {
				console.log( "Loading number of annotation by client..." );


			}

			function laadNumberOfAnnotationSetsByResource() {
				console.log( "Loading number of annotation sets by user..." );

				$.ajax({
					type: "GET",
					dataType: "text",
					url: "getNumberOfAnnotationByUser"
				}).done(function( results ) {
					console.log( "Number of annotation by user " + results);

					var data = []
					var counters = JSON.parse(results);
					for(var i=0; i<counters.length; i++) {
						var datum = {
							Name: counters[i].user, Spent: counters[i].counter, Year: 2015
						}
						data.push(datum);
					}

					// normalize/parse data
					data.forEach(function(d) {
					    d.Spent = d.Spent.match(/\d+/);
					});
					
					var chart = dc.rowChart("#chartNumberOfAnnotationSetsByResource");
					// set crossfilter
					var ndx = crossfilter(data),
					    yearDim = ndx.dimension(function(d) {return +d.Year;}),
					    spendDim = ndx.dimension(function(d) {return Math.floor(d.Spent/10);}),
					    nameDim = ndx.dimension(function(d) {return d.Name;}),
					    spendPerYear = yearDim.group().reduceSum(function(d) {return +d.Spent;}),
					    spendPerName = nameDim.group().reduceSum(function(d) {return +d.Spent;}),
					    spendHist = spendDim.group().reduceCount();
					         
					chart
					    .width(700).height(500)
					    .dimension(nameDim)
					    .group(spendPerName)
					    .elasticX(true);

					chart.render();
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
			<div id="chartNumberOfAnnotationByResource"></div>
			
			<h3 style="display: block; clear: both;">Annotations by Users</h3>
			<div id="chartNumberOfAnnotationByUser"></div>
			
			<h3 style="display: block; clear: both;">Annotation Sets by Resource</h3>
			<div id="chartNumberOfAnnotationSetsByResource"></div>
			
			<%-- 
			<h3 style="display: block; clear: both;"> Annotations by Client</h3>
			<div id="numberOfAnnotationByClient"></div>
			--%>
		</div>
	</body>
</html>