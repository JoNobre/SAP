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
import java.sql.Timestamp;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jonathan
 */
@WebServlet(name = "CadastroComentarioServlet", urlPatterns = {"/CadastroComentarioServlet"})
public class CadastroComentarioServlet extends HttpServlet{
    
    private static final long serialVersionUID = 1L;
        public CadastroComentarioServlet(){
            super();
        }
        
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            PrintWriter writer = response.getWriter();
            
            
            
            int id_usuario_fk = Integer.parseInt(request.getParameter("id_usuario_fk"));
            int id_chara_fk = Integer.parseInt(request.getParameter("id_chara_fk"));
            String nome_chara_fk = request.getParameter("nome_chara_fk");
            String mensagem_comentario = request.getParameter("mensagem_comentario");
            String location = request.getParameter("location");
            int dono = Integer.parseInt(request.getParameter("donoDoChara"));
            

            Connection con;
            Connection con2;
            Connection con3;
            try {
                con = CriarConexao.getConexao();
                con2 = CriarConexao.getConexao();
                con3 = CriarConexao.getConexao();
                HttpSession session = request.getSession();
                
                Comentario c = new Comentario();
                c.setId_usuario_fk(id_usuario_fk);
                c.setId_chara_fk(id_chara_fk);
                c.setMensagem_comentario(mensagem_comentario);
                
                ComentarioDAO dao = new ComentarioDAO(con);
                dao.adicionar(c);
                
                
                Notificacao n = new Notificacao(dono);
                NotificacaoDAO dao2 = new NotificacaoDAO(con2);
                NotificacaoDAO dao3 = new NotificacaoDAO(con3);
                
                n.setMensagem_notificacao("Você recebeu um novo comentário no personagem "
                        + "<a href='chara.jsp?charaId="+id_chara_fk+"'>"+nome_chara_fk+"</a>.");
                dao2.adicionar(n);
                request.getRequestDispatcher(location).forward(request, response);
                
                session.setAttribute("notifs",dao3.qtdNotifs(n));
                
            } catch (SQLException e){
                e.printStackTrace();
            }
        }
}
