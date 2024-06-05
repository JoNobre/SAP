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
            int id_chara = Integer.valueOf(request.getParameter("charaId"));
            int id_usuario_fk = 0;
            String nome_usuario_c = "";
            String nome_chara = "";
            String descricao_chara = "";
            String img_link_chara = "";

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

            String acao = request.getParameter("acao");
            if ("dl".equals(acao)) {
                int ex = Integer.valueOf(request.getParameter("ex"));
                String sql = "delete from comentario where id_comentario = ?";
                PreparedStatement stmt_dl = conn.prepareStatement(sql);
                stmt_dl.setInt(1, ex);
                stmt_dl.execute();
                stmt_dl.close();

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
                </div>
                <div class="charaFormIdNome">
                    <div class="charaFormNome">
                        <label for="charaNome">Dono: </label><span name="charaNomeVus" id="charaNomeVus" ><%=nome_usuario_c%></span>
                    </div>
                </div>
                <div class="charaFormDesc">
                    Descrição:
                    <span name="charaDescV" id="charaDescV"><%=descricao_chara%></span>
                </div>
                <% if ("img/chara_padrao.jpg".equals(img_link_chara)) {
                        img_link_chara = "";
                    } else {%>
                <div class="charaFormLink">
                    Link:
                    <span id="charaLinkV" name="charaLinkV"><%=img_link_chara%></span>
                </div>
                <%}%>

                <div class="sp_botoes">
                    <a id="jsonDownload" href="e" download="personagem.json" onload="baixa()"><button>Exportar Personagem</button></a>
                    <a id="clonar" href="inserirchara.jsp?n=<%=nome_chara%>&d=<%=descricao_chara%>&l=<%=img_link_chara%>"><button>Clonar Personagem</button></a>
                </div>
            </div>
        </div>
        <div class="secaoComentarios">
            <div id="comentar">
                <form action="CadastroComentarioServlet" method="post">
                    <textarea name="mensagem_comentario" ></textarea>
                    <input type="hidden" name="id_usuario_fk" value="<%=id_s%>">
                    <input type="hidden" name="id_chara_fk" value="<%=request.getParameter("charaId")%>">
                    <input type="hidden" name="nome_chara_fk" value="<%=nome_chara%>">
                    <input type="hidden" name="location" value="chara.jsp?charaId=<%=request.getParameter("charaId")%>">
                    <input type="hidden" name="donoDoChara" value="<%=id_usuario_fk%>">
                    <button>Comentar</button>
                </form>
            </div>
            <%
                int id_comentario = 0;
                int cm_id_usuario_fk = 0;
                String mensagem_comentario = "";
                String nome_usuario = "";
                String data_hora_comentario = "";
                boolean editado_comentario = false;

                rs = stmt.executeQuery("select c.*, u.nome_usuario from comentario c "
                        + "inner join usuario u on c.id_usuario_fk = u.id_usuario"
                        + " where id_chara_fk = " + id_chara
                        + " order by data_hora_comentario DESC");
                while (rs.next()) {
                    id_comentario = rs.getInt("id_comentario");
                    cm_id_usuario_fk = rs.getInt("id_usuario_fk");
                    nome_usuario = rs.getString("nome_usuario");
                    mensagem_comentario = rs.getString("mensagem_comentario");
                    data_hora_comentario = rs.getString("data_hora_comentario");
                    editado_comentario = rs.getBoolean("editado_comentario");

            %>
            <div class="comentario" >
                <span class="cm_nome"><%=nome_usuario%></span>
                <span class="cm_texto" id="cm_id_<%=id_comentario%>"><%=mensagem_comentario%></span>
                <%
                    if (editado_comentario == true) {
                %>
                <span class="cm_editado">(editado)</span>
                <%
                    }
                    if (cm_id_usuario_fk == id_s) {
                %>
                <form action="UpdateComentarioServlet" method="post" 
                      class="up_form" style="display: none">
                    <textarea name="mensagem_comentario" ><%=mensagem_comentario%></textarea>
                    <input type="hidden" name="id_comentario" value="<%=id_comentario%>">
                    <input type="hidden" name="nome_chara_fk" value="<%=nome_chara%>">
                    <input type="hidden" name="donoDoChara" value="<%=id_usuario_fk%>">
                    <input type="hidden" name="location" 
                           value="chara.jsp?charaId=<%=request.getParameter("charaId")%>">
                    <button>Editar</button>
                </form>
                <span class="cm_edex"><a class="cm_ed">Editar</a> | <a 
                        href="chara.jsp?charaId=<%=request.getParameter("charaId")%>&ex=<%=id_comentario%>&acao=dl" 
                        class="cm_ex">Excluir</a></span>
                    <%
                        }
                    %>
            </div>

        </div>
        <%
            }
            rs.close();
            stmt.close();
            conn.close();
        %>
        <script>
            window.onload = () => {
                let jsonChara = `"nome_chara": "<%=nome_chara%>", "descricao_chara": "<%=descricao_chara%>", "img_link_chara": "<%=img_link_chara%>"aaaaaaaaaaaaaa`;
                let dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(jsonChara);
                document.getElementById("jsonDownload").href = dataStr;
            };

            let comen = document.getElementsByClassName("comentario");
            /*
             let ed = this.querySelector(".cm_ed");
             let texto = this.querySelector(".cm_texto");
             let up_form = this.querySelector(".up_form");
             */

            for (let i = 0; i < comen.length; i++) {
                if (comen[i].getElementsByClassName("cm_ed").length !== 0) {
                    comen[i].querySelector(".cm_ed").addEventListener('click', function () {
                        let comen = document.getElementsByClassName("comentario");
                        comen[i].querySelector(".cm_texto").style.display = "none";
                        comen[i].querySelector(".up_form").style.display = "block";
                    }, false);
                }
            }

        </script>
    </body>
</html>
