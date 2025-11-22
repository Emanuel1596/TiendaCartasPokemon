package com.tiendacartaspokemon.controller;

import com.tiendacartaspokemon.model.Carta;
import com.tiendacartaspokemon.model.RolUsuario;
import com.tiendacartaspokemon.service.CartaServiceProxy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cartas")
@CrossOrigin(origins = "*")
public class CartaController {

    private final CartaServiceProxy cartaServiceProxy;

    public CartaController(CartaServiceProxy cartaServiceProxy) {
        this.cartaServiceProxy = cartaServiceProxy;
    }

    @GetMapping
    public List<Carta> listarCartas() {
        return cartaServiceProxy.listarCartas();
    }

    @PostMapping
    public ResponseEntity<?> crearCarta(
            @RequestHeader("X-ROL") String rolHeader,
            @RequestBody Carta carta) {

        RolUsuario rol = RolUsuario.valueOf(rolHeader.toUpperCase());
        try {
            Carta creada = cartaServiceProxy.crearCarta(carta, rol);
            return ResponseEntity.status(HttpStatus.CREATED).body(creada);
        } catch (SecurityException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizarCarta(
            @RequestHeader("X-ROL") String rolHeader,
            @PathVariable Long id,
            @RequestBody Carta carta) {

        RolUsuario rol = RolUsuario.valueOf(rolHeader.toUpperCase());
        try {
            Carta actualizada = cartaServiceProxy.actualizarCarta(id, carta, rol);
            if (actualizada == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(actualizada);
        } catch (SecurityException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarCarta(
            @RequestHeader("X-ROL") String rolHeader,
            @PathVariable Long id) {

        RolUsuario rol = RolUsuario.valueOf(rolHeader.toUpperCase());
        try {
            cartaServiceProxy.eliminarCarta(id, rol);
            return ResponseEntity.noContent().build();
        } catch (SecurityException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        }
    }
}
