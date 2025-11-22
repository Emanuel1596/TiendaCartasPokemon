--
-- PostgreSQL database dump
--

\restrict bjg0EnhxWwk6qb7uz1feSnp7kGmdEBJtLVa0xVWU5tNZteN47kvodWPwsboBlTo

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: administrador; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.administrador (
    id_admin bigint NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    nombre_mostrar character varying(100) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.administrador OWNER TO tienda_user;

--
-- Name: administrador_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.administrador_id_admin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administrador_id_admin_seq OWNER TO tienda_user;

--
-- Name: administrador_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.administrador_id_admin_seq OWNED BY public.administrador.id_admin;


--
-- Name: carta; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.carta (
    id_carta bigint NOT NULL,
    id_set bigint NOT NULL,
    id_rareza smallint,
    nombre character varying(100) NOT NULL,
    numero_en_set character varying(10) NOT NULL,
    hp smallint,
    descripcion text,
    precio_base numeric(10,2) NOT NULL,
    activa boolean DEFAULT true NOT NULL,
    imagen_url text,
    CONSTRAINT carta_hp_check CHECK ((hp >= 0)),
    CONSTRAINT carta_precio_base_check CHECK ((precio_base >= (0)::numeric))
);


ALTER TABLE public.carta OWNER TO tienda_user;

--
-- Name: carta_categoria; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.carta_categoria (
    id_carta bigint NOT NULL,
    id_categoria smallint NOT NULL
);


ALTER TABLE public.carta_categoria OWNER TO tienda_user;

--
-- Name: carta_id_carta_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.carta_id_carta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carta_id_carta_seq OWNER TO tienda_user;

--
-- Name: carta_id_carta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.carta_id_carta_seq OWNED BY public.carta.id_carta;


--
-- Name: carta_tipo; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.carta_tipo (
    id_carta bigint NOT NULL,
    id_tipo smallint NOT NULL
);


ALTER TABLE public.carta_tipo OWNER TO tienda_user;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.categoria (
    id_categoria smallint NOT NULL,
    nombre_categoria character varying(50) NOT NULL,
    descripcion character varying(255)
);


ALTER TABLE public.categoria OWNER TO tienda_user;

--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_categoria_seq OWNER TO tienda_user;

--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.cliente (
    id_cliente bigint NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    nombre_mostrar character varying(100) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.cliente OWNER TO tienda_user;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.cliente_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_cliente_seq OWNER TO tienda_user;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;


--
-- Name: condicion; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.condicion (
    id_condicion smallint NOT NULL,
    codigo_condicion character varying(10) NOT NULL,
    nombre_condicion character varying(30) NOT NULL
);


ALTER TABLE public.condicion OWNER TO tienda_user;

--
-- Name: condicion_id_condicion_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.condicion_id_condicion_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.condicion_id_condicion_seq OWNER TO tienda_user;

--
-- Name: condicion_id_condicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.condicion_id_condicion_seq OWNED BY public.condicion.id_condicion;


--
-- Name: idioma; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.idioma (
    id_idioma smallint NOT NULL,
    codigo_idioma character(5) NOT NULL,
    nombre_idioma character varying(40) NOT NULL
);


ALTER TABLE public.idioma OWNER TO tienda_user;

--
-- Name: idioma_id_idioma_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.idioma_id_idioma_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.idioma_id_idioma_seq OWNER TO tienda_user;

--
-- Name: idioma_id_idioma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.idioma_id_idioma_seq OWNED BY public.idioma.id_idioma;


--
-- Name: imagen_carta; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.imagen_carta (
    id_imagen bigint NOT NULL,
    id_carta bigint NOT NULL,
    url character varying(500) NOT NULL,
    texto_alternativo character varying(150),
    es_principal boolean DEFAULT false NOT NULL
);


ALTER TABLE public.imagen_carta OWNER TO tienda_user;

--
-- Name: imagen_carta_id_imagen_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.imagen_carta_id_imagen_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.imagen_carta_id_imagen_seq OWNER TO tienda_user;

--
-- Name: imagen_carta_id_imagen_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.imagen_carta_id_imagen_seq OWNED BY public.imagen_carta.id_imagen;


--
-- Name: inventario; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.inventario (
    id_inventario bigint NOT NULL,
    id_carta bigint NOT NULL,
    id_idioma smallint NOT NULL,
    id_condicion smallint NOT NULL,
    sku character varying(40) NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    actualizado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT inventario_cantidad_check CHECK ((cantidad >= 0)),
    CONSTRAINT inventario_precio_unitario_check CHECK ((precio_unitario >= (0)::numeric))
);


ALTER TABLE public.inventario OWNER TO tienda_user;

--
-- Name: inventario_id_inventario_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.inventario_id_inventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventario_id_inventario_seq OWNER TO tienda_user;

--
-- Name: inventario_id_inventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.inventario_id_inventario_seq OWNED BY public.inventario.id_inventario;


--
-- Name: rareza; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.rareza (
    id_rareza smallint NOT NULL,
    nombre_rareza character varying(40) NOT NULL
);


ALTER TABLE public.rareza OWNER TO tienda_user;

--
-- Name: rareza_id_rareza_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.rareza_id_rareza_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rareza_id_rareza_seq OWNER TO tienda_user;

--
-- Name: rareza_id_rareza_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.rareza_id_rareza_seq OWNED BY public.rareza.id_rareza;


--
-- Name: set_carta; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.set_carta (
    id_set bigint NOT NULL,
    codigo_set character varying(20) NOT NULL,
    nombre_set character varying(100) NOT NULL,
    fecha_lanzamiento date
);


ALTER TABLE public.set_carta OWNER TO tienda_user;

--
-- Name: set_carta_id_set_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.set_carta_id_set_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.set_carta_id_set_seq OWNER TO tienda_user;

--
-- Name: set_carta_id_set_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.set_carta_id_set_seq OWNED BY public.set_carta.id_set;


--
-- Name: tipo; Type: TABLE; Schema: public; Owner: tienda_user
--

CREATE TABLE public.tipo (
    id_tipo smallint NOT NULL,
    nombre_tipo character varying(30) NOT NULL
);


ALTER TABLE public.tipo OWNER TO tienda_user;

--
-- Name: tipo_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: tienda_user
--

CREATE SEQUENCE public.tipo_id_tipo_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_id_tipo_seq OWNER TO tienda_user;

--
-- Name: tipo_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tienda_user
--

ALTER SEQUENCE public.tipo_id_tipo_seq OWNED BY public.tipo.id_tipo;


--
-- Name: vw_cartas_catalogo; Type: VIEW; Schema: public; Owner: tienda_user
--

CREATE VIEW public.vw_cartas_catalogo AS
 SELECT c.id_carta AS id,
    c.nombre,
    s.nombre_set AS set_nombre,
    c.numero_en_set,
    r.nombre_rareza AS rareza,
    COALESCE(string_agg((t.nombre_tipo)::text, ', '::text ORDER BY (t.nombre_tipo)::text), ''::text) AS tipos,
    c.precio_base AS precio
   FROM ((((public.carta c
     JOIN public.set_carta s ON ((c.id_set = s.id_set)))
     LEFT JOIN public.rareza r ON ((c.id_rareza = r.id_rareza)))
     LEFT JOIN public.carta_tipo ct ON ((ct.id_carta = c.id_carta)))
     LEFT JOIN public.tipo t ON ((t.id_tipo = ct.id_tipo)))
  GROUP BY c.id_carta, c.nombre, s.nombre_set, c.numero_en_set, r.nombre_rareza, c.precio_base;


ALTER VIEW public.vw_cartas_catalogo OWNER TO tienda_user;

--
-- Name: administrador id_admin; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.administrador ALTER COLUMN id_admin SET DEFAULT nextval('public.administrador_id_admin_seq'::regclass);


--
-- Name: carta id_carta; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta ALTER COLUMN id_carta SET DEFAULT nextval('public.carta_id_carta_seq'::regclass);


--
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- Name: cliente id_cliente; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);


--
-- Name: condicion id_condicion; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.condicion ALTER COLUMN id_condicion SET DEFAULT nextval('public.condicion_id_condicion_seq'::regclass);


--
-- Name: idioma id_idioma; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.idioma ALTER COLUMN id_idioma SET DEFAULT nextval('public.idioma_id_idioma_seq'::regclass);


--
-- Name: imagen_carta id_imagen; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.imagen_carta ALTER COLUMN id_imagen SET DEFAULT nextval('public.imagen_carta_id_imagen_seq'::regclass);


--
-- Name: inventario id_inventario; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.inventario ALTER COLUMN id_inventario SET DEFAULT nextval('public.inventario_id_inventario_seq'::regclass);


--
-- Name: rareza id_rareza; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.rareza ALTER COLUMN id_rareza SET DEFAULT nextval('public.rareza_id_rareza_seq'::regclass);


--
-- Name: set_carta id_set; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.set_carta ALTER COLUMN id_set SET DEFAULT nextval('public.set_carta_id_set_seq'::regclass);


--
-- Name: tipo id_tipo; Type: DEFAULT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.tipo ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_id_tipo_seq'::regclass);


--
-- Name: administrador administrador_email_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.administrador
    ADD CONSTRAINT administrador_email_key UNIQUE (email);


--
-- Name: administrador administrador_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.administrador
    ADD CONSTRAINT administrador_pkey PRIMARY KEY (id_admin);


--
-- Name: administrador administrador_username_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.administrador
    ADD CONSTRAINT administrador_username_key UNIQUE (username);


--
-- Name: carta_categoria carta_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta_categoria
    ADD CONSTRAINT carta_categoria_pkey PRIMARY KEY (id_carta, id_categoria);


--
-- Name: carta carta_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta
    ADD CONSTRAINT carta_pkey PRIMARY KEY (id_carta);


--
-- Name: carta_tipo carta_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta_tipo
    ADD CONSTRAINT carta_tipo_pkey PRIMARY KEY (id_carta, id_tipo);


--
-- Name: categoria categoria_nombre_categoria_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_nombre_categoria_key UNIQUE (nombre_categoria);


--
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- Name: cliente cliente_email_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_email_key UNIQUE (email);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- Name: cliente cliente_username_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_username_key UNIQUE (username);


--
-- Name: condicion condicion_codigo_condicion_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.condicion
    ADD CONSTRAINT condicion_codigo_condicion_key UNIQUE (codigo_condicion);


--
-- Name: condicion condicion_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.condicion
    ADD CONSTRAINT condicion_pkey PRIMARY KEY (id_condicion);


--
-- Name: idioma idioma_codigo_idioma_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT idioma_codigo_idioma_key UNIQUE (codigo_idioma);


--
-- Name: idioma idioma_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT idioma_pkey PRIMARY KEY (id_idioma);


--
-- Name: imagen_carta imagen_carta_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.imagen_carta
    ADD CONSTRAINT imagen_carta_pkey PRIMARY KEY (id_imagen);


--
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);


