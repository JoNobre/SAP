<%-- 
    Document   : gerenciarchara
    Created on : 7 de abr. de 2024, 22:59:49
    Author     : Jonathan
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
        <script>
            $(function () {
                $("#nav").load("nav.jsp");
            });

            let chara_obj = {p_img: "", p_id_c: -1, p_id_u: -1, p_nome_c: "", p_nome_u: "", descricao_chara: ""};

            function enviaPainel(id_chara, id_usuario_fk, nome_usuario_c,
                    nome_chara, descricao_chara, img_link_chara) {
                chara_obj = {p_img: img_link_chara, p_id_c: id_chara,
                    p_id_u: id_usuario_fk, p_nome_c: nome_chara,
                    p_nome_u: nome_usuario_c, descricao_chara: descricao_chara};

                p_img = document.getElementById("p_img");
                p_id_c = document.getElementById("p_id_c");
                p_id_u = document.getElementById("p_id_u");
                p_nome_c = document.getElementById("p_nome_c");
                p_nome_u = document.getElementById("p_nome_u");
                c_img = document.getElementById("modalImgU");
                c_desc = document.getElementById("charaDescU");
                excluirId = document.getElementById("aBtExcluir");
                visuId = document.getElementById("aBtVisu");
                v_img = document.getElementById("modalImgV");
                v_img_link = document.getElementById("charaLinkV");
                v_nome_c = document.getElementById("charaNomeV");
                v_nome_u = document.getElementById("charaNomeVus");
                v_id_c = document.getElementById("charaIdV");
                v_id_u = document.getElementById("charaIdVus");
                v_id_desc = document.getElementById("charaDescV");

                p_img.src = chara_obj.p_img;
                p_id_c.innerHTML = chara_obj.p_id_c;
                p_id_u.innerHTML = chara_obj.p_id_u;
                p_nome_c.innerHTML = chara_obj.p_nome_c;
                p_nome_u.innerHTML = chara_obj.p_nome_u;

                charaLinkU.value = chara_obj.p_img;
                charaIdU.value = chara_obj.p_id_u;
                idChara.value = chara_obj.p_id_c;
                charaNomeU.value = chara_obj.p_nome_c;
                c_desc.innerHTML = chara_obj.descricao_chara;
                modalImgU.src = chara_obj.p_img;
                modalImgU.style.display = "block";
                
                v_img.src = chara_obj.p_img;
                v_img_link.innerHTML = chara_obj.p_img;
                v_nome_c.innerHTML = chara_obj.p_nome_c;
                v_nome_u.innerHTML = chara_obj.p_nome_u;
                v_id_c.innerHTML = chara_obj.p_id_c;
                v_id_u.innerHTML = chara_obj.p_id_u;
                v_id_desc.innerHTML = chara_obj.descricao_chara;
                v_img.style.display = "block";

                excluirId.href = "gerenciarchara.jsp?excluirId=" + chara_obj.p_id_c;
                visuId.href = "chara.jsp?charaId=" + chara_obj.p_id_c;
                
                document.getElementById("sb1").disabled = false;
                document.getElementById("sb2").disabled = false;
                document.getElementById("sb3").disabled = false;

            }

            function carregaImagem() {
                if (charaLink.value != "" && charaLink.value != undefined) {
                    modalImg.src = charaLink.value;
                    modalImg.style.display = "block";
                } else
                    modalImg.style.display = "none";
            }
            function carregaImagemU() {
                if (charaLinkU.value != "" && charaLinkU.value != undefined) {
                    modalImgU.src = charaLinkU.value;
                    modalImgU.style.display = "block";
                } else
                    modalImgU.style.display = "none";
            }
            function carregaJson() {
                let files = document.getElementById('seleciona').files;
                console.log(files);
                if (files.length <= 0) {
                    return false;
                }

                let fr = new FileReader();

                fr.onload = function (e) {
                    console.log(e);
                    let result = JSON.parse(e.target.result);                                        
                    charaLink.value = result.img_link_chara;
                    charaNome.value = result.nome_chara;
                    document.getElementById('charaDesc').value = result.descricao_chara;
                    carregaImagem();
                }
                
                fr.readAsText(files.item(0));
                
                
            };
        </script>
        <script src="js/modal.js" type="text/javascript"></script>
        
        <div id="nav"></div>
        <div id="body2">

            <h3>Personagens cadastrados no sistema: </h3>
            <button id="sb4" onclick="abreModal('modalCadastro')">Adicionar</button>
            <div id="content_listar">
                <ul>
                    <%
                        int id_chara = 0;
                        int id_usuario_fk = 0;
                        String nome_usuario_c = "";
                        String nome_chara = "";
                        String descricao_chara = "";
                        String img_link_chara = "";

                        Connection conn = CriarConexao.getConexao();
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("select c.id_chara,"
                                + " c.id_usuario_fk, u.nome_usuario, "
                                + "c.nome_chara, c.descricao_chara, "
                                + "img_link_chara from chara c "
                                + "inner join usuario u "
                                + "on c.id_usuario_fk = u.id_usuario "
                                + "order by c.id_chara");
                        while (rs.next()) {
                            id_chara = rs.getInt("id_chara");
                            id_usuario_fk = rs.getInt("id_usuario_fk");
                            nome_usuario_c = rs.getString("nome_usuario");
                            nome_chara = rs.getString("nome_chara");
                            descricao_chara = rs.getString("descricao_chara");
                            img_link_chara = rs.getString("img_link_chara");

                    %>

                    <li onclick="enviaPainel(<%=id_chara%>, <%=id_usuario_fk%>, '<%=nome_usuario_c%>', '<%=nome_chara%>', `<%=descricao_chara%>`, '<%=img_link_chara%>')">
                        <div class="lista_entry">
                            <img src="<%=img_link_chara%>">
                            <div class="entry_id"><%=id_chara%></div>
                            <div class="entry_names">
                                <div><%=nome_chara%></div>
                                <div>De: <%=nome_usuario_c%></div>
                            </div>
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
                            String sql2 = "delete from chara where id_chara=?";
                            PreparedStatement stmt2 = conn2.prepareStatement(sql2);
                            stmt2.setInt(1, id_delete);
                            stmt2.execute();
                            stmt2.close();
                            conn2.close();
                    %>
                    <script>
                        function atualiza() {
                            location.href = "gerenciarchara.jsp";
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
            <div class="s_head">
                <img id="p_img" src="img/chara_padrao.jpg">
                <div class="s_head_buttons">
                    <a href="chara.jsp" id="aBtVisu"><button id="sb1"
                        disabled="disabled">Visualizar</button></a>
                    <button id="sb2" onclick="abreModal('modalUpdate')"
                        disabled="disabled">Editar</button>
                    <a href="gerenciarchara.jsp" id="aBtExcluir"><button id="sb3"
                        disabled="disabled">Excluir</button></a>
                </div>
            </div>
            <div class="secao">
                <span class="span-secao">Personagem:</span>
                <div class="sub-secao">
                    <table>
                        <tr>
                            <td>Id:</td>
                            <td id="p_id_c"></td>
                        </tr>
                        <tr>
                            <td>Nome:</td>
                            <td id="p_nome_c"></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="secao">
                <span class="span-secao">Usuário:</span>
                <div class="sub-secao">
                    <table>
                        <tr>
                            <td>Id:</td>
                            <td id="p_id_u"></td>
                        </tr>
                        <tr>
                            <td>Nome:</td>
                            <td id="p_nome_u"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal" id="modalCadastro">
            <div class="modalConteudo">  
                <div class="modalCharaHead">
                    <p>Adicionar Personagem</p>
                    <span class="fechaModal" onclick="fechaModal('modalCadastro')">&times;</span>
                </div>
                <div id="modalImgContainer">
                    <img src="" id="modalImg" name="modalImg">
                </div>
                <form class="charaForm" action="CadastroChara" method="post">
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label for="charaNome">Nome: </label><input type="text" name="charaNome" id="charaNome" maxlength="25" >
                        </div>
                        <div class="charaFormId">
                            <label for="charaId">Usuario: </label><input type="number" required name="charaId" id="charaId" min="1" max="999">
                        </div>
                    </div>
                    <div class="charaFormDesc">
                        Descrição:
                        <textarea name="charaDesc" id="charaDesc"></textarea>
                    </div>
                    <div class="charaFormLink">
                        <label for="charaLink">Link: </label><input type="text" 
                                                                    id="charaLink" name="charaLink" 
                                                                    onblur="carregaImagem()">
                        <input type="hidden" name="location" value="gerenciarchara">
                    </div>
                    <div id="ImportaChara">
                        <input type="file" id="seleciona" value="Import" /><br />
                        <button id="importa" onclick="carregaJson()" type="button">Importar Personagem</button>
                    </div>
                    <button>Adicionar novo personagem</button>
                </form>
            </div>
        </div>
        <div class="modal" id="modalUpdate">

            <div class="modalConteudo">  
                <div class="modalCharaHead">
                    <p>Atualizar Personagem</p>
                    <span class="fechaModal" onclick="fechaModal('modalUpdate')">&times;</span>
                </div>
                <div id="modalImgContainerU">
                    <img src="" id="modalImgU" name="modalImgU">
                </div>
                <form class="charaForm" action="UpdateChara" method="post">
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label for="charaNome">Nome: </label><input type="text" name="charaNomeU" id="charaNomeU" maxlength="25" >
                        </div>
                        <div class="charaFormId">
                            <label for="charaId">Usuario: </label><input type="number" required name="charaIdU" id="charaIdU" min="1" max="999">
                        </div>
                    </div>
                    <div class="charaFormDesc">
                        Descrição:
                        <textarea name="charaDescU" id="charaDescU"></textarea>
                    </div>
                    <div class="charaFormLink">
                        <label for="charaLink">Link: </label><input type="text" 
                                                                    id="charaLinkU" name="charaLinkU" 
                                                                    onblur="carregaImagemU()">
                        <input type="hidden" name="location" value="gerenciarchara">
                        <input type="hidden" id="idChara" name="idChara" value="">
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
                <div id="modalImgContainerV">
                    <img src="" id="modalImgV" name="modalImgV">
                </div>
                <div class="charaForm">
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label for="charaNome">Nome: </label><span name="charaNomeV" id="charaNomeV" ></span>
                        </div>
                        <div class="charaFormId">
                            <label for="charaId">Id: </label><span name="charaNomeV" id="charaIdV" ></span>
                        </div>
                    </div>
                    <div class="charaFormIdNome">
                        <div class="charaFormNome">
                            <label for="charaNome">Usuario Nome: </label><span name="charaNomeVus" id="charaNomeVus" ></span>
                        </div>
                        <div class="charaFormId">
                            <label for="charaId">Usuario Id: </label><span name="charaIdVus" id="charaIdVus"></span>
                        </div>
                    </div>
                    <div class="charaFormDesc">
                        Descrição:
                        <span name="charaDescV" id="charaDescV"></span>
                    </div>
                    <div class="charaFormLink">
                        Link:
                        <span id="charaLinkV" name="charaLinkV"></span>
                    </div>
                </div>
            </div>
        </div>  
    </body>
</html>
