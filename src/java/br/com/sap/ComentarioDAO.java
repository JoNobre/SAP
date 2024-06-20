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
public class ComentarioDAO {
    private Connection con;
    public ComentarioDAO(Connection con){
        this.con = con;
    }
    public void adicionar (Comentario c) throws SQLException{
        String sql = "insert into comentario(id_usuario_fk, id_chara_fk"
                + ", mensagem_comentario)"
                + "values (?,?,?)";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setInt(1, c.getId_usuario_fk());
            stmt.setInt(2, c.getId_chara_fk());
            stmt.setString(3, c.getMensagem_comentario());
            
            stmt.execute();
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
    public void atualizar (Comentario c) throws SQLException{
        String sql = "update comentario set mensagem_comentario = ? ,"
                + "editado_comentario = ? where id_comentario = ?";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setString(1, c.getMensagem_comentario());
            stmt.setBoolean(2, true);
            stmt.setInt(3, c.getId_comentario());
            
            stmt.execute();
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
    
}
