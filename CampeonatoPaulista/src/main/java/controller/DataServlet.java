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

import model.Jogo;
import persistence.GenericDao;
import persistence.JogoDao;

@WebServlet("/data")
public class DataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DataServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String botao = request.getParameter("botao");

		GenericDao gDao = new GenericDao();
		JogoDao jogoDao = new JogoDao(gDao);

		List<Jogo> jogos = new ArrayList<Jogo>();
		String erro = "";
		String saida = "";

		try {
			if (botao.equalsIgnoreCase("pesquisar")) {

				jogos = jogoDao.listarJogos(saida);

			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {

			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
			request.setAttribute("j", jogos);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("data.jsp");
			dispatcher.forward(request, response);

		}
	}
}
