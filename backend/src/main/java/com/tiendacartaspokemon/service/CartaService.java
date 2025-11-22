package com.tiendacartaspokemon.service;

import com.tiendacartaspokemon.model.Carta;

import java.util.List;

public interface CartaService {

    List<Carta> listarCartas();

    Carta crearCarta(Carta carta);

    Carta actualizarCarta(Long id, Carta carta);

    void eliminarCarta(Long id);
}
