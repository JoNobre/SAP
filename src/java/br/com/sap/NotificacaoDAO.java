/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.sap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Jonathan
 */
public class NotificacaoDAO {

    private Connection con;

    public NotificacaoDAO(Connection con) {
        this.con = con;
    }

    public void adicionar(Notificacao f) throws SQLException {
        String sql = "insert into notificacao "
                + "(id_usuario_fk, mensagem_notificacao) values (?,?)";

        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            System.out.println("IdUs: "+f.getId_usuario_fk()+"\n Mensagem: "+f.getMensagem_notificacao());
            stmt.setInt(1, f.getId_usuario_fk());
            stmt.setString(2, f.getMensagem_notificacao());

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            con.close();
        }
    }
    public void deletar(Notificacao f) throws SQLException{
        try{
            PreparedStatement stmt = con.prepareStatement("delete from notificacao "
                    + "where id_notificacao="+f.getId_notificacao());
            stmt.execute();
            stmt.close();
        }catch (SQLException e) {
            e.printStackTrace();
        } finally {
            con.close();
        }
    }
    public int qtdNotifs(Notificacao f) throws SQLException{
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select count(*)as qtd from notificacao "
                + "where id_usuario_fk ="+f.getId_usuario_fk());
        rs.next();
        System.out.println("id do usuario:"+f.getId_usuario_fk());
        return rs.getInt("qtd");
    }
}
