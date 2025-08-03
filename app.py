from flask import Flask, render_template, redirect, url_for, request, flash
from flask_login import LoginManager, login_user, logout_user, login_required
from werkzeug.security import generate_password_hash, check_password_hash
from database import *

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///project.db"
app.secret_key = 'Romerito-Senpai'

login_manager = LoginManager()
login_manager.init_app(app)

db.init_app(app)

def criar_banco():
    with app.app_context():
        db.create_all()

@login_manager.user_loader
def load_user(user_id):
    return db.session.get(User, int(user_id))



@app.route('/')
def index():
    criar_banco()
    return render_template('index.html')



@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == 'POST':
        nome = request.form.get('nome')
        email = request.form.get('email')
        senha = request.form.get('senha')

        validar_user = db.session.execute(db.select(User).filter_by(email=email)).first()
        if not validar_user:
            user = User(nome=nome, email=email, senha_hash=generate_password_hash(senha))
            db.session.add(user)
            db.session.commit()
            login_user(user)
            return
        
        flash('ERRO 403! Este usuário já existe.', category='error')
        return

    return render_template("index.html")



@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == 'POST':
        nome = request.form.get('nome')
        email = request.form.get('email')
        senha = request.form.get('senha')
        
        validar_user = db.session.execute(db.select(User).filter_by(email=email)).first()
        if not validar_user:
            flash('ERRO 404! Usuário não cadastrado', category='error')
            return render_template("index.html")
        
        validar_senha = db.session.execute(db.select(User).filter_by(email=email)).scalar()
        if validar_senha and check_password_hash(validar_senha.senha_hash, senha):
            user = User(nome=nome, email=email, senha_hash=validar_senha.senha_hash)
            login_user(user)
            return render_template("index.html")
        
        flash('ERRO 401! Verfique sua senha e tente novamente', category='success')
        return render_template("index.html")
    
    return render_template("index.html")



@login_required
@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('index'))

@app.route('/dados')
def dados():
    return render_template('dados.html')

@app.route('/fichas')
def fichas():
    return render_template('fichas.html')

@app.route('/personagem-detail')
def personagem_detail():
    return render_template('fichapersonagem.html')

@app.route('/bestiario')
def bestiario():
    return render_template('bestiario.html')

@app.route('/bestiario-detail')
def bestiario_detail():
    return render_template('ficha_bestiario.html')

if __name__ == '__main__':
    app.run(debug=True)