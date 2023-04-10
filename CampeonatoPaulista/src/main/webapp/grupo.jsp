<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/styles.css">
<meta charset="ISO-8859-1">
<title>Grupos</title>
</head>
<body>
	<div align="center">
		<nav id=menu>
			<ul>
				<li><a href="index.jsp">Início</a></li>
				<li><a href="time.jsp">Times</a>
				<li><a href="grupo.jsp">Tabela de Grupos</a></li>
				<li><a href="jogo.jsp">Jogos</a></li>
				<li><a href="data.jsp">Datas</a></li>
			</ul>
		</nav>
	</div>
	<br />
	<br />
	<div id="centro" align="center">
		<h1 class=texto>Campeonato Paulista - 2023</h1>
		<h3>Tabelas dos grupos</h3>
		<div align="center">
			<form action="grupo" method="post">
				<input type="submit" id=botao name=botao value="Ver">
			</form>
		</div>
		<div align="center">
			<c:if test="${not empty erro}">
				<h4>
					<c:out value="${erro}"></c:out>
				</h4>
			</c:if>
		</div>
		<br />
		<div class="container grid">
			<c:if test="${not empty grupoA }">
				<table class=table_home>
					<thead>
						<tr>
							<th align="center">Grupo A</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupoA }" var="ga">
							<tr>
								<td align="center">
								<td><c:out value="${ga.grupo }"></c:out></td>
								<td><c:out value="${ga.time }"></c:out></td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<c:if test="${not empty grupoB }">
				<table class=table_home>
					<thead>
						<tr>
							<th align="center">Grupo B</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupoB }" var="gb">
							<tr>
								<td align="center">
								<td><c:out value="${gb.grupo }"></c:out></td>
								<td><c:out value="${gb.time }"></c:out></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
		<div class="container grid">
			<c:if test="${not empty grupoC }">
				<table class=table_home>
					<thead>
						<tr>
							<th align="center">Grupo C</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupoC }" var="gc">
							<tr>
								<td align="center">
								<td><c:out value="${gc.grupo }"></c:out></td>
								<td><c:out value="${gc.time }"></c:out></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<c:if test="${not empty grupoD }">
				<table class=table_home>
					<thead>
						<tr>
							<th align="center">Grupo D</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupoD }" var="gd">
							<tr>
								<td align="center">
								<td><c:out value="${gd.grupo }"></c:out></td>
								<td><c:out value="${gd.time }"></c:out></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
</body>
</html>