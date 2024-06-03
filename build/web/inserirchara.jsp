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
        <link href="css/cores.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/nav.css">
        <link rel="stylesheet" type="text/css" href="css/style3.css">
        <link rel="stylesheet" type="text/css" href="css/modal.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <title>Criar Personagem</title>

        <script>
            function validarCadastro() {
                var nome_cadastro = charaNome.value;

                if (nome_cadastro === "") {
                    alert('Insira o nome do personagem');
                    charaNome.focus();
                    return false;
                } else if (img_link.value === "" || img_link.value === undefined) {
                    img_link.value = "img/chara_padrao.jpg";

                } else {
                    alert('Personagem inserido com sucesso!');
                }
            }

            function carregaImagem() {
                if (charaLink.value !== "" && charaLink.value !== undefined) {
                    modalImg.src = charaLink.value;
                    modalImg.style.display = "block";
                } else{
                    modalImg.style.display = "none";
                }
            }

            function carregaJson() {
                let files = document.getElementById('seleciona').files;
                console.log(files);
                if (files.length <= 0) {
                    return false;
                }

                let fr = new FileReader();

                fr.onload = function (e) {
                    console.log(e);
                    let result = JSON.parse(e.target.result);                                        
                    charaLink.value = result.img_link_chara;
                    charaNome.value = result.nome_chara;
                    document.getElementById('charaDesc').value = result.descricao_chara;
                    carregaImagem();
                }
                
                fr.readAsText(files.item(0));
                
                
            };

        </script>
    </head>

    <body>
        <%
            int id_usuario = (Integer) session.getAttribute("id");
        %>
        <script>
            $(function () {
                $("#nav").load("nav.jsp");
            });
        </script>
        <div id="nav"></div>

        <div id="modalCadastro">
            <div class="modalConteudo">  
                <div class="modalCharaHead">
                    <p>Adicionar Personagem</p>               
                </div>
                <div id="modalImgContainer">
                    <img src="" id="modalImg" name="modalImg">
                </div>
                <form class="charaForm" action="CadastroChara" method="post">
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label for="charaNome">Nome: </label><input type="text" name="charaNome" id="charaNome" maxlength="25" >
                            <input type="hidden" name="charaId" id="charaId" value="<%=id_usuario%>">
                        </div>                 
                    </div>
                    <div class="charaFormDesc">
                        Descrição:
                        <textarea name="charaDesc" id="charaDesc"></textarea>
                    </div>
                    <div class="charaFormLink">
                        <label for="charaLink">Link: </label><input type="text" 
                                                                    id="charaLink" name="charaLink" 
                                                                    onblur="carregaImagem()">
                        <input type="hidden" name="location" value="listarchara">
                    </div>
                    <div id="ImportaChara">
                        <input type="file" id="seleciona" value="Import" /><br />
                        <button id="importa" onclick="carregaJson()" type="button">Importar Personagem</button>
                    </div>
                    <button onclick="return validarCadastro()">Adicionar novo personagem</button>
                </form>
                
            </div>
        </div>

    </body>
</html>

