--a
SELECT nome
FROM
(
    SELECT fornecedor.nome, COUNT(distinct categoria) c
    FROM produto
    INNER JOIN fornecedor
    ON produto.forn_primario = fornecedor.nif
    GROUP BY nome

UNION ALL

    SELECT fornecedor.nome, COUNT(distinct categoria) c
    FROM produto
    INNER JOIN fornece_sec
    ON produto.ean = fornece_sec.ean
    INNER JOIN fornecedor
    ON fornece_sec.nif = fornecedor.nif
    GROUP BY nome

) result

WHERE c = (
    SELECT MAX(c)
    FROM (
      (
        SELECT fornecedor.nome, COUNT(distinct categoria) c
        FROM produto
        INNER JOIN fornecedor
        ON produto.forn_primario = fornecedor.nif
        GROUP BY nome
)
        UNION
(
        SELECT fornecedor.nome, COUNT(distinct categoria) c
        FROM produto
        INNER JOIN fornece_sec
        ON produto.ean = fornece_sec.ean
        INNER JOIN fornecedor
        ON fornece_sec.nif = fornecedor.nif
        GROUP BY nome
      )
    ) result
);


--b 
SELECT nome, nif 
FROM (
	SELECT fornecedor.nome, fornecedor.nif, COUNT(distinct categoria) c
	FROM produto
	INNER JOIN fornecedor
	ON produto.forn_primario = fornecedor.nif
	INNER JOIN categoria_simples
	ON categoria_simples.nome = produto.categoria
	GROUP BY fornecedor.nome, nif
) result
WHERE c = (
	SELECT COUNT(*)
	FROM categoria_simples
);

--c
SELECT ean
FROM produto
WHERE ean NOT IN (
	SELECT ean
	FROM reposicao
);

--d
SELECT ean 
FROM(
	SELECT ean 
	FROM fornece_sec
	GROUP BY ean
	HAVING COUNT(nif) > 10) AS result;

--e
SELECT ean 
FROM reposicao
GROUP BY ean
HAVING COUNT(distinct operador) = 1;