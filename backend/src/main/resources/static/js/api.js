const API_BASE = "/api";

let cartaEditandoId = null; // null = modo crear, número = modo editar

// =======================
//  UTILIDADES FRONT
// =======================

function obtenerImagenMostrar(carta) {
    // Si el backend manda imagenUrl la usamos, si no, usamos una por defecto
    if (carta.imagenUrl && carta.imagenUrl.trim() !== "") {
        return carta.imagenUrl.trim();
    }
    // carta por defecto (puedes cambiarla)
    return "https://images.pokemontcg.io/base1/58_hires.png";
}

// =======================
//  CATÁLOGO (CLIENTE)
// =======================

async function cargarCartas() {
    const container = document.getElementById('cartas-container');
    if (!container) return; // no estamos en index.html

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

            const imagenUrl = obtenerImagenMostrar(c);

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

function llenarFormularioConCarta(carta) {
    const nombre = document.getElementById('nombre');
    const setNombre = document.getElementById('setNombre');
    const numeroEnSet = document.getElementById('numeroEnSet');
    const rareza = document.getElementById('rareza');
    const tipos = document.getElementById('tipos');
    const imagenUrl = document.getElementById('imagenUrl');
    const precio = document.getElementById('precio');
    const btnGuardar = document.getElementById('btn-guardar');

    if (!nombre || !setNombre || !numeroEnSet || !rareza || !tipos || !precio) {
        return;
    }

    nombre.value = carta.nombre || "";
    setNombre.value = carta.setNombre || "";
    numeroEnSet.value = carta.numeroEnSet || "";
    rareza.value = carta.rareza || "";
    tipos.value = carta.tipos || "";
    imagenUrl.value = carta.imagenUrl || "";
    precio.value = carta.precio || "";

    cartaEditandoId = carta.id;
    if (btnGuardar) btnGuardar.textContent = "Actualizar carta";
}

function limpiarFormulario() {
    const form = document.getElementById('form-carta');
    if (form) form.reset();

    const btnGuardar = document.getElementById('btn-guardar');
    if (btnGuardar) btnGuardar.textContent = "Guardar carta";

    cartaEditandoId = null;
}

function obtenerCartaDeFormulario() {
    const nombre = document.getElementById('nombre')?.value.trim();
    const setNombre = document.getElementById('setNombre')?.value.trim();
    const numeroEnSet = document.getElementById('numeroEnSet')?.value.trim();
    const rareza = document.getElementById('rareza')?.value;
    const tipos = document.getElementById('tipos')?.value;
    const imagenUrl = document.getElementById('imagenUrl')?.value.trim();
    const precioInput = document.getElementById('precio');
    const precioValor = parseFloat(precioInput?.value || "0");

    if (!nombre) {
        alert("Escribe el nombre de la carta.");
        return null;
    }
    if (!setNombre) {
        alert("Escribe el set de la carta.");
        return null;
    }
    if (!numeroEnSet) {
        alert("Escribe el número en el set.");
        return null;
    }
    if (!rareza) {
        alert("Selecciona una rareza.");
        return null;
    }
    if (!tipos) {
        alert("Selecciona un tipo.");
        return null;
    }

    if (isNaN(precioValor) || precioValor <= 0) {
        alert("Escribe un precio válido mayor a 0.");
        if (precioInput) precioInput.focus();
        return null;
    }

    if (precioValor > 1000000) {
        alert("Precio demasiado alto. Máximo permitido: 1,000,000.");
        if (precioInput) precioInput.focus();
        return null;
    }

    return {
        nombre: nombre,
        setNombre: setNombre,
        numeroEnSet: numeroEnSet,
        rareza: rareza,
        tipos: tipos,
        precio: precioValor,
        imagenUrl: imagenUrl || null
    };
}

async function manejarSubmitFormulario(e) {
    e.preventDefault();

    const carta = obtenerCartaDeFormulario();
    if (!carta) return;

    try {
        if (cartaEditandoId == null) {
            // CREAR
            await crearCartaAdmin(carta);
        } else {
            // ACTUALIZAR
            await actualizarCartaAdmin(cartaEditandoId, carta);
        }

        limpiarFormulario();
        await cargarCartasAdmin();
    } catch (err) {
        console.error(err);
        alert("Error al guardar la carta.");
    }
}

async function cargarCartasAdmin() {
    const container = document.getElementById('cartas-container-admin');
    if (!container) return; // no estamos en admin.html

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

            const imagenUrl = obtenerImagenMostrar(c);

            div.innerHTML = `
                <img src="${imagenUrl}" alt="${c.nombre}" class="carta-img">
                <h3>${c.nombre}</h3>
                <p><strong>Set:</strong> ${c.setNombre}</p>
                <p><strong>Número:</strong> ${c.numeroEnSet}</p>
                <p><strong>Rareza:</strong> ${c.rareza}</p>
                <p><strong>Tipos:</strong> ${c.tipos}</p>
                <p><strong>Precio:</strong> $${c.precio}</p>
            `;

            // Botones de acción
            const btnEditar = document.createElement('button');
            btnEditar.textContent = "Editar";
            btnEditar.addEventListener('click', () => {
                llenarFormularioConCarta(c);
            });

            const btnEliminar = document.createElement('button');
            btnEliminar.textContent = "Eliminar";
            btnEliminar.addEventListener('click', async () => {
                await eliminarCarta(c.id);
                await cargarCartasAdmin();
            });

            div.appendChild(btnEditar);
            div.appendChild(btnEliminar);

            container.appendChild(div);
        });
    } catch (err) {
        console.error(err);
        container.innerHTML = "<p>Error al cargar cartas.</p>";
    }
}

// =======================
//  LLAMADAS A LA API (ADMIN)
// =======================

async function crearCartaAdmin(carta) {
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
}

async function actualizarCartaAdmin(id, carta) {
    const res = await fetch(`${API_BASE}/cartas/${id}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
            'X-ROL': 'ADMINISTRADOR'
        },
        body: JSON.stringify(carta)
    });

    if (!res.ok) {
        const text = await res.text();
        alert("Error al actualizar carta: " + text);
    }
}

async function eliminarCarta(id) {
    if (!confirm("¿Seguro que quieres borrar esta carta?")) return;

    const res = await fetch(`${API_BASE}/cartas/${id}`, {
        method: 'DELETE',
        headers: {
            'X-ROL': 'ADMINISTRADOR'
        }
    });

    if (!res.ok) {
        const text = await res.text();
        alert("Error al eliminar carta: " + text);
    }
}

// =======================
//  INICIALIZACIÓN AUTOMÁTICA
// =======================

window.addEventListener('DOMContentLoaded', () => {
    // Si existe catálogo de cliente
    const btnRecargar = document.getElementById('btn-recargar');
    if (btnRecargar) {
        btnRecargar.addEventListener('click', cargarCartas);
        cargarCartas();
    }

    // Si existe panel admin
    const formAdmin = document.getElementById('form-carta');
    const btnRecargarAdmin = document.getElementById('btn-recargar-admin');

    if (formAdmin && btnRecargarAdmin) {
        formAdmin.addEventListener('submit', manejarSubmitFormulario);
        btnRecargarAdmin.addEventListener('click', cargarCartasAdmin);
        cargarCartasAdmin();
    }
});
