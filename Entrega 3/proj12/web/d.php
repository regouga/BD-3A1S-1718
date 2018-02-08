<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"> </head>
    <body>
        <font face="helvetica">
        <button style="width: 200px; height: 40px;" onclick="window.location='index.html';">< Voltar</button><br><br>
<?php
    try
    {
        include 'config.php';

        $design = $_POST['design'];
        $ean = $_POST['ean'];

        $sql = "START TRANSACTION;";
        $db->query($sql);

        if (isset($_POST['submeter'])) {
            $sql = "UPDATE produto SET design = '$design' WHERE ean = '$ean';";
            $db->query($sql);
        }

        $sql = "END;";
        $db->query($sql);

        echo("<h3>Produto</h3>\n");
        $sql = "SELECT * FROM produto;";
        $result = $db->query($sql);
        echo("<table border=\"1\">\n");
        echo("<tr><td><b>ean</b></td><td>design</td><td>categoria</td><td>forn_primario</td><td>data</td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['ean']);
            echo("</td><td>");
            echo($row['design']);
            echo("</td><td>");
            echo($row['categoria']);
            echo("</td><td>");
            echo($row['forn_primario']);
            echo("</td><td>");
            echo($row['data']);
            echo("</td></tr>\n");
        }
        echo("</table>\n");
        
        $db = null;
        $prep = null;
    }
    catch (PDOException $e)
    {
        echo("<p>Ocorreu um erro.<br>Tente novamente mais tarde.<br><br> Detalhes: {$e->getMessage()}</p><br><a href=\"d.php\"> < Voltar</a>");
    }
?>

        <h3>Alterar designação de um produto</h3>
        <form action='d.php' method='post'>
            <p>EAN do produto: <select name='ean' required>
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
            <p>Nova designação: <input type='text' name='design' required></p>
            <p><input type='submit' name='submeter' value='Submeter'/></p>
        </form>
    </body>
</html>
