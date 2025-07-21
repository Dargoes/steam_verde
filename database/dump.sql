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