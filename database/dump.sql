-- Personagens
CREATE TABLE feral (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    titulo TEXT NOT NULL,
    player TEXT NOT NULL,
	especialidade TEXT NOT NULL,
    imagem_url TEXT NOT NULL,
	vigor_max INT NOT NULL,
	vigor_atual INT NOT NULL,
	voce_e VARCHAR(100),
	tenta_ser VARCHAR(100),
	feras_familiares TEXT,
	prato_tipico VARCHAR(50),
	tempero_tipico VARCHAR(50),
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
    nome TEXT NOT NULL,
    alcance VARCHAR(50) NOT NULL,
    se_quebrado TEXT NOT NULL,
    durabilidade_atual INT NOT NULL,
    durabilidade_maxima INT NOT NULL
);

CREATE TABLE ataques_utensilio (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	custo TEXT NOT NULL,
	descricao TEXT NOT NULL,
	utensilio_id INTEGER REFERENCES utensilio(id) ON DELETE CASCADE
);

-- Feral Estilos
CREATE TABLE feral_estilo (
    feral_id INTEGER REFERENCES feral(id) ON DELETE CASCADE,
    ligeiro INT NOT NULL,
    poderoso INT NOT NULL,
    preciso INT NOT NULL,
    sagaz INT NOT NULL,
    PRIMARY KEY (feral_id)
);

-- Feral Habilidades
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
    PRIMARY KEY (feral_id)
);

-- Monstros
CREATE TABLE monstro (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    categoria VARCHAR(20) CHECK (categoria IN ('Jovem','Adulto','Apex')),
    vigor_base INT NOT NULL,
    vigor_atual INT NOT NULL,
    historia TEXT NOT NULL,
    alvos TEXT NOT NULL,
	dieta TEXT NOT NULL,
	habitat TEXT NOT NULL
);

-- Traços
CREATE TABLE traco_feral (
    id SERIAL PRIMARY KEY,
	feral_id INTEGER REFERENCES feral(id) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    custo VARCHAR(50) NOT NULL,
    descricao TEXT NOT NULL,
    habilidade_relacionada VARCHAR(50) NOT NULL,
    estilo_relacionado VARCHAR(50) NOT NULL
);

-- Traços
CREATE TABLE traco_monstro (
    id SERIAL PRIMARY KEY,
	monstro_id INTEGER REFERENCES monstro(id) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    custo VARCHAR(50) NOT NULL,
    descricao TEXT NOT NULL,
    habilidade_relacionada VARCHAR(50) NOT NULL,
    estilo_relacionado VARCHAR(50) NOT NULL
);

-- Partes dos monstros
CREATE TABLE parte (
    id SERIAL PRIMARY KEY,
    monstro_id INTEGER REFERENCES monstro(id) ON DELETE CASCADE,
    nome VARCHAR(50) NOT NULL,
    alcance VARCHAR(50) NOT NULL,
    se_quebrado TEXT NOT NULL,
    durabilidade_atual INT NOT NULL,
    durabilidade_maxima INT NOT NULL
);

-- Estilos
CREATE TABLE monstro_estilo (
    monstro_id INTEGER REFERENCES monstro(id) ON DELETE CASCADE,
    ligeiro INT NOT NULL,
    poderoso INT NOT NULL,
    preciso INT NOT NULL,
    sagaz INT NOT NULL,
    PRIMARY KEY (monstro_id)
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
    PRIMARY KEY (monstro_id)
);