WARNING:  database "db_pgdp" has a collation version mismatch
DETAIL:  The database was created using collation version 2.38, but the operating system provides version 2.39.
HINT:  Rebuild all objects in this database that use the default collation and run ALTER DATABASE db_pgdp REFRESH COLLATION VERSION, or build PostgreSQL with the right library version.
--
-- PostgreSQL database dump
--

\restrict qAVKtEL0Kn42UobdFTjqSxc6sxU8gZoBBKzIlnKwbp7zlGIpoUtszZi06jjNUhN

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

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
-- Name: enum_FichePresences_statut; Type: TYPE; Schema: public; Owner: mickaelyass
--

CREATE TYPE public."enum_FichePresences_statut" AS ENUM (
    'Présent',
    'Absent',
    'Retard',
    'Permission',
    'Congé',
    'Maladie'
);


ALTER TYPE public."enum_FichePresences_statut" OWNER TO mickaelyass;

--
-- Name: enum_demande_conges_decision_chef_service; Type: TYPE; Schema: public; Owner: mickaelyass
--

CREATE TYPE public.enum_demande_conges_decision_chef_service AS ENUM (
    'Autorisé',
    'Rejeté',
    'En attente'
);


ALTER TYPE public.enum_demande_conges_decision_chef_service OWNER TO mickaelyass;

--
-- Name: enum_demande_conges_decision_directrice; Type: TYPE; Schema: public; Owner: mickaelyass
--

CREATE TYPE public.enum_demande_conges_decision_directrice AS ENUM (
    'Validé',
    'Invalidé',
    'En attente'
);


ALTER TYPE public.enum_demande_conges_decision_directrice OWNER TO mickaelyass;

--
-- Name: enum_fichepresence_statut; Type: TYPE; Schema: public; Owner: mickaelyass
--

CREATE TYPE public.enum_fichepresence_statut AS ENUM (
    'Présent',
    'Absent',
    'Retard',
    'Permission',
    'Congé',
    'Maladie'
);


ALTER TYPE public.enum_fichepresence_statut OWNER TO mickaelyass;

--
-- Name: enum_info_ident_sexe; Type: TYPE; Schema: public; Owner: mickaelyass
--

CREATE TYPE public.enum_info_ident_sexe AS ENUM (
    'F',
    'M'
);


ALTER TYPE public.enum_info_ident_sexe OWNER TO mickaelyass;

--
-- Name: enum_users_role; Type: TYPE; Schema: public; Owner: mickaelyass
--

CREATE TYPE public.enum_users_role AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.enum_users_role OWNER TO mickaelyass;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: demande_conges; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.demande_conges (
    id_cong integer NOT NULL,
    matricule character varying(50) NOT NULL,
    date_debut timestamp with time zone,
    annee_jouissance integer,
    raison text,
    status character varying(50) DEFAULT 'En attente'::character varying,
    decision_chef_service character varying(50) DEFAULT 'En attente'::character varying,
    decision_directrice character varying(50) DEFAULT 'En attente'::character varying,
    piece_jointe integer,
    type_de_conge character varying(255),
    nombre_de_jour integer,
    date_de_fin timestamp with time zone
);


ALTER TABLE public.demande_conges OWNER TO mickaelyass;

--
-- Name: demande_conges_id_cong_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.demande_conges_id_cong_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.demande_conges_id_cong_seq OWNER TO mickaelyass;

--
-- Name: demande_conges_id_cong_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.demande_conges_id_cong_seq OWNED BY public.demande_conges.id_cong;


--
-- Name: details; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.details (
    id_detail integer NOT NULL,
    matricule character varying(255),
    etat character varying(255),
    poste_actuel character varying(255),
    service_actuel character varying(255),
    nouveau_poste character varying(255),
    nouveau_service character varying(255),
    date_prise_fonction timestamp with time zone,
    date_changement timestamp with time zone,
    motif_changement character varying(255),
    type_changement character varying(255),
    besoins_formation character varying(255),
    infop integer
);


ALTER TABLE public.details OWNER TO mickaelyass;

--
-- Name: details_id_detail_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.details_id_detail_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.details_id_detail_seq OWNER TO mickaelyass;

--
-- Name: details_id_detail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.details_id_detail_seq OWNED BY public.details.id_detail;


--
-- Name: diplome; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.diplome (
    id_diplome integer NOT NULL,
    nom_diplome character varying(255),
    date_obtention timestamp with time zone,
    institution character varying(255),
    infop integer
);


ALTER TABLE public.diplome OWNER TO mickaelyass;

--
-- Name: diplome_id_diplome_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.diplome_id_diplome_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diplome_id_diplome_seq OWNER TO mickaelyass;

--
-- Name: diplome_id_diplome_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.diplome_id_diplome_seq OWNED BY public.diplome.id_diplome;


--
-- Name: distinction; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.distinction (
    id_distinction integer NOT NULL,
    ref_distinction character varying(255),
    detail_distinction text,
    infoc integer
);


ALTER TABLE public.distinction OWNER TO mickaelyass;

--
-- Name: distinction_id_distinction_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.distinction_id_distinction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.distinction_id_distinction_seq OWNER TO mickaelyass;

--
-- Name: distinction_id_distinction_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.distinction_id_distinction_seq OWNED BY public.distinction.id_distinction;


--
-- Name: dossier; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.dossier (
    id_dossier integer NOT NULL,
    matricule character varying(50) NOT NULL,
    infoi integer NOT NULL,
    infop integer NOT NULL,
    infob integer NOT NULL,
    infoc integer NOT NULL
);


ALTER TABLE public.dossier OWNER TO mickaelyass;

--
-- Name: dossier_id_dossier_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.dossier_id_dossier_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dossier_id_dossier_seq OWNER TO mickaelyass;

--
-- Name: dossier_id_dossier_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.dossier_id_dossier_seq OWNED BY public.dossier.id_dossier;


--
-- Name: evaluation; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.evaluation (
    id uuid NOT NULL,
    nom_prenom character varying(255) NOT NULL,
    date_lieu_naissance character varying(255) NOT NULL,
    telephone character varying(255),
    email character varying(255),
    situation_familiale character varying(255),
    situation_militaire character varying(255),
    diplome character varying(255),
    matricule character varying(255) NOT NULL,
    cnss character varying(255),
    adresse character varying(255),
    date_prise_service date,
    grade_actuel character varying(255),
    categorie character varying(255),
    echelle character varying(255),
    echelon character varying(255),
    emploi character varying(255),
    contrat_initial character varying(255),
    contrat_renouvele character varying(255),
    cdi character varying(255),
    avenants character varying(255),
    periode_debut date,
    periode_fin date,
    objectifs jsonb,
    resultats jsonb,
    contraintes text,
    superior_notes jsonb,
    committee_notes jsonb
);


ALTER TABLE public.evaluation OWNER TO mickaelyass;

--
-- Name: fichepresence; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.fichepresence (
    id uuid NOT NULL,
    matricule character varying(255) NOT NULL,
    date_presence date NOT NULL,
    heure_arrivee time without time zone,
    heure_depart time without time zone,
    statut public.enum_fichepresence_statut NOT NULL,
    observations text
);


ALTER TABLE public.fichepresence OWNER TO mickaelyass;

--
-- Name: info_bank; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.info_bank (
    id_infob integer NOT NULL,
    rib character varying(255),
    mtn character varying(255),
    celtics character varying(255),
    moov character varying(255)
);


ALTER TABLE public.info_bank OWNER TO mickaelyass;

--
-- Name: info_bank_id_infob_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.info_bank_id_infob_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.info_bank_id_infob_seq OWNER TO mickaelyass;

--
-- Name: info_bank_id_infob_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.info_bank_id_infob_seq OWNED BY public.info_bank.id_infob;


--
-- Name: info_complementaire; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.info_complementaire (
    id_infoc integer NOT NULL,
    observation_particuliere text,
    situat_sante character varying(255)
);


ALTER TABLE public.info_complementaire OWNER TO mickaelyass;

--
-- Name: info_complementaire_id_infoc_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.info_complementaire_id_infoc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.info_complementaire_id_infoc_seq OWNER TO mickaelyass;

--
-- Name: info_complementaire_id_infoc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.info_complementaire_id_infoc_seq OWNED BY public.info_complementaire.id_infoc;


--
-- Name: info_ident; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.info_ident (
    id_infoi integer NOT NULL,
    cnss character varying(255),
    nom character varying(255),
    prenom character varying(255),
    dat_nat timestamp with time zone,
    lieu_nat character varying(255),
    situat_matri character varying(255),
    email character varying(255),
    sexe character varying(1) NOT NULL,
    nom_du_conjoint character varying(255),
    dat_mariage timestamp with time zone,
    nbre_enfants integer
);


ALTER TABLE public.info_ident OWNER TO mickaelyass;

--
-- Name: info_ident_id_infoi_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.info_ident_id_infoi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.info_ident_id_infoi_seq OWNER TO mickaelyass;

--
-- Name: info_ident_id_infoi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.info_ident_id_infoi_seq OWNED BY public.info_ident.id_infoi;


--
-- Name: info_pro; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.info_pro (
    id_infop integer NOT NULL,
    statut character varying(255),
    corps character varying(255),
    categorie character varying(255),
    branche_du_personnel character varying(255),
    fonctions character varying(255),
    dat_prise_fonction timestamp with time zone,
    responsabilite_partiuliere character varying(255),
    grade_paye character varying(255),
    indice_paye integer,
    dat_first_prise_de_service timestamp with time zone,
    dat_de_depart_retraite timestamp with time zone,
    dat_de_prise_service_dans_departement timestamp with time zone,
    ref_acte_de_prise_service_poste_actuel character varying(255),
    poste_actuel_service character varying(255),
    type_structure character varying(255),
    ref_nomination character varying(255),
    zone_sanitaire character varying(255),
    poste_specifique character varying(255),
    nombre_jour_conges_disponible integer
);


ALTER TABLE public.info_pro OWNER TO mickaelyass;

--
-- Name: info_pro_id_infop_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.info_pro_id_infop_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.info_pro_id_infop_seq OWNER TO mickaelyass;

--
-- Name: info_pro_id_infop_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.info_pro_id_infop_seq OWNED BY public.info_pro.id_infop;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.notifications (
    id_notif integer NOT NULL,
    message text NOT NULL,
    is_read boolean DEFAULT false,
    create_dat timestamp with time zone,
    id_user integer NOT NULL
);


ALTER TABLE public.notifications OWNER TO mickaelyass;

--
-- Name: notifications_id_notif_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.notifications_id_notif_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_notif_seq OWNER TO mickaelyass;

--
-- Name: notifications_id_notif_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.notifications_id_notif_seq OWNED BY public.notifications.id_notif;


--
-- Name: piece_jointe; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.piece_jointe (
    id_piece integer NOT NULL,
    url_certificat_non_jouissance text,
    url_derniere_autorisation_conges text,
    demande_conge integer
);


ALTER TABLE public.piece_jointe OWNER TO mickaelyass;

--
-- Name: piece_jointe_id_piece_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.piece_jointe_id_piece_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.piece_jointe_id_piece_seq OWNER TO mickaelyass;

--
-- Name: piece_jointe_id_piece_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.piece_jointe_id_piece_seq OWNED BY public.piece_jointe.id_piece;


--
-- Name: poste_anterieur; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.poste_anterieur (
    id_poste integer NOT NULL,
    nom_poste character varying(255),
    date_debut timestamp with time zone,
    date_fin timestamp with time zone,
    institution character varying(255),
    infop integer
);


ALTER TABLE public.poste_anterieur OWNER TO mickaelyass;

--
-- Name: poste_anterieur_id_poste_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.poste_anterieur_id_poste_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poste_anterieur_id_poste_seq OWNER TO mickaelyass;

--
-- Name: poste_anterieur_id_poste_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.poste_anterieur_id_poste_seq OWNED BY public.poste_anterieur.id_poste;


--
-- Name: sanction; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.sanction (
    id_sanction integer NOT NULL,
    nature_sanction character varying(255),
    infoc integer,
    sanction_punitive character varying(255)
);


ALTER TABLE public.sanction OWNER TO mickaelyass;

--
-- Name: sanction_id_sanction_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.sanction_id_sanction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sanction_id_sanction_seq OWNER TO mickaelyass;

--
-- Name: sanction_id_sanction_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.sanction_id_sanction_seq OWNED BY public.sanction.id_sanction;


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.user_profiles (
    id_user_profile integer NOT NULL,
    matricule character varying(255) NOT NULL,
    profile_image_url text
);


ALTER TABLE public.user_profiles OWNER TO mickaelyass;

--
-- Name: user_profiles_id_user_profile_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.user_profiles_id_user_profile_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_profiles_id_user_profile_seq OWNER TO mickaelyass;

--
-- Name: user_profiles_id_user_profile_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.user_profiles_id_user_profile_seq OWNED BY public.user_profiles.id_user_profile;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: mickaelyass
--

CREATE TABLE public.utilisateur (
    id_user integer NOT NULL,
    matricule character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);


ALTER TABLE public.utilisateur OWNER TO mickaelyass;

--
-- Name: utilisateur_id_user_seq; Type: SEQUENCE; Schema: public; Owner: mickaelyass
--

CREATE SEQUENCE public.utilisateur_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_user_seq OWNER TO mickaelyass;

--
-- Name: utilisateur_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mickaelyass
--

ALTER SEQUENCE public.utilisateur_id_user_seq OWNED BY public.utilisateur.id_user;


--
-- Name: demande_conges id_cong; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.demande_conges ALTER COLUMN id_cong SET DEFAULT nextval('public.demande_conges_id_cong_seq'::regclass);


--
-- Name: details id_detail; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.details ALTER COLUMN id_detail SET DEFAULT nextval('public.details_id_detail_seq'::regclass);


--
-- Name: diplome id_diplome; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.diplome ALTER COLUMN id_diplome SET DEFAULT nextval('public.diplome_id_diplome_seq'::regclass);


--
-- Name: distinction id_distinction; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.distinction ALTER COLUMN id_distinction SET DEFAULT nextval('public.distinction_id_distinction_seq'::regclass);


--
-- Name: dossier id_dossier; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier ALTER COLUMN id_dossier SET DEFAULT nextval('public.dossier_id_dossier_seq'::regclass);


--
-- Name: info_bank id_infob; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_bank ALTER COLUMN id_infob SET DEFAULT nextval('public.info_bank_id_infob_seq'::regclass);


--
-- Name: info_complementaire id_infoc; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_complementaire ALTER COLUMN id_infoc SET DEFAULT nextval('public.info_complementaire_id_infoc_seq'::regclass);


--
-- Name: info_ident id_infoi; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_ident ALTER COLUMN id_infoi SET DEFAULT nextval('public.info_ident_id_infoi_seq'::regclass);


--
-- Name: info_pro id_infop; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_pro ALTER COLUMN id_infop SET DEFAULT nextval('public.info_pro_id_infop_seq'::regclass);


--
-- Name: notifications id_notif; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id_notif SET DEFAULT nextval('public.notifications_id_notif_seq'::regclass);


--
-- Name: piece_jointe id_piece; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.piece_jointe ALTER COLUMN id_piece SET DEFAULT nextval('public.piece_jointe_id_piece_seq'::regclass);


