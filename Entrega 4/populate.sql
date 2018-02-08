-- Categorias
insert into categoria values ('Mercearia');
insert into categoria values ('Bolachas');
insert into categoria values ('Cafe');
insert into categoria values ('Cafe em Capsulas');
insert into categoria values ('Cafe Soluvel');

insert into categoria values ('Lacticinios');
insert into categoria values ('Leite');
insert into categoria values ('Queijo');
insert into categoria values ('Manteiga');

-- Categorias Simples

insert into categoria_simples values ('Cafe em Capsulas');
insert into categoria_simples values ('Cafe Soluvel');
insert into categoria_simples values ('Queijo');
insert into categoria_simples values ('Manteiga');
insert into categoria_simples values ('Leite');
insert into categoria_simples values ('Bolachas');

-- Super Categoria
insert into super_categoria values ('Mercearia');
insert into super_categoria values ('Cafe');

insert into super_categoria values ('Lacticinios');

-- Constituida
insert into constituida values ('Mercearia', 'Cafe');
insert into constituida values ('Mercearia', 'Bolachas');
insert into constituida values ('Cafe', 'Cafe Soluvel');
insert into constituida values ('Cafe', 'Cafe em Capsulas');

insert into constituida values ('Lacticinios', 'Leite');
insert into constituida values ('Lacticinios', 'Queijo');
insert into constituida values ('Lacticinios', 'Manteiga');

-- Fornecedor
insert into fornecedor values (363527604, 'Nespresso');
insert into fornecedor values (282943312, 'Delta Q');
insert into fornecedor values (194474799, 'Dolce Gusto');

insert into fornecedor values (316759354, 'Delta');
insert into fornecedor values (333293715, 'Nescafe');
insert into fornecedor values (183361795, 'Nicola');

insert into fornecedor values (592752693, 'Oreo');
insert into fornecedor values (131283641, 'Milka');
insert into fornecedor values (279150783, 'Nacional');

insert into fornecedor values (560994867, 'Mimosa');
insert into fornecedor values (293485841, 'Agros');
insert into fornecedor values (893992721, 'Flora');
insert into fornecedor values (758960761, 'Terra Nostra');
insert into fornecedor values (268015231, 'Limiano');
insert into fornecedor values (839103519, 'Queijaria Guilherme');

-- Produto
insert into produto values (900001, 'Qalidus', 'Cafe em Capsulas', 282943312, '2017-6-1');
insert into produto values (900002, 'Qaracter', 'Cafe em Capsulas', 282943312, '2017-6-1');
insert into produto values (900069, 'Qaracter Soluvel', 'Cafe Soluvel', 282943312, '2017-6-1');
insert into produto values (900011, 'Ristretto', 'Cafe em Capsulas', 363527604, '2017-6-2');
insert into produto values (900012, 'Vanillo', 'Cafe em Capsulas', 363527604, '2017-6-3');
insert into produto values (900014, 'Dharkan', 'Cafe em Capsulas', 363527604, '2017-6-3');
insert into produto values (900015, 'Espresso Macchiato', 'Cafe em Capsulas', 194474799, '2017-6-3');
insert into produto values (900016, 'Cappucino Luongo', 'Cafe em Capsulas', 194474799, '2017-6-4');

insert into produto values (130000, 'Gran Cafe', 'Cafe Soluvel', 316759354, '2017-4-27');
insert into produto values (130002, 'Corposo', 'Cafe Soluvel', 333293715, '2017-9-12');

insert into produto values (121348, 'Double Crema', 'Bolachas', 592752693, '2017-4-27');
insert into produto values (121358, 'Peanut Butter', 'Bolachas', 592752693, '2017-4-27');

insert into produto values (111111, 'Leite Achocolatado', 'Leite', 560994867, '2017-1-1');
insert into produto values (111112, 'Leite Branco', 'Leite', 293485841, '2017-1-2');
insert into produto values (111116, 'Manteiga Sem Sal', 'Manteiga', 893992721, '2017-1-2');
insert into produto values (111113, 'Queijo da Serra', 'Queijo', 893992721, '2017-1-3');
insert into produto values (111114, 'Queijo Fatiado', 'Queijo', 268015231, '2017-1-4');
insert into produto values (111115, 'Queijo Amanteigado', 'Queijo', 839103519, '2017-1-5');


