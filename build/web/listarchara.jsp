<%-- 
    Document   : listarchara
    Created on : 7 de abr. de 2024, 22:59:49
    Author     : Jonathan
--%>

<%@page import="br.com.conexao.CriarConexao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.com.sap.CharaDAO"%>
<%@page import="br.com.sap.Categoria"%>
<%@page language="java" contentType="text/html; -UTF-8" 
        pageEncoding="UTF-8" import="java.sql.*"%>
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
            Connection conn = CriarConexao.getConexao();
            CharaDAO chara = new CharaDAO(conn);

            ArrayList<Categoria> cats = new ArrayList<Categoria>();

            String acao = request.getParameter("acao");
            if ("dl".equals(acao)) {
                int ct = Integer.valueOf(request.getParameter("ct"));
                int ch = Integer.valueOf(request.getParameter("ch"));
                String sql = "delete from categoria_chara where id_chara_fk = ? and id_categoria_fk = ?";
                PreparedStatement stmt_dl = conn.prepareStatement(sql);
                stmt_dl.setInt(1, ch);
                stmt_dl.setInt(2, ct);
                stmt_dl.execute();
                stmt_dl.close();

            }
            if ("in".equals(acao)) {
                int ct = Integer.valueOf(request.getParameter("ct"));
                int ch = Integer.valueOf(request.getParameter("ch"));
                String sql = "delete from categoria_chara where id_chara_fk = ?";
                PreparedStatement stmt_dl = conn.prepareStatement(sql);
                stmt_dl.setInt(1, ch);
                //stmt_dl.setInt(2, ct);
                stmt_dl.execute();
                sql = "insert into categoria_chara (id_chara_fk, id_categoria_fk) values (?,?)";
                stmt_dl = conn.prepareStatement(sql);
                stmt_dl.setInt(1, ch);
                stmt_dl.setInt(2, ct);
                stmt_dl.execute();
                stmt_dl.close();

            }

            int us_id = id_s;
            if (request.getParameter("us") != null) {
                us_id = Integer.parseInt(request.getParameter("us"));
            }

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from categoria where id_usuario_fk = " + us_id);
            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId_categoria(rs.getInt("id_categoria"));
                c.setId_usuario_fk(rs.getInt("id_usuario_fk"));
                c.setNome_categoria(rs.getString("nome_categoria"));
                c.setDescricao_categoria(rs.getString("descricao_categoria"));
                cats.add(c);
            }
            rs.close();
            stmt.close();
        %>

        <script src="js/modal.js" type="text/javascript"></script>
        <div id="nav"></div>
        <div class="corpo">
            
            <%
                if (us_id == id_s){
            %>
            
            <div class="botoes">
                <button onclick="abreModal('modalCadastro')">Nova Categoria</button>
                <a href="inserirchara.jsp"><button>Novo Personagem</button></a>
            </div>
            <hr>
            
            <%
                }
                if (chara.charaSemCategoria(us_id)) {
            %>
            <div class="categoria">
                <h3>Sem Categoria</h3>
                <hr>
                <div class="chara_container">
                    <%
                        int id_categoria = 0;
                        int id_usuario_fk = 0;
                        String nome_categoria = "";
                        String descricao_categoria = "";
                        int id_categoria_t = 0;
                        int id_usuario_fk_t = 0;
                        String nome_categoria_t = "";
                        String descricao_categoria_t = "";
                        int id_chara = 0;
                        String nome_usuario_c = "";
                        String nome_chara = "";
                        String descricao_chara = "";
                        String img_link_chara = "";

                        Statement stmt2 = conn.createStatement();
                        ResultSet rs2 = stmt2.executeQuery("select * from chara c"
                                + " left join categoria_chara cc on c.id_chara = cc.id_chara_fk "
                                + "where id_usuario_fk = " + us_id + " and id_categoria_fk is null");
                        while (rs2.next()) {
                            id_chara = rs2.getInt("id_chara");
                            id_usuario_fk = rs2.getInt("id_usuario_fk");
                            nome_chara = rs2.getString("nome_chara");
                            descricao_chara = rs2.getString("descricao_chara");
                            img_link_chara = rs2.getString("img_link_chara");
                    %>

                    <div class="chara" data-id="<%=id_chara%>" id='c_<%=id_chara%>'>
                        <a href="chara.jsp?charaId=<%=id_chara%>"><img src="<%=img_link_chara%>">
                            <div class="nome_chara"><%=nome_chara%></div></a>


                        <ul class="moverCategoria" data-id="<%=id_chara%>" id="mc_<%=id_chara%>">


                            <%
                                for (Categoria c2 : cats) {
                                    id_categoria_t = c2.getId_categoria();
                                    id_usuario_fk_t = c2.getId_usuario_fk();
                                    nome_categoria_t = c2.getNome_categoria();
                                    descricao_categoria_t = c2.getDescricao_categoria();
                            %>
                            <a href="listarchara.jsp?ct=<%=id_categoria_t%>&ch=<%=id_chara%>&acao=in"><li 
                                    id="c_<%=id_categoria_t%>"><%=nome_categoria_t%></li></a>
                                    <%
                                        }
                                    %>
                        </ul>
                    </div>

                    <%
                        }
                        rs2.close();
                        stmt2.close();
                    %>
                </div>
            </div>
            <%
                }

                int id_categoria = 0;
                int id_usuario_fk = 0;
                String nome_categoria = "";
                String descricao_categoria = "";
                int id_categoria_t = 0;
                int id_usuario_fk_t = 0;
                String nome_categoria_t = "";
                String descricao_categoria_t = "";
                int id_chara = 0;
                String nome_usuario_c = "";
                String nome_chara = "";
                String descricao_chara = "";
                String img_link_chara = "";

                for (Categoria c : cats) {
                    id_categoria = c.getId_categoria();
                    id_usuario_fk = c.getId_usuario_fk();
                    nome_categoria = c.getNome_categoria();
                    descricao_categoria = c.getDescricao_categoria();

            %>
            <div class="categoria">
                <h3><%=nome_categoria%></h3>
                <div class="hoverDesc"><%=descricao_categoria%></div>
                <hr>
                <div class="chara_container">
                    <%
                        Statement stmt3 = conn.createStatement();
                        ResultSet rs3 = stmt3.executeQuery("select * from chara c"
                                + " left join categoria_chara cc on c.id_chara = cc.id_chara_fk "
                                + "where id_usuario_fk = " + us_id + " and id_categoria_fk =" + id_categoria);
                        while (rs3.next()) {
                            id_chara = rs3.getInt("id_chara");
                            id_usuario_fk = rs3.getInt("id_usuario_fk");
                            nome_chara = rs3.getString("nome_chara");
                            descricao_chara = rs3.getString("descricao_chara");
                            img_link_chara = rs3.getString("img_link_chara");
                    %>


                    <div class="chara" data-id="<%=id_chara%>" id='c_<%=id_chara%>'>
                        <a href="chara.jsp?charaId=<%=id_chara%>"><img src="<%=img_link_chara%>">
                            <div class="nome_chara"><%=nome_chara%></div></a>
                        <ul class="moverCategoria" data-id="<%=id_chara%>" id="mc_<%=id_chara%>">
                            <a href="listarchara.jsp?ct=<%=id_categoria%>&ch=<%=id_chara%>&acao=dl">
                                <li>Sem categoria</li></a>
                                    <%
                                        for (Categoria c3 : cats) {
                                            id_categoria_t = c3.getId_categoria();
                                            id_usuario_fk_t = c3.getId_usuario_fk();
                                            nome_categoria_t = c3.getNome_categoria();
                                            descricao_categoria_t = c3.getDescricao_categoria();
                                            if (id_categoria_t != id_categoria) {
                                    %>
                            <a href="listarchara.jsp?ct=<%=id_categoria_t%>&ch=<%=id_chara%>&acao=in"><li 
                                    id="c_<%=id_categoria_t%>"><%=nome_categoria_t%></li></a>
                                    <%
                                            }
                                        }
                                    %>
                        </ul>
                    </div>

                    <%
                        }
                        rs3.close();
                        stmt3.close();
                    %>
                </div>
            </div>
            <% }


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
                        <input type="hidden" name="idUsuario" value="<%=us_id%>">
                        <input type="hidden" name="location" value="listarchara">
                        <button>Criar nova Categoria</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
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
        function mostraCats(i) {
            let charas = document.getElementsByClassName("chara");
            let c = charas[i].getAttribute("data-id");
            let mc = document.getElementById("mc_" + c);

            if (window.innerWidth - charas[i].getBoundingClientRect().right < 100) {
                mc.classList.add("esquerda")
            }
            if (mc.querySelector("a") !== null){
                mc.style.display = "flex"
            }
            
        }
        function escondeCats(i) {
            let charas = document.getElementsByClassName("chara");
            let c = charas[i].getAttribute("data-id");
            let mc = document.getElementById("mc_" + c);
            mc.style.display = "none"
        }
        <%
            if(us_id == id_s){
        %>
        let charas = document.getElementsByClassName("chara");
        let mvCat = document.getElementsByClassName("moverCategoria");
        for (let i = 0; i < charas.length; i++) {
            console.log(charas[i].getAttribute("data-id"));
            charas[i].addEventListener("mouseenter", function () {
                mostraCats(i);
            })
            charas[i].addEventListener("mouseleave", function () {
                escondeCats(i);
            })
        }
        for (let i = 0; i < mvCat.length; i++) {
            mvCat[i].addEventListener("mouseleave", function () {
                escondeCats(i);
            })
        }
        <%
            }
        %>
        
    </script>
    <%
        conn.close();
    %>
</html>
