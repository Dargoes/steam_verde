function ficarVerde(elemento){
    if(elemento.style.backgroundColor === "var(--verde)"){
        elemento.style.backgroundColor = "var(--vermelho)"
    } else {
        elemento.style.backgroundColor = "var(--verde)"
    }
}