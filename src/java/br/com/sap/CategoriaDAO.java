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
public class CategoriaDAO {
    private Connection con;
    public CategoriaDAO(Connection con){
        this.con = con;
    }
    public void adicionar (Categoria c) throws SQLException{
        String sql = "insert into categoria(nome_categoria, descricao_categoria"
                + ", id_usuario_fk) values (?,?,?)";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setString(1, c.getNome_categoria());
            stmt.setString(2, c.getDescricao_categoria());
            stmt.setInt(3, c.getId_usuario_fk());
            
            stmt.execute();
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
    public void atualizar (Categoria c) throws SQLException{
        String sql = "update categoria set nome_categoria= ? , descricao_categoria = ? ,"
                + " id_usuario_fk = ? where id_usuario = ?";
        
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            
            stmt.setString(1, c.getNome_categoria());
            stmt.setString(2, c.getDescricao_categoria());
            stmt.setInt(3, c.getId_usuario_fk());
            stmt.setInt(4, c.getId_categoria());
            
            stmt.execute();
            stmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        } finally{
            con.close();
        }
    }
}
