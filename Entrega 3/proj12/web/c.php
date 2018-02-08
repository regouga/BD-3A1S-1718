<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"> </head>
    <body>
        <font face="helvetica">
        <button style="width: 200px; height: 40px;" onclick="window.location='index.html';">< Voltar</button><br><br>
<?php
    try
    {
        include 'config.php';

        echo("<h3>Produto</h3>\n");

        $sql = "SELECT ean, design FROM produto;";
        $result = $db->query($sql);


        echo("<table border=\"1\">\n");
        echo("<tr><td><b>ean</b></td><td>design</td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['ean']);
            echo("</td><td>");
            echo($row['design']);
            echo("</td></tr>\n");
        }
        echo("</table>\n");

        if (isset($_POST['submeter'])) {
            $ean = $_POST['ean'];

            echo("<h3>Eventos de Reposição do produto $ean</h3>\n");

            $sql = "START TRANSACTION;";
            $db->query($sql);
            
            $sql = "SELECT ean, operador, instante, unidades FROM evento_reposicao NATURAL JOIN reposicao WHERE ean = '$ean';";
            $result = $db->query($sql);

            $sql = "END;";
            $db->query($sql);

            echo("<table border=\"1\">\n");
            echo("<tr><td><b>ean</b></td><td>operador</td><td>instante</td><td>unidades</td></tr>\n");
            foreach($result as $row)
            {
                echo("<tr><td>");
                echo($row['ean']);
                echo("</td><td>");
                echo($row['operador']);
                echo("</td><td>");
                echo($row['instante']);
                echo("</td><td>");
                echo($row['unidades']);
                echo("</td></tr>\n");
            }
            echo("</table>\n");


            
            $db = null;
            $prep = null;
       }
    }
    catch (PDOException $e)
    {
        echo("<p>Ocorreu um erro.<br>Tente novamente mais tarde.<br><br> Detalhes: {$e->getMessage()}</p><br><a href=\"c.php\"> < Voltar</a>");
    }
?>

        <h3>Listar eventos de reposição de um produto</h3>
        <form action='c.php' method='post'>
            <p>EAN do Produto: <select name='ean' required>
                    <?php
                        include 'config.php';
                        $sql = "SELECT ean FROM produto;";
                        $result = $db->query($sql);
                        foreach($result as $row)
                        {
                            echo '<option value="'.htmlspecialchars($row['ean']).'">' . $row['ean'] . '</option>';
                        }
                    ?>
                </select></p>
            <p><input type='submit' name='submeter' value='Submeter'/></p>
        </form>
    </body>
</html>