--
-- Name: inventario inventario_sku_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_sku_key UNIQUE (sku);


--
-- Name: rareza rareza_nombre_rareza_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.rareza
    ADD CONSTRAINT rareza_nombre_rareza_key UNIQUE (nombre_rareza);


--
-- Name: rareza rareza_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.rareza
    ADD CONSTRAINT rareza_pkey PRIMARY KEY (id_rareza);


--
-- Name: set_carta set_carta_codigo_set_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.set_carta
    ADD CONSTRAINT set_carta_codigo_set_key UNIQUE (codigo_set);


--
-- Name: set_carta set_carta_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.set_carta
    ADD CONSTRAINT set_carta_pkey PRIMARY KEY (id_set);


--
-- Name: tipo tipo_nombre_tipo_key; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- Name: tipo tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (id_tipo);


--
-- Name: carta uk_carta_set_numero; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta
    ADD CONSTRAINT uk_carta_set_numero UNIQUE (id_set, numero_en_set);


--
-- Name: inventario uk_inventario_carta_idioma_condicion; Type: CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT uk_inventario_carta_idioma_condicion UNIQUE (id_carta, id_idioma, id_condicion);


--
-- Name: uq_imagen_carta_principal; Type: INDEX; Schema: public; Owner: tienda_user
--

