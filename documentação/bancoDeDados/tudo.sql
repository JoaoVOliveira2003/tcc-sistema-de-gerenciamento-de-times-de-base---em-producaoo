-- Desativar verificações temporariamente
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,  UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Criar o schema
DROP SCHEMA IF EXISTS `tcc`;
CREATE SCHEMA IF NOT EXISTS `tcc` DEFAULT CHARACTER SET utf8mb4;
USE `tcc`;

-- Nação
CREATE TABLE `nacao` (
  `cod_nacao` INT NOT NULL AUTO_INCREMENT, 
  `sigla_nacao` CHAR(3), 
  `desc_nacao` VARCHAR(50), 
  PRIMARY KEY (`cod_nacao`)
) ENGINE = InnoDB;

-- Estado
CREATE TABLE `estado` (
  `cod_estado` INT NOT NULL AUTO_INCREMENT, 
  `cod_nacao` INT NOT NULL, 
  `desc_estado` VARCHAR(50), 
  `sigla_estado` CHAR(3), 
  PRIMARY KEY (`cod_estado`), 
  CONSTRAINT `fk_estado_nacao` FOREIGN KEY (`cod_nacao`) REFERENCES `nacao` (`cod_nacao`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Município
CREATE TABLE `municipio` (
  `cod_municipio` INT NOT NULL AUTO_INCREMENT, 
  `cod_estado` INT NOT NULL, 
  `desc_municipio` VARCHAR(50), 
  `sigla_municipio` CHAR(3), 
  PRIMARY KEY (`cod_municipio`), 
  CONSTRAINT `fk_municipio_estado` FOREIGN KEY (`cod_estado`) REFERENCES `estado` (`cod_estado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;


-- Identificação do Usuário
CREATE TABLE `cadastro_identificacao` (
  `cod_usuario` INT NOT NULL AUTO_INCREMENT, 
  `nome` VARCHAR(100), 
  `cpf` VARCHAR(11), 
  `ativo` CHAR(1), 
  `cod_municipio` INT NOT NULL, 
  PRIMARY KEY (`cod_usuario`), 
  CONSTRAINT `fk_identificacao_municipio` FOREIGN KEY (`cod_municipio`) REFERENCES `municipio` (`cod_municipio`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Login
CREATE TABLE `login_usuario` (
  `cod_usuario` INT NOT NULL, 
  `email_usuario` VARCHAR(50), 
  `senha` VARCHAR(255), 
  PRIMARY KEY (`cod_usuario`), 
  CONSTRAINT `fk_login_usuario_identificacao` FOREIGN KEY (`cod_usuario`) REFERENCES `cadastro_identificacao` (`cod_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


-- Item de Menu
-- CREATE TABLE `item_menu` (
--   `cod_item_menu` INT NOT NULL AUTO_INCREMENT, 
--   `href` VARCHAR(200), 
--   `html_id` VARCHAR(200), 
--   `role_html` VARCHAR(200), 
--   `label` VARCHAR(200), 
--   `cod_tipo_role` INT NOT NULL, 
--   PRIMARY KEY (`cod_item_menu`), 
--   CONSTRAINT `fk_item_menu_tipo_role` FOREIGN KEY (`cod_tipo_role`) REFERENCES `tipo_role` (`cod_tipo_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
-- ) ENGINE = InnoDB;


-- Tipo de Role
CREATE TABLE `tipo_role` (
  `cod_tipo_role` INT NOT NULL AUTO_INCREMENT, 
  `desc_tipo_role` VARCHAR(100), 
  `abrev_tipo_role` CHAR(10), 
  `ativo` CHAR(1) DEFAULT 'S', 
  PRIMARY KEY (`cod_tipo_role`)
) ENGINE = InnoDB;


-- Tabela principal de menus
CREATE TABLE item_menu (
  cod_item_menu INT NOT NULL AUTO_INCREMENT,
  role_html VARCHAR(200),
  PRIMARY KEY (cod_item_menu)
);









-- Tabela de submenus (relacionada à item_menu)
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

-- Relação entre item_menu e tipos de usuários (roles)
CREATE TABLE itemMenu_tipoRole (
  cod_item_menu INT NOT NULL,
  cod_tipo_role INT NOT NULL,
  PRIMARY KEY (cod_item_menu, cod_tipo_role),
  CONSTRAINT fk_item_menu_tipo
    FOREIGN KEY (cod_item_menu) REFERENCES item_menu (cod_item_menu) ON DELETE CASCADE,
  CONSTRAINT fk_tipo_menu_item
    FOREIGN KEY (cod_tipo_role) REFERENCES tipo_role (cod_tipo_role) ON DELETE CASCADE
);

-- Relação entre menus, submenus e tipos de usuários
CREATE TABLE itemMenu_subitemMenu (
  cod_item_menu INT NOT NULL,
  cod_subitem_menu INT NOT NULL,
  cod_tipo_role INT NOT NULL,
  CONSTRAINT fk_item_menu_subitem_menu
    FOREIGN KEY (cod_item_menu) REFERENCES item_menu (cod_item_menu) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_subitem_menu_item_menu
    FOREIGN KEY (cod_subitem_menu) REFERENCES subitem_menu (cod_subitem_menu) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Atribuição de Role ao Usuário
CREATE TABLE `role_cadastro` (
  `cod_role_cadastro` INT NOT NULL AUTO_INCREMENT, 
  `cod_usuario` INT NOT NULL, 
  `cod_tipoRole` INT NOT NULL, 
  PRIMARY KEY (`cod_role_cadastro`), 
  CONSTRAINT `fk_role_usuario` FOREIGN KEY (`cod_usuario`) REFERENCES `cadastro_identificacao` (`cod_usuario`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_role_tipo_role` FOREIGN KEY (`cod_tipoRole`) REFERENCES `tipo_role` (`cod_tipo_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Staff
CREATE TABLE `staff` (
  `cod_staff` INT NOT NULL AUTO_INCREMENT,  
  PRIMARY KEY (`cod_staff`), 
  CONSTRAINT `fk_staff_role_cadastro` FOREIGN KEY (`cod_staff`) REFERENCES `role_cadastro` (`cod_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Administrador
CREATE TABLE `administrador` (
  `cod_administrador` INT NOT NULL AUTO_INCREMENT, 
  `tipo_role` INT NOT NULL, 
  PRIMARY KEY (`cod_administrador`), 
  CONSTRAINT `fk_admin_role` FOREIGN KEY (`cod_administrador`) REFERENCES `role_cadastro` (`cod_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Tipo de Instituição
CREATE TABLE `tipo_instituicao` (
  `cod_tipo_instituicao` INT NOT NULL AUTO_INCREMENT, 
  `desc_tipo_instituicao` VARCHAR(100), 
  PRIMARY KEY (`cod_tipo_instituicao`)
) ENGINE = InnoDB;

-- Instituição
CREATE TABLE `instituicao` (
  `cod_instituicao` INT NOT NULL AUTO_INCREMENT, 
  `desc_instituicao` VARCHAR(100), 
  `ativo` CHAR(1), 
  `cod_tipo_instituicao` INT, 
  PRIMARY KEY (`cod_instituicao`), 
  CONSTRAINT `fk_instituicao_tipo` FOREIGN KEY (`cod_tipo_instituicao`) REFERENCES `tipo_instituicao` (`cod_tipo_instituicao`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- administrador_instituicao
CREATE TABLE administrador_instituicao (
  cod_administrador INT NOT NULL, 
  cod_instituicao INT NOT NULL, 
  PRIMARY KEY (cod_administrador, cod_instituicao), 
  CONSTRAINT fk_adm_instituicao_administrador FOREIGN KEY (cod_administrador) REFERENCES administrador(cod_administrador) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT fk_adm_instituicao_instituicao FOREIGN KEY (cod_instituicao) REFERENCES instituicao(cod_instituicao) ON DELETE CASCADE ON UPDATE CASCADE
);

-- subInstituicao

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

-- subInstituticao_staff
CREATE TABLE `tcc`.`subInstituticao_staff` (
  `cod_staff` INT NOT NULL, 
  `cod_SubInstituicao` INT NOT NULL, 
  PRIMARY KEY (`cod_staff`, `cod_SubInstituicao`), 
  CONSTRAINT `fk_staff` FOREIGN KEY (`cod_staff`) REFERENCES `tcc`.`staff` (`cod_staff`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_subInstituto` FOREIGN KEY (`cod_SubInstituicao`) REFERENCES `tcc`.`subInstituicao` (`cod_instituicao`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- administrador_subInstituicao
CREATE TABLE `tcc`.`administrador_subInstituicao` (
  `cod_administrador` INT NOT NULL, 
  `cod_subInstituicao` INT NOT NULL, 
  PRIMARY KEY (
    `cod_administrador`, `cod_subInstituicao`
  ), 
  FOREIGN KEY (`cod_administrador`) REFERENCES `tcc`.`administrador` (`cod_administrador`) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (`cod_subInstituicao`) REFERENCES `tcc`.`subInstituicao` (`cod_subInstituicao`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


-- turma

CREATE TABLE turma (
  cod_turma INT PRIMARY KEY AUTO_INCREMENT, 
  desc_turma VARCHAR(50), 
  ativo CHAR(1), 
  cod_subInstituicao INT NOT NULL, 
  CONSTRAINT fk_turma_subInstituicao 
    FOREIGN KEY (cod_subInstituicao) REFERENCES subInstituicao(Cod_SubInstituicao)
    ON DELETE NO ACTION ON UPDATE CASCADE
);


-- staff_turma

CREATE TABLE `tcc`.`staff_turma` (
  `cod_staff` INT NOT NULL, 
  `cod_turma` INT NOT NULL, 
  PRIMARY KEY (`cod_staff`, `cod_turma`), 
  CONSTRAINT `fk_staff_turma_staff` FOREIGN KEY (`cod_staff`) REFERENCES `tcc`.`staff` (`cod_staff`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_staff_turma_turma` FOREIGN KEY (`cod_turma`) REFERENCES `tcc`.`turma` (`cod_turma`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- evento
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

-- esporte
CREATE TABLE `tcc`.`esporte` (
  `cod_esporte` INT NOT NULL AUTO_INCREMENT, 
  `desc_esporte` VARCHAR(25) NOT NULL, 
  PRIMARY KEY (`cod_esporte`)
) ENGINE = InnoDB;

-- posicao
CREATE TABLE `tcc`.`posicao` (
  `cod_posicao` INT NOT NULL AUTO_INCREMENT, 
  `cod_esporte` INT NOT NULL, 
  `desc_posicao` VARCHAR(100), 
  `sigla_posicao` CHAR(5), 
  PRIMARY KEY (`cod_posicao`), 
  CONSTRAINT `fk_posicao_esporte` FOREIGN KEY (`cod_esporte`) REFERENCES `tcc`.`esporte` (`cod_esporte`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Treino
CREATE TABLE `tcc`.`Treino` (
  `cod_treino` INT AUTO_INCREMENT PRIMARY KEY, 
  `cod_staff` INT NOT NULL, 
  `cod_esporte` INT NOT NULL, 
  `tempo_treino` CHAR(10), 
  `placar_treino` CHAR(10),
  FOREIGN KEY (`cod_staff`) REFERENCES `staff`(`cod_staff`) ON DELETE NO ACTION ON UPDATE NO ACTION, 
  FOREIGN KEY (`cod_esporte`) REFERENCES `esporte`(`cod_esporte`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

ALTER TABLE Treino MODIFY COLUMN tempo_treino CHAR(10);

-- midia_treino
CREATE TABLE `tcc`.`midia_treino` (
  `cod_midiaTreino` INT NOT NULL, 
  `local_midia` VARCHAR(45) NULL, 
  `cod_treino` INT NOT NULL, 
  `cod_midiaJogo` INT, 
  PRIMARY KEY (`cod_midiaTreino`), 
  CONSTRAINT `fk_midia_treino_treino` FOREIGN KEY (`cod_treino`) REFERENCES `tcc`.`Treino`(`cod_treino`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_midia_treino_midiaJogo` FOREIGN KEY (`cod_midiaJogo`) REFERENCES `tcc`.`midia_TreinoJogo`(`cod_midiaJogo`) ON DELETE 
  SET 
    NULL ON UPDATE CASCADE
) ENGINE = InnoDB;

-- midia_TreinoJogo
CREATE TABLE `tcc`.`midia_TreinoJogo` (
  `cod_midiaJogo` INT NOT NULL, 
  `local_midia` VARCHAR(45) NULL, 
  PRIMARY KEY (`cod_midiaJogo`)
) ENGINE = InnoDB;

-- grauPrivacidade
CREATE TABLE grau_privacidade(
  cod_grau_privacidade INT PRIMARY KEY, 
  desc_grau_privacidade VARCHAR(100) NOT NULL

);

-- notaTreino_jogador
CREATE TABLE `notaTreino_jogador` (
  cod_jogador INT NOT NULL, 
  cod_treino INT NOT NULL, 
  minuto_nota CHAR(10), 
  desc_notaTreino VARCHAR(100), 
  cod_grau_privacidade INT, 
  PRIMARY KEY (cod_jogador, cod_treino), 
  FOREIGN KEY (cod_grau_privacidade) REFERENCES grau_privacidade(cod_grau_privacidade),
  FOREIGN KEY (cod_jogador) REFERENCES jogador(cod_jogador), 
  FOREIGN KEY (cod_treino) REFERENCES treino(cod_treino)
);

-- tipo_lesao
CREATE TABLE `tcc`.`tipo_lesao` (
  `cod_tipoLesao` INT NOT NULL AUTO_INCREMENT, 
  `desc_tipoLesao` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_tipoLesao`)
) ENGINE = InnoDB;

-- historicoLesoes
CREATE TABLE `tcc`.`historicoLesoes` (
  `cod_historicoLesoes` INT NOT NULL AUTO_INCREMENT, 
  `cod_tipoLesao` INT NOT NULL, 
  `desc_lesao` VARCHAR(100) NULL, 
  `data_lesao` DATE NULL, 
  `tempoFora_lesao` VARCHAR(50) NULL, 
  PRIMARY KEY (`cod_historicoLesoes`), 
  CONSTRAINT `fk_historicoLesoes_tipo_lesao1` FOREIGN KEY (`cod_tipoLesao`) REFERENCES `tcc`.`tipo_lesao` (`cod_tipoLesao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- jogador
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



-- turma_jogador
CREATE TABLE `tcc`.`turma_jogador` (
  cod_turma INT NOT NULL, 
  cod_jogador INT NOT NULL, 
  PRIMARY KEY (cod_turma, cod_jogador), 
  FOREIGN KEY (cod_turma) REFERENCES `tcc`.`turma` (cod_turma) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`jogador` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- treino_jogador
CREATE TABLE `tcc`.`treino_jogador` (
  cod_jogador INT NOT NULL, 
  cod_treino INT NOT NULL, 
  PRIMARY KEY (cod_jogador, cod_treino), 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`jogador` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_treino) REFERENCES `tcc`.`treino` (cod_treino) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- nota_jogador
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

-- fichaMedica_historicoLesoes
CREATE TABLE `tcc`.`fichaMedica_historicoLesoes` (
  cod_jogador INT NOT NULL, 
  cod_historicoLesoes INT NOT NULL, 
  PRIMARY KEY (cod_jogador, cod_historicoLesoes), 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`fichaMedica` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_historicoLesoes) REFERENCES `tcc`.`historicoLesoes` (cod_historicoLesoes) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- contato_responsavel
CREATE TABLE `tcc`.`contato_responsavel` (
  cod_contatoResponsavel INT NOT NULL AUTO_INCREMENT, 
  nomeResponsavel VARCHAR(100), 
  tipoFiliacao VARCHAR(50), 
  emailResponsavel VARCHAR(100), 
  telefoneResponsavel int, 
  PRIMARY KEY (cod_contatoResponsavel)
) ENGINE = InnoDB;



-- fichaMedica
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


-- jogador_contatoResponsavel
CREATE TABLE `tcc`.`jogador_contatoResponsavel` (
  cod_jogador INT NOT NULL, 
  cod_contatoResponsavel INT NOT NULL, 
  PRIMARY KEY (cod_jogador, cod_contatoResponsavel), 
  FOREIGN KEY (cod_jogador) REFERENCES `tcc`.`jogador` (cod_jogador) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (cod_contatoResponsavel) REFERENCES `tcc`.`contato_responsavel` (cod_contatoResponsavel) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- turma_evento
CREATE TABLE `tcc`.`turma_evento` (
  `cod_evento` INT NOT NULL, 
  `cod_turma` INT NOT NULL, 
  PRIMARY KEY (`cod_evento`, `cod_turma`), 
  FOREIGN KEY (`cod_evento`) REFERENCES `tcc`.`evento` (`cod_evento`) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (`cod_turma`) REFERENCES `tcc`.`turma` (`cod_turma`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- esporte_turma
CREATE TABLE esporte_turma (
  cod_esporte INT NOT NULL, 
  cod_turma INT NOT NULL, 
  cod_treino INT, 
  PRIMARY KEY (cod_esporte, cod_turma), 
  FOREIGN KEY (cod_esporte) REFERENCES esporte(cod_esporte), 
  FOREIGN KEY (cod_turma) REFERENCES turma(cod_turma), 
  FOREIGN KEY (cod_treino) REFERENCES treino(cod_treino)
);
-- midia_esporte
CREATE TABLE `tcc`.`midia_esporte` (
  `cod_esporte` INT NOT NULL, 
  `local_midia` VARCHAR(100) NULL, 
    CONSTRAINT `fk_esporte_midia_esporte` FOREIGN KEY (`cod_esporte`) REFERENCES `esporte` (`cod_esporte`) 
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- midia_jogador
CREATE TABLE `tcc`.`midia_jogador` (
  `cod_jogador` INT NOT NULL, 
  `local_midia` VARCHAR(100) NULL, 
  PRIMARY KEY (`cod_jogador`),
  CONSTRAINT `fk_jogador_midia_jogador` 
    FOREIGN KEY (`cod_jogador`) REFERENCES `jogador` (`cod_jogador`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- =========================
-- REATIVAR REGRAS
-- =========================
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
  ('Relatórios'),                -- cod_item_menu = 2
  ('Eventos'),                -- cod_item_menu = 2
  ('Meus dados');

-- Submenus para "Gerenciamento de Usuários"
INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(1, '/tcc/telas/TI/telaCadastroTI.php', 'Cadastro TI'),                    -- 1
(1, '/tcc/telas/ADMI/telaCadastroADMI.php', 'Cadastro ADMI'),             -- 2
(1, '/tcc/telas/ADMS/telaCadastroADMS.php', 'Cadastro ADMS'),             -- 3
(1, '/tcc/telas/STAFFADMS/telaCadastroStaffADMS.php', 'Cadastro Staff ADMS'), -- 4
(1, '/tcc/telas/STAFF/telaCadastroStaff.php', 'Cadastro Staff'),          -- 5
(1, '/tcc/telas/JOGADOR/telaCadastroJogador.php', 'Cadastro Jogador'),    -- 6
(1, '/tcc/telas/STAFF/organizacaoTurmaPorStaff.php', 'Organização de Turmas por Staff'); -- 7

-- Submenus para "Relatórios"
INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES
(2, '/tcc/telas/TI/telaDadosInstituicao.php', 'Instituição'),         -- 8
(2, '/tcc/telas/ADMI/telaDadosSubInstituicao.php', 'Sub-Instituição'),-- 9
(2, '/tcc/telas/ADMS/telaDadosTurma.php', 'Turma'),                   -- 10
(2, '/tcc/telas/TI/telaDadosNacao.php', 'Nação'),                     -- 11
(2, '/tcc/telas/TI/telaDadosEstado.php', 'Estado'),                   -- 12
(2, '/tcc/telas/TI/telaDadosMunicipio.php', 'Município');             -- 13




-- Relacionar todos os tipos de role com os menus principais
INSERT INTO itemMenu_tipoRole (cod_item_menu, cod_tipo_role) VALUES
(1, 1), (2, 1),(3, 1),  -- TI
(1, 2), (2, 2),(3, 2),  -- ADMI
(1, 3), (2, 3),(3, 3),  -- ADMS
(1, 4), (2, 4),(3, 4),  -- ADMS|STAFF
(1, 5), (2, 5),(3, 5),  -- STAFF
(1, 6), (2, 6),(3, 6);  -- JOGADOR


-- TI
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 1, 1),   -- TI pode acessar: Cadastro TI
(1, 2, 1),   -- TI pode acessar: Cadastro ADMI
(1, 3, 1),   -- TI pode acessar: Cadastro ADMS
(1, 4, 1),   -- TI pode acessar: Cadastro Staff ADMS
(1, 5, 1),   -- TI pode acessar: Cadastro Staff
(1, 6, 1),   -- TI pode acessar: Cadastro Jogador
(1, 7, 1),   -- TI pode acessar: Organização de Turmas por Staff
(2, 8, 1),   -- TI pode acessar: Instituição
(2, 9, 1),   -- TI pode acessar: Sub-Instituição
(2, 10, 1),  -- TI pode acessar: Turma
(2, 11, 1),  -- TI pode acessar: Nação
(2, 12, 1);  -- TI pode acessar: Estado

-- ADMI
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 2, 2),
(1, 3, 2),
(1, 4, 2),
(1, 5, 2),
(1, 6, 2),
(2, 8, 2),
(2, 9, 2),
(2, 13, 2); -- Organização de Turmas por Staff

-- ADMS
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 3, 3),  -- Cadastro ADMS
(1, 4, 3),  -- Cadastro Staff ADMS
(1, 5, 3),  -- Cadastro Staff
(1, 6, 3),  -- Cadastro Jogador
(2, 9, 3);  -- Turma

-- ADMS|STAFF
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES
(1, 3, 4),   -- Cadastro ADMS
(1, 4, 4),   -- Cadastro Staff ADMS
(1, 5, 4),   -- Cadastro Staff
(1, 6, 4),   -- Cadastro Jogador
(1, 13, 4),  -- Organização de Turmas por Staff
(2, 9, 4);   -- Turma


INSERT INTO item_menu (role_html) VALUES ('Meus dados');
INSERT INTO subitem_menu (cod_item_menu, href, label) VALUES (4, '/tcc/telas/MEUSDADOS/meusDados.php', 'Meus dados'); 
INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES (3, 15, 4);   

-- -- STAFF
-- INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES

-- -- JOGADOR
-- INSERT INTO itemMenu_subitemMenu (cod_item_menu, cod_subitem_menu, cod_tipo_role) VALUES

-- STAFFS: IDs de 6 até 15
INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES 
('staff 6', 100000006, 1, 's'),
('staff 7', 100000007, 1, 's'),
('staff 8', 100000008, 1, 's'),
('staff 9', 100000009, 1, 's'),
('staff 10', 100000010, 1, 's'),
('staff 11', 100000011, 1, 's'),
('staff 12', 100000012, 1, 's'),
('staff 13', 100000013, 1, 's'),
('staff 14', 100000014, 1, 's'),
('staff 15', 100000015, 1, 's');

INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES
(6, 5), (7, 5), (8, 5), (9, 5), (10, 5),
(11, 5), (12, 5), (13, 5), (14, 5), (15, 5);

INSERT INTO staff (cod_staff) VALUES
 (8), (9), (10),
(11), (12), (13), (14), (15);

INSERT INTO subInstituticao_staff (cod_staff, cod_subInstituicao) VALUES
(9, 1), (10, 1),
(11, 1), (12, 1), (13, 1), (14, 1), (15, 1);

INSERT INTO login_usuario (cod_usuario, email_usuario, senha) VALUES
(9, 'staff9@gmail.com', 'staff9'),
(10, 'staff10@gmail.com', 'staff10'),
(11, 'staff11@gmail.com', 'staff11'),
(12, 'staff12@gmail.com', 'staff12'),
(13, 'staff13@gmail.com', 'staff13'),
(14, 'staff14@gmail.com', 'staff14'),
(15, 'staff15@gmail.com', 'staff15');

-- EVENTOS com staffs de 6 a 15
-- Turmas de 1 a 10

INSERT INTO evento (cod_staff, titulo_evento, data, horario, local, desc_evento, ativo) VALUES
(6, 'Evento 1', '2025-06-01', '09:00:00', 'Sala 1', 'Descrição do Evento 1', 'S'),
(7, 'Evento 2', '2025-06-02', '10:00:00', 'Sala 2', 'Descrição do Evento 2', 'S'),
(8, 'Evento 3', '2025-06-03', '11:00:00', 'Sala 3', 'Descrição do Evento 3', 'S'),
(9, 'Evento 4', '2025-06-04', '12:00:00', 'Sala 4', 'Descrição do Evento 4', 'S'),
(10, 'Evento 5', '2025-06-05', '13:00:00', 'Sala 5', 'Descrição do Evento 5', 'S'),
(11, 'Evento 6', '2025-06-06', '14:00:00', 'Sala 6', 'Descrição do Evento 6', 'S'),
(12, 'Evento 7', '2025-06-07', '15:00:00', 'Sala 7', 'Descrição do Evento 7', 'S'),
(13, 'Evento 8', '2025-06-08', '16:00:00', 'Sala 8', 'Descrição do Evento 8', 'S'),
(14, 'Evento 9', '2025-06-09', '17:00:00', 'Sala 9', 'Descrição do Evento 9', 'S'),
(15, 'Evento 10','2025-06-10', '18:00:00', 'Sala 10','Descrição do Evento 10', 'S');

INSERT INTO turma_evento (cod_evento, cod_turma) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 1),
(8, 2),
(9, 3),
(10, 1);

insert into staff_turma(cod_staff,cod_turma) values (9,3),(9,2),(9,5);
INSERT INTO staff_turma(cod_staff, cod_turma) VALUES
(9, 1),
(10, 2),
(11, 3),
(12, 4),
(13, 5),
(14, 2),
(15, 3),
(9, 4),
(10, 5),
(11, 1);

UPDATE subinstituticao_staff SET cod_SubInstituicao = 2 WHERE cod_staff = 6;
UPDATE subinstituticao_staff SET cod_SubInstituicao = 3 WHERE cod_staff = 7;
UPDATE subinstituticao_staff SET cod_SubInstituicao = 1 WHERE cod_staff = 9;
UPDATE subinstituticao_staff SET cod_SubInstituicao = 5 WHERE cod_staff = 10;
UPDATE subinstituticao_staff SET cod_SubInstituicao = 6 WHERE cod_staff = 11;
UPDATE subinstituticao_staff SET cod_SubInstituicao = 7 WHERE cod_staff = 12;
UPDATE subinstituticao_staff SET cod_SubInstituicao = 8 WHERE cod_staff = 13;
-- UPDATE subinstituticao_staff SET cod_SubInstituicao = 9 WHERE cod_staff = 14;
-- UPDATE subinstituticao_staff SET cod_SubInstituicao = 10 WHERE cod_staff = 15;

insert into staff_turma(cod_staff,cod_turma) values (14,9);


-- INSERTS em cadastro_identificacao
INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES 
('Thiago Heleno', '13432640900', '1', 's'),
('Carlos Silva', '12345678901', '2', 's'),
('Ana Pereira', '98765432100', '3', 's'),
('Bruna Rocha', '45612378900', '4', 's'),
('Lucas Costa', '32165498700', '5', 's'),
('Fernanda Lima', '14725836900', '6', 's'),
('Paulo Sousa', '25836914700', '7', 's'),
('Juliana Mendes', '36914725800', '8', 's'),
('Renato Torres', '74185296300', '9', 's'),
('Marina Alves', '85296374100', '10', 's');

-- INSERTS em role_cadastro
INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES 
(18, 6), (19, 6), (20, 6), (21, 6), (22, 6), (23, 6), (24, 6), (25, 6), (26, 6), (27, 6);

-- INSERTS em jogador
INSERT INTO jogador (cod_jogador, data_nascimento, posicao, esporte) VALUES 
(18, '2003-03-02', 5, 1),
(19, '2004-04-15', 2, 1),
(20, '2005-01-10', 3, 1),
(21, '2002-07-22', 1, 2),
(22, '2003-11-30', 4, 2),
(23, '2001-05-18', 2, 1),
(24, '2000-12-12', 5, 1),
(25, '2004-09-09', 3, 1),
(26, '2005-06-06', 1, 2),
(27, '2002-02-28', 4, 2);

-- INSERTS em turma_jogador
INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES 
(1, 18), (1, 19), (2, 20), (2, 21), (3, 22), (3, 23), (1, 24), (2, 25), (3, 26), (1, 27);

-- INSERTS em midia_jogador
INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES 
(18, 'EG2x_trabalho framework-01.png'),
(19, 'foto19.png'),
(20, 'foto20.jpg'),
(21, 'img21.jpeg'),
(22, 'media22.png'),
(23, 'arquivo23.pdf'),
(24, 'video24.mp4'),
(25, 'midia25.png'),
(26, 'upload26.png'),
(27, 'img27.jpg');

-- INSERTS em fichaMedica
INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) VALUES 
(18, 1.80, 75, 'AB-', 'Nenhuma', 'Poeira', NOW()),
(19, 1.75, 68, 'O+', 'Asma', 'Amendoim', NOW()),
(20, 1.70, 65, 'A-', 'Miopia', 'Nenhuma', NOW()),
(21, 1.85, 82, 'B+', 'Diabetes tipo 1', 'Pólen', NOW()),
(22, 1.90, 88, 'AB+', 'Nenhuma', 'Glúten', NOW()),
(23, 1.78, 74, 'O-', 'Lesão anterior no joelho', 'Nenhuma', NOW()),
(24, 1.83, 79, 'A+', 'Nenhuma', 'Frutos do mar', NOW()),
(25, 1.76, 70, 'B-', 'Hiperatividade', 'Nenhuma', NOW()),
(26, 1.72, 66, 'O+', 'Bronquite', 'Leite', NOW()),
(27, 1.80, 77, 'AB-', 'Nenhuma', 'Nenhuma', NOW());


insert into login_usuario(cod_usuario,email_usuario,senha) values(18,'admir','admir');
