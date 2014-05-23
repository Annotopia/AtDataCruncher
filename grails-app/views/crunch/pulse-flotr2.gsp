<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="secure"/>
		<title>Annotopia Pulse</title>
		
		<style type="text/css">

      #chartNumberOfAnnotationByResource {
        width : 600px;
        height: 384px;
        margin: 8px auto;
      }
    </style>
		
		<script type="text/javascript" src="${resource(dir: 'js/flotr2', file: 'flotr2.min.js')}"></script>
		<script>

			$( document ).ready(function() {
				console.log( "Pulse page ready to roll" );
				laadNumberOfAnnotations();
				laadNumberOfAnnotationSets();
				laadNumberOfAnnotatedResources();
				laadNumberOfAnnotationByResource();
				laadNumberOfAnnotationByUser();
				laadNumberOfAnnotationByClient();
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

					(function basic_bars(container, horizontal) {

					    var
					    horizontal = (horizontal ? true : false),
					        // Show horizontal bars
					        d1 = [],
					        // First data series
					        d2 = [],
					        // Second data series
					        point, // Data point variable declaration
					        i;

					    for (i = 0; i < 14; i++) {

					        if (horizontal) {
					            point = [Math.ceil(Math.random() * 10), i];
					        } else {
					            point = [i, Math.ceil(Math.random() * 10)];
					        }

					        d1.push(point);

							/*
						    if (horizontal) {
					            point = [Math.ceil(Math.random() * 10), i + 0.5];
					        } else {
					            point = [i + 0.5, Math.ceil(Math.random() * 10)];
					        }
					        d2.push(point);
					        */     
					    };

					    // Draw the graph
					    Flotr.draw(
					    container, [d1, d2], {
					        bars: {
					            show: true,
					            horizontal: horizontal,
					            shadowSize: 0,
					            barWidth: 0.5
					        },
					        mouse: {
					            track: true,
					            relative: true
					        },
					        yaxis: {
					            min: 0,
					            autoscaleMargin: 1
					        }
					    });
					})(document.getElementById("chartNumberOfAnnotationByResource"),true);
					
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
					//$('#numberOfAnnotationByUser').text(results);
				}).fail(function() {
					console.log( "FAILED loading number of annotation by user" );
				})
				.always(function() {
					
				});				
			}

			function laadNumberOfAnnotationByClient() {
				console.log( "Loading number of annotation by client..." );


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
			
			
			<h3>Annotations by Users</h3>
			<div id="numberOfAnnotationByUser"></div>
			<canvas id="chartNumberOfAnnotationByUser" width="400" height="600"></canvas>
			
			<h3>Annotations by Client</h3>
			<div id="numberOfAnnotationByClient"></div>
			<canvas id="chartNumberOfAnnotationByClient" width="400" height="600"></canvas>
		</div>
	</body>
</html>