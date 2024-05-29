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
public class CharaDAO {
    private Connection con;
    public CharaDAO(Connection con){
        this.con = con;
    }
    public void adicionar (Chara c) throws SQLException{
        String sql = "insert into chara(id_usuario_fk, nome_chara, descricao_chara,"
                + "img_link_chara)values (?,?,?,?)";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setInt(1, c.getId_usuario());            
            stmt.setString(2, c.getNome());
            stmt.setString(3, c.getDescricao());
            stmt.setString(4, c.getImg_link());
            
            stmt.execute();
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
    public void atualizar (Chara c) throws SQLException{
        String sql = "update chara set id_usuario_fk = ? , nome_chara = ? ,"
                + " descricao_chara = ?, img_link_chara = ? where id_chara = ?";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setInt(1, c.getId_usuario());
            stmt.setString(2, c.getNome());
            stmt.setString(3, c.getDescricao());
            stmt.setString(4, c.getImg_link());
            stmt.setInt(5, c.getId());
            
            stmt.execute();
            
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
}
