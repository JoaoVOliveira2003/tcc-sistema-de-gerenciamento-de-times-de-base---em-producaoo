SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,  UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `tcc`;
CREATE SCHEMA IF NOT EXISTS `tcc` DEFAULT CHARACTER SET utf8mb4;
USE `tcc`;

CREATE TABLE `nacao` (
  `cod_nacao` INT NOT NULL AUTO_INCREMENT, 
  `sigla_nacao` CHAR(3), 
  `desc_nacao` VARCHAR(50), 
  PRIMARY KEY (`cod_nacao`)
) ENGINE = InnoDB;

CREATE TABLE `estado` (
  `cod_estado` INT NOT NULL AUTO_INCREMENT, 
  `cod_nacao` INT NOT NULL, 
  `desc_estado` VARCHAR(50), 
  `sigla_estado` CHAR(3), 
  PRIMARY KEY (`cod_estado`), 
  CONSTRAINT `fk_estado_nacao` FOREIGN KEY (`cod_nacao`) REFERENCES `nacao` (`cod_nacao`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `municipio` (
  `cod_municipio` INT NOT NULL AUTO_INCREMENT, 
  `cod_estado` INT NOT NULL, 
  `desc_municipio` VARCHAR(50), 
  `sigla_municipio` CHAR(3), 
  PRIMARY KEY (`cod_municipio`), 
  CONSTRAINT `fk_municipio_estado` FOREIGN KEY (`cod_estado`) REFERENCES `estado` (`cod_estado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;


CREATE TABLE `cadastro_identificacao` (
  `cod_usuario` INT NOT NULL AUTO_INCREMENT, 
  `nome` VARCHAR(100), 
  `cpf` VARCHAR(11), 
  `ativo` CHAR(1), 
  `cod_municipio` INT NOT NULL, 
  PRIMARY KEY (`cod_usuario`), 
  CONSTRAINT `fk_identificacao_municipio` FOREIGN KEY (`cod_municipio`) REFERENCES `municipio` (`cod_municipio`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `login_usuario` (
  `cod_usuario` INT NOT NULL, 
  `email_usuario` VARCHAR(50), 
  `senha` VARCHAR(255), 
  PRIMARY KEY (`cod_usuario`), 
  CONSTRAINT `fk_login_usuario_identificacao` FOREIGN KEY (`cod_usuario`) REFERENCES `cadastro_identificacao` (`cod_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tipo_role` (
  `cod_tipo_role` INT NOT NULL AUTO_INCREMENT, 
  `desc_tipo_role` VARCHAR(100), 
  `abrev_tipo_role` CHAR(10), 
  `ativo` CHAR(1) DEFAULT 'S', 
  PRIMARY KEY (`cod_tipo_role`)
) ENGINE = InnoDB;


CREATE TABLE item_menu (
  cod_item_menu INT NOT NULL AUTO_INCREMENT,
  role_html VARCHAR(200),
  PRIMARY KEY (cod_item_menu)
);

CREATE TABLE subitem_menu (
  cod_subitem_menu INT NOT NULL AUTO_INCREMENT,
  cod_item_menu INT NOT NULL,
  href VARCHAR(200),
  label VARCHAR(200),
  PRIMARY KEY (cod_subitem_menu),
  CONSTRAINT fk_subitem_item_menu
    FOREIGN KEY (cod_item_menu)
    REFERENCES item_menu (cod_item_menu)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE itemMenu_tipoRole (
  cod_item_menu INT NOT NULL,
  cod_tipo_role INT NOT NULL,
  PRIMARY KEY (cod_item_menu, cod_tipo_role),
  CONSTRAINT fk_item_menu_tipo
    FOREIGN KEY (cod_item_menu) REFERENCES item_menu (cod_item_menu) ON DELETE CASCADE,
  CONSTRAINT fk_tipo_menu_item
    FOREIGN KEY (cod_tipo_role) REFERENCES tipo_role (cod_tipo_role) ON DELETE CASCADE
);

CREATE TABLE itemMenu_subitemMenu (
  cod_item_menu INT NOT NULL,
  cod_subitem_menu INT NOT NULL,
  cod_tipo_role INT NOT NULL,
  CONSTRAINT fk_item_menu_subitem_menu
    FOREIGN KEY (cod_item_menu) REFERENCES item_menu (cod_item_menu) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_subitem_menu_item_menu
    FOREIGN KEY (cod_subitem_menu) REFERENCES subitem_menu (cod_subitem_menu) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `role_cadastro` (
  `cod_role_cadastro` INT NOT NULL AUTO_INCREMENT, 
  `cod_usuario` INT NOT NULL, 
  `cod_tipoRole` INT NOT NULL, 
  PRIMARY KEY (`cod_role_cadastro`), 
  CONSTRAINT `fk_role_usuario` FOREIGN KEY (`cod_usuario`) REFERENCES `cadastro_identificacao` (`cod_usuario`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_role_tipo_role` FOREIGN KEY (`cod_tipoRole`) REFERENCES `tipo_role` (`cod_tipo_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `staff` (
  `cod_staff` INT NOT NULL AUTO_INCREMENT,  
  PRIMARY KEY (`cod_staff`), 
  CONSTRAINT `fk_staff_role_cadastro` FOREIGN KEY (`cod_staff`) REFERENCES `role_cadastro` (`cod_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE `administrador` (
  `cod_administrador` INT NOT NULL AUTO_INCREMENT, 
  `tipo_role` INT NOT NULL, 
  PRIMARY KEY (`cod_administrador`), 
  CONSTRAINT `fk_admin_role` FOREIGN KEY (`cod_administrador`) REFERENCES `role_cadastro` (`cod_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tipo_instituicao` (
  `cod_tipo_instituicao` INT NOT NULL AUTO_INCREMENT, 
  `desc_tipo_instituicao` VARCHAR(100), 
  PRIMARY KEY (`cod_tipo_instituicao`)
) ENGINE = InnoDB;

CREATE TABLE `instituicao` (
  `cod_instituicao` INT NOT NULL AUTO_INCREMENT, 
  `desc_instituicao` VARCHAR(100), 
  `ativo` CHAR(1), 
  `cod_tipo_instituicao` INT, 
  PRIMARY KEY (`cod_instituicao`), 
  CONSTRAINT `fk_instituicao_tipo` FOREIGN KEY (`cod_tipo_instituicao`) REFERENCES `tipo_instituicao` (`cod_tipo_instituicao`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE administrador_instituicao (
  cod_administrador INT NOT NULL, 
  cod_instituicao INT NOT NULL, 
  PRIMARY KEY (cod_administrador, cod_instituicao), 
  CONSTRAINT fk_adm_instituicao_administrador FOREIGN KEY (cod_administrador) REFERENCES administrador(cod_administrador) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT fk_adm_instituicao_instituicao FOREIGN KEY (cod_instituicao) REFERENCES instituicao(cod_instituicao) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `tcc`.`subInstituicao` (
  Cod_SubInstituicao INT NOT NULL AUTO_INCREMENT, 
  Cod_Instituicao INT NOT NULL, 
  ativo CHAR(1) DEFAULT 'S', 
  desc_subInstituicao VARCHAR(100), 
  Cod_Municipio INT NOT NULL, 
  PRIMARY KEY (Cod_SubInstituicao), 
  CONSTRAINT fk_subInstituicao_instituicao FOREIGN KEY (Cod_Instituicao) REFERENCES tcc.instituicao (cod_instituicao) ON DELETE NO ACTION ON UPDATE CASCADE, 
  CONSTRAINT fk_subInstituicao_municipio FOREIGN KEY (Cod_Municipio) REFERENCES tcc.municipio (cod_municipio) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`subInstituticao_staff` (
  `cod_staff` INT NOT NULL, 
  `cod_SubInstituicao` INT NOT NULL, 
  PRIMARY KEY (`cod_staff`, `cod_SubInstituicao`), 
  CONSTRAINT `fk_staff` FOREIGN KEY (`cod_staff`) REFERENCES `tcc`.`staff` (`cod_staff`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_subInstituto` FOREIGN KEY (`cod_SubInstituicao`) REFERENCES `tcc`.`subInstituicao` (`cod_instituicao`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`administrador_subInstituicao` (
  `cod_administrador` INT NOT NULL, 
  `cod_subInstituicao` INT NOT NULL, 
  PRIMARY KEY (
    `cod_administrador`, `cod_subInstituicao`
  ), 
  FOREIGN KEY (`cod_administrador`) REFERENCES `tcc`.`administrador` (`cod_administrador`) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (`cod_subInstituicao`) REFERENCES `tcc`.`subInstituicao` (`cod_subInstituicao`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


CREATE TABLE turma (
  cod_turma INT PRIMARY KEY AUTO_INCREMENT, 
  desc_turma VARCHAR(50), 
  ativo CHAR(1), 
  cod_subInstituicao INT NOT NULL, 
  CONSTRAINT fk_turma_subInstituicao 
    FOREIGN KEY (cod_subInstituicao) REFERENCES subInstituicao(Cod_SubInstituicao)
    ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `tcc`.`staff_turma` (
  `cod_staff` INT NOT NULL, 
  `cod_turma` INT NOT NULL, 
  PRIMARY KEY (`cod_staff`, `cod_turma`), 
  CONSTRAINT `fk_staff_turma_staff` FOREIGN KEY (`cod_staff`) REFERENCES `tcc`.`staff` (`cod_staff`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_staff_turma_turma` FOREIGN KEY (`cod_turma`) REFERENCES `tcc`.`turma` (`cod_turma`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`evento` (
  cod_evento INT NOT NULL AUTO_INCREMENT, 
  cod_staff INT NOT NULL, 
  titulo_evento VARCHAR(50), 
  data DATE, 
  horario TIME, 
  local VARCHAR(50), 
  desc_evento VARCHAR(200), 
  ativo CHAR(1), 
  PRIMARY KEY (cod_evento), 
  CONSTRAINT fk_evento_staff FOREIGN KEY (cod_staff) REFERENCES tcc.staff(cod_staff) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`esporte` (
  `cod_esporte` INT NOT NULL AUTO_INCREMENT, 
  `desc_esporte` VARCHAR(25) NOT NULL, 
  PRIMARY KEY (`cod_esporte`)
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`posicao` (
  `cod_posicao` INT NOT NULL AUTO_INCREMENT, 
  `cod_esporte` INT NOT NULL, 
  `desc_posicao` VARCHAR(100), 
  `sigla_posicao` CHAR(5), 
  PRIMARY KEY (`cod_posicao`), 
  CONSTRAINT `fk_posicao_esporte` FOREIGN KEY (`cod_esporte`) REFERENCES `tcc`.`esporte` (`cod_esporte`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`Treino` (
  `cod_treino` INT AUTO_INCREMENT PRIMARY KEY,
  `cod_staff` INT NOT NULL,
  `cod_esporte` INT NOT NULL,
  `tempo_treino` INT,
  `dataTreino` DATE NULL,
  `nomeTreino` VARCHAR(200) NULL,
  FOREIGN KEY (`cod_staff`) REFERENCES `staff`(`cod_staff`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`cod_esporte`) REFERENCES `esporte`(`cod_esporte`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`midia_TreinoJogo` (
  `cod_midiaTreino` INT NOT NULL AUTO_INCREMENT, 
  `local_midia` VARCHAR(45) NULL, 
  PRIMARY KEY (`cod_midiaTreino`)
) ENGINE = InnoDB;


CREATE TABLE `tcc`.`midia_treino` (
  `cod_midiaTreino` INT NOT NULL, 
  `cod_treino` INT NOT NULL, 
  PRIMARY KEY (`cod_midiaTreino`), 

  CONSTRAINT `fk_midia_treino_treino` 
    FOREIGN KEY (`cod_treino`) 
    REFERENCES `tcc`.`Treino`(`cod_treino`) 
    ON DELETE CASCADE ON UPDATE CASCADE


) ENGINE = InnoDB;

CREATE TABLE grau_privacidade(
  cod_grau_privacidade INT PRIMARY KEY, 
  desc_grau_privacidade VARCHAR(100) NOT NULL
);

CREATE TABLE notaTreino_jogador (
  cod_notaTreino INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cod_jogador INT NOT NULL, 
  cod_treino INT NOT NULL, 
  minuto_nota CHAR(10), 
  desc_notaTreino VARCHAR(100), 
  cod_grau_privacidade INT,
  FOREIGN KEY (cod_grau_privacidade) REFERENCES grau_privacidade(cod_grau_privacidade),
  FOREIGN KEY (cod_jogador) REFERENCES jogador(cod_jogador), 
  FOREIGN KEY (cod_treino) REFERENCES treino(cod_treino)
);

CREATE TABLE `tcc`.`tipo_lesao` (
  `cod_tipoLesao` INT NOT NULL AUTO_INCREMENT, 
  `desc_tipoLesao` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_tipoLesao`)
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`historicoLesoes` (
  `cod_historicoLesoes` INT NOT NULL AUTO_INCREMENT, 
  `cod_tipoLesao` INT NOT NULL, 
  `desc_lesao` VARCHAR(100) NULL, 
  `data_lesao` DATE NULL, 
  `tempoFora_lesao` VARCHAR(50) NULL, 
  PRIMARY KEY (`cod_historicoLesoes`), 
  CONSTRAINT `fk_historicoLesoes_tipo_lesao1` FOREIGN KEY (`cod_tipoLesao`) REFERENCES `tcc`.`tipo_lesao` (`cod_tipoLesao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`jogador` (
  `cod_jogador` INT NOT NULL, 
  `data_nascimento` DATE, 
  `posicao` INT, 
  `cod_esporte` INT,
  PRIMARY KEY (`cod_jogador`), 
  FOREIGN KEY (`cod_jogador`) REFERENCES `role_cadastro`(`cod_usuario`), 
  FOREIGN KEY (`posicao`) REFERENCES `posicao`(`cod_posicao`), 
  FOREIGN KEY (`cod_esporte`) REFERENCES `esporte`(`cod_esporte`)
);



CREATE TABLE `tcc`.`turma_jogador` (
  cod_turma INT NOT NULL, 
  cod_jogador INT NOT NULL, 
  PRIMARY KEY (cod_turma, cod_jogador), 
  FOREIGN KEY (cod_turma) REFERENCES `tcc`.`turma` (cod_turma) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`jogador` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`treino_jogador` (
  cod_jogador INT NOT NULL, 
  cod_treino INT NOT NULL, 
  PRIMARY KEY (cod_jogador, cod_treino), 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`jogador` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_treino) REFERENCES `tcc`.`treino` (cod_treino) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`nota_jogador` (
  id_nota INT NOT NULL AUTO_INCREMENT,
  cod_jogador INT NOT NULL, 
  cod_staff INT NOT NULL, 
  nota_jogador CHAR(3), 
  data_atualizacao DATETIME,
  ativo CHAR(1), 
  PRIMARY KEY (id_nota), -- chave artificial única
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`jogador` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_staff) REFERENCES `tcc`.`staff` (cod_staff) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`fichaMedica_historicoLesoes` (
  cod_jogador INT NOT NULL, 
  cod_historicoLesoes INT NOT NULL, 
  PRIMARY KEY (cod_jogador, cod_historicoLesoes), 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`fichaMedica` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_historicoLesoes) REFERENCES `tcc`.`historicoLesoes` (cod_historicoLesoes) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`contato_responsavel` (
  cod_contatoResponsavel INT NOT NULL AUTO_INCREMENT, 
  nomeResponsavel VARCHAR(100), 
  tipoFiliacao VARCHAR(50), 
  emailResponsavel VARCHAR(100), 
  telefoneResponsavel int, 
  PRIMARY KEY (cod_contatoResponsavel)
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`fichaMedica` (
  `cod_jogador` INT NOT NULL, 
  `altura` CHAR(3) NULL, 
  `peso` CHAR(3) NULL, 
  `tipoSanguineo` VARCHAR(3) NULL, 
  `restricoes_medicas` VARCHAR(100) NULL, 
  `alergias` VARCHAR(100) NULL, 
  `data_atualizacao` DATETIME NULL, 
  PRIMARY KEY (`cod_jogador`),
  FOREIGN KEY (`cod_jogador`) REFERENCES `tcc`.`jogador`(`cod_jogador`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`jogador_contatoResponsavel` (
  cod_jogador INT NOT NULL, 
  cod_contatoResponsavel INT NOT NULL, 
  PRIMARY KEY (cod_jogador, cod_contatoResponsavel), 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`jogador` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_contatoResponsavel) REFERENCES `tcc`.`contato_responsavel` (cod_contatoResponsavel) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`turma_evento` (
  `cod_evento` INT NOT NULL, 
  `cod_turma` INT NOT NULL, 
  PRIMARY KEY (`cod_evento`, `cod_turma`), 
  FOREIGN KEY (`cod_evento`) REFERENCES `tcc`.`evento` (`cod_evento`) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (`cod_turma`) REFERENCES `tcc`.`turma` (`cod_turma`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE esporte_turma (
  cod_esporte INT NOT NULL, 
  cod_turma INT NOT NULL, 
  cod_treino INT, 
  PRIMARY KEY (cod_esporte, cod_turma), 
  FOREIGN KEY (cod_esporte) REFERENCES esporte(cod_esporte), 
  FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma), 
  FOREIGN KEY (cod_treino) REFERENCES treino(cod_treino)
);
CREATE TABLE `tcc`.`midia_esporte` (
  `cod_esporte` INT NOT NULL, 
  `local_midia` VARCHAR(100) NULL, 
    CONSTRAINT `fk_esporte_midia_esporte` FOREIGN KEY (`cod_esporte`) REFERENCES `esporte` (`cod_esporte`) 
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `tcc`.`midia_jogador` (
  `cod_jogador` INT NOT NULL, 
  `local_midia` VARCHAR(100) NULL, 
  PRIMARY KEY (`cod_jogador`),
  CONSTRAINT `fk_jogador_midia_jogador` 
    FOREIGN KEY (`cod_jogador`) REFERENCES `jogador` (`cod_jogador`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE = InnoDB;

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

INSERT INTO nacao (sigla_nacao, desc_nacao) VALUES
('br', 'Brasil');

INSERT INTO estado (cod_nacao, desc_estado, sigla_estado) VALUES
(1, 'Paraná', 'pr'),         -- cod_estado = 1
(1, 'São Paulo', 'sp'),      -- cod_estado = 2
(1, 'Bahia', 'ba');          -- cod_estado = 3

INSERT INTO municipio (cod_estado, desc_municipio, sigla_municipio) VALUES
(1, 'Colombo', 'ct'),
(1, 'Curitiba', 'ct'),
(1, 'Londrina', 'ld'),
(1, 'Maringá', 'mg'),
(1, 'Cascavel', 'cv'),
(1, 'Guarapuava', 'gp');

INSERT INTO municipio (cod_estado, desc_municipio, sigla_municipio) VALUES
(2, 'São Paulo', 'sp'),
(2, 'Campinas', 'cp'),
(2, 'Santos', 'st'),
(2, 'São Bernardo do Campo', 'sb'),
(2, 'Guarulhos', 'gl');

INSERT INTO municipio (cod_estado, desc_municipio, sigla_municipio) VALUES
(3, 'Salvador', 'sv'),
(3, 'Feira de Santana', 'fs'),
(3, 'Vitória da Conquista', 'vc'),
(3, 'Itabuna', 'ib'),
(3, 'Ilhéus', 'il');

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

INSERT INTO esporte (desc_esporte) VALUES 
('Futebol'), 
('Vôlei'), 
('Futebol');

INSERT INTO posicao (cod_posicao, cod_esporte, desc_posicao, sigla_posicao) VALUES
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

(12, 2, 'Armador', 'ARM'),
(13, 2, 'Ala-Armador', 'AA'),
(14, 2, 'Ala', 'ALA'),
(15, 2, 'Ala-Pivô', 'AP'),
(16, 2, 'Pivô', 'PIV'),

(17, 3, 'Levantador', 'LEV'),
(18, 3, 'Oposto', 'OPO'),
(19, 3, 'Ponteiro', 'PON'),
(20, 3, 'Central', 'CEN'),
(21, 3, 'Líbero', 'LIB');

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
('Instituto Federal do Paraná', 's', 8),
('Centro Esportivo Paulista', 's', 1)
;

INSERT INTO subInstituicao (Cod_Instituicao, ativo, desc_subInstituicao, Cod_Municipio) VALUES
(1, 's', 'IFPR - Campus Colombo', 1),
(1, 's', 'IFPR - Campus Curitiba', 2),
(1, 's', 'IFPR - Campus Londrina', 3),
(2, 's', 'Centro de São Paulo', 7),
(2, 's', 'Centro de São Bernardo do Campo', 10),
(2, 's', 'Centro de Campinas', 8)
;

INSERT INTO turma (desc_turma, ativo, cod_subInstituicao) VALUES
('TADS2023', 's', 1),
('IFPR2019', 's', 1),
('INFO2022', 's', 1),

('ENGCOMP2021', 's', 2),
('TADS2022', 's', 2),
('IFPR2020', 's', 2),

('ELETRO2023', 's', 3),
('INFO2021', 's', 3),
('IFPR2022', 's', 3),

('CENTRO2023-A', 's', 4),
('CENTRO2022-B', 's', 4),
('ADMIN2019', 's', 4),

('SBC2023', 's', 5),
('SBC2022-TI', 's', 5),
('GEST2021', 's', 5),

('CAMP2020-TADS', 's', 6),
('INFOCAMP2021', 's', 6),
('ADM2023', 's', 6);

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
INSERT INTO role_cadastro (cod_usuario,cod_tipoRole) VALUES (1,1);
INSERT INTO staff(cod_staff) VALUES (1);
insert into login_usuario(cod_usuario,email_usuario,senha) values (1,'a@gmail.com','a');


INSERT INTO item_menu (role_html) VALUES 
  ('Gerenciamento de Usuários'),  -- cod_item_menu = 1
  ('Relatórios'),                 -- cod_item_menu = 2
  ('Eventos'),                    -- cod_item_menu = 3
  ('Meus dados'),                 -- cod_item_menu = 4
  ('Treino');                     -- cod_item_menu = 5

INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(1, '/tcc/telas/TI/telaCadastroTI.php', 'Cadastro TI'),                     -- cod_subitem_menu = 1
(1, '/tcc/telas/ADMI/telaCadastroADMI.php', 'Cadastro ADMI'),              -- 2
(1, '/tcc/telas/ADMS/telaCadastroADMS.php', 'Cadastro ADMS'),              -- 3
(1, '/tcc/telas/STAFFADMS/telaCadastroStaffADMS.php', 'Cadastro Staff ADMS'), -- 4
(1, '/tcc/telas/STAFF/telaCadastroStaff.php', 'Cadastro Staff'),           -- 5
(1, '/tcc/telas/JOGADOR/telaCadastroJogador.php', 'Cadastro Jogador'),     -- 6
(1, '/tcc/telas/STAFF/organizacaoTurmaPorStaff.php', 'Organização de Turmas por Staff'); -- 7

INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(2, '/tcc/telas/TI/telaDadosInstituicao.php', 'Instituição'),              -- 8
(2, '/tcc/telas/ADMI/telaDadosSubInstituicao.php', 'Sub-Instituição'),     -- 9
(2, '/tcc/telas/ADMS/telaDadosTurma.php', 'Turma'),                        -- 10
(2, '/tcc/telas/TI/telaDadosNacao.php', 'Nação'),                          -- 11
(2, '/tcc/telas/TI/telaDadosEstado.php', 'Estado'),                        -- 12
(2, '/tcc/telas/TI/telaDadosMunicipio.php', 'Município');                  -- 13

INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(3, '/tcc/telas/EVENTOS/telaCadastroEvento.php', 'Cadastro Evento'),       -- 14
(3, '/tcc/telas/EVENTOS/telaTodosEventos.php', 'Eventos ativos'),          -- 15
(4, '/tcc/telas/MEUSDADOS/meusDados.php', 'Meus dados'),                   -- 16
(5, '/tcc/telas/TREINO/criarTreino.php', 'Criar treino');                  -- 17

INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(2, '/tcc/telas/JOGADOR/relatorioTodosJogadores.php', 'Relatório todos jogadores'); -- 18

INSERT INTO itemMenu_tipoRole (cod_item_menu, cod_tipo_role) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),  -- TI
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2),  -- ADMI
(1, 3), (2, 3), (3, 3), (4, 3), (5, 3),  -- ADMS
(1, 4), (2, 4), (3, 4), (4, 4), (5, 4),  -- ADMS|STAFF
(1, 5), (2, 5), (3, 5), (4, 5), (5, 5),  -- STAFF
(1, 6), (2, 6), (3, 6), (4, 6), (5, 6);  -- JOGADOR


INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(2, 13, 1),
(1, 1, 1),
(1, 2, 1),
(1, 3, 1),
(1, 4, 1),
(1, 5, 1),
(1, 6, 1),
(1, 7, 1),
(2, 8, 1),
(2, 9, 1),
(2, 10, 1),
(2, 11, 1),
(2, 12, 1),
(3, 15, 1),
(4, 16, 1)
;

INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 2, 2),
(1, 3, 2),
(1, 4, 2),
(1, 5, 2),
(1, 6, 2),
(2, 9, 2),
(2, 13, 2),
(3, 15, 2),
(4, 16, 2),
(2, 10, 2),
(1, 7, 2)
;

INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 3, 3),
(1, 4, 3),
(1, 5, 3),
(1, 6, 3),
(3, 15, 3),
(4, 16, 3),
(1, 7, 3)
;

INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 3, 4),
(1, 4, 4),
(1, 5, 4),
(1, 6, 4),
(1, 7, 4),
(1, 13, 4),
(3, 14, 4),
(3, 15, 4),
(4, 16, 4),
(5, 17, 4)
;

INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(3, 14, 5),
(3, 15, 5),
(4, 16, 5),
(5, 17, 5)

;

INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(3, 15, 6),
(4, 16, 6)
;

INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(2, 18, 1),
(2, 18, 2),
(2, 18, 3),
(2, 18, 4),
(2, 18, 5)
;

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('ti', '12345678901', 3, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (2, 1);
INSERT INTO login_usuario (cod_usuario, email_usuario, senha) VALUES (2, 'ti@gmail.com', 'ti');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('AdministradorTi03', '23456789012', 7, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (3, 1);
INSERT INTO login_usuario (cod_usuario, email_usuario, senha) VALUES (3, 'admin03@ifpr.edu.br', 'senhaSegura03');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)  VALUES ('AdministradorTi04', '34567890123', 12, 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (4, 1);
INSERT INTO login_usuario (cod_usuario, email_usuario, senha) VALUES (4, 'admin04@ifpr.edu.br', 'senhaSegura04');


INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('AdministradorInst1_01', '45678901234', 4, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (5, 2);

INSERT INTO administrador (cod_administrador, tipo_role) VALUES (5, 2);

INSERT INTO administrador_instituicao (cod_administrador, cod_instituicao) VALUES (5, 1);

INSERT INTO login_usuario (cod_usuario, email_usuario, senha)VALUES (5, 'admi@gmail.com', 'admi');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('AdministradorInst1_02', '56789012345', 6, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (6, 2);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (6, 2);

INSERT INTO administrador_instituicao (cod_administrador, cod_instituicao)
VALUES (6, 1);

INSERT INTO login_usuario (cod_usuario, email_usuario, senha)
VALUES (6, 'admin06@ifpr.edu.br', 'senhaSegura06');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('AdministradorInst1_03', '67890123456', 8, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (7, 2);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (7, 2);

INSERT INTO administrador_instituicao (cod_administrador, cod_instituicao)
VALUES (7, 1);

INSERT INTO login_usuario (cod_usuario, email_usuario, senha)
VALUES (7, 'admin07@ifpr.edu.br', 'senhaSegura07');



INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('admi', '78901234567', 9, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (8, 2);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (8, 2);

INSERT INTO administrador_instituicao (cod_administrador, cod_instituicao)
VALUES (8, 2);

INSERT INTO login_usuario (cod_usuario, email_usuario, senha)
VALUES (8, 'admi@gmail.br', 'admi');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('AdministradorInst2_02', '89012345678', 10, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (9, 2);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (9, 2);

INSERT INTO administrador_instituicao (cod_administrador, cod_instituicao)
VALUES (9, 2);

INSERT INTO login_usuario (cod_usuario, email_usuario, senha)
VALUES (9, 'admin09@ifpr.edu.br', 'senhaSegura09');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('AdministradorInst2_03', '90123456789', 11, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (10, 2);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (10, 2);

INSERT INTO administrador_instituicao (cod_administrador, cod_instituicao)
VALUES (10, 2);

INSERT INTO login_usuario (cod_usuario, email_usuario, senha)
VALUES (10, 'admin10@ifpr.edu.br', 'senhaSegura10');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('adms', '01234567890', 2, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (11, 3);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (11, 3);

INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao)
VALUES (11, 1);

INSERT INTO login_usuario (email_usuario, cod_usuario, senha)
VALUES ('adms@gmail.com', 11, 'adms');


INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('AdministradorSub1_02', '12345678901', 4, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (12, 3);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (12, 3);

INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao)
VALUES (12, 1);

INSERT INTO login_usuario (email_usuario, cod_usuario, senha)
VALUES ('admin12@ifpr.edu.br', 12, 'senhaSegura12');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('adms', '23456789012', 6, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (13, 3);

INSERT INTO administrador (cod_administrador, tipo_role)
VALUES (13, 3);

INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao)
VALUES (13, 1);

INSERT INTO login_usuario (email_usuario, cod_usuario, senha) VALUES ('adms@gmail.br', 13, 'adms');

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('staff', '34567890123', 5, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (14, 5);

INSERT INTO staff(cod_staff) VALUES (14);

INSERT INTO subInstituticao_staff (cod_staff,cod_SubInstituicao) VALUES  (14, 1);

INSERT INTO login_usuario (email_usuario, cod_usuario,senha)
VALUES ('staff@gmail.com', 14,'staff');


INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('StaffSub1_02', '45678901234', 8, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (15, 5);

INSERT INTO staff(cod_staff) VALUES (15);

INSERT INTO subInstituticao_staff (cod_staff, cod_SubInstituicao)
VALUES (15, 1);

INSERT INTO login_usuario (email_usuario, cod_usuario,senha)
VALUES ('staff15@ifpr.edu.br', 15,'12');


INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo)
VALUES ('StaffSub1_03', '56789012345', 11, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole)
VALUES (16, 5);

INSERT INTO staff(cod_staff) VALUES (16);

INSERT INTO subInstituticao_staff (cod_staff, cod_SubInstituicao)
VALUES (16, 1);

INSERT INTO login_usuario (email_usuario, cod_usuario,senha)
VALUES ('staff16@ifpr.edu.br', 16,'staff16');

INSERT INTO staff_turma (cod_staff, cod_turma) VALUES (14, 1);
INSERT INTO staff_turma (cod_staff, cod_turma) VALUES (14, 2);



INSERT INTO staff_turma (cod_staff, cod_turma) VALUES (16, 1);
INSERT INTO staff_turma (cod_staff, cod_turma) VALUES (16, 2);
INSERT INTO staff_turma (cod_staff, cod_turma) VALUES (16, 3);

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('AdmsStaff', '46672656049', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (17, 4);
INSERT INTO staff (cod_staff) VALUES (17);
INSERT INTO subInstituticao_staff (cod_staff, cod_SubInstituicao) VALUES (17, 1);
INSERT INTO administrador (cod_administrador, tipo_role) VALUES (17, 4);
INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao) VALUES (17, 1);
INSERT INTO login_usuario (email_usuario, cod_usuario,senha) VALUES ('AdmsStaff@gmail.com', 17,'AdmsStaff');

INSERT INTO staff_turma (cod_staff, cod_turma) VALUES (17, 1);
INSERT INTO staff_turma (cod_staff, cod_turma) VALUES (17, 2);


INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Lucas Henrique da Silva', '13432640900', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (18, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (18, '2007-04-15', 3, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (2, 18);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (18, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) VALUES (18, 178, 65, 'O+', 'Nenhuma', 'Amendoim', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) VALUES (1, 'Marcelo da Silva', 'Pai', 'marcelo.silva@gmail.com', '41998732');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (18, 1);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) VALUES (1, 1, 'Entorse no tornozelo direito durante partida', '2024-10-21', '15 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (18, 1);
INSERT INTO login_usuario (email_usuario, cod_usuario,senha) VALUES ('lucas.silva@gmail.com', 18,'senhaLuscar');
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) VALUES (18, 1, '6.0', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Mariana Costa Oliveira', '24578912399', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (19, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (19, '2006-07-22', 2, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (2, 19);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (19, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) VALUES (19, 165, 58, 'A-', 'Asma', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) VALUES (2, 'Ana Costa', 'Mãe', 'ana.costa@gmail.com', '419654321');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (19, 2);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) VALUES (2, 2, 'Lesão muscular na coxa esquerda', '2023-12-10', '30 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (19, 2);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('mariana.oliveira@gmail.com', 19);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) VALUES (19, 1, '7.5', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Felipe Augusto Ramos', '31245678911', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (20, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (20, '2008-01-05', 1, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (2, 20);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (20, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) VALUES (20, 180, 70, 'B+', 'Nenhuma', 'Pólen', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) VALUES (3, 'Carlos Ramos', 'Pai', 'carlos.ramos@gmail.com', '41994567');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (20, 3);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) VALUES (3, 3, 'Contusão no joelho direito', '2025-01-15', '20 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (20, 3);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('felipe.ramos@gmail.com', 20);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) VALUES (20, 1, '8.0', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Ana Beatriz Souza', '49832165477', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (21, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (21, '2007-09-12', 4, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (2, 21);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (21, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) VALUES (21, 170, 60, 'AB+', 'Hipertensão', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) VALUES (4, 'Roberto Souza', 'Pai', 'roberto.souza@gmail.com', '419997766');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (21, 4);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) VALUES (4, 4, 'Fratura no braço esquerdo', '2024-05-18', '60 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (21, 4);
INSERT INTO login_usuario (email_usuario, cod_usuario,senha) VALUES ('ana.souza@gmail.com', 21,'ana');
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) VALUES (21, 1, '7.0', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Pedro Henrique Lima', '58974125844', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (22, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (22, '2006-11-30', 5, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (2, 22);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (22, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) VALUES (22, 175, 68, 'A+', 'Nenhuma', 'Lactose', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) VALUES (5, 'Luciana Lima', 'Mãe', 'luciana.lima@gmail.com', '419445566');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (22, 5);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) VALUES (5, 5, 'Distensão muscular na coxa direita', '2024-09-10', '25 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (22, 5);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('pedro.lima@gmail.com', 22);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) VALUES (22, 1, '7.8', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Lucas Ferreira da Silva', '11111111111', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (23, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (23, '2006-05-14', 1, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (1, 23);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (23, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (23, 178, 72, 'O+', 'Nenhuma', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (6, 'Marcos da Silva', 'Pai', 'marcos.silva@gmail.com', '419999991');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (23, 6);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (6, 3, 'Entorse no tornozelo esquerdo', '2024-06-12', '15 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (23, 6);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('lucas.ferreira@gmail.com', 23);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (23, 1, '8.2', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Gabriel Santos Lima', '22222222222', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (24, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (24, '2006-03-09', 2, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (1, 24);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (24, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (24, 180, 75, 'A+', 'Nenhuma', 'Pólen', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (7, 'Renata Lima', 'Mãe', 'renata.lima@gmail.com', '419999999');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (24, 7);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (7, 2, 'Luxação no ombro direito', '2023-10-20', '30 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (24, 7);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('gabriel.lima@gmail.com', 24);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (24, 1, '7.5', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Matheus Rocha Almeida', '33333333333', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (25, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (25, '2006-07-22', 3, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (1, 25);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (25, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (25, 176, 70, 'B-', 'Nenhuma', 'Frutos do mar', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (8, 'Joana Almeida', 'Mãe', 'joana.almeida@gmail.com', '419999993');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (25, 8);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (8, 4, 'Fratura no dedo mindinho do pé', '2023-12-01', '10 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (25, 8);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('matheus.almeida@gmail.com', 25);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (25, 1, '8.0', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Henrique Oliveira Costa', '44444444444', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (26, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (26, '2006-01-30', 4, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (1, 26);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (26, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (26, 183, 80, 'AB+', 'Asma leve', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (9, 'Carlos Costa', 'Pai', 'carlos.costa@gmail.com', '419999994');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (26, 9);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (9, 1, 'Corte na sobrancelha em treino', '2025-01-15', '5 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (26, 9);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('henrique.costa@gmail.com', 26);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (26, 1, '7.9', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Diego Martins Souza', '55555555555', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (27, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (27, '2006-11-11', 5, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (1, 27);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (27, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (27, 177, 73, 'O-', 'Nenhuma', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (10, 'Sandra Souza', 'Mãe', 'sandra.souza@gmail.com', '419999995');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (27, 10);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (10, 6, 'Tendinite no joelho esquerdo', '2024-08-05', '20 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (27, 10);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('diego.souza@gmail.com', 27);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (27, 1, '8.1', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('João Victor Mendes', '66666666666', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (28, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (28, '2006-08-20', 1, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (3, 28);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (28, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (28, 179, 74, 'A-', 'Nenhuma', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (11, 'Carla Mendes', 'Mãe', 'carla.mendes@gmail.com', '419999996');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (28, 11);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (11, 1, 'Torção leve no tornozelo', '2024-07-01', '7 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (28, 11);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('joao.mendes@gmail.com', 28);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (28, 1, '7.7', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Thiago Costa Ribeiro', '77777777777', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (29, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (29, '2006-10-15', 2, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (3, 29);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (29, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (29, 181, 76, 'O+', 'Nenhuma', 'Ácaro', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (12, 'Roberto Ribeiro', 'Pai', 'roberto.ribeiro@gmail.com', '419999997');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (29, 12);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (12, 3, 'Contusão no joelho direito', '2024-05-10', '20 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (29, 12);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('thiago.ribeiro@gmail.com', 29);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (29, 1, '8.3', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Ricardo Alves Moreira', '88888888888', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (30, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (30, '2006-09-12', 3, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (3, 30);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (30, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (30, 174, 69, 'B+', 'Nenhuma', 'Picada de inseto', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (13, 'Fernanda Moreira', 'Mãe', 'fernanda.moreira@gmail.com', '419999998');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (30, 13);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (13, 4, 'Estiramento muscular', '2024-04-18', '18 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (30, 13);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('ricardo.moreira@gmail.com', 30);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (30, 1, '7.9', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('André Luiz Barreto', '99999999999', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (31, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (31, '2006-06-06', 4, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (3, 31);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (31, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (31, 182, 78, 'AB-', 'Bronquite', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (14, 'Lucia Barreto', 'Mãe', 'lucia.barreto@gmail.com', '419999999');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (31, 14);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (14, 2, 'Corte no supercílio', '2024-01-09', '4 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (31, 14);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('andre.barreto@gmail.com', 31);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (31, 1, '8.0', 's', NOW());

INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
VALUES ('Felipe Augusto Nunes', '00000000000', '1', 's');
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES (32, 6);
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, cod_esporte) VALUES (32, '2006-02-28', 5, 1);
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES (3, 32);
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES (32, 'jogadorPadrao.png');
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
VALUES (32, 175, 71, 'A+', 'Nenhuma', 'Nenhuma', NOW());
INSERT INTO contato_responsavel (cod_contatoResponsavel, nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
VALUES (15, 'Patricia Nunes', 'Mãe', 'patricia.nunes@gmail.com', '419999000');
INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) VALUES (32, 15);
INSERT INTO historicoLesoes (cod_historicoLesoes, cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
VALUES (15, 6, 'Dor lombar após treino', '2024-06-20', '7 dias');
INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) VALUES (32, 15);
INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('felipe.nunes@gmail.com', 32);
INSERT INTO nota_jogador (cod_jogador, cod_staff, nota_jogador, ativo, data_atualizacao) 
VALUES (32, 1, '7.8', 's', NOW());


INSERT INTO evento (cod_staff, titulo_evento, data, horario, local, desc_evento, ativo) VALUES
(1, 'Treinamento Técnico',       '2025-08-01', '09:00', 'Quadra A', 'Sessão de aprimoramento técnico para todos os atletas.', 'S'),
(1, 'Palestra Motivacional',     '2025-08-05', '14:00', 'Sala Multiuso', 'Palestra com ex-atleta olímpico sobre foco e motivação.', 'S'),
(1, 'Avaliação Física Inicial',  '2025-08-10', '08:30', 'Centro de Avaliação', 'Exames físicos e testes de resistência.', 'S'),
(1, 'Simulado de Competição',    '2025-08-15', '10:00', 'Ginásio Principal', 'Competição simulada para preparação do campeonato.', 'S'),
(1, 'Aula de Nutrição Esportiva','2025-08-20', '15:00', 'Auditório', 'Nutricionista apresentará dicas de alimentação esportiva.', 'S');

INSERT INTO turma_evento (cod_evento, cod_turma) VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 1);

INSERT INTO evento (cod_staff, titulo_evento, data, horario, local, desc_evento, ativo) VALUES
(1, 'Treino Funcional Avançado',   '2025-08-03', '07:30', 'Campo 2', 'Treinamento funcional com foco em agilidade e força.', 'S'),
(1, 'Sessão de Vídeo Tática',      '2025-08-06', '13:00', 'Sala de Vídeo', 'Análise de jogos para melhorar decisões em campo.', 'S'),
(1, 'Treinamento de Resistência',  '2025-08-11', '10:00', 'Pista de Atletismo', 'Série de corridas e circuitos para resistência.', 'S'),
(1, 'Oficina de Liderança',        '2025-08-17', '16:00', 'Sala B', 'Atividades para desenvolvimento de liderança em grupo.', 'S'),
(1, 'Reunião com Pais',            '2025-08-21', '18:00', 'Auditório', 'Encontro com pais/responsáveis para apresentação dos objetivos.', 'S');

INSERT INTO turma_evento (cod_evento, cod_turma) VALUES
(6, 2), (7, 2), (8, 2), (9, 2), (10, 2);

INSERT INTO evento (cod_staff, titulo_evento, data, horario, local, desc_evento, ativo) VALUES
(1, 'Treino Tático Coletivo',   '2025-08-04', '08:00', 'Quadra Coberta', 'Trabalho de posicionamento e entrosamento tático.', 'S'),
(1, 'Workshop de Primeiros Socorros', '2025-08-08', '14:00', 'Sala C', 'Instruções básicas de primeiros socorros em campo.', 'S'),
(1, 'Atividade de Recuperação', '2025-08-13', '11:00', 'Sala de Fisioterapia', 'Alongamentos e relaxamento após treinos intensos.', 'S'),
(1, 'Campeonato Interno',       '2025-08-18', '09:00', 'Ginásio', 'Competições internas entre os times da turma.', 'S'),
(1, 'Sessão de Feedback Técnico','2025-08-22', '17:00', 'Sala de Reunião', 'Discussão com os treinadores sobre o desempenho.', 'S');


INSERT INTO turma_evento (cod_evento, cod_turma) VALUES
(11, 3), (12, 3), (13, 3), (14, 3), (15, 3);

update cadastro_identificacao set nome='AdmsStaff Dutch' where cod_usuario = 17;
update cadastro_identificacao set nome='Staff Micah Bell' where cod_usuario = 16;
update cadastro_identificacao set nome='Staff John Marston' where cod_usuario = 15;
update cadastro_identificacao set nome='Staff Arthur Morgan' where cod_usuario = 14;

update cadastro_identificacao set nome='Tiago de Sousa Marques' where cod_usuario = 24;
update cadastro_identificacao set nome='gabriel kayky Matos' where cod_usuario = 23;
update cadastro_identificacao set nome='Nathália Silva' where cod_usuario = 26;
update cadastro_identificacao set nome='Mayra Pinheiro' where cod_usuario = 25;
update cadastro_identificacao set nome='João Expedito' where cod_usuario = 21;
update cadastro_identificacao set nome='Manu biesdorf' where cod_usuario = 20;
update cadastro_identificacao set nome='Kayo Maringa' where cod_usuario = 18;
update cadastro_identificacao set nome='Gabriel Jacksson' where cod_usuario = 19;
update cadastro_identificacao set nome='Ines Portugal' where cod_usuario = 22;
update cadastro_identificacao set nome='Daniels Sportining' where cod_usuario = 31;
update cadastro_identificacao set nome='Pyro' where cod_usuario = 32;
update cadastro_identificacao set nome='Cauã Barbosa' where cod_usuario = 28;
update cadastro_identificacao set nome='Felipe Alt' where cod_usuario = 30;
update cadastro_identificacao set nome='Willy Wagner' where cod_usuario = 29;

UPDATE nota_jogador SET nota_jogador = '60' where id_nota>0;

update midia_jogador set local_midia ='expeto.png' where cod_jogador = 21;

update midia_jogador set local_midia ='manu.png' where cod_jogador = 20;
update midia_jogador set local_midia ='nati' where cod_jogador = 26;
update midia_jogador set local_midia ='may.png' where cod_jogador = 25;