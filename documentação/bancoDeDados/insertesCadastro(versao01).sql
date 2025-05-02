-- 01
INSERT INTO cadastro_identificacao (nome, cpf,cod_municipio,ativo) VALUES ('joselito','13432640900',1,'n');

-- 02
INSERT INTO role_cadastro (cod_usuario,cod_tipoRole) VALUES (1,1);

-- 03
INSERT INTO login_usuario (cod_usuario,email_usuario,senha) VALUES (1,'oas@gmail.com','senha');

-- 04
INSERT INTO administrador (cod_administrador,ativo,tipo_role) VALUES (1,'s',1);

-- 05
INSERT INTO administrador_instituicao (cod_administrador,cod_instituicao) VALUES (1,1);

-- 06
INSERT INTO administrador_subInstituto (cod_administrador,cod_subInstituicao) VALUES (1,1);

-- 07
INSERT INTO staff (cod_staff,ativo) VALUES (1,'s');

--  08
INSERT INTO subInstituto_staff (cod_staff,cod_subInstituto) VALUES (1,1);

--  09
INSERT INTO staff_turma (cod_staff,cod_turma) VALUES (1,1);

-- 10
INSERT INTO jogador (cod_jogador,ativo,data_nascimento,posicao,esporte,ficha_medica_cod_jogador) VALUES (1,'s','2025-12-31',1,1,1);

--  11
INSERT INTO midia_jogador (cod_jogador,local_midia) VALUES (1,'midia/zjor.png');

-- 12
INSERT INTO contato_responsavel (nomeResponsavel,tipoFiliacao,emailResponsavel,telefoneResponsavel) VALUES ('maria vlau','mae','jora@gmail.com','41940804942');

-- 13
INSERT INTO jogador_contatoResponsavel (cod_jogador,cod_contatoResponsavel) VALUES (1,1);

-- 14
INSERT INTO historicoLesoes (cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) VALUES (3, 'quebrou pé', '2003-02-13', '40 dias');

-- 15
INSERT INTO fichaMedica (cod_jogador,altura,peso,tipoSanguineo,restricoes_medicas,alergias,data_atualizacao) VALUES (1,182,765,'O+','Nenhuma','Poeira, Pólen','2025-04-22');

-- 16
INSERT INTO fichaMedica_historicoLesoes (cod_jogador,cod_historicoLesoes) VALUES (1,1);

-- 17
INSERT INTO nota_jogador (cod_jogador,cod_staff,nota_jogador,ativo) VALUES (1,1,1,'s');

-- 18
INSERT INTO turma_jogador (cod_turma,cod_jogador) VALUES (1,1);