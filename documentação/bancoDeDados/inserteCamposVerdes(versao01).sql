SET 
  SQL_MODE = @OLD_SQL_MODE;
SET 
  FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET 
  UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

-- Inserção de nações-- Inserção de nação (somente Brasil)
INSERT INTO nacao (sigla_nacao, desc_nacao) VALUES
('br', 'Brasil');

-- Inserção de estados do Brasil (cod_nacao = 1)
INSERT INTO estado (cod_nacao, desc_estado, sigla_estado) VALUES
(1, 'Paraná', 'pr'),         -- cod_estado = 1
(1, 'São Paulo', 'sp'),      -- cod_estado = 2
(1, 'Bahia', 'ba');          -- cod_estado = 3

-- Inserção de municípios do Paraná (cod_estado = 1)
INSERT INTO municipio (cod_estado, desc_municipio, sigla_municipio) VALUES
(1, 'Colombo', 'ct'),
(1, 'Curitiba', 'ct'),
(1, 'Londrina', 'ld'),
(1, 'Maringá', 'mg'),
(1, 'Cascavel', 'cv'),
(1, 'Guarapuava', 'gp');

-- Municípios de São Paulo (cod_estado = 2)
INSERT INTO municipio (cod_estado, desc_municipio, sigla_municipio) VALUES
(2, 'São Paulo', 'sp'),
(2, 'Campinas', 'cp'),
(2, 'Santos', 'st'),
(2, 'São Bernardo do Campo', 'sb'),
(2, 'Guarulhos', 'gl');

-- Municípios da Bahia (cod_estado = 3)
INSERT INTO municipio (cod_estado, desc_municipio, sigla_municipio) VALUES
(3, 'Salvador', 'sv'),
(3, 'Feira de Santana', 'fs'),
(3, 'Vitória da Conquista', 'vc'),
(3, 'Itabuna', 'ib'),
(3, 'Ilhéus', 'il');

-- Inserção de tipos de instituição
INSERT INTO tipo_instituicao (desc_tipo_instituicao) VALUES
('Clube'),
('Federação'),
('Escola'),
('Associação'),
('Confederação'),
('Liga'),
('Instituição Privada'),
('Instituição Pública'),
('Academia'),
('Escola de Esportes'),
('Organização Não Governamental');

-- Inserção de esportes
INSERT INTO esporte (desc_esporte) VALUES 
('Futebol'), 
('Vôlei'), 
('Futebol');

-- Inserção de posições
INSERT INTO posicao (cod_posicao, cod_esporte, desc_posicao, sigla_posicao) VALUES
-- Futebol (cod_esporte = 1)
(1, 1, 'Goleiro', 'GL'),
(2, 1, 'Zagueiro', 'ZAG'),
(3, 1, 'Lateral Direito', 'LD'),
(4, 1, 'Lateral Esquerdo', 'LE'),
(5, 1, 'Volante', 'VOL'),
(6, 1, 'Meia-Central', 'MC'),
(7, 1, 'Meia-Ofensivo', 'MO'),
(8, 1, 'Ponta Direita', 'PD'),
(9, 1, 'Ponta Esquerda', 'PE'),
(10, 1, 'Atacante', 'ATA'),
(11, 1, 'Centroavante', 'CA'),

-- Vôlei (cod_esporte = 2)
(12, 2, 'Armador', 'ARM'),
(13, 2, 'Ala-Armador', 'AA'),
(14, 2, 'Ala', 'ALA'),
(15, 2, 'Ala-Pivô', 'AP'),
(16, 2, 'Pivô', 'PIV'),

-- Vôlei (cod_esporte = 3)
(17, 3, 'Levantador', 'LEV'),
(18, 3, 'Oposto', 'OPO'),
(19, 3, 'Ponteiro', 'PON'),
(20, 3, 'Central', 'CEN'),
(21, 3, 'Líbero', 'LIB');

-- Inserção de grau de privacidade
INSERT INTO grau_privacidade (cod_grau_privacidade, desc_grau_privacidade) VALUES
(1, 'privada'),
(2, 'staff'),
(3, 'staff|jogador');


INSERT INTO tipo_role(desc_tipo_role,abrev_tipo_role,ativo) values
('Admistrador de sistemas','TI','s'),
('Admistrador de Instituição','ADMI','s'),
('Admistrador de Sub-Instituição','ADMS','s'),
('Admistrador de Sub-Instituição e Staff','ADMS|STAFF','s'),
('Treinadores','STAFF','s'),
('jogadores','','s');

