from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.orm import Mapped, mapped_column

class Base(DeclarativeBase):
  pass

db = SQLAlchemy(model_class=Base)

class User(db.Model, UserMixin):
    user_id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    nome: Mapped[str]
    email: Mapped[str] = mapped_column(unique=True, nullable=False)
    senha_hash: Mapped[str]

    def get_id(self):
      return str(self.user_id)
