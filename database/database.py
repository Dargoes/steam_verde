from sqlalchemy import Column, Integer, ForeignKey, Boolean, CheckConstraint, create_engine, VARCHAR
from sqlalchemy.orm import declarative_base, relationship, sessionmaker

DATABASE_URL = "mysql+pymysql://romerito:romerito@localhost:3306/romerito"

engine = create_engine(DATABASE_URL, echo=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

class Users(Base):
    __tablename__ = 'users'
    user_id = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(VARCHAR(100), nullable=False)
    email = Column(VARCHAR(100), nullable=False)
    senha_hash = Column(VARCHAR(100), nullable=False)


def init_db():
    Base.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()