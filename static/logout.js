document.addEventListener("DOMContentLoaded", function () {
    const perfilBtn = document.getElementById("perfil-btn");
    const popup = document.getElementById("popup-logout");
    const logoutBtn = document.getElementById("logout-btn");

    if (perfilBtn && popup && logoutBtn) {
        perfilBtn.addEventListener("click", function (e) {
            e.stopPropagation();
            popup.classList.toggle("hidden");
        });

        logoutBtn.addEventListener("click", function () {
            const logoutUrl = perfilBtn.dataset.logoutUrl;
            if (logoutUrl) {
                window.location.href = logoutUrl;
            } else {
                console.error("URL de logout não encontrada.");
            }
        });

        document.addEventListener("click", function (event) {
            if (!perfilBtn.contains(event.target) && !popup.contains(event.target)) {
                popup.classList.add("hidden");
            }
        });
    }
});