--
-- Name: poste_anterieur id_poste; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.poste_anterieur ALTER COLUMN id_poste SET DEFAULT nextval('public.poste_anterieur_id_poste_seq'::regclass);


--
-- Name: sanction id_sanction; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.sanction ALTER COLUMN id_sanction SET DEFAULT nextval('public.sanction_id_sanction_seq'::regclass);


--
-- Name: user_profiles id_user_profile; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN id_user_profile SET DEFAULT nextval('public.user_profiles_id_user_profile_seq'::regclass);


--
-- Name: utilisateur id_user; Type: DEFAULT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_user SET DEFAULT nextval('public.utilisateur_id_user_seq'::regclass);


--
-- Data for Name: demande_conges; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.demande_conges (id_cong, matricule, date_debut, annee_jouissance, raison, status, decision_chef_service, decision_directrice, piece_jointe, type_de_conge, nombre_de_jour, date_de_fin) FROM stdin;
92	MAT001	2016-07-28 01:00:00+01	2032	Facultatif	En attente	En attente	En attente	92	Congé administratif	63	2016-09-29 01:00:00+01
93	MAT001	2016-07-28 01:00:00+01	2032	Facultatif	Rejetée	Autorisée	Invalidé	93	Congé administratif	12	2016-08-09 01:00:00+01
94	MAT00C	2026-02-17 01:00:00+01	0	Facultatif	En attente	En attente	En attente	94	Congé maternité	45	2026-04-03 01:00:00+01
67	MAT003	2025-01-09 01:00:00+01	0	Facultatif	En attente	En attente	En attente	67	Congé maladie	15	2025-01-24 01:00:00+01
78	MAT003	2025-03-04 01:00:00+01	2016	Facultatif	En attente	En attente	En attente	78	Congé administratif	12	2025-03-16 01:00:00+01
\.


--
-- Data for Name: details; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.details (id_detail, matricule, etat, poste_actuel, service_actuel, nouveau_poste, nouveau_service, date_prise_fonction, date_changement, motif_changement, type_changement, besoins_formation, infop) FROM stdin;
1	MAT001	Actif	Secrétaire	Service A	\N	\N	2024-01-01 00:00:00+01	2024-01-01 00:00:00+01	Aucun	Mutation	Formation en cours	1
2	MAT00C	Actif	Secrétaire	Service A	\N	\N	2024-01-01 00:00:00+01	2024-01-01 00:00:00+01	Aucun	Mutation	Formation en cours	2
3	MAT003	Actif	Secrétaire	Service A	\N	\N	2024-01-01 00:00:00+01	2024-01-01 00:00:00+01	Aucun	Mutation	Formation en cours	3
4	MAT002	Actif	Secrétaire	Service A	\N	\N	2024-01-01 00:00:00+01	2024-01-01 00:00:00+01	Aucun	Mutation	Formation en cours	5
5	MAT00G	Actif	Secrétaire	Service A	\N	\N	2024-01-01 00:00:00+01	2024-01-01 00:00:00+01	Aucun	Mutation	Formation en cours	6
\.


--
-- Data for Name: diplome; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.diplome (id_diplome, nom_diplome, date_obtention, institution, infop) FROM stdin;
34	licence	2025-03-13 01:00:00+01	efes	1
\.


--
-- Data for Name: distinction; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.distinction (id_distinction, ref_distinction, detail_distinction, infoc) FROM stdin;
\.


--
-- Data for Name: dossier; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.dossier (id_dossier, matricule, infoi, infop, infob, infoc) FROM stdin;
1	MAT001	1	1	1	1
2	MAT00C	2	2	2	2
3	MAT003	3	3	3	3
4	MAT002	5	5	5	5
5	MAT00G	6	6	6	6
\.


--
-- Data for Name: evaluation; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.evaluation (id, nom_prenom, date_lieu_naissance, telephone, email, situation_familiale, situation_militaire, diplome, matricule, cnss, adresse, date_prise_service, grade_actuel, categorie, echelle, echelon, emploi, contrat_initial, contrat_renouvele, cdi, avenants, periode_debut, periode_fin, objectifs, resultats, contraintes, superior_notes, committee_notes) FROM stdin;
bf4a0101-6ed0-4191-af83-de693516e6d0	KPANOU Freddy	29 janvier 1991 à Takon	155521111	yassegoungbeseton@gmail.com	Marié	neant	licence	MAT001	14452556	Non précisé	1984-08-11	Sint eum in perferen	C	2	2	Dolore do qui quo do	Nostrud laborum Dui	Est modi iusto sunt	Dicta exercitationem	Ut ipsum id aliquip	2000-01-11	1994-06-15	["Ea eos iusto est vo", "Distinctio Esse et", "Nesciunt et et ea n"]	["Sequi ad veniam rer", "Consequuntur impedit", "In vel est consectet"]	Dolor deserunt iure 	{"ethique": 1, "valeurs": 1, "animation": 1, "assiduite": 1, "competence": 8, "evaluation": 1.5, "encadrement": 1, "ponctualite": 2}	{"ethique": 0, "valeurs": 0, "animation": 0, "assiduite": 0, "competence": 0, "evaluation": 0, "encadrement": 0, "ponctualite": 0}
dc6f4d65-cc88-4ebd-8e84-ac6cd4cfe096	KPANOU Freddy	29 janvier 1991 à Takon	155521111	yassegoungbeseton@gmail.com	Marié	\N	1	MAT001	1445255	Non précisé	2025-02-15	A2	B	3	2	Responsable du magazin	5	58	5	55	2025-02-14	2025-02-14	["Amélioration de la communication interne", "Renforcement du soutien aux équipes", "Optimisation de la gestion administrative"]	["Réduction des délais de traitement des documents et meilleure accessibilité des archives.", "Fluidification de la communication interne", "Optimisation du soutien aux équipes"]	Charge de travail élevée,Retards dans la transmission des informations entre les services et manque de réactivité de certains interlocuteurs.	{"ethique": 0, "valeurs": 0, "animation": 0, "assiduite": 2, "competence": 2, "evaluation": 0, "encadrement": 0, "ponctualite": 2}	{"ethique": 1, "valeurs": 1, "animation": 0.5, "assiduite": 2, "competence": 7, "evaluation": 1, "encadrement": 2, "ponctualite": 0}
16e12b45-a126-462b-9f87-4c9a14092412	DANSOU Jeanne	29 janvier 1889 à So- ava	3555966	yassegoungbeseton@gmail.com	Célibataire	\N	3	MAT003	354788555	Non précisé	2024-11-29	2	B	1	3	3	8	8	8	8	2025-02-09	2025-02-15	["fait le points des achats ", "", ""]	["rapport des achats", "", ""]	diccultés de collecte des facture	{"ethique": 0, "valeurs": 0, "animation": 0, "assiduite": 0, "competence": 0, "evaluation": 0, "encadrement": 0, "ponctualite": 0}	{"ethique": 1, "valeurs": 0, "animation": 0, "assiduite": 0, "competence": 4, "evaluation": 0, "encadrement": 2, "ponctualite": 2}
12f969f2-04bb-4a46-a89e-83437850d28e	KPANOU Freddy	29 janvier 1991 à Takon	155521111	yassegoungbeseton@gmail.com	Marié	neant	1	MAT001	1445255	Non précisé	2020-12-06	A2	A	3	3	Responsable du magazin	6	6	6	6	2025-02-20	2025-02-11	["Développement des actions de sensibilisation", "", ""]	["Renforcement du soutien aux équipes", "", ""]	Manque de ressources	{"ethique": 0, "valeurs": 0, "animation": 0, "assiduite": 0, "competence": 2, "evaluation": 0, "encadrement": 0, "ponctualite": 0}	{"ethique": 1.5, "valeurs": 1, "animation": 1, "assiduite": 2, "competence": 8, "evaluation": 2, "encadrement": 2, "ponctualite": 2}
\.


--
-- Data for Name: fichepresence; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.fichepresence (id, matricule, date_presence, heure_arrivee, heure_depart, statut, observations) FROM stdin;
e5cd6169-5906-430c-9791-c5184cd2f907	MAT003	2025-01-29	00:00:00	00:00:00	Absent	
a7d23de6-9ce2-4447-a062-96b1626e96a9	MAT002	2025-01-29	00:00:00	00:00:00	Absent	
c631d220-355d-4f9b-b640-4c86f5da48cd	MAT001	2025-01-29	09:55:00	17:00:00	Retard	panne de moto
d49bc0ad-3d55-4ef7-b255-eba126e2762a	MAT00C	2025-01-29	00:00:00	00:00:00	Congé	
5be2e09c-2485-483b-a329-948c645f9075	MAT001	2025-01-30	00:00:00	00:00:00	Permission	
6ffe3171-e7e2-46ff-94b7-b3589ad702a9	MAT00C	2025-01-30	00:00:00	00:00:00	Maladie	
c01f6363-664f-4fdb-b109-daf06cf7cea7	MAT003	2025-01-30	00:00:00	00:00:00	Congé	
fb2ee607-ca42-43c7-ae40-07b45e2ce037	MAT002	2025-01-30	00:00:00	00:00:00	Absent	
d12413bc-9cda-420e-8e86-e4d5aa7e5653	MAT003	2025-01-31	00:00:00	00:00:00	Congé	
aa151598-b2a8-49e1-94a3-54ec5c462e9d	MAT002	2025-01-31	00:00:00	00:00:00	Permission	
b32d4b1c-82d0-4180-b1c6-a12fc6dca637	MAT001	2025-01-31	08:00:00	18:00:00	Absent	
7b599dae-d86d-4a4b-a9c5-b6fb5cf1476b	MAT00C	2025-01-31	00:00:00	00:00:00	Absent	
5ba8d734-7bdc-4b85-9e21-68b79056f8f8	MAT001	2025-02-01	00:00:00	00:00:00	Absent	
b8f2e893-d176-4168-ab42-38b91aeb8d76	MAT003	2025-02-01	11:00:00	15:00:00	Retard	
3db98907-a4c0-4b7c-83d5-5b7e79bb0e2c	MAT00C	2025-02-01	08:00:00	18:00:00	Présent	
ec0423d1-8ea2-4168-9a24-b26b5bb41c09	MAT002	2025-02-01	00:00:00	00:00:00	Absent	
da3e3e83-e4a5-4559-826b-40222f656bed	MAT00G	2025-02-01	00:00:00	00:00:00	Absent	
62cbe3b5-915c-4266-b6da-d69904dfa3ce	MAT003	2025-02-06	00:00:00	00:00:00	Absent	
d260f532-cd47-4110-bd28-c31edaae495d	MAT002	2025-02-06	00:00:00	00:00:00	Absent	
8d5a6ae6-1838-45ae-8502-1634d432a0d6	MAT001	2025-02-06	00:00:00	00:00:00	Absent	
f82472ae-8936-4114-886e-15dd83f20eb3	MAT00G	2025-02-06	00:00:00	00:00:00	Absent	
3bfa1432-e357-4c83-affd-647ba2e44365	MAT00C	2025-02-06	00:00:00	00:00:00	Absent	
0c04aae5-0e3f-4290-bf48-10f887e58398	MAT001	2025-03-03	00:00:00	00:00:00	Absent	
e404c4d5-f9f3-4f85-8385-f2913fc88bad	MAT00C	2025-03-03	00:00:00	00:00:00	Absent	
792cc65b-cf8c-4adf-b722-6e670516c52f	MAT00G	2025-03-03	00:00:00	00:00:00	Absent	
ab44b341-3b7d-4fb8-a5d8-fe04107d7dcb	MAT002	2025-03-03	00:00:00	00:00:00	Absent	
ff70b991-304c-4c8b-9d8c-c1daf8319d3e	MAT003	2025-03-03	00:00:00	00:00:00	Absent	
a14effe7-c53a-4c6d-abc3-1d8599557951	MAT001	2025-03-06	06:00:00	00:00:00	Présent	
bdd47135-2a87-471c-96bb-a8d78961f002	MAT002	2025-03-06	00:00:00	00:00:00	Absent	
fd0c046f-58d1-48dc-a2a1-64f71720dc34	MAT003	2025-03-06	00:00:00	00:00:00	Absent	
04224f41-7fc4-4aa2-9123-8ae25f153817	MAT00C	2025-03-06	00:00:00	00:00:00	Absent	
acac0d53-b3ec-4944-a3e5-eabcb3c82945	MAT00G	2025-03-06	00:00:00	00:00:00	Absent	
\.


--
-- Data for Name: info_bank; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.info_bank (id_infob, rib, mtn, celtics, moov) FROM stdin;
5	496669	987654321	12345	4566646
1	126662	155521111	1445454	1555444
2	144555	144455555	1455555	1455555
3	3548985	3555966	35589898	359996
6	5663322	90008015	1586331	47859632
\.


--
-- Data for Name: info_complementaire; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.info_complementaire (id_infoc, observation_particuliere, situat_sante) FROM stdin;
5		Bonne
1		Bonne
2	neant	Bonne
3	neant	Bonne
6	neant	Bonne
\.


--
-- Data for Name: info_ident; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.info_ident (id_infoi, cnss, nom, prenom, dat_nat, lieu_nat, situat_matri, email, sexe, nom_du_conjoint, dat_mariage, nbre_enfants) FROM stdin;
5	1566665	KPOTON	Wilfried	2000-04-02 01:00:00+01	Azowlisse	Célibataire	willy@gmail.com	M		\N	0
2	1566664	DOSSOU	Eric	1992-04-12 01:00:00+01	Zakpota	Marié	yassegoungbeseton@gmail.com	F	LEGBA Helene	2015-01-07 01:00:00+01	0
3	354788555	DANSOU	Jeanne	1889-01-29 00:38:48+00:38:48	So- ava	Célibataire	yassegoungbeseton@gmail.com	F		2000-01-01 00:00:00+01	0
6	1445255	ZANNOU	Paul	1988-04-12 01:00:00+01	Natitingou	Marié	paul@gmail.com	M	DOHOU Irène	2016-02-19 01:00:00+01	1
1	14452556	KPANOU	Freddy	1991-01-29 01:00:00+01	Takon	Marié	yassegoungbeseton@gmail.com	M	Toffo Anne	2022-02-17 01:00:00+01	1
\.


