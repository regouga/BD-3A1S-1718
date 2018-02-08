<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"> </head>
    <body>
        <font face="helvetica">

        <button style="width: 200px; height: 40px;" onclick="window.location='index.html';">< Voltar</button><br><br>
        <h2>Inserir e remover categorias e sub-categorias</h2>
        <br><br>
<?php
    try
    {
        include 'config.php';
        
        $mode = isset($_REQUEST['mode']) ? $_REQUEST['mode'] : '';
        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : '';

        $nome = $_POST['nome'];
        $nome_sub = $_POST['nome_sub'];
        $nome_super = $_POST['nome_super'];

        $sql = "START TRANSACTION;";
        $db->query($sql);
        
        if ($mode == "remove") {
            if ($type == "categoria") {

                $sql = "DELETE FROM categoria WHERE nome = '$nome';";
                $db->query($sql);
            }

            if ($type == "sub-categoria") {

                $sql = "DELETE FROM constituida WHERE super_categoria = '$nome_super' AND categoria = '$nome_sub';";
                $db->query($sql);

                $sql = "DELETE FROM categoria WHERE nome = '$nome_sub';";
                $db->query($sql);
            }

        }
        if ($mode == "add") {
            if ($type == "categoria") {

                $sql = "INSERT INTO categoria VALUES('$nome');";
                $db->query($sql);
                

                if ($_REQUEST['cat']=="catsimp") {

                    $sql = "INSERT INTO categoria_simples VALUES('$nome');";
                    $db->query($sql);

                }

                if ($_REQUEST['cat']=="supercat") {

                    $sql = "INSERT INTO super_categoria VALUES('$nome');";
                    $db->query($sql);

                }
            }

            if ($type == "sub-categoria") {

                $sql = "INSERT INTO categoria VALUES('$nome_sub');";
                $db->query($sql);

                $sql = "INSERT INTO categoria_simples VALUES('$nome_sub');";
                $db->query($sql);

                $sql = "INSERT INTO constituida VALUES('$nome_super', '$nome_sub');";
                $db->query($sql);

            }
        }

        $sql = "END;";
        $db->query($sql);


        echo("<div style=\"margin: 0 auto; padding-right: 30px; display: inline-block;\"><h3>Constituida</h3>\n");
        $sql = "SELECT * FROM constituida;";
        $result = $db->query($sql);
        echo("<table style=\"margin: 0 auto;\" border=\"1\">\n");
        echo("<tr><td><b>super_categoria</b></td><td><b>categoria</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['super_categoria']);
            echo("</td><td>");
            echo($row['categoria']);
            echo("</td></tr>\n");
        }
        echo("</table></div>\n");


        echo("<div style=\"margin: 0 auto; padding-right: 30px; display: inline-block;\"><h3>Categoria</h3>\n");
        $sql = "SELECT * FROM categoria;";
        $result = $db->query($sql);
        echo("<table style=\"margin: 0 auto;\" border=\"1\">\n");
        echo("<tr><td><b>nome</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['nome']);
            echo("</td></tr>\n");
        }
        echo("</table></div>\n");
        echo("<div style=\"margin: 0 auto; padding-right: 30px; display: inline-block;\"><h3>Categoria Simples</h3>\n");



        $sql = "SELECT * FROM categoria_simples;";
        $result = $db->query($sql);
        echo("<table style=\"margin: 0 auto;\" border=\"1\">\n");
        echo("<tr><td><b>nome</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['nome']);
            echo("</td></tr>\n");
        }
        echo("</table></div>\n");


        echo("<div style=\"margin: 0 auto; padding-right: 30px; display: inline-block;\"><h3>Super Categoria</h3>\n");


        $sql = "SELECT * FROM super_categoria;";
        $result = $db->query($sql);
        echo("<table border=\"1\">\n");
        echo("<tr><td><b>nome</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['nome']);
            echo("</td></tr>\n");
        }
        echo("</table></div>\n");
        
        $db = null;
        $prep = null;
    }
    catch (PDOException $e)
    {
        echo("<p>Ocorreu um erro na ligação à base de dados. Verifique que introduziu corretamente os dados e que tem ligação à internet.\n\n Detalhes: {$e->getMessage()}</p><br><a href=\"a.php\"> < Voltar</a>");
    }
?>
        <br>
        <br><br>
        <h3>Adicionar nova categoria</h3>
        <form action='a.php' method='post'>
            <p><input type='hidden' name='mode' value='add'/></p>
            <p><input type='hidden' name='type' value='categoria'/></p>
            <p>Nome da nova categoria: <input type='text' name='nome' required/></p>
            <p><input type="radio" name="cat" value="catsimp"/> Categoria Simples<input type="radio" name="cat" value="supercat" /> Super Categoria<br /></p>
            <p><input type='submit' value='Submeter'/></p>
        </form>
        <br>
        <h3>Adicionar nova sub-categoria</h3>
        <form action='a.php' method='post'>
            <p><input type='hidden' name='mode' value='add'/></p>
            <p><input type='hidden' name='type' value='sub-categoria'/></p>
            <p>Nome da nova sub-categoria: <input type='text' name='nome_sub' required/></p>
            <p>Nome da super-categoria: 
                <select name='nome_super' required>
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
            <p><input type='submit' value='Submeter'/></p>
        </form>
        <br>
        <h3>Remover categoria</h3>
        <form action='a.php' method='post'>
            <p><input type='hidden' name='mode' value='remove'/></p>
            <p><input type='hidden' name='type' value='categoria'/></p>
            <p>Nome da categoria a remover: <select name='nome' required>
                    <?php
                        include 'config.php';
                        $sql = "SELECT nome FROM categoria;";
                        $result = $db->query($sql);
                        foreach($result as $row)
                        {
                            echo '<option value="'.htmlspecialchars($row['nome']).'">' . $row['nome'] . '</option>';
                        }
                    ?>
                </select></p>
            <p><input type='submit' value='Submeter'/></p>
        </form>
        <br>
        <h3>Remover sub-categoria</h3>
        <form action='a.php' method='post'>
            <p><input type='hidden' name='mode' value='remove'/></p>
            <p><input type='hidden' name='type' value='sub-categoria'/></p>
            <p>Nome da sub-categoria a remover: <select name='nome_sub' required>
                    <?php
                        include 'config.php';
                        $sql = "SELECT nome FROM categoria_simples;";
                        $result = $db->query($sql);
                        foreach($result as $row)
                        {
                            echo '<option value="'.htmlspecialchars($row['nome']).'">' . $row['nome'] . '</option>';
                        }
                    ?>
                </select></p>
            <p>Nome da super-categoria da sub-categoria a remover: <select name='nome_super' required>
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
            <p><input type='submit' value='Submeter'/></p>
        </form>
        <br><br>
    </body>
</html>
