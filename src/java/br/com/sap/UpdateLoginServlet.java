/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.sap;

import br.com.conexao.CriarConexao;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author laboratorio
 */
public class UpdateLoginServlet extends HttpServlet{
    
    private static final long serialVersionUID = 1L;
        public UpdateLoginServlet(){
            super();
        }
        
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            try {
                PrintWriter writer = response.getWriter();
                String id = request.getParameter("id");
                String nome = request.getParameter("nome");
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String ativado = request.getParameter("ativado");
                String cargo = request.getParameter("cargo");
                
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(senha.getBytes());
                
                byte[] digest = md.digest();
                StringBuffer sb = new StringBuffer();
                for (byte b : digest){
                    sb.append(String.format("%02x",b & 0xff));
                }
                senha = sb.toString();
                
                Connection con;
                try {
                    con = CriarConexao.getConexao();
                    
                    Usuario u = new Usuario();
                    u.setId(Integer.valueOf(id));
                    u.setNome(nome);
                    u.setEmail(email);
                    u.setSenha(senha);
                    u.setAtivado(Integer.valueOf(ativado));
                    u.setCargo(Integer.valueOf(cargo));
                    
                    UsuarioDAO dao = new UsuarioDAO(con);
                    dao.atualizar(u);
                    request.getRequestDispatcher("gerenciarusuario.jsp").forward(request, response);
                } catch (SQLException e){
                    e.printStackTrace();
                }
            } catch (NoSuchAlgorithmException ex){
                Logger.getLogger(UpdateLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
}
