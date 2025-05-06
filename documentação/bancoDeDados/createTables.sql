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

-- Mídia da Nação
CREATE TABLE `midia_nacao` (
  `cod_midia` INT NOT NULL AUTO_INCREMENT, 
  `cod_nacao` INT NOT NULL, 
  `local_midia` VARCHAR(100), 
  PRIMARY KEY (`cod_midia`), 
  CONSTRAINT `fk_nacao_midia_nacao` FOREIGN KEY (`cod_nacao`) REFERENCES `nacao` (`cod_nacao`) ON DELETE RESTRICT ON UPDATE CASCADE
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

-- Tipo de Role
CREATE TABLE `tipo_role` (
  `cod_tipo_role` INT NOT NULL AUTO_INCREMENT, 
  `desc_tipo_role` VARCHAR(100), 
  `abrev_tipo_role` CHAR(10), 
  `ativo` CHAR(1), 
  PRIMARY KEY (`cod_tipo_role`)
) ENGINE = InnoDB;

-- Item de Menu
CREATE TABLE `item_menu` (
  `cod_item_menu` INT NOT NULL AUTO_INCREMENT, 
  `href` VARCHAR(200), 
  `html_id` VARCHAR(200), 
  `role_html` VARCHAR(200), 
  `label` VARCHAR(200), 
  `cod_tipo_role` INT NOT NULL, 
  PRIMARY KEY (`cod_item_menu`), 
  CONSTRAINT `fk_item_menu_tipo_role` FOREIGN KEY (`cod_tipo_role`) REFERENCES `tipo_role` (`cod_tipo_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Subitem de Menu
CREATE TABLE `subitem_menu` (
  `cod_subitem_menu` INT NOT NULL AUTO_INCREMENT, 
  `cod_item_menu` INT NOT NULL, 
  `href` VARCHAR(200), 
  `label` VARCHAR(200), 
  PRIMARY KEY (`cod_subitem_menu`), 
  CONSTRAINT `fk_subitem_item_menu` FOREIGN KEY (`cod_item_menu`) REFERENCES `item_menu` (`cod_item_menu`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

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
  `cod_subInstituto` INT NOT NULL, 
  PRIMARY KEY (`cod_staff`, `cod_subInstituto`), 
  CONSTRAINT `fk_staff` FOREIGN KEY (`cod_staff`) REFERENCES `tcc`.`staff` (`cod_staff`) ON DELETE CASCADE ON UPDATE CASCADE, 
  CONSTRAINT `fk_subInstituto` FOREIGN KEY (`cod_subInstituto`) REFERENCES `tcc`.`subInstituicao` (`cod_instituicao`) ON DELETE CASCADE ON UPDATE CASCADE
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
  evento VARCHAR(50), 
  data DATE, 
  horario TIME, 
  local VARCHAR(50), 
  titulo VARCHAR(100), 
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
  FOREIGN KEY (`cod_staff`) REFERENCES `staff`(`cod_staff`) ON DELETE NO ACTION ON UPDATE NO ACTION, 
  FOREIGN KEY (`cod_esporte`) REFERENCES `esporte`(`cod_esporte`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

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
  `categoria` VARCHAR(100) NULL, 
  `tipo_lesao` VARCHAR(100) NULL, 
  `desc_lesao` VARCHAR(100) NULL, 
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
  `esporte` INT, 
  `ficha_medica_cod_jogador` INT, 
  PRIMARY KEY (`cod_jogador`), 
  FOREIGN KEY (`cod_jogador`) REFERENCES `role_cadastro`(`cod_usuario`), 
  FOREIGN KEY (`posicao`) REFERENCES `posicao`(`cod_posicao`), 
  FOREIGN KEY (`esporte`) REFERENCES `esporte`(`cod_esporte`), 
  FOREIGN KEY (`ficha_medica_cod_jogador`) REFERENCES `ficha_medica`(`cod_jogador`)
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
  cod_jogador INT NOT NULL, 
  cod_staff INT NOT NULL, 
  nota_jogador CHAR(3), 
  ativo CHAR(1), 
  PRIMARY KEY (cod_jogador, cod_staff), 
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
  telefoneResponsavel CHAR(11), 
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
