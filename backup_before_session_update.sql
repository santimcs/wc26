--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15
-- Dumped by pg_dump version 10.15

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.channels (
    id bigint NOT NULL,
    number integer,
    name character varying,
    logo character varying,
    url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.channels OWNER TO postgres;

--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channels_id_seq OWNER TO postgres;

--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.channels_id_seq OWNED BY public.channels.id;


--
-- Name: criteria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.criteria (
    id bigint NOT NULL,
    show_date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.criteria OWNER TO postgres;

--
-- Name: criteria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.criteria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.criteria_id_seq OWNER TO postgres;

--
-- Name: criteria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.criteria_id_seq OWNED BY public.criteria.id;


--
-- Name: fixtures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fixtures (
    id bigint NOT NULL,
    round_id bigint,
    date date,
    session_id bigint,
    home_team_id bigint,
    away_team_id bigint,
    channel_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    criterium_id bigint
);


ALTER TABLE public.fixtures OWNER TO postgres;

--
-- Name: fixtures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fixtures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fixtures_id_seq OWNER TO postgres;

--
-- Name: fixtures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fixtures_id_seq OWNED BY public.fixtures.id;


--
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.results (
    id bigint NOT NULL,
    fixture_id bigint,
    home_goals integer,
    away_goals integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.results OWNER TO postgres;

--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_id_seq OWNER TO postgres;

--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.results_id_seq OWNED BY public.results.id;


--
-- Name: rounds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rounds (
    id bigint NOT NULL,
    sequence integer,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.rounds OWNER TO postgres;

--
-- Name: rounds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rounds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rounds_id_seq OWNER TO postgres;

--
-- Name: rounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rounds_id_seq OWNED BY public.rounds.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id bigint NOT NULL,
    sequence integer,
    "time" time without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: standings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.standings (
    id bigint NOT NULL,
    team_id bigint,
    played integer DEFAULT 0,
    wins integer DEFAULT 0,
    draws integer DEFAULT 0,
    losses integer DEFAULT 0,
    goals_for integer DEFAULT 0,
    goals_against integer DEFAULT 0,
    points integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.standings OWNER TO postgres;

--
-- Name: standings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.standings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standings_id_seq OWNER TO postgres;

--
-- Name: standings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.standings_id_seq OWNED BY public.standings.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name character varying,
    "group" character varying,
    ranking integer,
    flag character varying,
    confederation character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.channels ALTER COLUMN id SET DEFAULT nextval('public.channels_id_seq'::regclass);


--
-- Name: criteria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.criteria ALTER COLUMN id SET DEFAULT nextval('public.criteria_id_seq'::regclass);


--
-- Name: fixtures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures ALTER COLUMN id SET DEFAULT nextval('public.fixtures_id_seq'::regclass);


--
-- Name: results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);


--
-- Name: rounds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rounds ALTER COLUMN id SET DEFAULT nextval('public.rounds_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: standings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.standings ALTER COLUMN id SET DEFAULT nextval('public.standings_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2026-06-18 02:40:45.285793	2026-06-18 02:40:45.285793
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.channels (id, number, name, logo, url, created_at, updated_at) FROM stdin;
1	1	Fox Sports	fox_logo.png	foxsports.com	2026-06-18 02:41:01.800942	2026-06-18 02:41:01.800942
2	2	FOX	fox_logo.png	fox.com	2026-06-18 02:41:01.802426	2026-06-18 02:41:01.802426
3	3	Telemundo	telemundo_logo.png	telemundo.com	2026-06-18 02:41:01.803566	2026-06-18 02:41:01.803566
4	4	Universo	universo_logo.png	universo.com	2026-06-18 02:41:01.804688	2026-06-18 02:41:01.804688
5	5	TSN	tsn_logo.png	tsn.ca	2026-06-18 02:41:01.805854	2026-06-18 02:41:01.805854
6	6	RDS	rds_logo.png	rds.ca	2026-06-18 02:41:01.806935	2026-06-18 02:41:01.806935
7	7	BBC One	bbc_logo.png	bbc.co.uk/sport	2026-06-18 02:41:01.807973	2026-06-18 02:41:01.807973
8	8	ITV	itv_logo.png	itv.com/sport	2026-06-18 02:41:01.809021	2026-06-18 02:41:01.809021
9	9	Optus Sport	optus_logo.png	sport.optus.com.au	2026-06-18 02:41:01.810061	2026-06-18 02:41:01.810061
10	10	SBS	sbs_logo.png	sbs.com.au/sport	2026-06-18 02:41:01.811097	2026-06-18 02:41:01.811097
11	11	beIN Sports	bein_logo.png	bein.net	2026-06-18 02:41:01.812345	2026-06-18 02:41:01.812345
12	12	Sky Sports	sky_logo.png	skysports.com	2026-06-18 02:41:01.813378	2026-06-18 02:41:01.813378
13	13	ESPN	espn_logo.png	espn.com	2026-06-18 02:41:01.814431	2026-06-18 02:41:01.814431
14	14	DAZN	dazn_logo.png	dazn.com	2026-06-18 02:41:01.815467	2026-06-18 02:41:01.815467
15	15	SuperSport	supersport_logo.png	supersport.com	2026-06-18 02:41:01.816507	2026-06-18 02:41:01.816507
\.


--
-- Data for Name: criteria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.criteria (id, show_date, created_at, updated_at) FROM stdin;
1	2026-06-12	2026-06-19 02:35:51.306154	2026-06-19 02:35:51.306154
\.


--
-- Data for Name: fixtures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fixtures (id, round_id, date, session_id, home_team_id, away_team_id, channel_id, created_at, updated_at, criterium_id) FROM stdin;
1	1	2026-06-12	2	1	2	1	2026-06-18 02:41:01.838018	2026-06-18 02:41:01.838018	\N
2	1	2026-06-12	11	3	4	2	2026-06-18 02:41:01.841628	2026-06-18 02:41:01.841628	\N
3	1	2026-06-13	2	5	6	5	2026-06-18 02:41:01.843711	2026-06-18 02:41:01.843711	\N
4	1	2026-06-13	10	13	14	1	2026-06-18 02:41:01.845737	2026-06-18 02:41:01.845737	\N
5	1	2026-06-14	2	7	8	3	2026-06-18 02:41:01.847753	2026-06-18 02:41:01.847753	\N
6	1	2026-06-14	8	9	10	1	2026-06-18 02:41:01.84975	2026-06-18 02:41:01.84975	\N
7	1	2026-06-14	10	11	12	4	2026-06-18 02:41:01.852084	2026-06-18 02:41:01.852084	\N
8	1	2026-06-14	12	15	16	9	2026-06-18 02:41:01.85415	2026-06-18 02:41:01.85415	\N
9	1	2026-06-15	6	17	18	7	2026-06-18 02:41:01.856175	2026-06-18 02:41:01.856175	\N
10	1	2026-06-15	7	21	22	1	2026-06-18 02:41:01.858107	2026-06-18 02:41:01.858107	\N
11	1	2026-06-15	9	19	20	11	2026-06-18 02:41:01.860046	2026-06-18 02:41:01.860046	\N
12	1	2026-06-15	11	23	24	2	2026-06-18 02:41:01.862021	2026-06-18 02:41:01.862021	\N
13	1	2026-06-15	12	29	30	1	2026-06-18 02:41:01.86393	2026-06-18 02:41:01.86393	\N
14	1	2026-06-16	2	25	26	1	2026-06-18 02:41:01.865825	2026-06-18 02:41:01.865825	\N
15	1	2026-06-16	8	31	32	3	2026-06-18 02:41:01.867849	2026-06-18 02:41:01.867849	\N
16	1	2026-06-16	10	27	28	12	2026-06-18 02:41:01.869994	2026-06-18 02:41:01.869994	\N
17	1	2026-06-17	2	33	34	1	2026-06-18 02:41:01.871981	2026-06-18 02:41:01.871981	\N
18	1	2026-06-17	8	35	36	11	2026-06-18 02:41:01.878751	2026-06-18 02:41:01.878751	\N
19	1	2026-06-17	10	37	38	1	2026-06-18 02:41:01.880811	2026-06-18 02:41:01.880811	\N
20	1	2026-06-17	12	39	40	10	2026-06-18 02:41:01.882678	2026-06-18 02:41:01.882678	\N
23	1	2026-06-18	9	47	48	2	2026-06-18 02:41:01.888781	2026-06-18 02:41:01.888781	\N
24	1	2026-06-18	11	43	44	11	2026-06-18 02:41:01.890698	2026-06-18 02:41:01.890698	\N
21	1	2026-06-18	1	41	42	1	2026-06-18 02:41:01.8848	2026-06-18 14:11:32.981489	\N
22	1	2026-06-18	3	45	46	7	2026-06-18 02:41:01.886874	2026-06-18 14:11:50.402093	\N
25	1	2026-06-18	12	4	2	1	2026-06-19 02:35:51.347801	2026-06-19 02:35:51.347801	1
26	1	2026-06-19	2	8	6	1	2026-06-19 02:35:51.352941	2026-06-19 02:35:51.352941	1
27	1	2026-06-19	4	5	7	1	2026-06-19 02:35:51.355086	2026-06-19 02:35:51.355086	1
28	1	2026-06-19	6	1	3	1	2026-06-19 02:35:51.357248	2026-06-19 02:35:51.357248	1
29	1	2026-06-20	2	13	15	1	2026-06-19 02:35:51.359338	2026-06-19 02:35:51.359338	1
30	1	2026-06-20	4	12	10	1	2026-06-19 02:35:51.361359	2026-06-19 02:35:51.361359	1
32	1	2026-06-20	6	9	11	1	2026-06-19 02:35:51.366768	2026-06-19 02:35:51.366768	1
34	1	2026-06-21	1	21	23	1	2026-06-19 02:35:51.371782	2026-06-19 02:35:51.371782	1
35	1	2026-06-21	3	17	19	1	2026-06-19 02:35:51.373739	2026-06-19 02:35:51.373739	1
38	1	2026-06-21	12	29	31	1	2026-06-19 02:35:51.37957	2026-06-19 02:35:51.37957	1
40	1	2026-06-22	2	25	27	1	2026-06-19 02:35:51.383761	2026-06-19 02:35:51.383761	1
41	1	2026-06-22	4	32	30	1	2026-06-19 02:35:51.385852	2026-06-19 02:35:51.385852	1
44	1	2026-06-23	14	40	38	1	2026-06-19 02:35:51.39272	2026-06-19 02:35:51.39272	1
45	1	2026-06-24	1	41	43	1	2026-06-19 02:35:51.394648	2026-06-19 02:35:51.394648	1
46	1	2026-06-24	3	45	47	1	2026-06-19 02:35:51.396558	2026-06-19 02:35:51.396558	1
47	1	2026-06-24	5	48	46	1	2026-06-19 02:35:51.398469	2026-06-19 02:35:51.398469	1
48	1	2026-06-24	7	44	42	1	2026-06-19 02:35:51.400642	2026-06-19 02:35:51.400642	1
49	1	2026-06-25	2	6	7	1	2026-06-19 02:35:51.402724	2026-06-19 02:35:51.402724	1
50	1	2026-06-25	2	8	5	1	2026-06-19 02:35:51.404672	2026-06-19 02:35:51.404672	1
51	1	2026-06-25	4	12	9	1	2026-06-19 02:35:51.40655	2026-06-19 02:35:51.40655	1
52	1	2026-06-25	4	10	11	1	2026-06-19 02:35:51.408485	2026-06-19 02:35:51.408485	1
53	1	2026-06-25	6	4	1	1	2026-06-19 02:35:51.410411	2026-06-19 02:35:51.410411	1
54	1	2026-06-25	6	2	3	1	2026-06-19 02:35:51.412359	2026-06-19 02:35:51.412359	1
55	1	2026-06-26	3	20	17	1	2026-06-19 02:35:51.414226	2026-06-19 02:35:51.414226	1
56	1	2026-06-26	3	18	19	1	2026-06-19 02:35:51.416267	2026-06-19 02:35:51.416267	1
57	1	2026-06-26	5	22	23	1	2026-06-19 02:35:51.418449	2026-06-19 02:35:51.418449	1
58	1	2026-06-26	5	24	21	1	2026-06-19 02:35:51.420356	2026-06-19 02:35:51.420356	1
59	1	2026-06-26	7	16	13	1	2026-06-19 02:35:51.422252	2026-06-19 02:35:51.422252	1
60	1	2026-06-26	7	14	15	1	2026-06-19 02:35:51.424227	2026-06-19 02:35:51.424227	1
62	1	2026-06-27	16	34	35	1	2026-06-19 02:35:51.429102	2026-06-19 02:35:51.429102	1
69	1	2026-06-28	5	44	41	1	2026-06-19 02:35:51.442895	2026-06-19 02:35:51.442895	1
70	1	2026-06-28	5	42	43	1	2026-06-19 02:35:51.444848	2026-06-19 02:35:51.444848	1
71	1	2026-06-28	7	38	39	1	2026-06-19 02:35:51.446869	2026-06-19 02:35:51.446869	1
72	1	2026-06-28	7	40	37	1	2026-06-19 02:35:51.448908	2026-06-19 02:35:51.448908	1
33	1	2026-06-20	8	16	14	1	2026-06-19 02:35:51.369777	2026-06-19 02:46:31.809976	1
31	1	2026-06-21	6	20	18	1	2026-06-19 02:35:51.364654	2026-06-19 02:50:42.042911	1
36	1	2026-06-21	8	24	22	1	2026-06-19 02:35:51.375711	2026-06-19 02:52:10.030247	1
37	1	2026-06-22	6	28	26	1	2026-06-19 02:35:51.377635	2026-06-19 02:53:59.034375	1
39	1	2026-06-23	1	37	39	1	2026-06-19 02:35:51.381494	2026-06-19 02:55:00.433556	1
42	1	2026-06-23	3	33	35	1	2026-06-19 02:35:51.388771	2026-06-19 02:55:39.647352	1
43	1	2026-06-23	6	36	34	1	2026-06-19 02:35:51.390761	2026-06-19 02:57:26.317162	1
63	1	2026-06-27	6	30	31	1	2026-06-19 02:35:51.43107	2026-06-19 03:02:40.195756	1
64	1	2026-06-27	6	32	29	1	2026-06-19 02:35:51.433203	2026-06-19 03:03:18.450754	1
61	1	2026-06-27	2	36	33	1	2026-06-19 02:35:51.4271	2026-06-19 03:03:57.710449	1
66	1	2026-06-27	7	28	25	1	2026-06-19 02:35:51.437062	2026-06-19 03:04:29.11044	1
65	1	2026-06-27	7	26	27	1	2026-06-19 02:35:51.435169	2026-06-19 03:05:15.587017	1
67	1	2026-06-28	3	48	45	1	2026-06-19 02:35:51.438967	2026-06-19 03:06:34.095934	1
68	1	2026-06-28	3	46	47	1	2026-06-19 02:35:51.440942	2026-06-19 03:07:09.815901	1
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.results (id, fixture_id, home_goals, away_goals, created_at, updated_at) FROM stdin;
1	2	2	1	2026-06-18 03:05:28.913832	2026-06-18 03:05:28.913832
2	1	2	0	2026-06-18 03:05:28.931639	2026-06-18 03:05:28.931639
3	3	1	1	2026-06-18 03:05:28.937496	2026-06-18 03:05:28.937496
4	4	4	1	2026-06-18 03:05:28.942831	2026-06-18 03:05:28.942831
5	5	1	1	2026-06-18 03:05:28.954516	2026-06-18 03:05:28.954516
6	6	1	1	2026-06-18 03:05:28.959822	2026-06-18 03:05:28.959822
7	7	0	1	2026-06-18 03:05:28.965355	2026-06-18 03:05:28.965355
8	8	2	0	2026-06-18 03:05:28.970672	2026-06-18 03:05:28.970672
9	9	7	1	2026-06-18 03:05:28.975764	2026-06-18 03:05:28.975764
10	10	2	2	2026-06-18 03:05:28.981098	2026-06-18 03:05:28.981098
11	11	1	0	2026-06-18 03:05:28.986231	2026-06-18 03:05:28.986231
12	12	5	1	2026-06-18 03:05:28.991245	2026-06-18 03:05:28.991245
13	13	0	0	2026-06-18 03:05:28.996604	2026-06-18 03:05:28.996604
14	14	1	1	2026-06-18 03:05:29.001968	2026-06-18 03:05:29.001968
15	15	1	1	2026-06-18 03:05:29.007018	2026-06-18 03:05:29.007018
16	16	2	2	2026-06-18 03:05:29.012376	2026-06-18 03:05:29.012376
17	17	3	1	2026-06-18 03:05:29.017765	2026-06-18 03:05:29.017765
18	19	3	0	2026-06-18 03:05:29.022699	2026-06-18 03:05:29.022699
19	18	1	4	2026-06-18 03:05:29.027837	2026-06-18 03:05:29.027837
20	20	3	1	2026-06-18 03:05:29.033068	2026-06-18 03:05:29.033068
21	21	1	1	2026-06-18 03:07:21.963107	2026-06-18 03:07:21.963107
22	22	4	2	2026-06-18 03:07:37.818083	2026-06-18 03:07:37.818083
23	23	1	0	2026-06-18 03:07:48.669982	2026-06-18 03:07:48.669982
24	24	1	3	2026-06-19 02:37:27.163761	2026-06-19 02:37:27.163761
25	25	1	1	2026-06-19 02:38:10.34543	2026-06-19 02:38:10.34543
26	26	4	1	2026-06-19 02:38:28.228878	2026-06-19 02:38:28.228878
27	27	6	0	2026-06-19 02:38:54.144712	2026-06-19 02:38:54.144712
28	28	1	0	2026-06-19 03:10:38.670766	2026-06-19 03:10:38.670766
\.


--
-- Data for Name: rounds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rounds (id, sequence, name, created_at, updated_at) FROM stdin;
1	1	Group	2026-06-18 02:41:01.764337	2026-06-18 02:41:01.764337
2	2	Round of 32	2026-06-18 02:41:01.765923	2026-06-18 02:41:01.765923
3	3	Round of 16	2026-06-18 02:41:01.767066	2026-06-18 02:41:01.767066
4	4	Quarter-finals	2026-06-18 02:41:01.768433	2026-06-18 02:41:01.768433
5	5	Semi-finals	2026-06-18 02:41:01.775374	2026-06-18 02:41:01.775374
6	6	FinalS	2026-06-18 02:41:01.776602	2026-06-18 02:41:01.776602
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20260614100406
20260614102826
20260614103632
20260614104224
20260614105126
20260614110838
20260614110943
20260615102446
20260616093104
20260616150223
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, sequence, "time", created_at, updated_at) FROM stdin;
1	1	00:00:00	2026-06-18 02:41:01.781946	2026-06-18 02:41:01.781946
2	2	02:00:00	2026-06-18 02:41:01.783495	2026-06-18 02:41:01.783495
3	3	03:00:00	2026-06-18 02:41:01.784688	2026-06-18 02:41:01.784688
4	4	05:00:00	2026-06-18 02:41:01.785906	2026-06-18 02:41:01.785906
5	5	06:00:00	2026-06-18 02:41:01.787061	2026-06-18 02:41:01.787061
6	6	08:00:00	2026-06-18 02:41:01.788186	2026-06-18 02:41:01.788186
7	7	09:00:00	2026-06-18 02:41:01.789512	2026-06-18 02:41:01.789512
8	8	11:00:00	2026-06-18 02:41:01.790731	2026-06-18 02:41:01.790731
9	9	17:00:00	2026-06-18 02:41:01.791895	2026-06-18 02:41:01.791895
10	10	20:00:00	2026-06-18 02:41:01.793035	2026-06-18 02:41:01.793035
11	11	22:00:00	2026-06-18 02:41:01.794131	2026-06-18 02:41:01.794131
12	12	23:00:00	2026-06-18 02:41:01.795284	2026-06-18 02:41:01.795284
13	13	00:00:00	2026-06-19 02:35:51.362772	2026-06-19 02:35:51.362772
14	13	03:00:00	2026-06-19 02:35:51.368145	2026-06-19 02:35:51.368145
15	13	21:00:00	2026-06-19 02:35:51.387269	2026-06-19 02:35:51.387269
16	13	18:00:00	2026-06-19 02:35:51.425592	2026-06-19 02:35:51.425592
\.


--
-- Data for Name: standings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.standings (id, team_id, played, wins, draws, losses, goals_for, goals_against, points, created_at, updated_at) FROM stdin;
7	13	1	1	0	0	4	1	3	2026-06-18 03:05:28.944236	2026-06-18 03:05:28.944236
8	14	1	0	0	1	1	4	0	2026-06-18 03:05:28.952127	2026-06-18 03:05:28.952127
11	9	1	0	1	0	1	1	1	2026-06-18 03:05:28.96144	2026-06-18 03:05:28.96144
12	10	1	0	1	0	1	1	1	2026-06-18 03:05:28.963053	2026-06-18 03:05:28.963053
13	11	1	0	0	1	0	1	0	2026-06-18 03:05:28.966918	2026-06-18 03:05:28.966918
14	12	1	1	0	0	1	0	3	2026-06-18 03:05:28.968359	2026-06-18 03:05:28.968359
15	15	1	1	0	0	2	0	3	2026-06-18 03:05:28.972149	2026-06-18 03:05:28.972149
16	16	1	0	0	1	0	2	0	2026-06-18 03:05:28.973529	2026-06-18 03:05:28.973529
17	17	1	1	0	0	7	1	3	2026-06-18 03:05:28.977258	2026-06-18 03:05:28.977258
18	18	1	0	0	1	1	7	0	2026-06-18 03:05:28.978918	2026-06-18 03:05:28.978918
19	21	1	0	1	0	2	2	1	2026-06-18 03:05:28.982493	2026-06-18 03:05:28.982493
20	22	1	0	1	0	2	2	1	2026-06-18 03:05:28.983994	2026-06-18 03:05:28.983994
21	19	1	1	0	0	1	0	3	2026-06-18 03:05:28.987666	2026-06-18 03:05:28.987666
22	20	1	0	0	1	0	1	0	2026-06-18 03:05:28.989055	2026-06-18 03:05:28.989055
23	23	1	1	0	0	5	1	3	2026-06-18 03:05:28.992806	2026-06-18 03:05:28.992806
24	24	1	0	0	1	1	5	0	2026-06-18 03:05:28.994335	2026-06-18 03:05:28.994335
25	29	1	0	1	0	0	0	1	2026-06-18 03:05:28.99795	2026-06-18 03:05:28.99795
26	30	1	0	1	0	0	0	1	2026-06-18 03:05:28.999842	2026-06-18 03:05:28.999842
27	25	1	0	1	0	1	1	1	2026-06-18 03:05:29.003321	2026-06-18 03:05:29.003321
28	26	1	0	1	0	1	1	1	2026-06-18 03:05:29.004876	2026-06-18 03:05:29.004876
29	31	1	0	1	0	1	1	1	2026-06-18 03:05:29.008569	2026-06-18 03:05:29.008569
30	32	1	0	1	0	1	1	1	2026-06-18 03:05:29.009979	2026-06-18 03:05:29.009979
31	27	1	0	1	0	2	2	1	2026-06-18 03:05:29.013914	2026-06-18 03:05:29.013914
32	28	1	0	1	0	2	2	1	2026-06-18 03:05:29.015584	2026-06-18 03:05:29.015584
33	33	1	1	0	0	3	1	3	2026-06-18 03:05:29.019202	2026-06-18 03:05:29.019202
34	34	1	0	0	1	1	3	0	2026-06-18 03:05:29.020618	2026-06-18 03:05:29.020618
35	37	1	1	0	0	3	0	3	2026-06-18 03:05:29.024117	2026-06-18 03:05:29.024117
36	38	1	0	0	1	0	3	0	2026-06-18 03:05:29.025492	2026-06-18 03:05:29.025492
37	35	1	0	0	1	1	4	0	2026-06-18 03:05:29.029411	2026-06-18 03:05:29.029411
38	36	1	1	0	0	4	1	3	2026-06-18 03:05:29.030885	2026-06-18 03:05:29.030885
39	39	1	1	0	0	3	1	3	2026-06-18 03:05:29.034467	2026-06-18 03:05:29.034467
40	40	1	0	0	1	1	3	0	2026-06-18 03:05:29.035857	2026-06-18 03:05:29.035857
41	41	1	0	1	0	1	1	1	2026-06-18 03:07:21.973438	2026-06-18 03:07:21.973438
42	42	1	0	1	0	1	1	1	2026-06-18 03:07:21.975642	2026-06-18 03:07:21.975642
43	45	1	1	0	0	4	2	3	2026-06-18 03:07:37.820435	2026-06-18 03:07:37.820435
44	46	1	0	0	1	2	4	0	2026-06-18 03:07:37.822304	2026-06-18 03:07:37.822304
45	47	1	1	0	0	1	0	3	2026-06-18 03:07:48.672425	2026-06-18 03:07:48.672425
46	48	1	0	0	1	0	1	0	2026-06-18 03:07:48.674282	2026-06-18 03:07:48.674282
47	43	1	0	0	1	1	3	0	2026-06-19 02:37:27.176356	2026-06-19 02:37:27.176356
48	44	1	1	0	0	3	1	3	2026-06-19 02:37:27.17953	2026-06-19 02:37:27.17953
2	4	2	0	1	1	2	3	1	2026-06-18 03:05:28.929292	2026-06-19 02:38:10.348214
4	2	2	0	1	1	1	3	1	2026-06-18 03:05:28.934842	2026-06-19 02:38:10.350866
10	8	2	1	1	0	5	2	4	2026-06-18 03:05:28.95751	2026-06-19 02:38:28.232168
6	6	2	0	1	1	2	5	1	2026-06-18 03:05:28.940605	2026-06-19 02:38:28.234512
5	5	2	1	1	0	7	1	4	2026-06-18 03:05:28.939004	2026-06-19 02:38:54.152166
9	7	2	0	1	1	1	7	1	2026-06-18 03:05:28.955967	2026-06-19 02:38:54.154627
3	1	2	2	0	0	3	0	6	2026-06-18 03:05:28.93313	2026-06-19 03:10:38.674239
1	3	2	1	0	1	2	2	3	2026-06-18 03:05:28.927208	2026-06-19 03:10:38.67653
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (id, name, "group", ranking, flag, confederation, created_at, updated_at) FROM stdin;
1	Mexico	A	14	mexico_flag.png	CONCACAF	2026-06-18 02:41:01.705882	2026-06-18 02:41:01.705882
2	South Africa	A	65	south_africa_flag.png	CAF	2026-06-18 02:41:01.707839	2026-06-18 02:41:01.707839
3	South Korea	A	25	south_korea_flag.png	AFC	2026-06-18 02:41:01.708971	2026-06-18 02:41:01.708971
4	Czech Republic	A	40	czech_republic_flag.png	UEFA	2026-06-18 02:41:01.710091	2026-06-18 02:41:01.710091
5	Canada	B	45	canada_flag.png	CONCACAF	2026-06-18 02:41:01.711189	2026-06-18 02:41:01.711189
6	Bosnia and Herzegovina	B	58	bosnia_flag.png	UEFA	2026-06-18 02:41:01.712305	2026-06-18 02:41:01.712305
7	Qatar	B	53	qatar_flag.png	AFC	2026-06-18 02:41:01.71342	2026-06-18 02:41:01.71342
8	Switzerland	B	19	switzerland_flag.png	UEFA	2026-06-18 02:41:01.714484	2026-06-18 02:41:01.714484
9	Brazil	C	6	brazil_flag.png	CONMEBOL	2026-06-18 02:41:01.715565	2026-06-18 02:41:01.715565
10	Morocco	C	7	morocco_flag.png	CAF	2026-06-18 02:41:01.71666	2026-06-18 02:41:01.71666
11	Haiti	C	85	haiti_flag.png	CONCACAF	2026-06-18 02:41:01.717723	2026-06-18 02:41:01.717723
12	Scotland	C	32	scotland_flag.png	UEFA	2026-06-18 02:41:01.71879	2026-06-18 02:41:01.71879
13	United States	D	17	usa_flag.png	CONCACAF	2026-06-18 02:41:01.719921	2026-06-18 02:41:01.719921
14	Paraguay	D	50	paraguay_flag.png	CONMEBOL	2026-06-18 02:41:01.720998	2026-06-18 02:41:01.720998
15	Australia	D	25	australia_flag.png	AFC	2026-06-18 02:41:01.722059	2026-06-18 02:41:01.722059
16	Turkey	D	22	turkey_flag.png	UEFA	2026-06-18 02:41:01.723125	2026-06-18 02:41:01.723125
17	Germany	E	10	germany_flag.png	UEFA	2026-06-18 02:41:01.72419	2026-06-18 02:41:01.72419
18	Curacao	E	90	curacao_flag.png	CONCACAF	2026-06-18 02:41:01.725238	2026-06-18 02:41:01.725238
19	Ivory Coast	E	52	ivory_coast_flag.png	CAF	2026-06-18 02:41:01.726435	2026-06-18 02:41:01.726435
20	Ecuador	E	23	ecuador_flag.png	CONMEBOL	2026-06-18 02:41:01.727578	2026-06-18 02:41:01.727578
21	Netherlands	F	8	netherlands_flag.png	UEFA	2026-06-18 02:41:01.728621	2026-06-18 02:41:01.728621
22	Japan	F	18	japan_flag.png	AFC	2026-06-18 02:41:01.729682	2026-06-18 02:41:01.729682
23	Sweden	F	21	sweden_flag.png	UEFA	2026-06-18 02:41:01.730794	2026-06-18 02:41:01.730794
24	Tunisia	F	31	tunisia_flag.png	CAF	2026-06-18 02:41:01.731914	2026-06-18 02:41:01.731914
25	Belgium	G	9	belgium_flag.png	UEFA	2026-06-18 02:41:01.732998	2026-06-18 02:41:01.732998
26	Egypt	G	34	egypt_flag.png	CAF	2026-06-18 02:41:01.734173	2026-06-18 02:41:01.734173
27	Iran	G	20	iran_flag.png	AFC	2026-06-18 02:41:01.735318	2026-06-18 02:41:01.735318
28	New Zealand	G	100	new_zealand_flag.png	OFC	2026-06-18 02:41:01.73642	2026-06-18 02:41:01.73642
29	Spain	H	2	spain_flag.png	UEFA	2026-06-18 02:41:01.737469	2026-06-18 02:41:01.737469
30	Cape Verde	H	70	cape_verde_flag.png	CAF	2026-06-18 02:41:01.738522	2026-06-18 02:41:01.738522
31	Saudi Arabia	H	56	saudi_arabia_flag.png	AFC	2026-06-18 02:41:01.739571	2026-06-18 02:41:01.739571
32	Uruguay	H	16	uruguay_flag.png	CONMEBOL	2026-06-18 02:41:01.74062	2026-06-18 02:41:01.74062
33	France	I	3	france_flag.png	UEFA	2026-06-18 02:41:01.741929	2026-06-18 02:41:01.741929
34	Senegal	I	15	senegal_flag.png	CAF	2026-06-18 02:41:01.743233	2026-06-18 02:41:01.743233
35	Iraq	I	63	iraq_flag.png	AFC	2026-06-18 02:41:01.744426	2026-06-18 02:41:01.744426
36	Norway	I	41	norway_flag.png	UEFA	2026-06-18 02:41:01.745538	2026-06-18 02:41:01.745538
37	Argentina	J	1	argentina_flag.png	CONMEBOL	2026-06-18 02:41:01.7466	2026-06-18 02:41:01.7466
38	Algeria	J	33	algeria_flag.png	CAF	2026-06-18 02:41:01.74767	2026-06-18 02:41:01.74767
39	Austria	J	24	austria_flag.png	UEFA	2026-06-18 02:41:01.748759	2026-06-18 02:41:01.748759
40	Jordan	J	67	jordan_flag.png	AFC	2026-06-18 02:41:01.749817	2026-06-18 02:41:01.749817
41	Portugal	K	5	portugal_flag.png	UEFA	2026-06-18 02:41:01.751035	2026-06-18 02:41:01.751035
42	DR Congo	K	64	dr_congo_flag.png	CAF	2026-06-18 02:41:01.75212	2026-06-18 02:41:01.75212
43	Uzbekistan	K	60	uzbekistan_flag.png	AFC	2026-06-18 02:41:01.753188	2026-06-18 02:41:01.753188
44	Colombia	K	13	colombia_flag.png	CONMEBOL	2026-06-18 02:41:01.754253	2026-06-18 02:41:01.754253
45	England	L	4	england_flag.png	UEFA	2026-06-18 02:41:01.755315	2026-06-18 02:41:01.755315
46	Croatia	L	11	croatia_flag.png	UEFA	2026-06-18 02:41:01.756359	2026-06-18 02:41:01.756359
47	Ghana	L	46	ghana_flag.png	CAF	2026-06-18 02:41:01.75757	2026-06-18 02:41:01.75757
48	Panama	L	52	panama_flag.png	CONCACAF	2026-06-18 02:41:01.758688	2026-06-18 02:41:01.758688
\.


--
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.channels_id_seq', 15, true);


--
-- Name: criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.criteria_id_seq', 1, false);


--
-- Name: fixtures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fixtures_id_seq', 72, true);


--
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.results_id_seq', 28, true);


--
-- Name: rounds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rounds_id_seq', 6, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_id_seq', 16, true);


--
-- Name: standings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.standings_id_seq', 48, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_id_seq', 48, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: criteria criteria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.criteria
    ADD CONSTRAINT criteria_pkey PRIMARY KEY (id);


--
-- Name: fixtures fixtures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fixtures_pkey PRIMARY KEY (id);


--
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: rounds rounds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rounds
    ADD CONSTRAINT rounds_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: standings standings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.standings
    ADD CONSTRAINT standings_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: index_fixtures_on_away_team_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fixtures_on_away_team_id ON public.fixtures USING btree (away_team_id);


--
-- Name: index_fixtures_on_channel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fixtures_on_channel_id ON public.fixtures USING btree (channel_id);


--
-- Name: index_fixtures_on_criterium_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fixtures_on_criterium_id ON public.fixtures USING btree (criterium_id);


--
-- Name: index_fixtures_on_home_team_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fixtures_on_home_team_id ON public.fixtures USING btree (home_team_id);


--
-- Name: index_fixtures_on_round_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fixtures_on_round_id ON public.fixtures USING btree (round_id);


--
-- Name: index_fixtures_on_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fixtures_on_session_id ON public.fixtures USING btree (session_id);


--
-- Name: index_results_on_fixture_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_results_on_fixture_id ON public.results USING btree (fixture_id);


--
-- Name: index_standings_on_team_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_standings_on_team_id ON public.standings USING btree (team_id);


--
-- Name: fixtures fk_rails_0c45715fb6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_0c45715fb6 FOREIGN KEY (criterium_id) REFERENCES public.criteria(id);


--
-- Name: results fk_rails_24208fad15; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT fk_rails_24208fad15 FOREIGN KEY (fixture_id) REFERENCES public.fixtures(id);


--
-- Name: fixtures fk_rails_45a97a2b64; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_45a97a2b64 FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: fixtures fk_rails_75266f13a2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_75266f13a2 FOREIGN KEY (home_team_id) REFERENCES public.teams(id);


--
-- Name: fixtures fk_rails_9af4cca3ac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_9af4cca3ac FOREIGN KEY (round_id) REFERENCES public.rounds(id);


--
-- Name: fixtures fk_rails_e99c2e4db6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_e99c2e4db6 FOREIGN KEY (channel_id) REFERENCES public.channels(id);


--
-- Name: standings fk_rails_e9d6ea91b3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.standings
    ADD CONSTRAINT fk_rails_e9d6ea91b3 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: fixtures fk_rails_fce055dec7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_fce055dec7 FOREIGN KEY (away_team_id) REFERENCES public.teams(id);


--
-- PostgreSQL database dump complete
--