-- Fornecedor Secundario
insert into fornece_sec values (560994867, 111112);
insert into fornece_sec values (758960761, 111113);
insert into fornece_sec values (268015231, 111113);
insert into fornece_sec values (839103519, 111114);
insert into fornece_sec values (560994867, 111114);
insert into fornece_sec values (194474799, 900001);
insert into fornece_sec values (363527604, 900002);
insert into fornece_sec values (194474799, 900002);
insert into fornece_sec values (131283641, 121348);
insert into fornece_sec values (279150783, 121348);
insert into fornece_sec values (279150783, 121358);


-- Corredor
insert into corredor values (1, 2);
insert into corredor values (2, 2);
insert into corredor values (3, 2);
insert into corredor values (4, 2);
insert into corredor values (5, 2);

-- Prateleira
insert into prateleira values (1, 'Direito', 0.90);
insert into prateleira values (1, 'Esquerdo', 0.90);
insert into prateleira values (2, 'Direito', 0.90);
insert into prateleira values (2, 'Esquerdo', 0.90);
insert into prateleira values (2, 'Esquerdo', 1.20);
insert into prateleira values (3, 'Direito', 0.90);
insert into prateleira values (3, 'Esquerdo', 0.90);
insert into prateleira values (3, 'Direito', 1.20);
insert into prateleira values (3, 'Esquerdo', 1.20);
insert into prateleira values (4, 'Direito', 0.90);
insert into prateleira values (4, 'Esquerdo', 0.90);
insert into prateleira values (4, 'Direito', 1.20);
insert into prateleira values (4, 'Esquerdo', 1.20);
insert into prateleira values (5, 'Direito', 0.90);
insert into prateleira values (5, 'Esquerdo', 0.90);
insert into prateleira values (5, 'Direito', 1.20);
insert into prateleira values (5, 'Esquerdo', 1.20);

-- Planograma
insert into planograma values (111111, 1, 'Direito', 0.90, 'Frente', 20, 'Prateleira');
insert into planograma values (900069, 1, 'Direito', 0.90, 'Frente', 20, 'Prateleira');
insert into planograma values (111112, 1, 'Esquerdo', 0.90, 'Frente', 30, 'Pratelira');
insert into planograma values (111113, 2, 'Direito', 0.90, 'Frente', 50, 'Prateleira');
insert into planograma values (111114, 2, 'Esquerdo', 0.90, 'Frente', 40, 'Prateleira');
insert into planograma values (111115, 2, 'Esquerdo', 0.90, 'Frente', 35, 'Prateleira');
insert into planograma values (900001, 3, 'Esquerdo', 0.90, 'Frente', 35, 'Prateleira');
insert into planograma values (900002, 3, 'Direito', 0.90, 'Frente', 35, 'Prateleira');
insert into planograma values (900011, 3, 'Direito', 1.20, 'Frente', 35, 'Prateleira');
insert into planograma values (900012, 3, 'Esquerdo', 1.20, 'Frente', 35, 'Prateleira');
insert into planograma values (900014, 4, 'Esquerdo', 0.90, 'Frente', 35, 'Prateleira');
insert into planograma values (900015, 4, 'Direito', 0.90, 'Frente', 35, 'Prateleira');
insert into planograma values (900016, 4, 'Esquerdo', 1.20, 'Frente', 35, 'Prateleira');
insert into planograma values (130000, 4, 'Direito', 1.20, 'Frente', 35, 'Prateleira');
insert into planograma values (130002, 5, 'Esquerdo', 0.90, 'Frente', 35, 'Prateleira');
insert into planograma values (121348, 5, 'Direito', 0.90, 'Frente', 35, 'Prateleira');
insert into planograma values (121358, 5, 'Esquerdo', 1.20, 'Frente', 35, 'Prateleira');