INSERT INTO instituicao (desc_instituicao, ativo, cod_tipo_instituicao) VALUES 
('Universidade do Sol', 's', 3),
('Centro Técnico Alfa', 's', 1),
('Instituto Delta', 's', 7),
('Faculdade Horizonte', 's', 2),
('Escola Técnica Nova Geração', 's', 5),
('Academia Científica Orion', 's', 9),
('Colégio Saber Futuro', 's', 4),
('Instituto de Pesquisas Quark', 's', 11),
('Universidade Internacional PontoCom', 's', 6),
('Centro de Inovação Vortex', 's', 8);

INSERT INTO subInstituicao (Cod_Instituicao, ativo, desc_subInstituicao, Cod_Municipio) VALUES
(1, 's', 'Campus Central - Bloco A', 2),
(2, 's', 'Unidade Zona Norte', 5),
(3, 's', 'Extensão Tecnológica Sul', 1),
(4, 's', 'Polo Educacional Mar Azul', 3),
(5, 's', 'Núcleo de Pesquisa Aurora', 7),
(6, 's', 'Centro de Formação Técnica', 4),
(7, 's', 'Campus Avançado Oeste', 6),
(8, 's', 'Unidade Experimental Leste', 8),
(9, 's', 'Subunidade Acadêmica Alfa', 9),
(9, 's', 'Ponto de Apoio Regional', 10);

INSERT INTO turma (desc_turma, ativo, cod_subInstituicao) VALUES
('Turma A - Manhã', 's', 1),
('Turma B - Tarde', 's', 2),
('Turma C - Noite', 's', 3),
('Turma D - Integral', 's', 4),
('Turma E - Manhã', 's', 5),
('Turma F - Tarde', 's', 6),
('Turma G - Noite', 's', 7),
('Turma H - Integral', 's', 8),
('Turma I - Manhã', 's', 9),
('Turma J - Tarde', 's', 10);

INSERT INTO tipo_lesao (desc_tipoLesao) VALUES 
('Lesões de Pele'),
('Lesões Musculares'),
('Lesões nas Articulações'),
('Lesões Neurológicas'),
('Lesões no Pé e Tornozelo'),
('Lesões no Pescoço ou Coluna'),
('Lesões no Quadril ou Lombar'),
('Lesões nos Ligamentos'),
('Lesões nos Meniscos'),
('Lesões nos Ossos'),
('Lesões nos Tendões');

INSERT INTO cadastro_identificacao (nome, cpf,cod_municipio,ativo) VALUES ('sistema','1',1,'s');
INSERT INTO role_cadastro (cod_usuario,cod_tipoRole) VALUES (1,5);
INSERT INTO staff(cod_staff) VALUES (1);


-- CAADASTRO DE TI
insert into cadastro_identificacao(nome,cpf,ativo,cod_municipio) values ('Cadastro TI',123,'s',2);
insert into role_cadastro(cod_usuario,cod_tipoRole) values(2,1);
insert into login_usuario(cod_usuario,email_usuario,senha) values (2,'ti@gmail.com','ti');

