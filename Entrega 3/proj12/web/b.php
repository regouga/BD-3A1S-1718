<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript">
     function addFields(){
            var number = document.getElementById("member").value;
            var container = document.getElementById("container");

            while (container.hasChildNodes()) {
                container.removeChild(container.lastChild);
            }

            for (i=0;i<number;i++){

                container.appendChild(document.createTextNode("NIF do Fornecedor Secundário " + (i+1)));
                var input = document.createElement("input");
                input.type = "text";
                input.name = "forece_sec_nif_" + i;
                input.id = "forece_sec_nif_" + i;
                container.appendChild(input);


                container.appendChild(document.createTextNode("Nome do Fornecedor Secundário " + (i+1)));
                var input = document.createElement("input");
                input.type = "text";
                input.name = "forece_sec_nome_" + i;
                input.id = "forece_sec_nome_" + i;
                container.appendChild(input);
                container.appendChild(document.createElement("br"));
            }
        }   
    </script>
  </head>
    <body>
    	<font face="helvetica">
        <button style="width: 200px; height: 40px;" onclick="window.location='index.html';">< Voltar</button><br><br>
<?php
    try
    {
        include 'config.php';

        $ean = $_POST['ean'];
        $design = $_POST['design'];
        $categoria = $_POST['categoria'];
        $data = $_POST['data'];
        $forn_primario_nif = $_POST['forn_primario_nif'];
        $forn_primario_nome = $_POST['forn_primario_nome'];
        $forn_secundario_nif = $_POST['forn_secundario_nif'];
        $forn_secundario_nome = $_POST['forn_secundario_nome'];


        $mode = isset($_REQUEST['mode']) ? $_REQUEST['mode'] : '';

        $sql = "START TRANSACTION;";
        $db->query($sql);

        if ($mode == "remove") {

        	$sql = "DELETE FROM produto WHERE ean = '$ean';";
            $db->query($sql);

            $sql = "DELETE FROM fornece_sec WHERE ean = '$ean;'";
            $db->query($sql);


        }

	    if ($mode == "add") {

	    	$numberSecs = $_REQUEST['member'];
	        $fornecedoresSecs_NIF = array();
	        $fornecedoresSecs_NOME = array();

	        for ($i = 0; $i < $numberSecs; $i++) {

	        	$natual = $i;
	        	$text1 = 'forece_sec_nif_';
	        	$conc1 = $text1 . $natual;

	        	$atualForneceSecNIF = $_REQUEST[$conc1];
	        	$fornecedoresSecs_NIF[$i] = $atualForneceSecNIF;

	        	$text2 = 'forece_sec_nome_';
	        	$conc2 = $text2 . $natual;

	        	$atualForneceSecNOME = $_REQUEST[$conc2];
	        	$fornecedoresSecs_NOME[$i] = $atualForneceSecNOME;
        	}

        	$sql = "INSERT INTO fornecedor (nif, nome) SELECT $forn_primario_nif, '$forn_primario_nome' WHERE not exists (SELECT nif FROM fornecedor WHERE nif=$forn_primario_nif);";
            $db->query($sql);

            
            $sql = "INSERT INTO produto VALUES($ean, '$design', '$categoria', $forn_primario_nif, '$data');";
            $db->query($sql);

            for ($i = 0; $i < $numberSecs; $i++) {

            	 $sql = "INSERT INTO fornecedor (nif, nome) SELECT $fornecedoresSecs_NIF[$i], '$fornecedoresSecs_NOME[$i]' WHERE not exists (SELECT nif FROM fornecedor WHERE nif=$fornecedoresSecs_NIF[$i]);";
            	$db->query($sql);

            	$sql = "INSERT INTO fornece_sec values ($fornecedoresSecs_NIF[$i], $ean);";
            	$db->query($sql);

        	}

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


        if (isset($_POST['submeter'])) {
            $ean = $_POST['ean'];

            echo("<h3>Fornecedores</h3>\n");
            
            $sql = "SELECT * FROM fornecedor;";
            $result = $db->query($sql);

            echo("<table border=\"1\">\n");
            echo("<tr><td><b>nif</b></td><td>nome</td></tr>\n");
            foreach($result as $row)
            {
                echo("<tr><td>");
                echo($row['nif']);
                echo("</td><td>");
                echo($row['nome']);
                echo("</td></tr>\n");
            }
            echo("</table>\n");


            echo("<h3>Fornecedores Secundários</h3>\n");
            
            $sql = "SELECT * FROM fornece_sec;";
            $result = $db->query($sql);

            echo("<table border=\"1\">\n");
            echo("<tr><td><b>nif</b></td><td>ean</td></tr>\n");
            foreach($result as $row)
            {
                echo("<tr><td>");
                echo($row['nif']);
                echo("</td><td>");
                echo($row['ean']);
                echo("</td></tr>\n");
            }
            echo("</table>\n\n");
            
            $db = null;
            $prep = null;
       }
    }
    catch (PDOException $e)
    {
        echo("<p>Ocorreu um erro.<br>Verifique que introduziu os dados na forma correta.<br>Assegure que a categoria com o nome introduzido não existe atualmente na base de dados.<br><br> Detalhes: {$e->getMessage()}</p><br><a href=\"b.php\"> < Voltar</a>");
    }
?>

        <h3>Adicionar produto e seus respetivos fornecedores</h3>
        <form action='b.php' method='post'>
            <p><input type='hidden' name='mode' value='add'/></p>
            <p>EAN do Produto: <input type='text' name='ean' required/></p>
            <p>Designação do Produto: <input type='text' name='design' required/></p>
            <p>Categoria do Produto: <select name='categoria' required>
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
            <p>NIF do Fornecedor Primário do Produto: <input type='text' name='forn_primario_nif' required/></p>
            <p>Nome do Fornecedor Primário do Produto: <input type='text' name='forn_primario_nome' required/></p>
            <p>Data de início do fornecimento (formato AAAA-MM-DD): <input type='text' name='data' required/></p>
            <p>Número de Fornecedor secundários:<input type="text" id="member" name="member" required value=""><br />
    		<a href="#" id="filldetails" onclick="addFields()">Submeter número de fornecedores</a>
    		<div id="container"/></div></p>
            <p><input type='submit' name='submeter' value='Submeter'/></p>
        </form>
        <br>
        <br>
        <h3>Remover produto e seus respetivos fornecedores</h3>
        <form action='b.php' method='post'>
            <p><input type='hidden' name='mode' value='remove'/></p>
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
