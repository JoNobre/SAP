<%-- 
    Document   : listarchara
    Created on : 7 de abr. de 2024, 22:59:49
    Author     : Jonathan
--%>

<%@page import="br.com.conexao.CriarConexao"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" 
        pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Personagens</title>
        <link href="css/cores.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/nav.css">
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        <link href="css/modalListarchara.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <%
            String email_s = (String) session.getAttribute("email");
            String nome_s = (String) session.getAttribute("nome");
            int cargo_s = (Integer) session.getAttribute("cargo");
            int id_s = (Integer) session.getAttribute("id");
        %>
        <script>
            $(function () {
                $("#nav").load("nav.jsp");
            });

            function mostra(string) {
                img_hover.src = string;
                img_hover.style.display = "block"
            }
            function esconde() {
                img_hover.src = ""
                img_hover.style.display = "none"
            }
        </script>
        <script src="js/modal.js" type="text/javascript"></script>
        <div id="nav"></div>
        <div class="corpo">
            <div class="botoes">
                <button onclick="abreModal('modalCadastro')">Nova Categoria</button>
                <button>Novo Personagem</button>
            </div>
            <hr>
            <%
                int id_categoria = 0;
                int id_usuario_fk = 0;
                String nome_categoria = "";
                String descricao_categoria = "";

                Connection conn = CriarConexao.getConexao();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("select * from categoria where id_usuario_fk = "+id_s);
                while (rs.next()) {
                    id_categoria = rs.getInt("id_categoria");
                    id_usuario_fk = rs.getInt("id_usuario_fk");
                    nome_categoria = rs.getString("nome_categoria");
                    descricao_categoria = rs.getString("descricao_categoria");

            %>
            <div class="categoria">
                <h3><%=nome_categoria%></h3>
                <div class="hoverDesc"><%=descricao_categoria%></div>
                <hr>
            </div>
            <% }
                rs.close();
                stmt.close();
                conn.close();
            %>
            <div class="modal" id="modalCadastro">
                <div class="modalConteudo"> 
                    <div class="modalHead">
                        <h1>Nova Categoria</h1>
                        <span class="fechaModal" onclick="fechaModal('modalCadastro')">&times;</span>
                    </div>
                    <form class="modalForm" action="CadastroCategoria" method="post">
                        <div class="inlineInput">
                            <label for="nomeCat">Nome: </label>
                            <input type="text" required maxlength="20" name="nomeCat" id="nomeCat">
                        </div>
                        <div class="blockInput">
                            <label for="descCat">Descrição:</label>
                            <textarea name="descCat" id="descCat"></textarea>
                        </div>
                        <input type="hidden" name="idUsuario" value="<%=id_s%>">
                        <input type="hidden" name="location" value="listarchara">
                        <button>Criar nova Categoria</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
