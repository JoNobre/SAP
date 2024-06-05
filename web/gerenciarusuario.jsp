<%-- 
    Document   : gerenciarchara
    Created on : 7 de abr. de 2024, 22:59:49
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
        <link rel="stylesheet" type="text/css" href="css/modal.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <%
            String email_s = (String) session.getAttribute("email");
            String nome_s = (String) session.getAttribute("nome");
            int cargo_s = (Integer) session.getAttribute("cargo");
        %>

        <script src="js/modal.js" type="text/javascript"></script>

        <div id="nav"></div>
        <div id="body2">

            <h3>Usuários cadastrados no sistema: </h3>
            <button id="sb4" onclick="abreModal('modalCadastro')">Adicionar</button>
            <div id="content_listar">
                <ul>
                    <%
                        int id_usuario = 0;
                        int id_cargo_fk = 0;
                        String nome_usuario = "";
                        String nome_cargo = "";
                        String email_usuario = "";
                        String senha_usuario = "";
                        Boolean ativado_usuario = true;
                        String str_ativado_usuario = "";

                        Connection conn = CriarConexao.getConexao();
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("select u.id_usuario, "
                                + "u.nome_usuario, u.email_usuario, "
                                + "u.senha_usuario, u.ativado_usuario, "
                                + "c.nome_cargo, u.id_cargo_fk from usuario u "
                                + "inner join cargo c on u.id_cargo_fk = "
                                + "c.id_cargo order by u.id_usuario");
                        while (rs.next()) {
                            id_usuario = rs.getInt("id_usuario");
                            id_cargo_fk = rs.getInt("id_cargo_fk");
                            nome_usuario = rs.getString("nome_usuario");
                            nome_cargo = rs.getString("nome_cargo");
                            email_usuario = rs.getString("email_usuario");
                            senha_usuario = rs.getString("senha_usuario");
                            ativado_usuario = rs.getBoolean("ativado_usuario");
                            if (rs.getBoolean("ativado_usuario")) {
                                str_ativado_usuario = "Ativo";
                            } else {
                                str_ativado_usuario = "Inativo";
                            }

                    %>

                    <li onclick="enviaPainel(<%=id_usuario%>, <%=id_cargo_fk%>,
                                    '<%=nome_usuario%>', '<%=nome_cargo%>', '<%=email_usuario%>',
                                    '<%=senha_usuario%>', <%=ativado_usuario%>, '<%=str_ativado_usuario%>')">
                        <div class="lista_entry">                           
                            <div class="entry_id"><%=id_usuario%></div>
                            <div class="entry_names">
                                <div><%=nome_usuario%></div>
                                <div><%=nome_cargo%></div>
                            </div>
                            <div class="entry_status <%=str_ativado_usuario%>">Usuário <%=str_ativado_usuario%></div>
                        </div>
                    </li>

                    <% }
                        rs.close();
                        stmt.close();
                        conn.close();

                        String excluirId = request.getParameter("excluirId");
                        if (excluirId != "" && excluirId != null) {
                            int id_delete = Integer.parseInt(excluirId);
                            Connection conn2 = CriarConexao.getConexao();
                            String sql2 = "delete from usuario where id_usuario=?";
                            PreparedStatement stmt2 = conn2.prepareStatement(sql2);
                            stmt2.setInt(1, id_delete);
                            stmt2.execute();
                            stmt2.close();
                            conn2.close();
                    %>
                    <script>
                        function atualiza() {
                            location.href = "gerenciarusuario.jsp";
                        }
                        atualiza();
                    </script>
                    <%
                        }

                    %>     

                </ul>
            </div>
        </div>
        <div id="painel">
            <div class="secao">
                <span class="span-secao">Usuário:</span>
                <div class="sub-secao">
                    <table>
                        <tr>
                            <td>Id:</td>
                            <td id="us_id"></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td id="us_email"></td>
                        </tr>
                        <tr>
                            <td>Nome:</td>
                            <td id="us_nome"></td>
                        </tr>
                        <tr>
                            <td>Status:</td>
                            <td id="us_status"></td>
                        </tr>
                        <tr>
                            <td>Cargo:</td>
                            <td id="us_cargo"></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="s_head">                
                <div class="s_head_buttons">
                    <button id="sb1" onclick="abreModal('modalVisualiza')"
                            disabled="disabled">Visualizar</button>
                    <button id="sb2" onclick="abreModal('modalUpdate')"
                            disabled="disabled">Editar</button>
                    <a href="gerenciarchara.jsp" id="aBtExcluir"><button id="sb3"
                                                                         disabled="disabled">Excluir</button></a>
                </div>
            </div>            
        </div>
        <div class="modal" id="modalCadastro">
            <div class="modalConteudo">  
                <div class="modalCharaHead">
                    <p>Adicionar Personagem</p>
                    <span class="fechaModal" onclick="fechaModal('modalCadastro')">&times;</span>
                </div>
                <form class="charaForm" action="CadastroLogin" method="post" autocomplete="off">
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label for="nome_cad">Nome: </label><input type="text" 
                                                                       name="nome_cad" id="nome_cad" maxlength="25" 
                                                                       style="width: 100%" required >
                        </div>
                    </div>
                    <div class="charaFormLink">
                        <label for="senha_cad">Senha: </label><input type="password" 
                                                                     id="senha_cad" name="senha_cad" required autocomplete="new-password" maxlength="8">
                    </div>
                    <div class="charaFormLink">
                        <label for="email_cad">E-mail: </label><input type="email" 
                                                                    id="email_cad" name="email_cad" required >
                    </div>

                    <input type="hidden" name="location" value="gerenciarusuario">
                    <button>Adicionar novo usuário</button>
                </form>
            </div>
        </div>
        <div class="modal" id="modalUpdate">

            <div class="modalConteudo">  
                <div class="modalCharaHead">
                    <p>Atualizar Usuário</p>
                    <span class="fechaModal" onclick="fechaModal('modalUpdate')">&times;</span>
                </div>
                <form class="charaForm" action="UpdateLogin" method="post" autocomplete="off">
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label for="us_nome_update">Nome: </label>
                            <input type="text" name="nome" id="us_nome_update"
                                   maxlength="25" >
                        </div>
                        <div class="charaFormId" style="flex: 1.5;">
                            <label for="us_cargo">Cargo: </label>
                            <select id="us_cargo" name="cargo">
                                <%                                    int cargo_id = 0;
                                    String cargo_nome = "";

                                    Connection conn3 = CriarConexao.getConexao();
                                    Statement stmt3 = conn3.createStatement();
                                    ResultSet rs3 = stmt3.executeQuery("select * from cargo");
                                    while (rs3.next()) {
                                        cargo_id = rs3.getInt("id_cargo");
                                        cargo_nome = rs3.getString("nome_cargo");
                                %>
                                <option id="c_<%=cargo_id%>" value="<%=cargo_id%>"><%=cargo_nome%></option>
                                <% }
                                    rs3.close();
                                    stmt3.close();
                                    conn3.close();
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="charaFormIdNome">
                        <div class="charaFormNome" style="flex: 4">
                            <label for="us_senha_update">Senha: </label>
                            <input type="password" name="senha" 
                                   id="us_senha_update" maxlength="8"
                                   autocomplete="new-password" required>
                        </div>
                        <div class="charaFormNome" style="flex: 1">
                            <label for="us_status_update">Status: </label>
                            <input type="hidden" name="ativado" 
                                   id="us_hidden_status_update" value="0">
                            <input type="checkbox" name="ativado" 
                                   id="us_status_update" value="1">
                        </div>
                    </div>
                    <div class="charaFormLink">
                        <label for="us_email_update">E-mail: </label><input type="email" 
                                                                            id="us_email_update" name="email">
                        <input type="hidden" name="location" value="gerenciarusuario">
                        <input type="hidden" id="us_id_update" name="id" value="">
                    </div>
                    <button>Atualizar personagem</button>
                </form>
            </div>
        </div>
        <div class="modal" id="modalVisualiza">
            <div class="modalConteudo">  
                <div class="modalCharaHead">
                    <span class="fechaModal" onclick="fechaModal('modalVisualiza')">&times;</span>
                </div>
                <div class="charaForm">
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label>Nome: </label><span name="us_nome_visu" id="us_nome_visu" style="margin-right: 0.6vw"></span>
                        </div>
                        <div class="charaFormId">
                            <label>Id: </label><span name="us_id_visu" id="us_id_visu" ></span>
                        </div>
                    </div>
                    <div class="charaFormIdNome">
                        <div class="charaFormId">
                            <label>Cargo: </label><span name="us_cargo_visu" id="us_cargo_visu" style="margin-right: 0.6vw"></span>
                        </div>
                        <div class="charaFormId">
                            <label>Status: </label><span name="us_status_visu" id="us_status_visu"></span>
                        </div>
                    </div>
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label>E-mail: </label><span name="us_email_visu" id="us_email_visu" style="width: 100%"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
    </body>
    <script>
        $(function () {
            $("#nav").load("nav.jsp");
        });

        function enviaPainel(id_usuario, id_cargo_fk, nome_usuario,
                nome_cargo, email_usuario, senha_usuario, ativado_usuario,
                str_ativado_usuario) {

            us_id = document.getElementById("us_id");
            us_email = document.getElementById("us_email");
            us_nome = document.getElementById("us_nome");
            us_cargo = document.getElementById("us_cargo");
            us_status = document.getElementById("us_status");
            excluirId = document.getElementById("aBtExcluir");
            visuId = document.getElementById("aBtVisu");

            us_nome_update = document.getElementById("us_nome_update");
            us_cargo = document.getElementById("us_cargo");
            us_senha_update = document.getElementById("us_senha_update");
            us_hidden_status_update = document.getElementById("us_hidden_status_update");
            us_status_update = document.getElementById("us_status_update");
            us_id_update = document.getElementById("us_id_update");
            us_email_update = document.getElementById("us_email_update");

            us_nome_visu = document.getElementById("us_nome_visu");
            us_id_visu = document.getElementById("us_id_visu");
            us_cargo_visu = document.getElementById("us_cargo_visu");
            us_status_visu = document.getElementById("us_status_visu");
            us_email_visu = document.getElementById("us_email_visu");

            us_id.innerHTML = id_usuario;
            us_email.innerHTML = email_usuario;
            us_nome.innerHTML = nome_usuario;
            us_cargo.innerHTML = nome_cargo;
            us_status.innerHTML = str_ativado_usuario;


            us_nome_update.value = nome_usuario;
            document.getElementById("c_" + id_cargo_fk).selected = true;
            if (ativado_usuario === true) {
                us_status_update.checked = true;
                us_hidden_status_update.value = "1"
            } else {
                us_status_update.checked = false;
            }
            us_email_update.value = email_usuario;

            us_nome_visu.innerHTML = nome_usuario;
            us_id_visu.innerHTML = id_usuario;
            us_cargo_visu.innerHTML = nome_cargo;
            us_status_visu.innerHTML = str_ativado_usuario;
            us_email_visu.innerHTML = email_usuario;

            excluirId.href = "gerenciarusuario.jsp?excluirId=" + id_usuario;
            us_id_update.value = id_usuario;
            
            
            /*
             
             v_nome_c.innerHTML = chara_obj.p_nome_c;
             v_nome_u.innerHTML = chara_obj.p_nome_u;
             v_id_c.innerHTML = chara_obj.p_id_c;
             v_id_u.innerHTML = chara_obj.p_id_u;
             v_id_desc.innerHTML = chara_obj.descricao_chara;
             
             
             
             
             */

            document.getElementById("sb1").disabled = false;
            document.getElementById("sb2").disabled = false;
            document.getElementById("sb3").disabled = false;

        }
        us_status_update.addEventListener("input", function(){
                us_hidden_status_update.value = "1"
            })
    </script>
</html>
