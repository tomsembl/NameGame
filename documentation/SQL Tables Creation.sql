-- Table: public.games

-- DROP TABLE IF EXISTS public.games;

CREATE TABLE IF NOT EXISTS public.games
(
    game_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    game_name character varying(256) COLLATE pg_catalog."default" NOT NULL,
    active boolean NOT NULL,
    stage integer,
    round integer,
    number_teams integer NOT NULL,
    number_names integer NOT NULL,
    time_limit integer NOT NULL,
    round1 integer,
    round2 integer,
    round3 integer,
    round4 integer,
    date_created timestamp without time zone,
    CONSTRAINT games_pkey PRIMARY KEY (game_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.games
    OWNER to postgres;





-- Table: public.teams

-- DROP TABLE IF EXISTS public.teams;

CREATE TABLE IF NOT EXISTS public.teams
(
    team_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    game_id integer NOT NULL,
    team_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    round1score integer,
    round2score integer,
    round3score integer,
    round4score integer,
    final_score integer,
    CONSTRAINT teams_pkey PRIMARY KEY (team_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.teams
    OWNER to postgres;






-- Table: public.user_instance

-- DROP TABLE IF EXISTS public.user_instance;

CREATE TABLE IF NOT EXISTS public.user_instance
(
    user_inst_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    username character varying(16) COLLATE pg_catalog."default" NOT NULL,
    team_id integer,
    game_id integer NOT NULL,
    round1score integer,
    round2score integer,
    round3score integer,
    round4score integer,
    final_score integer,
    CONSTRAINT user_instance_pkey PRIMARY KEY (user_inst_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_instance
    OWNER to postgres;







-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    user_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    username character varying(16) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;




-- Table: public.answers

-- DROP TABLE IF EXISTS public.answers;

CREATE TABLE IF NOT EXISTS public.answers
(
    answer_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    game_id integer NOT NULL,
    team_id integer NOT NULL,
    user_inst_id integer NOT NULL,
    name_id integer NOT NULL,
    name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    success integer NOT NULL,
    round integer NOT NULL,
    time_start timestamp without time zone,
    time_finish timestamp without time zone,
    CONSTRAINT answers_pkey PRIMARY KEY (answer_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.answers
    OWNER to postgres;







-- Table: public.names

-- DROP TABLE IF EXISTS public.names;

CREATE TABLE IF NOT EXISTS public.names
(
    name_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    game_id integer NOT NULL,
    user_inst_id integer NOT NULL,
    name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT names_pkey PRIMARY KEY (name_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.names
    OWNER to postgres;









    -- Table: public.teams_turn_order

-- DROP TABLE IF EXISTS public.teams_turn_order;

CREATE TABLE IF NOT EXISTS public.teams_turn_order
(
    game_id integer,
    teams_array integer[],
    number_teams integer,
    current_team integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.teams_turn_order
    OWNER to postgres;








    -- Table: public.players_turn_order

-- DROP TABLE IF EXISTS public.players_turn_order;

CREATE TABLE IF NOT EXISTS public.players_turn_order
(
    team_id integer,
    players_array integer[],
    number_players integer,
    current_player integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.players_turn_order
    OWNER to postgres;







    -- Table: public.mp3_order

-- DROP TABLE IF EXISTS public.mp3_order;

CREATE TABLE IF NOT EXISTS public.mp3_order
(
    number_stops integer,
    current_stop integer,
    number_starts integer,
    current_start integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.mp3_order
    OWNER to postgres;




-- MP3 Data standard
INSERT INTO public.mp3_order(
	number_stops, current_stop, number_starts, current_start)
	VALUES (13, 0, 18, 0);



--STATS
--get team totals
	select team_id, count(*) from answers
	where success = 1
	and round = 1 --by round
	group by team_id

-- get player totals
	select user_inst_id, count(*) from answers
	where success = 1
	and round = 1 --by round
	group by user_inst_id

--most flunked names
    select name, count(*) from answers
	where success = 0
	AND GAME_ID = 86
	group by name
	order by count(*) desc
	
--who put in what names
    SELECT NAME, USERNAME,* 
    FROM NAMES N
    JOIN USER_INSTANCE U ON U.USER_INST_ID = N.USER_INST_ID
    ORDER BY NAME_ID DESC

--time taken per answer
    SELECT NAME, USERNAME, DATE_PART('second',TIME_FINISH-time_start) seconds,* FROM ANSWERS A
    JOIN USER_INSTANCE U ON U.USER_INST_ID = A.USER_INST_ID
    WHERE SUCCESS = 1 and
    a.game_id = 86 and
    time_finish is not null
    ORDER BY TIME_FINISH-time_start desc










    -- Table: public.default_names

-- DROP TABLE IF EXISTS public.default_names;

CREATE TABLE IF NOT EXISTS public.default_names
(
    name_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT default_names_pkey PRIMARY KEY (name_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.default_names
    OWNER to postgres;

REVOKE ALL ON TABLE public.default_names FROM webserver_namegame;

GRANT ALL ON TABLE public.default_names TO postgres;

GRANT DELETE, UPDATE, INSERT, SELECT ON TABLE public.default_names TO webserver_namegame;










-- Table: public.turns

-- DROP TABLE IF EXISTS public.turns;

CREATE TABLE IF NOT EXISTS public.turns
(
    turn_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
	user_inst_id integer NOT NULL,
    game_id integer NOT NULL,
	round integer NOT NULL,
    time_start timestamp without time zone,
	time_finish timestamp without time zone,
    CONSTRAINT turns_pkey PRIMARY KEY (turn_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.turns
    OWNER to postgres;

REVOKE ALL ON TABLE public.turns FROM webserver_namegame;

GRANT ALL ON TABLE public.turns TO postgres;

GRANT DELETE, UPDATE, INSERT, SELECT ON TABLE public.turns TO webserver_namegame;
	