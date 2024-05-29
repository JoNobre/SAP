
import br.com.conexao.CriarConexao;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Jonathan
 */
public class LoginControllers extends HttpServlet{
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        try{
            String emailBuscado = "";
            String nomeBuscado = "";
            String senhaBuscada = "";
            int idBuscado = 0;
            int cargoBuscado = 0;
            Connection con;
            String email = request.getParameter("email_login");
            String senha = request.getParameter("senha_login");
            String sql = "Select * from usuario where email_usuario = ? and senha_usuario = ?";
            
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(senha.getBytes());
            
            byte[] digest = md.digest();
            StringBuffer sb = new StringBuffer();
            for (byte b : digest){
                sb.append(String.format("%02x",b & 0xff));
            }
            senha = sb.toString();
            try{
                con = CriarConexao.getConexao();
                PreparedStatement stmt = con.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, senha);
                
                ResultSet rs = stmt.executeQuery();
                while (rs.next()){
                    emailBuscado = rs.getString("email_usuario");
                    senhaBuscada = rs.getString("senha_usuario");
                    cargoBuscado = rs.getInt("id_cargo_fk");
                    nomeBuscado = rs.getString("nome_usuario");
                    idBuscado = rs.getInt("id_usuario");
                }
                rs.close();
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            if (emailBuscado.equals(email) || senhaBuscada.equals(senha)) {
                HttpSession session = request.getSession();
                session.setAttribute("id",idBuscado);
                session.setAttribute("email",email);
                session.setAttribute("nome",nomeBuscado);
                session.setAttribute("cargo",cargoBuscado);
                request.getRequestDispatcher("logado.jsp").forward(request, response);
            } else{
                System.out.println(emailBuscado + "-" + email);
                System.out.println(senhaBuscada + "-" + senha);
                request.getRequestDispatcher("errodeusuario.jsp").forward(request, response);
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginControllers.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
