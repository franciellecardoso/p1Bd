package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Grupo;
import persistence.GenericDao;
import persistence.GrupoDao;

@WebServlet("/grupo")
public class GrupoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GrupoServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String botao = request.getParameter("botao");

		GenericDao gDao = new GenericDao();
		GrupoDao grupoDao = new GrupoDao(gDao);

		List<Grupo> grupoA = new ArrayList<>();

		List<Grupo> grupoB = new ArrayList<>();

		List<Grupo> grupoC = new ArrayList<>();

		List<Grupo> grupoD = new ArrayList<>();

		String erro = "";
		String saida = "";

		try {
			if (botao.equalsIgnoreCase("ver")) {
				grupoA = grupoDao.listarGrupoA();
				grupoB = grupoDao.listarGrupoB();
				grupoC = grupoDao.listarGrupoC();
				grupoD = grupoDao.listarGrupoD();
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {

			request.setAttribute("saida", saida);

			request.setAttribute("erro", erro);

			request.setAttribute("ga", grupoA);

			request.setAttribute("gb", grupoB);

			request.setAttribute("gc", grupoC);

			request.setAttribute("gd", grupoD);

			RequestDispatcher dispatcher = request.getRequestDispatcher("grupo.jsp");
			dispatcher.forward(request, response);
		}
	}

}