--
-- Data for Name: info_pro; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.info_pro (id_infop, statut, corps, categorie, branche_du_personnel, fonctions, dat_prise_fonction, responsabilite_partiuliere, grade_paye, indice_paye, dat_first_prise_de_service, dat_de_depart_retraite, dat_de_prise_service_dans_departement, ref_acte_de_prise_service_poste_actuel, poste_actuel_service, type_structure, ref_nomination, zone_sanitaire, poste_specifique, nombre_jour_conges_disponible) FROM stdin;
1	FE	Agents	A2	neant	Responsable du magazin	2021-12-13 01:00:00+01	\N	A2	1200	2020-12-06 01:00:00+01	2051-01-29 01:00:00+01	2020-12-12 01:00:00+01		SPAF	Publique			Magazinier	3
2	ACDPE	Agents	B	1	Chef de la RIPOSTE	2017-12-13 01:00:00+01	\N	A1	245	2017-12-14 01:00:00+01	2050-04-12 01:00:00+01	2017-12-20 01:00:00+01		SPAF	Public			Docteur	412
5	AFC	Agents	B	neant	Réparation Electrique	2018-08-02 01:00:00+01	\N	A2	315	2018-02-05 01:00:00+01	2058-04-02 01:00:00+01	2018-02-05 01:00:00+01		SPAF	Publique			Electicien	2017
6	ACDPE	Sécurité	B	neant	Sécurité	2014-05-02 01:00:00+01	\N	0	0	2014-05-02 01:00:00+01	2046-04-12 01:00:00+01	2014-05-02 01:00:00+01		SPAF	Publique			 Chef Securité	43
3	FE	Infirmier	B	neant	3	2024-12-14 01:00:00+01	\N	2	4444	2024-11-29 01:00:00+01	1947-01-28 01:00:00+01	2024-12-14 01:00:00+01		DDS	interne			Infirmiere OMEL	305
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.notifications (id_notif, message, is_read, create_dat, id_user) FROM stdin;
81	Nouveau demande de congé faire par l'agent : MAT001	t	2025-01-29 07:36:10.314+01	1
82	Nouveau demande de congé faire par l'agent : MAT001	f	2025-01-31 21:47:27.451+01	1
83	La demande de congé de l'agent MAT001 est Autorisée	f	2025-01-31 21:50:06.621+01	1
84	La demande de congé de l'agent MAT001 est Validé	f	2025-01-31 21:50:55.381+01	1
85	Nouveau demande de congé faire par l'agent : MAT003	f	2025-01-31 21:59:15.212+01	6
87	La demande de congé de l'agent MAT001 est Autorisée	f	2025-01-31 22:01:49.346+01	1
88	La demande de congé de l'agent MAT001 est Validé	f	2025-01-31 22:02:13.591+01	1
89	Nouveau demande de congé faire par l'agent : MAT001	f	2025-02-01 09:42:31.125+01	1
86	Nouveau demande de congé faire par l'agent : MAT001	t	2025-01-31 22:00:48.734+01	1
90	La demande de congé de l'agent MAT001 est Validé	f	2025-02-01 13:03:57.205+01	1
91	Nouveau demande de congé faire par l'agent : MAT00G	t	2025-02-13 02:13:10.547+01	8
92	Nouveau demande de congé faire par l'agent : MAT00G	f	2025-02-13 02:19:15.135+01	8
93	Nouveau demande de congé faire par l'agent : MAT00G	f	2025-02-13 02:24:38.694+01	8
94	Nouveau demande de congé faire par l'agent : MAT00G	f	2025-02-13 02:28:27.066+01	8
95	Nouveau demande de congé faire par l'agent : MAT001	f	2025-02-13 16:03:29.129+01	1
96	La demande de congé de l'agent MAT001 est Autorisée	f	2025-02-13 16:04:49.666+01	1
97	Nouveau demande de congé faire par l'agent : MAT001	t	2025-03-02 12:03:42.581+01	1
98	La demande de congé de l'agent MAT001 est Autorisée	t	2025-03-03 20:33:57.893+01	1
99	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-06 10:04:56.759+01	1
100	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-21 15:05:14.842+01	1
101	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-21 15:05:59.206+01	1
102	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-21 15:07:08.062+01	1
103	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:51:28.747+01	1
104	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:51:39.251+01	1
105	La demande de congé de l'agent MAT00G est Autorisée	f	2025-03-24 11:51:47.127+01	8
106	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:52:02.46+01	1
107	La demande de congé de l'agent MAT00G est Autorisée	f	2025-03-24 11:52:12.713+01	8
109	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:52:36.197+01	1
112	La demande de congé de l'agent MAT001 est Rejetée	f	2025-03-24 11:53:04.802+01	1
113	La demande de congé de l'agent MAT001 est Rejetée	f	2025-03-24 11:53:12.68+01	1
116	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:54:33.259+01	1
117	La demande de congé de l'agent MAT00G est Autorisée	f	2025-03-24 11:54:45.622+01	8
118	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:54:56.538+01	1
119	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:55:05.495+01	1
120	La demande de congé de l'agent MAT00C est Autorisée	f	2025-03-24 11:55:17.204+01	4
121	La demande de congé de l'agent MAT00G est Autorisée	f	2025-03-24 11:55:27.805+01	8
122	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:55:46.902+01	1
123	La demande de congé de l'agent MAT00G est Autorisée	f	2025-03-24 11:55:57.298+01	8
124	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 11:57:26.387+01	1
125	Nouveau demande de congé faire par l'agent : MAT003	f	2025-03-24 11:58:29.893+01	6
126	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-24 11:59:58.032+01	1
127	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-24 12:02:58.216+01	1
128	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 12:03:27.801+01	1
129	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 12:04:11.469+01	1
130	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-24 12:05:16.031+01	1
131	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 12:05:43.07+01	1
132	La demande de congé de l'agent MAT00C est Validé	f	2025-03-24 12:06:22.053+01	4
133	La demande de congé de l'agent MAT001 est Validé	f	2025-03-24 12:10:03.741+01	1
134	La demande de congé de l'agent MAT001 est Validé	f	2025-03-24 12:10:15.063+01	1
135	La demande de congé de l'agent MAT00C est Validé	f	2025-03-24 12:10:25.579+01	4
136	La demande de congé de l'agent MAT00G est Validé	f	2025-03-24 12:10:34.673+01	8
137	La demande de congé de l'agent MAT00C est Validé	f	2025-03-24 12:10:45.439+01	4
138	La demande de congé de l'agent MAT001 est Validé	f	2025-03-24 12:11:01.15+01	1
140	La demande de congé de l'agent MAT00G est Invalidé	f	2025-03-24 12:11:29.147+01	8
141	La demande de congé de l'agent MAT00G est Invalidé	f	2025-03-24 12:11:38.939+01	8
142	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-24 12:11:50.577+01	1
143	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-24 12:12:00.676+01	1
144	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-24 12:12:10.95+01	1
145	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-24 12:12:30.73+01	1
146	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-24 12:12:40.3+01	1
147	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-24 12:12:48.987+01	1
148	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-24 12:23:40.546+01	1
149	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-24 12:24:10.242+01	1
150	La demande de congé de l'agent MAT001 est Validé	f	2025-03-24 12:24:34.982+01	1
151	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:37:41.368+01	1
152	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:37:52.761+01	1
153	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:38:05.42+01	1
154	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:38:14.97+01	1
155	La demande de congé de l'agent MAT00G est Invalidé	f	2025-03-26 23:38:29.498+01	8
156	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:38:38.343+01	1
108	La demande de congé de l'agent MAT00C est Autorisée	t	2025-03-24 11:52:24.981+01	4
110	La demande de congé de l'agent MAT00C est Autorisée	t	2025-03-24 11:52:44.477+01	4
111	La demande de congé de l'agent MAT00C est Autorisée	t	2025-03-24 11:52:54.735+01	4
114	La demande de congé de l'agent MAT00C est Rejetée	t	2025-03-24 11:53:23.003+01	4
115	La demande de congé de l'agent MAT00C est Rejetée	t	2025-03-24 11:53:34.151+01	4
157	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:38:47.577+01	1
158	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:39:01.42+01	1
159	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:39:09.498+01	1
160	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-26 23:39:18.651+01	1
161	La demande de congé de l'agent MAT00G est Invalidé	f	2025-03-26 23:39:29.303+01	8
162	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-27 09:06:47.962+01	1
163	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-27 09:07:09.975+01	1
164	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-27 09:07:31.269+01	1
165	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-27 10:12:08.577+01	1
166	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-27 10:12:32.228+01	1
167	La demande de congé de l'agent MAT001 est Validé	f	2025-03-27 10:12:44.324+01	1
168	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-27 15:08:26.497+01	1
169	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-27 15:08:47.977+01	1
170	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-27 15:09:06.651+01	1
171	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-27 22:19:48.129+01	1
172	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-27 22:20:08.145+01	1
173	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-27 22:20:28.935+01	1
174	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-28 23:47:23.458+01	1
175	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-28 23:48:07.51+01	1
176	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-28 23:48:56.259+01	1
177	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-28 23:49:58.861+01	1
178	La demande de congé de l'agent MAT001 est Rejetée	f	2025-03-28 23:50:17.828+01	1
179	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-28 23:51:24.44+01	1
180	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-28 23:51:50.916+01	1
181	La demande de congé de l'agent MAT001 est Validé	f	2025-03-28 23:52:25.915+01	1
182	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-29 01:00:15.606+01	1
183	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-29 01:00:33.041+01	1
184	La demande de congé de l'agent MAT001 est Invalidé	f	2025-03-29 01:00:51.333+01	1
185	Nouveau demande de congé faire par l'agent : MAT001	f	2025-03-29 13:07:34.213+01	1
186	La demande de congé de l'agent MAT001 est Autorisée	f	2025-03-29 13:07:57.057+01	1
187	La demande de congé de l'agent MAT001 est Validé	t	2025-03-29 13:08:18.859+01	1
139	La demande de congé de l'agent MAT00C est Invalidé	t	2025-03-24 12:11:18.216+01	4
188	Nouveau demande de congé faire par l'agent : MAT001	f	2025-07-31 12:46:49.853+01	1
189	La demande de congé de l'agent MAT001 est Autorisée	f	2025-07-31 12:53:52.782+01	1
191	Nouveau demande de congé faire par l'agent : MAT00C	f	2026-02-15 11:03:59.569+01	4
190	La demande de congé de l'agent MAT001 est Invalidé	t	2025-07-31 12:54:58.105+01	1
\.


--
-- Data for Name: piece_jointe; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.piece_jointe (id_piece, url_certificat_non_jouissance, url_derniere_autorisation_conges, demande_conge) FROM stdin;
1	/doc/1733816462237.jpg	/doc/1733816462246.jpg	\N
2	/doc/1733819181055.jpg	/doc/1733819181064.jpg	\N
3	/doc/1733819330793.jpg	/doc/1733819330798.jpg	\N
4	/doc/1733819428115.jpg	/doc/1733819428119.jpg	\N
5	/doc/1733819673343.jpg	/doc/1733819673346.jpg	\N
6	/doc/1733819887600.jpg	/doc/1733819887603.jpg	\N
7	/doc/1733820638686.jpg	/doc/1733820638688.jpg	\N
8	/doc/1733820955154.jpg	/doc/1733820955156.jpg	\N
9	/doc/1733821074373.jpg	/doc/1733821074376.jpg	\N
10	/doc/1734104048737.jpg	/doc/1734104048772.jpg	\N
11	/doc/1734104839929.jpg	/doc/1734104839934.jpg	\N
12	/doc/1734104981678.jpg	/doc/1734104981682.jpg	\N
13	/doc/1734105263018.jpg	/doc/1734105263021.jpg	\N
14	/doc/1734105344284.jpg	/doc/1734105344287.jpg	\N
15	/doc/1734105634095.jpg	/doc/1734105634098.jpg	\N
16	/doc/1734105807497.jpg	/doc/1734105807501.jpg	\N
17	/doc/1734106160764.jpg	/doc/1734106160767.jpg	\N
18	/doc/1734551879725.png	/doc/1734551879727.png	\N
19	/doc/1734552026018.png	/doc/1734552026020.png	\N
20	/doc/1734552077068.png	/doc/1734552077071.png	\N
21	/doc/1734552518302.png	/doc/1734552518305.png	\N
22	/doc/1734552588805.png	/doc/1734552588806.png	\N
23	/doc/1734552630513.png	/doc/1734552630517.png	\N
24	/doc/1734552871772.png	/doc/1734552871774.png	\N
25	/doc/1734553041187.png	/doc/1734553041190.png	\N
26	/doc/1736926478967.pdf	/doc/1736926479025.pdf	\N
27	/doc/1737325066938.pdf	/doc/1737325066977.pdf	\N
28	/doc/1737326925101.pdf	/doc/1737326925264.jpg	\N
29	/doc/1737327425222.pdf	/doc/1737327425253.pdf	\N
30	/doc/1737327873934.pdf	/doc/1737327873947.pdf	\N
31	/doc/1737328149336.pdf	/doc/1737328149369.pdf	\N
32	/doc/1737450317128.pdf	/doc/1737450317152.pdf	\N
33	/doc/1737551158376.pdf	/doc/1737551158459.pdf	\N
34	/doc/1737551526354.pdf	/doc/1737551526403.pdf	\N
35	/doc/1737551680049.pdf	/doc/1737551680079.pdf	\N
36	/doc/1737552155943.pdf	/doc/1737552155975.pdf	\N
37	/doc/1737552503846.pdf	/doc/1737552503858.pdf	\N
38	/doc/1737552864415.pdf	/doc/1737552864456.jpg	\N
39	/doc/1737553070346.pdf	/doc/1737553070350.pdf	\N
40	/doc/1737557781252.pdf	/doc/1737557781272.pdf	\N
41	/doc/1737558174731.pdf	/doc/1737558174738.pdf	\N
42	/doc/1737558456366.pdf	/doc/1737558456369.pdf	\N
43	/doc/1737558511231.pdf	/doc/1737558511235.pdf	\N
44	/doc/1737558873300.pdf	/doc/1737558873309.pdf	\N
45	/doc/1737559104944.pdf	/doc/1737559105004.pdf	\N
46	/doc/1737559158446.pdf	/doc/1737559158467.pdf	\N
47	/doc/1737724359282.pdf	/doc/1737724359331.pdf	\N
48	/doc/1737724424476.pdf	\N	\N
49	/doc/1737725459206.pdf	\N	\N
50	/doc/1737725582395.pdf	\N	\N
51	/doc/1737725622063.pdf	\N	\N
52	/doc/1737725700288.pdf	\N	\N
53	/doc/1737726055546.pdf	/doc/1737726055559.pdf	\N
54	/doc/1737726195343.pdf	/doc/1737726195369.pdf	\N
55	/doc/1737726475720.pdf	/doc/1737726475726.pdf	\N
56	/doc/1737726794291.pdf	/doc/1737726794381.pdf	\N
57	/doc/1737726849752.pdf	\N	\N
58	/doc/1737727364396.pdf	/doc/1737727364443.pdf	\N
59	/doc/1737727709894.pdf	/doc/1737727709902.pdf	\N
60	/doc/1737727737436.pdf	\N	\N
61	/doc/1737793876059.pdf	\N	\N
62	/doc/1737793934942.pdf	/doc/1737793934958.pdf	\N
63	/doc/1737959624683.pdf	\N	\N
64	/doc/1737960989383.pdf	/doc/1737960989393.pdf	\N
65	/doc/1738132570061.pdf	/doc/1738132570149.pdf	\N
66	/doc/1738356441624.pdf	/doc/1738356441864.pdf	\N
67	/doc/1738357154872.pdf	\N	\N
68	/doc/1738357248463.pdf	\N	\N
69	/doc/1738364124434.pdf	\N	\N
70	/doc/1738399350932.pdf	\N	\N
71	/doc/1739409190074.png	/doc/1739409190110.png	\N
72	/doc/1739409554780.png	\N	\N
73	/doc/1739409878511.png	\N	\N
74	/doc/1739410106885.png	\N	\N
75	/doc/1739459008889.png	/doc/1739459008895.png	\N
76	/doc/1740913421034.png	/doc/1740913421085.png	\N
77	/doc/1742565914186.png	/doc/1742565914280.png	\N
78	/doc/1742813909708.pdf	/doc/1742813909730.png	\N
79	/doc/1742813997825.png	\N	\N
80	/doc/1742814178007.png	/doc/1742814178041.pdf	\N
81	/doc/1742814315900.png	/doc/1742814315904.png	\N
82	/doc/1742815420382.pdf	/doc/1742815420443.pdf	\N
83	/doc/1743062807676.pdf	\N	\N
84	/doc/1743066728380.pdf	\N	\N
85	/doc/1743084503702.pdf	/doc/1743084503759.pdf	\N
86	/doc/1743110387880.pdf	\N	\N
87	/doc/1743202041691.pdf	/doc/1743202041707.pdf	\N
88	/doc/1743202198747.pdf	\N	\N
89	/doc/1743202283842.pdf	\N	\N
90	/doc/1743206415422.pdf	\N	\N
91	/doc/1743250054013.pdf	\N	\N
92	/doc/1753962386441.pdf	/doc/1753962386473.png	\N
93	/doc/1753962408378.pdf	/doc/1753962408379.png	\N
94	/doc/1771149838691.jpg	\N	\N
\.


