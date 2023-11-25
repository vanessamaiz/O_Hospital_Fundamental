CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE IF NOT EXISTS especialidade
(id_especialidade int(11) primary key auto_increment,
nome_especialidade varchar(100) not null);

CREATE TABLE IF NOT EXISTS convenio
(id_convenio int(11) primary key auto_increment,
nome_convenio varchar(100),
cnpj_convenio varchar(14),
tempo_carencia varchar(100));

CREATE TABLE IF NOT EXISTS medico
(id_medico int(11) primary key auto_increment,
nome_medico varchar(255) not null,
crm varchar(6) unique not null,
email_medico varchar(150),
cargo varchar(100) not null,
especialidade_id int(11) not null,
foreign key(especialidade_id) references especialidade(id_especialidade)
 on delete cascade on update cascade);
 
ALTER TABLE medico
ADD COLUMN cpf_medico varchar(11) unique not null;
 
 CREATE TABLE IF NOT EXISTS paciente
 (id_paciente int(11) primary key auto_increment,
 nome_paciente varchar(255) not null,
 dt_nasc_paciente date,
 cpf_paciente varchar(14) unique not null,
 rg_paciente varchar(11) not null,
 email_paciente varchar(150),
 convenio_id int(11) default null,
 foreign key(convenio_id) references convenio(id_convenio)
 on delete cascade on update cascade);
 
 CREATE TABLE IF NOT EXISTS enfermeiro
 (id_enfermeiro int(11) primary key auto_increment,
 nome_enfermeiro varchar(255) not null,
 cpf_enfermeiro varchar(14) unique not null,
 cre varchar(13) unique not null);
 
 CREATE TABLE IF NOT EXISTS consulta
 (id_consulta int(11) primary key auto_increment,
 data_consulta date not null,
 hora_consulta time not null,
 valor_consulta decimal,
 convenio_id int(11) default null,
 medico_id int(11) not null,
 paciente_id int(11) not null,
 especialidade_id int(11) not null,
 foreign key(convenio_id) references convenio(id_convenio)
 on delete cascade on update cascade,
 foreign key(medico_id) references medico(id_medico)
 on delete cascade on update cascade,
 foreign key(paciente_id) references paciente(id_paciente)
 on delete cascade on update cascade,
 foreign key(especialidade_id) references especialidade(id_especialidade)
 on delete cascade on update cascade);
 
 CREATE TABLE IF NOT EXISTS receita
 (id_receita int(11) primary key auto_increment,
 medicamento varchar(150),
 qtd_medicamento int(11),
 instrucao_uso varchar(255),
 consulta_id int(11) not null,
 foreign key(consulta_id) references consulta(id_consulta)
 on delete cascade on update cascade);
 
 CREATE TABLE IF NOT EXISTS tipo_quarto
 (id_tipo int(11) primary key auto_increment,
 valor_quarto decimal(8,2) not null,
 desc_quarto varchar(100) default null);
 
 CREATE TABLE IF NOT EXISTS quarto
 (id_quarto int(11) primary key auto_increment,
 numero int(11) not null,
 tipo_id int(11) not null,
 foreign key(tipo_id) references tipo_quarto(id_tipo)
 on delete cascade on update cascade);
 
 CREATE TABLE IF NOT EXISTS internacao
 (id_internacao int(11) primary key auto_increment,
 data_entrada date not null,
 data_efet_alta date not null,
 desc_procedimento varchar(255),
 paciente_id int(11) not null,
 medico_id int(11) not null,
 quarto_id int(11) not null,
 foreign key(paciente_id) references paciente(id_paciente)
 on delete cascade on update cascade,
 foreign key(medico_id) references medico(id_medico)
 on delete cascade on update cascade,
 foreign key(quarto_id) references quarto(id_quarto)
 on delete cascade on update cascade);
 
 ALTER TABLE internacao
