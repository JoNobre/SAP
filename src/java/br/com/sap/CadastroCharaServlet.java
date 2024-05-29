/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
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
 * @author Jonathan
 */
public class CadastroCharaServlet extends HttpServlet{
    
    private static final long serialVersionUID = 1L;
        public CadastroCharaServlet(){
            super();
        }
        
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            PrintWriter writer = response.getWriter();
            int id_usuario = Integer.valueOf(request.getParameter("charaId"));
            String nome = request.getParameter("charaNome");
            String descricao = request.getParameter("charaDesc");
            String img_link = request.getParameter("charaLink");            
            if ("".equals(img_link) || img_link == null){
                img_link = "img/chara_padrao.jpg";             
            }
            String location = request.getParameter("location");
            
            Connection con;
            try {
                con = CriarConexao.getConexao();
                
                Chara c = new Chara();
                c.setId_usuario(id_usuario);
                c.setNome(nome);
                c.setDescricao(descricao);
                c.setImg_link(img_link);
                
                CharaDAO dao = new CharaDAO(con);
                dao.adicionar(c);
                //request.setAttribute("email", c.getEmail());
                request.getRequestDispatcher(location+".jsp").forward(request, response);
            } catch (SQLException e){
                e.printStackTrace();
            }
        }
}
