<%-- 
    Document   : chara
    Created on : 17/05/2024, 08:55:14
    Author     : laboratorio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="br.com.conexao.CriarConexao"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/cores.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/nav.css">
        <link rel="stylesheet" type="text/css" href="css/pesquisa.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <div id="nav"></div>
        <div class="dPesquisa">
            <button id="btnquem" value="us">Usuário</button>
            <input type="text" name="pesquisar" placeholder="Pesquisar" id="txtpesquisar">
            <img src="img/loupe.png" alt="" id="btnpesquisar"/>
        </div>
        <%
            String email_s = (String) session.getAttribute("email");
            String nome_s = (String) session.getAttribute("nome");
            int cargo_s = (Integer) session.getAttribute("cargo");
            
            Connection conn = CriarConexao.getConexao();
            
            int id_usuario = 0;
            String nome = "";
            String img = "img/chara_padrao.jpg";
            
            String n = request.getParameter("n");
            String q = request.getParameter("q");
            if (n != null && n != "") {
                String quem = "";
                if ("us".equals(q)) {
                    quem = "usuario";
                } else {
                    quem = "chara";
                }
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("select * from " + quem + " where nome_" + quem + " "
                        + "like '%" + n + "%'");
                while (rs.next()) {
                    nome = rs.getString("nome_" + quem);
                    if ("ch".equals(q)) {
                        img = rs.getString("img_link_chara");
                    }
        %>

        <div class="entry">
            <img src="<%=img%>" alt=""/>
            <%=nome%>
        </div>

        <%
                }
                rs.close();
                stmt.close();
            }
            
            conn.close();

        %>
        <script>
            $(function () {
                $("#nav").load("nav.jsp");
            });
            btnquem = document.getElementById("btnquem");
            document.getElementById("btnpesquisar").addEventListener("click", pesquisa);
            btnquem.addEventListener("click", troca);
            function pesquisa() {
                txtpesquisar = document.getElementById("txtpesquisar").value
                window.location.href = "pesquisa.jsp?n=" + txtpesquisar + "&q=" + btnquem.value
            }
            function troca() {
                if (btnquem.value == "us") {
                    btnquem.value = "ch"
                    btnquem.innerHTML = "Personagem"
                } else {
                    btnquem.value = "us"
                    btnquem.innerHTML = "Usuario"
                }
            }
        </script>
    </body>
</html>