--
-- Data for Name: poste_anterieur; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.poste_anterieur (id_poste, nom_poste, date_debut, date_fin, institution, infop) FROM stdin;
\.


--
-- Data for Name: sanction; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.sanction (id_sanction, nature_sanction, infoc, sanction_punitive) FROM stdin;
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.user_profiles (id_user_profile, matricule, profile_image_url) FROM stdin;
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: mickaelyass
--

COPY public.utilisateur (id_user, matricule, password, role) FROM stdin;
2	MAT00A	$2a$10$YNL8n8Skh3ttXz0CCfi.QuOnty3slnkmrNG.ohGX8/xNQnbhyCHyO	admin
3	MAT002	$2a$10$Nf8XKxF3nUXDFWtAYICeS.p4wuvNEYijY..1rQWcUqslGGXM5T1eO	user
4	MAT00C	$2a$10$5EX6/3FW/J0F3sBGNbfNZ.NCy3UtKqpMkEuDvpy4bw2kdr/yWSv5S	chef_service
5	MAT00D	$2a$10$giPU/lG33w0jJonngwn7VeLWlHq3Am/HCy9kzqXIlsvLfIMleUaRq	directrice
6	MAT003	$2a$10$X2Bbuc1Ojlz.bO3aunQtSOA6U8egw91H5KCFN0ILbrEX65wXWWB8y	user
7	MAT004	$2a$10$qnUuSFLKUTchrRJch8QRD.0gx0DKGaMcVmQ9wchIooZrq374zz2h.	user
1	MAT001	$2a$10$rrZQ7INfJLe9el1bEAgAbOz/AhgRFTDaowG7qTPZUSModgtM6W48K	user
8	MAT00G	$2a$10$fegYrSIgNC1OHmifjVQn8eDSA6sdX.0BpAFsBqQy9wgxhg4Pto2V2	securite
9	MAT05	$2b$10$BVan0kEtNcZD4YqAccs8A.UBhBu05fF2yPy504vRjVcPhuBz9yyAG	user
\.


--
-- Name: demande_conges_id_cong_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.demande_conges_id_cong_seq', 94, true);


--
-- Name: details_id_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.details_id_detail_seq', 74, true);


--
-- Name: diplome_id_diplome_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.diplome_id_diplome_seq', 37, true);


--
-- Name: distinction_id_distinction_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.distinction_id_distinction_seq', 33, true);


--
-- Name: dossier_id_dossier_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.dossier_id_dossier_seq', 8, true);


--
-- Name: info_bank_id_infob_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.info_bank_id_infob_seq', 9, true);


--
-- Name: info_complementaire_id_infoc_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.info_complementaire_id_infoc_seq', 9, true);


--
-- Name: info_ident_id_infoi_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.info_ident_id_infoi_seq', 9, true);


--
-- Name: info_pro_id_infop_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.info_pro_id_infop_seq', 9, true);


--
-- Name: notifications_id_notif_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.notifications_id_notif_seq', 191, true);


--
-- Name: piece_jointe_id_piece_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.piece_jointe_id_piece_seq', 94, true);


--
-- Name: poste_anterieur_id_poste_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.poste_anterieur_id_poste_seq', 36, true);


--
-- Name: sanction_id_sanction_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.sanction_id_sanction_seq', 33, true);


--
-- Name: user_profiles_id_user_profile_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.user_profiles_id_user_profile_seq', 1, false);


--
-- Name: utilisateur_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: mickaelyass
--

SELECT pg_catalog.setval('public.utilisateur_id_user_seq', 9, true);


--
-- Name: demande_conges demande_conges_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.demande_conges
    ADD CONSTRAINT demande_conges_pkey PRIMARY KEY (id_cong);


--
-- Name: details details_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.details
    ADD CONSTRAINT details_pkey PRIMARY KEY (id_detail);


--
-- Name: diplome diplome_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.diplome
    ADD CONSTRAINT diplome_pkey PRIMARY KEY (id_diplome);


--
-- Name: distinction distinction_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.distinction
    ADD CONSTRAINT distinction_pkey PRIMARY KEY (id_distinction);


--
-- Name: dossier dossier_infob_key; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_key UNIQUE (infob);


--
-- Name: dossier dossier_infoc_key; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_key UNIQUE (infoc);


--
-- Name: dossier dossier_infoi_key; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_key UNIQUE (infoi);


--
-- Name: dossier dossier_infop_key; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_key UNIQUE (infop);


--
-- Name: dossier dossier_matricule_key; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_matricule_key UNIQUE (matricule);


--
-- Name: dossier dossier_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_pkey PRIMARY KEY (id_dossier);


--
-- Name: evaluation evaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.evaluation
    ADD CONSTRAINT evaluation_pkey PRIMARY KEY (id);


--
-- Name: fichepresence fichepresence_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.fichepresence
    ADD CONSTRAINT fichepresence_pkey PRIMARY KEY (id);


--
-- Name: info_bank info_bank_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_bank
    ADD CONSTRAINT info_bank_pkey PRIMARY KEY (id_infob);


--
-- Name: info_complementaire info_complementaire_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_complementaire
    ADD CONSTRAINT info_complementaire_pkey PRIMARY KEY (id_infoc);


--
-- Name: info_ident info_ident_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_ident
    ADD CONSTRAINT info_ident_pkey PRIMARY KEY (id_infoi);


--
-- Name: info_pro info_pro_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.info_pro
    ADD CONSTRAINT info_pro_pkey PRIMARY KEY (id_infop);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id_notif);


--
-- Name: piece_jointe piece_jointe_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.piece_jointe
    ADD CONSTRAINT piece_jointe_pkey PRIMARY KEY (id_piece);


--
-- Name: poste_anterieur poste_anterieur_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.poste_anterieur
    ADD CONSTRAINT poste_anterieur_pkey PRIMARY KEY (id_poste);


--
-- Name: sanction sanction_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.sanction
    ADD CONSTRAINT sanction_pkey PRIMARY KEY (id_sanction);


--
-- Name: user_profiles user_profiles_matricule_key; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_matricule_key UNIQUE (matricule);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id_user_profile);


--
-- Name: utilisateur utilisateur_matricule_key; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key1; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key1 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key10; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key10 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key100; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key100 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key101; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key101 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key102; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key102 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key103; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key103 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key104; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key104 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key105; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key105 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key106; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key106 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key107; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key107 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key108; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key108 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key109; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key109 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key11; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key11 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key110; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key110 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key111; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key111 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key112; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key112 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key113; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key113 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key114; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key114 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key115; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key115 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key116; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key116 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key117; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key117 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key118; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key118 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key119; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key119 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key12; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key12 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key120; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key120 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key121; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key121 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key122; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key122 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key123; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key123 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key124; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key124 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key125; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key125 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key126; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key126 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key127; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key127 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key128; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key128 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key129; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key129 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key13; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key13 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key130; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key130 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key131; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key131 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key132; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key132 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key133; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key133 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key134; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key134 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key135; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key135 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key136; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key136 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key137; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key137 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key138; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key138 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key139; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key139 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key14; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key14 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key140; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key140 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key141; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key141 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key142; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key142 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key143; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key143 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key144; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key144 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key145; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key145 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key146; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key146 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key147; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key147 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key148; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key148 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key149; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key149 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key15; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key15 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key150; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key150 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key151; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key151 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key152; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key152 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key153; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key153 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key154; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key154 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key155; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key155 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key156; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key156 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key157; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key157 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key158; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key158 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key159; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key159 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key16; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key16 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key160; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key160 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key161; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key161 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key162; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key162 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key163; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key163 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key164; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key164 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key165; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key165 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key166; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key166 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key167; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key167 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key168; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key168 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key169; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key169 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key17; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key17 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key170; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key170 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key171; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key171 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key172; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key172 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key173; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key173 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key174; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key174 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key175; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key175 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key176; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key176 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key177; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key177 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key178; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key178 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key179; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key179 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key18; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key18 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key180; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key180 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key181; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key181 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key182; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key182 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key183; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key183 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key184; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key184 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key185; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key185 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key186; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key186 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key187; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key187 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key188; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key188 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key189; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key189 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key19; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key19 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key190; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key190 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key191; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key191 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key192; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key192 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key193; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key193 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key194; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key194 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key195; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key195 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key196; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key196 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key197; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key197 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key198; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key198 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key199; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key199 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key2; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key2 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key20; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key20 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key200; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key200 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key201; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key201 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key202; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key202 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key203; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key203 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key204; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key204 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key205; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key205 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key206; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key206 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key207; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key207 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key208; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key208 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key209; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key209 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key21; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key21 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key210; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key210 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key211; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key211 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key212; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key212 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key213; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key213 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key214; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key214 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key215; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key215 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key216; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key216 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key217; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key217 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key218; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key218 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key219; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key219 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key22; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key22 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key220; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key220 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key221; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key221 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key222; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key222 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key223; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key223 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key224; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key224 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key225; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key225 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key226; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key226 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key227; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key227 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key228; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key228 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key229; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key229 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key23; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key23 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key230; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key230 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key231; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key231 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key232; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key232 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key233; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key233 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key234; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key234 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key235; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key235 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key236; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key236 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key237; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key237 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key238; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key238 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key239; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key239 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key24; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key24 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key240; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key240 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key241; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key241 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key242; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key242 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key243; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key243 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key244; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key244 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key245; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key245 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key246; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key246 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key247; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key247 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key248; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key248 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key249; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key249 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key25; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key25 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key250; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key250 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key251; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key251 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key252; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key252 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key253; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key253 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key254; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key254 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key255; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key255 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key256; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key256 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key257; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key257 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key258; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key258 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key259; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key259 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key26; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key26 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key260; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key260 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key261; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key261 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key262; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key262 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key263; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key263 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key264; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key264 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key265; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key265 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key266; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key266 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key267; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key267 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key268; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key268 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key269; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key269 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key27; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key27 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key270; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key270 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key271; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key271 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key272; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key272 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key273; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key273 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key274; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key274 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key275; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key275 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key276; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key276 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key277; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key277 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key278; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key278 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key279; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key279 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key28; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key28 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key280; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key280 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key281; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key281 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key282; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key282 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key283; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key283 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key284; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key284 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key285; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key285 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key286; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key286 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key287; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key287 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key288; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key288 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key289; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key289 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key29; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key29 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key290; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key290 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key291; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key291 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key292; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key292 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key293; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key293 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key294; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key294 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key295; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key295 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key296; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key296 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key297; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key297 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key298; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key298 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key299; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key299 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key3; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key3 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key30; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key30 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key300; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key300 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key301; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key301 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key302; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key302 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key303; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key303 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key304; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key304 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key305; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key305 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key306; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key306 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key307; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key307 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key308; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key308 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key309; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key309 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key31; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key31 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key310; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key310 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key311; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key311 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key312; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key312 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key313; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key313 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key314; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key314 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key315; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key315 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key316; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key316 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key317; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key317 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key318; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key318 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key319; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key319 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key32; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key32 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key320; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key320 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key321; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key321 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key322; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key322 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key323; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key323 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key324; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key324 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key325; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key325 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key326; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key326 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key327; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key327 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key328; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key328 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key329; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key329 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key33; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key33 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key330; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key330 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key331; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key331 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key332; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key332 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key333; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key333 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key334; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key334 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key335; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key335 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key336; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key336 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key337; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key337 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key338; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key338 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key339; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key339 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key34; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key34 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key340; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key340 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key341; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key341 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key342; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key342 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key343; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key343 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key344; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key344 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key345; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key345 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key346; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key346 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key347; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key347 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key348; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key348 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key349; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key349 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key35; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key35 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key350; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key350 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key351; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key351 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key352; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key352 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key353; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key353 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key354; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key354 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key355; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key355 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key356; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key356 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key357; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key357 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key358; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key358 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key359; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key359 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key36; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key36 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key360; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key360 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key361; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key361 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key362; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key362 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key363; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key363 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key364; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key364 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key365; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key365 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key366; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key366 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key367; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key367 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key368; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key368 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key369; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key369 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key37; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key37 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key370; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key370 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key371; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key371 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key372; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key372 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key373; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key373 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key374; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key374 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key375; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key375 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key376; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key376 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key377; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key377 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key378; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key378 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key379; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key379 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key38; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key38 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key380; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key380 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key381; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key381 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key382; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key382 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key383; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key383 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key384; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key384 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key385; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key385 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key386; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key386 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key387; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key387 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key388; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key388 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key389; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key389 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key39; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key39 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key390; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key390 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key391; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key391 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key392; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key392 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key393; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key393 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key394; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key394 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key395; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key395 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key396; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key396 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key397; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key397 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key398; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key398 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key399; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key399 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key4; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key4 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key40; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key40 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key400; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key400 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key401; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key401 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key402; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key402 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key403; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key403 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key404; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key404 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key405; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key405 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key406; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key406 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key407; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key407 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key408; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key408 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key409; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key409 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key41; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key41 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key410; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key410 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key411; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key411 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key412; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key412 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key413; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key413 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key414; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key414 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key415; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key415 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key416; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key416 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key417; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key417 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key418; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key418 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key419; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key419 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key42; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key42 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key420; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key420 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key421; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key421 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key422; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key422 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key423; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key423 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key424; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key424 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key425; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key425 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key426; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key426 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key427; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key427 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key428; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key428 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key429; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key429 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key43; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key43 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key430; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key430 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key431; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key431 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key432; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key432 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key433; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key433 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key434; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key434 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key435; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key435 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key436; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key436 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key437; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key437 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key438; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key438 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key439; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key439 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key44; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key44 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key440; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key440 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key441; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key441 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key442; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key442 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key443; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key443 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key444; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key444 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key445; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key445 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key446; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key446 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key447; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key447 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key448; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key448 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key449; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key449 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key45; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key45 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key450; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key450 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key451; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key451 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key452; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key452 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key453; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key453 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key454; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key454 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key455; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key455 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key456; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key456 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key457; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key457 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key458; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key458 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key459; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key459 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key46; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key46 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key460; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key460 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key461; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key461 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key462; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key462 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key463; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key463 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key464; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key464 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key465; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key465 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key466; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key466 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key467; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key467 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key468; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key468 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key469; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key469 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key47; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key47 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key470; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key470 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key471; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key471 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key472; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key472 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key473; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key473 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key474; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key474 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key475; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key475 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key476; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key476 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key477; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key477 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key478; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key478 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key479; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key479 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key48; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key48 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key480; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key480 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key481; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key481 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key482; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key482 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key483; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key483 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key484; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key484 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key485; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key485 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key486; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key486 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key487; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key487 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key488; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key488 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key489; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key489 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key49; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key49 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key490; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key490 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key491; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key491 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key492; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key492 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key493; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key493 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key494; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key494 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key495; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key495 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key496; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key496 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key497; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key497 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key498; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key498 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key499; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key499 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key5; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key5 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key50; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key50 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key500; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key500 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key501; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key501 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key502; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key502 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key503; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key503 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key504; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key504 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key505; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key505 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key506; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key506 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key507; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key507 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key508; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key508 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key509; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key509 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key51; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key51 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key510; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key510 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key511; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key511 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key512; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key512 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key513; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key513 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key514; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key514 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key515; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key515 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key516; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key516 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key517; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key517 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key518; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key518 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key519; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key519 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key52; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key52 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key520; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key520 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key521; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key521 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key522; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key522 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key523; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key523 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key524; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key524 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key525; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key525 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key526; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key526 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key527; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key527 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key528; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key528 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key529; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key529 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key53; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key53 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key530; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key530 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key531; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key531 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key532; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key532 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key533; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key533 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key534; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key534 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key535; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key535 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key536; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key536 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key537; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key537 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key538; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key538 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key539; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key539 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key54; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key54 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key540; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key540 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key541; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key541 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key542; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key542 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key543; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key543 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key544; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key544 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key545; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key545 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key546; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key546 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key547; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key547 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key548; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key548 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key549; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key549 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key55; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key55 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key550; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key550 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key551; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key551 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key552; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key552 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key553; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key553 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key554; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key554 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key555; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key555 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key556; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key556 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key557; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key557 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key558; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key558 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key559; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key559 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key56; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key56 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key560; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key560 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key561; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key561 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key562; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key562 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key563; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key563 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key564; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key564 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key565; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key565 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key566; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key566 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key567; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key567 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key57; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key57 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key58; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key58 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key59; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key59 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key6; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key6 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key60; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key60 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key61; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key61 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key62; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key62 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key63; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key63 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key64; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key64 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key65; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key65 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key66; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key66 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key67; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key67 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key68; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key68 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key69; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key69 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key7; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key7 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key70; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key70 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key71; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key71 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key72; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key72 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key73; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key73 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key74; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key74 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key75; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key75 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key76; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key76 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key77; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key77 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key78; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key78 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key79; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key79 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key8; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key8 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key80; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key80 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key81; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key81 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key82; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key82 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key83; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key83 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key84; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key84 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key85; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key85 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key86; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key86 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key87; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key87 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key88; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key88 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key89; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key89 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key9; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key9 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key90; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key90 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key91; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key91 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key92; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key92 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key93; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key93 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key94; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key94 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key95; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key95 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key96; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key96 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key97; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key97 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key98; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key98 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_matricule_key99; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_matricule_key99 UNIQUE (matricule);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_user);


