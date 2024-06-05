<%
            String nav_nome = (String) session.getAttribute("nome");
            int us_id = (Integer) session.getAttribute("id");
            int notifs = (Integer) session.getAttribute("notifs");
            
%>
<nav>
    <a href="logado.jsp" id="logo"><img src="img/sap-logo.png" alt=""/></a>
    
    <ul>
        <li><a href="listarchara.jsp">Personagens</a></li>
        <li><a href="pesquisa.jsp">Pesquisar</a></li>
        <li></li>
        <li><a>Perfil</a><a href="notificacoes.jsp">
                <%
                    if (notifs > 0){
                %>
                <span><%=notifs%></span>
                <%
                    }
                %>
                <img src="img/notif.png" alt=""/></a><a href="remover.jsp">Sair</a></li>
    </ul>
    
</nav>