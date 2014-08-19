<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="secure"/>
		<title>Annotopia Statistics</title>
		
		<style type="text/css">
			path.slice{
				stroke-width:2px;
			}
			polyline{
				opacity: .3;
				stroke: black;
				stroke-width: 2px;
				fill: none;
			} 
			svg text.percent{
				fill:white;
				text-anchor:middle;
				font-size:12px;
			}
			
			h2 {
			  font-size: .8em;
			  margin-left: 10px;
			}
			.chart {
			  background: #fff;
			  margin: 5px;
			}
			 
			.chart rect {
			  stroke: white;
			  fill: steelblue;
			}
			 
			.chart text {
			  fill: white;
			}
			 
			.chart text.name {
			  fill: #000;
			}
			 
			.chart line {
			  stroke: #c1c1c1;
			}
			 
			.chart .rule {
			  fill: #000;
			}
			 
			/* removed the while stroke as we don't need it anymore */
			#annotationsByClientBars .chart rect {
			  stroke: none;
			}
			 
			/* a bit of hovering effect for each bar */
			#annotationsByClientBars .chart rect:hover {
			  fill: #64707D;
			} 
		</style>
		
		<script type="text/javascript" src="${resource(dir: 'js/d3js', file: 'd3.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/d3js', file: 'donut3D.js')}"></script>
		
	</head>
	<body>
		<div class="container">
			<table class="statistics">
				<tr>
					<td colspan="3"><span style="font-weight: bold; font-size: 18px;">Annotations Distribution by Motivation</span></td>
				</tr>	
				<tr>
					<td style="width: 400px; vertical-align: top; padding-top:30px;">
						<div id="annotationsTypeBars"></div>
					</td>					
					<td>
						<div id="annotationsByTypeChart"></div>
					</td>
				</tr>
			</table>
			<table class="statistics">
				<tr>
					<td colspan="3"><span style="font-weight: bold; font-size: 18px;">Annotations Distribution by Client Type</span></td>
				</tr>	
				<tr>
					<td style="width: 80px; vertical-align: top; padding-top:30px;">
						<div id="annotationsByClientBars"></div>
					</td>
					<td>
						<div id="annotationsByClient"></div>
					</td>
				</tr>
			</table>	
			<table class="statistics">
				<tr>
					<td colspan="3"><span style="font-weight: bold; font-size: 18px;">Annotations Distribution by Target Type</span></td>
				</tr>	
				<tr>
					<td style="width: 80px; vertical-align: top; padding-top:30px;">
						<div id="targetTypeBars"></div>
					</td>
					<td>
						<div id="annotationsByTargetType"></div>
					</td>
				</tr>
			</table>	
			<table class="statistics">
				<tr>
					<td colspan="3"><span style="font-weight: bold; font-size: 18px;">Annotations Distribution by Target Scope</span></td>
				</tr>	
				<tr>
					<td style="width: 80px; vertical-align: top; padding-top:30px;">
						<div id="targetScopeBars"></div>
					</td>
					<td>
						<div id="annotationsByTargetScope"></div>
					</td>
				</tr>
			</table>
		</div>
		<script>

           var svg1 = d3.select("#annotationsByTypeChart").append("svg").attr("width",300).attr("height",300);
           svg1.append("g").attr("id","annotationsTypeDonut");

           var svg2 = d3.select("#annotationsByClient").append("svg").attr("width",300).attr("height",300);
           svg2.append("g").attr("id","annotationsByClientDonut");

           var svg3 = d3.select("#annotationsByTargetType").append("svg").attr("width",300).attr("height",300);
           svg3.append("g").attr("id","targetTypeDonut");

           var svg4 = d3.select("#annotationsByTargetScope").append("svg").attr("width",300).attr("height",300);
           svg4.append("g").attr("id","targetScopeDonut");

          

           function randomData(){
           	return salesData.map(function(d){ 
           		return {label:d.label, value:1000*Math.random(), color:d.color};});
           }

			$( document ).ready(function() {
				laadAnnotationsByType();
				laadAnnotationsByClient();
				laadAnnotationsByTargetType();
				laadAnnotationsByTargetScope();
			});

			function laadAnnotationsByClient() {
				console.log( "Loading number of annotations by client..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotationByClient"
				}).done(function( data ) {
					console.log( "Number of annotations by client " + data);
					var counter =0;
					var annotationsByClient = new Array();
					data.forEach(function(d) {
						var a = {};
						a["label"] = d.client;
						a["value"] = d.counter;
						a["color"] = color(counter);
						annotationsByClient[counter] = a;
					    counter++;
					});

					Donut3D.draw("annotationsByClientDonut", annotationsByClient, 150, 150, 130, 100, 30, 0.4);

					drawBars("#annotationsByClientBars", annotationsByClient);
					
				}).fail(function() {
					console.log( "FAILED loading number of annotations by client" );
				});
			}
			
			function laadAnnotationsByType() {
				console.log( "Loading number of annotations by type..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotationByType"
				}).done(function( data ) {
					console.log( "Number of annotations by type " + data);
					var counter =0;
					var annotationsByTypes = new Array();
					
					data.forEach(function(d) {
						var a = {};
						a["label"] = d.type;
						a["value"] = d.counter;
						a["color"] = color(counter);
						annotationsByTypes[counter] = a;
					    counter++;
					});

					Donut3D.draw("annotationsTypeDonut", annotationsByTypes, 150, 150, 130, 100, 30, 0.4);
					
					drawBars("#annotationsTypeBars", annotationsByTypes);
				}).fail(function() {
					console.log( "FAILED loading number of annotations by type" );
				});
			}

			function laadAnnotationsByTargetType() {
				console.log( "Loading number of annotations by target type..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotationByTargetType"
				}).done(function( data ) {
					console.log( "Number of annotations by target type " + data);
					var counter =0;
					var annotationsByTypes = new Array();
					data.forEach(function(d) {
						var a = {};
						a["label"] = d.label;
						a["value"] = d.value;
						a["color"] = color(counter);
						annotationsByTypes[counter] = a;
					    counter++;
					});

					Donut3D.draw("targetTypeDonut", annotationsByTypes, 150, 150, 130, 100, 30, 0.4);

					drawBars("#targetTypeBars", annotationsByTypes);
				}).fail(function() {
					console.log( "FAILED loading number of annotations by type" );
				});	
			}

			function laadAnnotationsByTargetScope() {
				console.log( "Loading number of annotations by target scope..." );

				$.ajax({
					type: "GET",
					url: "getNumberOfAnnotationByTargetScope"
				}).done(function( data ) {
					console.log( "Number of annotations by target scope " + data);
					var counter =0;
					var annotationsByTypes = new Array();
					data.forEach(function(d) {
						var a = {};
						a["label"] = d.label;
						a["value"] = d.value;
						a["color"] = color(counter);
						annotationsByTypes[counter] = a;
					    counter++;
					});

					Donut3D.draw("targetScopeDonut", annotationsByTypes, 150, 150, 130, 100, 30, 0.4);

					drawBars("#targetScopeBars", annotationsByTypes);
				}).fail(function() {
					console.log( "FAILED loading number of annotations by scope" );
				});	
			}

			var color = d3.scale.category20();

			function drawBars(id, data) {

				var indices = d3.range(0, data.length);   

				var labels = new Array();
				var values = new Array();
				data.forEach(function(d) {
					labels.push((d.label!='null')?d.label:'not specified');
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
				    
				 var left_width = 280;
				 
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
	</body>
</html>