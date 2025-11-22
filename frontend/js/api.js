const API_BASE = "/api";

// =======================
//  CATÁLOGO (CLIENTE)
// =======================
async function cargarCartas() {
    const container = document.getElementById('cartas-container');
    if (!container) return;

    container.innerHTML = "Cargando...";

    try {
        const res = await fetch(`${API_BASE}/cartas`);
        const cartas = await res.json();

        if (!Array.isArray(cartas) || cartas.length === 0) {
            container.innerHTML = "<p>No hay cartas.</p>";
            return;
        }

        container.innerHTML = "";
        cartas.forEach(c => {
            const div = document.createElement('div');
            div.className = 'carta-card';

            const imagenUrl = c.imagenUrl && c.imagenUrl.trim() !== ""
                ? c.imagenUrl
                : "https://tcg.pokemon.com/assets/img/global/tcg-card-back-2x.jpg";

            div.innerHTML = `
                <img src="${imagenUrl}" alt="${c.nombre}" class="carta-img">
                <h3>${c.nombre}</h3>
                <p><strong>Set:</strong> ${c.setNombre}</p>
                <p><strong>Número:</strong> ${c.numeroEnSet}</p>
                <p><strong>Rareza:</strong> ${c.rareza}</p>
                <p><strong>Tipos:</strong> ${c.tipos}</p>
                <p><strong>Precio:</strong> $${c.precio}</p>
            `;
            container.appendChild(div);
        });
    } catch (err) {
        console.error(err);
        container.innerHTML = "<p>Error al cargar cartas.</p>";
    }
}

// =======================
//  PANEL ADMIN
// =======================
async function cargarCartasAdmin() {
    const container = document.getElementById('cartas-container-admin');
    if (!container) return;

    container.innerHTML = "Cargando...";

    try {
        const res = await fetch(`${API_BASE}/cartas`);
        const cartas = await res.json();

        if (!Array.isArray(cartas) || cartas.length === 0) {
            container.innerHTML = "<p>No hay cartas.</p>";
            return;
        }

        container.innerHTML = "";
        cartas.forEach(c => {
            const div = document.createElement('div');
            div.className = 'carta-card';

            const imagenUrl = c.imagenUrl && c.imagenUrl.trim() !== ""
                ? c.imagenUrl
                : "https://tcg.pokemon.com/assets/img/global/tcg-card-back-2x.jpg";

            div.innerHTML = `
                <img src="${imagenUrl}" alt="${c.nombre}" class="carta-img">
                <h3>${c.nombre}</h3>
                <p><strong>Set:</strong> ${c.setNombre}</p>
                <p><strong>Número:</strong> ${c.numeroEnSet}</p>
                <p><strong>Rareza:</strong> ${c.rareza}</p>
                <p><strong>Tipos:</strong> ${c.tipos}</p>
                <p><strong>Precio:</strong> $${c.precio}</p>
            `;
            container.appendChild(div);
        });
    } catch (err) {
        console.error(err);
        container.innerHTML = "<p>Error al cargar cartas.</p>";
    }
}

// =======================
//  CREAR CARTA (ADMIN)
// =======================
async function crearCartaAdmin(carta) {
    try {
        const res = await fetch(`${API_BASE}/cartas`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-ROL': 'ADMINISTRADOR'
            },
            body: JSON.stringify(carta)
        });

        if (!res.ok) {
            const text = await res.text();
            alert("Error al crear carta: " + text);
        }
    } catch (err) {
        console.error(err);
        alert("Error de red.");
    }
}