-- Evento Reposicao
insert into evento_reposicao values ('Andre Gomes', '2017-11-26 9:23:12');
insert into evento_reposicao values ('Andre Gomes', '2017-11-27 9:23:12');
insert into evento_reposicao values ('Jose Esteves', '2017-11-26 9:23:15');
insert into evento_reposicao values ('Andre Gomes', '2017-11-26 16:33:12');
insert into evento_reposicao values ('Marcia Rodrigues', '2017-11-26 16:37:52');
insert into evento_reposicao values ('Joao Silva', '2017-11-26 17:00:20');
insert into evento_reposicao values ('Joao Silva', '2017-11-26 17:10:20');
insert into evento_reposicao values ('Anabela Santos', '2017-11-27 10:37:52');
insert into evento_reposicao values ('Andre Gomes', '2017-11-27 11:23:12');
insert into evento_reposicao values ('Andre Gomes', '2017-11-27 11:35:12');
insert into evento_reposicao values ('Andre Gomes', '2017-11-27 12:05:12');
insert into evento_reposicao values ('Andre Gomes', '2017-11-27 12:52:27');
insert into evento_reposicao values ('Jose Esteves', '2017-11-27 14:23:15');
insert into evento_reposicao values ('Jose Esteves', '2017-11-27 15:02:15');
insert into evento_reposicao values ('Jose Esteves', '2017-11-27 16:34:15');

-- Reposicao
insert into reposicao values (111111, 1, 'Direito', 0.90, 'Andre Gomes', '2017-11-26 9:23:12', 5);
insert into reposicao values (900069, 1, 'Direito', 0.90, 'Andre Gomes', '2017-11-27 9:23:12', 5);
insert into reposicao values (111111, 1, 'Direito', 0.90, 'Jose Esteves', '2017-11-26 9:23:15', 5);
insert into reposicao values (111112, 1, 'Esquerdo', 0.90, 'Andre Gomes', '2017-11-26 16:33:12', 10);
insert into reposicao values (111114, 2, 'Esquerdo', 0.90, 'Marcia Rodrigues', '2017-11-26 16:37:52', 10);
insert into reposicao values (111115, 2, 'Esquerdo', 0.90, 'Joao Silva', '2017-11-26 17:00:20', 5);
insert into reposicao values (900001, 3, 'Esquerdo', 0.90, 'Joao Silva', '2017-11-26 17:10:20', 15);
insert into reposicao values (900002, 3, 'Direito', 0.90, 'Anabela Santos', '2017-11-27 10:37:52', 15);
insert into reposicao values (111115, 2, 'Esquerdo', 0.90, 'Andre Gomes', '2017-11-27 11:23:12', 7);
insert into reposicao values (900011, 3, 'Direito', 1.20, 'Andre Gomes', '2017-11-27 11:35:12', 7);
insert into reposicao values (900012, 3, 'Esquerdo', 1.20, 'Andre Gomes', '2017-11-27 12:05:12', 10);
insert into reposicao values (900014, 4, 'Esquerdo', 0.90, 'Andre Gomes', '2017-11-27 12:52:27', 10);
insert into reposicao values (900015, 4, 'Direito', 0.90, 'Jose Esteves', '2017-11-27 14:23:15', 10);
insert into reposicao values (900016, 4, 'Esquerdo', 1.20, 'Jose Esteves', '2017-11-27 16:34:15', 5);


-- d_produto
insert into d_produto ( cean, categoria, nif_fornecedor_principal)
	SELECT  ean as cean, categoria, forn_primario as nif_fornecedor_principal FROM produto;

	INSERT INTO d_tempo (tempo_id, dia, mes, ano)
		SELECT
			instante,
			EXTRACT(DAY FROM instante),
			EXTRACT(MONTH FROM instante),
			EXTRACT(YEAR FROM instante)
		FROM reposicao;

insert into factos(tempo_id,produto_id)
	SELECT DISTINCT
		tempo_id,
		produto_id
	FROM
		reposicao inner join d_tempo on reposicao.instante=d_tempo.tempo_id inner join d_produto on reposicao.ean=d_produto.cean;
