-- Personagens
CREATE TABLE feral (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    player VARCHAR(100) NOT NULL,
    imagem_url TEXT NOT NULL,
    criacao TEXT NOT NULL,
    iniciacao TEXT NOT NULL,
    ambicao TEXT NOT NULL,
    conexao TEXT NOT NULL
);

-- Condições
CREATE TABLE condicao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE feral_condicao (
    feral_id INTEGER REFERENCES feral(id) ON DELETE CASCADE,
    condicao_id INTEGER REFERENCES condicao(id) ON DELETE CASCADE,
    PRIMARY KEY (feral_id, condicao_id)
);

-- Utensílios
CREATE TABLE utensilio (
    id SERIAL PRIMARY KEY,
    feral_id INTEGER REFERENCES feral(id) ON DELETE CASCADE,
    nome VARCHAR(50) NOT NULL,
    alcance VARCHAR(50) NOT NULL,
    se_quebrado TEXT NOT NULL,
    durabilidade_atual INT NOT NULL,
    durabilidade_maxima INT NOT NULL,
    ataques TEXT
);

-- Estilos
CREATE TABLE feral_estilo (
    feral_id INTEGER REFERENCES feral(id) ON DELETE CASCADE,
    ligeiro INT NOT NULL,
    poderoso INT NOT NULL,
    preciso INT NOT NULL,
    sagaz INT NOT NULL,
    PRIMARY KEY (feral_id, estilo_id)
);

-- Habilidades
CREATE TABLE feral_habilidade (
    feral_id INTEGER REFERENCES feral(id) ON DELETE CASCADE,
    agarrar INT NOT NULL,
    atirar INT NOT NULL,
    curar INT NOT NULL,
    golpear INT NOT NULL,
    armazenar INT NOT NULL,
    atravessar INT NOT NULL,
    estudar INT NOT NULL,
    manufaturar INT NOT NULL,
    assegurar INT NOT NULL,
    chamar INT NOT NULL,
    exibir INT NOT NULL,
    procurar INT NOT NULL,
    PRIMARY KEY (feral_id, habilidade_id)
);

-- Traços
CREATE TABLE traco (
    id SERIAL PRIMARY KEY,
    feral_id INTEGER REFERENCES feral(id) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    descricao TEXT NOT NULL,
    habilidade_relacionada VARCHAR(50) NOT NULL,
    estilo_relacionado VARCHAR(50) NOT NULL
);



-- 1. Monstro
CREATE TABLE monstro (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(20) CHECK (categoria IN ('Jovem','Adulto','Apex')),
    resistencia_base INT NOT NULL,
    resistencia_atual INT NOT NULL
    partes INT NOT NULL,
    max_partes INT NOT NULL,
    descricao TEXT
);

-- Estilos
CREATE TABLE monstro_estilo (
    monstro_id INTEGER REFERENCES monstro(id) ON DELETE CASCADE,
    ligeiro INT NOT NULL,
    poderoso INT NOT NULL,
    preciso INT NOT NULL,
    sagaz INT NOT NULL,
    PRIMARY KEY (monstro_id, estilo_id)
);

-- Habilidades
CREATE TABLE monstro_habilidade (
    monstro_id INTEGER REFERENCES monstro(id) ON DELETE CASCADE,
    agarrar INT NOT NULL,
    atirar INT NOT NULL,
    curar INT NOT NULL,
    golpear INT NOT NULL,
    armazenar INT NOT NULL,
    atravessar INT NOT NULL,
    estudar INT NOT NULL,
    manufaturar INT NOT NULL,
    assegurar INT NOT NULL,
    chamar INT NOT NULL,
    exibir INT NOT NULL,
    procurar INT NOT NULL,
    PRIMARY KEY (monstro_id, habilidade_id)
);

-- 8. Ação
CREATE TABLE acao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- 9. Monstro-Ação
CREATE TABLE monstro_acao (
    id SERIAL PRIMARY KEY,
    monstro_id INT NOT NULL REFERENCES monstro(id) ON DELETE CASCADE,
    acao_id INT NOT NULL REFERENCES acao(id) ON DELETE CASCADE,
    UNIQUE (monstro_id, acao_id)
);

-- 10. Alvo Prioridade
CREATE TABLE alvo_prioridade (
    id SERIAL PRIMARY KEY,
    monstro_id INT NOT NULL REFERENCES monstro(id) ON DELETE CASCADE,
    ordem INT NOT NULL,
    UNIQUE (monstro_id, ordem)
);

CREATE TABLE parte (
    id SERIAL PRIMARY KEY,
    monstro_id INT NOT NULL REFERENCES monstro(id) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    modificador_max INT
);
