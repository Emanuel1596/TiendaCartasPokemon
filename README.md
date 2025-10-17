
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

| Entidad | Descripción | Ejemplo |
|----------|--------------|----------|
| **Usuario** | Persona que usa el sistema (cliente o admin). | “Carlos (admin)” o “María (cliente)” |
| **Carta Pokémon** | Objeto principal de la tienda. Tiene nombre, tipo y precio. | “Pikachu – Eléctrico – $150” |
| **Categoría** | Agrupa las cartas por tipo o rareza. | “Fuego”, “Agua”, “Legendaria” |

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