ADD COLUMN data_prev_alta date not null;
 
 CREATE TABLE IF NOT EXISTS internacao_enfermeiro
 (id_internacao_enfermeiro int(11) primary key auto_increment,
 internacao_id int(11) not null,
 enfermeiro_id int(11) not null,
 foreign key(internacao_id) references internacao(id_internacao)
 on delete cascade on update cascade,
 foreign key(enfermeiro_id) references enfermeiro(id_enfermeiro)
 on delete cascade on update cascade);
 
 CREATE TABLE IF NOT EXISTS medico_especialidade
 (id_medico_especialidade int(11) primary key auto_increment,
 medico_id int(11) not null,
 especialidade_id int(11) not null,
 foreign key(medico_id) references medico(id_medico)
 on delete cascade on update cascade,
 foreign key(especialidade_id) references especialidade(id_especialidade)
 on delete cascade on update cascade);
 
 CREATE TABLE IF NOT EXISTS telefone
 (id_telefone int(11) primary key auto_increment,
 ddd int (4) not null,
 num_telefone int(10) not null,
 paciente_id int(11) default null,
 medico_id int(11) default null,
 foreign key(paciente_id) references paciente(id_paciente)
 on delete cascade on update cascade,
 foreign key(medico_id) references medico(id_medico)
 on delete cascade on update cascade);
 
 CREATE TABLE IF NOT EXISTS endereco
 (id_endereco int(11) primary key auto_increment,
 rua varchar(150) not null,
 bairro varchar(100) not null,
 cep int(8) not null,
 cidade varchar(50) not null,
 estado varchar(50) not null,
 paciente_id int(11) default null,
 medico_id int(11) default null,
 foreign key(paciente_id) references paciente(id_paciente)
 on delete cascade on update cascade,
 foreign key(medico_id) references medico(id_medico)
 on delete cascade on update cascade);
 
 -- inserindo dados na tabela especialidade
 
 select * from especialidade;
 insert into especialidade(id_especialidade, nome_especialidade)
 values(1, "Pediatria");
 insert into especialidade(id_especialidade, nome_especialidade)
 values(2, "Clínico geral");
 insert into especialidade(id_especialidade, nome_especialidade)
 values(3, "Gastrenterologia");
 insert into especialidade(id_especialidade, nome_especialidade)
 values(4, "Dermatologia");
 insert into especialidade(id_especialidade, nome_especialidade)
 values(5, "Cardiologia");
 insert into especialidade(id_especialidade, nome_especialidade)
 values(6, "Neurologia");
 insert into especialidade(id_especialidade, nome_especialidade)
 values(7, "Oftamologia");
 
 -- inserindo dados na tabela convenio
 
 select * from convenio;
 insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia)
 values(1, "Porto Seguro", "53998672437105", "24 horas");
 insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia)
 values(2, "SulAmerica", "21558604578448", "20 dias");
 insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia)
 values(3, "Amil", "34698897935401", "40 dias");
 insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia)
 values(4, "Bradesco Saude", "21048645638480", "90 dias");
 
 -- inserindo dados na tabela tipo de quartos
 
 select * from tipo_quarto;
 insert into tipo_quarto(id_tipo, valor_quarto, desc_quarto)
 values(1, '900.00', 'Privado');
 insert into tipo_quarto(id_tipo, valor_quarto, desc_quarto)
 values(2, '600.00', 'Duplo');
 insert into tipo_quarto(id_tipo, valor_quarto, desc_quarto)
 values(3, '300.00', 'Coletivo');
 
 -- inserindo dados na tabela medico
 
 select * from medico;
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(1, 'Pedro Mendes Silva', '986837', '15638949321', 'pedro.mendes@gmail.com', 'Especialista', 1);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(2, 'Poliana Almeida', '766156', '1238912803', 'p.almeida@gmail.com', 'Generalista', 3);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(3, 'Luís Carlos', '806723', '36726845231', 'luis.carlos@gmail.com', 'Residente', 6);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(4, 'Luana Costa', '769231', '65931350459', 'l.costa@gmail.com', 'Especialista', 5);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(5, 'João Messias', '397573', '86473105697', 'joao.mss@gmail.com', 'Especialista', 4);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(6, 'Laura Sarmento', '103649', '98237864910', 'sarmento.laura@gmail.com', 'Generalista', 2);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(7, 'Apolo Silva', '123789', '14725812348', 'apolo.silv@gmail.com', 'Residente', 7);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(8, 'Gabriel Azevedo', '321987', '15555812322', 'gabriel.augusto@gmail.com', 'Generalista', 1);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(9, 'Vanessa Costa', '879364', '03876845019', 'van.costa@gmail.com', 'Residente', 2);
 insert into medico(id_medico, nome_medico, crm, cpf_medico, email_medico, cargo, especialidade_id)
 values(10, 'Lilian Carla', '109016', '98345615870', 'lili.carla@gmail.com', 'Especialista', 7);
 
 -- inserindo dados na tabela paciente
 
 select * from paciente;
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id)
values(1, 'Marcos Almeida Lima', '1973-02-25', '45612393108', '987654321', 'Marcos.A@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(2, 'Josefa Soares Lima', '1989-04-22', '89453209679', '954783662', 'jo.soares@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(3, 'Guilherme Souza', '2001-09-12', '69874692795', '786433812', 'gui.souza@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(4, 'Liana Nunes', '2003-01-10', '16368713706', '690178153', 'liana_nunes@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(5, 'Paulo Gustavo', '1991-01-26', '43014597010', '564893589', 'gustavo.paulo@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(6, 'Roberta Campos', '1973-02-26', '97699831156', '169848179', 'campos.roberta@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(7, 'Joana Silva', '1999-11-30', '46532178953', '631578943', 'joana-silva@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(8, 'Antônio Costa', '1985-07-15', '12456789315', '154897652', 'antonio-costa@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(9, 'Valentina Feitosa', '1978-09-06', '52164589652', '456789123', 'v.feitosa@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(10, 'Saulo Oliveira', '2000-09-09', '25894652561', '456789312', 's.oliveira@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(11, 'Marcela de Campos', '1974-11-06', '65879213596', '156478932', 'campos.marcela@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(12, 'Sophia Costa', '2005-11-10', '48967546358', '135497654', 'sophia.costa@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(13, 'Bruno Castro', '2001-12-05', '23456789132', '264584936', 'bruno_castro@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(14, 'Sara Dias', '2003-11-15', '45216547157', '453697821', 'saradias44@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) 
values(15,'Lana Moreno', '1990-12-12', '25648972365', '423659872', 'lana_m@gmail.com', 2);

-- inserindo dados da tabela telefone

select * from telefone;
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(1, 11, 953649586, 1);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(2, 11, 956478956, 2);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(3, 11, 978546856, 3);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(4, 11, 912345678, 4);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(5, 11, 945678125, 5);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(6, 11, 965789012, 6);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(7, 11, 978469532, 7);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(8, 11, 983125792, 8);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(9, 11, 930127569, 9);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(10, 11, 912879652, 10);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(11, 11, 923456987, 11);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(12, 11, 936785492, 12);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(13, 11, 987594658, 13);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(14, 11, 978649537, 14);
insert into telefone(id_telefone, ddd, num_telefone, paciente_id) values(15, 11, 984659726, 15);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(16, 11, 64532899, 1);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(17, 11, 45236528, 2);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(18, 11, 52346987, 3);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(19, 11, 62798546, 4);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(20, 11, 56428497, 5);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(21, 11, 56487289, 6);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(22, 11, 56428497,7);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(23, 11, 56475896, 8);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(24, 11, 45692375, 9);
insert into telefone(id_telefone, ddd, num_telefone, medico_id) values(25, 11, 87965823, 10);
 
 -- inserindo dados na tabela de endereco
 
select * from endereco;
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(16, 'R. São Joaquim', 'Liberdade', 01508001, 'São Paulo', 'São Paulo', 1);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(17, 'R. Manuel José Ratão', 'Casa Verde Baixa', 02501010, 'São Paulo', 'São Paulo', 2);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(18, 'R. Giovanni de Lucca', 'Casa Verde Baixa', 02501015, 'São Paulo', 'São Paulo', 3);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(19, 'R. Antônio de Luca', 'Capão Redondo',  05859020, 'São Paulo', 'São Paulo', 4);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(20, 'R. Passo da Pátria', 'Bela Aliança',  05085000, 'São Paulo', 'São Paulo', 5);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(21, ' R. Dona Ana Pimentel', 'Água Branca', 05002040, 'São Paulo', 'São Paulo', 6);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(22, ' R. Espírito Santo', 'Aclimação', 01526020, 'São Paulo', 'São Paulo', 7);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(23, ' R. Benedito Jacob', 'Aricanduva', 03505015, 'São Paulo', 'São Paulo', 8);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(24, 'Rua Cruzeiro', 'Barra Funda', 01137000, 'São Paulo', 'São Paulo', 9);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, medico_id) values(25, 'Rua Neuchatel', 'Capela do Socorro ', 04781030, 'São Paulo', 'São Paulo', 10);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(1, 'R. Ginaldo Willis Galdino', 'Jardim Antártica', 02652190, 'São Paulo', 'São Paulo', 1);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(2, 'R. Mário Tarenghi', ' Conjunto Habitacional Teotonio Vilela', 03928040, 'São Paulo', 'São Paulo', 2);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(3, 'R. São Joaquim', 'Liberdade', 01508001, 'São Paulo', 'São Paulo', 3);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(4, 'R. Alvarenga', 'Butatã', 05509001, 'São Paulo', 'São Paulo', 4);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(5, 'R. Maria do Carmo', 'Vila Alpina', 03206010, 'São Paulo', 'São Paulo', 5);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(6, 'R. Dom Bento pickel', 'Casa Verde Alta', 02555000, 'São Paulo', 'São Paulo', 6);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(7, 'R. Octávio Vidal de Azevedo', 'Residencial Morumbi.', 05745210, 'São Paulo', 'São Paulo', 7);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(8, 'R. Professora Maria Lucia Prandi', 'Cangaíba', 03717220, 'São Paulo', 'São Paulo', 8);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(9, 'Praça Presidente Getúlio Vargas', 'Centro', 07010000, 'Guarulhos', 'São Paulo', 9);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(10, 'R. Maria de Oliveira Arruda', 'Centro', 07010060, 'Guarulhos', 'São Paulo', 10);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(11, 'R. Vereador Paulo Teixeira', 'Vila Conceição', 07020150, 'Guarulhos', 'São Paulo', 11);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(12, 'R. Luiz Palma', 'Vila Conceição', 07020200, 'Guarulhos', 'São Paulo', 12);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(13, 'Rua Plácido da Costa Xavier', 'Vila Zanardi', 07020100, 'Guarulhos', 'São Paulo', 13);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(14, 'R. Gago Coutinho', 'Vila Yara',  02577020, 'Osasco', 'São Paulo', 14);
insert into endereco(id_endereco, rua, bairro, cep, cidade, estado, paciente_id) values(15, 'R. Cardeal Arcoverde', 'Pinheiros',  05407003, 'São Paulo', 'São Paulo', 15);
 
 -- inserindo dados da tabela enfermeiro
 
SELECT * FROM enfermeiro;
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(1, 'Samuel Sampaio', '68149713898', '512195');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(2, 'Lívia Andrade', '65736170984', '234038');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(3, 'Manuel Carlos', '45634746321', '327421');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(4, 'Pedro Lima', '75469609350', '908716');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(5, 'Iara Mendes', '56337811322', '565891');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(6, 'Samara Caetana', '89786876150', '067843');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(7, 'Karla Lima', '64258972130', '178065');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(8, 'Luana Ferreira', '03482169752', '713569');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(9, 'Marcos Luchi', '52367894210', '712869');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(10, 'Alfredo Cruz', '76459120150', '561795');

-- inserindo dados na tabela de consulta

SELECT * FROM consulta;
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(1, '2015-01-01', '13:40:00', '150.00', 2, 1, 3, 7);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) values(2, '2015-06-25', '15:40:00', '200.00', 10, 6, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) values(3, '2016-05-30', '20:00:00', '150.00', 9, 3, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(4, '2017-08-12', '19:50:00' ,'200.00', 3, 1, 15, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(5, '2020-08-15', '14:00:00','250.00', 1, 4, 12, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(6, '2020-12-24','17:35:00 ','100.00', 4, 2, 10, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(7, '2018-02-06','18:00:00','200.00', 1, 6, 8, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) value(8, '2020-11-26','12:30:00','200.00', 7, 7, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(9, '2019-01-29', '16:00:00', '150.00', 2, 5, 9, 7);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) value(10, '2020-10-21', '21:35:00','100.00', 2, 4, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(11, '2016-02-05', '10:00:00', '150.00', 1, 8, 11, 6);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) value(12, '2021-06-26','10:00:00', '150.00', 2, 1, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(13, '2019-07-19', '22:00:00','200.00', 7, 13, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) value(14, '2021-12-30', '11:00:00', '150.00', 1, 3, 14, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) value(15, '2021-02-20', '12:15:00', '250.00', 10, 5, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(16, '2015-07-22', '09:00:00', '100.00', 1, 8, 2, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(17, '2020-03-15', '08:15:00', '150.00', 3, 2, 5, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) values(18, '2017-08-02', '09:35:00', '200.00', 6, 14, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, medico_id, paciente_id, especialidade_id) values(19, '2021-04-04', '23:00:00', '150.00', 8, 13, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(20, '2019-09-23', '15:15:00', '100.00', 2, 9, 10, 3);
 
 -- inserindo dados na tabela receita
 
SELECT * FROM receita;
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(1, 'Dipirona 1g, ibuprofeno', '2', 'Tomar 1 comprimido de dipirona a cada 6 horas. Tomar 1 comprimido de ibuprofeno a cada 8 horas', 1);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(2, 'Losartana e Hidroclorotiazida', '2', 'Tomar um comprimido de Losartana e um comprimido de Hidroclorotiazida juntos, uma vez ao dia.', 2);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(3, 'AINE, Metotrexato', '2', 'Tomar o AINE duas vezes ao dia e o Metotrexato uma vez por semana.', 3);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(4, 'Roacutan, Pycnogenol', '2','Tomar um comprimido de roacutan uma vez ao dia. Tomar um comprimido de Pycnogenol uma vez ao dia', 4);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(5, 'Dipirona 1g, ibuprofeno', '2','Tomar 1 comprimido de dipirona a cada 6 horas. Tomar 1 comprimido de ibuprofeno a cada 8 horas', 5);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(6, 'Losartana e Hidroclorotiazida', '2', 'Tomar um comprimido de Losartana e um comprimido de Hidroclorotiazida juntos, uma vez ao dia.', 10);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(7, 'AINE, Metotrexato', '2', 'Tomar o AINE duas vezes ao dia e o Metotrexato uma vez por semana.', 11);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(8, 'Roacutan, Pycnogenol', '2','Tomar um comprimido de roacutan uma vez ao dia. Tomar um comprimido de Pycnogenol uma vez ao dia', 12);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(9, 'Dipirona 1g, ibuprofeno', '2','Tomar 1 comprimido de dipirona a cada 6 horas. Tomar 1 comprimido de ibuprofeno a cada 8 horas', 6);
insert into receita(id_receita, medicamento, qtd_medicamento, instrucao_uso, consulta_id) 
values(10,  'Losartana e Hidroclorotiazida', '2', 'Tomar um comprimido de Losartana e um comprimido de Hidroclorotiazida juntos, uma vez ao dia.', 14);
 
 -- inserindo dados na tabela quarta
 
SELECT * FROM quarto;
insert into quarto(id_quarto, numero, tipo_id) values(1, 201, 1);
insert into quarto(id_quarto, numero, tipo_id) values(2, 202, 2);
insert into quarto(id_quarto, numero, tipo_id) values(3, 203, 2);
insert into quarto(id_quarto, numero, tipo_id) values(4, 204, 3);
insert into quarto(id_quarto, numero, tipo_id) values(5, 205, 1);

-- inserindo dados tabela internacao

SELECT * FROM internacao;
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimento, paciente_id, medico_id, quarto_id) 
values(1, '2015-05-05', '2015-05-09', '2015-05-07', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.', 9, 7, 1);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimento, paciente_id, medico_id, quarto_id) 
values(2, '2016-12-12', '2016-12-20', '2016-12-15', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.', 7, 9, 3);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimento, paciente_id, medico_id, quarto_id) 
values(3, '2017-06-24', '2017-06-26', '2017-06-25','Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.',9, 3, 4);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimento, paciente_id, medico_id, quarto_id) 
values(4, '2018-07-10', '2018-07-15', '2018-07-13', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.', 7, 1, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimento, paciente_id, medico_id, quarto_id) 
values(5, '2020-08-12', '2020-08-19', '2020-08-15', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.', 15, 10, 5);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimento, paciente_id, medico_id, quarto_id) 
values(6, '2021-11-25', '2021-11-30', '2021-11-27', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.', 12, 5, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimento, paciente_id, medico_id, quarto_id) 
values(7, '2019-09-07', '2019-09-15', '2019-09-11',  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.', 14, 6, 3);

SELECT * FROM internacao_enfermeiro;
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(5, 3, 6);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(6, 3, 8);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(7, 4, 10);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(8, 4, 4);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(9, 5, 7);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(10, 5, 3);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(11, 6, 6);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(12, 6, 1);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(13, 7, 5);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(14, 7, 2);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(1, 1, 3);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(2, 1, 4);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(3, 2, 1);
insert into internacao_enfermeiro(id_internacao_enfermeiro, internacao_id, enfermeiro_id) values(4, 2, 2);

SELECT * FROM medico_especialidade;
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(1, 1, 1);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(2, 2, 2);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(3, 3, 3);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(4, 4, 4);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(5, 5, 5);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(6, 6, 6);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(7, 7, 7);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(8, 8, 1);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(9, 9, 2);
insert into medico_especialidade(id_medico_especialidade, medico_id, especialidade_id) values(10, 10, 3);

ALTER TABLE medico ADD em_atividade varchar(100);
update medico set em_atividade = 'Inativo' where id_medico = 1;
update medico set em_atividade = 'Ativo' where id_medico = 2;
update medico set em_atividade = 'Ativo' where id_medico = 3;
update medico set em_atividade = 'Ativo' where id_medico = 4;
update medico set em_atividade = 'Ativo' where id_medico = 5;
update medico set em_atividade = 'Ativo' where id_medico = 6;
update medico set em_atividade = 'Ativo' where id_medico = 7;
update medico set em_atividade = 'Ativo' where id_medico = 8;
update medico set em_atividade = 'Ativo' where id_medico = 9;
update medico set em_atividade = 'Inativo' where id_medico = 10;

-- Parte 5 -> Consultas

-- Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.

select *, avg(valor_consulta) as valor_medio_consultas
from consulta
where year(data_consulta) = 2020 and id_consulta is not null 
group by(data_consulta), id_consulta;

-- Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.

SELECT * FROM internacao where data_efet_alta > data_prev_alta;

-- Receituário completo da primeira consulta registrada com receituário associado.

SELECT * FROM consulta 
inner join receita on consulta.id_consulta = receita.consulta_id
inner join paciente on paciente.id_paciente = consulta.paciente_id
order by receita.id_receita limit 1;

-- Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio).

(SELECT *
 FROM consulta
 where convenio_id IS NULL
 order by valor_consulta DESC
 limit 1)
 
 UNION
 
 (SELECT *
 FROM consulta
 where convenio_id IS NULL
 order by valor_consulta ASC
 limit 1);
 
 -- Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.
 
 SELECT internacao.*, quarto.*, tipo_quarto.valor_quarto, 
       DATEDIFF(internacao.data_efet_alta, internacao.data_entrada) as dias_internado,
       DATEDIFF(internacao.data_efet_alta, internacao.data_entrada) * tipo_quarto.valor_quarto as valor_total
FROM internacao
INNER JOIN quarto ON internacao.quarto_id = quarto.id_quarto
INNER JOIN tipo_quarto ON quarto.tipo_id = tipo_quarto.id_tipo;

-- Data, procedimento e número de quarto de internações em quartos do tipo “privado”.

select i.id_internacao, i.data_entrada, i.desc_procedimento, q.numero from internacao i inner join quarto q 
on q.id_quarto = i.quarto_id where q.tipo_id = 1;

-- Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.

SELECT paciente.nome_paciente AS "Nome do Paciente",
       consulta.data_consulta AS "Data da Consulta",
       consulta.especialidade_id AS "Especialidade"
FROM paciente
INNER JOIN consulta ON paciente.id_paciente = consulta.paciente_id
WHERE (YEAR(NOW()) - YEAR(paciente.dt_nasc_paciente)) - (DATE_FORMAT(NOW(), '%m%d') < DATE_FORMAT(paciente.dt_nasc_paciente, '%m%d')) < 18
AND consulta.especialidade_id != 1
ORDER BY consulta.data_consulta;

-- Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.
 
 SELECT paciente.nome_paciente AS "Nome do Paciente",
       medico.nome_medico AS "Nome do Médico",
       internacao.data_entrada AS "Data da Internação",
       internacao.desc_procedimento AS "Procedimentos",
       quarto.id_quarto 
FROM internacao
INNER JOIN medico ON internacao.medico_id = medico.id_medico
INNER JOIN paciente ON internacao.paciente_id = paciente.id_paciente
INNER JOIN quarto ON quarto.id_quarto = internacao.quarto_id
WHERE medico.especialidade_id = 3 AND quarto.tipo_id = 3;

-- Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.

select m.nome_medico, m.crm, COUNT(c.medico_id) as 'Quantidade de Consultas'
from medico m 
inner join consulta c on c.medico_id = m.id_medico group by c.medico_id;

-- Todos os médicos que tenham "Gabriel" no nome.

select * from medico where nome_medico like '%Gabriel%';

-- Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.

select enfermeiro.nome_enfermeiro, enfermeiro.cre, COUNT(p.enfermeiro_id) as Participacao from enfermeiro enfermeiro
inner join internacao_enfermeiro p on p.enfermeiro_id = enfermeiro.id_enfermeiro group by enfermeiro.id_enfermeiro having Participacao > 1;

 
 
