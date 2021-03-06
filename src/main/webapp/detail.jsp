<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CESAR Challenge</title>
</head>

<body style="overflow: hidden;">
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="mdl/material.min.js"></script>
<link rel="stylesheet" href="mdl/material.min.css">
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script src="jquery/jquery.min.js"></script>
<script type="text/javascript">
	$(window)
			.load(
					function() {
						//Load the Visualization API and the packages.
						google.charts.load('current', {
							packages : [ 'corechart', 'bar' ]
						});

						// Set a callback to run when the Google Visualization API is loaded.
						google.charts.setOnLoadCallback(drawBasic);

						function drawBasic() {
							var jsonData = $
									.ajax({
										url : "NumberTweetsPerBrazilianState",
										type : 'GET',
										data : jQuery.param({
											hashtag : "${hashtag}"
										}),
										contentType : "application/json; charset=utf-8",
										dataType : "json",
										async : true,
										success : function(data) {
											// Create our data table out of JSON data loaded from server.
											var data1 = new google.visualization.DataTable();

											// assumes "Estado" is a string and "Quantidade de Tweets" is a number
											data1.addColumn('string', 'States');
											data1.addColumn('number',
													'Number of Tweets');

											$.each(data, function(i, obj) {
												data1.addRow([ obj.state,
														obj.qty]);
											});

											var options = {
												title : 'Número de Tweets da hashtag #${hashtag} dos Estados do Brasil',
												width : '100%',
												height : '100%',
												chartArea : {
													left : "25%",
													top : "3%",
													height : "80%",
													width : "100%"
												},
												hAxis : {
													title : 'Number of Tweets',
													minValue : 0
												},
												vAxis : {
													title : 'States',
													minValue : 27
												}
											};

											var chart = new google.visualization.BarChart(
													document
															.getElementById('chart_div'));

											chart.draw(data1, options);
											$('#spinloading').removeAttr(
													"class");
											$('#spinloading')
													.attr("class",
															"mdl-spinner mdl-js-spinner");
										},
										error : function(xhr, type) {
											alert('Error fetching number of tweets per Brazilian state')
											$('#spinloading').removeAttr(
													"class");
											$('#spinloading')
													.attr("class",
															"mdl-spinner mdl-js-spinner");
										}
									});
						}
					});
</script>
</head>
<body>
	<!-- Always shows a header, even in smaller screens. -->
	<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
		<header class="mdl-layout__header">
			<div class="mdl-layout__header-row">
				<!-- Title -->
				<span class="mdl-layout-title" id="topico_title">Number of
					tweets to #${hashtag}</span>
				<!-- Add spacer, to align navigation to the right -->
				<div class="mdl-layout-spacer"></div>
				<!-- Navigation. We hide it in small screens. -->
				<nav class="mdl-navigation mdl-layout--large-screen-only">
					<a class="mdl-navigation__link" href="hashtags">Trending
						Hashtags</a>
				</nav>
			</div>
		</header>
		<div class="mdl-layout__drawer">
			<span class="mdl-layout-title">CESAR Challenge</span>
			<nav class="mdl-navigation">
				<a class="mdl-navigation__link" href="hashtags">Trending
					Hashtags</a>
			</nav>
		</div>
		<main class="mdl-layout__content">
		<div class="page-content">
			<section class="mdl-grid" id="my-table">
				<div class="mdl-layout-spacer"></div>
				<div
					class="mdl-cell mdl-cell--6-col-tablet mdl-cell--4-col-phone mdl-cell--10-col-desktop mdl-cell--stretch">
					<div id="spinloading" class="mdl-spinner mdl-js-spinner is-active"
						style="position: fixed; top: 50%; left: 50%"></div>
					<div id="chart_div" style="width: 100%; min-height: 600px;"></div>
				</div>
				<div class="mdl-layout-spacer"></div>
			</section>
		</div>
		</main>
	</div>
</body>
</html>

</body>
</html>