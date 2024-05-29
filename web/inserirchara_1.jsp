<%-- 
    Document   : inserirchara
    Created on : 6 de abr. de 2024, 21:45:45
    Author     : Jonathan
--%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/estilo.css">
    <title>Criar Personagem</title>

    <script>
        function validarCadastro() {
            var nome_cadastro = frmCadastrarChara.nome_cad.value;

            if (nome_cadastro === "") {
                alert('Insira o nome do personagem');
                frmCadastrarChara.nome_cad.focus();
                return false;
            } else if (img_link.value === "" || img_link.value === undefined){
                img_link.value = "img/chara_padrao.jpg";
                
            }else {
                alert('Personagem inserido com sucesso!');
            }
        }
        function desesconde(){
            img_link.style.color = "rgba(0, 0, 0, 1)";
        }
    </script>
    <script src=""></script>
</head>

<body>
    <%
        int id_usuario = (Integer) session.getAttribute("id");
    %>
    <div class="container">
        <div class="content">
            <div id="cadastro">
                <form name="frmCadastrarChara" action="CadastroChara" method="post">
                    <h1>Criar Personagem</h1>

                    <p>
                        <input type="hidden" name="charaId" value="<%=id_usuario%>">
                        <label for="nome_cad">Nome do personagem</label>
                        <input type="text" id="nome_cad" name="charaNome" 
                               placeholder="Nome" required />
                    </p>

                    <p>
                        <label for="descricao">Descrição</label><br>
                        <textarea name="charaDesc" id="descricao" 
                                  placeholder="Descreva seu personagem..." rows="4"></textarea>
                    </p>

                    <p>
                        <label for="img_link">Link da Imagem</label>
                        <input type="text" name="charaLink" id="img_link" 
                               placeholder="link da imagem" onblur="carregaImagem()"
                               onclick="desesconde()">
                    </p>
                    <p name="img_out" id="img_out">
                        <img src="" name="img_output">
                    </p>
                    <script>
                        function carregaImagem(){
                            if (img_link.value != "" && img_link.value != undefined){
                                img_output.src = img_link.value
                                img_out.style.display = "block"
                            }
                        }
                    </script>
                    <p>
                        <input type="submit" value="Criar" onclick="return validarCadastro()">
                    </p>
                    <p class="link">
                        <a href="logado.jsp">Voltar</a>
                    </p>
                </form>
            </div>

        </div>
    </div>
</body>
</html>

