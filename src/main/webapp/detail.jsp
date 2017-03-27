<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<title>Trending Topics</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">

	//Load the Visualization API and the packages.
	google.charts.load('current', {
		packages : [ 'corechart', 'bar' ]
	});
	
	// Set a callback to run when the Google Visualization API is loaded.
	google.charts.setOnLoadCallback(drawBasic);

	function drawBasic() {
		var jsonData = $.ajax({
			url : "NumberTweetsPerBrazilianState",
			type : 'GET',
			data : jQuery.param({
				hashtag : "${hashtag}"
			}),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			async : false,
			success : function(data) {
				console.log(data);
			},
			error : function(xhr, type) {
				alert('server error occoured')
			}
		}).responseJSON;
		//alert(jsonData)
		
		// Create our data table out of JSON data loaded from server.
		var data = new google.visualization.DataTable();
		
		// assumes "Estado" is a string and "Quantidade de Tweets" is a number
		data.addColumn('string', 'Estado');
		data.addColumn('number', 'Quantidade de Tweets');

		$.each(jsonData, function(i, obj) {
			data.addRow([ obj.state, obj.qty ]);
		});

		var options = {
			title : 'Número de Tweets dos Estados do Brasil',
			width: 350,
			height: 700,
			chartArea : {
				width : '50%'
			},
			hAxis : {
				title : 'Total de Tweets',
				minValue : 0
			},
			vAxis : {
				title : 'Estados'
			}
		};

		var chart = new google.visualization.BarChart(document
				.getElementById('chart_div'));

		chart.draw(data, options);
	}
</script>
</head>
<body>
	<!-- Always shows a header, even in smaller screens. -->
	<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
		<header class="mdl-layout__header">
		<div class="mdl-layout__header-row">
			<!-- Title -->
			<span class="mdl-layout-title" id="topico_title">Trending
				Topics</span>
			<!-- Add spacer, to align navigation to the right -->
			<div class="mdl-layout-spacer"></div>
			<!-- Navigation. We hide it in small screens. -->
			<nav class="mdl-navigation mdl-layout--large-screen-only"> <a
				class="mdl-navigation__link" href="ExibeRanking">Topics</a> </nav>
		</div>
		</header>
		<div class="mdl-layout__drawer">
			<span class="mdl-layout-title">Fórum</span>
			<nav class="mdl-navigation"> <a class="mdl-navigation__link"
				href="ExibeRanking">Ranking</a> </nav>
		</div>
		<main class="mdl-layout__content">
		<div class="page-content">
			<section class="mdl-grid" id="my-table">
			<div class="mdl-layout-spacer"></div>
			<div
				class="mdl-cell mdl-cell--6-col-tablet mdl-cell--4-col-phone mdl-cell--5-col-desktop mdl-cell--stretch">
				<div id="chart_div"></div>
			</div>
			<div class="mdl-layout-spacer"></div>
			</section>
		</div>
		</main>
	</div>
</body>
</html>