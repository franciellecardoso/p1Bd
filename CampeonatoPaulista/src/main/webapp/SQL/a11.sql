CREATE DATABASE a11
GO
USE a11
GO

CREATE TABLE times(
codigo               INT           IDENTITY(1,1)	NOT NULL,
nome                 VARCHAR(50)					NOT NULL,
cidade               VARCHAR(50)					NOT NULL,
estadio              VARCHAR(50)					NOT NULL,
material_esportivo   VARCHAR(50)					NOT NULL,
fl_unico             INT							NOT NULL
PRIMARY KEY(codigo)
)

CREATE TABLE grupos(
grupo                CHAR(1)  CHECK(UPPER(grupo) = 'A' OR 
									UPPER(grupo) = 'B' OR 
									UPPER(grupo) = 'C' OR 
									UPPER(grupo) = 'D')		NOT NULL,
codigo_time          INT							        NOT NULL,
PRIMARY KEY(grupo, codigo_time),
FOREIGN KEY(codigo_time) REFERENCES times(codigo)
)

CREATE TABLE jogos(
codigo_timeA         INT              NOT NULL,
codigo_timeB         INT              NOT NULL,
gols_timeA           INT              NULL,
gols_timeB           INT              NULL,
data				 DATE			  NOT NULL
PRIMARY KEY(codigo_timeA, codigo_timeB),
FOREIGN KEY (codigo_timeA) REFERENCES times(codigo),
FOREIGN KEY (codigo_timeB) REFERENCES times(codigo)
)

CREATE TABLE datas_jogos(
dia				     DATE			  NOT NULL,
fl_passou		     BIT			  NOT NULL
PRIMARY KEY(dia)
)

INSERT INTO times VALUES('Corinthians', 'São Paulo', 'Neo Química Arena', 'Nike', 1),
						('Palmeiras', 'São Paulo', 'Allianz Parque', 'Puma', 1),
						('Santos', 'Santos', 'Vila Belmiro', 'Umbro', 1),
						('São Paulo', 'São Paulo', 'Morumbi', 'Adidas', 1),
						('Água Santa', 'Diadema', 'Distrital do Inamar', 'Karilu', 0),
						('Botafogo SP', 'Ribeirão Preto', 'Santa Cruz', 'Volt Sport', 0),
						('Ferroviária', 'Araraquara', 'Fonte Luminosa', 'Lupo', 0),
						('Guarani', 'Campinas', 'Brinco de Ouro', 'Kappa', 0),
						('Inter de Limeira', 'Limeira', 'Limeirão', 'Alluri Sports', 0),
						('Ituano', 'Itu', 'Novelli Júnior', 'Kanxa', 0),
						('Mirrasol', 'Mirrasol', 'José Maria de Campos Maia', 'Super Bolla', 0),
						('Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi', 'Physicus', 0),
						('Ponte Preta', 'Campinas', 'Moisés Lucarelli', '1900(Marca Própria)', 0),
						('Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid', 'Nike', 0),
						('Santo André', 'Santo André', 'Bruno José Daniel', 'Icone Sports', 0),
						('São Bernardo', 'São Bernardo do Campo', 'Primeiro de Maio', 'Magnum Group', 0)
				

INSERT INTO datas_jogos VALUES ('2023-04-12', 0), ('2023-04-16', 0), ('2023-04-19', 0), 
('2023-04-23', 0), ('2023-04-26', 0), ('2023-04-30', 0), 
('2023-05-03', 0), ('2023-05-07', 0), ('2023-05-10', 0),
('2023-05-14', 0), ('2023-05-17', 0), ('2023-05-21', 0)

