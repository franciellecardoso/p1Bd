package model;

public class Time {
	private int codigo;
	private String nome;
	private String cidade;
	private String estadio;
	private String material;

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstadio() {
		return estadio;
	}

	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	@Override
	public String toString() {
		return "Time [codigo=" + codigo + ", nome=" + nome + ", cidade=" + cidade + ", estadio=" + estadio
				+ ", material=" + material + "]";
	}
}
