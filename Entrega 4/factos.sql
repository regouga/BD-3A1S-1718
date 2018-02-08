CREATE TABLE factos(
	tempo_id SERIAL,
	produto_id SERIAL,
	nro integer NOT NULL,
	lado varchar(10) NOT NULL,
	altura numeric(19,4) NOT NULL,
	operador varchar(80) NOT NULL,
	unidades integer NOT NULL,
	FOREIGN key (produto_id) REFERENCES d_produto(produto_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (tempo_id) REFERENCES d_tempo(tempo_id) ON DELETE CASCADE ON UPDATE CASCADE
);