--
-- Name: demande_conges demande_conges_matricule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.demande_conges
    ADD CONSTRAINT demande_conges_matricule_fkey FOREIGN KEY (matricule) REFERENCES public.utilisateur(matricule) ON UPDATE CASCADE;


--
-- Name: demande_conges demande_conges_piece_jointe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.demande_conges
    ADD CONSTRAINT demande_conges_piece_jointe_fkey FOREIGN KEY (piece_jointe) REFERENCES public.piece_jointe(id_piece);


--
-- Name: details details_infop_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.details
    ADD CONSTRAINT details_infop_fkey FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: diplome diplome_infop_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.diplome
    ADD CONSTRAINT diplome_infop_fkey FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: distinction distinction_infoc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.distinction
    ADD CONSTRAINT distinction_infoc_fkey FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dossier dossier_infob_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey1 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey10; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey10 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey100; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey100 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey101; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey101 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey102; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey102 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey103; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey103 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey104; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey104 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey105; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey105 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey106; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey106 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey107; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey107 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey108; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey108 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey109; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey109 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey11; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey11 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey110; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey110 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey111; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey111 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey112; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey112 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey113; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey113 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey114; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey114 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey115; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey115 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey116; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey116 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey117; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey117 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey118; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey118 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey119; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey119 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey12; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey12 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey120; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey120 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey121; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey121 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey122; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey122 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey123; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey123 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey124; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey124 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey125; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey125 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey126; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey126 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey127; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey127 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey128; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey128 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey129; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey129 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey13; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey13 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey130; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey130 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey131; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey131 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey132; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey132 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey133; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey133 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey134; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey134 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey135; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey135 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey136; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey136 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey137; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey137 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey138; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey138 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey139; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey139 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey14; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey14 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey140; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey140 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey141; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey141 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey142; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey142 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey143; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey143 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey144; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey144 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey145; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey145 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey146; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey146 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey147; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey147 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey148; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey148 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey149; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey149 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey15; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey15 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey150; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey150 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey151; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey151 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey152; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey152 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey153; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey153 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey154; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey154 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey155; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey155 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey156; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey156 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey157; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey157 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey158; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey158 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey159; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey159 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey16; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey16 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey160; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey160 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey161; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey161 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey162; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey162 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey163; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey163 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey164; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey164 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey165; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey165 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey166; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey166 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey167; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey167 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey168; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey168 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey169; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey169 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey17; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey17 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey170; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey170 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey171; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey171 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey172; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey172 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey173; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey173 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey174; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey174 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey175; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey175 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey176; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey176 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey177; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey177 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey178; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey178 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey179; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey179 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey18; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey18 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey180; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey180 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey181; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey181 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey182; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey182 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey183; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey183 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey184; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey184 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey185; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey185 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey186; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey186 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey187; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey187 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey188; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey188 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey189; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey189 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey19; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey19 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey190; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey190 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey191; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey191 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey192; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey192 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey193; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey193 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey194; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey194 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey195; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey195 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey196; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey196 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey197; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey197 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey198; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey198 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey199; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey199 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey2 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey20; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey20 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey200; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey200 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey201; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey201 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey202; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey202 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey203; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey203 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey204; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey204 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey205; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey205 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey206; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey206 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey207; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey207 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey208; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey208 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey209; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey209 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey21; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey21 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey210; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey210 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey211; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey211 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey212; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey212 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey213; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey213 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey214; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey214 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey215; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey215 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey216; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey216 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey217; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey217 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey218; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey218 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey219; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey219 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey22; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey22 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey220; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey220 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey221; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey221 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey222; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey222 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey223; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey223 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey224; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey224 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey225; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey225 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey226; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey226 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey227; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey227 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey228; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey228 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey229; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey229 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey23; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey23 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey230; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey230 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey231; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey231 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey232; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey232 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey233; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey233 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey234; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey234 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey235; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey235 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey236; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey236 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey237; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey237 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey238; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey238 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey239; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey239 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey24; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey24 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey240; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey240 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey241; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey241 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey242; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey242 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey243; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey243 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey244; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey244 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey245; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey245 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey246; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey246 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey247; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey247 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey248; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey248 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey249; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey249 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey25; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey25 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey250; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey250 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey251; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey251 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey252; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey252 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey253; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey253 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey254; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey254 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey255; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey255 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey256; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey256 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey257; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey257 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey258; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey258 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey259; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey259 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey26; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey26 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey260; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey260 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey261; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey261 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey262; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey262 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey263; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey263 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey264; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey264 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey265; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey265 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey266; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey266 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey267; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey267 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey268; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey268 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey269; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey269 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey27; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey27 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey270; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey270 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey271; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey271 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey272; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey272 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey273; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey273 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey274; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey274 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey275; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey275 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey276; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey276 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey277; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey277 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey278; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey278 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey279; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey279 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey28; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey28 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey280; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey280 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey281; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey281 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey282; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey282 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey283; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey283 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey284; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey284 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey285; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey285 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey286; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey286 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey287; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey287 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey288; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey288 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey289; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey289 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey29; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey29 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey290; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey290 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey291; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey291 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey292; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey292 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey293; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey293 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey294; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey294 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey295; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey295 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey296; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey296 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey297; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey297 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey298; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey298 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey299; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey299 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey3 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey30; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey30 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey300; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey300 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey301; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey301 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey302; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey302 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey303; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey303 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey304; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey304 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey305; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey305 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey306; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey306 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey307; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey307 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey308; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey308 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey309; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey309 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey31; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey31 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey310; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey310 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey311; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey311 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey312; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey312 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey313; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey313 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey314; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey314 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey315; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey315 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey316; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey316 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey317; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey317 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey318; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey318 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey319; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey319 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey32; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey32 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey320; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey320 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey321; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey321 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey322; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey322 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey323; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey323 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey324; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey324 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey325; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey325 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey326; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey326 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey327; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey327 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey328; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey328 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey329; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey329 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey33; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey33 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey330; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey330 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey331; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey331 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey332; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey332 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey333; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey333 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey334; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey334 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey335; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey335 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey336; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey336 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey337; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey337 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey338; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey338 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey339; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey339 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey34; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey34 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey340; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey340 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey341; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey341 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey342; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey342 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey343; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey343 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey344; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey344 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey345; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey345 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey346; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey346 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey347; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey347 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey348; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey348 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey349; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey349 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey35; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey35 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey350; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey350 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey351; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey351 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey352; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey352 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey353; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey353 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey354; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey354 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey355; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey355 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey356; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey356 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey357; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey357 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey358; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey358 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey359; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey359 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey36; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey36 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey360; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey360 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey361; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey361 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey362; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey362 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey363; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey363 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey364; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey364 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey365; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey365 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey366; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey366 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey367; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey367 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey368; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey368 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey369; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey369 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey37; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey37 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey370; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey370 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey371; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey371 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey372; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey372 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey373; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey373 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey374; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey374 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey375; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey375 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey376; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey376 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey377; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey377 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey378; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey378 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey379; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey379 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey38; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey38 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey380; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey380 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey381; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey381 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey382; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey382 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey383; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey383 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey384; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey384 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey385; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey385 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey386; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey386 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey387; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey387 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey388; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey388 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey389; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey389 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey39; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey39 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey390; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey390 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey391; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey391 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey392; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey392 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey393; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey393 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey394; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey394 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey395; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey395 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey396; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey396 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey397; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey397 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey398; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey398 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey399; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey399 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey4 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey40; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey40 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey400; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey400 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey401; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey401 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey402; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey402 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey403; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey403 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey404; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey404 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey405; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey405 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey406; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey406 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey407; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey407 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey408; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey408 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey409; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey409 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey41; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey41 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey410; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey410 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey411; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey411 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey412; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey412 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey413; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey413 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey414; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey414 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey415; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey415 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey416; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey416 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey417; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey417 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey418; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey418 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey419; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey419 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey42; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey42 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey420; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey420 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey421; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey421 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey422; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey422 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey423; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey423 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey424; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey424 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey425; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey425 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey426; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey426 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey427; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey427 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey428; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey428 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey429; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey429 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey43; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey43 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey430; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey430 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey431; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey431 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey432; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey432 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey433; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey433 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey434; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey434 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey435; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey435 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey436; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey436 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey437; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey437 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey438; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey438 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey439; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey439 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey44; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey44 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey440; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey440 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey441; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey441 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey442; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey442 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey443; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey443 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey444; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey444 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey445; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey445 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey446; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey446 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey447; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey447 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey448; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey448 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey449; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey449 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey45; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey45 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey450; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey450 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey451; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey451 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey452; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey452 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey453; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey453 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey454; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey454 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey455; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey455 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey456; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey456 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey457; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey457 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey458; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey458 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey459; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey459 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey46; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey46 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey460; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey460 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey461; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey461 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey462; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey462 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey463; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey463 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey464; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey464 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey465; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey465 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey466; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey466 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey467; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey467 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey468; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey468 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey469; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey469 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey47; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey47 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey470; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey470 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey471; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey471 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey472; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey472 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey473; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey473 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey474; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey474 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey475; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey475 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey476; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey476 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey477; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey477 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey478; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey478 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey479; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey479 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey48; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey48 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey480; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey480 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey481; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey481 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey482; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey482 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey483; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey483 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey484; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey484 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey485; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey485 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey486; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey486 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey487; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey487 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey488; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey488 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey489; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey489 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey49; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey49 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey490; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey490 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey491; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey491 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey492; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey492 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey493; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey493 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey494; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey494 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey495; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey495 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey496; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey496 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey497; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey497 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey498; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey498 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey499; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey499 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey5; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey5 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey50; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey50 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey500; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey500 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey501; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey501 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey502; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey502 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey503; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey503 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey504; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey504 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey505; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey505 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey506; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey506 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey507; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey507 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey508; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey508 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey509; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey509 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey51; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey51 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey510; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey510 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey511; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey511 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey512; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey512 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey513; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey513 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey514; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey514 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey515; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey515 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey516; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey516 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey517; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey517 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey518; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey518 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey519; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey519 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey52; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey52 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey520; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey520 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey521; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey521 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey522; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey522 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey523; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey523 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey524; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey524 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey525; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey525 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey526; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey526 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey527; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey527 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey528; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey528 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey529; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey529 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey53; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey53 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey530; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey530 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey531; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey531 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey532; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey532 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey533; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey533 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey534; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey534 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey535; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey535 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey536; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey536 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey537; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey537 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey538; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey538 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey539; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey539 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey54; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey54 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey540; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey540 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey541; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey541 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey542; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey542 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey543; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey543 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey544; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey544 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey545; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey545 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey546; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey546 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey547; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey547 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey548; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey548 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey549; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey549 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey55; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey55 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey550; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey550 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey551; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey551 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey552; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey552 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey553; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey553 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey554; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey554 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey555; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey555 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey556; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey556 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey557; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey557 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey558; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey558 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey559; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey559 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey56; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey56 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey57; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey57 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey58; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey58 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey59; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey59 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey6; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey6 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey60; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey60 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey61; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey61 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey62; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey62 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey63; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey63 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey64; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey64 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey65; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey65 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey66; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey66 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey67; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey67 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey68; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey68 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey69; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey69 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey7; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey7 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey70; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey70 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey71; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey71 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey72; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey72 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey73; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey73 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey74; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey74 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey75; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey75 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey76; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey76 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey77; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey77 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey78; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey78 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey79; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey79 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey8; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey8 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey80; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey80 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey81; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey81 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey82; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey82 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey83; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey83 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey84; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey84 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey85; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey85 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey86; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey86 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey87; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey87 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey88; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey88 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey89; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey89 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey9; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey9 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey90; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey90 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey91; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey91 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey92; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey92 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey93; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey93 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey94; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey94 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey95; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey95 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey96; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey96 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey97; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey97 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey98; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey98 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infob_fkey99; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infob_fkey99 FOREIGN KEY (infob) REFERENCES public.info_bank(id_infob);


