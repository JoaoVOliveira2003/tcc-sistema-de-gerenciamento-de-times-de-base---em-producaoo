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

-- Inserção de tipos de lesão
INSERT INTO tipo_lesao (categoria, tipo_lesao, desc_lesao) VALUES
('Lesões Musculares', 'Distensão Muscular', 'Estiramento excessivo dos músculos.'),
('Lesões Musculares', 'Cãibras', 'Contração involuntária e dolorosa dos músculos.'),
('Lesões Musculares', 'Ruptura Muscular', 'Quebra das fibras musculares devido a esforço excessivo.'),
('Lesões nos Tendões', 'Tendinite', 'Inflamação dos tendões, geralmente causada por uso repetitivo.'),
('Lesões nos Tendões', 'Tendinose', 'Degeneração dos tendões, podendo ser crônica.'),
('Lesões nos Tendões', 'Ruptura do Tendão', 'Quebra ou rompimento do tendão, com ou sem perda de função.'),
('Lesões nas Articulações', 'Entorse', 'Lesão nos ligamentos devido a torção excessiva.'),
('Lesões nas Articulações', 'Luxação', 'Deslocamento de um osso da sua posição na articulação.'),
('Lesões nas Articulações', 'Fratura Articular', 'Quebra de ossos dentro ou ao redor da articulação.'),
('Lesões nos Ligamentos', 'Lesão no Ligamento Cruzado Anterior (LCA)', 'Lesão no ligamento do joelho, comum em esportes com mudanças rápidas de direção.'),
('Lesões nos Ligamentos', 'Lesão no Ligamento Colateral', 'Afeta os ligamentos laterais do joelho ou cotovelo.'),
('Lesões nos Ligamentos', 'Lesões nos Ligamentos do Tornozelo', 'Lesão nos ligamentos do tornozelo, geralmente por entorses.'),
('Lesões nos Ossos', 'Fraturas', 'Quebra de um osso, podendo ser simples ou múltiplas.'),
('Lesões nos Ossos', 'Fratura por Estresse', 'Lesão óssea causada por sobrecarga repetitiva, comum em corredores.'),
('Lesões nos Meniscos', 'Lesão Meniscal', 'Rasgos ou danos nos meniscos do joelho, que ajudam a absorver impacto.'),
('Lesões Neurológicas', 'Concussão', 'Lesão cerebral causada por impacto forte na cabeça.'),
('Lesões Neurológicas', 'Contusão Cerebral', 'Lesão grave com danos ao tecido cerebral, geralmente por impacto forte.'),
('Lesões no Pescoço ou Coluna', 'Danos à medula espinhal ou nervos periféricos', 'Lesões no Pescoço ou Coluna.'),
('Lesões de Pele', 'Cortes e Lacerações', 'Ferimentos superficiais ou profundos causados por colisões.'),
('Lesões de Pele', 'Queimaduras', 'Lesões causadas por atrito ou calor.'),
('Lesões de Pele', 'Arranhões e Abrasões', 'Ferimentos leves causados por quedas ou contato com superfícies duras.'),
('Lesões no Pé e Tornozelo', 'Fratura no Pé', 'Quebra dos ossos do pé, geralmente por impacto direto.'),
('Lesões no Pé e Tornozelo', 'Entorse no Tornozelo', 'Lesão nos ligamentos do tornozelo, comumente causada por mudanças rápidas de direção.'),
('Lesões no Pé e Tornozelo', 'Fasceíte Plantar', 'Inflamação da fáscia plantar, comum em corredores.'),
('Lesões no Quadril e Lombar', 'Distensão do Quadril', 'Lesão nos músculos ou ligamentos do quadril.'),
('Lesões no Quadril e Lombar', 'Hérnia de Disco', 'Deslocamento do disco intervertebral, causando dor e limitação de movimento.');

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

INSERT INTO cadastro_identificacao (nome, cpf,cod_municipio,ativo) VALUES ('sistema','1',1,'s');

INSERT INTO role_cadastro (cod_usuario,cod_tipoRole) VALUES (1,5);

INSERT INTO staff(cod_staff) VALUES (1);
