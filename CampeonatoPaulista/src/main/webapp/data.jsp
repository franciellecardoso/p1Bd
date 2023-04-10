<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/styles.css">
<meta charset="ISO-8859-1">
<title>Datas</title>
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
		<h3 class=tarefa>Escolha a data da rodada (16 de Abril - 21 de
			Maio de 2023)</h3>
		<div align="center">
			<form action="data" method="post">
				<td><input type="date" id="data" name="data">
				<td>
				<td><input type="submit" id="botao" name="botao"
					value="Pesquisar">
				<td>
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
		<br />
		<div align="center">
			<c:if test="${not empty rodada }">
				<table class=table_home>
					<thead>
						<tr>
							<th>Time A</th>
							<th>Time B</th>
							<th>Gols A</th>
							<th>Gols B</th>
							<th>Data</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${jogo }" var="j">
							<tr>
								<td align="center"><c:out value="${j.codigo_timeA } "></c:out></td>
								<td align="center"><c:out value="${j.codigo_timeB } "></c:out></td>
								<td align="center"><c:out value="${j.golsTimeA }  "></c:out></td>
								<td align="center"><c:out value="${j.golsTimeB }  "></c:out></td>
								<td align="center"><c:out value="${j.data }"></c:out></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
</body>
</html>