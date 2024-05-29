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
        <link rel="stylesheet" type="text/css" href="css/style3.css">
        <link rel="stylesheet" type="text/css" href="css/modal.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <%
            String email_s = (String) session.getAttribute("email");
            String nome_s = (String) session.getAttribute("nome");
            int cargo_s = (Integer) session.getAttribute("cargo");
        %>
        <script>
            $(function () {
                $("#nav").load("nav.jsp");
            });
        </script>
        <div id="nav"></div>
        <%
            int id_chara = Integer.valueOf(request.getParameter("charaId"));
            int id_usuario_fk = 0;
            String nome_usuario_c = "";
            String nome_chara = "";
            String descricao_chara = "";
            String img_link_chara = "";

            Connection conn = CriarConexao.getConexao();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select c.id_chara, "
                    + "c.id_usuario_fk, u.nome_usuario, c.nome_chara, "
                    + "c.descricao_chara, img_link_chara from chara c "
                    + "inner join usuario u on c.id_usuario_fk = u.id_usuario "
                    + "where id_chara = " + id_chara);
            if (rs.next()) {
                id_chara = rs.getInt("id_chara");
                id_usuario_fk = rs.getInt("id_usuario_fk");
                nome_usuario_c = rs.getString("nome_usuario");
                nome_chara = rs.getString("nome_chara");
                descricao_chara = rs.getString("descricao_chara");
                img_link_chara = rs.getString("img_link_chara");
            }
        %>
        <div class="modalConteudo">    
            <div id="modalImgContainerV">
                <img src="<%=img_link_chara%>" id="modalImgV" name="modalImgV" style="display: block">
            </div>
            <div class="charaForm">
                <div class="charaFormIdNome">
                    <div class="charaFormNome">
                        <label for="charaNome">Nome: </label><span name="charaNomeV" id="charaNomeV" ><%=nome_chara%></span>
                    </div>
                    <div class="charaFormId">
                        <label for="charaId">Id: </label><span name="charaNomeV" id="charaIdV" ><%=id_chara%></span>
                    </div>
                </div>
                <div class="charaFormIdNome">
                    <div class="charaFormNome">
                        <label for="charaNome">Usuario Nome: </label><span name="charaNomeVus" id="charaNomeVus" ><%=nome_usuario_c%></span>
                    </div>
                    <div class="charaFormId">
                        <label for="charaId">Usuario Id: </label><span name="charaIdVus" id="charaIdVus"><%=id_usuario_fk%></span>
                    </div>
                </div>
                <div class="charaFormDesc">
                    Descrição:
                    <span name="charaDescV" id="charaDescV"><%=descricao_chara%></span>
                </div>
                <% if ("img/chara_padrao.jpg".equals(img_link_chara)){ img_link_chara = ""; } else{%>
                <div class="charaFormLink">
                    Link:
                    <span id="charaLinkV" name="charaLinkV"><%=img_link_chara%></span>
                </div>
                <%}%>
                <script>                   
                    window.onload = () => {
                        let jsonChara = '{"nome_chara": "<%=nome_chara%>", "descricao_chara": "<%=descricao_chara%>", "img_link_chara": "<%=img_link_chara%>"}';
                        let dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(jsonChara);
                        document.getElementById("jsonDownload").href = dataStr;
                    };

                </script>
                <a id="jsonDownload" href="e" download="personagem.json" onload="baixa()"><button>Exportar Personagem</button></a>
            </div>
        </div>
        <%
            rs.close();
            stmt.close();
            conn.close();
        %>
    </body>
</html>
