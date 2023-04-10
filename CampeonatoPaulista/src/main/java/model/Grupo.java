package model;

public class Grupo {
	private String grupo;
	private int time;

	public String getGrupo() {
		return grupo;
	}

	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "Grupo [grupo=" + grupo + ", time=" + time + "]";
	}
}
