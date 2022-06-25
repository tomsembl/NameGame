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

COPY public.answers (answer_id, game_id, team_id, user_inst_id, name_id, name, success, round, time_start, time_finish, turn_id) FROM stdin;
1133	79	312	255	438	Vincent van Gogh	1	1	\N	2022-06-19 22:46:41.525269	\N
1134	79	312	255	441	Julie Andrews	1	1	\N	2022-06-19 22:46:54.526249	\N
1135	79	312	255	433	Lady Gaga	0	1	\N	2022-06-19 22:47:28.513474	\N
1147	79	313	254	436	Yuri Gagarin	1	1	2022-06-19 23:03:47.958623	2022-06-19 23:03:48.946166	12
1148	79	313	254	437	Pol Pot	1	1	2022-06-19 23:03:48.946166	2022-06-19 23:03:51.325049	12
1149	79	312	255	437	Pol Pot	1	2	2022-06-19 23:04:19.495984	2022-06-19 23:04:20.859232	13
1150	79	312	255	436	Yuri Gagarin	1	2	2022-06-19 23:04:20.859232	2022-06-19 23:04:22.062051	13
1151	79	312	255	434	Drake	1	2	2022-06-19 23:04:22.062051	2022-06-19 23:04:23.251347	13
1152	79	312	255	435	Archimedes	1	2	2022-06-19 23:04:23.251347	2022-06-19 23:04:24.42173	13
1153	79	312	255	440	Warren Buffett	0	2	2022-06-19 23:04:24.42173	2022-06-19 23:04:25.578201	13
1154	79	313	254	438	Vincent van Gogh	1	2	2022-06-19 23:04:31.554822	2022-06-19 23:04:32.346703	14
1155	79	313	254	431	Shia LaBeouf	1	2	2022-06-19 23:04:32.346703	2022-06-19 23:04:33.359999	14
1156	79	313	254	439	Gal Gadot	1	2	2022-06-19 23:04:33.359999	2022-06-19 23:04:34.716391	14
1157	79	313	254	432	Pope Francis	1	2	2022-06-19 23:04:34.716391	2022-06-19 23:04:35.972539	14
1158	79	313	254	440	Warren Buffett	0	2	2022-06-19 23:04:35.972539	2022-06-19 23:04:37.715951	14
1186	79	312	255	433	Lady Gaga	1	4	2022-06-19 23:40:23.623774	2022-06-19 23:40:25.908778	22
1187	79	312	255	432	Pope Francis	1	4	2022-06-19 23:40:25.908778	2022-06-19 23:40:31.276777	22
1252	81	316	270	512	Nelson Mandela 	0	2	2022-06-20 20:51:29.050768	2022-06-20 20:51:31.213958	34
1253	81	317	266	523	Ludwig van Beethoven	1	2	2022-06-20 20:52:19.118174	2022-06-20 20:52:32.573265	35
1254	81	317	266	525	Julius caesar	1	2	2022-06-20 20:52:32.573265	2022-06-20 20:52:55.34738	35
1255	81	317	266	484	Sia	1	2	2022-06-20 20:52:55.34738	2022-06-20 20:53:05.628756	35
1256	81	317	266	499	Alex jones	1	2	2022-06-20 20:53:05.628756	2022-06-20 20:53:14.491677	35
1257	81	317	266	505	King Henry VIII	0	2	2022-06-20 20:53:14.491677	2022-06-20 20:53:19.127584	35
1258	81	316	269	501	Jake the dog	1	2	2022-06-20 20:54:10.810198	2022-06-20 20:54:40.401625	36
1259	81	316	269	488	Michael Jackson	1	2	2022-06-20 20:54:40.401625	2022-06-20 20:54:45.460557	36
1260	81	316	269	522	Amy winehouse	1	2	2022-06-20 20:54:45.460557	2022-06-20 20:54:56.200105	36
1261	81	316	269	491	George Harrison	1	2	2022-06-20 20:54:56.200105	2022-06-20 20:55:00.528729	36
1262	81	316	269	509	Elvis	1	2	2022-06-20 20:55:00.528729	2022-06-20 20:55:08.843869	36
1263	81	316	269	515	Pele	0	2	2022-06-20 20:55:08.843869	2022-06-20 20:55:10.864864	36
1264	81	316	263	498	Rick Sanchez	0	2	2022-06-20 20:56:20.681454	2022-06-20 20:56:21.056888	37
1265	81	317	268	508	Harold Holt	1	2	2022-06-20 20:56:33.994949	2022-06-20 20:56:40.677439	38
1266	81	317	268	520	Vincent van gogh	1	2	2022-06-20 20:56:40.677439	2022-06-20 20:56:48.47178	38
1267	81	317	268	495	Bolsonaro	0	2	2022-06-20 20:56:48.47178	2022-06-20 20:57:34.004014	38
1268	81	316	270	506	Jane Austen	1	2	2022-06-20 20:57:49.096536	2022-06-20 20:58:45.300928	39
1269	81	316	270	515	Pele	0	2	2022-06-20 20:58:45.300928	2022-06-20 20:58:49.160213	39
1270	81	317	266	494	Nelson Mandela	1	2	2022-06-20 20:59:00.605555	2022-06-20 20:59:05.278087	40
1271	81	317	266	507	Ned Kelly	1	2	2022-06-20 20:59:05.278087	2022-06-20 20:59:09.24734	40
1272	81	317	266	495	Bolsonaro	0	2	2022-06-20 20:59:09.24734	2022-06-20 21:00:00.610879	40
1273	81	316	269	496	Satoshi Nakamoto	1	2	2022-06-20 21:01:44.651	2022-06-20 21:01:56.062037	41
1274	81	316	269	515	Pele	1	2	2022-06-20 21:01:56.062037	2022-06-20 21:02:01.034225	41
1275	81	316	269	497	J. R. R. Tolkein	1	2	2022-06-20 21:02:01.034225	2022-06-20 21:02:04.692059	41
1276	81	316	269	510	Marie Antoinette	1	2	2022-06-20 21:02:04.692059	2022-06-20 21:02:18.815463	41
1277	81	316	269	517	Aristotle	1	2	2022-06-20 21:02:18.815463	2022-06-20 21:02:34.782379	41
1278	81	316	269	505	King Henry VIII	1	2	2022-06-20 21:02:34.782379	2022-06-20 21:02:40.14155	41
1279	81	316	269	498	Rick Sanchez	0	2	2022-06-20 21:02:40.14155	2022-06-20 21:02:44.671415	41
1280	81	316	263	487	Whitney Huston 	1	2	2022-06-20 21:03:47.500765	2022-06-20 21:04:46.974738	42
1281	81	316	263	512	Nelson Mandela 	0	2	2022-06-20 21:04:46.974738	2022-06-20 21:04:47.48716	42
1282	81	317	268	492	Karl Marx	0	2	2022-06-20 21:05:10.462723	2022-06-20 21:06:32.903839	43
1283	81	316	270	485	Beyonce 	1	2	2022-06-20 21:07:37.680887	2022-06-20 21:07:55.425884	44
1284	81	316	270	502	Colonel Sanders	1	2	2022-06-20 21:07:55.425884	2022-06-20 21:08:11.595131	44
1285	81	316	270	511	Ryan Reynolds	1	2	2022-06-20 21:08:11.595131	2022-06-20 21:08:22.984646	44
1286	81	316	270	512	Nelson Mandela 	1	2	2022-06-20 21:08:22.984646	2022-06-20 21:08:28.844716	44
1287	81	316	270	504	Kevin Parker	0	2	2022-06-20 21:08:28.844716	2022-06-20 21:08:37.75274	44
1288	81	317	266	495	Bolsonaro	1	2	2022-06-20 21:09:07.616121	2022-06-20 21:09:12.777936	45
1289	81	317	266	503	A minion	0	2	2022-06-20 21:09:12.777936	2022-06-20 21:10:07.628868	45
1290	81	316	269	498	Rick Sanchez	1	2	2022-06-20 21:12:19.193928	2022-06-20 21:12:25.993369	46
1291	81	316	269	503	A minion	1	2	2022-06-20 21:12:25.993369	2022-06-20 21:12:33.353313	46
1292	81	316	269	486	Rihanna	1	2	2022-06-20 21:12:33.353313	2022-06-20 21:12:42.360088	46
1293	81	316	269	521	Cleopatra	1	2	2022-06-20 21:12:42.360088	2022-06-20 21:13:06.272702	46
1294	81	316	269	492	Karl Marx	0	2	2022-06-20 21:13:06.272702	2022-06-20 21:13:19.311423	46
1295	81	317	268	492	Karl Marx	1	2	2022-06-20 21:15:00.796218	2022-06-20 21:15:07.536926	47
1296	81	317	268	504	Kevin Parker	0	2	2022-06-20 21:15:07.536926	2022-06-20 21:16:00.803739	47
1297	81	316	263	504	Kevin Parker	1	2	2022-06-20 21:18:35.226806	2022-06-20 21:18:49.747854	48
1298	81	317	268	491	George Harrison	1	3	2022-06-20 21:19:23.427807	2022-06-20 21:20:08.051339	49
1299	81	317	268	495	Bolsonaro	1	3	2022-06-20 21:20:08.051339	2022-06-20 21:20:15.279787	49
1300	81	317	268	523	Ludwig van Beethoven	1	3	2022-06-20 21:20:15.279787	2022-06-20 21:20:21.269668	49
1301	81	317	268	502	Colonel Sanders	0	3	2022-06-20 21:20:21.269668	2022-06-20 21:20:23.428811	49
1302	81	316	270	492	Karl Marx	1	3	2022-06-20 21:20:38.66697	2022-06-20 21:20:46.118752	50
1303	81	316	270	508	Harold Holt	1	3	2022-06-20 21:20:46.118752	2022-06-20 21:21:03.650584	50
1304	81	316	270	507	Ned Kelly	1	3	2022-06-20 21:21:03.650584	2022-06-20 21:21:13.118142	50
1305	81	316	270	484	Sia	1	3	2022-06-20 21:21:13.118142	2022-06-20 21:21:17.699802	50
1306	81	316	270	505	King Henry VIII	1	3	2022-06-20 21:21:17.699802	2022-06-20 21:21:28.072418	50
1307	81	316	270	519	Karl kruzulnitsky	1	3	2022-06-20 21:21:28.072418	2022-06-20 21:21:35.041641	50
1308	81	316	270	518	Greta Thunberg	0	3	2022-06-20 21:21:35.041641	2022-06-20 21:21:57.423956	50
1309	81	317	266	485	Beyonce 	1	3	2022-06-20 21:23:34.564227	2022-06-20 21:23:43.960962	51
1310	81	317	266	496	Satoshi Nakamoto	1	3	2022-06-20 21:23:43.960962	2022-06-20 21:23:50.600654	51
1311	81	317	266	489	Lady Gaga	0	3	2022-06-20 21:23:50.600654	2022-06-20 21:24:34.580428	51
1312	81	317	264	503	A minion	1	3	2022-06-20 21:27:13.174505	2022-06-20 21:27:23.312478	53
1313	81	317	264	506	Jane Austen	1	3	2022-06-20 21:27:23.312478	2022-06-20 21:27:45.429364	53
1314	81	317	264	500	George Washington	1	3	2022-06-20 21:27:45.429364	2022-06-20 21:27:55.880932	53
1315	81	317	264	501	Jake the dog	1	3	2022-06-20 21:27:55.880932	2022-06-20 21:28:02.690694	53
1316	81	317	264	487	Whitney Huston 	1	3	2022-06-20 21:28:02.690694	2022-06-20 21:28:08.727874	53
1317	81	317	264	497	J. R. R. Tolkein	0	3	2022-06-20 21:28:08.727874	2022-06-20 21:28:13.175008	53
1318	81	316	263	516	Bob Marley	1	3	2022-06-20 21:28:28.991587	2022-06-20 21:28:36.198507	54
1319	81	316	263	490	Celine Dion	1	3	2022-06-20 21:28:36.198507	2022-06-20 21:28:53.477272	54
1136	79	313	254	439	Gal Gadot	1	1	\N	2022-06-19 22:52:14.820353	8
1137	79	313	254	435	Archimedes	1	1	\N	2022-06-19 22:52:17.421593	8
1138	79	313	254	440	Warren Buffett	0	1	\N	2022-06-19 22:52:18.780526	8
1139	79	312	255	433	Lady Gaga	1	1	\N	2022-06-19 22:52:24.217819	9
1140	79	312	255	431	Shia LaBeouf	1	1	\N	2022-06-19 22:52:26.430307	9
1141	79	312	255	434	Drake	1	1	\N	2022-06-19 22:52:30.494514	9
1142	79	312	255	437	Pol Pot	0	1	\N	2022-06-19 22:52:31.854671	9
1143	79	313	254	432	Pope Francis	1	1	\N	2022-06-19 22:52:38.438818	10
1144	79	313	254	437	Pol Pot	0	1	\N	2022-06-19 22:52:39.744026	10
1159	79	312	255	441	Julie Andrews	1	2	2022-06-19 23:09:16.511109	2022-06-19 23:09:17.543956	15
1160	79	312	255	440	Warren Buffett	1	2	2022-06-19 23:09:17.543956	2022-06-19 23:09:27.797235	15
1161	79	312	255	433	Lady Gaga	1	2	2022-06-19 23:09:27.797235	2022-06-19 23:09:32.768581	15
1162	79	313	254	434	Drake	1	3	2022-06-19 23:09:42.091615	2022-06-19 23:09:43.414112	16
1163	79	313	254	433	Lady Gaga	1	3	2022-06-19 23:09:43.414112	2022-06-19 23:09:44.947521	16
1164	79	313	254	441	Julie Andrews	1	3	2022-06-19 23:09:44.947521	2022-06-19 23:09:46.267889	16
1165	79	313	254	440	Warren Buffett	1	3	2022-06-19 23:09:46.267889	2022-06-19 23:09:47.721899	16
1166	79	313	254	436	Yuri Gagarin	1	3	2022-06-19 23:09:47.721899	2022-06-19 23:09:49.156946	16
1167	79	313	254	438	Vincent van Gogh	1	3	2022-06-19 23:09:49.156946	2022-06-19 23:09:51.693723	16
1168	79	313	254	432	Pope Francis	1	3	2022-06-19 23:09:51.693723	2022-06-19 23:09:53.9057	16
1169	79	313	254	439	Gal Gadot	0	3	2022-06-19 23:09:53.9057	2022-06-19 23:09:56.14806	16
1188	81	317	266	507	Ned Kelly	1	1	2022-06-20 20:17:06.936375	2022-06-20 20:17:51.875165	23
1189	81	317	266	493	Jesus	1	1	2022-06-20 20:17:51.875165	2022-06-20 20:17:58.105124	23
1190	81	317	266	488	Michael Jackson	1	1	2022-06-20 20:17:58.105124	2022-06-20 20:18:02.534362	23
1191	81	317	266	520	Vincent van gogh	0	1	2022-06-20 20:18:02.534362	2022-06-20 20:18:06.929241	23
1192	81	316	269	498	Rick Sanchez	1	1	2022-06-20 20:18:31.318789	2022-06-20 20:19:09.642553	24
1193	81	316	269	508	Harold Holt	1	1	2022-06-20 20:19:09.642553	2022-06-20 20:19:18.791695	24
1194	81	316	269	512	Nelson Mandela 	1	1	2022-06-20 20:19:18.791695	2022-06-20 20:19:28.422718	24
1195	81	316	269	515	Pele	0	1	2022-06-20 20:19:28.422718	2022-06-20 20:19:31.322356	24
1196	81	317	264	490	Celine Dion	1	1	2022-06-20 20:19:46.97664	2022-06-20 20:19:52.974364	25
1197	81	317	264	520	Vincent van gogh	1	1	2022-06-20 20:19:52.974364	2022-06-20 20:19:59.002218	25
1198	81	317	264	513	Vincent Van Gogh 	1	1	2022-06-20 20:19:59.002218	2022-06-20 20:20:06.331936	25
1199	81	317	264	499	Alex jones	1	1	2022-06-20 20:20:06.331936	2022-06-20 20:20:24.284676	25
1200	81	317	264	523	Ludwig van Beethoven	0	1	2022-06-20 20:20:24.284676	2022-06-20 20:20:47.126727	25
1201	81	316	263	486	Rihanna	1	1	2022-06-20 20:21:02.640479	2022-06-20 20:21:21.848794	26
1202	81	316	263	509	Elvis	1	1	2022-06-20 20:21:21.848794	2022-06-20 20:21:32.224789	26
1203	81	316	263	521	Cleopatra	1	1	2022-06-20 20:21:32.224789	2022-06-20 20:21:36.739123	26
1204	81	316	263	511	Ryan Reynolds	0	1	2022-06-20 20:21:36.739123	2022-06-20 20:22:02.656116	26
1205	81	317	268	519	Karl kruzulnitsky	1	1	2022-06-20 20:22:17.560355	2022-06-20 20:22:28.622864	27
1206	81	317	268	516	Bob Marley	1	1	2022-06-20 20:22:28.622864	2022-06-20 20:22:58.436252	27
1207	81	317	268	503	A minion	1	1	2022-06-20 20:22:58.436252	2022-06-20 20:23:09.190814	27
1208	81	317	268	485	Beyonce 	0	1	2022-06-20 20:23:09.190814	2022-06-20 20:23:38.026634	27
1209	81	316	270	524	Twiggy forrest	1	1	2022-06-20 20:24:01.987567	2022-06-20 20:24:10.040506	28
1210	81	316	270	511	Ryan Reynolds	1	1	2022-06-20 20:24:10.040506	2022-06-20 20:24:21.400254	28
1211	81	316	270	494	Nelson Mandela	1	1	2022-06-20 20:24:21.400254	2022-06-20 20:24:24.779908	28
1212	81	316	270	497	J. R. R. Tolkein	1	1	2022-06-20 20:24:24.779908	2022-06-20 20:24:28.620886	28
1213	81	316	270	487	Whitney Huston 	1	1	2022-06-20 20:24:28.620886	2022-06-20 20:24:45.35777	28
1214	81	316	270	484	Sia	1	1	2022-06-20 20:24:45.35777	2022-06-20 20:24:53.790386	28
1215	81	316	270	518	Greta Thunberg	1	1	2022-06-20 20:24:53.790386	2022-06-20 20:25:01.899756	28
1216	81	316	270	495	Bolsonaro	0	1	2022-06-20 20:25:01.899756	2022-06-20 20:25:01.984129	28
1217	81	317	266	525	Julius caesar	1	1	2022-06-20 20:25:29.508877	2022-06-20 20:25:40.567737	29
1218	81	317	266	525	Julius caesar	1	1	2022-06-20 20:25:40.567737	2022-06-20 20:25:46.521397	29
1219	81	317	266	525	Julius caesar	1	1	2022-06-20 20:25:46.521397	2022-06-20 20:25:46.526344	29
1220	81	317	266	502	Colonel Sanders	0	1	2022-06-20 20:25:46.526344	2022-06-20 20:26:29.532018	29
1221	81	317	266	500	George Washington	1	1	2022-06-20 20:31:19.990005	2022-06-20 20:31:32.966517	30
1222	81	317	266	495	Bolsonaro	1	1	2022-06-20 20:31:32.966517	2022-06-20 20:31:34.541164	30
1223	81	317	266	505	King Henry VIII	1	1	2022-06-20 20:31:34.541164	2022-06-20 20:31:36.062499	30
1224	81	317	266	517	Aristotle	1	1	2022-06-20 20:31:36.062499	2022-06-20 20:31:37.409863	30
1225	81	317	266	504	Kevin Parker	1	1	2022-06-20 20:31:37.409863	2022-06-20 20:31:38.494416	30
1226	81	317	266	491	George Harrison	1	1	2022-06-20 20:31:38.494416	2022-06-20 20:31:39.626444	30
1227	81	317	266	496	Satoshi Nakamoto	1	1	2022-06-20 20:31:39.626444	2022-06-20 20:31:40.70524	30
1228	81	317	266	506	Jane Austen	1	1	2022-06-20 20:31:40.70524	2022-06-20 20:31:41.748465	30
1229	81	317	266	515	Pele	1	1	2022-06-20 20:31:41.748465	2022-06-20 20:31:42.61921	30
1230	81	317	266	510	Marie Antoinette	1	1	2022-06-20 20:31:42.61921	2022-06-20 20:31:43.413355	30
1231	81	317	266	489	Lady Gaga	1	1	2022-06-20 20:31:43.413355	2022-06-20 20:31:44.241181	30
1232	81	317	266	514	Shakespeare 	1	1	2022-06-20 20:31:44.241181	2022-06-20 20:31:45.042649	30
1233	81	317	266	492	Karl Marx	1	1	2022-06-20 20:31:45.042649	2022-06-20 20:31:47.750671	30
1234	81	317	266	522	Amy winehouse	1	1	2022-06-20 20:31:47.750671	2022-06-20 20:31:49.047057	30
1235	81	317	266	502	Colonel Sanders	1	1	2022-06-20 20:31:49.047057	2022-06-20 20:31:52.680149	30
1236	81	317	266	501	Jake the dog	1	1	2022-06-20 20:31:52.680149	2022-06-20 20:31:53.729087	30
1237	81	317	266	485	Beyonce 	1	1	2022-06-20 20:31:53.729087	2022-06-20 20:31:54.439552	30
1238	81	317	266	523	Ludwig van Beethoven	1	1	2022-06-20 20:31:54.439552	2022-06-20 20:31:56.542414	30
1239	81	316	269	519	Karl kruzulnitsky	1	2	2022-06-20 20:38:50.405382	2022-06-20 20:39:03.394254	31
1240	81	316	269	518	Greta Thunberg	1	2	2022-06-20 20:39:03.394254	2022-06-20 20:39:08.756863	31
1241	81	316	269	514	Shakespeare 	1	2	2022-06-20 20:39:08.756863	2022-06-20 20:39:14.476162	31
262	29	209	162	179	Scomo	1	1	\N	\N	\N
263	29	209	162	208	Britney Spears 	1	1	\N	\N	\N
264	29	209	162	177	Donald Trump	1	1	\N	\N	\N
265	29	209	162	183	Picasso	1	1	\N	\N	\N
266	29	209	162	212	Kylie Jenner 	0	1	\N	\N	\N
267	29	210	164	185	Pepe the frog	1	1	\N	\N	\N
268	29	210	164	192	Anthea	0	1	\N	\N	\N
269	29	209	166	188	Arnold Schwarzenegger	1	1	\N	\N	\N
270	29	209	166	184	Tony Abbott	1	1	\N	\N	\N
271	29	209	166	213	The Pope 	1	1	\N	\N	\N
272	29	209	166	175	Amber Heard	1	1	\N	\N	\N
273	29	209	166	178	Justin Beiber	1	1	\N	\N	\N
274	29	209	166	198	Hillary clinton	0	1	\N	\N	\N
275	29	210	167	204	Tom cruise	1	1	\N	\N	\N
276	29	210	167	187	Bolsonaro	1	1	\N	\N	\N
277	29	210	167	211	Boris Johnson 	1	1	\N	\N	\N
278	29	210	167	210	Donald Trump 	1	1	\N	\N	\N
279	29	210	167	181	Albanese	0	1	\N	\N	\N
280	29	209	165	194	Donald trump	1	1	\N	\N	\N
281	29	209	165	202	Fred Flintstone 	1	1	\N	\N	\N
282	29	209	165	207	Mark twain	0	1	\N	\N	\N
283	29	210	164	203	Sponge bob	1	1	\N	\N	\N
284	29	210	164	190	Hugo Innes	1	1	\N	\N	\N
285	29	210	164	205	Ànthony albonese	1	1	\N	\N	\N
286	29	210	164	189	Josh Frydenberg	0	1	\N	\N	\N
287	29	209	162	197	Monalisa	1	1	\N	\N	\N
288	29	209	162	192	Anthea	1	1	\N	\N	\N
289	29	209	162	176	Johnny Depp	1	1	\N	\N	\N
290	29	209	162	180	Peter Dutton	0	1	\N	\N	\N
291	29	210	167	195	Iron man	1	1	\N	\N	\N
292	29	210	167	189	Josh Frydenberg	1	1	\N	\N	\N
293	29	210	167	200	Tom cruise	1	1	\N	\N	\N
294	29	210	167	199	Gladys	0	1	\N	\N	\N
295	29	209	166	201	Eva	1	1	\N	\N	\N
296	29	209	166	174	Tom cruise	1	1	\N	\N	\N
297	29	209	166	196	Madonna	1	1	\N	\N	\N
298	29	209	166	186	Donald Trump	1	1	\N	\N	\N
299	29	209	166	209	Justin Beiber 	1	1	\N	\N	\N
300	29	209	166	193	Barack Obama	0	1	\N	\N	\N
301	29	210	164	180	Peter Dutton	1	1	\N	\N	\N
302	29	210	164	181	Albanese	1	1	\N	\N	\N
303	29	210	164	198	Hillary clinton	1	1	\N	\N	\N
304	29	210	164	207	Mark twain	1	1	\N	\N	\N
305	29	210	164	193	Barack Obama	0	1	\N	\N	\N
306	29	209	165	191	Harry Manson	1	1	\N	\N	\N
307	29	209	165	199	Gladys	1	1	\N	\N	\N
308	29	209	165	206	Michael jordan	1	1	\N	\N	\N
309	29	209	165	193	Barack Obama	1	1	\N	\N	\N
310	29	209	165	212	Kylie Jenner 	1	1	\N	\N	\N
311	29	209	165	182	Queen Elizabeth	1	1	\N	\N	\N
312	29	210	167	192	Anthea	1	2	\N	\N	\N
313	29	210	167	187	Bolsonaro	1	2	\N	\N	\N
314	29	210	167	210	Donald Trump 	1	2	\N	\N	\N
315	29	210	167	175	Amber Heard	1	2	\N	\N	\N
316	29	210	167	184	Tony Abbott	0	2	\N	\N	\N
317	29	209	162	179	Scomo	1	2	\N	\N	\N
318	29	209	162	177	Donald Trump	1	2	\N	\N	\N
319	29	209	162	205	Ànthony albonese	1	2	\N	\N	\N
320	29	209	162	204	Tom cruise	1	2	\N	\N	\N
321	29	209	162	201	Eva	0	2	\N	\N	\N
322	29	210	164	182	Queen Elizabeth	1	2	\N	\N	\N
323	29	210	164	212	Kylie Jenner 	1	2	\N	\N	\N
324	29	210	164	198	Hillary clinton	1	2	\N	\N	\N
325	29	210	164	195	Iron man	1	2	\N	\N	\N
326	29	210	164	208	Britney Spears 	0	2	\N	\N	\N
327	29	209	166	208	Britney Spears 	1	2	\N	\N	\N
328	29	209	166	209	Justin Beiber 	1	2	\N	\N	\N
329	29	209	166	176	Johnny Depp	1	2	\N	\N	\N
330	29	209	166	206	Michael jordan	1	2	\N	\N	\N
331	29	209	166	211	Boris Johnson 	1	2	\N	\N	\N
332	29	209	166	201	Eva	1	2	\N	\N	\N
333	29	209	166	199	Gladys	1	2	\N	\N	\N
334	29	209	166	185	Pepe the frog	0	2	\N	\N	\N
335	29	210	167	189	Josh Frydenberg	1	2	\N	\N	\N
336	29	210	167	180	Peter Dutton	1	2	\N	\N	\N
337	29	210	167	197	Monalisa	1	2	\N	\N	\N
338	29	210	167	174	Tom cruise	1	2	\N	\N	\N
339	29	210	167	200	Tom cruise	1	2	\N	\N	\N
340	29	210	167	181	Albanese	1	2	\N	\N	\N
341	29	210	167	186	Donald Trump	1	2	\N	\N	\N
342	29	210	167	185	Pepe the frog	1	2	\N	\N	\N
343	29	210	167	184	Tony Abbott	1	2	\N	\N	\N
344	29	210	167	196	Madonna	1	2	\N	\N	\N
345	29	210	167	207	Mark twain	1	2	\N	\N	\N
346	29	210	167	203	Sponge bob	1	2	\N	\N	\N
347	29	210	167	194	Donald trump	1	2	\N	\N	\N
348	29	210	167	183	Picasso	0	2	\N	\N	\N
349	29	209	165	213	The Pope 	1	2	\N	\N	\N
350	29	209	165	191	Harry Manson	1	2	\N	\N	\N
351	29	209	165	188	Arnold Schwarzenegger	1	2	\N	\N	\N
352	29	209	165	202	Fred Flintstone 	1	2	\N	\N	\N
353	29	209	165	178	Justin Beiber	1	2	\N	\N	\N
354	29	209	165	193	Barack Obama	1	2	\N	\N	\N
355	29	209	165	183	Picasso	0	2	\N	\N	\N
356	29	210	164	190	Hugo Innes	1	2	\N	\N	\N
357	29	210	164	183	Picasso	1	2	\N	\N	\N
358	30	211	170	253	Queen victoria	1	1	\N	\N	\N
359	30	211	170	262	Ringo Starr	0	1	\N	\N	\N
360	30	212	168	254	Adolf Hitler	1	1	\N	\N	\N
361	30	212	168	229	Mickey mouse	1	1	\N	\N	\N
362	30	212	168	219	Seth McFarlane	0	1	\N	\N	\N
363	30	211	169	264	Elon Musk	1	1	\N	\N	\N
364	30	211	169	240	Mick jagger	0	1	\N	\N	\N
365	30	212	172	262	Ringo Starr	1	1	\N	\N	\N
366	30	212	172	265	Ivanka Trump	1	1	\N	\N	\N
367	30	212	172	255	Smeagol / Gollum	1	1	\N	\N	\N
368	30	212	172	214	Harry Potter	1	1	\N	\N	\N
369	30	212	172	235	Auntie pauline	1	1	\N	\N	\N
370	30	212	172	237	Princess margaret	1	1	\N	\N	\N
371	30	212	172	217	Mel Gibson	0	1	\N	\N	\N
372	30	211	171	246	Adele	1	1	\N	\N	\N
373	30	211	171	227	Ted	1	1	\N	\N	\N
374	30	211	171	268	Steve Jobs	1	1	\N	\N	\N
375	30	211	171	251	Ramses II	1	1	\N	\N	\N
376	30	211	171	258	Vladimir Putin	1	1	\N	\N	\N
377	30	211	171	242	Kim kardashian	0	1	\N	\N	\N
378	30	211	171	242	Kim kardashian	1	1	\N	\N	\N
379	30	212	173	233	Putin	1	1	\N	\N	\N
380	30	212	173	223	Santa Clause	1	1	\N	\N	\N
381	30	212	173	260	Helena Bonham Carter	1	1	\N	\N	\N
382	30	212	173	241	Kate bush	1	1	\N	\N	\N
383	30	212	173	263	Alan Rickman	1	1	\N	\N	\N
384	30	212	173	256	Jaimie Lannister	0	1	\N	\N	\N
385	30	211	170	247	Gandalf	1	1	\N	\N	\N
386	30	211	170	267	George Bush	1	1	\N	\N	\N
387	30	211	170	225	Rob	1	1	\N	\N	\N
388	30	211	170	219	Seth McFarlane	1	1	\N	\N	\N
389	30	211	170	270	Julia Gillard	1	1	\N	\N	\N
390	30	211	170	248	Dyanerys	0	1	\N	\N	\N
391	30	212	168	221	Shrek	1	1	\N	\N	\N
392	30	212	168	218	Justin Timberlake	1	1	\N	\N	\N
393	30	212	168	266	Kate Bush	1	1	\N	\N	\N
394	30	212	168	271	Bill Gates	1	1	\N	\N	\N
395	30	212	168	249	Lady Di	1	1	\N	\N	\N
396	30	212	168	250	Einsten	1	1	\N	\N	\N
397	30	212	168	224	Jacinta Ardern	0	1	\N	\N	\N
398	30	211	169	217	Mel Gibson	1	1	\N	\N	\N
399	30	211	169	240	Mick jagger	1	1	\N	\N	\N
400	30	211	169	272	Mark McGowan	1	1	\N	\N	\N
401	30	211	169	231	George bush	1	1	\N	\N	\N
402	30	211	169	234	Mark mcgowan	1	1	\N	\N	\N
403	30	211	169	230	Osama bin Laden 	1	1	\N	\N	\N
404	30	211	169	261	Dwayne "the rock" johnson	1	1	\N	\N	\N
405	30	211	169	238	Prince andrew	0	1	\N	\N	\N
406	30	212	172	245	Cheer	1	1	\N	\N	\N
407	30	212	172	220	Homer Simpson	1	1	\N	\N	\N
408	30	212	172	239	King george IV	1	1	\N	\N	\N
409	30	212	172	248	Dyanerys	0	1	\N	\N	\N
410	30	211	171	248	Dyanerys	1	1	\N	\N	\N
411	30	211	171	273	Sting (singer)	1	1	\N	\N	\N
412	30	211	171	222	Prince Andrew	1	1	\N	\N	\N
413	30	211	171	238	Prince andrew	1	1	\N	\N	\N
414	30	211	171	215	Julia Gillard 	1	1	\N	\N	\N
415	30	211	171	259	Zelensky	0	1	\N	\N	\N
416	30	212	173	224	Jacinta Ardern	0	1	\N	\N	\N
417	30	211	170	257	Margaret Thatcher	1	1	\N	\N	\N
418	30	211	170	243	Bob dylan	1	1	\N	\N	\N
419	30	211	170	228	Popeye	1	1	\N	\N	\N
420	30	211	170	224	Jacinta Ardern	1	1	\N	\N	\N
421	30	211	170	269	Miley Cyrus	1	1	\N	\N	\N
422	30	211	170	244	Peppa pig	1	1	\N	\N	\N
423	30	211	170	236	Caroline potter	0	1	\N	\N	\N
424	30	212	168	232	Kylie Minogue 	1	1	\N	\N	\N
425	30	212	168	226	Cleo	1	1	\N	\N	\N
426	30	212	168	259	Zelensky	0	1	\N	\N	\N
427	30	211	169	236	Caroline potter	1	1	\N	\N	\N
428	30	211	169	259	Zelensky	1	1	\N	\N	\N
429	30	211	169	252	Dracula	1	1	\N	\N	\N
430	30	211	169	216	Melania Trump	1	1	\N	\N	\N
431	30	211	169	256	Jaimie Lannister	1	1	\N	\N	\N
432	30	211	169	234	Mark mcgowan	1	2	\N	\N	\N
433	30	211	169	252	Dracula	1	2	\N	\N	\N
434	30	211	169	263	Alan Rickman	1	2	\N	\N	\N
435	30	211	169	266	Kate Bush	1	2	\N	\N	\N
436	30	211	169	262	Ringo Starr	1	2	\N	\N	\N
437	30	211	169	256	Jaimie Lannister	0	2	\N	\N	\N
438	30	212	172	251	Ramses II	1	2	\N	\N	\N
439	30	212	172	221	Shrek	1	2	\N	\N	\N
440	30	212	172	233	Putin	1	2	\N	\N	\N
441	30	212	172	270	Julia Gillard	1	2	\N	\N	\N
442	30	212	172	268	Steve Jobs	1	2	\N	\N	\N
443	30	212	172	257	Margaret Thatcher	1	2	\N	\N	\N
444	30	212	172	224	Jacinta Ardern	1	2	\N	\N	\N
445	30	212	172	258	Vladimir Putin	1	2	\N	\N	\N
446	30	212	172	225	Rob	0	2	\N	\N	\N
447	30	211	171	254	Adolf Hitler	1	2	\N	\N	\N
448	30	211	171	260	Helena Bonham Carter	1	2	\N	\N	\N
449	30	211	171	232	Kylie Minogue 	1	2	\N	\N	\N
450	30	211	171	223	Santa Clause	1	2	\N	\N	\N
451	30	211	171	246	Adele	1	2	\N	\N	\N
452	30	211	171	256	Jaimie Lannister	1	2	\N	\N	\N
453	30	211	171	245	Cheer	0	2	\N	\N	\N
454	30	212	173	230	Osama bin Laden 	1	2	\N	\N	\N
455	30	212	173	243	Bob dylan	1	2	\N	\N	\N
456	30	212	173	249	Lady Di	1	2	\N	\N	\N
457	30	212	173	244	Peppa pig	1	2	\N	\N	\N
458	30	212	173	272	Mark McGowan	1	2	\N	\N	\N
459	30	212	173	241	Kate bush	0	2	\N	\N	\N
460	30	211	170	215	Julia Gillard 	1	2	\N	\N	\N
461	30	211	170	241	Kate bush	1	2	\N	\N	\N
462	30	211	170	255	Smeagol / Gollum	1	2	\N	\N	\N
463	30	211	170	236	Caroline potter	1	2	\N	\N	\N
464	30	211	170	216	Melania Trump	0	2	\N	\N	\N
465	30	212	168	271	Bill Gates	1	2	\N	\N	\N
466	30	212	168	242	Kim kardashian	1	2	\N	\N	\N
467	30	212	168	253	Queen victoria	1	2	\N	\N	\N
468	30	212	168	217	Mel Gibson	1	2	\N	\N	\N
469	30	212	168	265	Ivanka Trump	1	2	\N	\N	\N
470	30	212	168	219	Seth McFarlane	1	2	\N	\N	\N
471	30	212	168	214	Harry Potter	1	2	\N	\N	\N
472	30	212	168	240	Mick jagger	1	2	\N	\N	\N
473	30	212	168	259	Zelensky	0	2	\N	\N	\N
474	30	211	169	248	Dyanerys	1	2	\N	\N	\N
475	30	211	169	218	Justin Timberlake	1	2	\N	\N	\N
476	30	211	169	229	Mickey mouse	1	2	\N	\N	\N
477	30	211	169	231	George bush	0	2	\N	\N	\N
478	30	212	172	239	King george IV	1	2	\N	\N	\N
479	30	212	172	226	Cleo	1	2	\N	\N	\N
480	30	212	172	269	Miley Cyrus	1	2	\N	\N	\N
481	30	212	172	261	Dwayne "the rock" johnson	1	2	\N	\N	\N
482	30	212	172	228	Popeye	1	2	\N	\N	\N
483	30	212	172	231	George bush	1	2	\N	\N	\N
484	30	212	172	237	Princess margaret	1	2	\N	\N	\N
485	30	212	172	259	Zelensky	1	2	\N	\N	\N
486	30	212	172	222	Prince Andrew	0	2	\N	\N	\N
487	30	211	171	222	Prince Andrew	1	2	\N	\N	\N
488	30	211	171	267	George Bush	1	2	\N	\N	\N
489	30	211	171	238	Prince andrew	1	2	\N	\N	\N
490	30	211	171	273	Sting (singer)	1	2	\N	\N	\N
491	30	211	171	247	Gandalf	1	2	\N	\N	\N
492	30	211	171	235	Auntie pauline	1	2	\N	\N	\N
493	30	211	171	227	Ted	1	2	\N	\N	\N
494	30	211	171	216	Melania Trump	1	2	\N	\N	\N
495	30	211	171	220	Homer Simpson	1	2	\N	\N	\N
496	30	211	171	245	Cheer	0	2	\N	\N	\N
497	30	212	173	264	Elon Musk	1	2	\N	\N	\N
498	30	212	173	245	Cheer	1	2	\N	\N	\N
499	30	212	173	250	Einsten	1	2	\N	\N	\N
500	30	212	173	225	Rob	0	2	\N	\N	\N
501	30	211	170	225	Rob	1	2	\N	\N	\N
502	30	211	170	248	Dyanerys	1	3	\N	\N	\N
503	30	211	170	223	Santa Clause	1	3	\N	\N	\N
504	30	211	170	264	Elon Musk	1	3	\N	\N	\N
505	30	211	170	251	Ramses II	1	3	\N	\N	\N
506	30	211	170	226	Cleo	1	3	\N	\N	\N
507	30	211	170	241	Kate bush	0	3	\N	\N	\N
508	30	212	168	222	Prince Andrew	1	3	\N	\N	\N
509	30	212	168	240	Mick jagger	1	3	\N	\N	\N
510	30	212	168	241	Kate bush	1	3	\N	\N	\N
511	30	212	168	263	Alan Rickman	1	3	\N	\N	\N
512	30	212	168	239	King george IV	1	3	\N	\N	\N
513	30	212	168	235	Auntie pauline	0	3	\N	\N	\N
514	30	211	169	225	Rob	1	3	\N	\N	\N
515	30	211	169	273	Sting (singer)	1	3	\N	\N	\N
516	30	211	169	219	Seth McFarlane	1	3	\N	\N	\N
517	30	211	169	253	Queen victoria	1	3	\N	\N	\N
518	30	211	169	245	Cheer	1	3	\N	\N	\N
519	30	211	169	229	Mickey mouse	1	3	\N	\N	\N
520	30	211	169	228	Popeye	1	3	\N	\N	\N
521	30	211	169	242	Kim kardashian	0	3	\N	\N	\N
522	30	212	172	243	Bob dylan	1	3	\N	\N	\N
523	30	212	172	235	Auntie pauline	1	3	\N	\N	\N
524	30	212	172	217	Mel Gibson	1	3	\N	\N	\N
525	30	212	172	233	Putin	0	3	\N	\N	\N
526	30	211	171	216	Melania Trump	1	3	\N	\N	\N
527	30	211	171	270	Julia Gillard	1	3	\N	\N	\N
528	30	211	171	250	Einsten	1	3	\N	\N	\N
529	30	211	171	262	Ringo Starr	1	3	\N	\N	\N
530	30	211	171	255	Smeagol / Gollum	1	3	\N	\N	\N
531	30	211	171	268	Steve Jobs	0	3	\N	\N	\N
532	30	212	173	215	Julia Gillard 	1	3	\N	\N	\N
533	30	212	173	254	Adolf Hitler	1	3	\N	\N	\N
534	30	212	173	218	Justin Timberlake	1	3	\N	\N	\N
535	30	212	173	230	Osama bin Laden 	1	3	\N	\N	\N
536	30	212	173	271	Bill Gates	1	3	\N	\N	\N
537	30	212	173	268	Steve Jobs	1	3	\N	\N	\N
538	30	212	173	260	Helena Bonham Carter	1	3	\N	\N	\N
539	30	212	173	257	Margaret Thatcher	0	3	\N	\N	\N
540	30	211	170	249	Lady Di	1	3	\N	\N	\N
541	30	211	170	259	Zelensky	1	3	\N	\N	\N
542	30	211	170	257	Margaret Thatcher	1	3	\N	\N	\N
543	30	211	170	244	Peppa pig	1	3	\N	\N	\N
544	30	211	170	232	Kylie Minogue 	1	3	\N	\N	\N
545	30	211	170	265	Ivanka Trump	1	3	\N	\N	\N
546	30	211	170	258	Vladimir Putin	1	3	\N	\N	\N
547	30	211	170	220	Homer Simpson	1	3	\N	\N	\N
548	30	211	170	237	Princess margaret	1	3	\N	\N	\N
549	30	211	170	231	George bush	0	3	\N	\N	\N
550	30	212	168	238	Prince andrew	1	3	\N	\N	\N
551	30	212	168	233	Putin	1	3	\N	\N	\N
552	30	212	168	272	Mark McGowan	1	3	\N	\N	\N
553	30	212	168	214	Harry Potter	1	3	\N	\N	\N
554	30	212	168	261	Dwayne "the rock" johnson	1	3	\N	\N	\N
555	30	212	168	234	Mark mcgowan	1	3	\N	\N	\N
556	30	212	168	224	Jacinta Ardern	1	3	\N	\N	\N
557	30	212	168	247	Gandalf	1	3	\N	\N	\N
558	30	212	168	256	Jaimie Lannister	1	3	\N	\N	\N
559	30	212	168	236	Caroline potter	1	3	\N	\N	\N
560	30	212	168	227	Ted	1	3	\N	\N	\N
561	30	212	168	266	Kate Bush	0	3	\N	\N	\N
562	30	211	169	269	Miley Cyrus	1	3	\N	\N	\N
563	30	211	169	221	Shrek	1	3	\N	\N	\N
564	30	211	169	266	Kate Bush	1	3	\N	\N	\N
565	30	211	169	246	Adele	0	3	\N	\N	\N
566	30	212	172	231	George bush	1	3	\N	\N	\N
567	30	212	172	246	Adele	1	3	\N	\N	\N
568	30	212	172	267	George Bush	1	3	\N	\N	\N
569	30	212	172	252	Dracula	1	3	\N	\N	\N
570	30	212	172	242	Kim kardashian	1	3	\N	\N	\N
571	30	211	171	268	Steve Jobs	1	4	\N	\N	\N
572	30	211	171	226	Cleo	1	4	\N	\N	\N
573	30	211	171	265	Ivanka Trump	1	4	\N	\N	\N
574	30	211	171	272	Mark McGowan	0	4	\N	\N	\N
575	30	212	173	250	Einsten	1	4	\N	\N	\N
576	30	212	173	233	Putin	1	4	\N	\N	\N
577	30	212	173	230	Osama bin Laden 	0	4	\N	\N	\N
578	30	211	170	236	Caroline potter	1	4	\N	\N	\N
579	30	211	170	223	Santa Clause	1	4	\N	\N	\N
580	30	211	170	243	Bob dylan	1	4	\N	\N	\N
581	30	211	170	228	Popeye	1	4	\N	\N	\N
582	30	211	170	242	Kim kardashian	1	4	\N	\N	\N
583	30	211	170	255	Smeagol / Gollum	1	4	\N	\N	\N
584	30	211	170	221	Shrek	0	4	\N	\N	\N
585	30	212	168	254	Adolf Hitler	1	4	\N	\N	\N
586	30	212	168	234	Mark mcgowan	1	4	\N	\N	\N
587	30	212	168	260	Helena Bonham Carter	1	4	\N	\N	\N
588	30	212	168	272	Mark McGowan	1	4	\N	\N	\N
589	30	212	168	253	Queen victoria	1	4	\N	\N	\N
590	30	212	168	231	George bush	1	4	\N	\N	\N
591	30	212	168	215	Julia Gillard 	0	4	\N	\N	\N
592	30	211	169	244	Peppa pig	1	4	\N	\N	\N
593	30	211	169	259	Zelensky	1	4	\N	\N	\N
594	30	211	169	258	Vladimir Putin	1	4	\N	\N	\N
595	30	211	169	270	Julia Gillard	0	4	\N	\N	\N
596	30	212	172	238	Prince andrew	1	4	\N	\N	\N
597	30	212	172	230	Osama bin Laden 	1	4	\N	\N	\N
598	30	212	172	264	Elon Musk	1	4	\N	\N	\N
599	30	212	172	221	Shrek	0	4	\N	\N	\N
600	30	211	171	251	Ramses II	1	4	\N	\N	\N
601	30	211	171	241	Kate bush	1	4	\N	\N	\N
602	30	211	171	218	Justin Timberlake	1	4	\N	\N	\N
603	30	211	171	239	King george IV	1	4	\N	\N	\N
604	30	211	171	246	Adele	1	4	\N	\N	\N
605	30	211	171	219	Seth McFarlane	0	4	\N	\N	\N
606	30	212	173	222	Prince Andrew	1	4	\N	\N	\N
607	30	212	173	263	Alan Rickman	1	4	\N	\N	\N
608	30	212	173	225	Rob	1	4	\N	\N	\N
609	30	212	173	227	Ted	1	4	\N	\N	\N
610	30	212	173	271	Bill Gates	1	4	\N	\N	\N
611	30	212	173	216	Melania Trump	0	4	\N	\N	\N
612	30	211	170	224	Jacinta Ardern	1	4	\N	\N	\N
613	30	211	170	237	Princess margaret	1	4	\N	\N	\N
614	30	211	170	219	Seth McFarlane	1	4	\N	\N	\N
615	30	211	170	232	Kylie Minogue 	0	4	\N	\N	\N
616	30	212	168	273	Sting (singer)	1	4	\N	\N	\N
617	30	212	168	235	Auntie pauline	1	4	\N	\N	\N
618	30	212	168	216	Melania Trump	1	4	\N	\N	\N
619	30	212	168	266	Kate Bush	1	4	\N	\N	\N
620	30	212	168	247	Gandalf	1	4	\N	\N	\N
621	30	212	168	214	Harry Potter	1	4	\N	\N	\N
622	30	212	168	261	Dwayne "the rock" johnson	1	4	\N	\N	\N
623	30	212	168	257	Margaret Thatcher	1	4	\N	\N	\N
624	30	212	168	217	Mel Gibson	1	4	\N	\N	\N
625	30	212	168	270	Julia Gillard	0	4	\N	\N	\N
626	30	211	169	221	Shrek	1	4	\N	\N	\N
627	30	211	169	270	Julia Gillard	1	4	\N	\N	\N
628	30	211	169	256	Jaimie Lannister	1	4	\N	\N	\N
629	30	211	169	252	Dracula	0	4	\N	\N	\N
630	30	212	172	262	Ringo Starr	1	4	\N	\N	\N
631	30	212	172	220	Homer Simpson	0	4	\N	\N	\N
632	30	211	171	240	Mick jagger	1	4	\N	\N	\N
633	30	211	171	267	George Bush	1	4	\N	\N	\N
634	30	211	171	252	Dracula	1	4	\N	\N	\N
635	30	211	171	269	Miley Cyrus	1	4	\N	\N	\N
636	30	211	171	248	Dyanerys	0	4	\N	\N	\N
637	30	212	173	229	Mickey mouse	1	4	\N	\N	\N
638	30	212	173	245	Cheer	1	4	\N	\N	\N
639	30	212	173	215	Julia Gillard 	0	4	\N	\N	\N
640	30	211	170	249	Lady Di	1	4	\N	\N	\N
641	30	211	170	220	Homer Simpson	1	4	\N	\N	\N
642	30	211	170	248	Dyanerys	1	4	\N	\N	\N
643	30	211	170	215	Julia Gillard 	1	4	\N	\N	\N
644	30	211	170	232	Kylie Minogue 	0	4	\N	\N	\N
645	30	212	168	232	Kylie Minogue 	1	4	\N	\N	\N
1145	79	312	255	440	Warren Buffett	1	1	\N	2022-06-19 22:53:32.251499	11
1146	79	312	255	437	Pol Pot	0	1	\N	2022-06-19 22:53:55.39826	11
1170	79	312	255	439	Gal Gadot	1	3	2022-06-19 23:10:34.029494	2022-06-19 23:10:35.394679	17
1171	79	312	255	435	Archimedes	1	3	2022-06-19 23:10:35.394679	2022-06-19 23:10:37.042589	17
1172	79	312	255	431	Shia LaBeouf	1	3	2022-06-19 23:10:37.042589	2022-06-19 23:10:38.626116	17
1173	79	312	255	437	Pol Pot	1	3	2022-06-19 23:10:38.626116	2022-06-19 23:10:40.139378	17
1174	79	313	254	435	Archimedes	0	4	2022-06-19 23:10:58.662688	2022-06-19 23:11:00.946705	18
1175	79	312	255	437	Pol Pot	1	4	2022-06-19 23:11:06.427831	2022-06-19 23:11:07.733369	19
1176	79	312	255	438	Vincent van Gogh	1	4	2022-06-19 23:11:07.733369	2022-06-19 23:11:09.196636	19
1177	79	312	255	439	Gal Gadot	1	4	2022-06-19 23:11:09.196636	2022-06-19 23:11:11.041658	19
1178	79	312	255	434	Drake	1	4	2022-06-19 23:11:11.041658	2022-06-19 23:11:26.223709	19
1179	79	312	255	431	Shia LaBeouf	0	4	2022-06-19 23:11:26.223709	2022-06-19 23:11:57.000206	19
1180	79	313	254	436	Yuri Gagarin	1	4	2022-06-19 23:38:27.5628	2022-06-19 23:38:37.833528	20
1181	79	313	254	440	Warren Buffett	1	4	2022-06-19 23:38:37.833528	2022-06-19 23:38:44.87829	20
1182	79	313	254	431	Shia LaBeouf	1	4	2022-06-19 23:38:44.87829	2022-06-19 23:38:50.820991	20
1183	79	313	254	435	Archimedes	1	4	2022-06-19 23:38:50.820991	2022-06-19 23:38:56.803261	20
1184	79	313	254	441	Julie Andrews	1	4	2022-06-19 23:38:56.803261	2022-06-19 23:39:14.267556	20
1185	79	313	254	433	Lady Gaga	0	4	2022-06-19 23:39:14.267556	2022-06-19 23:39:27.578488	20
1242	81	316	269	524	Twiggy forrest	1	2	2022-06-20 20:39:14.476162	2022-06-20 20:39:18.075859	31
1243	81	316	269	489	Lady Gaga	1	2	2022-06-20 20:39:18.075859	2022-06-20 20:39:27.145209	31
1244	81	316	269	484	Sia	0	2	2022-06-20 20:39:27.145209	2022-06-20 20:39:36.369386	31
1245	81	316	263	493	Jesus	1	2	2022-06-20 20:47:27.114359	2022-06-20 20:47:30.348009	32
1246	81	316	263	516	Bob Marley	1	2	2022-06-20 20:47:30.348009	2022-06-20 20:47:34.882249	32
1247	81	316	263	500	George Washington	1	2	2022-06-20 20:47:34.882249	2022-06-20 20:47:53.664768	32
1248	81	316	263	513	Vincent Van Gogh 	1	2	2022-06-20 20:47:53.664768	2022-06-20 20:47:57.535306	32
1249	81	316	263	491	George Harrison	0	2	2022-06-20 20:47:57.535306	2022-06-20 20:48:27.129043	32
1250	81	317	268	515	Pele	0	2	2022-06-20 20:49:12.414175	2022-06-20 20:49:49.359947	33
1251	81	316	270	490	Celine Dion	1	2	2022-06-20 20:50:31.164787	2022-06-20 20:51:29.050768	34
1320	81	316	263	498	Rick Sanchez	1	3	2022-06-20 21:28:53.477272	2022-06-20 21:29:10.752478	54
1321	81	316	263	488	Michael Jackson	1	3	2022-06-20 21:29:10.752478	2022-06-20 21:29:14.498667	54
1322	81	316	263	517	Aristotle	1	3	2022-06-20 21:29:14.498667	2022-06-20 21:29:19.770057	54
1323	81	316	263	524	Twiggy forrest	1	3	2022-06-20 21:29:19.770057	2022-06-20 21:29:26.389075	54
1324	81	316	263	514	Shakespeare 	0	3	2022-06-20 21:29:26.389075	2022-06-20 21:29:28.985515	54
1325	81	317	268	509	Elvis	1	3	2022-06-20 21:29:38.804261	2022-06-20 21:29:52.701756	55
1326	81	317	268	513	Vincent Van Gogh 	1	3	2022-06-20 21:29:52.701756	2022-06-20 21:29:55.622874	55
1327	81	317	268	489	Lady Gaga	1	3	2022-06-20 21:29:55.622874	2022-06-20 21:30:00.590135	55
1328	81	317	268	486	Rihanna	1	3	2022-06-20 21:30:00.590135	2022-06-20 21:30:07.413374	55
1329	81	317	268	520	Vincent van gogh	1	3	2022-06-20 21:30:07.413374	2022-06-20 21:30:09.860692	55
1330	81	317	268	497	J. R. R. Tolkein	1	3	2022-06-20 21:30:09.860692	2022-06-20 21:30:19.347875	55
1331	81	317	268	514	Shakespeare 	1	3	2022-06-20 21:30:19.347875	2022-06-20 21:30:31.713093	55
1332	81	317	268	522	Amy winehouse	1	3	2022-06-20 21:30:31.713093	2022-06-20 21:30:37.352936	55
1333	81	317	268	504	Kevin Parker	0	3	2022-06-20 21:30:37.352936	2022-06-20 21:30:38.865313	55
1334	81	316	270	499	Alex jones	0	3	2022-06-20 21:31:00.160945	2022-06-20 21:31:18.104844	56
1335	81	317	266	515	Pele	1	3	2022-06-20 21:31:52.700217	2022-06-20 21:31:58.984339	57
1336	81	317	266	521	Cleopatra	1	3	2022-06-20 21:31:58.984339	2022-06-20 21:32:06.436137	57
1337	81	317	266	525	Julius caesar	1	3	2022-06-20 21:32:06.436137	2022-06-20 21:32:17.8516	57
1338	81	317	266	510	Marie Antoinette	1	3	2022-06-20 21:32:17.8516	2022-06-20 21:32:23.747513	57
1339	81	317	266	504	Kevin Parker	0	3	2022-06-20 21:32:23.747513	2022-06-20 21:33:42.321342	57
1340	81	316	269	511	Ryan Reynolds	0	3	2022-06-20 21:34:02.419806	2022-06-20 21:35:02.387834	58
1341	81	317	264	504	Kevin Parker	1	3	2022-06-20 21:35:59.991651	2022-06-20 21:36:07.27881	59
1342	81	317	264	511	Ryan Reynolds	1	3	2022-06-20 21:36:07.27881	2022-06-20 21:36:10.768181	59
1343	81	317	264	499	Alex jones	1	3	2022-06-20 21:36:10.768181	2022-06-20 21:36:17.415587	59
1344	81	317	264	518	Greta Thunberg	1	3	2022-06-20 21:36:17.415587	2022-06-20 21:36:24.527478	59
1345	81	317	264	512	Nelson Mandela 	1	3	2022-06-20 21:36:24.527478	2022-06-20 21:36:27.664353	59
1346	81	317	264	502	Colonel Sanders	1	3	2022-06-20 21:36:27.664353	2022-06-20 21:36:30.965038	59
1347	81	317	264	494	Nelson Mandela	1	3	2022-06-20 21:36:30.965038	2022-06-20 21:36:35.23168	59
1348	81	317	264	493	Jesus	1	3	2022-06-20 21:36:35.23168	2022-06-20 21:36:40.232553	59
1349	81	316	263	523	Ludwig van Beethoven	1	4	2022-06-20 21:37:17.535528	2022-06-20 21:37:24.33847	60
1350	81	316	263	484	Sia	1	4	2022-06-20 21:37:24.33847	2022-06-20 21:37:28.18719	60
1351	81	316	263	485	Beyonce 	1	4	2022-06-20 21:37:28.18719	2022-06-20 21:37:47.090742	60
1352	81	316	263	506	Jane Austen	1	4	2022-06-20 21:37:47.090742	2022-06-20 21:38:03.685861	60
1353	81	316	263	498	Rick Sanchez	1	4	2022-06-20 21:38:03.685861	2022-06-20 21:38:09.169381	60
1354	81	316	263	495	Bolsonaro	0	4	2022-06-20 21:38:09.169381	2022-06-20 21:38:17.544515	60
1355	81	317	268	496	Satoshi Nakamoto	1	4	2022-06-20 21:38:43.054547	2022-06-20 21:39:06.789647	61
1356	81	317	268	511	Ryan Reynolds	1	4	2022-06-20 21:39:06.789647	2022-06-20 21:39:10.126833	61
1357	81	317	268	491	George Harrison	1	4	2022-06-20 21:39:10.126833	2022-06-20 21:39:29.112294	61
1358	81	317	268	504	Kevin Parker	0	4	2022-06-20 21:39:29.112294	2022-06-20 21:39:43.067675	61
1359	81	316	270	490	Celine Dion	1	4	2022-06-20 21:40:01.391336	2022-06-20 21:40:12.936523	62
1360	81	316	270	517	Aristotle	1	4	2022-06-20 21:40:12.936523	2022-06-20 21:40:18.987358	62
1361	81	316	270	522	Amy winehouse	1	4	2022-06-20 21:40:18.987358	2022-06-20 21:40:24.677068	62
1362	81	316	270	499	Alex jones	1	4	2022-06-20 21:40:24.677068	2022-06-20 21:40:32.655985	62
1363	81	316	270	513	Vincent Van Gogh 	1	4	2022-06-20 21:40:32.655985	2022-06-20 21:40:38.036098	62
1364	81	316	270	504	Kevin Parker	1	4	2022-06-20 21:40:38.036098	2022-06-20 21:40:42.329039	62
1365	81	316	270	501	Jake the dog	1	4	2022-06-20 21:40:42.329039	2022-06-20 21:40:46.969565	62
1366	81	316	270	509	Elvis	1	4	2022-06-20 21:40:46.969565	2022-06-20 21:40:51.950561	62
1367	81	316	270	519	Karl kruzulnitsky	1	4	2022-06-20 21:40:51.950561	2022-06-20 21:40:59.58839	62
1368	81	316	270	516	Bob Marley	0	4	2022-06-20 21:40:59.58839	2022-06-20 21:41:01.451018	62
1369	81	317	266	497	J. R. R. Tolkein	1	4	2022-06-20 21:41:21.663123	2022-06-20 21:41:41.884358	63
1370	81	317	266	505	King Henry VIII	1	4	2022-06-20 21:41:41.884358	2022-06-20 21:41:54.471912	63
1371	81	317	266	515	Pele	1	4	2022-06-20 21:41:54.471912	2022-06-20 21:41:57.677409	63
1372	81	317	266	525	Julius caesar	1	4	2022-06-20 21:41:57.677409	2022-06-20 21:42:06.021726	63
1373	81	317	266	502	Colonel Sanders	0	4	2022-06-20 21:42:06.021726	2022-06-20 21:42:21.658519	63
1374	81	316	269	514	Shakespeare 	1	4	2022-06-20 21:42:57.902813	2022-06-20 21:43:09.283038	64
1375	81	316	269	512	Nelson Mandela 	1	4	2022-06-20 21:43:09.283038	2022-06-20 21:43:37.602161	64
1376	81	316	269	486	Rihanna	1	4	2022-06-20 21:43:37.602161	2022-06-20 21:43:47.702129	64
1377	81	316	269	508	Harold Holt	0	4	2022-06-20 21:43:47.702129	2022-06-20 21:43:57.797924	64
1378	81	317	264	516	Bob Marley	1	4	2022-06-20 21:44:10.923905	2022-06-20 21:44:16.886716	65
1379	81	317	264	493	Jesus	1	4	2022-06-20 21:44:16.886716	2022-06-20 21:44:20.116259	65
1380	81	317	264	494	Nelson Mandela	1	4	2022-06-20 21:44:20.116259	2022-06-20 21:44:26.237907	65
1381	81	317	264	495	Bolsonaro	1	4	2022-06-20 21:44:26.237907	2022-06-20 21:44:30.167281	65
1382	81	317	264	507	Ned Kelly	1	4	2022-06-20 21:44:30.167281	2022-06-20 21:44:40.217091	65
1383	81	317	264	488	Michael Jackson	1	4	2022-06-20 21:44:40.217091	2022-06-20 21:44:43.959908	65
1384	81	317	264	518	Greta Thunberg	0	4	2022-06-20 21:44:43.959908	2022-06-20 21:45:10.930007	65
1385	81	316	263	487	Whitney Huston 	1	4	2022-06-20 21:45:40.756064	2022-06-20 21:45:57.282496	66
1386	81	316	263	521	Cleopatra	1	4	2022-06-20 21:45:57.282496	2022-06-20 21:46:01.185113	66
1387	81	316	263	508	Harold Holt	1	4	2022-06-20 21:46:01.185113	2022-06-20 21:46:04.762903	66
1388	81	316	263	500	George Washington	1	4	2022-06-20 21:46:04.762903	2022-06-20 21:46:17.469726	66
1389	81	316	263	510	Marie Antoinette	1	4	2022-06-20 21:46:17.469726	2022-06-20 21:46:31.964046	66
1390	81	316	263	489	Lady Gaga	0	4	2022-06-20 21:46:31.964046	2022-06-20 21:46:40.748899	66
1391	81	317	268	503	A minion	1	4	2022-06-20 21:47:00.561485	2022-06-20 21:47:08.34076	67
1392	81	317	268	518	Greta Thunberg	1	4	2022-06-20 21:47:08.34076	2022-06-20 21:47:15.704871	67
1393	81	317	268	502	Colonel Sanders	1	4	2022-06-20 21:47:15.704871	2022-06-20 21:47:21.100637	67
1394	81	317	268	524	Twiggy forrest	1	4	2022-06-20 21:47:21.100637	2022-06-20 21:47:28.232959	67
1395	81	317	268	520	Vincent van gogh	1	4	2022-06-20 21:47:28.232959	2022-06-20 21:47:31.820865	67
1396	81	317	268	492	Karl Marx	1	4	2022-06-20 21:47:31.820865	2022-06-20 21:47:58.496459	67
1397	81	317	268	489	Lady Gaga	0	4	2022-06-20 21:47:58.496459	2022-06-20 21:48:00.560038	67
1398	81	316	270	489	Lady Gaga	1	4	2022-06-20 21:48:11.714214	2022-06-20 21:48:17.620031	68
1399	83	320	275	530	Anne Boleyn	1	1	2022-06-23 16:44:40.501086	2022-06-23 16:44:42.177735	69
1400	83	320	275	529	Mary, mother of Jesus	1	1	2022-06-23 16:44:42.177735	2022-06-23 16:44:43.455511	69
1401	83	320	275	532	Alexander the Great	1	1	2022-06-23 16:44:43.455511	2022-06-23 16:44:44.766903	69
1402	83	320	275	531	Kirsten Dunst	1	1	2022-06-23 16:44:44.766903	2022-06-23 16:44:46.018417	69
1403	83	320	275	527	Alexander the Great	0	1	2022-06-23 16:44:46.018417	2022-06-23 16:44:47.204387	69
1404	83	321	276	533	Billie Eilish	0	1	2022-06-23 16:44:52.201648	2022-06-23 16:44:53.174241	70
1405	83	320	275	526	Emilia Clarke	0	1	2022-06-23 16:44:56.860627	2022-06-23 16:44:57.562617	71
1406	83	321	276	526	Emilia Clarke	0	1	2022-06-23 16:45:01.116131	2022-06-23 16:45:01.576238	72
1407	83	320	275	527	Alexander the Great	0	1	2022-06-23 16:45:06.177051	2022-06-23 16:45:36.454284	73
1408	83	321	276	528	Leonard Cohen	0	1	2022-06-23 16:57:15.059857	2022-06-23 16:57:20.976891	75
1409	83	320	275	533	Billie Eilish	0	1	2022-06-23 16:58:42.831899	2022-06-23 16:59:01.277183	77
1410	84	323	277	538	Hans Christian Andersen	1	1	2022-06-23 17:09:16.85305	2022-06-23 17:09:19.806172	78
1411	84	323	277	536	Drake	0	1	2022-06-23 17:09:19.806172	2022-06-23 17:09:21.333355	78
1412	84	322	278	534	Aristotle	0	1	2022-06-23 17:30:22.391502	2022-06-23 17:31:40.454378	80
1413	84	323	277	535	Margot Robbie	0	1	2022-06-23 17:31:59.947975	2022-06-23 17:32:11.362689	81
1414	84	322	278	536	Drake	0	1	2022-06-23 17:36:14.35198	2022-06-23 17:47:54.792916	82
1415	84	323	277	537	Usain Bolt	0	1	2022-06-23 17:32:11.362689	2022-06-23 17:49:07.544204	81
1416	84	322	278	535	Margot Robbie	0	1	2022-06-23 17:49:26.924542	2022-06-23 17:49:56.786628	83
1417	84	323	277	535	Margot Robbie	0	1	2022-06-23 17:51:06.326562	2022-06-23 17:52:14.164818	84
1418	84	322	278	536	Drake	0	1	2022-06-23 17:53:24.917275	2022-06-23 17:53:26.521074	85
1419	84	323	277	539	George W. Bush	0	1	2022-06-23 17:52:14.164818	2022-06-23 17:55:16.798727	84
1420	84	322	278	537	Usain Bolt	0	1	2022-06-23 18:04:15.718233	2022-06-23 18:05:23.053571	86
1421	86	329	291	599	Shakira	1	1	2022-06-23 19:33:05.422029	2022-06-23 19:33:10.36655	87
1422	86	329	291	555	Bojack Horseman	1	1	2022-06-23 19:33:10.36655	2022-06-23 19:33:24.98119	87
1423	86	329	291	595	Annastacia Palaszczuk	1	1	2022-06-23 19:33:24.98119	2022-06-23 19:33:35.312246	87
1424	86	329	291	571	Sean Connery 	1	1	2022-06-23 19:33:35.312246	2022-06-23 19:33:39.888685	87
1425	86	329	291	548	Gandalf	1	1	2022-06-23 19:33:39.888685	2022-06-23 19:33:42.678968	87
1426	86	329	291	596	The queen	1	1	2022-06-23 19:33:42.678968	2022-06-23 19:33:49.508471	87
1427	86	329	291	542	Dr Hibert	1	1	2022-06-23 19:33:49.508471	2022-06-23 19:33:59.44672	87
1428	86	329	291	575	Pudge	0	1	2022-06-23 19:33:59.44672	2022-06-23 19:34:05.433619	87
1429	86	327	286	578	Snape	1	1	2022-06-23 19:36:01.178795	2022-06-23 19:36:06.81454	88
1430	86	327	286	562	Ricky Ponting 	1	1	2022-06-23 19:36:06.81454	2022-06-23 19:36:52.97856	88
1431	86	327	286	559	Ryan Gosling	0	1	2022-06-23 19:36:52.97856	2022-06-23 19:37:01.180199	88
1432	86	328	287	585	Ingo Patrikas	0	1	2022-06-23 19:37:53.184236	2022-06-23 19:38:53.216362	89
1433	86	329	292	544	Keanu Reeves	1	1	2022-06-23 19:39:27.625094	2022-06-23 19:39:31.730403	90
1434	86	329	292	550	Karen ,speak to the manager 	1	1	2022-06-23 19:39:31.730403	2022-06-23 19:39:41.296221	90
1435	86	329	292	579	Saruman	1	1	2022-06-23 19:39:41.296221	2022-06-23 19:39:47.158759	90
1436	86	329	292	597	Fred mercury	1	1	2022-06-23 19:39:47.158759	2022-06-23 19:39:52.017146	90
1437	86	329	292	575	Pudge	1	1	2022-06-23 19:39:52.017146	2022-06-23 19:39:55.943115	90
1438	86	329	292	573	Jesus	1	1	2022-06-23 19:39:55.943115	2022-06-23 19:40:00.052452	90
1439	86	329	292	574	Agatha Christie	1	1	2022-06-23 19:40:00.052452	2022-06-23 19:40:04.24246	90
1440	86	329	292	589	Liz Constable	0	1	2022-06-23 19:40:04.24246	2022-06-23 19:40:27.673675	90
1441	86	327	294	545	Elon Musk	1	1	2022-06-23 19:41:12.12919	2022-06-23 19:41:17.191786	91
1442	86	327	294	581	The Hound 	1	1	2022-06-23 19:41:17.191786	2022-06-23 19:42:03.616594	91
1443	86	327	294	584	Brian Blessed	0	1	2022-06-23 19:42:03.616594	2022-06-23 19:42:53.73591	91
1444	86	328	285	587	Vladimir Putin	1	1	2022-06-23 19:43:07.426784	2022-06-23 19:43:16.207572	92
1445	86	328	285	565	Paul Keating 	1	1	2022-06-23 19:43:16.207572	2022-06-23 19:43:26.827702	92
1446	86	328	285	567	Al Pacino	1	1	2022-06-23 19:43:26.827702	2022-06-23 19:43:34.459095	92
1447	86	328	285	569	Marie Curie	0	1	2022-06-23 19:43:34.459095	2022-06-23 19:44:07.492789	92
1448	86	329	288	547	Sponje bob	1	1	2022-06-23 19:44:51.10543	2022-06-23 19:44:57.304366	93
1449	86	329	288	577	Spartacus	1	1	2022-06-23 19:44:57.304366	2022-06-23 19:45:14.479597	93
1450	86	329	288	543	The fat controller 	1	1	2022-06-23 19:45:14.479597	2022-06-23 19:45:21.212027	93
1451	86	329	288	566	Nelson Muntz 	1	1	2022-06-23 19:45:21.212027	2022-06-23 19:45:39.291292	93
1452	86	329	288	590	Jane Prince	0	1	2022-06-23 19:45:39.291292	2022-06-23 19:45:51.105703	93
1453	86	327	289	583	Bilbo Baggins	1	1	2022-06-23 19:46:43.882937	2022-06-23 19:47:14.811863	94
1454	86	327	289	557	Kevin Rudd	0	1	2022-06-23 19:47:14.811863	2022-06-23 19:47:43.872378	94
1455	86	328	293	553	Hermione	1	1	2022-06-23 19:48:19.692029	2022-06-23 19:48:23.717213	95
1456	86	328	293	584	Brian Blessed	1	1	2022-06-23 19:48:23.717213	2022-06-23 19:48:32.966304	95
1457	86	328	293	541	Overly Excited Girlfriend 	1	1	2022-06-23 19:48:32.966304	2022-06-23 19:48:41.781801	95
1458	86	328	293	558	Lorde	1	1	2022-06-23 19:48:41.781801	2022-06-23 19:48:46.996379	95
1459	86	328	293	556	Henry Cavill	1	1	2022-06-23 19:48:46.996379	2022-06-23 19:49:01.150997	95
1460	86	328	293	582	Judy Dench	1	1	2022-06-23 19:49:01.150997	2022-06-23 19:49:05.678675	95
1461	86	328	293	563	Bob Katter 	1	1	2022-06-23 19:49:05.678675	2022-06-23 19:49:09.846206	95
1462	86	328	293	602	Maleficent	1	1	2022-06-23 19:49:09.846206	2022-06-23 19:49:19.614837	95
1463	86	328	293	591	Casey Briggs	0	1	2022-06-23 19:49:19.614837	2022-06-23 19:49:19.687233	95
1464	86	329	291	560	Light Yagami	1	1	2022-06-23 19:49:40.24751	2022-06-23 19:50:12.209322	96
1465	86	329	291	580	Dendi	1	1	2022-06-23 19:50:12.209322	2022-06-23 19:50:25.23589	96
1466	86	329	291	589	Liz Constable	1	1	2022-06-23 19:50:25.23589	2022-06-23 19:50:31.917802	96
1467	86	329	291	593	Kate Chaney	0	1	2022-06-23 19:50:31.917802	2022-06-23 19:50:40.256696	96
1468	86	327	286	591	Casey Briggs	0	1	2022-06-23 19:51:25.71959	2022-06-23 19:52:25.684162	97
1469	86	328	287	598	John lenon	1	1	2022-06-23 19:53:00.50991	2022-06-23 19:53:08.45732	98
1470	86	328	287	551	Scooby doo	1	1	2022-06-23 19:53:08.45732	2022-06-23 19:53:20.506057	98
1471	86	328	287	593	Kate Chaney	1	1	2022-06-23 19:53:20.506057	2022-06-23 19:53:29.594961	98
1472	86	328	287	586	Pope Francis	1	1	2022-06-23 19:53:29.594961	2022-06-23 19:53:37.93697	98
1473	86	328	287	601	Snow white	1	1	2022-06-23 19:53:37.93697	2022-06-23 19:53:48.403667	98
1474	86	328	287	559	Ryan Gosling	0	1	2022-06-23 19:53:48.403667	2022-06-23 19:54:00.523817	98
1475	86	329	292	576	Tony Abbott 	1	1	2022-06-23 19:54:17.825352	2022-06-23 19:54:26.901579	99
1476	86	329	292	592	Karen Fernandes	1	1	2022-06-23 19:54:26.901579	2022-06-23 19:54:53.673002	99
1477	86	329	292	559	Ryan Gosling	1	1	2022-06-23 19:54:53.673002	2022-06-23 19:55:00.454369	99
1478	86	329	292	554	Tom Cruise	1	1	2022-06-23 19:55:00.454369	2022-06-23 19:55:04.469458	99
1479	86	329	292	540	Mr Strong	0	1	2022-06-23 19:55:04.469458	2022-06-23 19:55:17.879122	99
1480	86	327	294	572	Prince William	1	1	2022-06-23 19:55:36.822529	2022-06-23 19:56:29.672807	100
1481	86	327	294	590	Jane Prince	0	1	2022-06-23 19:56:29.672807	2022-06-23 19:56:36.838528	100
1482	86	328	285	540	Mr Strong	1	1	2022-06-23 19:57:05.499928	2022-06-23 19:57:17.636115	101
1483	86	328	285	557	Kevin Rudd	1	1	2022-06-23 19:57:17.636115	2022-06-23 19:57:27.033013	101
1484	86	328	285	585	Ingo Patrikas	1	1	2022-06-23 19:57:27.033013	2022-06-23 19:57:32.659434	101
1485	86	328	285	546	Luigi	1	1	2022-06-23 19:57:32.659434	2022-06-23 19:57:37.188054	101
1486	86	328	285	600	Tom	1	1	2022-06-23 19:57:37.188054	2022-06-23 19:57:42.316864	101
1487	86	328	285	561	Stalin 	1	1	2022-06-23 19:57:42.316864	2022-06-23 19:57:54.531505	101
1488	86	328	285	564	Roger Cook	0	1	2022-06-23 19:57:54.531505	2022-06-23 19:58:05.551209	101
1489	86	329	288	590	Jane Prince	1	1	2022-06-23 19:58:44.163099	2022-06-23 19:58:55.755626	102
1490	86	329	288	568	Marie Antoinette	1	1	2022-06-23 19:58:55.755626	2022-06-23 19:59:00.921094	102
1491	86	329	288	552	Lady gaga	1	1	2022-06-23 19:59:00.921094	2022-06-23 19:59:16.90513	102
1492	86	329	288	569	Marie Curie	1	1	2022-06-23 19:59:16.90513	2022-06-23 19:59:21.279835	102
1493	86	329	288	588	Volodimir Zelensky	1	1	2022-06-23 19:59:21.279835	2022-06-23 19:59:27.598716	102
1494	86	329	288	570	Serena Williams	1	1	2022-06-23 19:59:27.598716	2022-06-23 19:59:33.491925	102
1495	86	329	288	564	Roger Cook	1	1	2022-06-23 19:59:33.491925	2022-06-23 19:59:40.143161	102
1496	86	329	288	594	Banjo	0	1	2022-06-23 19:59:40.143161	2022-06-23 19:59:44.170774	102
1497	86	327	289	594	Banjo	1	1	2022-06-23 20:00:13.589259	2022-06-23 20:00:22.952178	103
1498	86	327	289	591	Casey Briggs	1	1	2022-06-23 20:00:22.952178	2022-06-23 20:00:36.149371	103
1499	86	327	289	549	Peppa pig	1	1	2022-06-23 20:00:36.149371	2022-06-23 20:00:48.124371	103
1500	86	328	293	571	Sean Connery 	0	2	2022-06-23 20:03:19.067436	2022-06-23 20:04:19.069152	104
1501	86	329	291	587	Vladimir Putin	1	2	2022-06-23 20:05:10.669242	2022-06-23 20:05:16.448372	105
1502	86	329	291	590	Jane Prince	1	2	2022-06-23 20:05:16.448372	2022-06-23 20:05:26.322436	105
1503	86	329	291	571	Sean Connery 	1	2	2022-06-23 20:05:26.322436	2022-06-23 20:05:29.894674	105
1504	86	329	291	561	Stalin 	1	2	2022-06-23 20:05:29.894674	2022-06-23 20:05:34.260343	105
1505	86	329	291	555	Bojack Horseman	1	2	2022-06-23 20:05:34.260343	2022-06-23 20:05:51.296297	105
1506	86	329	291	602	Maleficent	1	2	2022-06-23 20:05:51.296297	2022-06-23 20:05:56.56136	105
1507	86	329	291	566	Nelson Muntz 	1	2	2022-06-23 20:05:56.56136	2022-06-23 20:06:00.725433	105
1508	86	329	291	576	Tony Abbott 	1	2	2022-06-23 20:06:00.725433	2022-06-23 20:06:05.604911	105
1509	86	329	291	551	Scooby doo	0	2	2022-06-23 20:06:05.604911	2022-06-23 20:06:10.682291	105
1510	86	327	286	554	Tom Cruise	1	2	2022-06-23 20:06:38.151586	2022-06-23 20:06:43.763775	106
1511	86	327	286	541	Overly Excited Girlfriend 	0	2	2022-06-23 20:06:43.763775	2022-06-23 20:07:38.182629	106
1512	86	328	287	567	Al Pacino	1	2	2022-06-23 20:08:29.258846	2022-06-23 20:08:40.844744	107
1513	86	328	287	589	Liz Constable	1	2	2022-06-23 20:08:40.844744	2022-06-23 20:09:20.784319	107
1514	86	328	287	600	Tom	0	2	2022-06-23 20:09:20.784319	2022-06-23 20:09:29.260256	107
1515	86	329	292	552	Lady gaga	1	2	2022-06-23 20:10:04.615436	2022-06-23 20:10:08.894672	108
1516	86	329	292	543	The fat controller 	1	2	2022-06-23 20:10:08.894672	2022-06-23 20:10:12.563802	108
1517	86	329	292	562	Ricky Ponting 	1	2	2022-06-23 20:10:12.563802	2022-06-23 20:10:17.493403	108
1518	86	329	292	584	Brian Blessed	1	2	2022-06-23 20:10:17.493403	2022-06-23 20:10:22.695247	108
1519	86	329	292	551	Scooby doo	1	2	2022-06-23 20:10:22.695247	2022-06-23 20:10:27.536084	108
1520	86	329	292	599	Shakira	1	2	2022-06-23 20:10:27.536084	2022-06-23 20:10:35.699246	108
1521	86	329	292	545	Elon Musk	1	2	2022-06-23 20:10:35.699246	2022-06-23 20:10:41.884892	108
1522	86	329	292	558	Lorde	1	2	2022-06-23 20:10:41.884892	2022-06-23 20:10:46.846229	108
1523	86	329	292	596	The queen	1	2	2022-06-23 20:10:46.846229	2022-06-23 20:10:53.126311	108
1524	86	329	292	557	Kevin Rudd	1	2	2022-06-23 20:10:53.126311	2022-06-23 20:10:58.795471	108
1525	86	329	292	593	Kate Chaney	0	2	2022-06-23 20:10:58.795471	2022-06-23 20:11:04.675762	108
1526	86	327	294	563	Bob Katter 	1	2	2022-06-23 20:11:34.098234	2022-06-23 20:12:25.899683	109
1527	86	327	294	564	Roger Cook	0	2	2022-06-23 20:12:25.899683	2022-06-23 20:12:34.110162	109
1528	86	328	285	553	Hermione	1	2	2022-06-23 20:12:54.269347	2022-06-23 20:12:58.413239	110
1529	86	328	285	569	Marie Curie	1	2	2022-06-23 20:12:58.413239	2022-06-23 20:13:10.949598	110
1530	86	328	285	575	Pudge	1	2	2022-06-23 20:13:10.949598	2022-06-23 20:13:17.308832	110
1531	86	328	285	541	Overly Excited Girlfriend 	1	2	2022-06-23 20:13:17.308832	2022-06-23 20:13:22.515652	110
1532	86	328	285	549	Peppa pig	1	2	2022-06-23 20:13:22.515652	2022-06-23 20:13:44.514869	110
1533	86	328	285	588	Volodimir Zelensky	1	2	2022-06-23 20:13:44.514869	2022-06-23 20:13:52.713875	110
1534	86	328	285	547	Sponje bob	0	2	2022-06-23 20:13:52.713875	2022-06-23 20:13:54.337886	110
1535	86	329	288	550	Karen ,speak to the manager 	1	2	2022-06-23 20:14:27.77966	2022-06-23 20:14:34.026085	111
1536	86	329	288	577	Spartacus	1	2	2022-06-23 20:14:34.026085	2022-06-23 20:14:38.623681	111
1537	86	329	288	598	John lenon	1	2	2022-06-23 20:14:38.623681	2022-06-23 20:14:44.259588	111
1538	86	329	288	544	Keanu Reeves	1	2	2022-06-23 20:14:44.259588	2022-06-23 20:14:49.045652	111
1539	86	329	288	592	Karen Fernandes	1	2	2022-06-23 20:14:49.045652	2022-06-23 20:14:58.405393	111
1540	86	329	288	586	Pope Francis	1	2	2022-06-23 20:14:58.405393	2022-06-23 20:15:04.990972	111
1541	86	329	288	573	Jesus	1	2	2022-06-23 20:15:04.990972	2022-06-23 20:15:09.150749	111
1542	86	329	288	568	Marie Antoinette	1	2	2022-06-23 20:15:09.150749	2022-06-23 20:15:12.718762	111
1543	86	329	288	556	Henry Cavill	1	2	2022-06-23 20:15:12.718762	2022-06-23 20:15:17.27642	111
1544	86	329	288	581	The Hound 	0	2	2022-06-23 20:15:17.27642	2022-06-23 20:15:27.791841	111
1545	86	327	289	560	Light Yagami	1	2	2022-06-23 20:15:46.87674	2022-06-23 20:15:51.482967	112
1546	86	327	289	583	Bilbo Baggins	1	2	2022-06-23 20:15:51.482967	2022-06-23 20:16:01.861001	112
1547	86	327	289	601	Snow white	1	2	2022-06-23 20:16:01.861001	2022-06-23 20:16:08.865034	112
1548	86	327	289	546	Luigi	1	2	2022-06-23 20:16:08.865034	2022-06-23 20:16:12.535203	112
1549	86	327	289	580	Dendi	1	2	2022-06-23 20:16:12.535203	2022-06-23 20:16:18.838273	112
1550	86	327	289	578	Snape	1	2	2022-06-23 20:16:18.838273	2022-06-23 20:16:21.965476	112
1551	86	327	289	594	Banjo	1	2	2022-06-23 20:16:21.965476	2022-06-23 20:16:25.978663	112
1552	86	327	289	542	Dr Hibert	0	2	2022-06-23 20:16:25.978663	2022-06-23 20:16:46.872648	112
1553	86	328	293	591	Casey Briggs	1	2	2022-06-23 20:17:18.433086	2022-06-23 20:17:24.992878	113
1554	86	328	293	542	Dr Hibert	1	2	2022-06-23 20:17:24.992878	2022-06-23 20:17:30.226078	113
1555	86	328	293	581	The Hound 	1	2	2022-06-23 20:17:30.226078	2022-06-23 20:17:37.830707	113
1556	86	328	293	582	Judy Dench	1	2	2022-06-23 20:17:37.830707	2022-06-23 20:17:41.32875	113
1557	86	328	293	597	Fred mercury	1	2	2022-06-23 20:17:41.32875	2022-06-23 20:17:47.927864	113
1558	86	328	293	579	Saruman	1	2	2022-06-23 20:17:47.927864	2022-06-23 20:17:54.694183	113
1559	86	328	293	564	Roger Cook	1	2	2022-06-23 20:17:54.694183	2022-06-23 20:18:04.124736	113
1560	86	328	293	565	Paul Keating 	1	2	2022-06-23 20:18:04.124736	2022-06-23 20:18:13.709599	113
1561	86	328	293	572	Prince William	0	2	2022-06-23 20:18:13.709599	2022-06-23 20:18:18.428634	113
1562	86	329	291	570	Serena Williams	1	2	2022-06-23 20:18:47.806055	2022-06-23 20:18:51.023851	114
1563	86	329	291	572	Prince William	1	2	2022-06-23 20:18:51.023851	2022-06-23 20:18:57.304538	114
1564	86	329	291	547	Sponje bob	1	2	2022-06-23 20:18:57.304538	2022-06-23 20:19:00.690681	114
1565	86	329	291	600	Tom	1	2	2022-06-23 20:19:00.690681	2022-06-23 20:19:03.23791	114
1566	86	329	291	548	Gandalf	1	2	2022-06-23 20:19:03.23791	2022-06-23 20:19:06.695158	114
1567	86	329	291	585	Ingo Patrikas	0	2	2022-06-23 20:19:06.695158	2022-06-23 20:19:47.840381	114
1568	86	327	286	559	Ryan Gosling	1	2	2022-06-23 20:20:17.884147	2022-06-23 20:21:16.923122	115
1569	86	327	286	593	Kate Chaney	0	2	2022-06-23 20:21:16.923122	2022-06-23 20:21:17.9077	115
1570	86	328	287	574	Agatha Christie	1	2	2022-06-23 20:21:43.22475	2022-06-23 20:21:56.098777	116
1571	86	328	287	595	Annastacia Palaszczuk	1	2	2022-06-23 20:21:56.098777	2022-06-23 20:22:16.207091	116
1572	86	328	287	540	Mr Strong	1	2	2022-06-23 20:22:16.207091	2022-06-23 20:22:23.839439	116
1573	86	328	287	593	Kate Chaney	1	2	2022-06-23 20:22:23.839439	2022-06-23 20:22:28.109932	116
1574	86	328	287	585	Ingo Patrikas	1	2	2022-06-23 20:22:28.109932	2022-06-23 20:22:32.175728	116
1575	86	329	292	590	Jane Prince	1	3	2022-06-23 20:23:38.170736	2022-06-23 20:23:45.408894	117
1576	86	329	292	567	Al Pacino	1	3	2022-06-23 20:23:45.408894	2022-06-23 20:23:49.125214	117
1577	86	329	292	592	Karen Fernandes	1	3	2022-06-23 20:23:49.125214	2022-06-23 20:23:58.072235	117
1578	86	329	292	593	Kate Chaney	1	3	2022-06-23 20:23:58.072235	2022-06-23 20:24:01.161588	117
1579	86	329	292	559	Ryan Gosling	1	3	2022-06-23 20:24:01.161588	2022-06-23 20:24:19.455487	117
1580	86	329	292	569	Marie Curie	1	3	2022-06-23 20:24:19.455487	2022-06-23 20:24:23.992427	117
1581	86	329	292	585	Ingo Patrikas	1	3	2022-06-23 20:24:23.992427	2022-06-23 20:24:30.706141	117
1582	86	329	292	571	Sean Connery 	1	3	2022-06-23 20:24:30.706141	2022-06-23 20:24:34.231952	117
1583	86	329	292	596	The queen	0	3	2022-06-23 20:24:34.231952	2022-06-23 20:24:38.212576	117
1584	86	327	294	555	Bojack Horseman	1	3	2022-06-23 20:25:10.237567	2022-06-23 20:25:33.545816	118
1585	86	327	294	595	Annastacia Palaszczuk	0	3	2022-06-23 20:25:33.545816	2022-06-23 20:26:10.22613	118
1586	86	328	285	584	Brian Blessed	1	3	2022-06-23 20:26:52.078796	2022-06-23 20:26:56.994909	119
1587	86	328	285	576	Tony Abbott 	1	3	2022-06-23 20:26:56.994909	2022-06-23 20:27:00.776026	119
1588	86	328	285	543	The fat controller 	1	3	2022-06-23 20:27:00.776026	2022-06-23 20:27:06.958407	119
1589	86	328	285	597	Fred mercury	1	3	2022-06-23 20:27:06.958407	2022-06-23 20:27:16.64202	119
1590	86	328	285	581	The Hound 	1	3	2022-06-23 20:27:16.64202	2022-06-23 20:27:21.966265	119
1591	86	328	285	556	Henry Cavill	1	3	2022-06-23 20:27:21.966265	2022-06-23 20:27:24.979539	119
1592	86	328	285	580	Dendi	1	3	2022-06-23 20:27:24.979539	2022-06-23 20:27:30.456211	119
1593	86	328	285	587	Vladimir Putin	1	3	2022-06-23 20:27:30.456211	2022-06-23 20:27:39.341427	119
1594	86	328	285	541	Overly Excited Girlfriend 	1	3	2022-06-23 20:27:39.341427	2022-06-23 20:27:44.071982	119
1595	86	328	285	546	Luigi	1	3	2022-06-23 20:27:44.071982	2022-06-23 20:27:47.488923	119
1596	86	328	285	570	Serena Williams	1	3	2022-06-23 20:27:47.488923	2022-06-23 20:27:50.699737	119
1597	86	328	285	582	Judy Dench	0	3	2022-06-23 20:27:50.699737	2022-06-23 20:27:52.12602	119
1598	86	329	288	554	Tom Cruise	1	3	2022-06-23 20:28:13.420128	2022-06-23 20:28:16.874911	120
1599	86	329	288	547	Sponje bob	1	3	2022-06-23 20:28:16.874911	2022-06-23 20:28:22.414157	120
1600	86	329	288	560	Light Yagami	1	3	2022-06-23 20:28:22.414157	2022-06-23 20:28:39.358935	120
1601	86	329	288	563	Bob Katter 	1	3	2022-06-23 20:28:39.358935	2022-06-23 20:28:44.216457	120
1602	86	329	288	594	Banjo	1	3	2022-06-23 20:28:44.216457	2022-06-23 20:28:51.456591	120
1603	86	329	288	557	Kevin Rudd	1	3	2022-06-23 20:28:51.456591	2022-06-23 20:28:57.08537	120
1604	86	329	288	586	Pope Francis	1	3	2022-06-23 20:28:57.08537	2022-06-23 20:29:05.838778	120
1605	86	329	288	566	Nelson Muntz 	1	3	2022-06-23 20:29:05.838778	2022-06-23 20:29:09.421218	120
1606	86	329	288	599	Shakira	0	3	2022-06-23 20:29:09.421218	2022-06-23 20:29:13.473541	120
1607	86	327	289	578	Snape	1	3	2022-06-23 20:29:34.571381	2022-06-23 20:29:38.340506	121
1608	86	327	289	589	Liz Constable	1	3	2022-06-23 20:29:38.340506	2022-06-23 20:30:06.56572	121
1609	86	327	289	552	Lady gaga	1	3	2022-06-23 20:30:06.56572	2022-06-23 20:30:18.272298	121
1610	86	327	289	588	Volodimir Zelensky	0	3	2022-06-23 20:30:18.272298	2022-06-23 20:30:34.610089	121
1611	86	328	293	544	Keanu Reeves	1	3	2022-06-23 20:30:57.007788	2022-06-23 20:31:02.769525	122
1612	86	328	293	601	Snow white	1	3	2022-06-23 20:31:02.769525	2022-06-23 20:31:18.85174	122
1613	86	328	293	558	Lorde	1	3	2022-06-23 20:31:18.85174	2022-06-23 20:31:31.469738	122
1614	86	328	293	550	Karen ,speak to the manager 	1	3	2022-06-23 20:31:31.469738	2022-06-23 20:31:37.709841	122
1615	86	328	293	596	The queen	1	3	2022-06-23 20:31:37.709841	2022-06-23 20:31:44.119734	122
1616	86	328	293	582	Judy Dench	0	3	2022-06-23 20:31:44.119734	2022-06-23 20:31:57.010486	122
1617	86	329	291	573	Jesus	1	3	2022-06-23 20:32:21.597326	2022-06-23 20:32:25.441069	123
1618	86	329	291	575	Pudge	1	3	2022-06-23 20:32:25.441069	2022-06-23 20:32:31.421007	123
1619	86	329	291	579	Saruman	1	3	2022-06-23 20:32:31.421007	2022-06-23 20:32:35.834791	123
1620	86	329	291	551	Scooby doo	1	3	2022-06-23 20:32:35.834791	2022-06-23 20:32:45.533044	123
1621	86	329	291	599	Shakira	1	3	2022-06-23 20:32:45.533044	2022-06-23 20:32:48.992284	123
1622	86	329	291	588	Volodimir Zelensky	1	3	2022-06-23 20:32:48.992284	2022-06-23 20:32:52.544742	123
1623	86	329	291	562	Ricky Ponting 	1	3	2022-06-23 20:32:52.544742	2022-06-23 20:32:55.96617	123
1624	86	329	291	600	Tom	1	3	2022-06-23 20:32:55.96617	2022-06-23 20:32:58.286698	123
1625	86	329	291	574	Agatha Christie	1	3	2022-06-23 20:32:58.286698	2022-06-23 20:33:03.922855	123
1626	86	329	291	572	Prince William	1	3	2022-06-23 20:33:03.922855	2022-06-23 20:33:10.194668	123
1627	86	329	291	540	Mr Strong	1	3	2022-06-23 20:33:10.194668	2022-06-23 20:33:16.026311	123
1628	86	329	291	602	Maleficent	1	3	2022-06-23 20:33:16.026311	2022-06-23 20:33:20.973253	123
1629	86	329	291	553	Hermione	0	3	2022-06-23 20:33:20.973253	2022-06-23 20:33:21.599102	123
1630	86	327	286	553	Hermione	1	3	2022-06-23 20:33:41.069274	2022-06-23 20:33:46.29989	124
1631	86	327	286	598	John lenon	1	3	2022-06-23 20:33:46.29989	2022-06-23 20:33:58.33047	124
1632	86	327	286	595	Annastacia Palaszczuk	1	3	2022-06-23 20:33:58.33047	2022-06-23 20:34:26.866351	124
1633	86	327	286	548	Gandalf	1	3	2022-06-23 20:34:26.866351	2022-06-23 20:34:31.474222	124
1634	86	327	286	542	Dr Hibert	0	3	2022-06-23 20:34:31.474222	2022-06-23 20:34:41.099018	124
1635	86	328	287	565	Paul Keating 	1	3	2022-06-23 20:35:04.451379	2022-06-23 20:35:16.662037	125
1636	86	328	287	542	Dr Hibert	1	3	2022-06-23 20:35:16.662037	2022-06-23 20:35:32.37302	125
1637	86	328	287	583	Bilbo Baggins	1	3	2022-06-23 20:35:32.37302	2022-06-23 20:35:43.047865	125
1638	86	328	287	561	Stalin 	1	3	2022-06-23 20:35:43.047865	2022-06-23 20:35:48.858246	125
1639	86	328	287	577	Spartacus	1	3	2022-06-23 20:35:48.858246	2022-06-23 20:36:00.13714	125
1640	86	328	287	568	Marie Antoinette	0	3	2022-06-23 20:36:00.13714	2022-06-23 20:36:04.451178	125
1641	86	329	292	591	Casey Briggs	1	3	2022-06-23 20:36:25.108313	2022-06-23 20:36:30.565224	126
1642	86	329	292	549	Peppa pig	1	3	2022-06-23 20:36:30.565224	2022-06-23 20:36:42.414596	126
1643	86	329	292	545	Elon Musk	1	3	2022-06-23 20:36:42.414596	2022-06-23 20:36:52.800695	126
1644	86	329	292	582	Judy Dench	1	3	2022-06-23 20:36:52.800695	2022-06-23 20:36:59.515726	126
1645	86	329	292	568	Marie Antoinette	1	3	2022-06-23 20:36:59.515726	2022-06-23 20:37:02.533227	126
1646	86	329	292	564	Roger Cook	0	3	2022-06-23 20:37:02.533227	2022-06-23 20:37:25.157784	126
1647	86	327	294	564	Roger Cook	1	3	2022-06-23 20:38:16.138237	2022-06-23 20:38:23.034475	127
1648	86	328	285	548	Gandalf	1	4	2022-06-23 20:39:28.066242	2022-06-23 20:39:32.014051	128
1649	86	328	285	596	The queen	1	4	2022-06-23 20:39:32.014051	2022-06-23 20:39:35.316906	128
1650	86	328	285	589	Liz Constable	1	4	2022-06-23 20:39:35.316906	2022-06-23 20:39:42.862503	128
1651	86	328	285	584	Brian Blessed	1	4	2022-06-23 20:39:42.862503	2022-06-23 20:39:46.841292	128
1652	86	328	285	595	Annastacia Palaszczuk	1	4	2022-06-23 20:39:46.841292	2022-06-23 20:40:19.046866	128
1653	86	328	285	563	Bob Katter 	1	4	2022-06-23 20:40:19.046866	2022-06-23 20:40:24.393923	128
1654	86	328	285	559	Ryan Gosling	0	4	2022-06-23 20:40:24.393923	2022-06-23 20:40:28.117942	128
1655	86	329	288	576	Tony Abbott 	1	4	2022-06-23 20:41:11.142726	2022-06-23 20:41:14.532421	129
1656	86	329	288	566	Nelson Muntz 	1	4	2022-06-23 20:41:14.532421	2022-06-23 20:41:19.723632	129
1657	86	329	288	571	Sean Connery 	1	4	2022-06-23 20:41:19.723632	2022-06-23 20:41:27.166231	129
1658	86	329	288	567	Al Pacino	1	4	2022-06-23 20:41:27.166231	2022-06-23 20:41:49.05954	129
1659	86	329	288	591	Casey Briggs	1	4	2022-06-23 20:41:49.05954	2022-06-23 20:42:06.516051	129
1660	86	329	288	587	Vladimir Putin	0	4	2022-06-23 20:42:06.516051	2022-06-23 20:42:11.153414	129
1661	86	327	289	544	Keanu Reeves	1	4	2022-06-23 20:42:41.271805	2022-06-23 20:42:46.409373	130
1662	86	327	289	581	The Hound 	1	4	2022-06-23 20:42:46.409373	2022-06-23 20:43:06.213322	130
1663	86	327	289	577	Spartacus	1	4	2022-06-23 20:43:06.213322	2022-06-23 20:43:22.492077	130
1664	86	327	289	546	Luigi	0	4	2022-06-23 20:43:22.492077	2022-06-23 20:43:41.28673	130
1665	86	328	293	552	Lady gaga	1	4	2022-06-23 20:44:01.979982	2022-06-23 20:44:19.199907	131
1666	86	328	293	592	Karen Fernandes	1	4	2022-06-23 20:44:19.199907	2022-06-23 20:44:27.544806	131
1667	86	328	293	554	Tom Cruise	1	4	2022-06-23 20:44:27.544806	2022-06-23 20:44:35.546742	131
1668	86	328	293	583	Bilbo Baggins	1	4	2022-06-23 20:44:35.546742	2022-06-23 20:44:59.000154	131
1669	86	328	293	590	Jane Prince	0	4	2022-06-23 20:44:59.000154	2022-06-23 20:45:01.993392	131
1670	86	329	291	588	Volodimir Zelensky	1	4	2022-06-23 20:45:39.174208	2022-06-23 20:45:46.594651	132
1671	86	329	291	599	Shakira	1	4	2022-06-23 20:45:46.594651	2022-06-23 20:45:50.124705	132
1672	86	329	291	560	Light Yagami	1	4	2022-06-23 20:45:50.124705	2022-06-23 20:45:56.533307	132
1673	86	329	291	598	John lenon	1	4	2022-06-23 20:45:56.533307	2022-06-23 20:45:59.994435	132
1674	86	329	291	562	Ricky Ponting 	1	4	2022-06-23 20:45:59.994435	2022-06-23 20:46:03.531195	132
1675	86	329	291	557	Kevin Rudd	1	4	2022-06-23 20:46:03.531195	2022-06-23 20:46:11.2127	132
1676	86	329	291	587	Vladimir Putin	1	4	2022-06-23 20:46:11.2127	2022-06-23 20:46:16.960831	132
1677	86	329	291	574	Agatha Christie	1	4	2022-06-23 20:46:16.960831	2022-06-23 20:46:20.451159	132
1678	86	329	291	545	Elon Musk	1	4	2022-06-23 20:46:20.451159	2022-06-23 20:46:25.829841	132
1679	86	329	291	575	Pudge	1	4	2022-06-23 20:46:25.829841	2022-06-23 20:46:32.648436	132
1680	86	329	291	590	Jane Prince	0	4	2022-06-23 20:46:32.648436	2022-06-23 20:46:39.177536	132
1681	86	327	286	601	Snow white	1	4	2022-06-23 20:47:46.02622	2022-06-23 20:48:03.680615	133
1682	86	327	286	540	Mr Strong	1	4	2022-06-23 20:48:03.680615	2022-06-23 20:48:08.04129	133
1683	86	327	286	555	Bojack Horseman	1	4	2022-06-23 20:48:08.04129	2022-06-23 20:48:14.583241	133
1684	86	327	286	594	Banjo	1	4	2022-06-23 20:48:14.583241	2022-06-23 20:48:19.574877	133
1685	86	327	286	570	Serena Williams	1	4	2022-06-23 20:48:19.574877	2022-06-23 20:48:31.383187	133
1686	86	327	286	564	Roger Cook	1	4	2022-06-23 20:48:31.383187	2022-06-23 20:48:37.176094	133
1687	86	327	286	558	Lorde	1	4	2022-06-23 20:48:37.176094	2022-06-23 20:48:41.128665	133
1688	86	327	286	602	Maleficent	0	4	2022-06-23 20:48:41.128665	2022-06-23 20:48:46.031567	133
1689	86	328	287	553	Hermione	1	4	2022-06-23 20:49:38.438858	2022-06-23 20:49:51.265206	134
1690	86	328	287	547	Sponje bob	1	4	2022-06-23 20:49:51.265206	2022-06-23 20:49:59.204973	134
1691	86	328	287	602	Maleficent	0	4	2022-06-23 20:49:59.204973	2022-06-23 20:50:38.451696	134
1692	86	329	292	568	Marie Antoinette	1	4	2022-06-23 20:50:57.125967	2022-06-23 20:50:59.888218	135
1693	86	329	292	572	Prince William	1	4	2022-06-23 20:50:59.888218	2022-06-23 20:51:08.135825	135
1694	86	329	292	559	Ryan Gosling	1	4	2022-06-23 20:51:08.135825	2022-06-23 20:51:52.083092	135
1695	86	329	292	543	The fat controller 	1	4	2022-06-23 20:51:52.083092	2022-06-23 20:51:55.755705	135
1696	86	329	292	573	Jesus	0	4	2022-06-23 20:51:55.755705	2022-06-23 20:51:57.181973	135
1697	86	327	294	549	Peppa pig	1	4	2022-06-23 20:52:37.844147	2022-06-23 20:52:41.698411	136
1698	86	327	294	542	Dr Hibert	1	4	2022-06-23 20:52:41.698411	2022-06-23 20:52:50.376207	136
1699	86	327	294	573	Jesus	1	4	2022-06-23 20:52:50.376207	2022-06-23 20:52:55.671546	136
1700	86	327	294	585	Ingo Patrikas	0	4	2022-06-23 20:52:55.671546	2022-06-23 20:53:37.850383	136
1701	86	328	285	597	Fred mercury	1	4	2022-06-23 20:54:10.478211	2022-06-23 20:54:22.421285	137
1702	86	328	285	593	Kate Chaney	1	4	2022-06-23 20:54:22.421285	2022-06-23 20:54:38.3304	137
1703	86	328	285	582	Judy Dench	0	4	2022-06-23 20:54:38.3304	2022-06-23 20:55:10.528289	137
1704	86	329	288	602	Maleficent	1	4	2022-06-23 20:55:57.205026	2022-06-23 20:56:04.040479	138
1705	86	329	288	561	Stalin 	1	4	2022-06-23 20:56:04.040479	2022-06-23 20:56:07.870405	138
1706	86	329	288	586	Pope Francis	1	4	2022-06-23 20:56:07.870405	2022-06-23 20:56:13.436731	138
1707	86	329	288	582	Judy Dench	1	4	2022-06-23 20:56:13.436731	2022-06-23 20:56:45.33608	138
1708	86	329	288	580	Dendi	0	4	2022-06-23 20:56:45.33608	2022-06-23 20:56:57.166503	138
1709	86	327	289	578	Snape	1	4	2022-06-23 20:57:23.275226	2022-06-23 20:57:34.730767	139
1710	86	327	289	590	Jane Prince	1	4	2022-06-23 20:57:34.730767	2022-06-23 20:57:58.407369	139
1711	86	327	289	565	Paul Keating 	1	4	2022-06-23 20:57:58.407369	2022-06-23 20:58:21.846943	139
1712	86	327	289	579	Saruman	0	4	2022-06-23 20:58:21.846943	2022-06-23 20:58:23.279055	139
1713	86	328	293	579	Saruman	0	4	2022-06-23 20:59:29.245362	2022-06-23 21:00:29.24416	140
1714	86	329	291	569	Marie Curie	1	4	2022-06-23 21:01:04.301007	2022-06-23 21:01:17.239044	141
1715	86	329	291	551	Scooby doo	1	4	2022-06-23 21:01:17.239044	2022-06-23 21:01:22.559698	141
1716	86	329	291	580	Dendi	1	4	2022-06-23 21:01:22.559698	2022-06-23 21:01:29.580479	141
1717	86	329	291	550	Karen ,speak to the manager 	1	4	2022-06-23 21:01:29.580479	2022-06-23 21:01:36.67823	141
1718	86	329	291	600	Tom	1	4	2022-06-23 21:01:36.67823	2022-06-23 21:01:39.03163	141
1719	86	329	291	556	Henry Cavill	1	4	2022-06-23 21:01:39.03163	2022-06-23 21:01:48.439996	141
1720	86	329	291	585	Ingo Patrikas	1	4	2022-06-23 21:01:48.439996	2022-06-23 21:01:52.884955	141
1721	86	329	291	579	Saruman	1	4	2022-06-23 21:01:52.884955	2022-06-23 21:01:58.738655	141
1722	86	329	291	541	Overly Excited Girlfriend 	1	4	2022-06-23 21:01:58.738655	2022-06-23 21:02:03.319709	141
1723	86	329	291	546	Luigi	0	4	2022-06-23 21:02:03.319709	2022-06-23 21:02:04.303742	141
1724	86	327	286	546	Luigi	1	4	2022-06-23 21:02:38.394424	2022-06-23 21:02:50.240651	142
\.


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

