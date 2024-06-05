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
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author Jonathan
 */
@WebServlet(name = "PesquisaServlet", urlPatterns = {"/PesquisaServlet"})
public class PesquisaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
        public PesquisaServlet(){
            super();
        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pesquisa = String.valueOf(request.getParameter("pesquisa"));
        
    }

}
