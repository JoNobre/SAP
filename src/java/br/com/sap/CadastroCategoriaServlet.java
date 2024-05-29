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
public class CadastroCategoriaServlet extends HttpServlet{
    
    private static final long serialVersionUID = 1L;
        public CadastroCategoriaServlet(){
            super();
        }
        
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            PrintWriter writer = response.getWriter();
            int id_usuario = Integer.valueOf(request.getParameter("idUsuario"));
            String nome = request.getParameter("nomeCat");
            String descricao = request.getParameter("descCat");
            String location = request.getParameter("location");
            
            Connection con;
            try {
                con = CriarConexao.getConexao();
                
                Categoria c = new Categoria();
                c.setId_usuario_fk(id_usuario);
                c.setNome_categoria(nome);
                c.setDescricao_categoria(descricao);
                
                CategoriaDAO dao = new CategoriaDAO(con);
                dao.adicionar(c);
                request.getRequestDispatcher(location+".jsp").forward(request, response);
            } catch (SQLException e){
                e.printStackTrace();
            }
        }
}
