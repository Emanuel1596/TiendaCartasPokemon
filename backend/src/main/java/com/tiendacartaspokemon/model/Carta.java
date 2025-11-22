package com.tiendacartaspokemon.model;

public class Carta {

    private Long id;
    private String nombre;
    private String setNombre;
    private String numeroEnSet;
    private String rareza;
    private String tipos;
    private Double precio;
    private String imagenUrl;  // 🔹 NUEVO

    public Carta() {
    }

    public Carta(Long id, String nombre, String setNombre,
                 String numeroEnSet, String rareza,
                 String tipos, Double precio, String imagenUrl) {
        this.id = id;
        this.nombre = nombre;
        this.setNombre = setNombre;
        this.numeroEnSet = numeroEnSet;
        this.rareza = rareza;
        this.tipos = tipos;
        this.precio = precio;
        this.imagenUrl = imagenUrl;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getSetNombre() { return setNombre; }
    public void setSetNombre(String setNombre) { this.setNombre = setNombre; }

    public String getNumeroEnSet() { return numeroEnSet; }
    public void setNumeroEnSet(String numeroEnSet) { this.numeroEnSet = numeroEnSet; }

    public String getRareza() { return rareza; }
    public void setRareza(String rareza) { this.rareza = rareza; }

    public String getTipos() { return tipos; }
    public void setTipos(String tipos) { this.tipos = tipos; }

    public Double getPrecio() { return precio; }
    public void setPrecio(Double precio) { this.precio = precio; }

    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }
}