--
-- Name: dossier dossier_infoc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey1 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey10; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey10 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey100; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey100 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey101; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey101 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey102; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey102 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey103; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey103 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey104; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey104 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey105; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey105 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey106; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey106 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey107; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey107 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey108; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey108 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey109; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey109 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey11; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey11 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey110; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey110 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey111; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey111 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey112; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey112 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey113; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey113 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey114; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey114 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey115; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey115 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey116; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey116 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey117; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey117 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey118; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey118 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey119; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey119 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey12; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey12 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey120; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey120 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey121; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey121 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey122; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey122 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey123; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey123 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey124; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey124 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey125; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey125 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey126; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey126 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey127; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey127 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey128; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey128 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey129; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey129 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey13; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey13 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey130; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey130 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey131; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey131 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey132; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey132 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey133; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey133 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey134; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey134 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey135; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey135 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey136; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey136 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey137; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey137 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey138; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey138 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey139; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey139 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey14; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey14 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey140; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey140 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey141; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey141 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey142; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey142 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey143; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey143 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey144; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey144 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey145; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey145 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey146; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey146 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey147; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey147 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey148; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey148 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey149; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey149 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey15; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey15 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey150; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey150 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey151; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey151 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey152; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey152 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey153; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey153 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey154; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey154 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey155; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey155 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey156; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey156 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey157; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey157 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey158; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey158 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey159; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey159 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey16; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey16 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey160; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey160 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey161; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey161 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey162; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey162 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey163; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey163 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey164; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey164 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey165; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey165 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey166; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey166 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey167; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey167 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey168; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey168 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey169; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey169 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey17; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey17 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey170; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey170 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey171; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey171 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey172; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey172 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey173; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey173 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey174; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey174 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey175; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey175 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey176; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey176 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey177; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey177 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey178; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey178 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey179; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey179 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey18; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey18 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey180; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey180 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey181; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey181 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey182; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey182 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey183; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey183 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey184; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey184 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey185; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey185 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey186; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey186 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey187; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey187 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey188; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey188 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey189; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey189 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey19; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey19 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey190; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey190 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey191; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey191 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey192; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey192 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey193; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey193 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey194; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey194 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey195; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey195 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey196; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey196 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey197; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey197 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey198; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey198 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey199; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey199 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey2 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey20; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey20 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey200; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey200 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey201; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey201 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey202; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey202 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey203; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey203 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey204; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey204 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey205; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey205 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey206; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey206 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey207; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey207 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey208; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey208 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey209; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey209 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey21; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey21 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey210; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey210 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey211; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey211 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey212; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey212 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey213; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey213 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey214; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey214 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey215; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey215 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey216; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey216 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey217; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey217 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey218; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey218 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey219; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey219 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey22; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey22 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey220; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey220 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey221; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey221 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey222; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey222 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey223; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey223 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey224; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey224 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey225; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey225 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey226; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey226 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey227; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey227 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey228; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey228 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey229; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey229 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey23; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey23 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey230; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey230 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey231; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey231 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey232; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey232 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey233; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey233 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey234; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey234 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey235; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey235 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey236; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey236 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey237; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey237 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey238; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey238 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey239; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey239 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey24; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey24 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey240; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey240 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey241; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey241 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey242; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey242 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey243; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey243 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey244; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey244 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey245; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey245 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey246; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey246 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey247; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey247 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey248; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey248 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey249; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey249 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey25; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey25 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey250; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey250 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey251; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey251 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey252; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey252 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey253; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey253 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey254; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey254 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey255; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey255 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey256; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey256 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey257; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey257 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey258; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey258 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey259; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey259 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey26; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey26 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey260; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey260 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey261; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey261 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey262; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey262 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey263; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey263 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey264; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey264 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey265; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey265 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey266; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey266 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey267; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey267 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey268; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey268 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey269; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey269 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey27; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey27 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey270; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey270 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey271; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey271 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey272; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey272 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey273; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey273 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey274; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey274 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey275; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey275 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey276; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey276 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey277; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey277 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey278; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey278 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey279; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey279 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey28; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey28 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey280; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey280 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey281; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey281 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey282; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey282 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey283; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey283 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey284; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey284 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey285; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey285 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey286; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey286 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey287; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey287 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey288; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey288 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey289; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey289 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey29; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey29 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey290; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey290 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey291; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey291 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey292; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey292 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey293; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey293 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey294; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey294 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey295; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey295 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey296; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey296 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey297; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey297 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey298; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey298 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey299; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey299 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey3 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey30; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey30 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey300; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey300 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey301; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey301 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey302; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey302 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey303; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey303 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey304; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey304 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey305; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey305 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey306; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey306 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey307; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey307 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey308; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey308 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey309; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey309 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey31; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey31 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey310; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey310 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey311; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey311 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey312; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey312 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey313; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey313 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey314; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey314 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey315; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey315 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey316; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey316 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey317; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey317 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey318; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey318 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey319; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey319 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey32; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey32 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey320; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey320 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey321; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey321 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey322; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey322 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey323; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey323 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey324; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey324 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey325; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey325 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey326; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey326 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey327; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey327 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey328; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey328 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey329; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey329 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey33; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey33 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey330; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey330 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey331; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey331 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey332; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey332 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey333; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey333 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey334; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey334 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey335; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey335 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey336; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey336 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey337; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey337 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey338; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey338 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey339; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey339 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey34; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey34 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey340; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey340 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey341; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey341 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey342; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey342 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey343; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey343 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey344; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey344 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey345; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey345 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey346; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey346 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey347; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey347 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey348; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey348 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey349; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey349 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey35; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey35 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey350; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey350 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey351; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey351 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey352; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey352 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey353; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey353 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey354; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey354 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey355; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey355 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey356; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey356 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey357; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey357 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey358; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey358 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey359; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey359 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey36; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey36 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey360; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey360 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey361; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey361 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey362; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey362 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey363; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey363 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey364; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey364 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey365; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey365 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey366; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey366 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey367; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey367 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey368; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey368 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey369; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey369 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey37; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey37 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey370; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey370 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey371; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey371 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey372; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey372 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey373; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey373 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey374; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey374 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey375; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey375 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey376; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey376 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey377; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey377 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey378; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey378 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey379; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey379 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey38; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey38 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey380; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey380 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey381; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey381 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey382; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey382 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey383; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey383 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey384; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey384 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey385; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey385 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey386; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey386 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey387; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey387 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey388; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey388 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey389; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey389 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey39; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey39 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey390; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey390 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey391; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey391 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey392; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey392 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey393; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey393 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey394; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey394 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey395; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey395 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey396; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey396 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey397; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey397 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey398; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey398 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey399; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey399 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey4 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey40; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey40 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey400; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey400 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey401; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey401 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey402; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey402 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey403; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey403 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey404; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey404 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey405; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey405 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey406; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey406 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey407; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey407 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey408; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey408 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey409; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey409 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey41; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey41 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey410; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey410 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey411; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey411 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey412; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey412 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey413; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey413 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey414; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey414 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey415; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey415 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey416; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey416 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey417; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey417 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey418; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey418 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey419; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey419 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey42; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey42 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey420; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey420 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey421; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey421 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey422; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey422 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey423; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey423 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey424; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey424 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey425; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey425 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey426; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey426 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey427; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey427 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey428; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey428 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey429; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey429 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey43; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey43 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey430; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey430 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey431; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey431 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey432; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey432 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey433; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey433 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey434; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey434 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey435; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey435 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey436; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey436 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey437; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey437 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey438; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey438 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey439; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey439 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey44; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey44 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey440; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey440 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey441; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey441 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey442; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey442 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey443; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey443 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey444; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey444 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey445; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey445 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey446; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey446 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey447; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey447 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey448; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey448 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey449; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey449 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey45; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey45 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey450; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey450 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey451; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey451 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey452; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey452 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey453; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey453 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey454; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey454 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey455; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey455 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey456; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey456 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey457; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey457 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey458; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey458 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey459; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey459 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey46; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey46 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey460; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey460 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey461; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey461 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey462; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey462 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey463; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey463 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey464; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey464 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey465; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey465 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey466; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey466 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey467; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey467 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey468; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey468 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey469; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey469 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey47; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey47 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey470; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey470 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey471; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey471 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey472; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey472 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey473; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey473 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey474; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey474 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey475; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey475 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey476; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey476 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey477; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey477 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey478; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey478 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey479; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey479 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey48; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey48 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey480; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey480 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey481; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey481 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey482; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey482 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey483; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey483 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey484; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey484 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey485; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey485 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey486; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey486 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey487; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey487 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey488; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey488 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey489; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey489 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey49; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey49 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey490; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey490 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey491; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey491 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey492; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey492 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey493; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey493 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey494; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey494 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey495; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey495 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey496; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey496 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey497; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey497 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey498; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey498 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey499; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey499 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey5; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey5 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey50; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey50 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey500; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey500 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey501; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey501 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey502; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey502 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey503; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey503 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey504; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey504 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey505; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey505 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey506; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey506 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey507; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey507 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey508; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey508 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey509; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey509 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey51; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey51 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey510; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey510 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey511; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey511 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey512; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey512 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey513; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey513 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey514; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey514 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey515; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey515 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey516; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey516 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey517; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey517 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey518; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey518 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey519; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey519 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey52; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey52 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey520; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey520 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey521; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey521 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey522; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey522 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey523; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey523 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey524; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey524 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey525; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey525 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey526; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey526 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey527; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey527 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey528; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey528 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey529; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey529 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey53; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey53 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey530; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey530 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey531; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey531 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey532; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey532 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey533; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey533 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey534; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey534 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey535; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey535 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey536; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey536 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey537; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey537 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey538; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey538 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey539; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey539 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey54; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey54 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey540; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey540 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey541; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey541 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey542; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey542 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey543; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey543 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey544; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey544 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey545; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey545 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey546; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey546 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey547; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey547 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey548; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey548 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey549; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey549 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey55; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey55 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey550; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey550 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey551; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey551 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey552; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey552 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey553; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey553 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey554; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey554 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey555; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey555 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey556; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey556 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey557; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey557 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey558; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey558 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey559; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey559 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey56; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey56 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey57; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey57 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey58; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey58 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey59; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey59 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey6; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey6 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey60; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey60 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey61; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey61 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey62; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey62 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey63; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey63 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey64; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey64 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey65; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey65 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey66; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey66 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey67; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey67 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey68; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey68 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey69; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey69 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey7; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey7 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey70; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey70 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey71; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey71 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey72; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey72 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey73; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey73 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey74; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey74 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey75; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey75 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey76; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey76 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey77; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey77 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey78; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey78 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey79; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey79 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey8; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey8 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey80; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey80 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey81; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey81 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey82; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey82 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey83; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey83 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey84; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey84 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey85; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey85 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey86; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey86 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey87; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey87 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey88; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey88 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey89; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey89 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey9; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey9 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey90; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey90 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey91; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey91 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey92; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey92 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey93; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey93 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey94; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey94 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey95; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey95 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey96; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey96 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey97; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey97 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey98; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey98 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoc_fkey99; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoc_fkey99 FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc);


