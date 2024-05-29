<%
            String nav_nome = (String) session.getAttribute("nome");
            int us_id = (Integer) session.getAttribute("id");
            
        %>
<nav>
    <a href="logado.jsp"><img src="img/sap-logo.png" alt=""/></a>
    
    <ul>
        <li><a href="listarchara.jsp?idUsuario=<%=us_id%>">Personagens</a></li>
        <li><a>Pesquisar</a></li>
        <li><a>Perfil</a></li>
        <li><a href="remover.jsp">Sair</a></li>
    </ul>
    
</nav>