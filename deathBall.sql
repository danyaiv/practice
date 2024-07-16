CREATE TABLE IF NOT EXISTS public.auras
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    drop_chance integer,
    player_count integer DEFAULT 0,
    name character varying COLLATE pg_catalog."default",
    CONSTRAINT "ауры_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.auras
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public.players
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nickname character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT "игроки_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.players
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.swords
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(100) COLLATE pg_catalog."default",
    rarity character varying(50) COLLATE pg_catalog."default",
    price integer,
    player_count integer DEFAULT 0,
    power integer,
    CONSTRAINT "мечи_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.swords
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.players_swords
(
    player_id integer NOT NULL,
    sword_id integer NOT NULL,
    CONSTRAINT "игроки_мечи_pkey" PRIMARY KEY (player_id, sword_id),
    CONSTRAINT "игроки_мечи_игрок_id_fkey" FOREIGN KEY (player_id)
        REFERENCES public.players (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "игроки_мечи_меч_id_fkey" FOREIGN KEY (sword_id)
        REFERENCES public.swords (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.players_swords
    OWNER to postgres

CREATE TABLE IF NOT EXISTS public.players_auras
(
    player_id integer NOT NULL,
    aura_id integer NOT NULL,
    CONSTRAINT "игроки_ауры_pkey" PRIMARY KEY (player_id, aura_id),
    CONSTRAINT "игроки_ауры_аура_id_fkey" FOREIGN KEY (aura_id)
        REFERENCES public.auras (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "игроки_ауры_игрок_id_fkey" FOREIGN KEY (player_id)
        REFERENCES public.players (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.players_auras
    OWNER to postgres;
