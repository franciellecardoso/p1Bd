package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Jogo;

public class JogoDao implements IJogoDao {
	private GenericDao gDao;

	public JogoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String gerarJogos() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();

		String sql = "{CALL sp_gerar_rodadas}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();

		String saida = cs.getString(1); // obtém a mensagem de retorno da procedure

		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<Jogo> listarJogos(String data) throws SQLException, ClassNotFoundException {
		List<Jogo> jogos = new ArrayList<Jogo>();

		Connection c = gDao.getConnection();
		String sql = "sp_gerar_rodadas";

		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, data);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Jogo j = new Jogo();
			j.setTimeA(rs.getString("codigo_timeA"));
			j.setTimeB(rs.getString("codigo_timeB"));
			j.setGolsTimeA(rs.getInt("GolsTimeA"));
			j.setGolsTimeB(rs.getInt("GolsTimeB"));
			j.setData(rs.getString("Data"));

			jogos.add(j);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}
}
