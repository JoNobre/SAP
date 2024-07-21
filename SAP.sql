drop schema if exists SAP;
create schema if not exists SAP default character set utf8;
use SAP;

create table if not exists SAP.cargo (
    id_cargo int not null auto_increment,
    nome_cargo varchar(15) not null,
    primary key (id_cargo)
) engine = InnoDB;

create table if not exists SAP.usuario (
    id_usuario int not null auto_increment,
    nome_usuario varchar(50) not null,
    email_usuario varchar(50) not null,
    senha_usuario varchar(64) not null,
    ativado_usuario boolean not null,
    id_cargo_fk int not null,
    primary key (id_usuario),
    foreign key (id_cargo_fk) references cargo(id_cargo)
    ) engine = InnoDB;

create table if not exists SAP.chara (
    id_chara int not null auto_increment,
    id_usuario_fk int not null,
    nome_chara varchar(80) not null,
    descricao_chara varchar(2000),
    img_link_chara varchar(500) default 'img/chara_padrao.jpg',
    primary key (id_chara),
    foreign key (id_usuario_fk) references usuario(id_usuario)
) engine = InnoDB;

create table if not exists SAP.categoria(
	id_categoria int not null auto_increment,
    id_usuario_fk int not null,
    nome_categoria varchar(20) not null,
    descricao_categoria varchar(300),
    primary key (id_categoria),
    foreign key (id_usuario_fk) references usuario(id_usuario)
) engine = InnoDB;

create table if not exists SAP.categoria_chara(
	id_categoria_fk int not null,
    id_chara_fk int not null,
    primary key (id_categoria_fk, id_chara_fk),
    foreign key (id_categoria_fk) references categoria(id_categoria),
    foreign key (id_chara_fk) references chara(id_chara)
) engine = InnoDB;

/*
drop table chat_mensagem;
drop table chat;
*/
create table if not exists SAP.chat(
	id_chat int not null auto_increment,
    id_usuario1_fk int not null,
    id_usuario2_fk int not null,
    primary key (id_chat),
    foreign key (id_usuario1_fk) references usuario(id_usuario),
    foreign key (id_usuario2_fk) references usuario(id_usuario)
) engine = InnoDB;

create table if not exists SAP.chat_mensagem(
	id_cm int not null auto_increment,
    id_usuario_fk int not null,
    id_chat_fk int not null,
    mensagem_cm varchar(300) not null,
	data_hora_cm datetime default now(),
    primary key (id_cm),
    foreign key (id_usuario_fk) references usuario(id_usuario),
    foreign key (id_chat_fk) references chat(id_chat)
) engine = InnoDB;


create table if not exists SAP.comentario(
	id_comentario int not null auto_increment,
    id_usuario_fk int not null,
    id_chara_fk int not null,
    mensagem_comentario varchar(300) not null,
	data_hora_comentario datetime default now(),
    primary key (id_comentario),
    foreign key (id_usuario_fk) references usuario(id_usuario),
    foreign key (id_chara_fk) references chara(id_chara)
) engine = InnoDB;

create table if not exists SAP.notificacao(
	id_notificacao int not null auto_increment,
    id_usuario_fk int not null,
    mensagem_notificacao varchar(300) not null,
	data_hora_notificacao datetime default now(                  ),
    primary key (id_notificacao),
    foreign key (id_usuario_fk) references usuario(id_usuario)
) engine = InnoDB;

insert into SAP.cargo (nome_cargo) values 
    ("Admin"),
    ("Moderador"),
    ("Usuário");

insert into SAP.usuario (nome_usuario, email_usuario, senha_usuario, ativado_usuario, id_cargo_fk) values 
	("admin", "admin@admin.admin", "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918", true, 1),
    ("notadmin", "notadmin@user.admin", "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918", false, 3),
    ("jonh", "jojo@user.admin", "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918", true, 2);
    
