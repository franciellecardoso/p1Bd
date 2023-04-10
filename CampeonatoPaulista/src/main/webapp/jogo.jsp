<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/styles.css">
<meta charset="ISO-8859-1">
<title>Gerar Rodadas</title>
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
		<h3 class=tarefa>Gerar as rodadas com os jogos</h3>
		<div align="center">
			<form action="jogo" method="post">
				<input type="submit" id="botao" name="botao"
					value="Listar">
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
		<div align="center">
			<c:if test="${not empty saida}">
				<h4>
					<c:out value="${saida}"></c:out>
				</h4>
			</c:if>
		</div>
	</div>
</body>
</html>