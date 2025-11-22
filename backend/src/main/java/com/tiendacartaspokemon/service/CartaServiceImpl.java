package com.tiendacartaspokemon.service;

import com.tiendacartaspokemon.model.Carta;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

@Service
public class CartaServiceImpl implements CartaService {

    private final JdbcTemplate jdbcTemplate;

    public CartaServiceImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // =========================
    //  LISTAR
    // =========================
    @Override
    public List<Carta> listarCartas() {
        String sql = """
                SELECT
                    c.id_carta,
                    c.nombre,
                    s.nombre_set,
                    c.numero_en_set,
                    COALESCE(r.nombre_rareza, '') AS rareza,
                    COALESCE(
                        STRING_AGG(t.nombre_tipo, ', ' ORDER BY t.nombre_tipo),
                        ''
                    ) AS tipos,
                    c.precio_base
                FROM carta c
                JOIN set_carta s ON c.id_set = s.id_set
                LEFT JOIN rareza r ON c.id_rareza = r.id_rareza
                LEFT JOIN carta_tipo ct ON ct.id_carta = c.id_carta
                LEFT JOIN tipo t ON t.id_tipo = ct.id_tipo
                WHERE c.activa = TRUE
                GROUP BY
                    c.id_carta,
                    c.nombre,
                    s.nombre_set,
                    c.numero_en_set,
                    r.nombre_rareza,
                    c.precio_base
                ORDER BY c.id_carta
                """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Carta carta = new Carta();
            carta.setId(rs.getLong("id_carta"));
            carta.setNombre(rs.getString("nombre"));
            carta.setSetNombre(rs.getString("nombre_set"));
            carta.setNumeroEnSet(rs.getString("numero_en_set"));
            carta.setRareza(rs.getString("rareza"));
            carta.setTipos(rs.getString("tipos"));
            carta.setPrecio(rs.getDouble("precio_base"));

            // URL de imagen calculada en memoria
            carta.setImagenUrl(obtenerImagenPorNombre(carta.getNombre()));

            return carta;
        });
    }

    // =========================
    //  CREAR
    // =========================
    @Override
    @Transactional
    public Carta crearCarta(Carta carta) {

        Long idSet = obtenerIdSet(carta.getSetNombre());
        Long idRareza = obtenerIdRareza(carta.getRareza());

        String insertCarta = """
                INSERT INTO carta
                    (id_set, id_rareza, nombre, numero_en_set, hp, descripcion, precio_base, activa)
                VALUES
                    (?, ?, ?, ?, NULL, NULL, ?, TRUE)
                RETURNING id_carta
                """;

        Long idCarta = jdbcTemplate.queryForObject(
                insertCarta,
                Long.class,
                idSet,
                idRareza,
                carta.getNombre(),
                carta.getNumeroEnSet(),
                carta.getPrecio()
        );

        insertarTipos(idCarta, carta.getTipos());

        carta.setId(idCarta);
        carta.setImagenUrl(obtenerImagenPorNombre(carta.getNombre()));

        return carta;
    }

    // =========================
    //  ACTUALIZAR
    // =========================
    @Override
    @Transactional
    public Carta actualizarCarta(Long id, Carta carta) {

        Long idSet = obtenerIdSet(carta.getSetNombre());
        Long idRareza = obtenerIdRareza(carta.getRareza());

        String updateCarta = """
                UPDATE carta
                SET
                    id_set = ?,
                    id_rareza = ?,
                    nombre = ?,
                    numero_en_set = ?,
                    precio_base = ?
                WHERE id_carta = ?
                """;

        int updated = jdbcTemplate.update(
                updateCarta,
                idSet,
                idRareza,
                carta.getNombre(),
                carta.getNumeroEnSet(),
                carta.getPrecio(),
                id
        );

        if (updated == 0) {
            return null; // no existe esa carta
        }

        // Borramos tipos anteriores y volvemos a insertar
        jdbcTemplate.update("DELETE FROM carta_tipo WHERE id_carta = ?", id);
        insertarTipos(id, carta.getTipos());

        carta.setId(id);
        carta.setImagenUrl(obtenerImagenPorNombre(carta.getNombre()));

        return carta;
    }

    // =========================
    //  ELIMINAR (BORRADO FÍSICO)
    // =========================
    @Override
    @Transactional
    public void eliminarCarta(Long id) {
        // 1) Borramos relaciones primero para no violar llaves foráneas
        jdbcTemplate.update("DELETE FROM carta_tipo WHERE id_carta = ?", id);
        jdbcTemplate.update("DELETE FROM inventario WHERE id_carta = ?", id);

        // 2) Borrado físico de la carta
        jdbcTemplate.update("DELETE FROM carta WHERE id_carta = ?", id);
    }

    // =========================
    //  HELPERS: SET / RAREZA / TIPO
    // =========================

    private Long obtenerIdSet(String nombreSet) {
        if (nombreSet == null || nombreSet.isBlank()) {
            throw new IllegalArgumentException("El nombre del set no puede ir vacío");
        }

        String codigoSet = nombreSet.trim()
                .toUpperCase()
                .replace(" ", "_"); // Base Set -> BASE_SET

        String selectPorCodigo = "SELECT id_set FROM set_carta WHERE codigo_set = ?";

        List<Long> ids = jdbcTemplate.query(
                selectPorCodigo,
                (rs, rowNum) -> rs.getLong("id_set"),
                codigoSet
        );

        if (!ids.isEmpty()) {
            return ids.get(0);
        }

        String insert = """
                INSERT INTO set_carta (codigo_set, nombre_set)
                VALUES (?, ?)
                RETURNING id_set
                """;

        try {
            return jdbcTemplate.queryForObject(
                    insert,
                    Long.class,
                    codigoSet,
                    nombreSet
            );
        } catch (DuplicateKeyException ex) {
            return jdbcTemplate.queryForObject(
                    selectPorCodigo,
                    Long.class,
                    codigoSet
            );
        }
    }

    private Long obtenerIdRareza(String nombreRareza) {
        if (nombreRareza == null || nombreRareza.isBlank()) {
            return null; // en la tabla es NULL permitido
        }

        String nombreNormalizado = nombreRareza.trim();

        String select = "SELECT id_rareza FROM rareza WHERE nombre_rareza = ?";
        List<Long> ids = jdbcTemplate.query(
                select,
                (rs, rowNum) -> rs.getLong("id_rareza"),
                nombreNormalizado
        );

        if (!ids.isEmpty()) {
            return ids.get(0);
        }

        String insert = """
                INSERT INTO rareza (nombre_rareza)
                VALUES (?)
                RETURNING id_rareza
                """;

        try {
            return jdbcTemplate.queryForObject(
                    insert,
                    Long.class,
                    nombreNormalizado
            );
        } catch (DuplicateKeyException ex) {
            return jdbcTemplate.queryForObject(
                    select,
                    Long.class,
                    nombreNormalizado
            );
        }
    }

    private Long obtenerIdTipo(String nombreTipo) {
        String nombreNormalizado = nombreTipo.trim();

        String select = "SELECT id_tipo FROM tipo WHERE nombre_tipo = ?";
        List<Long> ids = jdbcTemplate.query(
                select,
                (rs, rowNum) -> rs.getLong("id_tipo"),
                nombreNormalizado
        );

        if (!ids.isEmpty()) {
            return ids.get(0);
        }

        String insert = """
                INSERT INTO tipo (nombre_tipo)
                VALUES (?)
                RETURNING id_tipo
                """;

        try {
            return jdbcTemplate.queryForObject(
                    insert,
                    Long.class,
                    nombreNormalizado
            );
        } catch (DuplicateKeyException ex) {
            return jdbcTemplate.queryForObject(
                    select,
                    Long.class,
                    nombreNormalizado
            );
        }
    }

    private void insertarTipos(Long idCarta, String tiposTexto) {
        if (tiposTexto == null || tiposTexto.isBlank()) {
            return;
        }

        List<String> tipos = Arrays.stream(tiposTexto.split(","))
                .map(String::trim)
                .filter(s -> !s.isBlank())
                .toList();

        String insertCartaTipo = """
                INSERT INTO carta_tipo (id_carta, id_tipo)
                VALUES (?, ?)
                ON CONFLICT DO NOTHING
                """;

        for (String nombreTipo : tipos) {
            Long idTipo = obtenerIdTipo(nombreTipo);
            jdbcTemplate.update(insertCartaTipo, idCarta, idTipo);
        }
    }

    // =========================
    //  HELPER: URL DE IMAGEN
    // =========================
    private String obtenerImagenPorNombre(String nombreCarta) {
        if (nombreCarta == null) {
            return null;
        }
        String n = nombreCarta.trim().toLowerCase();

        switch (n) {
            case "pikachu":
                return "https://images.pokemontcg.io/base1/58_hires.png";
            case "charizard":
                return "https://images.pokemontcg.io/base1/4_hires.png";
            case "mewtwo":
                return "https://images.pokemontcg.io/base1/10_hires.png";
            default:
                return "https://tcg.pokemon.com/assets/img/global/tcg-card-back-2x.jpg";
        }
    }
}