--
-- Name: dossier dossier_infoi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey1 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey10; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey10 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey100; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey100 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey101; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey101 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey102; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey102 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey103; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey103 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey104; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey104 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey105; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey105 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey106; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey106 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey107; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey107 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey108; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey108 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey109; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey109 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey11; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey11 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey110; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey110 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey111; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey111 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey112; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey112 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey113; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey113 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey114; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey114 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey115; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey115 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey116; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey116 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey117; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey117 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey118; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey118 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey119; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey119 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey12; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey12 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey120; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey120 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey121; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey121 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey122; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey122 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey123; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey123 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey124; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey124 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey125; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey125 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey126; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey126 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey127; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey127 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey128; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey128 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey129; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey129 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey13; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey13 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey130; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey130 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey131; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey131 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey132; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey132 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey133; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey133 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey134; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey134 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey135; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey135 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey136; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey136 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey137; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey137 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey138; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey138 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey139; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey139 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey14; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey14 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey140; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey140 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey141; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey141 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey142; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey142 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey143; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey143 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey144; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey144 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey145; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey145 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey146; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey146 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey147; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey147 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey148; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey148 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey149; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey149 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey15; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey15 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey150; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey150 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey151; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey151 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey152; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey152 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey153; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey153 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey154; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey154 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey155; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey155 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey156; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey156 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey157; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey157 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey158; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey158 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey159; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey159 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey16; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey16 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey160; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey160 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey161; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey161 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey162; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey162 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey163; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey163 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey164; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey164 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey165; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey165 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey166; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey166 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey167; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey167 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey168; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey168 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey169; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey169 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey17; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey17 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey170; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey170 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey171; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey171 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey172; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey172 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey173; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey173 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey174; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey174 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey175; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey175 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey176; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey176 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey177; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey177 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey178; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey178 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey179; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey179 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey18; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey18 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey180; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey180 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey181; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey181 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey182; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey182 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey183; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey183 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey184; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey184 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey185; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey185 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey186; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey186 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey187; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey187 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey188; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey188 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey189; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey189 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey19; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey19 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey190; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey190 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey191; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey191 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey192; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey192 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey193; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey193 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey194; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey194 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey195; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey195 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey196; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey196 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey197; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey197 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey198; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey198 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey199; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey199 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey2 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey20; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey20 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey200; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey200 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey201; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey201 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey202; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey202 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey203; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey203 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey204; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey204 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey205; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey205 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey206; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey206 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey207; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey207 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey208; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey208 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey209; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey209 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey21; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey21 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey210; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey210 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey211; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey211 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey212; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey212 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey213; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey213 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey214; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey214 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey215; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey215 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey216; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey216 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey217; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey217 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey218; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey218 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey219; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey219 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey22; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey22 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey220; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey220 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey221; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey221 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey222; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey222 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey223; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey223 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey224; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey224 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey225; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey225 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey226; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey226 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey227; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey227 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey228; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey228 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey229; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey229 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey23; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey23 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey230; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey230 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey231; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey231 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey232; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey232 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey233; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey233 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey234; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey234 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey235; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey235 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey236; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey236 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey237; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey237 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey238; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey238 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey239; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey239 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey24; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey24 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey240; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey240 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey241; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey241 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey242; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey242 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey243; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey243 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey244; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey244 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey245; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey245 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey246; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey246 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey247; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey247 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey248; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey248 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey249; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey249 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey25; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey25 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey250; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey250 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey251; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey251 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey252; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey252 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey253; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey253 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey254; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey254 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey255; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey255 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey256; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey256 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey257; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey257 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey258; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey258 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey259; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey259 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey26; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey26 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey260; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey260 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey261; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey261 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey262; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey262 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey263; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey263 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey264; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey264 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey265; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey265 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey266; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey266 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey267; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey267 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey268; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey268 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey269; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey269 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey27; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey27 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey270; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey270 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey271; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey271 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey272; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey272 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey273; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey273 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey274; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey274 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey275; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey275 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey276; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey276 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey277; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey277 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey278; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey278 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey279; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey279 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey28; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey28 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey280; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey280 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey281; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey281 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey282; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey282 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey283; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey283 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey284; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey284 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey285; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey285 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey286; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey286 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey287; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey287 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey288; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey288 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey289; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey289 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey29; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey29 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey290; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey290 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey291; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey291 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey292; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey292 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey293; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey293 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey294; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey294 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey295; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey295 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey296; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey296 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey297; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey297 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey298; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey298 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey299; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey299 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey3 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey30; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey30 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey300; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey300 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey301; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey301 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey302; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey302 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey303; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey303 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey304; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey304 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey305; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey305 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey306; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey306 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey307; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey307 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey308; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey308 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey309; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey309 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey31; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey31 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey310; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey310 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey311; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey311 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey312; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey312 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey313; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey313 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey314; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey314 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey315; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey315 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey316; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey316 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey317; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey317 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey318; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey318 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey319; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey319 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey32; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey32 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey320; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey320 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey321; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey321 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey322; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey322 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey323; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey323 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey324; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey324 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey325; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey325 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey326; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey326 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey327; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey327 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey328; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey328 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey329; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey329 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey33; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey33 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey330; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey330 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey331; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey331 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey332; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey332 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey333; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey333 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey334; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey334 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey335; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey335 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey336; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey336 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey337; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey337 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey338; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey338 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey339; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey339 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey34; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey34 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey340; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey340 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey341; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey341 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey342; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey342 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey343; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey343 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey344; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey344 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey345; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey345 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey346; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey346 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey347; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey347 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey348; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey348 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey349; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey349 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey35; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey35 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey350; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey350 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey351; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey351 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey352; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey352 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey353; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey353 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey354; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey354 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey355; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey355 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey356; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey356 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey357; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey357 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey358; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey358 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey359; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey359 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey36; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey36 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey360; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey360 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey361; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey361 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey362; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey362 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey363; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey363 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey364; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey364 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey365; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey365 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey366; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey366 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey367; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey367 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey368; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey368 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey369; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey369 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey37; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey37 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey370; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey370 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey371; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey371 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey372; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey372 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey373; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey373 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey374; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey374 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey375; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey375 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey376; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey376 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey377; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey377 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey378; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey378 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey379; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey379 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey38; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey38 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey380; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey380 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey381; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey381 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey382; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey382 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey383; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey383 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey384; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey384 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey385; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey385 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey386; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey386 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey387; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey387 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey388; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey388 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey389; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey389 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey39; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey39 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey390; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey390 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey391; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey391 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey392; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey392 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey393; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey393 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey394; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey394 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey395; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey395 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey396; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey396 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey397; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey397 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey398; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey398 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey399; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey399 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey4 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey40; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey40 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey400; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey400 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey401; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey401 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey402; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey402 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey403; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey403 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey404; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey404 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey405; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey405 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey406; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey406 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey407; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey407 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey408; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey408 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey409; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey409 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey41; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey41 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey410; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey410 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey411; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey411 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey412; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey412 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey413; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey413 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey414; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey414 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey415; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey415 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey416; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey416 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey417; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey417 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey418; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey418 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey419; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey419 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey42; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey42 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey420; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey420 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey421; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey421 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey422; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey422 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey423; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey423 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey424; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey424 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey425; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey425 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey426; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey426 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey427; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey427 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey428; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey428 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey429; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey429 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey43; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey43 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey430; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey430 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey431; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey431 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey432; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey432 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey433; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey433 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey434; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey434 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey435; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey435 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey436; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey436 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey437; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey437 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey438; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey438 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey439; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey439 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey44; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey44 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey440; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey440 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey441; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey441 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey442; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey442 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey443; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey443 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey444; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey444 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey445; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey445 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey446; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey446 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey447; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey447 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey448; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey448 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey449; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey449 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey45; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey45 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey450; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey450 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey451; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey451 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey452; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey452 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey453; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey453 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey454; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey454 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey455; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey455 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey456; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey456 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey457; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey457 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey458; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey458 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey459; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey459 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey46; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey46 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey460; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey460 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey461; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey461 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey462; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey462 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey463; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey463 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey464; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey464 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey465; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey465 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey466; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey466 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey467; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey467 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey468; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey468 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey469; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey469 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey47; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey47 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey470; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey470 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey471; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey471 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey472; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey472 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey473; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey473 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey474; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey474 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey475; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey475 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey476; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey476 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey477; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey477 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey478; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey478 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey479; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey479 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey48; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey48 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey480; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey480 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey481; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey481 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey482; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey482 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey483; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey483 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey484; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey484 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey485; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey485 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey486; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey486 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey487; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey487 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey488; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey488 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey489; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey489 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey49; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey49 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey490; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey490 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey491; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey491 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey492; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey492 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey493; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey493 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey494; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey494 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey495; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey495 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey496; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey496 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey497; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey497 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey498; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey498 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey499; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey499 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey5; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey5 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey50; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey50 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey500; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey500 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey501; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey501 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey502; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey502 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey503; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey503 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey504; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey504 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey505; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey505 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey506; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey506 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey507; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey507 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey508; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey508 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey509; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey509 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey51; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey51 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey510; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey510 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey511; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey511 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey512; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey512 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey513; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey513 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey514; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey514 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey515; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey515 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey516; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey516 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey517; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey517 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey518; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey518 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey519; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey519 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey52; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey52 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey520; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey520 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey521; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey521 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey522; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey522 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey523; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey523 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey524; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey524 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey525; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey525 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey526; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey526 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey527; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey527 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey528; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey528 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey529; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey529 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey53; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey53 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey530; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey530 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey531; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey531 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey532; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey532 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey533; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey533 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey534; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey534 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey535; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey535 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey536; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey536 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey537; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey537 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey538; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey538 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey539; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey539 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey54; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey54 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey540; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey540 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey541; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey541 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey542; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey542 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey543; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey543 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey544; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey544 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey545; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey545 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey546; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey546 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey547; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey547 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey548; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey548 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey549; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey549 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey55; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey55 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey550; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey550 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey551; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey551 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey552; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey552 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey553; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey553 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey554; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey554 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey555; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey555 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey556; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey556 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey557; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey557 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey558; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey558 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey559; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey559 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey56; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey56 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey57; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey57 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey58; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey58 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey59; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey59 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey6; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey6 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey60; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey60 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey61; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey61 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey62; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey62 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey63; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey63 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey64; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey64 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey65; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey65 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey66; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey66 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey67; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey67 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey68; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey68 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey69; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey69 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey7; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey7 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey70; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey70 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey71; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey71 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey72; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey72 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey73; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey73 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey74; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey74 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey75; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey75 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey76; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey76 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey77; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey77 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey78; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey78 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey79; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey79 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey8; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey8 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey80; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey80 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey81; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey81 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey82; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey82 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey83; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey83 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey84; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey84 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey85; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey85 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey86; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey86 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey87; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey87 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey88; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey88 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey89; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey89 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey9; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey9 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey90; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey90 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey91; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey91 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey92; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey92 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey93; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey93 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey94; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey94 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey95; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey95 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey96; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey96 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey97; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey97 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey98; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey98 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infoi_fkey99; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infoi_fkey99 FOREIGN KEY (infoi) REFERENCES public.info_ident(id_infoi);