COPY public.games (game_id, game_name, active, stage, round, number_teams, number_names, time_limit, round1, round2, round3, round4, date_created) FROM stdin;
81	Birthday 2	t	4	4	2	7	60	1	1	1	1	2022-06-20 20:07:34.226029
82	Ybyg	f	1	4	2	10	60	1	1	1	1	2022-06-20 20:37:13.935421
83	Test 123	f	3	4	2	4	30	1	1	1	1	2022-06-23 16:44:03.855906
76	hax	f	2	4	3	10	60	1	1	1	1	2022-06-18 18:58:48.87708
77	test team	f	1	4	2	10	60	1	1	1	1	2022-06-19 19:08:26.729228
71	awda	f	1	4	3	10	60	1	1	1	1	2022-06-18 17:30:05.631789
68	dwadwadwa	f	1	4	3	10	60	1	1	1	1	2022-06-18 11:40:56.426449
65	T	f	3	4	1	10	60	1	1	1	1	2022-06-17 20:38:53.644184
62	Toms game	f	4	4	2	10	60	1	1	1	1	2022-06-16 21:14:50.166239
52	\\b	f	1	4	3	10	60	1	1	1	1	2022-06-12 21:50:16.075117
47	FINAL TEST	f	4	4	2	10	60	1	1	1	1	2022-06-12 20:43:34.846729
49	kkkkkkkkkkk	f	3	4	2	10	60	1	1	1	1	2022-06-12 21:21:33.276116
51	solo	f	3	4	1	10	60	1	1	1	1	2022-06-12 21:28:53.550161
53	asdwa	f	1	4	3	10	60	1	1	1	1	2022-06-12 21:50:51.580027
57	fsdfsefs	f	2	4	1	10	60	1	1	1	1	2022-06-12 21:58:46.81181
56	dsdad	f	1	4	3	10	60	1	1	1	1	2022-06-12 21:58:41.853051
1	Insert Name Here	f	3	4	3	10	60	1	1	1	1	2022-06-05 15:08:45.45293
2	Insert Name Here	f	3	4	1	10	60	1	1	1	1	2022-06-05 15:09:20.530039
3	Insert Name Here	f	3	4	1	10	60	1	1	1	1	2022-06-05 15:35:09.792856
6	AA	f	3	4	1	10	60	1	1	1	1	2022-06-05 16:05:21.346796
5	A	f	1	4	3	10	60	1	1	1	1	2022-06-05 16:05:10.986097
4	test	f	3	4	1	10	60	1	1	1	1	2022-06-05 16:02:08.979768
7	Aaaaaa	f	3	4	1	10	60	1	1	1	1	2022-06-05 16:39:28.761938
8	Toms game	f	3	4	3	10	60	1	1	1	1	2022-06-05 16:51:27.482552
10	Insert Name Here	f	1	4	3	10	60	1	1	1	1	2022-06-05 20:58:45.447094
9	speed the fwuk	f	1	4	2	3	60	1	1	1	1	2022-06-05 20:58:10.840079
28	Mcelhinney-dev-chandler	f	3	4	2	10	60	1	1	1	1	2022-06-11 19:18:22.313993
25	New game	f	3	4	1	10	60	1	1	1	1	2022-06-09 20:58:41.974859
31	hacks	f	3	4	3	10	60	1	1	1	1	2022-06-11 22:22:13.804869
45	Djjsjs	f	3	4	3	10	60	1	1	1	1	2022-06-12 18:33:51.327615
50	game50	f	4	4	2	10	60	1	1	1	1	2022-06-12 21:23:12.999627
54	ddada	f	2	4	1	10	60	1	1	1	1	2022-06-12 21:53:54.196671
79	Testing timer	f	4	4	2	10	60	1	1	1	1	2022-06-19 22:45:35.766074
80	Dirthbay	t	2	4	2	7	60	1	1	1	1	2022-06-20 19:46:37.097713
58	dwadwa	f	1	4	3	10	60	1	1	1	1	2022-06-12 22:00:09.165436
33	jinkies	f	3	4	2	10	60	1	1	1	1	2022-06-12 12:08:54.448858
38	aaaaaaaaaaa	f	2	4	1	10	60	1	1	1	1	2022-06-12 16:50:18.656959
20	n	f	1	4	3	10	60	1	1	1	1	2022-06-08 22:15:36.413768
21	lm	f	1	4	3	10	60	1	1	1	1	2022-06-08 22:20:55.497407
84	asdfasdf	f	3	4	2	10	60	1	1	1	1	2022-06-23 17:08:37.813511
22	aa	f	1	4	3	10	60	1	1	1	1	2022-06-08 22:26:14.499237
23	Cnnd	f	1	4	3	10	60	1	1	1	1	2022-06-08 22:27:59.298271
24	asx	f	1	4	3	10	60	1	1	1	1	2022-06-08 22:29:52.977684
11	not the munns distance	f	3	4	2	3	60	1	1	1	1	2022-06-05 21:19:35.14889
27	AAAAAAAAA	f	3	4	2	10	60	1	1	1	1	2022-06-09 21:52:35.797105
26	Test ppl	f	3	4	2	10	60	1	1	1	1	2022-06-09 21:39:13.11183
63	Bbbxbhsbz	f	3	4	1	10	60	1	1	1	1	2022-06-16 21:51:31.403241
64	New gamee	f	3	4	1	10	60	1	1	1	1	2022-06-17 20:30:21.829501
36	fdfddfaafd	f	3	4	1	10	60	1	1	1	1	2022-06-12 16:44:51.121404
35	fdsasdf	f	3	4	1	10	60	1	1	1	1	2022-06-12 16:36:43.242426
29	NEW FAMILY GAME	f	3	4	2	10	60	1	1	1	1	2022-06-11 19:24:51.417087
30	New new fam gam	f	3	4	2	10	60	1	1	1	1	2022-06-11 20:29:20.289937
42	kkkkkkk	f	1	4	3	10	60	1	1	1	1	2022-06-12 17:59:01.83734
41	test team	f	1	4	2	10	60	1	1	1	1	2022-06-12 17:58:46.99181
15	Insert Name Here	f	3	4	1	10	60	1	1	1	1	2022-06-05 22:11:35.951052
19	ad	f	1	4	3	10	60	0	0	0	1	2022-06-08 21:47:45.797228
18		f	1	4	3	10	60	1	1	1	1	2022-06-08 21:45:24.202915
17		f	1	4	3	10	60	1	1	1	1	2022-06-08 21:45:20.18301
16		f	1	4	3	10	60	1	1	1	1	2022-06-08 21:24:34.120732
14	Insert Name Here	f	1	4	3	10	60	1	1	1	1	2022-06-05 22:07:40.07143
44	test	f	3	4	1	10	60	1	1	1	1	2022-06-12 18:04:14.020939
46	asdsa	f	3	4	2	10	60	1	1	1	1	2022-06-12 19:03:01.951333
48	test 2	f	4	4	2	10	60	1	1	1	1	2022-06-12 21:02:42.286287
85	Toms birthday 	f	1	4	3	10	60	1	1	1	1	2022-06-23 19:14:52.378732
55	dwadaw	f	2	4	1	10	60	1	1	1	1	2022-06-12 21:55:05.782214
13	Insert Name Here	f	3	4	1	10	60	1	1	1	1	2022-06-05 21:50:53.129052
12	Insert Name Here	f	1	4	3	10	60	1	1	1	1	2022-06-05 21:50:00.192262
73	waasd	f	1	4	3	10	60	1	1	1	1	2022-06-18 17:31:20.398102
72	awda	f	1	4	3	10	60	1	1	1	1	2022-06-18 17:31:15.444485
69	daw	f	1	4	3	10	60	1	1	1	1	2022-06-18 12:26:49.85862
66	dwada	f	2	4	3	10	60	1	1	1	1	2022-06-17 21:16:10.866667
32	game	f	3	4	2	16	60	1	1	1	1	2022-06-12 09:47:18.991008
37	sssssssss	f	3	4	1	10	60	1	1	1	1	2022-06-12 16:47:04.481917
34	asdfsdf	f	1	4	3	10	60	1	1	1	1	2022-06-12 16:18:06.323672
39	asdsa	f	1	4	3	10	59	1	1	1	1	2022-06-12 17:16:33.826788
43	test team	f	1	4	3	10	60	1	1	1	1	2022-06-12 18:01:50.489638
40	Aaaaaaàa	f	3	4	2	10	60	1	1	1	1	2022-06-12 17:18:08.184322
59	dawdaw	f	2	4	1	10	60	1	1	1	1	2022-06-12 22:00:20.310269
60	dAWDAWD	f	1	4	3	10	60	1	1	1	1	2022-06-16 19:21:04.954641
61	Interesting Name	f	4	4	2	10	60	1	1	1	1	2022-06-16 20:37:23.125381
67	Test Game 35	t	4	4	1	5	30	1	1	1	0	2022-06-17 21:28:50.860305
70	Test ppl	f	1	4	3	10	60	1	1	1	1	2022-06-18 15:36:09.234926
74	Test ppl	f	1	4	3	10	60	1	1	1	1	2022-06-18 18:10:13.161689
75	Test ppl	t	3	4	2	10	60	1	1	1	1	2022-06-18 18:11:49.978421
78	Tome's Game	f	3	4	2	10	60	1	1	1	1	2022-06-19 21:15:13.878322
86	Toms birthday 	t	4	4	3	7	60	1	1	1	1	2022-06-23 19:15:30.49343
\.


