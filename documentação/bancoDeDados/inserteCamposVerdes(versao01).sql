-- Inserção de nações
INSERT INTO nacao (sigla_nacao, desc_nacao) VALUES
('br', 'Brasil'),
('ar', 'Argentina'),
('pt', 'Portugal');

-- Inserção de estados
INSERT INTO estado (cod_nacao, desc_estado, sigla_estado) VALUES
-- Argentina
(1, 'Buenos Aires', 'ba'),
(1, 'Córdoba', 'cb'),
(1, 'Santa Fe', 'sf'),

-- Brasil
(2, 'Paraná', 'pr'),
(2, 'São Paulo', 'sp'),
(2, 'Bahia', 'ba'),

-- Portugal
(3, 'Lisboa', 'ls'),
(3, 'Porto', 'pt'),
(3, 'Coimbra', 'cb');

-- Inserção de municípios
INSERT INTO municipio (cod_estado, desc_municipio, sigla_municipio) VALUES
-- Buenos Aires (cod_estado = 1)
(1, 'La Plata', 'lp'),
(1, 'Mar del Plata', 'mp'),
(1, 'Bahía Blanca', 'bb'),
(1, 'Quilmes', 'ql'),
(1, 'Tigre', 'tg'),

-- Córdoba (cod_estado = 2)
(2, 'Córdoba Capital', 'cc'),
(2, 'Río Cuarto', 'rc'),
(2, 'Villa María', 'vm'),

-- Santa Fe (cod_estado = 3)
(3, 'Rosário', 'rs'),
(3, 'Santa Fe', 'sf'),
(3, 'Rafaela', 'rf'),

-- Paraná (cod_estado = 4)
(4, 'Curitiba', 'ct'),
(4, 'Londrina', 'ld'),
(4, 'Maringá', 'mg'),
(4, 'Cascavel', 'cv'),
(4, 'Guarapuava', 'gp'),

-- São Paulo (cod_estado = 5)
(5, 'São Paulo', 'sp'),
(5, 'Campinas', 'cp'),
(5, 'Santos', 'st'),
(5, 'São Bernardo do Campo', 'sb'),
(5, 'Guarulhos', 'gl'),

-- Bahia (cod_estado = 6)
(6, 'Salvador', 'sv'),
(6, 'Feira de Santana', 'fs'),
(6, 'Vitória da Conquista', 'vc'),
(6, 'Itabuna', 'ib'),
(6, 'Ilhéus', 'il'),

-- Lisboa (cod_estado = 7)
(7, 'Lisboa', 'ls'),
(7, 'Sintra', 'sn'),
(7, 'Loures', 'lr'),
(7, 'Amadora', 'ad'),
(7, 'Odivelas', 'od'),

-- Porto (cod_estado = 8)
(8, 'Porto', 'pt'),
(8, 'Gondomar', 'gd'),
(8, 'Matosinhos', 'mt'),

-- Coimbra (cod_estado = 9)
(9, 'Coimbra', 'cb'),
(9, 'Figueira da Foz', 'ff'),
(9, 'Condeixa-a-Nova', 'cn');

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
INSERT INTO grau_privacidade (cod_grau_privacidade, descricao) VALUES
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
('Treinadores','STAFF','s'),
('jogadores','','s');


