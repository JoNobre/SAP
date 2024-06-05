/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.sap;

import br.com.conexao.CriarConexao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author laboratorio
 */
public class UpdateCharaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UpdateCharaServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.valueOf(request.getParameter("idChara"));
        int id_usuario = Integer.valueOf(request.getParameter("charaIdU"));
        String nome = request.getParameter("charaNomeU");
        String descricao = request.getParameter("charaDescU");
        String img_link = request.getParameter("charaLinkU");
        String location = request.getParameter("location");
        if ("".equals(img_link) || img_link == null) {
            img_link = "img/chara_padrao.jpg";
        }

        Connection con;
        try {
            con = CriarConexao.getConexao();

            Chara c = new Chara();
            c.setId_usuario(Integer.valueOf(id_usuario));
            c.setId(Integer.valueOf(id));
            c.setNome(nome);
            c.setDescricao(descricao);
            c.setImg_link(img_link);

            CharaDAO dao = new CharaDAO(con);
            dao.atualizar(c);
            request.getRequestDispatcher(location + ".jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
