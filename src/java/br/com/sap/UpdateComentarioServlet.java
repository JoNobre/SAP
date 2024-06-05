/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.com.sap;

import br.com.conexao.CriarConexao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Jonathan
 */
@WebServlet(name = "UpdateComentarioServlet", urlPatterns = {"/UpdateComentarioServlet"})
public class UpdateComentarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id_comentario"));
        String msg = request.getParameter("mensagem_comentario");
        String location = request.getParameter("location");
        
        Connection con;
        try {
            con = CriarConexao.getConexao();
            
            Comentario c = new Comentario();
            c.setMensagem_comentario(msg);
            c.setId_comentario(id);
            
            ComentarioDAO dao = new ComentarioDAO(con);
            dao.atualizar(c);
            request.getRequestDispatcher(location).forward(request, response);
            
        }catch (SQLException e) {
            e.printStackTrace();
        }
    }
    private static final long serialVersionUID = 1L;

    public UpdateComentarioServlet() {
        super();
    }

}
