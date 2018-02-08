#SELECT forn_primario, count(*) as count FROM reposicao NATURAL JOIN produto NATURAL JOIN fornece_sec WHERE forn_primario='123456789' or nif='123456789';



SELECT categoria, ano, mes, count(categoria) FROM factos NATURAL JOIN d_tempo NATURAL JOIN d_produto
WHERE nif_fornecedor_principal='282943312'
GROUP BY categoria, ano, mes
UNION
SELECT categoria, ano, null, count(categoria) FROM factos NATURAL JOIN d_tempo NATURAL JOIN d_produto
WHERE nif_fornecedor_principal='282943312'
GROUP BY categoria, ano
UNION
SELECT categoria, null, null, count(categoria) FROM factos NATURAL JOIN d_produto
WHERE nif_fornecedor_principal='282943312'
GROUP BY categoria
UNION
SELECT null, null, null, count(categoria) FROM factos NATURAL JOIN d_produto
WHERE nif_fornecedor_principal='282943312';

SELECT building_name, day_period, hour_of_day, avg(reading)
FROM meter_readings NATURAL JOIN building_dimension NATURAL JOIN time_dimension
GROUP BY building_name, day_period, hour_of_day
UNION
SELECT building_name, day_period, null, avg(reading)
FROM meter_readings NATURAL JOIN building_dimension NATURAL JOIN time_dimension
GROUP BY building_name, day_period
UNION
SELECT building_name, null, null, avg(reading)
FROM meter_readings NATURAL JOIN building_dimension NATURAL JOIN time_dimension
GROUP BY building_name
UNION
SELECT null, null, null, avg(reading)
FROM meter_readings;


UNION
SELECT ano, NULL, count(*)
FROM factos NATURAL JOIN d_tempo NATURAL JOIN d_produto
WHERE nif_fornecedor_principal='282943312'
GROUP BY ano
UNION
SELECT NULL, NULL, count(*)
FROM factos NATURAL JOIN d_tempo NATURAL JOIN d_produto
WHERE nif_fornecedor_principal='282943312'

