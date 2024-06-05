/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.com.sap;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import br.com.conexao.CriarConexao;
import java.sql.*;

/**
 *
 * @author Jonathan
 */
@WebServlet(name = "ChatServlet", urlPatterns = {"/ChatServlet"})
public class ChatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
        public ChatServlet(){
            super();
        }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cm_msg = request.getParameter("cm_msg");
        int id_chat = Integer.parseInt(request.getParameter("id_chat"));
        int id_usuario = Integer.parseInt(request.getParameter("id_usuario"));
        String location = request.getParameter("location");
        
        try{
            
            Connection con = CriarConexao.getConexao();
            String sql = "insert into chat_mensagem(id_usuario_fk, id_chat_fk"
                + ", mensagem_cm) values (?,?,?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setInt(1, id_usuario);
            stmt.setInt(2, id_chat);
            stmt.setString(3, cm_msg);
            
            stmt.execute();
            stmt.close();
            
            request.getRequestDispatcher(location).forward(request, response);
            
        } catch (SQLException e){
                e.printStackTrace();
            }
    }
}