-- CADASTRO DE JOGADOR
INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('joselito', '13432640900', 1, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (2, 6);
INSERT INTO jogador(cod_jogador, data_nascimento, posicao, esporte) VALUES (2, '2025-12-31', 1, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (1, 2);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (2, 'midia/zjor.png');
INSERT INTO contato_responsavel (nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) VALUES ('maria vlau', 'mae', 'jora@gmail.com', '41940804942');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (2, 1);
INSERT INTO historicoLesoes (cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) VALUES (3, 'quebrou pé', '2003-02-13', '40 dias');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) VALUES (2, 182, 765, 'O+', 'Nenhuma', 'Poeira, Pólen', '2025-04-22');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (2, 1);
insert into login_usuario(cod_usuario,email_usuario,senha) values (3,'jogador@gmail.com','jogador');

-- cadastro ADMI
INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('admi', 123, 1, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (4, 4);
INSERT INTO administrador (cod_administrador, tipo_role) VALUES (4,2);
INSERT INTO administrador_instituicao (cod_administrador, cod_instituicao) VALUES (4, 1);
insert into login_usuario(cod_usuario,email_usuario,senha) values (4,'admi@gmail.com','admi');

-- cadastro ADMS
INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('adms', 123, 1, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (5, 4);
INSERT INTO administrador (cod_administrador, tipo_role) VALUES (5,3);
INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao) VALUES (4, 1);
insert into login_usuario(cod_usuario,email_usuario,senha) values (5,'adms@gmail.com','adms');

-- cadastro staff
INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('staff', 123, 1, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (6, 5);
INSERT INTO staff (cod_staff) VALUES (6);
INSERT INTO subInstituticao_staff (cod_staff, cod_subInstituicao) VALUES (6, 1);
insert into login_usuario(cod_usuario,email_usuario,senha) values (6,'staff@gmail.com','staff');


-- cadastro staffAdms
INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('staffAdms', 123, 1, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (7,5);
INSERT INTO staff (cod_staff) VALUES (7);
INSERT INTO administrador (cod_administrador, tipo_role) VALUES (7,4);
INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao) VALUES (7, 1);
INSERT INTO subInstituticao_staff (cod_staff, cod_subInstituicao) VALUES (7, 1);
insert into login_usuario(cod_usuario,email_usuario,senha) values (7,'staffAdms@gmail.com','staffAdms');


-- headers (agora só para o ADMS)

INSERT INTO item_menu (role_html) VALUES 
  ('Gerenciamento de Usuários'), -- cod_item_menu = 1
  ('Relatórios');                -- cod_item_menu = 2

-- Submenus para "Gerenciamento de Usuários" (cod_item_menu = 1)
INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(1, '/tcc/telas/TI/telaCadastroTI.php', 'Cadastro TI'),
(1, '/tcc/telas/ADMI/telaCadastroADMI.php', 'Cadastro ADMI'),
(1, '/tcc/telas/ADMS/telaCadastroADMS.php', 'Cadastro ADMS'),
(1, '/tcc/telas/STAFFADMS/telaCadastroStaffADMS.php', 'Cadastro Staff ADMS'),
(1, '/tcc/telas/STAFF/telaCadastroStaff.php', 'Cadastro Staff'),
(1, '/tcc/telas/JOGADOR/telaCadastroJogador.php', 'Cadastro Jogador');

-- Submenus para "Relatórios" (cod_item_menu = 2)
INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(2, '/tcc/telas/TI/telaDadosInstituicao.php', 'Instituição'),
(2, '/tcc/telas/ADMI/telaDadosSubInstituicao.php', 'Sub-Instituição'),
(2, '/tcc/telas/ADMS/telaDadosTurma.php', 'Turma'),
(2, '/tcc/telas/TI/telaDadosNacao.php', 'Nação'),
(2, '/tcc/telas/TI/telaDadosEstado.php', 'Estado'),
(2, '/tcc/telas/TI/telaDadosMunicipio.php', 'Município');



-- Relacionar todos os tipos de role com os menus principais
INSERT INTO itemMenu_tipoRole (cod_item_menu, cod_tipo_role) VALUES
(1, 1), (2, 1), -- TI
(1, 2), (2, 2), -- ADMI
(1, 3), (2, 3), -- ADMS
(1, 4), (2, 4), -- ADMS|STAFF
(1, 5), (2, 5), -- STAFF
(1, 6), (2, 6); -- JOGADOR


-- TI
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 1, 1),  -- Cadastro TI
(1, 2, 1),  -- Cadastro ADMI
(1, 3, 1),  -- Cadastro ADMS
(1, 4, 1),  -- Cadastro Staff ADMS
(1, 5, 1),  -- Cadastro Staff
(1, 6, 1),  -- Cadastro Jogador
(2, 7, 1),  -- /tcc/telas/TI/telaDadosInstituicao.php
(2, 8, 1),  -- /tcc/telas/ADMI/telaDadosSubInstituicao.php
(2, 9, 1),   -- /tcc/telas/ADMS/telaDadosTurma.php
(2, 10, 1),  -- /tcc/telas/TI/telaDadosNacao.php
(2, 11, 1),  -- /tcc/telas/TI/telaDadosEstado.php
(2, 12, 1);  -- /tcc/telas/TI/telaDadosMunicipio.php

-- ADMI
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 2, 2),  -- Cadastro ADMI
(1, 3, 2),  -- Cadastro ADMS
(1, 4, 2),  -- Cadastro Staff ADMS
(1, 5, 2),  -- Cadastro Staff
(1, 6, 2),  -- Cadastro Jogador
(2, 8, 2),  -- /tcc/telas/ADMI/telaDadosSubInstituicao.php
(2, 9, 2);   -- /tcc/telas/ADMS/telaDadosTurma.php

-- ADMS
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 3, 3),  -- Cadastro ADMS
(1, 4, 3),  -- Cadastro Staff ADMS
(1, 5, 3),  -- Cadastro Staff
(1, 6, 3),  -- Cadastro Jogador
(2, 9, 3);   -- /tcc/telas/ADMS/telaDadosTurma.php

-- ADMS|STAFF
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 3, 4),  -- Cadastro ADMS
(1, 4, 4),  -- Cadastro Staff ADMS
(1, 5, 4),  -- Cadastro Staff
(1, 6, 4),  -- Cadastro Jogador
(2, 9, 4);   -- /tcc/telas/ADMS/telaDadosTurma.php

-- -- STAFF
-- INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES

-- -- JOGADOR
-- INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES