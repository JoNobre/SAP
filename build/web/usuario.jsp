<%-- 
    Document   : chara
    Created on : 17/05/2024, 08:55:14
    Author     : laboratorio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="br.com.conexao.CriarConexao"%>
<%@page import="java.sql.*"%>
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
            int id_s = (Integer) session.getAttribute("id");
            Connection conn = CriarConexao.getConexao();
        %>
        <script>
            $(function () {
                $("#nav").load("nav.jsp");
            });
        </script>
        <div id="nav"></div>
        <%
            int id_usuario = Integer.valueOf(request.getParameter("usuarioId"));
            String nome_usuario = "";
            String email_usuario = "";
            int ativado_usuario = 1;
            int id_cargo_fk = 3;
            String str_ativado_usuario = "";
            String str_cargo_usuario = "";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from usuario c "
                    + "where id_usuario = " + id_usuario);
            if (rs.next()) {
                nome_usuario = rs.getString("nome_usuario");
                email_usuario = rs.getString("email_usuario");
                ativado_usuario = rs.getInt("ativado_usuario");
                id_cargo_fk = rs.getInt("id_cargo_fk");
                if (ativado_usuario == 1){str_ativado_usuario = "Ativo";}
                else {str_ativado_usuario = "Inativo";}
                switch (id_cargo_fk) {
                        case 1:
                            str_cargo_usuario = "Admnistrador";
                            break;
                        case 2:
                            str_cargo_usuario = "Moderador";
                            break;
                        case 3:
                            str_cargo_usuario = "Usuário";
                            break;
                        default:
                            throw new AssertionError();
                    }
            }

        %>
        <div class="VisuContainer">
            <div clas="VisuConteudo">
                <div class="VisuRow">
                    <label>Nome: </label><span class="VisuLongText"><%=nome_usuario%></span>
                    <%
                        if (cargo_s != 3) {
                    %>

                    <label>Id: </label><span class="VisuShortText" ><%=nome_usuario%></span>

                    <%}%>
                </div>
                <%
                    if (cargo_s != 3) {
                %>

                <div class="VisuRow">
                    <label>Email: </label><span class="VisuLongText"><%=email_usuario%></span>
                </div>
                <div class="VisuRow">
                    <label>Status: </label><span class="VisuLongText"><%=str_ativado_usuario%></span>
                    <label>Cargo: </label><span class="VisuLongText"><%=str_cargo_usuario%></span>
                </div>

                <%}%>
                
                <div class="VisuColumn">
                    <a href="listarchara.jsp?us=<%=id_usuario%>"><button>Ver personagens de <%=nome_usuario%> >>></button></a>
                <%
                    if (id_usuario != id_s){
                %>
                    <a href="chat.jsp?us=<%=id_usuario%>"><button>Conversar com <%=nome_usuario%> >>></button></a>
                <%
                    }
                %>
                </div>

            </div>
        </div>
        <script>

        </script>
    </body>
</html>
