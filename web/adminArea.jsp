<%-- 
    Document   : logado
    Created on : 08/03/2024, 10:51:31
    Author     : laboratorio
--%>
<%@page import="br.com.conexao.CriarConexao"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" 
        pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Logado</title>
        <link href="css/cores.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/nav.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <%
            String email_s = (String) session.getAttribute("email");
            String nome_s = (String) session.getAttribute("nome");
            int cargo_s = (Integer) session.getAttribute("cargo");            
        %>
        
        <div id="nav">
        <script>
            $(function(){
              $("#nav").load("nav.jsp");
            });
        </script>
        </div>
        <div id="body2"> 
            <div id="container">
                <a href="gerenciarusuario.jsp"><div id="m_usuario" class="box">Manter Usu�rios</div></a>
                <a href="gerenciarchara.jsp"><div id="m_personagem" class="box">Manter Personagens</div></a>
            </div>
        </div>
    </body>
</html>
