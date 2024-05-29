/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
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
 * @author Jonathan
 */
public class CadastroLoginServlet extends HttpServlet{
    
    private static final long serialVersionUID = 1L;
        public CadastroLoginServlet(){
            super();
        }
        
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            PrintWriter writer = response.getWriter();
            String nome = request.getParameter("nome_cad");
            String email = request.getParameter("email_cad");
            String senha = request.getParameter("senha_cad");
            String location = request.getParameter("location");
            
            
            Connection con;
            try {
                con = CriarConexao.getConexao();
                
                Usuario u = new Usuario();
                u.setNome(nome);
                u.setEmail(email);
                
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(senha.getBytes());
                
                byte[] digest = md.digest();
                StringBuffer sb = new StringBuffer();
                for (byte b : digest){
                    sb.append(String.format("%02x",b & 0xff));
                }
                
                u.setSenha(sb.toString());
                
                UsuarioDAO dao = new UsuarioDAO(con);
                dao.adicionar(u);
                request.setAttribute("email", u.getEmail());
                request.getRequestDispatcher(location+".jsp").forward(request, response);
            } catch (SQLException e){
                e.printStackTrace();
            } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(CadastroLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        }
}
