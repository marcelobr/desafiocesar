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
				<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
					<thead>
						<tr>
							<th class="mdl-data-table__cell--non-numeric">Topic</th>
						</tr>
					</thead>
					<tbody>
						<!-- <div class="mdl-spinner mdl-js-spinner is-active"></div> -->
						<c:choose>
							<c:when test="${!trendingList.isEmpty()}">
								<c:forEach items="${trendingList}" var="trendingItem">
									<tr>
										<td class="mdl-data-table__cell--non-numeric"><a
											href="NumberTweetsPerBrazilianState?hashtag=${trendingItem.substring(1)}">${trendingItem}</a>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="2" style="text-align: center">Nenhuma hashtag para exibir</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="mdl-layout-spacer"></div>
			</section>
		</div>
		</main>
	</div>
</body>
</html>