CREATE UNIQUE INDEX uq_imagen_carta_principal ON public.imagen_carta USING btree (id_carta) WHERE (es_principal = true);


--
-- Name: carta_categoria carta_categoria_id_carta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta_categoria
    ADD CONSTRAINT carta_categoria_id_carta_fkey FOREIGN KEY (id_carta) REFERENCES public.carta(id_carta);


--
-- Name: carta_categoria carta_categoria_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta_categoria
    ADD CONSTRAINT carta_categoria_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- Name: carta carta_id_rareza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta
    ADD CONSTRAINT carta_id_rareza_fkey FOREIGN KEY (id_rareza) REFERENCES public.rareza(id_rareza);


--
-- Name: carta carta_id_set_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta
    ADD CONSTRAINT carta_id_set_fkey FOREIGN KEY (id_set) REFERENCES public.set_carta(id_set);


--
-- Name: carta_tipo carta_tipo_id_carta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta_tipo
    ADD CONSTRAINT carta_tipo_id_carta_fkey FOREIGN KEY (id_carta) REFERENCES public.carta(id_carta);


--
-- Name: carta_tipo carta_tipo_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.carta_tipo
    ADD CONSTRAINT carta_tipo_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo(id_tipo);


--
-- Name: imagen_carta imagen_carta_id_carta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.imagen_carta
    ADD CONSTRAINT imagen_carta_id_carta_fkey FOREIGN KEY (id_carta) REFERENCES public.carta(id_carta);


--
-- Name: inventario inventario_id_carta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_id_carta_fkey FOREIGN KEY (id_carta) REFERENCES public.carta(id_carta);


--
-- Name: inventario inventario_id_condicion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_id_condicion_fkey FOREIGN KEY (id_condicion) REFERENCES public.condicion(id_condicion);


--
-- Name: inventario inventario_id_idioma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tienda_user
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_id_idioma_fkey FOREIGN KEY (id_idioma) REFERENCES public.idioma(id_idioma);


--
-- PostgreSQL database dump complete
--

\unrestrict bjg0EnhxWwk6qb7uz1feSnp7kGmdEBJtLVa0xVWU5tNZteN47kvodWPwsboBlTo

