/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.sap;

import java.sql.Timestamp;

/**
 *
 * @author Jonathan
 */
public class Comentario {
    private int id_comentario;
    private int id_usuario_fk;
    private int id_chara_fk;
    private String mensagem_comentario;
    private Timestamp data_hora_comentario;
    private boolean editado_comentario;

    public int getId_comentario() {
        return id_comentario;
    }

    public void setId_comentario(int id_comentario) {
        this.id_comentario = id_comentario;
    }

    public int getId_usuario_fk() {
        return id_usuario_fk;
    }

    public void setId_usuario_fk(int id_usuario_fk) {
        this.id_usuario_fk = id_usuario_fk;
    }

    public int getId_chara_fk() {
        return id_chara_fk;
    }

    public void setId_chara_fk(int id_chara_fk) {
        this.id_chara_fk = id_chara_fk;
    }

    public String getMensagem_comentario() {
        return mensagem_comentario;
    }

    public void setMensagem_comentario(String mensagem_comentario) {
        this.mensagem_comentario = mensagem_comentario;
    }

    public Timestamp getData_hora_comentario() {
        return data_hora_comentario;
    }

    public void setData_hora_comentario(Timestamp data_hora_comentario) {
        this.data_hora_comentario = data_hora_comentario;
    }

    public boolean isEditado_comentario() {
        return editado_comentario;
    }

    public void setEditado_comentario(boolean editado_comentario) {
        this.editado_comentario = editado_comentario;
    }
    
    
}
