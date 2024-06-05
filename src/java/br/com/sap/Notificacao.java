/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.sap;

/**
 *
 * @author Jonathan
 */
public class Notificacao {
    int id_notificacao;
    int id_usuario_fk;
    String mensagem_notificacao;
    String data_hora_notificacao;

    public Notificacao(int id_usuario_fk) {
        this.id_usuario_fk = id_usuario_fk;
    }
    
    

    public int getId_notificacao() {
        return id_notificacao;
    }

    public void setId_notificacao(int id_notificacao) {
        this.id_notificacao = id_notificacao;
    }

    public int getId_usuario_fk() {
        return id_usuario_fk;
    }

    public void setId_usuario_fk(int id_usuario_fk) {
        this.id_usuario_fk = id_usuario_fk;
    }

    public String getMensagem_notificacao() {
        return mensagem_notificacao;
    }

    public void setMensagem_notificacao(String mensagem_notificacao) {
        this.mensagem_notificacao = mensagem_notificacao;
    }

    public String getData_hora_notificacao() {
        return data_hora_notificacao;
    }

    public void setData_hora_notificacao(String data_hora_notificacao) {
        this.data_hora_notificacao = data_hora_notificacao;
    }
    
    
}