--
-- Data for Name: mp3_order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.mp3_order (number_stops, current_stop, number_starts, current_start) FROM stdin;
13	2	18	6
\.


--
-- Data for Name: names; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.names (name_id, game_id, user_inst_id, name) FROM stdin;
80	2	118	Tom McElhinney
81	2	118	Tom McElhinney
82	2	118	Tom McElhinney
83	2	118	Tom McElhinney
84	2	118	Tom McElhinney
85	2	118	Tom McElhinney
86	2	118	Tom McElhinney
87	2	118	Tom McElhinney
88	2	118	Tom McElhinney
89	3	119	Tom McElhinney
90	3	119	Tom McElhinney
91	3	119	Tom McElhinney
92	3	119	Tom McElhinney
93	3	119	Tom McElhinney
94	3	119	Tom McElhinney
95	3	119	Tom McElhinney
96	3	119	Tom McElhinney
97	3	119	Tom McElhinney
98	4	120	Tom McElhinney 1
99	4	120	Tom McElhinney 2
100	4	120	Tom McElhinney 3
101	4	120	Tom McElhinney 4
102	4	120	Tom McElhinney 5
103	4	120	Tom McElhinney 6
104	4	120	Tom McElhinney 7
105	4	120	Tom McElhinney 8
106	4	120	Tom McElhinney 9
107	4	120	Tom McElhinney 10
108	6	122	Tom McElhinney 1
109	6	122	Tom McElhinney 2
110	6	122	Tom McElhinney 6
111	6	122	Tom McElhinney 3
112	6	122	Tom McElhinney 4
113	6	122	Tom McElhinney 5
114	6	122	Tom McElhinney 7
115	6	122	Tom McElhinney 8
116	6	122	Tom McElhinney 9
117	6	122	Tom McElhinney 10
118	7	123	Tom McElhinney 1
119	7	123	Tom McElhinney 2
120	7	123	Tom McElhinney 3
121	7	123	Tom McElhinney4 
122	7	123	Tom McElhinney 5
123	7	123	Tom McElhinney 6
124	7	123	Tom McElhinney 7
125	8	124	Jk rowling
126	8	124	Dumbledore
127	8	124	Amber heard
128	8	124	Jake Gyllenhaal
129	8	124	Frosty the snowman
130	8	124	Peter knight
131	8	124	Sarah knight
132	8	126	Dwayne the rock johnson
133	8	125	Tom McElhinney
134	8	125	Harry Manson
135	8	125	Paul Francis
136	8	125	Hugo Innes
137	8	125	Anna Chandler
138	11	130	viper
139	11	130	james
140	11	130	windi
141	11	131	Smeagol / Gollum
142	11	131	The whomping willow
143	11	131	Pudge
144	13	133	Tom McElhinney
145	13	133	Tom McElhinney
146	13	133	Tom McElhinney
147	13	133	Tom McElhinney
148	13	133	Tom McElhinney
149	13	133	Tom McElhinney
150	13	133	Tom McElhinney
151	13	133	Tom McElhinney
152	13	133	Tom McElhinney
153	15	135	Tom McElhinney
154	15	135	Tom McElhinney
155	15	135	Tom McElhinney
156	15	135	Tom McElhinney
157	15	135	Tom McElhinney
158	15	135	Tom McElhinney
159	15	135	Tom McElhinney
160	15	135	Tom McElhinney
161	15	135	Tom McElhinney
162	25	147	fuck
163	25	147	lol
164	25	147	tom
165	25	147	jorge
166	25	147	daniel nguyen
167	25	147	asdf
168	25	147	bongo
169	27	153	aaaaaa
170	27	153	dddddddd
171	27	153	fffffff
172	27	153	cccccccc
173	28	156	Tom cruise
174	29	165	Tom cruise
175	29	165	Amber Heard
176	29	165	Johnny Depp
177	29	165	Donald Trump
178	29	165	Justin Beiber
179	29	165	Scomo
180	29	165	Peter Dutton
181	29	165	Albanese
182	29	165	Queen Elizabeth
183	29	165	Picasso
184	29	166	Tony Abbott
185	29	166	Pepe the frog
186	29	166	Donald Trump
187	29	166	Bolsonaro
188	29	166	Arnold Schwarzenegger
189	29	166	Josh Frydenberg
190	29	166	Hugo Innes
191	29	166	Harry Manson
192	29	166	Anthea
193	29	166	Barack Obama
194	29	162	Donald trump
195	29	162	Iron man
196	29	162	Madonna
197	29	162	Monalisa
198	29	162	Hillary clinton
199	29	162	Gladys
200	29	162	Tom cruise
201	29	162	Eva
202	29	162	Fred Flintstone 
203	29	162	Sponge bob
204	29	167	Tom cruise
205	29	167	Ànthony albonese
206	29	167	Michael jordan
207	29	167	Mark twain
208	29	167	Britney Spears 
209	29	167	Justin Beiber 
210	29	167	Donald Trump 
211	29	167	Boris Johnson 
212	29	167	Kylie Jenner 
213	29	167	The Pope 
214	30	170	Harry Potter
215	30	170	Julia Gillard 
216	30	170	Melania Trump
217	30	170	Mel Gibson
218	30	170	Justin Timberlake
219	30	170	Seth McFarlane
220	30	170	Homer Simpson
221	30	170	Shrek
222	30	170	Prince Andrew
223	30	170	Santa Clause
224	30	171	Jacinta Ardern
225	30	171	Rob
226	30	171	Cleo
227	30	171	Ted
228	30	171	Popeye
229	30	171	Mickey mouse
230	30	171	Osama bin Laden 
231	30	171	George bush
232	30	171	Kylie Minogue 
233	30	171	Putin
234	30	172	Mark mcgowan
235	30	172	Auntie pauline
236	30	172	Caroline potter
237	30	172	Princess margaret
238	30	172	Prince andrew
239	30	172	King george IV
240	30	172	Mick jagger
241	30	172	Kate bush
242	30	172	Kim kardashian
243	30	172	Bob dylan
244	30	173	Peppa pig
245	30	173	Cheer
246	30	173	Adele
247	30	173	Gandalf
248	30	173	Dyanerys
249	30	173	Lady Di
250	30	173	Einsten
251	30	173	Ramses II
252	30	173	Dracula
253	30	173	Queen victoria
254	30	168	Adolf Hitler
255	30	168	Smeagol / Gollum
256	30	168	Jaimie Lannister
257	30	168	Margaret Thatcher
258	30	168	Vladimir Putin
259	30	168	Zelensky
260	30	168	Helena Bonham Carter
261	30	168	Dwayne "the rock" johnson
262	30	168	Ringo Starr
263	30	168	Alan Rickman
264	30	169	Elon Musk
265	30	169	Ivanka Trump
266	30	169	Kate Bush
267	30	169	George Bush
268	30	169	Steve Jobs
269	30	169	Miley Cyrus
270	30	169	Julia Gillard
271	30	169	Bill Gates
272	30	169	Mark McGowan
273	30	169	Sting (singer)
274	38	184	Tom McElhinney
275	38	184	Tom McElhinney
276	38	184	Tom McElhinney
277	38	184	Tom McElhinney
278	38	184	Tom McElhinney
279	38	184	Tom McElhinney
280	38	184	Tom McElhinney
281	38	184	Tom McElhinney
282	38	184	Tom McElhinney
283	40	188	Tom McElhinney
284	40	188	Tom McElhinney
285	40	188	Tom McElhinney
286	40	188	Tom McElhinney
287	40	188	Tom McElhinney
288	40	188	Tom McElhinney
289	40	188	Tom McElhinney
290	40	188	Tom McElhinney
291	40	188	Tom McElhinney
292	44	190	Tom McElhinney
293	44	190	Tom McElhinney
294	44	190	Tom McElhinney
295	44	190	Tom McElhinney
296	44	190	Tom McElhinney
297	44	190	Tom McElhinney
298	44	190	Tom McElhinney
299	44	190	Tom McElhinney
300	44	190	Tom McElhinney
301	44	192	Taa
302	44	191	oihlo
303	46	198	Gchsux
304	46	197	oiu
305	46	197	Tom McElhinney
306	46	197	Tom McElhinney
307	46	197	Tom McElhinney
308	46	197	Tom McElhinney
309	46	197	Tom McElhinney
310	46	197	Tom McElhinney
311	46	197	Tom McElhinney
312	46	197	Tom McElhinney
313	46	197	Tom McElhinney
314	46	196	ghkiuyg
315	45	194	Tom McElhinney
316	45	194	Tom McElhinney
317	45	194	Tom McElhinney
318	45	194	Tom McElhinney
319	45	194	Tom McElhinney
320	45	194	Tom McElhinney
321	45	194	Tom McElhinney
322	45	194	Tom McElhinney
323	45	194	Tom McElhinney
324	45	195	awd
325	45	193	Dhs
326	47	201	Phone
327	47	199	chrome
328	47	200	edge
329	48	202	tgdgtd
330	48	203	liuh
331	48	204	Fhbxs
332	49	205	liuhliou
333	49	206	lkjlkj
334	49	207	Ygyff
335	50	209	hi
336	50	208	bhb
337	50	210	Yfctuct
338	51	211	asdasd
339	54	213	awdawd
340	55	214	Tom McElhinney
341	55	214	Tom McElhinney
342	55	214	Tom McElhinney
343	55	214	Tom McElhinney
344	55	214	Tom McElhinney
345	55	214	Tom McElhinney
346	55	214	Tom McElhinney
347	55	214	Tom McElhinney
348	55	214	Tom McElhinney
349	57	215	yy
350	57	215	y
351	57	215	y
352	57	215	y
353	57	215	u
354	61	220	a
355	61	220	b
356	61	219	C
357	61	219	D
358	62	221	A
359	62	221	B
360	62	222	C
361	62	222	D
362	62	223	E
363	62	223	F
364	63	224	F
365	63	224	D
366	63	224	S
367	63	224	C
368	63	224	C
369	63	224	C
370	63	224	C
371	63	224	C
372	63	224	Z
373	63	224	Z
374	64	225	A
375	64	225	B
376	64	225	C
377	64	225	D
378	64	225	E
379	64	225	F
380	64	225	G
381	64	225	H
382	64	225	I
383	64	225	J
384	65	226	a
385	65	226	b
386	65	226	c
387	65	226	d
388	65	226	e
389	65	226	f
390	67	229	John Travolta
391	67	229	Paul
392	67	229	Boris Johnson
393	67	229	A380
394	67	229	of course you can feel the sawls
395	67	230	Murray Thomas
396	67	230	Alex Tonkin
397	67	230	Agamemnon
398	67	230	Robbie Katter
399	67	230	GLaDOS
400	75	244	HHHH
401	75	244	GGGG
402	75	244	JJJJ
403	75	242	AWDAWD
404	75	242	ADWAWD
405	75	242	dsaASD
406	75	243	Gshshx
407	75	243	Cbnsnz
408	75	243	Chidizjcj
409	76	250	Gautama Buddha
410	76	250	Steve Jobs
411	76	250	Princess Diana
412	76	250	Neil Armstrong
413	76	250	Al Pacino
414	76	250	Stephen Hawking
415	76	250	Napoleon
416	76	250	Florence Nightingale
417	76	250	Amy Winehouse
418	76	250	Confucius
419	78	252	Marco Polo
420	78	252	Muammar Gaddafi
421	78	253	Gal Gadot
422	78	253	Muhammad Ali
423	78	253	Rami Malek
424	78	253	Wolfgang Amadeus Mozart
425	78	253	Virginia Woolf
426	78	253	Isaac Newton
427	78	253	Kylie Jenner
428	78	253	Marilyn Monroe
429	78	253	John Lennon
430	78	253	Chris Hemsworth
431	79	255	Shia LaBeouf
432	79	255	Pope Francis
433	79	255	Lady Gaga
434	79	255	Drake
435	79	255	Archimedes
436	79	255	Yuri Gagarin
437	79	255	Pol Pot
438	79	255	Vincent van Gogh
439	79	255	Gal Gadot
440	79	255	Warren Buffett
441	79	254	Julie Andrews
442	80	259	Nicole Kidman
443	80	259	Cat in the Hat
444	80	259	Barbie
445	80	259	Elvis
446	80	259	Jane Austen
447	80	259	Ned Kelly
448	80	259	King Henry VIII
449	80	260	Vincent van gogh
450	80	260	Stalin 
451	80	260	Greta thunberg
452	80	260	James Cook 
453	80	260	Pele
454	80	260	Greg Norman 
455	80	260	Crocodile Dundee
456	80	262	Sia
457	80	262	Beyonce
458	80	262	Shakira
459	80	262	Whitney Huston
460	80	262	Lady gaga
461	80	262	Michael jackson
462	80	262	Rihanna
463	80	257	George Harrison
464	80	257	Karl Marx
465	80	257	Jesus
466	80	257	Nelson Mandela
467	80	257	Bolsonaro
468	80	257	Satoshi Nakamoto
469	80	257	J. R. R. Tolkien
470	80	261	Karl kruzulnitsky
471	80	261	Boris johnson
472	80	261	Mick jagger
473	80	261	Twiggy forrest
474	80	261	John Lennon
475	80	261	Amy Winehouse
476	80	261	Vincent van Gogh
477	80	258	Colonel Sanders
478	80	258	Rick Sanchez
479	80	258	Marty Mcfly
480	80	258	 Kevin Parker
481	80	258	 Alex jones
482	80	258	 Satoshi Nakamoto
483	80	258	A minion
484	81	266	Sia
485	81	266	Beyonce 
486	81	266	Rihanna
487	81	266	Whitney Huston 
488	81	266	Michael Jackson
489	81	266	Lady Gaga
490	81	266	Celine Dion
491	81	263	George Harrison
492	81	263	Karl Marx
493	81	263	Jesus
494	81	263	Nelson Mandela
495	81	263	Bolsonaro
496	81	263	Satoshi Nakamoto
497	81	263	J. R. R. Tolkein
498	81	268	Rick Sanchez
499	81	268	Alex jones
500	81	268	George Washington
501	81	268	Jake the dog
502	81	268	Colonel Sanders
503	81	268	A minion
504	81	268	Kevin Parker
505	81	264	King Henry VIII
506	81	264	Jane Austen
507	81	264	Ned Kelly
508	81	264	Harold Holt
509	81	264	Elvis
510	81	264	Marie Antoinette
511	81	264	Ryan Reynolds
512	81	269	Nelson Mandela 
513	81	269	Vincent Van Gogh 
514	81	269	Shakespeare 
515	81	269	Pele
516	81	269	Bob Marley
517	81	269	Aristotle
518	81	269	Greta Thunberg
519	81	270	Karl kruzulnitsky
520	81	270	Vincent van gogh
521	81	270	Cleopatra
522	81	270	Amy winehouse
523	81	270	Ludwig van Beethoven
524	81	270	Twiggy forrest
525	81	270	Julius caesar
526	83	276	Emilia Clarke
527	83	276	Alexander the Great
528	83	276	Leonard Cohen
529	83	276	Mary, mother of Jesus
530	83	275	Anne Boleyn
531	83	275	Kirsten Dunst
532	83	275	Alexander the Great
533	83	275	Billie Eilish
534	84	278	Aristotle
535	84	278	Margot Robbie
536	84	278	Drake
537	84	277	Usain Bolt
538	84	277	Hans Christian Andersen
539	84	277	George W. Bush
540	86	285	Mr Strong
541	86	285	Overly Excited Girlfriend 
542	86	285	Dr Hibert
543	86	285	The fat controller 
544	86	285	Keanu Reeves
545	86	285	Elon Musk
546	86	285	Luigi
547	86	294	Sponje bob
548	86	294	Gandalf
549	86	294	Peppa pig
550	86	294	Karen ,speak to the manager 
551	86	294	Scooby doo
552	86	294	Lady gaga
553	86	294	Hermione
554	86	289	Tom Cruise
555	86	289	Bojack Horseman
556	86	289	Henry Cavill
557	86	289	Kevin Rudd
558	86	289	Lorde
559	86	289	Ryan Gosling
560	86	289	Light Yagami
561	86	292	Stalin 
562	86	292	Ricky Ponting 
563	86	292	Bob Katter 
564	86	292	Roger Cook
565	86	292	Paul Keating 
566	86	292	Nelson Muntz 
567	86	292	Al Pacino
568	86	288	Marie Antoinette
569	86	288	Marie Curie
570	86	288	Serena Williams
571	86	288	Sean Connery 
572	86	288	Prince William
573	86	288	Jesus
574	86	288	Agatha Christie
575	86	286	Pudge
576	86	286	Tony Abbott 
577	86	286	Spartacus
578	86	286	Snape
579	86	286	Saruman
580	86	286	Dendi
581	86	286	The Hound 
582	86	291	Judy Dench
583	86	291	Bilbo Baggins
584	86	291	Brian Blessed
585	86	291	Ingo Patrikas
586	86	291	Pope Francis
587	86	291	Vladimir Putin
588	86	291	Volodimir Zelensky
589	86	287	Liz Constable
590	86	287	Jane Prince
591	86	287	Casey Briggs
592	86	287	Karen Fernandes
593	86	287	Kate Chaney
594	86	287	Banjo
595	86	287	Annastacia Palaszczuk
596	86	293	The queen
597	86	293	Fred mercury
598	86	293	John lenon
599	86	293	Shakira
600	86	293	Tom
601	86	293	Snow white
602	86	293	Maleficent
\.


