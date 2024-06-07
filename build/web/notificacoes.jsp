<%-- 
    Document   : chara
    Created on : 17/05/2024, 08:55:14
    Author     : laboratorio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="br.com.sap.Notificacao"%>
<%@page import="br.com.sap.NotificacaoDAO"%>
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
        <link rel="stylesheet" type="text/css" href="css/notif.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <div id="nav"></div>
        <div class="notif-list">
        <%
            String email_s = (String) session.getAttribute("email");
            String nome_s = (String) session.getAttribute("nome");
            int cargo_s = (Integer) session.getAttribute("cargo");
            int id_s = (Integer) session.getAttribute("id");
            
            Connection conn = CriarConexao.getConexao();
            Connection conn2 = CriarConexao.getConexao();
            Notificacao n = new Notificacao(id_s);
            NotificacaoDAO dao2 = new NotificacaoDAO(conn2);
            session.setAttribute("notifs",dao2.qtdNotifs(n));
            
            String acao = request.getParameter("acao");
            if("dl".equals(acao)){
                int ex = Integer.valueOf(request.getParameter("ex"));
                String sql = "delete from notificacao where id_notificacao = ?";
                PreparedStatement stmt_dl = conn.prepareStatement(sql);
                stmt_dl.setInt(1, ex);
                stmt_dl.execute();
                stmt_dl.close();
                
            }
            
            int id_notificacao = 0;
            int id_usuario_fk = 0;
            String mensagem_notificacao = "";
            String data_hora_notificacao = "";
            
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("select * from notificacao "
                        + "where id_usuario_fk="+id_s);
                while (rs.next()) {
                    id_notificacao = rs.getInt("id_notificacao");
                    id_usuario_fk = rs.getInt("id_usuario_fk");
                    mensagem_notificacao = rs.getString("mensagem_notificacao");
                    data_hora_notificacao = rs.getString("data_hora_notificacao");
        %>

        <div class="notif">
            <span><%=mensagem_notificacao%></span>
            <span><%=data_hora_notificacao%></span>
            <span class="deleta_n"><a href="notificacoes.jsp?acao=dl&ex=<%=id_notificacao%>">&times;</a></span>
        </div>

        <%
                }
                rs.close();
                stmt.close();
            
            
            conn.close();

        %>
        </div>
        <script>
            $(function () {
                $("#nav").load("nav.jsp");
            });
        </script>
    </body>
</html>
