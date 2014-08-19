<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="secure"/>
		<title>Annotopia Pulse</title>
		
		<script type="text/javascript" src="${resource(dir: 'js/d3js', file: 'd3.min.js')}"></script>
		
		<script>

			$( document ).ready(function() {
				console.log( "Pulse page ready to roll" );
				laadNumberOfAnnotations();
				laadNumberOfAnnotationSets();
				laadNumberOfAnnotatedResources();
				laadNumberOfAnnotationByResource();
				laadNumberOfAnnotationByUser();
				//laadNumberOfAnnotationSetsByResource();
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
				});				
			}

			function laadNumberOfAnnotationByResource() {
				console.log( "Loading number of annotation by resource..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotationByResource"
				}).done(function( data ) {
					console.log( "Number of annotation by resource " + data);

					var counter=0;
					var annotationsByTypes = new Array();
					data.forEach(function(d) {
						var a = {};
						a["label"] = d.resource;
						a["value"] = d.counter;
						a["color"] = color(counter);
						annotationsByTypes[counter] = a;
					    counter++;
					});
					
					drawBars("#annotationByResourceBars", annotationsByTypes);
				}).fail(function() {
					console.log( "FAILED loading number of annotation by resource" );
				});				
			}

			function laadNumberOfAnnotationByUser() {
				console.log( "Loading number of annotation by user..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotationByUser"
				}).done(function( data ) {
					console.log( "Number of annotation by user " + data);

					var counter=0;
					var annotationsByTypes = new Array();
					data.forEach(function(d) {
						var a = {};
						a["label"] = d.user;
						a["value"] = d.counter;
						a["color"] = color(counter);
						annotationsByTypes[counter] = a;
					    counter++;
					});
					
					drawBars("#annotationByUserBars", annotationsByTypes);
				}).fail(function() {
					console.log( "FAILED loading number of annotation by resource" );
				});			
			}

			var color = d3.scale.category20();

			function drawBars(id, data) {
				var indices = d3.range(0, data.length);   

				var labels = new Array();
				var values = new Array();
				data.forEach(function(d) {
					labels.push(d.label);
					values.push(parseInt(d.value));
				});

				var chart,
			      	width = 400,
			      	bar_height = 30,
			      	height = bar_height * data.length;
				
				 var x, y;

				 x = d3.scale.linear()
				     .domain([0, d3.max(values)])
				     .range([0, width]);
				 
				 y = d3.scale.ordinal()
				    .domain(indices)
				    .rangeBands([0, height]);
				    
				 var left_width = 400;
				 
				 chart = d3.select($(id)[0])
				    .append('svg')
				    .attr('class', 'chart')
				    .attr('width', left_width + width)
				    .attr('height', height);
 
				 chart.selectAll("rect")
				    .data(values)
				    .enter().append("rect")
				    .attr("x", left_width)
				    .attr("y", function (value, index) { 
				        // use the index as input instead of value; y(index) instead of y(value)
				        return y(index); 
				    })
				    .attr("width", x)
				    .attr("height", y.rangeBand())
				    .style("fill", function(d, i) { return color(i); });

				  chart.selectAll("text.score")
				    .data(values)
				    .enter().append("text")
				    .attr("x", function(d) { return x(d) + left_width; })
				    .attr("y", function(d, i) { return y(i) + y.rangeBand()/2; } )
				    .attr("dx", -5)
				    .attr("dy", ".36em")
				    .attr("text-anchor", "end")
				    .attr('class', 'score')
				    .text(String);
 
				  chart.selectAll("text.name")
				    .data(labels)
				    .enter().append("text")
				    .attr("x", 4)
				    .attr("y", function(d){ return y(d) + y.rangeBand()/2; } )
				    .attr("dy", ".36em")
				    .attr("text-anchor", "left")
				    .attr('class', 'name')
				    .text(String);
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
			<br/>
			<table class="statistics">
				<tr>
					<td colspan="3"><span style="font-weight: bold; font-size: 18px;">Annotations Distribution by Resource</span></td>
				</tr>	
				<tr>
					<td style="width: 400px; vertical-align: top; padding-top:30px;">
						<div id="annotationByResourceBars"></div>
					</td>
				</tr>
			</table>
			<br/>
			<table class="statistics">
				<tr>
					<td colspan="3"><span style="font-weight: bold; font-size: 18px;">Annotations Distribution by User</span></td>
				</tr>	
				<tr>
					<td style="width: 400px; vertical-align: top; padding-top:30px;">
						<div id="annotationByUserBars"></div>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>