--
-- Data for Name: players_turn_order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.players_turn_order (team_id, players_array, number_players, current_player) FROM stdin;
146	{34}	1	0
165	{34}	1	0
205	{34,35}	2	1
206	{40}	1	0
323	{106}	1	0
210	{42,45}	2	0
209	{43,44,46}	3	1
322	{105}	1	0
311	{85}	1	0
310	{86}	1	0
149	{34}	1	0
277	{55}	1	0
155	{34}	1	0
276	{53,54}	2	0
224	{49}	1	0
170	{34}	1	0
158	{38}	1	0
159	{37}	1	0
157	{34}	1	0
202	{40,34,35}	3	0
208	{42,45}	2	0
150	{34}	1	0
207	{43,44,46}	3	1
156	{34}	1	0
245	{52}	1	0
244	{41,35}	2	0
203	{40,35}	2	1
204	{34}	1	0
174	{34}	1	0
151	{34}	1	0
225	{49}	1	0
304	{76}	1	0
250	{49,35}	2	0
251	{52}	1	0
275	{53}	1	0
243	{35}	1	0
241	{52}	1	0
230	{52}	1	0
166	{38}	1	0
231	{49}	1	0
242	{49}	1	0
212	{43,44,46}	3	2
211	{42,45,47}	3	0
213	{48,41}	2	1
217	{41}	1	0
274	{54}	1	0
303	{56,77}	2	1
218	{50}	1	0
328	{113,107,109}	3	1
329	{106,108,110}	3	1
219	{51}	1	0
327	{112,114,111}	3	1
321	{106}	1	0
320	{105}	1	0
247	{52}	1	0
246	{49,35}	2	1
278	{54}	1	0
223	{49}	1	0
253	{52}	1	0
252	{49,35}	2	1
240	{49,35,52}	3	1
284	{55,63}	2	1
313	{86}	1	0
279	{57}	1	0
312	{85}	1	0
248	{49,35}	2	0
249	{52}	1	0
254	{49}	1	0
317	{97,104,103}	3	0
316	{102,100,86}	3	1
280	{56}	1	0
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teams (team_id, game_id, team_name, round1score, round2score, round3score, round4score, final_score) FROM stdin;
146	1	bmiR2	\N	\N	\N	\N	\N
147	1	QxKLO	\N	\N	\N	\N	\N
148	1	jLwLh	\N	\N	\N	\N	\N
149	2	c0Z2v	\N	\N	\N	\N	\N
150	3	Zugm3	\N	\N	\N	\N	\N
151	4	eAE7v	\N	\N	\N	\N	\N
152	5	SxDIh	\N	\N	\N	\N	\N
153	5	aCoOz	\N	\N	\N	\N	\N
154	5	eCXDt	\N	\N	\N	\N	\N
155	6	TEAM	\N	\N	\N	\N	\N
156	7	weLsR	\N	\N	\N	\N	\N
157	8	TFNXi	\N	\N	\N	\N	\N
158	8	p8ISg	\N	\N	\N	\N	\N
159	8	IDHOV	\N	\N	\N	\N	\N
162	10	xBhAw	\N	\N	\N	\N	\N
163	10	IbxGy	\N	\N	\N	\N	\N
164	10	K3nCo	\N	\N	\N	\N	\N
161	9	dwadwawdsasdsad	\N	\N	\N	\N	\N
284	67	Team of Test	\N	\N	\N	\N	\N
160	9	WWWWWWW	\N	\N	\N	\N	\N
165	11	the pilkos	\N	\N	\N	\N	\N
166	11	Tomes Teames	\N	\N	\N	\N	\N
167	12	0NPmx	\N	\N	\N	\N	\N
168	12	2dtsv	\N	\N	\N	\N	\N
169	12	xWTh3	\N	\N	\N	\N	\N
170	13	xNeaa	\N	\N	\N	\N	\N
171	14	yijry	\N	\N	\N	\N	\N
172	14	Hbw3i	\N	\N	\N	\N	\N
173	14	xAyZ2	\N	\N	\N	\N	\N
174	15	PJQzc	\N	\N	\N	\N	\N
175	16	Corwh	\N	\N	\N	\N	\N
176	16	PbAjF	\N	\N	\N	\N	\N
177	16	5NRjo	\N	\N	\N	\N	\N
178	17	2p3De	\N	\N	\N	\N	\N
179	17	zfRK8	\N	\N	\N	\N	\N
180	17	HYqqp	\N	\N	\N	\N	\N
181	18	6c9fa	\N	\N	\N	\N	\N
182	18	Vzcg6	\N	\N	\N	\N	\N
183	18	5CoeK	\N	\N	\N	\N	\N
184	19	XlBJM	\N	\N	\N	\N	\N
185	19	o6TCx	\N	\N	\N	\N	\N
186	19	oMsx5	\N	\N	\N	\N	\N
187	20	Hwgw0	\N	\N	\N	\N	\N
188	20	uT0fp	\N	\N	\N	\N	\N
189	20	DEV58	\N	\N	\N	\N	\N
190	21	sIkDB	\N	\N	\N	\N	\N
191	21	QBMcx	\N	\N	\N	\N	\N
192	21	LvNzQ	\N	\N	\N	\N	\N
193	22	zUwue	\N	\N	\N	\N	\N
194	22	0dTxZ	\N	\N	\N	\N	\N
195	22	a9ByR	\N	\N	\N	\N	\N
196	23	dALSy	\N	\N	\N	\N	\N
197	23	1LCU1	\N	\N	\N	\N	\N
198	23	I37N5	\N	\N	\N	\N	\N
199	24	0vQMC	\N	\N	\N	\N	\N
200	24	chwzI	\N	\N	\N	\N	\N
201	24	P5bHN	\N	\N	\N	\N	\N
202	25	The Teamies	\N	\N	\N	\N	\N
203	26	qbLY9	\N	\N	\N	\N	\N
204	26	BGr3g	\N	\N	\N	\N	\N
206	27	the phones	\N	\N	\N	\N	\N
205	27	the PCs	\N	\N	\N	\N	\N
285	68	hf0jm	\N	\N	\N	\N	\N
286	68	n1AME	\N	\N	\N	\N	\N
287	68	KF1ex	\N	\N	\N	\N	\N
208	28	Beans	\N	\N	\N	\N	\N
207	28	Team?	\N	\N	\N	\N	\N
209	29	Couch	\N	\N	\N	\N	\N
210	29	Bed	\N	\N	\N	\N	\N
211	30	Bed	\N	\N	\N	\N	\N
212	30	Couch	\N	\N	\N	\N	\N
213	31	PlhlY	\N	\N	\N	\N	\N
214	31	j3Cvw	\N	\N	\N	\N	\N
215	31	4xOAP	\N	\N	\N	\N	\N
216	32	uWnKy	\N	\N	\N	\N	\N
217	32	Rl7ts	\N	\N	\N	\N	\N
218	33	Qitoi	\N	\N	\N	\N	\N
219	33	dkjbx	\N	\N	\N	\N	\N
220	34	iz2m0	\N	\N	\N	\N	\N
221	34	pVN92	\N	\N	\N	\N	\N
222	34	PEAZh	\N	\N	\N	\N	\N
223	35	IG4u8	\N	\N	\N	\N	\N
224	36	bJmdd	\N	\N	\N	\N	\N
225	37	wzszK	\N	\N	\N	\N	\N
226	38	9R75n	\N	\N	\N	\N	\N
227	39	yZoED	\N	\N	\N	\N	\N
228	39	YCP9f	\N	\N	\N	\N	\N
229	39	6Ng1a	\N	\N	\N	\N	\N
230	40	wtPWz	\N	\N	\N	\N	\N
231	40	BZWIu	\N	\N	\N	\N	\N
232	41	7kihM	\N	\N	\N	\N	\N
233	41	NZRfZ	\N	\N	\N	\N	\N
234	42	DsfDU	\N	\N	\N	\N	\N
235	42	2BLBm	\N	\N	\N	\N	\N
236	42	fw3h5	\N	\N	\N	\N	\N
237	43	A9QCF	\N	\N	\N	\N	\N
238	43	2gDnM	\N	\N	\N	\N	\N
239	43	NzVLI	\N	\N	\N	\N	\N
240	44	Xfxe5	\N	\N	\N	\N	\N
241	45	gix0Y	\N	\N	\N	\N	\N
242	45	CbRz4	\N	\N	\N	\N	\N
243	45	ymrzW	\N	\N	\N	\N	\N
244	46	PCs	\N	\N	\N	\N	\N
245	46	Phones	\N	\N	\N	\N	\N
246	47	33OxQ	\N	\N	\N	\N	\N
247	47	wSUVY	\N	\N	\N	\N	\N
248	48	eQ3WO	\N	\N	\N	\N	\N
249	48	WI5t0	\N	\N	\N	\N	\N
250	49	C7PAV	\N	\N	\N	\N	\N
251	49	sKfUn	\N	\N	\N	\N	\N
252	50	ni2zI	\N	\N	\N	\N	\N
253	50	MGvsq	\N	\N	\N	\N	\N
254	51	mw4xi	\N	\N	\N	\N	\N
255	52	srPaG	\N	\N	\N	\N	\N
256	52	YzdAq	\N	\N	\N	\N	\N
257	52	Y2xoc	\N	\N	\N	\N	\N
258	53	arvdo	\N	\N	\N	\N	\N
259	53	WE9Y2	\N	\N	\N	\N	\N
260	53	EaWqi	\N	\N	\N	\N	\N
261	54	FeA2c	\N	\N	\N	\N	\N
262	55	6JFpR	\N	\N	\N	\N	\N
263	56	mZr7N	\N	\N	\N	\N	\N
264	56	Pauc9	\N	\N	\N	\N	\N
265	56	ZgGLw	\N	\N	\N	\N	\N
266	57	Ja7MQ	\N	\N	\N	\N	\N
267	58	PGdLr	\N	\N	\N	\N	\N
268	58	NiIPZ	\N	\N	\N	\N	\N
269	58	hBzqr	\N	\N	\N	\N	\N
270	59	ByGea	\N	\N	\N	\N	\N
272	60	gL8jn	\N	\N	\N	\N	\N
288	69	u1AqD	\N	\N	\N	\N	\N
289	69	gGqIu	\N	\N	\N	\N	\N
273	60	dsjiseiw	\N	\N	\N	\N	\N
271	60	As jakjwq	\N	\N	\N	\N	\N
274	61	Team 1	\N	\N	\N	\N	\N
275	61	Team 2	\N	\N	\N	\N	\N
276	62	0j5as	\N	\N	\N	\N	\N
277	62	Edges Team	\N	\N	\N	\N	\N
278	63	0hZKV	\N	\N	\N	\N	\N
279	64	HBdOu	\N	\N	\N	\N	\N
280	65	OQOT9	\N	\N	\N	\N	\N
281	66	myyXT	\N	\N	\N	\N	\N
282	66	MDoUz	\N	\N	\N	\N	\N
283	66	S3bmW	\N	\N	\N	\N	\N
290	69	DlKDq	\N	\N	\N	\N	\N
291	70	Oun4E	\N	\N	\N	\N	\N
292	70	IHkaf	\N	\N	\N	\N	\N
293	70	il6hE	\N	\N	\N	\N	\N
294	72	Team bk5RS	\N	\N	\N	\N	\N
295	72	Team QiSdO	\N	\N	\N	\N	\N
296	72	Team xTyDg	\N	\N	\N	\N	\N
297	73	Team toN8H	\N	\N	\N	\N	\N
298	73	Team u4qor	\N	\N	\N	\N	\N
299	73	Team 8eYdU	\N	\N	\N	\N	\N
300	74	Team gJvom	\N	\N	\N	\N	\N
301	74	Team iN1XI	\N	\N	\N	\N	\N
302	74	Team RGqQk	\N	\N	\N	\N	\N
303	75	Team qrgN6	\N	\N	\N	\N	\N
304	75	Team vYaQW	\N	\N	\N	\N	\N
308	77	Team OUrov	\N	\N	\N	\N	\N
307	76	single quote	\N	\N	\N	\N	\N
305	76	oopsies'	\N	\N	\N	\N	\N
306	76	dwasd	\N	\N	\N	\N	\N
309	77	Team aY2zg	\N	\N	\N	\N	\N
311	78	Team2	\N	\N	\N	\N	\N
310	78	Team1	\N	\N	\N	\N	\N
312	79	Team s4pIT	\N	\N	\N	\N	\N
313	79	Team GJf09	\N	\N	\N	\N	\N
315	80	The shit team	\N	\N	\N	\N	\N
314	80	The good team	\N	\N	\N	\N	\N
316	81	Team Good	\N	\N	\N	\N	\N
317	81	Team Bad	\N	\N	\N	\N	\N
318	82	Team QIN7q	\N	\N	\N	\N	\N
319	82	Team mIqGG	\N	\N	\N	\N	\N
320	83	Team Ltj0v	\N	\N	\N	\N	\N
321	83	Team AiAcD	\N	\N	\N	\N	\N
322	84	Team U9yUj	\N	\N	\N	\N	\N
323	84	Team HDvgB	\N	\N	\N	\N	\N
324	85	Team 1rV3F	\N	\N	\N	\N	\N
325	85	Team E4WVT	\N	\N	\N	\N	\N
326	85	Team HWsLD	\N	\N	\N	\N	\N
328	86	worbies	\N	\N	\N	\N	\N
327	86	Air	\N	\N	\N	\N	\N
329	86	Anime enjoyers	\N	\N	\N	\N	\N
\.


