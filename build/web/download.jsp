<%-- 
    Document   : downlaod
    Created on : 18 de mai. de 2024, 17:45:10
    Author     : Jonathan
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
    </head>
    <body>
        <p>
            insert into usuario (nome_usuario, email_usuario, senha_usuario, ativado_usuario, id_cargo_fk) values<br>
            <%
                int id_cargo_fk = 0;
                Boolean ativado_usuario = true;
                String nome_usuario = "";
                String email_usuario = "";
                String senha_usuario = "";
                

                Connection conn3 = CriarConexao.getConexao();
                Statement stmt3 = conn3.createStatement();
                ResultSet rs3 = stmt3.executeQuery("select * from usuario");
                while (rs3.next()){
                    id_cargo_fk = rs3.getInt("id_cargo_fk");
                    nome_usuario = rs3.getString("nome_usuario");
                    email_usuario = rs3.getString("email_usuario");
                    senha_usuario = rs3.getString("senha_usuario");
                    ativado_usuario = rs3.getBoolean("ativado_usuario");
            %>
            ("<%=nome_usuario%>", "<%=email_usuario%>", "<%=senha_usuario%>", <%=ativado_usuario%>, <%=id_cargo_fk%>),<br>
            <% }            
                rs3.close();
                stmt3.close();
                conn3.close();
            %>;
        </p>
        <p>
            insert into usuario (id_usuario_fk, nome_chara, descricao_chara, img_link_chara) values<br>
            <%
                int id_usuario_fk = 0;
                String nome_chara = "";
                String descricao_chara = "";
                String img_link_chara = "";
                

                Connection conn = CriarConexao.getConexao();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("select * from chara");
                while (rs.next()){
                    id_usuario_fk = rs.getInt("id_usuario_fk");
                    nome_chara = rs.getString("nome_chara");
                    descricao_chara = rs.getString("descricao_chara");
                    img_link_chara = rs.getString("img_link_chara");
            %>
            (<%=id_usuario_fk%>, "<%=nome_chara%>", "<%=descricao_chara%>", "<%=img_link_chara%>"),<br>
            <% }            
                rs.close();
                stmt.close();
                conn.close();
            %>;
        </p>
        <a href="deleta/amor pt.pdf" download><button>Baixar</button></a>
    </body>
</html>
