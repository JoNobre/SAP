/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.sap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Jonathan
 */
public class UsuarioDAO {
    private Connection con;
    public UsuarioDAO(Connection con){
        this.con = con;
    }
    public void adicionar (Usuario u) throws SQLException{
        String sql = "insert into usuario(nome_usuario, email_usuario"
                + ", senha_usuario, ativado_usuario, id_cargo_fk)"
                + "values (?,?,?,true,3)";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setString(1, u.getNome());
            stmt.setString(2, u.getEmail());
            stmt.setString(3, u.getSenha());
            
            stmt.execute();
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
    public void atualizar (Usuario u) throws SQLException{
        String sql = "update usuario set nome_usuario= ? , email_usuario = ? ,"
                + " senha_usuario = ?, ativado_usuario = ?, id_cargo_fk = ?"
                + " where id_usuario = ?";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setString(1, u.getNome());
            stmt.setString(2, u.getEmail());
            stmt.setString(3, u.getSenha());
            stmt.setInt(4, u.getAtivado());
            stmt.setInt(5, u.getCargo());
            stmt.setInt(6, u.getId());
            
            stmt.execute();
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
}