--
-- Data for Name: teams_turn_order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teams_turn_order (game_id, teams_array, number_teams, current_team) FROM stdin;
1	{146}	3	1
11	{165,166}	2	1
27	{205,206}	2	0
44	{240}	1	0
29	{209,210}	2	1
51	{254}	1	0
81	{316,317}	2	1
36	{224}	1	0
2	{149}	1	0
6	{155}	1	0
48	{248,249}	2	0
62	{276,277}	2	1
13	{170}	1	0
25	{202}	1	0
8	{157,158,159}	3	1
28	{208,207}	2	0
67	{284}	1	0
3	{150}	1	0
37	{225}	1	0
7	{156}	1	0
26	{203,204}	2	0
46	{244,245}	2	1
15	{174}	1	0
40	{230,231}	2	0
4	{151}	1	0
61	{274,275}	2	1
49	{250,251}	2	0
30	{211,212}	2	1
31	{213}	3	1
32	{217}	2	1
63	{278}	1	0
45	{241,242,243}	3	2
33	{218,219}	2	0
83	{320,321}	2	1
78	{310,311}	2	1
64	{279}	1	0
50	{252,253}	2	1
35	{223}	1	0
47	{246,247}	2	1
65	{280}	1	0
79	{312,313}	2	1
75	{304,303}	2	0
84	{322,323}	2	1
86	{328,329,327}	3	0
\.


