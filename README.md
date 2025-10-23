
# TiendaCartasPokemon

Una aplicación web en donde se busca administrar y visualizar un inventario de cartas Pokémon.


## Autores

- [@Contreras González André Yahir](https://github.com/XxTiny2099xX)
- [@Laurrabaquio Ramírez Bryan Ricardo ](https://github.com/bryanlaurrabaquio)
- [@Mejia Osornio Valeria ](https://github.com/ba777e)
- [@Romero Palacios Randy Rodrigo](https://github.com/RandyPalacios02)
- [@Villanueva García Emanuel](https://github.com/Emanuel1596)


## Idea general del sistema

El sistema será una tienda web donde se mostrarán las cartas Pokémon que estarán registradas en la base de datos.  

Los usuarios podrán visualizar la información de las cartas como su categoría (por ejemplo: fuego, agua, eléctrico, legendaria, etc.) y su precio.

**Tipos de usuarios:**
- **Administrador:** Puede agregar, editar o eliminar cartas.  
- **Cliente:** Solo puede consultar el catálogo de cartas disponibles.
## Tecnologías utilizadas

- **HTML:** Estructura visual (formularios, botones, tablas).  
- **CSS:** Estilos con temática Pokémon (fondos amarillos y azules, botones llamativos).  
- **JavaScript:** Interacción dinámica, comunicación con la API sin recargar la página.  
- **Java (Backend):** Lógica del servidor, creación de la API y aplicación del patrón Proxy.  
- **Base de Datos (MariaDB o PostgreSQL):** Almacenamiento de usuarios, categorías y cartas.  
- **API (Interfaz de Programación de Aplicaciones):** Puente entre frontend y backend que gestiona las peticiones.
## Uso del patrón Proxy

El Proxy actúa como intermediario entre la API y la base de datos, controlando el acceso a ciertas funciones:

- Si el usuario es **administrador**, puede agregar o eliminar cartas.  
- Si el usuario es **cliente**, solo puede consultar el catálogo.  

De esta forma, el Proxy valida los permisos antes de permitir o denegar cualquier acción.
## Entidades principales del sistema

| Entidad             | Descripción                                                                                                                 | Ejemplo                                   |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| **Cliente**         | Persona que usa la tienda solo para **consultar** el catálogo.                                                              | “María (cliente)”                         |
| **Administrador**   | Persona con permisos para **agregar/editar/eliminar** cartas e inventario.                                                  | “Carlos (admin)”                          |
| **Carta Pokémon**   | Objeto principal del catálogo: pertenece a un **Set**, tiene **número en el set**, **tipos**, **rareza** y **precio base**. | “Pikachu – Set Base – #58/102 – $150”     |
| **Tipo**            | Clasificación elemental (una carta puede tener **varios tipos**).                                                           | “Fuego”, “Agua”, “Eléctrico”              |
| **Categoría**       | Etiquetas libres para agrupar cartas (temas/rareza especial).                                                               | “Legendaria”, “Promo”                     |
| **Set (Expansión)** | Colección/edición oficial a la que pertenece la carta.                                                                      | “Prismatic”, “SV01”                        |
| **Rareza**          | Grado de rareza definido por la edición.                                                                                    | “Common”, “Rare”, “Ultra Rare”            |
| **Idioma**          | Idioma de impresión del ítem en inventario.                                                                                 | “es”, “en”, “ja”                          |
| **Condición**       | Estado físico que afecta precio/venta.                                                                                      | “NM (Near Mint)”, “LP”                    |
| **Inventario**      | Ítem vendible (SKU) por **Carta + Idioma + Condición**, con **cantidad** y **precio**.                                      | `PK-BASE-58-ES-NM → 5 pzas a $150`        |
| **ImagenCarta**     | Una o varias imágenes asociadas a una carta; **máx. una principal**.                                                        | `https://…/pikachu-front.png` (principal) |

## Entidades principales del sistema

**Cliente**
| Atributo       | Tipo         | Restricciones / Notas                   |
| -------------- | ------------ | --------------------------------------- |
| id_cliente     | BIGINT       | **PK**, autoincremental                 |
| username       | VARCHAR(50)  | **NOT NULL**, **UK**                    |
| email          | VARCHAR(255) | **NOT NULL**, **UK**                    |
| password_hash  | VARCHAR(255) | **NOT NULL**                            |
| nombre_mostrar | VARCHAR(100) | **NOT NULL**                            |
| activo         | BOOLEAN      | **NOT NULL**, DEFAULT TRUE              |
| creado_en      | TIMESTAMP    | **NOT NULL**, DEFAULT CURRENT_TIMESTAMP |

**Administrador**
| Atributo       | Tipo         | Restricciones / Notas                   |
| -------------- | ------------ | --------------------------------------- |
| id_admin       | BIGINT       | **PK**, autoincremental                 |
| username       | VARCHAR(50)  | **NOT NULL**, **UK**                    |
| email          | VARCHAR(255) | **NOT NULL**, **UK**                    |
| password_hash  | VARCHAR(255) | **NOT NULL**                            |
| nombre_mostrar | VARCHAR(100) | **NOT NULL**                            |
| activo         | BOOLEAN      | **NOT NULL**, DEFAULT TRUE              |
| creado_en      | TIMESTAMP    | **NOT NULL**, DEFAULT CURRENT_TIMESTAMP |

**Set**
| Atributo          | Tipo         | Restricciones / Notas |
| ----------------- | ------------ | --------------------- |
| id_set            | BIGINT       | **PK**                |
| codigo_set        | VARCHAR(20)  | **NOT NULL**, **UK**  |
| nombre_set        | VARCHAR(100) | **NOT NULL**          |
| fecha_lanzamiento | DATE         | NULL                  |

**Rareza**
| Atributo      | Tipo        | Restricciones / Notas |
| ------------- | ----------- | --------------------- |
| id_rareza     | SMALLINT    | **PK**                |
| nombre_rareza | VARCHAR(40) | **NOT NULL**, **UK**  |

**Tipo**
| Atributo    | Tipo        | Restricciones / Notas |
| ----------- | ----------- | --------------------- |
| id_tipo     | SMALLINT    | **PK**                |
| nombre_tipo | VARCHAR(30) | **NOT NULL**, **UK**  |

**Categoria**
| Atributo         | Tipo         | Restricciones / Notas |
| ---------------- | ------------ | --------------------- |
| id_categoria     | SMALLINT     | **PK**                |
| nombre_categoria | VARCHAR(50)  | **NOT NULL**, **UK**  |
| descripcion      | VARCHAR(255) | NULL                  |

**Carta**
| Atributo           | Tipo          | Restricciones / Notas              |
| ------------------ | ------------- | ---------------------------------- |
| id_carta           | BIGINT        | **PK**                             |
| id_set             | BIGINT        | **FK → Set(id_set)**, **NOT NULL** |
| id_rareza          | SMALLINT      | **FK → Rareza(id_rareza)**, NULL   |
| nombre             | VARCHAR(100)  | **NOT NULL**                       |
| numero_en_set      | VARCHAR(10)   | **NOT NULL**                       |
| hp                 | SMALLINT      | NULL, **CHK hp ≥ 0**               |
| descripcion        | TEXT          | NULL                               |
| precio_base        | DECIMAL(10,2) | **NOT NULL**, **CHK ≥ 0**          |
| activa             | BOOLEAN       | **NOT NULL**, DEFAULT TRUE         |
| **UK (compuesta)** | —             | (**id_set**, **numero_en_set**)    |

**CartaTipo**
| Atributo           | Tipo     | Restricciones / Notas                  |
| ------------------ | -------- | -------------------------------------- |
| id_carta           | BIGINT   | **FK → Carta(id_carta)**, **NOT NULL** |
| id_tipo            | SMALLINT | **FK → Tipo(id_tipo)**, **NOT NULL**   |
| **PK (compuesta)** | —        | (**id_carta**, **id_tipo**)            |

**CartaCategoria**
| Atributo           | Tipo     | Restricciones / Notas                          |
| ------------------ | -------- | ---------------------------------------------- |
| id_carta           | BIGINT   | **FK → Carta(id_carta)**, **NOT NULL**         |
| id_categoria       | SMALLINT | **FK → Categoría(id_categoria)**, **NOT NULL** |
| **PK (compuesta)** | —        | (**id_carta**, **id_categoria**)               |

**Idioma**
| Atributo      | Tipo        | Restricciones / Notas                       |
| ------------- | ----------- | ------------------------------------------- |
| id_idioma     | SMALLINT    | **PK**                                      |
| codigo_idioma | CHAR(5)     | **NOT NULL**, **UK** (ej. “es”, “en”, “ja”) |
| nombre_idioma | VARCHAR(40) | **NOT NULL**                                |

**Condicion**
| Atributo         | Tipo        | Restricciones / Notas                    |
| ---------------- | ----------- | ---------------------------------------- |
| id_condicion     | SMALLINT    | **PK**                                   |
| codigo_condicion | VARCHAR(10) | **NOT NULL**, **UK** (NM, LP, MP, HP, D) |
| nombre_condicion | VARCHAR(30) | **NOT NULL**                             |

**Inventario**
| Atributo           | Tipo          | Restricciones / Notas                           |
| ------------------ | ------------- | ----------------------------------------------- |
| id_inventario      | BIGINT        | **PK**                                          |
| id_carta           | BIGINT        | **FK → Carta(id_carta)**, **NOT NULL**          |
| id_idioma          | SMALLINT      | **FK → Idioma(id_idioma)**, **NOT NULL**        |
| id_condicion       | SMALLINT      | **FK → Condición(id_condicion)**, **NOT NULL**  |
| sku                | VARCHAR(40)   | **NOT NULL**, **UK**                            |
| cantidad           | INT           | **NOT NULL**, **CHK ≥ 0**                       |
| precio_unitario    | DECIMAL(10,2) | **NOT NULL**, **CHK ≥ 0**                       |
| actualizado_en     | TIMESTAMP     | **NOT NULL**, DEFAULT CURRENT_TIMESTAMP         |
| **UK (compuesta)** | —             | (**id_carta**, **id_idioma**, **id_condicion**) |

**ImagenCarta**
| Atributo          | Tipo         | Restricciones / Notas                                                       |
| ----------------- | ------------ | --------------------------------------------------------------------------- |
| id_imagen         | BIGINT       | **PK**                                                                      |
| id_carta          | BIGINT       | **FK → Carta(id_carta)**, **NOT NULL**                                      |
| url               | VARCHAR(500) | **NOT NULL**                                                                |
| texto_alternativo | VARCHAR(150) | NULL                                                                        |
| es_principal      | BOOLEAN      | **NOT NULL**, DEFAULT FALSE                                                 |
| **Regla**         | —            | **Máx. 1** `es_principal = TRUE` por carta (índice único parcial o trigger) |




**Aun debemos verificar bien las entidades, sus atributos, relaciones, restricciones, etc**
## Flujo del sistema

**1.** El usuario abre la página web (HTML, CSS y JS).  
**2.** Si es cliente, visualiza las cartas disponibles.  
**3.** Si es administrador, puede agregar o editar cartas.  
**4.** JavaScript envía peticiones a la API Java.  
**5.** La API llama al Proxy para validar permisos.  
**6.** Si el acceso es válido, se ejecuta la acción en la base de datos.  
**7.**   La API responde al navegador con el resultado.

  

**Aun hay que especificar mejor los diversos casos de uso. Esto solo es una vision general**


## Objetivo académico

El propósito de este proyecto es demostrar la integración completa de las tecnologías web:
- Frontend: HTML, CSS, JS  
- Backend: Java con API y Proxy  
- Base de Datos: MariaDB o PostgreSQL
## Resumen

Nuestro proyecto Tienda de Cartas Pokémon permitirá visualizar y administrar cartas, aplicando el patrón Proxy para controlar permisos de usuario.  

Con este sistema integramos API, Java, Base de Datos, HTML, CSS y JavaScript en un entorno funcional.
