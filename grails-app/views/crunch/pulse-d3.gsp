<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="secure"/>
		<title>Annotopia Pulse</title>
		
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
		</style>
		
		<script type="text/javascript" src="${resource(dir: 'js/d3js', file: 'd3.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/d3js', file: 'donut3D.js')}"></script>
		
	</head>
	<body>
		<div class="container">
			<h3>Annotopia Hub Counters</h3>
			<table class="pinterest">
				<tr>
					<td style="width: 280px; vertical-align: top; padding-top:30px;">
						<span style="font-weight: bold;">Annotations Distribution by Motivation</span>
						<div id="annotationsByTypesLegend"></div>
					<td><div id="annotationsByTypeChart"></div></td>
					<td style="width: 80px; vertical-align: top;"></td>
				</tr>
			</table>
			<table class="pinterest">
				<tr>
					<td style="width: 280px; vertical-align: top; padding-top:30px;">
						<span style="font-weight: bold;">Annotations Distribution by Client</span>
						<button onClick="changeData()">Change Data</button></td>
					<td><div id="annotationsBySystem"></div></td>
					<td style="width: 80px; vertical-align: top;"></td>
				</tr>
			</table>
		</div>
		<script>

		var salesData=[
           	{label:"Basic", color:"#3366CC"},
           	{label:"Plus", color:"#DC3912"},
           	{label:"Lite", color:"#FF9900"},
           	{label:"Elite", color:"#109618"},
           	{label:"Delux", color:"#990099"}
           ];

			
           var svg1 = d3.select("#annotationsByTypeChart").append("svg").attr("width",400).attr("height",300);
           svg1.append("g").attr("id","salesDonut");

           var svg2 = d3.select("#annotationsBySystem").append("svg").attr("width",400).attr("height",300);
           svg2.append("g").attr("id","quotesDonut");

          
           Donut3D.draw("quotesDonut", randomData(), 150, 150, 130, 100, 30, 0);
           	
           function changeData(){
           		//Donut3D.transition("salesDonut", randomData(), 130, 100, 30, 0.4);
           		Donut3D.transition("quotesDonut", randomData(), 130, 100, 30, 0);
           }

           function randomData(){
           	return salesData.map(function(d){ 
           		return {label:d.label, value:1000*Math.random(), color:d.color};});
           }

			$( document ).ready(function() {
				console.log( "Pulse page ready to roll" );
				laadAnnotationsByType();
			});

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
						a["color"] = salesData[counter].color;
						annotationsByTypes[counter] = a;
						$("#annotationsByTypesLegend").append(d.type + "-" + d.counter + "<br/>");
					    counter++;
					});

					Donut3D.draw("salesDonut", annotationsByTypes, 150, 150, 130, 100, 30, 0.4);
				}).fail(function() {
					console.log( "FAILED loading number of annotations by type" );
				})
				.always(function() {
					
				});	
			}

		</script>
	</body>
</html>