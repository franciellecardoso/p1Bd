package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Grupo;

public interface IGrupoDao {
	public List<Grupo> geraGrupos() throws SQLException, ClassNotFoundException;

	public List<Grupo> listarGrupoA() throws SQLException, ClassNotFoundException;
	public List<Grupo> listarGrupoB() throws SQLException, ClassNotFoundException;
	public List<Grupo> listarGrupoC() throws SQLException, ClassNotFoundException;
	public List<Grupo> listarGrupoD() throws SQLException, ClassNotFoundException;

}
