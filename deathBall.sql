--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-16 18:42:49 UTC

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

--
-- TOC entry 226 (class 1255 OID 16519)
-- Name: update_swords_count_on_insert_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_swords_count_on_insert_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE swords
    SET count = count + NEW.count
    WHERE id = NEW.sword_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_swords_count_on_insert_func() OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16574)
-- Name: update_ауры_player_count(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."update_ауры_player_count"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE ауры
        SET player_count = player_count + 1
        WHERE id = NEW.аура_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE ауры
        SET player_count = player_count - 1
        WHERE id = OLD.аура_id;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."update_ауры_player_count"() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 16576)
-- Name: update_мечи_player_count(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."update_мечи_player_count"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE мечи
        SET player_count = player_count + 1
        WHERE id = NEW.меч_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE мечи
        SET player_count = player_count - 1
        WHERE id = OLD.меч_id;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."update_мечи_player_count"() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16522)
-- Name: auras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auras (
    id integer NOT NULL,
    drop_chance integer,
    player_count integer DEFAULT 0,
    name character varying
);


ALTER TABLE public.auras OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16530)
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id integer NOT NULL,
    nickname character varying(50)
);


ALTER TABLE public.players OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16544)
-- Name: players_auras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_auras (
    player_id integer NOT NULL,
    aura_id integer NOT NULL
);


ALTER TABLE public.players_auras OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16559)
-- Name: players_swords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_swords (
    player_id integer NOT NULL,
    sword_id integer NOT NULL
);


ALTER TABLE public.players_swords OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16537)
-- Name: swords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.swords (
    id integer NOT NULL,
    name character varying(100),
    rarity character varying(50),
    price integer,
    player_count integer DEFAULT 0,
    power integer
);


ALTER TABLE public.swords OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16521)
-- Name: ауры_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ауры_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ауры_id_seq" OWNER TO postgres;

--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 215
-- Name: ауры_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ауры_id_seq" OWNED BY public.auras.id;


--
-- TOC entry 225 (class 1259 OID 16612)
-- Name: ауры_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auras ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ауры_id_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16529)
-- Name: игроки_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."игроки_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."игроки_id_seq" OWNER TO postgres;

--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 217
-- Name: игроки_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."игроки_id_seq" OWNED BY public.players.id;


--
-- TOC entry 223 (class 1259 OID 16582)
-- Name: игроки_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.players ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."игроки_id_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16536)
-- Name: мечи_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."мечи_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."мечи_id_seq" OWNER TO postgres;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 219
-- Name: мечи_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."мечи_id_seq" OWNED BY public.swords.id;


--
-- TOC entry 224 (class 1259 OID 16587)
-- Name: мечи_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.swords ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."мечи_id_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3389 (class 0 OID 16522)
-- Dependencies: 216
-- Data for Name: auras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auras (id, drop_chance, player_count, name) FROM stdin;
3	300	1	void
4	1000	1	embrance
5	3000	1	blood
6	10000	1	shadow
7	50000	1	time keeper
1	10	2	flower
2	1000	1	spirit
\.


--
-- TOC entry 3391 (class 0 OID 16530)
-- Dependencies: 218
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (id, nickname) FROM stdin;
1	eshkere
2	shay
3	moron
4	danyakosmostars
5	komerz
6	Nadya239
7	numberUno
8	Eshmondiro
\.


--
-- TOC entry 3394 (class 0 OID 16544)
-- Dependencies: 221
-- Data for Name: players_auras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players_auras (player_id, aura_id) FROM stdin;
1	5
2	4
3	7
4	6
5	2
6	3
7	1
8	1
\.


--
-- TOC entry 3395 (class 0 OID 16559)
-- Dependencies: 222
-- Data for Name: players_swords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players_swords (player_id, sword_id) FROM stdin;
1	4
2	8
3	5
4	3
5	6
6	1
7	2
8	1
\.


--
-- TOC entry 3393 (class 0 OID 16537)
-- Dependencies: 220
-- Data for Name: swords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.swords (id, name, rarity, price, player_count, power) FROM stdin;
7	keilos katana	godly	20000	0	500
9	spirit scythe	mythic	350000	0	1000
4	eye scythe	legendary	50000	1	300
8	wrath blade	mythic	500000	1	1000
5	the shadow	legendary	4000	1	300
3	black nichi	rare	70000	1	150
6	zen sword	godly	120000	1	500
2	velvet sword	rare	20000	1	150
1	yellow nichi	rare	60000	2	150
15	Slasher	mythic	25000	0	1000
\.


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 215
-- Name: ауры_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ауры_id_seq"', 7, true);


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 225
-- Name: ауры_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ауры_id_seq1"', 1, false);


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 217
-- Name: игроки_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."игроки_id_seq"', 17, true);


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 223
-- Name: игроки_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."игроки_id_seq1"', 21, true);


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 219
-- Name: мечи_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."мечи_id_seq"', 9, true);


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 224
-- Name: мечи_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."мечи_id_seq1"', 15, true);


--
-- TOC entry 3230 (class 2606 OID 16528)
-- Name: auras ауры_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auras
    ADD CONSTRAINT "ауры_pkey" PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 16535)
-- Name: players игроки_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT "игроки_pkey" PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 16548)
-- Name: players_auras игроки_ауры_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_auras
    ADD CONSTRAINT "игроки_ауры_pkey" PRIMARY KEY (player_id, aura_id);


--
-- TOC entry 3238 (class 2606 OID 16563)
-- Name: players_swords игроки_мечи_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_swords
    ADD CONSTRAINT "игроки_мечи_pkey" PRIMARY KEY (player_id, sword_id);


--
-- TOC entry 3234 (class 2606 OID 16543)
-- Name: swords мечи_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swords
    ADD CONSTRAINT "мечи_pkey" PRIMARY KEY (id);


--
-- TOC entry 3243 (class 2620 OID 16575)
-- Name: players_auras trigger_update_ауры_player_count; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "trigger_update_ауры_player_count" AFTER INSERT OR DELETE ON public.players_auras FOR EACH ROW EXECUTE FUNCTION public."update_ауры_player_count"();


--
-- TOC entry 3244 (class 2620 OID 16577)
-- Name: players_swords trigger_update_мечи_player_count; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "trigger_update_мечи_player_count" AFTER INSERT OR DELETE ON public.players_swords FOR EACH ROW EXECUTE FUNCTION public."update_мечи_player_count"();


--
-- TOC entry 3239 (class 2606 OID 16554)
-- Name: players_auras игроки_ауры_аура_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_auras
    ADD CONSTRAINT "игроки_ауры_аура_id_fkey" FOREIGN KEY (aura_id) REFERENCES public.auras(id);


--
-- TOC entry 3240 (class 2606 OID 16549)
-- Name: players_auras игроки_ауры_игрок_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_auras
    ADD CONSTRAINT "игроки_ауры_игрок_id_fkey" FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- TOC entry 3241 (class 2606 OID 16564)
-- Name: players_swords игроки_мечи_игрок_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_swords
    ADD CONSTRAINT "игроки_мечи_игрок_id_fkey" FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- TOC entry 3242 (class 2606 OID 16569)
-- Name: players_swords игроки_мечи_меч_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_swords
    ADD CONSTRAINT "игроки_мечи_меч_id_fkey" FOREIGN KEY (sword_id) REFERENCES public.swords(id);


-- Completed on 2024-07-16 18:42:49 UTC

--
-- PostgreSQL database dump complete
--