--SEPARANDO OS TIMES EM GRUPOS
CREATE PROCEDURE sp_divide_times_grupos
AS
BEGIN
    DECLARE @codigo INT, @grupo CHAR(1), @codigo_time INT, @count INT
    
    -- Inserir os quatro times proibidos em grupos diferentes
    INSERT INTO grupos(grupo, codigo_time) VALUES ('A', 1), ('B', 2), ('C', 3), ('D', 4)
    
    -- Gerar grupos aleatórios para os demais times
    SET @codigo = 5
    WHILE (@codigo <= 16)
    BEGIN
        SET @grupo = CHAR((RAND() * 4) + 65) -- ASCII de A é 65
        SET @count = (SELECT COUNT(*) FROM grupos WHERE grupo = @grupo)
        IF (@count < 4) AND (@codigo NOT IN (1, 2, 3, 4)) -- Verificar se o grupo ainda tem vagas e se o time não é proibido
        BEGIN
            INSERT INTO grupos(grupo, codigo_time) VALUES (@grupo, @codigo)
            SET @codigo = @codigo + 1
        END
    END
END

--TESTANDO(funcionou!)
EXEC sp_divide_times_grupos
--LISTA DE GRUPOS E NOME DOS TIMES
SELECT g.grupo, t.nome
FROM grupos g, times t
WHERE g.codigo_time = t.codigo 
ORDER BY grupo, codigo_time


--GERADOR DE RODADAS
CREATE PROCEDURE sp_gerar_rodadas
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @rodada INT = 1;
    DECLARE @data DATE = '2023-04-12';
    DECLARE @jogos TABLE (
        id INT IDENTITY(1,1),
        casa VARCHAR(50),
        visitante VARCHAR(50),
        data_jogo DATE
    )
    
    WHILE @rodada <= 12
    BEGIN
        DECLARE @times TABLE (
            id INT IDENTITY(1,1),
            nome VARCHAR(50)
        )
        
        INSERT INTO @times (nome)
        VALUES
        ('Corinthians'),
        ('Palmeiras'),
        ('Santos'),
        ('São Paulo'),
        ('Guarani'),
        ('Ituano'),
        ('Botafogo'),
        ('Mirassol'),
        ('Água Santa'),
        ('São Bernardo'),
        ('Novorizontino'),
        ('Ferroviária'),
        ('Red Bull Bragantino'),
        ('Ponte Preta'),
        ('Inter de Limeira'),
        ('Santo André')

        DECLARE @id_casa INT, @id_visitante INT, @qtde_times INT, @qtde_jogos INT;
        SELECT @qtde_times = COUNT(*) FROM @times;
        SET @qtde_jogos = @qtde_times / 2
        
        WHILE @qtde_jogos > 0
        BEGIN
            SELECT TOP 1 @id_casa = id, @id_visitante = (SELECT TOP 1 id FROM @times WHERE id != @id_casa AND nome NOT IN (SELECT visitante FROM @jogos WHERE data_jogo = @data)) 
            FROM @times WHERE nome NOT IN (SELECT casa FROM @jogos WHERE data_jogo = @data) ORDER BY NEWID()
            
            INSERT INTO @jogos (casa, visitante, data_jogo)
            SELECT nome, (SELECT nome FROM @times WHERE id = @id_visitante), @data FROM @times WHERE id = @id_casa
            
            DELETE FROM @times WHERE id IN (@id_casa, @id_visitante)
            SET @qtde_jogos = @qtde_jogos - 1
        END
        
        SELECT * FROM @jogos WHERE data_jogo = @data AND casa IS NOT NULL AND visitante IS NOT NULL
        DELETE FROM @jogos WHERE data_jogo = @data
       
		IF @rodada = 1 SET @data = '2023-04-12'
		ELSE IF @rodada = 2 SET @data = '2023-04-16'
		ELSE IF @rodada = 3 SET @data = '2023-04-19'
		ELSE IF @rodada = 4 SET @data = '2023-04-23'
		ELSE IF @rodada = 5 SET @data = '2023-04-26'
		ELSE IF @rodada = 6 SET @data = '2023-04-30'
		ELSE IF @rodada = 7 SET @data = '2023-05-03'
		ELSE IF @rodada = 8 SET @data = '2023-05-07'
		ELSE IF @rodada = 9 SET @data = '2023-05-10'
		ELSE IF @rodada = 10 SET @data = '2023-05-14'
		ELSE IF @rodada = 11 SET @data = '2023-05-17'
		ELSE IF @rodada = 12 SET @data = '2023-05-21'
        
        SET @rodada = @rodada + 1
    END
END

--TESTANDO(funcionou!)
EXEC sp_gerar_rodadas

