<%-- 
    Document   : chat
    Created on : 5 de jun. de 2024, 14:15:49
    Author     : Jonathan
--%>

<%@page import="br.com.conexao.CriarConexao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" 
        pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logado</title>
        <link href="css/cores.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/nav.css">
        <link rel="stylesheet" type="text/css" href="css/style3.css">
        <link rel="stylesheet" type="text/css" href="css/chat.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <%
            String email_s = (String) session.getAttribute("email");
            String nome_s = (String) session.getAttribute("nome");
            int cargo_s = (Integer) session.getAttribute("cargo");
            int id_s = (Integer) session.getAttribute("id");
            Connection conn = CriarConexao.getConexao();

            int id_usuario = Integer.valueOf(request.getParameter("us"));
            int id_chat = 0;

            String sql = "insert into chat (id_usuario1_fk,id_usuario2_fk) "
                    + "select ?,? where not exists "
                    + "(select 1 from chat "
                    + "where (id_usuario1_fk = ? and id_usuario2_fk = ?) or (id_usuario1_fk = ? and id_usuario2_fk = ?))";
            try {
                PreparedStatement stmt = conn.prepareStatement(sql);

                stmt.setInt(1, id_s);
                stmt.setInt(2, id_usuario);
                stmt.setInt(3, id_s);
                stmt.setInt(4, id_usuario);
                stmt.setInt(5, id_usuario);
                stmt.setInt(6, id_s);

                stmt.execute();
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            sql = "select * from chat where (id_usuario1_fk = " + id_s
                    + " and id_usuario2_fk = " + id_usuario + ") or "
                    + "(id_usuario1_fk = " + id_usuario + " "
                    + "and id_usuario2_fk = " + id_s + ")";
            Statement stmt2 = conn.createStatement();
            ResultSet rs = stmt2.executeQuery(sql);
            if (rs.next()) {
                id_chat = rs.getInt("id_chat");
            }
        %>
        <script src="js/modal.js" type="text/javascript"></script>

        <div id="nav"></div>
        <div id="chatWindow">
            <div id="chatContainer">
                <%
                    sql = "select cm.*,u.nome_usuario from chat_mensagem cm "
                            + "inner join usuario u on "
                            + "cm.id_usuario_fk = u.id_usuario "
                            + "where id_chat_fk = " + id_chat + " order by data_hora_cm";
                    int id_cm = 0;
                    int id_usuario_fk = 0;
                    String nome_usuario = "";
                    String mensagem_cm = "";
                    String data_hora_cm = "";

                    Statement stmt3 = conn.createStatement();
                    ResultSet rs2 = stmt3.executeQuery(sql);
                    while (rs2.next()) {
                        id_cm = rs2.getInt("id_cm");
                        id_usuario_fk = rs2.getInt("id_usuario_fk");
                        nome_usuario = rs2.getString("nome_usuario");
                        mensagem_cm = rs2.getString("mensagem_cm");
                        data_hora_cm = rs2.getString("data_hora_cm");
                %>
                <div class="chatMessage">
                    <span class="msgName"><%=nome_usuario%></span>
                    <span class="msgText"><%=mensagem_cm%></span>
                    <span class="msgTime"><%=data_hora_cm%></span>
                </div>
                <%
                    }
                    conn.close();
                    stmt2.close();
                    stmt3.close();
                    rs.close();
                    rs2.close();
                %>
            </div>
            <div id="chatPanel">
                <form action="ChatServlet" method="POST">
                    <textarea name="cm_msg"></textarea>
                    <input type="hidden" name="id_chat" value="<%=id_chat%>">
                    <input type="hidden" name="id_usuario" value="<%=id_s%>">
                    <input type="hidden" name="location" value="chat.jsp?us=<%=id_usuario%>">
                    <button>Enviar</button>
                </form>
            </div>
        </div>
    </body>
    <script>
        $(function () {
            $("#nav").load("nav.jsp");
        });
        document.getElementById("chatPanel").querySelector("textarea").focus();
    </script>
</html>