--
-- Data for Name: turns; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.turns (turn_id, user_inst_id, game_id, round, time_start, time_finish, active) FROM stdin;
1	252	78	4	2022-06-19 22:14:59.857386	\N	\N
2	253	78	4	2022-06-19 22:15:06.506253	\N	\N
3	252	78	4	2022-06-19 22:15:13.174077	\N	\N
4	253	78	4	2022-06-19 22:20:15.521565	\N	\N
5	252	78	4	2022-06-19 22:40:43.103694	\N	\N
6	253	78	4	2022-06-19 22:40:51.415617	\N	\N
7	255	79	1	2022-06-19 22:46:28.499931	\N	\N
8	254	79	1	2022-06-19 22:51:43.839001	\N	\N
9	255	79	1	2022-06-19 22:52:23.349808	\N	\N
10	254	79	1	2022-06-19 22:52:37.073126	\N	\N
11	255	79	1	2022-06-19 22:52:55.399435	\N	\N
12	254	79	1	2022-06-19 23:03:47.958623	\N	\N
13	255	79	2	2022-06-19 23:04:19.495984	\N	\N
14	254	79	2	2022-06-19 23:04:31.554822	\N	\N
15	255	79	2	2022-06-19 23:09:16.511109	\N	\N
16	254	79	3	2022-06-19 23:09:42.091615	\N	\N
17	255	79	3	2022-06-19 23:10:34.029494	\N	\N
18	254	79	4	2022-06-19 23:10:58.662688	\N	\N
19	255	79	4	2022-06-19 23:11:06.427831	\N	\N
20	254	79	4	2022-06-19 23:38:27.5628	\N	\N
21	255	79	4	2022-06-19 23:40:18.300404	\N	\N
22	255	79	4	2022-06-19 23:40:23.623774	\N	\N
23	266	81	1	2022-06-20 20:17:06.936375	\N	\N
24	269	81	1	2022-06-20 20:18:31.318789	\N	\N
25	264	81	1	2022-06-20 20:19:46.97664	\N	\N
26	263	81	1	2022-06-20 20:21:02.640479	\N	\N
27	268	81	1	2022-06-20 20:22:17.560355	\N	\N
28	270	81	1	2022-06-20 20:24:01.987567	\N	\N
29	266	81	1	2022-06-20 20:25:29.508877	\N	\N
30	266	81	1	2022-06-20 20:31:19.990005	\N	\N
31	269	81	2	2022-06-20 20:38:50.405382	\N	\N
32	263	81	2	2022-06-20 20:47:27.114359	\N	\N
33	268	81	2	2022-06-20 20:49:12.414175	\N	\N
34	270	81	2	2022-06-20 20:50:31.164787	\N	\N
35	266	81	2	2022-06-20 20:52:19.118174	\N	\N
36	269	81	2	2022-06-20 20:54:10.810198	\N	\N
37	263	81	2	2022-06-20 20:56:20.681454	\N	\N
38	268	81	2	2022-06-20 20:56:33.994949	\N	\N
39	270	81	2	2022-06-20 20:57:49.096536	\N	\N
40	266	81	2	2022-06-20 20:59:00.605555	\N	\N
41	269	81	2	2022-06-20 21:01:44.651	\N	\N
42	263	81	2	2022-06-20 21:03:47.500765	\N	\N
43	268	81	2	2022-06-20 21:05:10.462723	\N	\N
44	270	81	2	2022-06-20 21:07:37.680887	\N	\N
45	266	81	2	2022-06-20 21:09:07.616121	\N	\N
46	269	81	2	2022-06-20 21:12:19.193928	\N	\N
47	268	81	2	2022-06-20 21:15:00.796218	\N	\N
48	263	81	2	2022-06-20 21:18:35.226806	\N	\N
49	268	81	3	2022-06-20 21:19:23.427807	\N	\N
50	270	81	3	2022-06-20 21:20:38.66697	\N	\N
51	266	81	3	2022-06-20 21:23:34.564227	\N	\N
52	266	81	3	2022-06-20 21:26:27.960608	\N	\N
53	264	81	3	2022-06-20 21:27:13.174505	\N	\N
54	263	81	3	2022-06-20 21:28:28.991587	\N	\N
55	268	81	3	2022-06-20 21:29:38.804261	\N	\N
56	270	81	3	2022-06-20 21:31:00.160945	\N	\N
57	266	81	3	2022-06-20 21:31:52.700217	\N	\N
58	269	81	3	2022-06-20 21:34:02.419806	\N	\N
59	264	81	3	2022-06-20 21:35:59.991651	\N	\N
60	263	81	4	2022-06-20 21:37:17.535528	\N	\N
61	268	81	4	2022-06-20 21:38:43.054547	\N	\N
62	270	81	4	2022-06-20 21:40:01.391336	\N	\N
63	266	81	4	2022-06-20 21:41:21.663123	\N	\N
64	269	81	4	2022-06-20 21:42:57.902813	\N	\N
65	264	81	4	2022-06-20 21:44:10.923905	\N	\N
66	263	81	4	2022-06-20 21:45:40.756064	\N	\N
67	268	81	4	2022-06-20 21:47:00.561485	\N	\N
68	270	81	4	2022-06-20 21:48:11.714214	\N	\N
69	275	83	1	2022-06-23 16:44:40.501086	\N	\N
70	276	83	1	2022-06-23 16:44:52.201648	\N	\N
71	275	83	1	2022-06-23 16:44:56.860627	\N	\N
72	276	83	1	2022-06-23 16:45:01.116131	\N	\N
73	275	83	1	2022-06-23 16:45:06.177051	\N	\N
74	276	83	1	2022-06-23 16:57:11.015009	\N	\N
75	276	83	1	2022-06-23 16:57:15.059857	\N	\N
76	275	83	1	2022-06-23 16:58:34.534322	\N	\N
77	275	83	1	2022-06-23 16:58:42.831899	\N	\N
78	277	84	1	2022-06-23 17:09:16.85305	\N	\N
79	278	84	1	2022-06-23 17:29:08.002234	2022-06-23 17:30:08.002234	\N
80	278	84	1	2022-06-23 17:30:22.391502	2022-06-23 17:31:22.391502	\N
81	277	84	1	2022-06-23 17:31:59.947975	2022-06-23 17:32:59.947975	\N
82	278	84	1	2022-06-23 17:36:14.35198	2022-06-23 17:37:14.35198	\N
83	278	84	1	2022-06-23 17:49:26.924542	2022-06-23 17:50:26.924542	t
84	277	84	1	2022-06-23 17:51:06.326562	2022-06-23 17:52:06.326562	t
85	278	84	1	2022-06-23 17:53:24.917275	2022-06-23 17:54:24.917275	t
86	278	84	1	2022-06-23 18:04:15.718233	2022-06-23 18:05:15.718233	t
87	291	86	1	2022-06-23 19:33:05.422029	2022-06-23 19:34:05.422029	t
88	286	86	1	2022-06-23 19:36:01.178795	2022-06-23 19:37:01.178795	t
89	287	86	1	2022-06-23 19:37:53.184236	2022-06-23 19:38:53.184236	t
90	292	86	1	2022-06-23 19:39:27.625094	2022-06-23 19:40:27.625094	t
91	294	86	1	2022-06-23 19:41:12.12919	2022-06-23 19:42:12.12919	t
92	285	86	1	2022-06-23 19:43:07.426784	2022-06-23 19:44:07.426784	t
93	288	86	1	2022-06-23 19:44:51.10543	2022-06-23 19:45:51.10543	t
94	289	86	1	2022-06-23 19:46:43.882937	2022-06-23 19:47:43.882937	t
95	293	86	1	2022-06-23 19:48:19.692029	2022-06-23 19:49:19.692029	t
96	291	86	1	2022-06-23 19:49:40.24751	2022-06-23 19:50:40.24751	t
97	286	86	1	2022-06-23 19:51:25.71959	2022-06-23 19:52:25.71959	t
98	287	86	1	2022-06-23 19:53:00.50991	2022-06-23 19:54:00.50991	t
99	292	86	1	2022-06-23 19:54:17.825352	2022-06-23 19:55:17.825352	t
100	294	86	1	2022-06-23 19:55:36.822529	2022-06-23 19:56:36.822529	t
101	285	86	1	2022-06-23 19:57:05.499928	2022-06-23 19:58:05.499928	t
102	288	86	1	2022-06-23 19:58:44.163099	2022-06-23 19:59:44.163099	t
103	289	86	1	2022-06-23 20:00:13.589259	2022-06-23 20:01:13.589259	t
104	293	86	2	2022-06-23 20:03:19.067436	2022-06-23 20:04:19.067436	t
105	291	86	2	2022-06-23 20:05:10.669242	2022-06-23 20:06:10.669242	t
106	286	86	2	2022-06-23 20:06:38.151586	2022-06-23 20:07:38.151586	t
107	287	86	2	2022-06-23 20:08:29.258846	2022-06-23 20:09:29.258846	t
108	292	86	2	2022-06-23 20:10:04.615436	2022-06-23 20:11:04.615436	t
109	294	86	2	2022-06-23 20:11:34.098234	2022-06-23 20:12:34.098234	t
110	285	86	2	2022-06-23 20:12:54.269347	2022-06-23 20:13:54.269347	t
111	288	86	2	2022-06-23 20:14:27.77966	2022-06-23 20:15:27.77966	t
112	289	86	2	2022-06-23 20:15:46.87674	2022-06-23 20:16:46.87674	t
113	293	86	2	2022-06-23 20:17:18.433086	2022-06-23 20:18:18.433086	t
114	291	86	2	2022-06-23 20:18:47.806055	2022-06-23 20:19:47.806055	t
115	286	86	2	2022-06-23 20:20:17.884147	2022-06-23 20:21:17.884147	t
116	287	86	2	2022-06-23 20:21:43.22475	2022-06-23 20:22:43.22475	t
117	292	86	3	2022-06-23 20:23:38.170736	2022-06-23 20:24:38.170736	t
118	294	86	3	2022-06-23 20:25:10.237567	2022-06-23 20:26:10.237567	t
119	285	86	3	2022-06-23 20:26:52.078796	2022-06-23 20:27:52.078796	t
120	288	86	3	2022-06-23 20:28:13.420128	2022-06-23 20:29:13.420128	t
121	289	86	3	2022-06-23 20:29:34.571381	2022-06-23 20:30:34.571381	t
122	293	86	3	2022-06-23 20:30:57.007788	2022-06-23 20:31:57.007788	t
123	291	86	3	2022-06-23 20:32:21.597326	2022-06-23 20:33:21.597326	t
124	286	86	3	2022-06-23 20:33:41.069274	2022-06-23 20:34:41.069274	t
125	287	86	3	2022-06-23 20:35:04.451379	2022-06-23 20:36:04.451379	t
126	292	86	3	2022-06-23 20:36:25.108313	2022-06-23 20:37:25.108313	t
127	294	86	3	2022-06-23 20:38:16.138237	2022-06-23 20:39:16.138237	t
128	285	86	4	2022-06-23 20:39:28.066242	2022-06-23 20:40:28.066242	t
129	288	86	4	2022-06-23 20:41:11.142726	2022-06-23 20:42:11.142726	t
130	289	86	4	2022-06-23 20:42:41.271805	2022-06-23 20:43:41.271805	t
131	293	86	4	2022-06-23 20:44:01.979982	2022-06-23 20:45:01.979982	t
132	291	86	4	2022-06-23 20:45:39.174208	2022-06-23 20:46:39.174208	t
133	286	86	4	2022-06-23 20:47:46.02622	2022-06-23 20:48:46.02622	t
134	287	86	4	2022-06-23 20:49:38.438858	2022-06-23 20:50:38.438858	t
135	292	86	4	2022-06-23 20:50:57.125967	2022-06-23 20:51:57.125967	t
136	294	86	4	2022-06-23 20:52:37.844147	2022-06-23 20:53:37.844147	t
137	285	86	4	2022-06-23 20:54:10.478211	2022-06-23 20:55:10.478211	t
138	288	86	4	2022-06-23 20:55:57.205026	2022-06-23 20:56:57.205026	t
139	289	86	4	2022-06-23 20:57:23.275226	2022-06-23 20:58:23.275226	t
140	293	86	4	2022-06-23 20:59:29.245362	2022-06-23 21:00:29.245362	t
141	291	86	4	2022-06-23 21:01:04.301007	2022-06-23 21:02:04.301007	t
142	286	86	4	2022-06-23 21:02:38.394424	2022-06-23 21:03:38.394424	t
\.


