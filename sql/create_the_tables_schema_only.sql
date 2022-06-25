--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

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
-- Name: answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.answers (
    answer_id integer NOT NULL,
    game_id integer NOT NULL,
    team_id integer NOT NULL,
    user_inst_id integer NOT NULL,
    name_id integer NOT NULL,
    name character varying(40) NOT NULL,
    success integer NOT NULL,
    round integer NOT NULL,
    time_start timestamp without time zone,
    time_finish timestamp without time zone,
    turn_id integer
);


--
-- Name: answers_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.answers ALTER COLUMN answer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.answers_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: default_names; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_names (
    name_id integer NOT NULL,
    name character varying(40) NOT NULL
);


--
-- Name: default_names_name_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.default_names ALTER COLUMN name_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.default_names_name_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    game_name character varying(40) NOT NULL,
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
    date_created timestamp without time zone
);


--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.games ALTER COLUMN game_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.games_game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: mp3_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mp3_order (
    number_stops integer,
    current_stop integer,
    number_starts integer,
    current_start integer
);


--
-- Name: names; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.names (
    name_id integer NOT NULL,
    game_id integer NOT NULL,
    user_inst_id integer NOT NULL,
    name character varying(40) NOT NULL
);


--
-- Name: names_name_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.names ALTER COLUMN name_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.names_name_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: players_turn_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players_turn_order (
    team_id integer,
    players_array integer[],
    number_players integer,
    current_player integer
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    game_id integer NOT NULL,
    team_name character varying(20) NOT NULL,
    round1score integer,
    round2score integer,
    round3score integer,
    round4score integer,
    final_score integer
);


--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.teams ALTER COLUMN team_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.teams_team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: teams_turn_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams_turn_order (
    game_id integer,
    teams_array integer[],
    number_teams integer,
    current_team integer
);


--
-- Name: test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test (
);


--
-- Name: turns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.turns (
    turn_id integer NOT NULL,
    user_inst_id integer NOT NULL,
    game_id integer NOT NULL,
    round integer NOT NULL,
    time_start timestamp without time zone,
    time_finish timestamp without time zone,
    active boolean
);


--
-- Name: turns_turn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.turns ALTER COLUMN turn_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.turns_turn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_instance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_instance (
    user_inst_id integer NOT NULL,
    user_id integer NOT NULL,
    username character varying(16) NOT NULL,
    team_id integer,
    game_id integer NOT NULL,
    round1score integer,
    round2score integer,
    round3score integer,
    round4score integer,
    final_score integer
);


--
-- Name: user_instance_user_inst_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.user_instance ALTER COLUMN user_inst_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_instance_user_inst_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(16) NOT NULL,
    ip_address character varying(24)
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (answer_id);


--
-- Name: default_names default_names_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_names
    ADD CONSTRAINT default_names_pkey PRIMARY KEY (name_id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: names names_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.names
    ADD CONSTRAINT names_pkey PRIMARY KEY (name_id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: turns turns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turns
    ADD CONSTRAINT turns_pkey PRIMARY KEY (turn_id);


--
-- Name: user_instance user_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_instance
    ADD CONSTRAINT user_instance_pkey PRIMARY KEY (user_inst_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO webserver_namegame;


--
-- Name: TABLE answers; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.answers TO webserver_namegame;


--
-- Name: SEQUENCE answers_answer_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,UPDATE ON SEQUENCE public.answers_answer_id_seq TO webserver_namegame;


--
-- Name: TABLE default_names; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.default_names TO webserver_namegame;


--
-- Name: TABLE games; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.games TO webserver_namegame;


--
-- Name: SEQUENCE games_game_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,UPDATE ON SEQUENCE public.games_game_id_seq TO webserver_namegame;


--
-- Name: TABLE mp3_order; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.mp3_order TO webserver_namegame;


--
-- Name: TABLE names; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.names TO webserver_namegame;


--
-- Name: SEQUENCE names_name_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,UPDATE ON SEQUENCE public.names_name_id_seq TO webserver_namegame;


--
-- Name: TABLE players_turn_order; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.players_turn_order TO webserver_namegame;


--
-- Name: TABLE teams; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.teams TO webserver_namegame;


--
-- Name: SEQUENCE teams_team_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,UPDATE ON SEQUENCE public.teams_team_id_seq TO webserver_namegame;


--
-- Name: TABLE teams_turn_order; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.teams_turn_order TO webserver_namegame;


--
-- Name: TABLE turns; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.turns TO webserver_namegame;


--
-- Name: TABLE user_instance; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_instance TO webserver_namegame;


--
-- Name: SEQUENCE user_instance_user_inst_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,UPDATE ON SEQUENCE public.user_instance_user_inst_id_seq TO webserver_namegame;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO webserver_namegame;


--
-- Name: SEQUENCE users_user_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,UPDATE ON SEQUENCE public.users_user_id_seq TO webserver_namegame;


--
-- PostgreSQL database dump complete
--

