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


