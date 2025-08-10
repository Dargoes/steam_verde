from __future__ import annotations
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from sqlalchemy.orm import Mapped, mapped_column

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///project.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db = SQLAlchemy()


class User(db.Model, UserMixin):
    user_id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    nome: Mapped[str] = mapped_column(nullable=True)
    email: Mapped[str] = mapped_column(unique=True, nullable=True)
    senha_hash: Mapped[str]

    def get_id(self):
        return str(self.user_id)

    
feral_condicao = db.Table(
    "feral_condicao",
    db.Column("feral_id", db.Integer, db.ForeignKey("feral.id", ondelete="CASCADE"), primary_key=True),
    db.Column("condicao_id", db.Integer, db.ForeignKey("condicao.id", ondelete="CASCADE"), primary_key=True),
)


class Feral(db.Model):
    __tablename__ = "feral"
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    titulo = db.Column(db.String(100), nullable=False)
    player = db.Column(db.String(100), nullable=False)
    imagem_url = db.Column(db.Text, nullable=False)
    criacao = db.Column(db.Text, nullable=False)
    iniciacao = db.Column(db.Text, nullable=False)
    ambicao = db.Column(db.Text, nullable=False)
    conexao = db.Column(db.Text, nullable=False)
    especialidade = db.Column(db.Text, nullable=False)

    condicoes = db.relationship("Condicao", secondary=feral_condicao, back_populates="ferais")
    utensilios = db.relationship("Utensilio", back_populates="feral", cascade="all, delete-orphan")
    estilo = db.relationship("FeralEstilo", uselist=False, back_populates="feral", cascade="all, delete-orphan")
    habilidade = db.relationship("FeralHabilidade", uselist=False, back_populates="feral", cascade="all, delete-orphan")
    tracos = db.relationship("Traco", back_populates="feral", cascade="all, delete-orphan")


class Condicao(db.Model):
    __tablename__ = "condicao"
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50), unique=True, nullable=False)

    ferais = db.relationship("Feral", secondary=feral_condicao, back_populates="condicoes")


class Utensilio(db.Model):
    __tablename__ = "utensilio"
    id = db.Column(db.Integer, primary_key=True)
    feral_id = db.Column(db.Integer, db.ForeignKey("feral.id", ondelete="CASCADE"), nullable=False)
    nome = db.Column(db.String(50), nullable=False)
    alcance = db.Column(db.String(50), nullable=False)
    se_quebrado = db.Column(db.Text, nullable=False)
    durabilidade_atual = db.Column(db.Integer, nullable=False)
    durabilidade_maxima = db.Column(db.Integer, nullable=False)
    ataques = db.Column(db.Text)

    feral = db.relationship("Feral", back_populates="utensilios")


class FeralEstilo(db.Model):
    __tablename__ = "feral_estilo"
    feral_id = db.Column(db.Integer, db.ForeignKey("feral.id", ondelete="CASCADE"), primary_key=True)
    ligeiro = db.Column(db.Integer, nullable=False)
    poderoso = db.Column(db.Integer, nullable=False)
    preciso = db.Column(db.Integer, nullable=False)
    sagaz = db.Column(db.Integer, nullable=False)

    feral = db.relationship("Feral", back_populates="estilo")


class FeralHabilidade(db.Model):
    __tablename__ = "feral_habilidade"
    feral_id = db.Column(db.Integer, db.ForeignKey("feral.id", ondelete="CASCADE"), primary_key=True)
    agarrar = db.Column(db.Integer, nullable=False)
    atirar = db.Column(db.Integer, nullable=False)
    curar = db.Column(db.Integer, nullable=False)
    golpear = db.Column(db.Integer, nullable=False)
    armazenar = db.Column(db.Integer, nullable=False)
    atravessar = db.Column(db.Integer, nullable=False)
    estudar = db.Column(db.Integer, nullable=False)
    manufaturar = db.Column(db.Integer, nullable=False)
    assegurar = db.Column(db.Integer, nullable=False)
    chamar = db.Column(db.Integer, nullable=False)
    exibir = db.Column(db.Integer, nullable=False)
    procurar = db.Column(db.Integer, nullable=False)

    feral = db.relationship("Feral", back_populates="habilidade")


class Traco(db.Model):
    __tablename__ = "traco"
    id = db.Column(db.Integer, primary_key=True)
    feral_id = db.Column(db.Integer, db.ForeignKey("feral.id", ondelete="CASCADE"), nullable=False)
    nome = db.Column(db.String(100), nullable=False)
    custo = db.Column(db.String(50), nullable=False)
    descricao = db.Column(db.Text, nullable=False)
    habilidade_relacionada = db.Column(db.String(50), nullable=False)
    estilo_relacionado = db.Column(db.String(50), nullable=False)

    feral = db.relationship("Feral", back_populates="tracos")


class Monstro(db.Model):
    __tablename__ = "monstro"
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    categoria = db.Column(db.String(20), db.CheckConstraint("categoria IN ('Jovem','Adulto','Apex')"))
    resistencia_base = db.Column(db.Integer, nullable=False)
    resistencia_atual = db.Column(db.Integer, nullable=False)
    descricao = db.Column(db.Text)
    alvos = db.Column(db.Text)
    acoes = db.Column(db.Text)

    # partes_rel = db.relationship("Parte", back_populates="monstro", cascade="all, delete-orphan")


# class Parte(db.Model):
#     __tablename__ = "parte"
#     id = db.Column(db.Integer, primary_key=True)
#     monstro_id = db.Column(db.Integer, db.ForeignKey("monstro.id", ondelete="CASCADE"), nullable=False)
#     nome = db.Column(db.String(100), nullable=False)
#     quantidade = db.Column(db.Integer, nullable=False)
#     modificador_max = db.Column(db.Integer)

#     monstro = db.relationship("Monstro", back_populates="partes_rel")