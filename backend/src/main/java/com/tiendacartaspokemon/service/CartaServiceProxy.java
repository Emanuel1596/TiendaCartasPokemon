package com.tiendacartaspokemon.service;

import com.tiendacartaspokemon.model.Carta;
import com.tiendacartaspokemon.model.RolUsuario;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartaServiceProxy implements CartaService {

    private final CartaServiceImpl realService;

    public CartaServiceProxy(CartaServiceImpl realService) {
        this.realService = realService;
    }

    private void verificarPermisoEdicion(RolUsuario rol) {
        if (rol != RolUsuario.ADMINISTRADOR) {
            throw new SecurityException("No tienes permiso para modificar cartas.");
        }
    }

    @Override
    public List<Carta> listarCartas() {
        return realService.listarCartas();
    }

    public List<Carta> listarCartas(RolUsuario rol) {
        return realService.listarCartas();
    }

    @Override
    public Carta crearCarta(Carta carta) {
        return realService.crearCarta(carta);
    }

    public Carta crearCarta(Carta carta, RolUsuario rol) {
        verificarPermisoEdicion(rol);
        return realService.crearCarta(carta);
    }

    @Override
    public Carta actualizarCarta(Long id, Carta carta) {
        return realService.actualizarCarta(id, carta);
    }

    public Carta actualizarCarta(Long id, Carta carta, RolUsuario rol) {
        verificarPermisoEdicion(rol);
        return realService.actualizarCarta(id, carta);
    }

    @Override
    public void eliminarCarta(Long id) {
        realService.eliminarCarta(id);
    }

    public void eliminarCarta(Long id, RolUsuario rol) {
        verificarPermisoEdicion(rol);
        realService.eliminarCarta(id);
    }
}