--
-- Data for Name: user_instance; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_instance (user_inst_id, user_id, username, team_id, game_id, round1score, round2score, round3score, round4score, final_score) FROM stdin;
117	34	cxlQY	146	1	\N	\N	\N	\N	\N
118	34	cxlQY	149	2	\N	\N	\N	\N	\N
119	34	cxlQY	150	3	\N	\N	\N	\N	\N
120	34	cxlQY	151	4	\N	\N	\N	\N	\N
121	34	cxlQY	\N	5	\N	\N	\N	\N	\N
194	49	chrome	242	45	\N	\N	\N	\N	\N
122	34	CHROME	155	6	\N	\N	\N	\N	\N
123	34	CHROME	156	7	\N	\N	\N	\N	\N
195	35	edge	243	45	\N	\N	\N	\N	\N
157	44	Jorge	207	28	\N	\N	\N	\N	\N
125	34	CHROME	157	8	\N	\N	\N	\N	\N
124	38	Tom Phone	158	8	\N	\N	\N	\N	\N
126	37	Iphone	159	8	\N	\N	\N	\N	\N
159	42	Dev	208	28	\N	\N	\N	\N	\N
156	45	Michael 	208	28	\N	\N	\N	\N	\N
161	46	Tom	207	28	\N	\N	\N	\N	\N
224	54	Phone tome	278	63	\N	\N	\N	\N	\N
129	35	WTWXo	160	9	\N	\N	\N	\N	\N
127	34	mildwadawdmildwa	160	9	\N	\N	\N	\N	\N
160	43	Anna	207	28	\N	\N	\N	\N	\N
128	38	Tom Phone	161	9	\N	\N	\N	\N	\N
130	34	milko	165	11	\N	\N	\N	\N	\N
131	38	Tom Phone	166	11	\N	\N	\N	\N	\N
132	34	milko	167	12	\N	\N	\N	\N	\N
133	34	milko	170	13	\N	\N	\N	\N	\N
134	34	milko	171	14	\N	\N	\N	\N	\N
135	34	milko	174	15	\N	\N	\N	\N	\N
136	39	UL9no	\N	12	\N	\N	\N	\N	\N
137	34	milko	\N	20	\N	\N	\N	\N	\N
138	34	milko	\N	21	\N	\N	\N	\N	\N
139	34	milko	\N	22	\N	\N	\N	\N	\N
143	39	UL9no	\N	24	\N	\N	\N	\N	\N
144	40	FTOzu	\N	24	\N	\N	\N	\N	\N
164	42	Dev	210	29	\N	\N	\N	\N	\N
197	41	chrome	244	46	\N	\N	\N	\N	\N
165	43	Anna	209	29	\N	\N	\N	\N	\N
147	35	edge	202	25	\N	\N	\N	\N	\N
146	34	chrome	202	25	\N	\N	\N	\N	\N
145	40	Tom phone	202	25	\N	\N	\N	\N	\N
162	44	Jorge	209	29	\N	\N	\N	\N	\N
166	46	Tom	209	29	\N	\N	\N	\N	\N
148	34	chrome	204	26	\N	\N	\N	\N	\N
149	35	edge	203	26	\N	\N	\N	\N	\N
167	45	Michael 	210	29	\N	\N	\N	\N	\N
152	40	Tom phone	203	26	\N	\N	\N	\N	\N
153	35	edge	205	27	\N	\N	\N	\N	\N
154	34	chrome	205	27	\N	\N	\N	\N	\N
155	40	Tom phone	206	27	\N	\N	\N	\N	\N
196	35	edge	244	46	\N	\N	\N	\N	\N
198	52	Phone	245	46	\N	\N	\N	\N	\N
199	49	chrome	246	47	\N	\N	\N	\N	\N
172	43	Anna	212	30	\N	\N	\N	\N	\N
171	45	Michael 	211	30	\N	\N	\N	\N	\N
200	35	edge	246	47	\N	\N	\N	\N	\N
170	47	Mel	211	30	\N	\N	\N	\N	\N
169	42	Dev	211	30	\N	\N	\N	\N	\N
168	46	Tom	212	30	\N	\N	\N	\N	\N
173	44	Jorge	212	30	\N	\N	\N	\N	\N
174	48	8K48G	213	31	\N	\N	\N	\N	\N
201	52	Phone	247	47	\N	\N	\N	\N	\N
175	41	nv5Kz	214	31	\N	\N	\N	\N	\N
176	41	nv5Kz	217	32	\N	\N	\N	\N	\N
177	50	H5huA	218	33	\N	\N	\N	\N	\N
178	51	FEZRS	219	33	\N	\N	\N	\N	\N
180	49	EwGky	220	34	\N	\N	\N	\N	\N
181	49	EwGky	223	35	\N	\N	\N	\N	\N
182	49	EwGky	224	36	\N	\N	\N	\N	\N
183	49	EwGky	225	37	\N	\N	\N	\N	\N
184	49	EwGky	226	38	\N	\N	\N	\N	\N
185	49	EwGky	227	39	\N	\N	\N	\N	\N
186	52	nvqhy	228	39	\N	\N	\N	\N	\N
187	52	nvqhy	230	40	\N	\N	\N	\N	\N
188	49	EwGky	231	40	\N	\N	\N	\N	\N
189	49	EwGky	\N	41	\N	\N	\N	\N	\N
192	52	Phone	240	44	\N	\N	\N	\N	\N
190	49	chrome	240	44	\N	\N	\N	\N	\N
191	35	edge	240	44	\N	\N	\N	\N	\N
193	52	Phone	241	45	\N	\N	\N	\N	\N
202	49	chrome	248	48	\N	\N	\N	\N	\N
203	35	edge	248	48	\N	\N	\N	\N	\N
204	52	Phone	249	48	\N	\N	\N	\N	\N
205	49	chrome	250	49	\N	\N	\N	\N	\N
206	35	edge	250	49	\N	\N	\N	\N	\N
207	52	Phone	251	49	\N	\N	\N	\N	\N
208	49	chrome	252	50	\N	\N	\N	\N	\N
209	35	edge	252	50	\N	\N	\N	\N	\N
210	52	Phone	253	50	\N	\N	\N	\N	\N
211	49	chrome	254	51	\N	\N	\N	\N	\N
212	49	chrome	\N	53	\N	\N	\N	\N	\N
213	49	chrome	261	54	\N	\N	\N	\N	\N
214	49	chrome	262	55	\N	\N	\N	\N	\N
215	49	chrome	266	57	\N	\N	\N	\N	\N
216	49	chrome	270	59	\N	\N	\N	\N	\N
225	57	0A15a	279	64	\N	\N	\N	\N	\N
217	53	TOMEdwa	273	60	\N	\N	\N	\N	\N
226	56	uZY1Q	280	65	\N	\N	\N	\N	\N
218	54	Wk2kU	272	60	\N	\N	\N	\N	\N
220	53	TOMEdwa	275	61	\N	\N	\N	\N	\N
219	54	Phone tome	274	61	\N	\N	\N	\N	\N
221	54	Phone tome	276	62	\N	\N	\N	\N	\N
263	86	Tom	316	81	\N	\N	\N	\N	\N
222	53	TOMEdwa	276	62	\N	\N	\N	\N	\N
223	55	Edge	277	62	\N	\N	\N	\N	\N
230	63	huge	284	67	\N	\N	\N	\N	\N
232	73	5DUVS	282	66	\N	\N	\N	\N	\N
229	55	TOME	284	67	\N	\N	\N	\N	\N
231	56	uZY1Q	281	66	\N	\N	\N	\N	\N
235	76	5AA4o	\N	69	\N	\N	\N	\N	\N
236	77	OOr4m	\N	70	\N	\N	\N	\N	\N
237	77	OOr4m	\N	69	\N	\N	\N	\N	\N
227	55	TOME	283	66	\N	\N	\N	\N	\N
233	76	5AA4o	\N	68	\N	\N	\N	\N	\N
238	77	OOr4m	\N	73	\N	\N	\N	\N	\N
241	76	Phone	\N	74	\N	\N	\N	\N	\N
239	77	Edge	300	74	\N	\N	\N	\N	\N
240	56	Chrome	\N	74	\N	\N	\N	\N	\N
242	77	Edge	303	75	\N	\N	\N	\N	\N
244	56	Chrome	303	75	\N	\N	\N	\N	\N
243	76	Phone	304	75	\N	\N	\N	\N	\N
249	85	w1aUj	307	76	\N	\N	\N	\N	\N
247	84	REALLYLONGNAMENA	306	76	\N	\N	\N	\N	\N
246	77	OH NOES	305	76	\N	\N	\N	\N	\N
250	86	voyLv	305	76	\N	\N	\N	\N	\N
251	84	REALLYLONGNAMENA	308	77	\N	\N	\N	\N	\N
245	83	hax	307	76	\N	\N	\N	\N	\N
253	86	Phone	310	78	\N	\N	\N	\N	\N
252	85	Chrome	311	78	\N	\N	\N	\N	\N
255	85	Chrome	312	79	\N	\N	\N	\N	\N
254	86	Phone	313	79	\N	\N	\N	\N	\N
256	87	6jKG6	\N	77	\N	\N	\N	\N	\N
285	109	Famuel	328	86	\N	\N	\N	\N	\N
287	107	huge	328	86	\N	\N	\N	\N	\N
270	102	Anna	316	81	\N	\N	\N	\N	\N
269	100	Michael 	316	81	\N	\N	\N	\N	\N
293	113	Anthea	328	86	\N	\N	\N	\N	\N
266	97	Jorge	317	81	\N	\N	\N	\N	\N
268	103	Dev	317	81	\N	\N	\N	\N	\N
264	104	Mel	317	81	\N	\N	\N	\N	\N
272	103	Dev	\N	82	\N	\N	\N	\N	\N
286	112	Milkopilko	327	86	\N	\N	\N	\N	\N
273	105	jDy4H	\N	82	\N	\N	\N	\N	\N
294	114	Jorge	327	86	\N	\N	\N	\N	\N
274	104	QSXSN	\N	81	\N	\N	\N	\N	\N
289	111	worb	327	86	\N	\N	\N	\N	\N
288	110	Alex 	329	86	\N	\N	\N	\N	\N
291	106	Tom	329	86	\N	\N	\N	\N	\N
292	108	Callum	329	86	\N	\N	\N	\N	\N
276	106	urgH3	321	83	\N	\N	\N	\N	\N
275	105	jDy4H	320	83	\N	\N	\N	\N	\N
278	105	jDy4H	322	84	\N	\N	\N	\N	\N
277	106	urgH3	323	84	\N	\N	\N	\N	\N
279	109	mhopU	\N	82	\N	\N	\N	\N	\N
280	108	pxFbQ	\N	82	\N	\N	\N	\N	\N
281	109	mhopU	\N	85	\N	\N	\N	\N	\N
283	110	bz4RK	\N	85	\N	\N	\N	\N	\N
284	107	O5cZG	\N	85	\N	\N	\N	\N	\N
282	111	worb	\N	85	\N	\N	\N	\N	\N
290	108	Callum	\N	85	\N	\N	\N	\N	\N
259	94	Mel	314	80	\N	\N	\N	\N	\N
260	96	Michael 	314	80	\N	\N	\N	\N	\N
258	87	Dev	314	80	\N	\N	\N	\N	\N
261	95	Anna	315	80	\N	\N	\N	\N	\N
257	86	Tom	315	80	\N	\N	\N	\N	\N
262	97	Jorge	315	80	\N	\N	\N	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (user_id, username, ip_address) FROM stdin;
36	AlrMX	\N
38	Tom Phone	\N
37	Iphone	\N
39	UL9no	\N
40	Tom phone	\N
35	edge	\N
34	chrome	\N
44	Jorge	\N
43	Anna	\N
46	Tom	\N
45	Michael 	\N
42	Dev	\N
47	Mel	\N
48	8K48G	\N
50	H5huA	\N
51	FEZRS	\N
49	chrome	\N
52	Phone	\N
41	chrome	\N
53	TOMEdwa	\N
54	Phone tome	\N
57	0A15a	\N
58	QMKK1	\N
59	EDC79	\N
60	Y92Qg	\N
61	1PPeE	\N
62	geVkI	\N
55	TOME	\N
63	huge	\N
64	ClrN2	\N
65	LDY9u	\N
66	nqEJ0	\N
67	63fxJ	\N
68	34dES	\N
69	oqhQe	\N
70	wR0oc	\N
71	TpcSx	\N
73	5DUVS	203.12.14.83
74	FrD65	35.233.62.116
75	cAGLL	104.217.249.182
78	9bExm	66.240.192.82
79	f8lLT	167.94.138.62
80	fSvdJ	167.94.138.62
81	OhrIF	66.220.149.7
82	Inth9	66.220.149.11
76	Phone	203.12.14.83
56	Chrome	\N
77	OH NOES	203.12.14.83
83	hax	58.169.55.56
84	REALLYLONGNAMENA	127.0.0.1
85	Chrome	127.0.0.1
88	w52Dk	66.220.149.11
89	c8Y88	66.220.149.7
90	V1NKi	66.220.149.5
91	VAejt	66.220.149.6
92	39dXJ	66.220.149.3
93	zuhgW	66.220.149.17
87	Dev	203.12.14.83
86	Tom	203.12.14.83
95	Anna	1.126.30.36
96	Michael 	49.185.198.158
94	Mel	1.146.225.238
98	jed2i	1.146.225.238
99	Mel	1.146.225.238
97	Jorge	49.178.124.226
101	0fMqp	1.126.30.36
100	Michael 	49.185.198.158
103	Dev	203.12.14.83
102	Anna	1.126.30.36
104	QSXSN	203.12.14.83
105	jDy4H	192.168.0.106
111	worb	192.168.0.114
109	Famuel	192.168.0.111
110	Alex 	192.168.0.115
112	Milkopilko	192.168.0.112
107	huge	137.219.139.54
108	Callum	192.168.0.113
113	Anthea	192.168.0.101
114	Jorge	192.168.0.103
106	Tom	192.168.0.104
\.


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

