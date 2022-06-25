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
-- Data for Name: default_names; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (1, 'Donald Trump');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (2, 'Che Guevara');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (3, 'Pope Francis');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (4, 'Muhammad Ali');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (5, 'Jimmy Carter');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (6, 'Stephen Hawking');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (7, 'Pope John Paul II');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (8, 'Mikhail Gorbachev');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (9, 'Yuri Gagarin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (10, 'Sylvester Stallone');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (11, 'Steve Jobs');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (12, 'Freddie Mercury');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (13, 'Malcolm X');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (14, 'Elvis Presley');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (15, 'Bob Marley');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (16, 'Fidel Castro');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (17, 'Vladimir Putin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (18, 'Neil Armstrong');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (19, 'Steven Spielberg');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (20, 'Saddam Hussein');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (21, 'Bruce Lee');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (22, 'Martin Scorsese');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (23, 'Pope Benedict XVI');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (24, 'John Lennon');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (25, 'Prince Philip');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (26, 'Ennio Morricone');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (27, 'Pablo Escobar');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (28, 'Michael Jackson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (29, 'Boris Yeltsin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (30, 'Clint Eastwood');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (31, 'Al Pacino');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (32, 'Bill Gates');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (33, 'Muammar Gaddafi');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (34, '14th Dalai Lama');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (35, 'Marlon Brando');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (36, 'Yasser Arafat');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (37, 'Charles Manson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (38, 'Kim Jong-il');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (39, 'Stanley Kubrick');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (40, 'Anthony Hopkins');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (41, 'Andy Warhol');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (42, 'Robert De Niro');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (43, 'Luciano Pavarotti');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (44, 'Sean Connery');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (45, 'Morgan Freeman');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (46, 'Jeff Bezos');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (47, 'Martin Luther King Jr.');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (48, 'Arnold Schwarzenegger');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (49, 'Elon Musk');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (50, 'Warren Buffett');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (51, 'Roman Polanski');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (52, 'Jack Nicholson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (53, 'Pol Pot');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (54, 'George W. Bush');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (55, 'Prince Charles');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (56, 'Noam Chomsky');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (57, 'Danny DeVito');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (58, 'Joe Biden');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (59, 'Dustin Hoffman');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (60, 'Patrick Swayze');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (61, 'Leonard Cohen');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (62, 'Elizabeth II');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (63, 'Marilyn Monroe');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (64, 'Hillary Clinton');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (65, 'Anne Frank');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (66, 'Margaret Thatcher');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (67, 'Cher');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (68, 'Audrey Hepburn');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (69, 'Angela Merkel');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (70, 'Janis Joplin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (71, 'Judy Garland');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (72, 'Princess Margaret');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (73, 'Tina Turner');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (74, 'Meryl Streep');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (75, 'Maggie Smith');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (76, 'Yoko Ono');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (77, 'Grace Kelly');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (78, 'Princess Diana');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (79, 'Madonna');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (80, 'Barbra Streisand');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (81, 'Judi Dench');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (82, 'Patti Smith');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (83, 'Whitney Houston');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (84, 'Aretha Franklin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (85, 'Helen Mirren');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (86, 'Sigourney Weaver');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (87, 'J. K. Rowling');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (88, 'Julie Andrews');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (89, 'Gwyneth Paltrow');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (90, 'Cameron Diaz');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (91, 'Sandra Bullock');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (92, 'Margaret Atwood');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (93, 'Anatoly Dyatlov');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (94, 'Angelina Jolie');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (95, 'Muhammad');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (96, 'Genghis Khan');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (97, 'Leonardo da Vinci');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (98, 'Isaac Newton');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (99, 'Ludwig van Beethoven');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (100, 'Alexander the Great');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (101, 'Aristotle');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (102, 'Napoleon');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (103, 'Julius Caesar');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (104, 'Wolfgang Amadeus Mozart');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (105, 'Plato');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (106, 'Jesus');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (107, 'Adolf Hitler');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (108, 'Galileo Galilei');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (109, 'Marco Polo');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (110, 'Socrates');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (111, 'Johann Sebastian Bach');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (112, 'Albert Einstein');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (113, 'Michelangelo');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (114, 'William Shakespeare');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (115, 'Martin Luther');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (116, 'Christopher Columbus');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (117, 'Moses');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (118, 'Archimedes');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (119, 'Abraham');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (120, 'Sigmund Freud');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (121, 'Confucius');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (122, 'Vincent van Gogh');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (123, 'Nicolaus Copernicus');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (124, 'Ferdinand Magellan');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (125, 'Gautama Buddha');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (126, 'Charles Darwin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (127, 'Karl Marx');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (128, 'Immanuel Kant');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (129, 'Thomas Jefferson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (130, 'Joseph Stalin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (131, 'Thomas Edison');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (132, 'Vladimir Lenin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (133, 'Homer');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (134, 'Pablo Picasso');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (135, 'Nikola Tesla');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (136, 'Antonio Vivaldi');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (137, 'Nelson Mandela');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (138, 'Friedrich Nietzsche');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (139, 'Mahatma Gandhi');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (140, 'Frederic Chopin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (141, 'J. R. R. Tolkien');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (142, 'Niccola Machiavelli');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (143, 'Hans Christian Andersen');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (144, 'Charlie Chaplin');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (145, 'Salvador Dali');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (146, 'Mary, mother of Jesus');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (147, 'Joan of Arc');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (148, 'Elizabeth I');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (149, 'Marie Curie');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (150, 'Frida Kahlo');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (151, 'Queen Victoria');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (152, 'Marie Antoinette');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (153, 'Nefertiti');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (154, 'Maria Theresa');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (155, 'Agatha Christie');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (156, 'Mary, Queen of Scots');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (157, 'Pocahontas');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (158, 'Anne Boleyn');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (159, 'Catherine the Great');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (160, 'Mary Magdalene');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (161, 'Mother Teresa');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (162, 'Florence Nightingale');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (163, 'Eleanor Roosevelt');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (164, 'Cleopatra');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (165, 'Coco Chanel');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (166, 'Jane Austen');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (167, 'Wallis Simpson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (168, 'Maria Montessori');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (169, 'Baba Vanga');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (170, 'Virginia Woolf');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (171, 'Eva Braun');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (172, 'Kim Jong-un');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (173, 'Novak Djokovic');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (174, 'Chris Hemsworth');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (175, 'Roger Federer');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (176, 'Mark Zuckerberg');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (177, 'PewDiePie');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (178, 'Prince William');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (179, 'Shia LaBeouf');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (180, 'Usain Bolt');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (181, 'Drake');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (182, 'Daniel Radcliffe');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (183, 'Edward Snowden');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (184, 'Rafael Nadal');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (185, 'Lil Wayne');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (186, 'Avicii');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (187, 'LeBron James');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (188, 'Liam Hemsworth');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (189, 'Eddie Redmayne');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (190, 'Andrew Garfield');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (191, 'Rami Malek');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (192, 'Justin Timberlake');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (193, 'Justin Bieber');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (194, 'Donald Glover');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (195, 'Robert Pattinson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (196, 'Elijah Wood');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (197, 'Rihanna');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (198, 'Lady Gaga');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (199, 'Natalie Portman');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (200, 'Margot Robbie');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (201, 'Scarlett Johansson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (202, 'Alicia Keys');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (203, 'Anne Hathaway');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (204, 'Emma Watson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (205, 'Britney Spears');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (206, 'Amy Winehouse');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (207, 'Avril Lavigne');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (208, 'Keira Knightley');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (209, 'Selena Gomez');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (210, 'Beyonce');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (211, 'Katy Perry');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (212, 'Jessica Alba');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (213, 'Ariana Grande');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (214, 'Jennifer Lawrence');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (215, 'Emilia Clarke');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (216, 'Gal Gadot');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (217, 'Kirsten Dunst');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (218, 'Paris Hilton');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (219, 'Emma Stone');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (220, 'Kristen Stewart');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (221, 'Meghan Markle');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (222, 'Amber Heard');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (223, 'Taylor Swift');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (224, 'Kim Yo-jong');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (225, 'Lindsay Lohan');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (226, 'Megan Fox');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (227, 'Miley Cyrus');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (228, 'Billie Eilish');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (229, 'Mila Kunis');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (230, 'Lana Del Rey');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (231, 'Greta Thunberg');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (232, 'Serena Williams');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (233, 'Kylie Jenner');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (234, 'Dakota Johnson');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (235, 'Nicki Minaj');
INSERT INTO public.default_names OVERRIDING SYSTEM VALUE VALUES (236, 'Adele');



--
-- Data for Name: mp3_order; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.mp3_order VALUES (13, 2, 18, 6);



--
-- Name: answers_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.answers_answer_id_seq', 1724, true);


--
-- Name: default_names_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.default_names_name_id_seq', 236, true);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.games_game_id_seq', 86, true);


--
-- Name: names_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.names_name_id_seq', 602, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 329, true);


--
-- Name: turns_turn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.turns_turn_id_seq', 142, true);


--
-- Name: user_instance_user_inst_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_instance_user_inst_id_seq', 294, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 115, true);


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

