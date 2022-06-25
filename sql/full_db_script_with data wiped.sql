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
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: -
--

--
-- Data for Name: default_names; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_names (name_id, name) FROM stdin;
1	Donald Trump
2	Che Guevara
3	Pope Francis
4	Muhammad Ali
5	Jimmy Carter
6	Stephen Hawking
7	Pope John Paul II
8	Mikhail Gorbachev
9	Yuri Gagarin
10	Sylvester Stallone
11	Steve Jobs
12	Freddie Mercury
13	Malcolm X
14	Elvis Presley
15	Bob Marley
16	Fidel Castro
17	Vladimir Putin
18	Neil Armstrong
19	Steven Spielberg
20	Saddam Hussein
21	Bruce Lee
22	Martin Scorsese
23	Pope Benedict XVI
24	John Lennon
25	Prince Philip
26	Ennio Morricone
27	Pablo Escobar
28	Michael Jackson
29	Boris Yeltsin
30	Clint Eastwood
31	Al Pacino
32	Bill Gates
33	Muammar Gaddafi
34	14th Dalai Lama
35	Marlon Brando
36	Yasser Arafat
37	Charles Manson
38	Kim Jong-il
39	Stanley Kubrick
40	Anthony Hopkins
41	Andy Warhol
42	Robert De Niro
43	Luciano Pavarotti
44	Sean Connery
45	Morgan Freeman
46	Jeff Bezos
47	Martin Luther King Jr.
48	Arnold Schwarzenegger
49	Elon Musk
50	Warren Buffett
51	Roman Polanski
52	Jack Nicholson
53	Pol Pot
54	George W. Bush
55	Prince Charles
56	Noam Chomsky
57	Danny DeVito
58	Joe Biden
59	Dustin Hoffman
60	Patrick Swayze
61	Leonard Cohen
62	Elizabeth II
63	Marilyn Monroe
64	Hillary Clinton
65	Anne Frank
66	Margaret Thatcher
67	Cher
68	Audrey Hepburn
69	Angela Merkel
70	Janis Joplin
71	Judy Garland
72	Princess Margaret
73	Tina Turner
74	Meryl Streep
75	Maggie Smith
76	Yoko Ono
77	Grace Kelly
78	Princess Diana
79	Madonna
80	Barbra Streisand
81	Judi Dench
82	Patti Smith
83	Whitney Houston
84	Aretha Franklin
85	Helen Mirren
86	Sigourney Weaver
87	J. K. Rowling
88	Julie Andrews
89	Gwyneth Paltrow
90	Cameron Diaz
91	Sandra Bullock
92	Margaret Atwood
93	Anatoly Dyatlov
94	Angelina Jolie
95	Muhammad
96	Genghis Khan
97	Leonardo da Vinci
98	Isaac Newton
99	Ludwig van Beethoven
100	Alexander the Great
101	Aristotle
102	Napoleon
103	Julius Caesar
104	Wolfgang Amadeus Mozart
105	Plato
106	Jesus
107	Adolf Hitler
108	Galileo Galilei
109	Marco Polo
110	Socrates
111	Johann Sebastian Bach
112	Albert Einstein
113	Michelangelo
114	William Shakespeare
115	Martin Luther
116	Christopher Columbus
117	Moses
118	Archimedes
119	Abraham
120	Sigmund Freud
121	Confucius
122	Vincent van Gogh
123	Nicolaus Copernicus
124	Ferdinand Magellan
125	Gautama Buddha
126	Charles Darwin
127	Karl Marx
128	Immanuel Kant
129	Thomas Jefferson
130	Joseph Stalin
131	Thomas Edison
132	Vladimir Lenin
133	Homer
134	Pablo Picasso
135	Nikola Tesla
136	Antonio Vivaldi
137	Nelson Mandela
138	Friedrich Nietzsche
139	Mahatma Gandhi
140	Frederic Chopin
141	J. R. R. Tolkien
142	Niccola Machiavelli
143	Hans Christian Andersen
144	Charlie Chaplin
145	Salvador Dali
146	Mary, mother of Jesus
147	Joan of Arc
148	Elizabeth I
149	Marie Curie
150	Frida Kahlo
151	Queen Victoria
152	Marie Antoinette
153	Nefertiti
154	Maria Theresa
155	Agatha Christie
156	Mary, Queen of Scots
157	Pocahontas
158	Anne Boleyn
159	Catherine the Great
160	Mary Magdalene
161	Mother Teresa
162	Florence Nightingale
163	Eleanor Roosevelt
164	Cleopatra
165	Coco Chanel
166	Jane Austen
167	Wallis Simpson
168	Maria Montessori
169	Baba Vanga
170	Virginia Woolf
171	Eva Braun
172	Kim Jong-un
173	Novak Djokovic
174	Chris Hemsworth
175	Roger Federer
176	Mark Zuckerberg
177	PewDiePie
178	Prince William
179	Shia LaBeouf
180	Usain Bolt
181	Drake
182	Daniel Radcliffe
183	Edward Snowden
184	Rafael Nadal
185	Lil Wayne
186	Avicii
187	LeBron James
188	Liam Hemsworth
189	Eddie Redmayne
190	Andrew Garfield
191	Rami Malek
192	Justin Timberlake
193	Justin Bieber
194	Donald Glover
195	Robert Pattinson
196	Elijah Wood
197	Rihanna
198	Lady Gaga
199	Natalie Portman
200	Margot Robbie
201	Scarlett Johansson
202	Alicia Keys
203	Anne Hathaway
204	Emma Watson
205	Britney Spears
206	Amy Winehouse
207	Avril Lavigne
208	Keira Knightley
209	Selena Gomez
210	Beyonce
211	Katy Perry
212	Jessica Alba
213	Ariana Grande
214	Jennifer Lawrence
215	Emilia Clarke
216	Gal Gadot
217	Kirsten Dunst
218	Paris Hilton
219	Emma Stone
220	Kristen Stewart
221	Meghan Markle
222	Amber Heard
223	Taylor Swift
224	Kim Yo-jong
225	Lindsay Lohan
226	Megan Fox
227	Miley Cyrus
228	Billie Eilish
229	Mila Kunis
230	Lana Del Rey
231	Greta Thunberg
232	Serena Williams
233	Kylie Jenner
234	Dakota Johnson
235	Nicki Minaj
236	Adele
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: -
--


--
-- Data for Name: mp3_order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.mp3_order (number_stops, current_stop, number_starts, current_start) FROM stdin;
13	2	18	6
\.


--
-- Data for Name: players_turn_order; Type: TABLE DATA; Schema: public; Owner: -
--

--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: -
--

--
-- Data for Name: teams_turn_order; Type: TABLE DATA; Schema: public; Owner: -
--


--
-- Data for Name: turns; Type: TABLE DATA; Schema: public; Owner: -
--


--
-- Data for Name: user_instance; Type: TABLE DATA; Schema: public; Owner: -
--


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--


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

SELECT pg_catalog.setval('public.users_user_id_seq', 114, true);


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

