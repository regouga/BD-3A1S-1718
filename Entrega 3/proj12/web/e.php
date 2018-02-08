<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"> </head>
    <body>
         <font face="helvetica">

        <button style="width: 200px; height: 40px;" onclick="window.location='index.html';">< Voltar</button><br><br>
<?php
    try
    {
        include 'config.php';

        echo("<h3>Super-Categorias</h3>\n");

        $sql = "SELECT DISTINCT nome FROM super_categoria;";
        $result = $db->query($sql);

        echo("<table border=\"1\">\n");
        echo("<tr><td><b>nome</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['nome']);
            echo("</td></tr>\n");
        }
        echo("</table>\n");

        if (isset($_POST['submeter'])) {
        $nome = $_POST['nome'];

        echo("<h3>Sub-Categorias da Super-Categoria $nome</h3>\n");

        $sql = "START TRANSACTION;";
        $db->query($sql);
        
        $sql = "WITH RECURSIVE result (super_categoria, categoria) AS (SELECT super_categoria, categoria FROM constituida where super_categoria='$nome' UNION ALL SELECT constituida.super_categoria, constituida.categoria FROM constituida INNER JOIN result on constituida.super_categoria = result.categoria) SELECT categoria FROM result;";
        $result = $db->query($sql);

        $sql = "END;";
        $db->query($sql);

        echo("<table border=\"1\">\n");
        echo("<tr><td><b>categoria</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['categoria']);
            echo("</td></tr>\n");
        }
        echo("</table>\n");

        $db = null;
        $prep = null;
       }
    }
    catch (PDOException $e)
    {
        echo("<p>Ocorreu um erro.<br>Tente novamente mais tarde.<br><br> Detalhes: {$e->getMessage()}</p><br><a href=\"e.php\"> < Voltar</a>");
    }
?>

        <br><br><h3>Listar todas as sub-categorias de uma super-categoria, a todos os níveis de profundidade</h3>
        <form action='e.php' method='post'>
            <p>Nome da Super-Categoria: <select name='nome' required>
                    <?php
                        include 'config.php';
                        $sql = "SELECT nome FROM super_categoria;";
                        $result = $db->query($sql);
                        foreach($result as $row)
                        {
                            echo '<option value="'.htmlspecialchars($row['nome']).'">' . $row['nome'] . '</option>';
                        }
                    ?>
                </select></p>
            <p><input type='submit' name='submeter' value='Submeter'/></p>
        </form>
    </body>
</html>
