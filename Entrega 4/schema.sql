DROP TABLE IF EXISTS factos;
DROP TABLE IF EXISTS d_tempo;
DROP TABLE IF EXISTS d_produto;
DROP TABLE IF EXISTS reposicao;
DROP TABLE IF EXISTS evento_reposicao;
DROP TABLE IF EXISTS planograma;
DROP TABLE IF EXISTS prateleira;
DROP TABLE IF EXISTS corredor;
DROP TABLE IF EXISTS fornece_sec;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS constituida;
DROP TABLE IF EXISTS super_categoria;
DROP TABLE IF EXISTS categoria_simples;
DROP TABLE IF EXISTS categoria;

CREATE TABLE categoria(
	nome varchar(80) NOT NULL,
	PRIMARY KEY (nome)
);

CREATE TABLE categoria_simples(
	nome varchar(80) NOT NULL,
	PRIMARY KEY (nome),
	FOREIGN KEY (nome) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE super_categoria(
	nome varchar(80) NOT NULL,
	PRIMARY KEY (nome),
	FOREIGN KEY (nome) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE constituida(
	super_categoria varchar(80) NOT NULL,
	categoria varchar(80) NOT NULL,
	PRIMARY KEY (super_categoria, categoria),
	FOREIGN KEY (super_categoria) REFERENCES super_categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (categoria) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK (super_categoria != categoria)
);

CREATE TABLE fornecedor(
	nif integer NOT NULL unique,
	nome varchar(80) NOT NULL,
	PRIMARY KEY (nif)
);




CREATE TABLE produto(
	ean varchar(80) NOT NULL unique,
	design varchar(256) NOT NULL,
	categoria varchar(80) NOT NULL,
	forn_primario integer NOT NULL,
	data date NOT NULL,
	PRIMARY KEY (ean),
	FOREIGN KEY (categoria) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (forn_primario) REFERENCES fornecedor(nif) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE fornece_sec(
	nif integer NOT NULL,
	ean varchar(80) NOT NULL,
	PRIMARY KEY (nif, ean),
	FOREIGN KEY (nif) REFERENCES fornecedor(nif) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ean) REFERENCES produto(ean) ON DELETE CASCADE ON UPDATE CASCADE

);


create or replace function check_fornecedor()
  returns trigger as $$
declare f_aux integer;
begin

  select forn_primario into f_aux
  from produto
  where forn_primario = new.nif and ean = new.ean;
	if new.nif = f_aux
	THEN RAISE EXCEPTION 'o fornecedor com o nif % e fornecedor primario do produto %', new.nif, new.ean;
	end if;
	return null;
end
$$ language plpgsql;

create trigger check_forne after insert on fornece_sec for each row
	execute procedure check_fornecedor();

CREATE TABLE corredor(
	nro integer NOT NULL unique,
	largura numeric(19,4) NOT NULL,
	PRIMARY KEY (nro)
);

CREATE TABLE prateleira(
	nro integer NOT NULL,
	lado varchar(10) NOT NULL,
	altura numeric(19,4) NOT NULL,
	PRIMARY KEY (nro, lado, altura),
	FOREIGN KEY (nro) REFERENCES corredor(nro) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE planograma(
	ean varchar (80) NOT NULL unique,
	nro integer NOT NULL,
	lado varchar(10) NOT NULL,
	altura numeric(19,4) NOT NULL,
	face varchar(10) NOT NULL,
	unidades integer NOT NULL,
	loc varchar(30) NOT NULL,
	PRIMARY KEY (ean, nro, lado, altura),
	FOREIGN KEY (ean) REFERENCES produto(ean) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (nro, lado, altura) REFERENCES prateleira(nro, lado, altura) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE evento_reposicao(
	operador varchar(80) NOT NULL,
	instante timestamp NOT NULL,
	PRIMARY KEY (operador, instante),
	CHECK (localtimestamp >= instante)
);

CREATE TABLE reposicao(
	ean varchar (80) NOT NULL,
	nro integer NOT NULL,
	lado varchar(10) NOT NULL,
	altura numeric(19,4) NOT NULL,
	operador varchar(80) NOT NULL,
	instante timestamp NOT NULL,
	unidades integer NOT NULL,
	PRIMARY KEY (ean, nro, lado, altura, operador, instante),
	FOREIGN KEY (ean, nro, lado, altura) REFERENCES planograma(ean, nro, lado, altura) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (operador, instante) REFERENCES evento_reposicao(operador, instante) ON DELETE CASCADE ON UPDATE CASCADE
);

-- NAO ESQUECER OS DROPS


CREATE TABLE d_produto(
	produto_id SERIAL,
	cean varchar (80) NOT NULL,
	categoria varchar(80) NOT NULL,
	nif_fornecedor_principal integer NOT NULL,
	PRIMARY KEY (produto_id)
);

CREATE TABLE d_tempo(
	tempo_id timestamp,
	dia integer NOT NULL,
	mes integer NOT NULL,
	ano integer NOT NULL,
	PRIMARY KEY (tempo_id)
);

CREATE TABLE factos(
	tempo_id timestamp NOT NULL,
	produto_id integer NOT NULL,
	FOREIGN key (produto_id) REFERENCES d_produto(produto_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (tempo_id) REFERENCES d_tempo(tempo_id) ON DELETE CASCADE ON UPDATE CASCADE
);
