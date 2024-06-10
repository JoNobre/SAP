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

/*
alter table comentario
add column editado_comentario boolean default false;

create table if not exists SAP.atributo (
	id int not null auto_increment,
    nome varchar(20) not null,
    primary key (id)
) engine = InnoDB;


create table if not exists SAP.chara_atributo (
	id_atributo int not null,
    id_chara int not null,
    valor int not null,
    primary key (id_atributo, id_chara),
    foreign key (id_atributo) references atributo(id),
    foreign key (id_chara) references chara(id)
) engine = InnoDB;
*/

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
	data_hora_cm datetime default(now()),
    primary key (id_cm),
    foreign key (id_usuario_fk) references usuario(id_usuario),
    foreign key (id_chat_fk) references chat(id_chat)
) engine = InnoDB;

create table if not exists SAP.tag(
	id_tag int not null auto_increment,
    nome_tag varchar(11) not null,
    primary key (id_tag)
)engine = InnoDB;

create table if not exists SAP.tag_usuario(
	id_tag_fk int not null,
    id_usuario_fk int not null,
    primary key (id_tag_fk,id_usuario_fk),
    foreign key (id_usuario_fk) references usuario(id_usuario),
    foreign key (id_tag_fk) references tag(id_tag)
)engine = InnoDB;

create table if not exists SAP.tag_chara(
	id_tag_fk int not null,
    id_chara_fk int not null,
    primary key (id_tag_fk,id_chara_fk),
    foreign key (id_chara_fk) references chara(id_chara),
    foreign key (id_tag_fk) references tag(id_tag)
)engine = InnoDB;

create table if not exists SAP.comentario(
	id_comentario int not null auto_increment,
    id_usuario_fk int not null,
    id_chara_fk int not null,
    mensagem_comentario varchar(300) not null,
	data_hora_comentario datetime default(now()),
    primary key (id_comentario),
    foreign key (id_usuario_fk) references usuario(id_usuario),
    foreign key (id_chara_fk) references chara(id_chara)
) engine = InnoDB;

create table if not exists SAP.notificacao(
	id_notificacao int not null auto_increment,
    id_usuario_fk int not null,
    mensagem_notificacao varchar(300) not null,
	data_hora_notificacao datetime default(now()),
    primary key (id_notificacao),
    foreign key (id_usuario_fk) references usuario(id_usuario)
) engine = InnoDB;

/*
create table if not exists SAP.multi_categoria(
	id_cat_1 int not null,
    id_cat_2 int not null,
    primary key (id_cat_1, id_cat_2),
    foreign key (id_cat_1) references categoria(id),
    foreign key (id_cat_2) references categoria(id)
) engine = InnoDB;
*/

insert into SAP.cargo (nome_cargo) values 
    ("Admin"),
    ("Moderador"),
    ("Usuário");

insert into SAP.usuario (nome_usuario, email_usuario, senha_usuario, ativado_usuario, id_cargo_fk) values 
	("admin", "admin@admin.admin", "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918", true, 1),
    ("notadmin", "notadmin@user.admin", "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918", false, 3),
    ("jonh", "jojo@user.admin", "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918", true, 2);

insert into categoria_chara (id_chara_fk, id_categoria_fk) values 
    (3,1),
    (4,1),
    (5,2);
    
insert into tag (nome_tag) values
	("vermelho"),
    ("verde"),
    ("azul"),
    ("amarelo"),
    ("roxo");
    
insert into tag_usuario (id_tag_fk,id_usuario_fk) values
		(1,1),
        (2,1),
        (3,1),
        (4,2),
        (5,2),
        (1,3),
        (4,3);

insert into categoria_chara (id_chara_fk, id_categoria_fk) values (8,1);
delete from categoria_chara where id_chara_fk = 8 and id_categoria_fk = 1;

insert into notificacao (id_usuario_fk, mensagem_notificacao) values 
	(1,"Shikononokonokonoshitantan"),
    (1,"EEEEEEEEE"),
    (1,"ShikoASDASDASDnonokonokonoshitantan"),
    (1,"oisdfslkdfslkjdf");
    
/*
insert into SAP.chat (id_usuario_1, id_usuario_2) values (1,2);
insert into SAP.chat_mensagem (id_usuario,id_chat, mensagem, data_hora) values (1,1,"Mingo Bile","2023-05-20 09:20:03");

select * from chat;
select * from chat_mensagem order by data_hora;

*/
select * from usuario;
select * from usuario where nome_usuario like '%jon%' or nome_usuario like '%ivo%';
select * from usuario where nome_usuario like '%jon%' or nome_usuario like '%ivo%';
select * from comentario;
select * from notificacao;
select count(*)as qtd from notificacao where id_usuario_fk = 1;
select * from comentario where id_chara_fk = 4 order by data_hora_comentario DESC;

select c.*, u.nome_usuario from comentario c 
	inner join usuario u on c.id_usuario_fk = u.id_usuario
	where id_chara_fk = 4 order by data_hora_comentario DESC;

select length(senha_usuario) from usuario;
select * from cargo; 
select * from chara; 
select u.id_usuario, u.nome_usuario, u.email_usuario, u.senha_usuario, 
	case when u.ativado_usuario = 0 then 'não' else 'sim' end as ativado,
    c.nome_cargo, u.id_cargo_fk from usuario u inner join 
	cargo c on u.id_cargo_fk = c.id_cargo order by u.id_usuario;
    
    
    
Select * from usuario where ativado_usuario = false;
Select * from chara;
select * from categoria;
select * from categoria_chara;

select * from chara c inner join categoria_chara cc on
	c.id_chara = cc.id_chara_fk where id_usuario_fk = 1;
select * from chara c left join categoria_chara cc on
	c.id_chara = cc.id_chara_fk where id_usuario_fk = 1 and id_categoria_fk = 1;    

select * from categoria where id_usuario_fk = 1;
select u.id_usuario, u.nome_usuario, u.email_usuario, u.senha_usuario, 	u.ativado_usuario,c.nome_cargo as cargo from usuario u inner join cargo c on u.id_cargo_fk = c.id_cargo order by u.id_usuario;

select c.id_chara, c.id_usuario_fk, u.nome_usuario, c.nome_chara, c.descricao_chara, img_link_chara
	from chara c inner join usuario u on c.id_usuario_fk = u.id_usuario;
    
select count(*) as qtd from usuario where id_usuario = 0;

select * from chat;
select cm.*,u.nome_usuario from chat_mensagem cm inner join usuario u on cm.id_usuario_fk = u.id_usuario where id_chat_fk = 2 order by data_hora_cm;

insert into chat (id_usuario1_fk,id_usuario2_fk) select 3,1
	where not exists (select 1 from chat where (id_usuario1_fk = 1 and id_usuario2_fk = 3) or (id_usuario1_fk = 3 and id_usuario2_fk = 1));
update chara set id_usuario_fk = 2 where id_chara = 10; 