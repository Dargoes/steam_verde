function rolarDado(lados, elemento) {
    let contador = 0;
    const intervalo = setInterval(() => {
        elemento.textContent = Math.floor(Math.random() * lados) + 1;
        contador++;
        if (contador > 10) {  // Para a animação após algumas trocas
            clearInterval(intervalo);
            elemento.textContent = Math.floor(Math.random() * lados) + 1;
        }
    }, 50); // Troca os números rapidamente antes de parar
}

function rolarD8() {
    const dado = document.querySelector("#d8 p");
    animarDado(dado);
    setTimeout(() => rolarDado(8, dado), 500);
}

function rolarD20() {
    const dado = document.querySelector("#d20 p");
    animarDado(dado);
    setTimeout(() => rolarDado(20, dado), 500);
}

function rolarD6() {
    const quantidade = parseInt(document.querySelector("#qntdados").value);
    const dados = document.querySelectorAll(".dadosEstilo .dado p");

    dados.forEach((dado, i) => {
        if (i < quantidade) {
            animarDado(dado);
            setTimeout(() => rolarDado(6, dado), 500);
        } else {
            dado.textContent = "-"; // Oculta dados não usados
        }
    });
}

// Adiciona animação de rotação ao dado
function animarDado(dado) {
    const dadoContainer = dado.parentElement; 
    dadoContainer.style.transition = "transform 0.5s ease";
    dadoContainer.style.transform = "rotate(360deg)";
    setTimeout(() => dadoContainer.style.transform = "rotate(0deg)", 500);
}

// Animação de quando aperta o botão
function animarBotao(botao) {
    botao.classList.add("animando");
    setTimeout(() => botao.classList.remove("animando"), 1000); // Remove a classe após 1s
}

document.querySelectorAll(".rolar").forEach(botao => {
    botao.addEventListener("click", function() {
        animarBotao(this);
    });
});