--
-- Name: dossier dossier_infop_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey1 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey10; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey10 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey100; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey100 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey101; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey101 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey102; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey102 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey103; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey103 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey104; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey104 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey105; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey105 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey106; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey106 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey107; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey107 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey108; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey108 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey109; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey109 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey11; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey11 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey110; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey110 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey111; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey111 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey112; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey112 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey113; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey113 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey114; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey114 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey115; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey115 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey116; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey116 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey117; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey117 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey118; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey118 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey119; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey119 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey12; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey12 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey120; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey120 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey121; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey121 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey122; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey122 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey123; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey123 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey124; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey124 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey125; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey125 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey126; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey126 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey127; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey127 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey128; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey128 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey129; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey129 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey13; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey13 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey130; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey130 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey131; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey131 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey132; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey132 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey133; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey133 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey134; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey134 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey135; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey135 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey136; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey136 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey137; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey137 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey138; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey138 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey139; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey139 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey14; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey14 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey140; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey140 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey141; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey141 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey142; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey142 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey143; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey143 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey144; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey144 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey145; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey145 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey146; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey146 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey147; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey147 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey148; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey148 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey149; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey149 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey15; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey15 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey150; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey150 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey151; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey151 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey152; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey152 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey153; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey153 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey154; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey154 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey155; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey155 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey156; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey156 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey157; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey157 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey158; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey158 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey159; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey159 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey16; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey16 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey160; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey160 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey161; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey161 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey162; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey162 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey163; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey163 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey164; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey164 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey165; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey165 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey166; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey166 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey167; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey167 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey168; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey168 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey169; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey169 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey17; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey17 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey170; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey170 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey171; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey171 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey172; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey172 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey173; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey173 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey174; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey174 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey175; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey175 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey176; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey176 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey177; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey177 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey178; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey178 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey179; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey179 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey18; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey18 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey180; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey180 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey181; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey181 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey182; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey182 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey183; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey183 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey184; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey184 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey185; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey185 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey186; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey186 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey187; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey187 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey188; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey188 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey189; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey189 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey19; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey19 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey190; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey190 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey191; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey191 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey192; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey192 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey193; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey193 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey194; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey194 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey195; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey195 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey196; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey196 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey197; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey197 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey198; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey198 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey199; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey199 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey2 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey20; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey20 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey200; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey200 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey201; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey201 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey202; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey202 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey203; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey203 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey204; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey204 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey205; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey205 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey206; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey206 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey207; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey207 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey208; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey208 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey209; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey209 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey21; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey21 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey210; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey210 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey211; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey211 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey212; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey212 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey213; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey213 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey214; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey214 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey215; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey215 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey216; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey216 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey217; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey217 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey218; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey218 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey219; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey219 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey22; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey22 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey220; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey220 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey221; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey221 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey222; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey222 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey223; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey223 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey224; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey224 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey225; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey225 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey226; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey226 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey227; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey227 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey228; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey228 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey229; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey229 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey23; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey23 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey230; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey230 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey231; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey231 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey232; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey232 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey233; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey233 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey234; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey234 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey235; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey235 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey236; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey236 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey237; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey237 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey238; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey238 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey239; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey239 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey24; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey24 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey240; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey240 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey241; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey241 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey242; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey242 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey243; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey243 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey244; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey244 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey245; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey245 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey246; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey246 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey247; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey247 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey248; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey248 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey249; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey249 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey25; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey25 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey250; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey250 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey251; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey251 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey252; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey252 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey253; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey253 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey254; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey254 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey255; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey255 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey256; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey256 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey257; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey257 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey258; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey258 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey259; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey259 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey26; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey26 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey260; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey260 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey261; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey261 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey262; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey262 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey263; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey263 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey264; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey264 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey265; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey265 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey266; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey266 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey267; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey267 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey268; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey268 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey269; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey269 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey27; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey27 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey270; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey270 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey271; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey271 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey272; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey272 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey273; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey273 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey274; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey274 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey275; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey275 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey276; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey276 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey277; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey277 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey278; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey278 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey279; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey279 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey28; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey28 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey280; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey280 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey281; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey281 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey282; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey282 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey283; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey283 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey284; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey284 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey285; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey285 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey286; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey286 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey287; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey287 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey288; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey288 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey289; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey289 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey29; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey29 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey290; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey290 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey291; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey291 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey292; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey292 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey293; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey293 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey294; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey294 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey295; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey295 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey296; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey296 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey297; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey297 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey298; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey298 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey299; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey299 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey3 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey30; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey30 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey300; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey300 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey301; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey301 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey302; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey302 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey303; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey303 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey304; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey304 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey305; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey305 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey306; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey306 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey307; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey307 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey308; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey308 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey309; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey309 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey31; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey31 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey310; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey310 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey311; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey311 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey312; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey312 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey313; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey313 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey314; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey314 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey315; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey315 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey316; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey316 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey317; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey317 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey318; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey318 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey319; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey319 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey32; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey32 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey320; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey320 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey321; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey321 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey322; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey322 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey323; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey323 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey324; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey324 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey325; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey325 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey326; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey326 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey327; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey327 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey328; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey328 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey329; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey329 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey33; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey33 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey330; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey330 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey331; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey331 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey332; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey332 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey333; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey333 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey334; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey334 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey335; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey335 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey336; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey336 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey337; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey337 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey338; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey338 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey339; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey339 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey34; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey34 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey340; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey340 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey341; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey341 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey342; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey342 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey343; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey343 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey344; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey344 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey345; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey345 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey346; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey346 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey347; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey347 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey348; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey348 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey349; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey349 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey35; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey35 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey350; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey350 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey351; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey351 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey352; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey352 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey353; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey353 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey354; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey354 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey355; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey355 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey356; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey356 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey357; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey357 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey358; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey358 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey359; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey359 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey36; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey36 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey360; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey360 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey361; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey361 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey362; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey362 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey363; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey363 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey364; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey364 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey365; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey365 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey366; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey366 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey367; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey367 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey368; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey368 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey369; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey369 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey37; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey37 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey370; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey370 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey371; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey371 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey372; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey372 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey373; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey373 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey374; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey374 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey375; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey375 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey376; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey376 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey377; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey377 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey378; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey378 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey379; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey379 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey38; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey38 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey380; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey380 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey381; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey381 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey382; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey382 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey383; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey383 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey384; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey384 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey385; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey385 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey386; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey386 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey387; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey387 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey388; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey388 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey389; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey389 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey39; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey39 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey390; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey390 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey391; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey391 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey392; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey392 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey393; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey393 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey394; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey394 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey395; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey395 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey396; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey396 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey397; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey397 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey398; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey398 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey399; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey399 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey4 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey40; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey40 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey400; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey400 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey401; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey401 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey402; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey402 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey403; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey403 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey404; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey404 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey405; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey405 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey406; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey406 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey407; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey407 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey408; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey408 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey409; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey409 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey41; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey41 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey410; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey410 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey411; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey411 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey412; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey412 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey413; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey413 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey414; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey414 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey415; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey415 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey416; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey416 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey417; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey417 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey418; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey418 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey419; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey419 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey42; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey42 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey420; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey420 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey421; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey421 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey422; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey422 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey423; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey423 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey424; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey424 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey425; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey425 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey426; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey426 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey427; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey427 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey428; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey428 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey429; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey429 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey43; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey43 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey430; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey430 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey431; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey431 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey432; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey432 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey433; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey433 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey434; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey434 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey435; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey435 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey436; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey436 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey437; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey437 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey438; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey438 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey439; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey439 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey44; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey44 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey440; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey440 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey441; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey441 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey442; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey442 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey443; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey443 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey444; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey444 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey445; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey445 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey446; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey446 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey447; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey447 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey448; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey448 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey449; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey449 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey45; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey45 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey450; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey450 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey451; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey451 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey452; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey452 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey453; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey453 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey454; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey454 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey455; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey455 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey456; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey456 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey457; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey457 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey458; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey458 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey459; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey459 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey46; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey46 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey460; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey460 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey461; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey461 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey462; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey462 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey463; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey463 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey464; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey464 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey465; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey465 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey466; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey466 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey467; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey467 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey468; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey468 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey469; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey469 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey47; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey47 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey470; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey470 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey471; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey471 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey472; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey472 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey473; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey473 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey474; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey474 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey475; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey475 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey476; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey476 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey477; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey477 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey478; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey478 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey479; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey479 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey48; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey48 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey480; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey480 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey481; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey481 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey482; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey482 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey483; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey483 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey484; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey484 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey485; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey485 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey486; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey486 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey487; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey487 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey488; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey488 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey489; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey489 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey49; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey49 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey490; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey490 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey491; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey491 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey492; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey492 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey493; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey493 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey494; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey494 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey495; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey495 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey496; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey496 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey497; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey497 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey498; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey498 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey499; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey499 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey5; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey5 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey50; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey50 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey500; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey500 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey501; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey501 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey502; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey502 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey503; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey503 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey504; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey504 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey505; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey505 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey506; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey506 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey507; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey507 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey508; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey508 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey509; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey509 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey51; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey51 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey510; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey510 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey511; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey511 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey512; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey512 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey513; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey513 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey514; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey514 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey515; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey515 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey516; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey516 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey517; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey517 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey518; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey518 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey519; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey519 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey52; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey52 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey520; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey520 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey521; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey521 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey522; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey522 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey523; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey523 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey524; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey524 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey525; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey525 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey526; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey526 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey527; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey527 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey528; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey528 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey529; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey529 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey53; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey53 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey530; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey530 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey531; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey531 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey532; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey532 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey533; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey533 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey534; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey534 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey535; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey535 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey536; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey536 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey537; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey537 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey538; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey538 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey539; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey539 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey54; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey54 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey540; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey540 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey541; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey541 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey542; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey542 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey543; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey543 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey544; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey544 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey545; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey545 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey546; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey546 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey547; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey547 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey548; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey548 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey549; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey549 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey55; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey55 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey550; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey550 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey551; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey551 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey552; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey552 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey553; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey553 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey554; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey554 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey555; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey555 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey556; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey556 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey557; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey557 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey558; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey558 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey559; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey559 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey56; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey56 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey57; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey57 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey58; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey58 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey59; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey59 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey6; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey6 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey60; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey60 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey61; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey61 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey62; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey62 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey63; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey63 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey64; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey64 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey65; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey65 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey66; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey66 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey67; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey67 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey68; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey68 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey69; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey69 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey7; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey7 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey70; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey70 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey71; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey71 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey72; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey72 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey73; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey73 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey74; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey74 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey75; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey75 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey76; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey76 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey77; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey77 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey78; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey78 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey79; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey79 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey8; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey8 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey80; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey80 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey81; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey81 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey82; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey82 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey83; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey83 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey84; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey84 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey85; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey85 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey86; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey86 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey87; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey87 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey88; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey88 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey89; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey89 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey9; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey9 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey90; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey90 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey91; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey91 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey92; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey92 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey93; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey93 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey94; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey94 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey95; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey95 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey96; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey96 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey97; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey97 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey98; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey98 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_infop_fkey99; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_infop_fkey99 FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop);


--
-- Name: dossier dossier_matricule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.dossier
    ADD CONSTRAINT dossier_matricule_fkey FOREIGN KEY (matricule) REFERENCES public.utilisateur(matricule) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fichepresence fichepresence_matricule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.fichepresence
    ADD CONSTRAINT fichepresence_matricule_fkey FOREIGN KEY (matricule) REFERENCES public.dossier(matricule) ON UPDATE CASCADE;


--
-- Name: notifications notifications_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.utilisateur(id_user) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: poste_anterieur poste_anterieur_infop_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.poste_anterieur
    ADD CONSTRAINT poste_anterieur_infop_fkey FOREIGN KEY (infop) REFERENCES public.info_pro(id_infop) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sanction sanction_infoc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.sanction
    ADD CONSTRAINT sanction_infoc_fkey FOREIGN KEY (infoc) REFERENCES public.info_complementaire(id_infoc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_profiles user_profiles_matricule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mickaelyass
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_matricule_fkey FOREIGN KEY (matricule) REFERENCES public.utilisateur(matricule) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict qAVKtEL0Kn42UobdFTjqSxc6sxU8gZoBBKzIlnKwbp7zlGIpoUtszZi06jjNUhN

