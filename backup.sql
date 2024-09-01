--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.5 (Debian 14.5-1.pgdg110+1)

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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: web_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_customer (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    address text,
    contact character varying(20),
    customer_type_id bigint
);


ALTER TABLE public.web_customer OWNER TO postgres;

--
-- Name: web_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_customer_id_seq OWNER TO postgres;

--
-- Name: web_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_customer_id_seq OWNED BY public.web_customer.id;


--
-- Name: web_customertype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_customertype (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.web_customertype OWNER TO postgres;

--
-- Name: web_customertype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_customertype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_customertype_id_seq OWNER TO postgres;

--
-- Name: web_customertype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_customertype_id_seq OWNED BY public.web_customertype.id;


--
-- Name: web_ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_ingredient (
    id bigint NOT NULL,
    quantity double precision NOT NULL,
    ingredient_id bigint,
    recipe_id bigint NOT NULL,
    main_ingredient boolean NOT NULL,
    multiplied_by_main_ingredient boolean NOT NULL,
    multiplied_by_production boolean NOT NULL
);


ALTER TABLE public.web_ingredient OWNER TO postgres;

--
-- Name: web_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_ingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_ingredient_id_seq OWNER TO postgres;

--
-- Name: web_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_ingredient_id_seq OWNED BY public.web_ingredient.id;


--
-- Name: web_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_product (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    price double precision NOT NULL,
    recipe_id bigint
);


ALTER TABLE public.web_product OWNER TO postgres;

--
-- Name: web_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_product_id_seq OWNER TO postgres;

--
-- Name: web_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_product_id_seq OWNED BY public.web_product.id;


--
-- Name: web_production; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_production (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    product_id bigint,
    date date NOT NULL,
    CONSTRAINT web_production_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.web_production OWNER TO postgres;

--
-- Name: web_production_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_production_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_production_id_seq OWNER TO postgres;

--
-- Name: web_production_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_production_id_seq OWNED BY public.web_production.id;


--
-- Name: web_productioningredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_productioningredients (
    id bigint NOT NULL,
    quantity double precision NOT NULL,
    ingredient_id bigint,
    production_id bigint
);


ALTER TABLE public.web_productioningredients OWNER TO postgres;

--
-- Name: web_productioningredients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_productioningredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_productioningredients_id_seq OWNER TO postgres;

--
-- Name: web_productioningredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_productioningredients_id_seq OWNED BY public.web_productioningredients.id;


--
-- Name: web_purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_purchase (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    amount double precision NOT NULL,
    notes text,
    date date NOT NULL,
    supplier_id bigint
);


ALTER TABLE public.web_purchase OWNER TO postgres;

--
-- Name: web_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_purchase_id_seq OWNER TO postgres;

--
-- Name: web_purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_purchase_id_seq OWNED BY public.web_purchase.id;


--
-- Name: web_recipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_recipe (
    id bigint NOT NULL,
    quantity_produced double precision NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.web_recipe OWNER TO postgres;

--
-- Name: web_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_recipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_recipe_id_seq OWNER TO postgres;

--
-- Name: web_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_recipe_id_seq OWNED BY public.web_recipe.id;


--
-- Name: web_sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_sales (
    id bigint NOT NULL,
    sales_type character varying(255) NOT NULL,
    quantity integer NOT NULL,
    customer_id bigint,
    product_id bigint,
    actual_sale double precision,
    freebies integer,
    projected_sale double precision NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.web_sales OWNER TO postgres;

--
-- Name: web_sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_sales_id_seq OWNER TO postgres;

--
-- Name: web_sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_sales_id_seq OWNED BY public.web_sales.id;


--
-- Name: web_supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_supplier (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.web_supplier OWNER TO postgres;

--
-- Name: web_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_supplier_id_seq OWNER TO postgres;

--
-- Name: web_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_supplier_id_seq OWNED BY public.web_supplier.id;


--
-- Name: web_supply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_supply (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    supplied_at date NOT NULL,
    item_id bigint,
    purchase_order_id bigint
);


ALTER TABLE public.web_supply OWNER TO postgres;

--
-- Name: web_supply_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_supply_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_supply_id_seq OWNER TO postgres;

--
-- Name: web_supply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_supply_id_seq OWNED BY public.web_supply.id;


--
-- Name: web_supplyitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_supplyitem (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    price double precision NOT NULL,
    unit character varying(255) NOT NULL
);


ALTER TABLE public.web_supplyitem OWNER TO postgres;

--
-- Name: web_supplyitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_supplyitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_supplyitem_id_seq OWNER TO postgres;

--
-- Name: web_supplyitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_supplyitem_id_seq OWNED BY public.web_supplyitem.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: web_customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_customer ALTER COLUMN id SET DEFAULT nextval('public.web_customer_id_seq'::regclass);


--
-- Name: web_customertype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_customertype ALTER COLUMN id SET DEFAULT nextval('public.web_customertype_id_seq'::regclass);


--
-- Name: web_ingredient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_ingredient ALTER COLUMN id SET DEFAULT nextval('public.web_ingredient_id_seq'::regclass);


--
-- Name: web_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_product ALTER COLUMN id SET DEFAULT nextval('public.web_product_id_seq'::regclass);


--
-- Name: web_production id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_production ALTER COLUMN id SET DEFAULT nextval('public.web_production_id_seq'::regclass);


--
-- Name: web_productioningredients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_productioningredients ALTER COLUMN id SET DEFAULT nextval('public.web_productioningredients_id_seq'::regclass);


--
-- Name: web_purchase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_purchase ALTER COLUMN id SET DEFAULT nextval('public.web_purchase_id_seq'::regclass);


--
-- Name: web_recipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_recipe ALTER COLUMN id SET DEFAULT nextval('public.web_recipe_id_seq'::regclass);


--
-- Name: web_sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_sales ALTER COLUMN id SET DEFAULT nextval('public.web_sales_id_seq'::regclass);


--
-- Name: web_supplier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supplier ALTER COLUMN id SET DEFAULT nextval('public.web_supplier_id_seq'::regclass);


--
-- Name: web_supply id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supply ALTER COLUMN id SET DEFAULT nextval('public.web_supply_id_seq'::regclass);


--
-- Name: web_supplyitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supplyitem ALTER COLUMN id SET DEFAULT nextval('public.web_supplyitem_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add customer type	7	add_customertype
26	Can change customer type	7	change_customertype
27	Can delete customer type	7	delete_customertype
28	Can view customer type	7	view_customertype
29	Can add customer	8	add_customer
30	Can change customer	8	change_customer
31	Can delete customer	8	delete_customer
32	Can view customer	8	view_customer
33	Can add product	9	add_product
34	Can change product	9	change_product
35	Can delete product	9	delete_product
36	Can view product	9	view_product
37	Can add supply item	10	add_supplyitem
38	Can change supply item	10	change_supplyitem
39	Can delete supply item	10	delete_supplyitem
40	Can view supply item	10	view_supplyitem
41	Can add supply	11	add_supply
42	Can change supply	11	change_supply
43	Can delete supply	11	delete_supply
44	Can view supply	11	view_supply
45	Can add recipe	12	add_recipe
46	Can change recipe	12	change_recipe
47	Can delete recipe	12	delete_recipe
48	Can view recipe	12	view_recipe
49	Can add production	13	add_production
50	Can change production	13	change_production
51	Can delete production	13	delete_production
52	Can view production	13	view_production
53	Can add sales	14	add_sales
54	Can change sales	14	change_sales
55	Can delete sales	14	delete_sales
56	Can view sales	14	view_sales
57	Can add production ingredients	15	add_productioningredients
58	Can change production ingredients	15	change_productioningredients
59	Can delete production ingredients	15	delete_productioningredients
60	Can view production ingredients	15	view_productioningredients
61	Can add ingredient	16	add_ingredient
62	Can change ingredient	16	change_ingredient
63	Can delete ingredient	16	delete_ingredient
64	Can view ingredient	16	view_ingredient
65	Can add purchase	17	add_purchase
66	Can change purchase	17	change_purchase
67	Can delete purchase	17	delete_purchase
68	Can view purchase	17	view_purchase
69	Can add supplier	18	add_supplier
70	Can change supplier	18	change_supplier
71	Can delete supplier	18	delete_supplier
72	Can view supplier	18	view_supplier
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$260000$Qq6sZe90Y5WnppO5dSaQBB$+VmtWzFo9Z6EFzQ07DF9bIP7Y4MAuCiM7mcOe8rw9xM=	2022-10-31 15:22:46.839491+00	t	root				t	t	2022-10-31 15:09:00.644565+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-10-31 16:16:12.149066+00	1	CustomerType object (1)	1	[{"added": {}}]	7	1
2	2022-10-31 16:16:14.807055+00	2	CustomerType object (2)	1	[{"added": {}}]	7	1
3	2022-10-31 16:16:20.155293+00	3	CustomerType object (3)	1	[{"added": {}}]	7	1
4	2022-10-31 16:16:56.407909+00	1	Product object (1)	1	[{"added": {}}]	9	1
5	2022-10-31 16:17:15.495734+00	2	Product object (2)	1	[{"added": {}}]	9	1
6	2022-10-31 16:19:28.103055+00	1	SupplyItem object (1)	1	[{"added": {}}]	10	1
7	2022-10-31 16:20:08.027652+00	2	SupplyItem object (2)	1	[{"added": {}}]	10	1
8	2022-10-31 16:20:17.092867+00	3	SupplyItem object (3)	1	[{"added": {}}]	10	1
9	2022-10-31 16:20:47.966182+00	4	SupplyItem object (4)	1	[{"added": {}}]	10	1
10	2022-10-31 16:21:24.27091+00	3	MSG	2	[{"changed": {"fields": ["Price"]}}]	10	1
11	2022-10-31 16:23:51.169498+00	5	Plastic Wrap (S)	1	[{"added": {}}]	10	1
12	2022-10-31 16:24:03.712292+00	6	Plastic Wrap (L)	1	[{"added": {}}]	10	1
13	2022-10-31 16:24:22.223126+00	1	Recipe object (1)	1	[{"added": {}}]	12	1
14	2022-10-31 16:25:16.134267+00	2	Recipe object (2)	1	[{"added": {}}]	12	1
15	2022-10-31 16:25:29.823276+00	3	Recipe object (3)	1	[{"added": {}}]	12	1
16	2022-10-31 16:25:42.899018+00	4	Recipe object (4)	1	[{"added": {}}]	12	1
17	2022-10-31 16:26:09.625447+00	5	Recipe object (5)	1	[{"added": {}}]	12	1
18	2022-10-31 16:27:25.983918+00	1	Supply object (1)	1	[{"added": {}}]	11	1
19	2022-10-31 16:27:42.676784+00	2	Supply object (2)	1	[{"added": {}}]	11	1
20	2022-10-31 16:27:50.468181+00	3	Supply object (3)	1	[{"added": {}}]	11	1
21	2022-10-31 16:28:00.431003+00	4	Supply object (4)	1	[{"added": {}}]	11	1
22	2022-10-31 16:28:07.543532+00	5	Supply object (5)	1	[{"added": {}}]	11	1
23	2022-10-31 16:28:17.771144+00	6	Supply object (6)	1	[{"added": {}}]	11	1
24	2022-11-01 09:53:16.210742+00	5	test	3		12	1
25	2022-11-01 09:53:16.220423+00	4	test	3		12	1
26	2022-11-01 09:53:16.222907+00	3	test	3		12	1
27	2022-11-01 09:53:16.229371+00	2	test	3		12	1
28	2022-11-01 09:53:16.231874+00	1	test	3		12	1
29	2022-11-01 09:54:59.665403+00	6	80G Recipe	1	[{"added": {}}, {"added": {"name": "ingredient", "object": "Ingredient object (1)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (2)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (3)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (4)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (5)"}}]	12	1
30	2022-11-01 09:55:13.18591+00	1	AMOREN_MIX_80G	2	[{"changed": {"fields": ["Recipe"]}}]	9	1
31	2022-11-01 09:56:12.098736+00	7	200G Recipe	1	[{"added": {}}, {"added": {"name": "ingredient", "object": "Ingredient object (6)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (7)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (8)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (9)"}}, {"added": {"name": "ingredient", "object": "Ingredient object (10)"}}]	12	1
32	2022-11-01 09:56:16.42631+00	2	AMOREN_MIX_200G	2	[{"changed": {"fields": ["Recipe"]}}]	9	1
33	2022-11-01 11:36:44.708278+00	2	Production object (2)	3		13	1
34	2022-11-01 11:39:35.418083+00	3	Production object (3)	3		13	1
35	2022-11-01 11:40:56.890361+00	4	Production object (4)	3		13	1
36	2022-11-01 11:47:06.699861+00	5	Production object (5)	3		13	1
37	2022-11-01 11:47:51.074395+00	6	Production object (6)	3		13	1
38	2022-11-01 12:06:46.113018+00	7	Production object (7)	3		13	1
39	2022-11-01 12:15:29.092052+00	9	Production object (9)	1	[{"added": {}}]	13	1
40	2022-11-01 12:43:18.607624+00	1	80G Recipe - Flour Sack	2	[{"changed": {"fields": ["Main ingredient", "Multiplied by main ingredient"]}}]	16	1
41	2022-11-01 12:43:35.234413+00	6	200G Recipe - Flour Sack	2	[{"changed": {"fields": ["Main ingredient", "Multiplied by main ingredient"]}}]	16	1
42	2022-11-01 12:43:41.625058+00	5	80G Recipe - Plastic Wrap (S)	2	[{"changed": {"fields": ["Multiplied by main ingredient", "Multiplied by production"]}}]	16	1
43	2022-11-01 12:43:46.974347+00	10	200G Recipe - Plastic Wrap (L)	2	[{"changed": {"fields": ["Multiplied by main ingredient", "Multiplied by production"]}}]	16	1
44	2022-11-01 13:19:30.269116+00	9	Production object (9)	3		13	1
45	2022-11-01 13:19:30.280339+00	8	Production object (8)	3		13	1
46	2022-11-01 13:19:30.289402+00	1	Production object (1)	3		13	1
47	2022-11-01 13:24:24.47036+00	10	Production object (10)	3		13	1
48	2022-11-01 16:46:25.370059+00	1	Customer object (1)	1	[{"added": {}}]	8	1
49	2022-11-01 19:51:04.349873+00	2	Test 2	1	[{"added": {}}]	8	1
50	2022-11-02 04:14:11.309854+00	4	Sales object (4)	3		14	1
51	2022-11-02 04:14:11.315564+00	3	Sales object (3)	3		14	1
52	2022-11-02 04:14:11.31824+00	2	Sales object (2)	3		14	1
53	2022-11-02 04:14:11.321151+00	1	Sales object (1)	3		14	1
54	2022-11-02 04:14:29.45414+00	14	Production object (14)	3		13	1
55	2022-11-02 04:14:29.459332+00	13	Production object (13)	3		13	1
56	2022-11-02 04:14:29.462465+00	12	Production object (12)	3		13	1
57	2022-11-02 04:14:29.465162+00	11	Production object (11)	3		13	1
58	2022-11-02 04:14:43.510698+00	2	Test 2	3		8	1
59	2022-11-02 04:14:43.516437+00	1	Test  1	3		8	1
60	2022-11-02 04:16:16.958758+00	11	Supply object (11)	3		11	1
61	2022-11-02 04:16:16.964162+00	10	Supply object (10)	3		11	1
62	2022-11-02 04:16:16.967167+00	9	Supply object (9)	3		11	1
63	2022-11-02 04:16:16.970182+00	8	Supply object (8)	3		11	1
64	2022-11-02 04:16:16.973675+00	7	Supply object (7)	3		11	1
65	2022-11-02 04:16:16.97645+00	6	Supply object (6)	3		11	1
66	2022-11-02 04:16:16.979651+00	5	Supply object (5)	3		11	1
67	2022-11-02 04:16:16.982424+00	4	Supply object (4)	3		11	1
68	2022-11-02 04:16:16.985247+00	3	Supply object (3)	3		11	1
69	2022-11-02 04:16:16.988344+00	2	Supply object (2)	3		11	1
70	2022-11-02 04:16:16.9915+00	1	Supply object (1)	3		11	1
71	2022-11-02 04:18:56.493261+00	3	CustomerType object (3)	3		7	1
72	2022-11-02 04:18:56.498905+00	2	CustomerType object (2)	3		7	1
73	2022-11-02 04:18:56.502465+00	1	CustomerType object (1)	3		7	1
74	2022-11-02 04:19:27.818807+00	4	MALL	1	[{"added": {}}]	7	1
75	2022-11-02 04:19:31.716445+00	5	MARKET	1	[{"added": {}}]	7	1
76	2022-11-02 04:19:41.178385+00	6	WALK-IN	1	[{"added": {}}]	7	1
77	2022-11-02 04:21:29.018083+00	3	Gaisano Mall	1	[{"added": {}}]	8	1
78	2022-11-02 04:21:40.969858+00	4	Grand	1	[{"added": {}}]	8	1
79	2022-11-02 04:21:48.678929+00	5	NCCC Tagum	1	[{"added": {}}]	8	1
80	2022-11-02 04:22:02.738201+00	6	Lots For Less	1	[{"added": {}}]	8	1
81	2022-11-02 04:22:12.526511+00	7	JGH Tagum	1	[{"added": {}}]	8	1
82	2022-11-02 04:22:22.005656+00	8	Franco	1	[{"added": {}}]	8	1
83	2022-11-02 04:42:06.717476+00	7	Hyco	1	[{"added": {}}]	10	1
84	2022-11-02 04:43:28.518375+00	8	Sugar	1	[{"added": {}}]	10	1
85	2022-11-02 04:44:07.802939+00	9	Plastic Wrap (BBQ)	1	[{"added": {}}]	10	1
86	2022-11-02 04:44:16.469626+00	8	BBQ Recipe	1	[{"added": {}}, {"added": {"name": "ingredient", "object": "BBQ Recipe - Hyco"}}, {"added": {"name": "ingredient", "object": "BBQ Recipe - Pepper"}}, {"added": {"name": "ingredient", "object": "BBQ Recipe - Iodized Salt"}}, {"added": {"name": "ingredient", "object": "BBQ Recipe - MSG"}}, {"added": {"name": "ingredient", "object": "BBQ Recipe - Sugar"}}, {"added": {"name": "ingredient", "object": "BBQ Recipe - Plastic Wrap (BBQ)"}}]	12	1
87	2022-11-02 04:44:31.913392+00	8	BBQ Recipe	2	[{"changed": {"name": "ingredient", "object": "BBQ Recipe - Plastic Wrap (BBQ)", "fields": ["Multiplied by main ingredient", "Multiplied by production"]}}]	12	1
88	2022-11-02 04:44:36.189219+00	3	AMORENS_BBQ_MIX	1	[{"added": {}}]	9	1
89	2022-11-02 04:46:36.372531+00	15	Amoren's Crispy Mix 80G + 8707 + 2022-09-01	2	[{"changed": {"fields": ["Date"]}}]	13	1
90	2022-11-02 04:50:14.144954+00	10	Garlic Powder	1	[{"added": {}}]	10	1
91	2022-11-02 04:51:47.641105+00	9	Garlic Recipe	1	[{"added": {}}, {"added": {"name": "ingredient", "object": "Garlic Recipe - Garlic Powder"}}, {"added": {"name": "ingredient", "object": "Garlic Recipe - Flour Sack"}}, {"added": {"name": "ingredient", "object": "Garlic Recipe - Iodized Salt"}}, {"added": {"name": "ingredient", "object": "Garlic Recipe - MSG"}}, {"added": {"name": "ingredient", "object": "Garlic Recipe - Pepper"}}, {"added": {"name": "ingredient", "object": "Garlic Recipe - Plastic Wrap (S)"}}]	12	1
92	2022-11-02 04:52:24.263433+00	4	AMORENS_GARLIC_MIX	1	[{"added": {}}]	9	1
93	2022-11-02 05:21:14.498651+00	9	PANACAN / TIBUNGCO	1	[{"added": {}}]	8	1
94	2022-11-02 05:21:26.052019+00	10	CARMEN / KAPALONG/ ASUNCION	1	[{"added": {}}]	8	1
95	2022-11-02 05:21:53.331765+00	11	DIGOS / STA CRUZ	1	[{"added": {}}]	8	1
96	2022-11-02 05:22:09.267289+00	7	MUSIC STORE	1	[{"added": {}}]	7	1
97	2022-11-02 05:22:18.044501+00	12	AMIGO	1	[{"added": {}}]	8	1
98	2022-11-02 05:22:24.313831+00	13	LKY	1	[{"added": {}}]	8	1
99	2022-11-02 08:16:09.91538+00	25	sold Amoren's Crispy Mix 200G x 0 to JGH Tagum at 2022-11-02	3		14	1
100	2022-11-02 08:16:09.920748+00	24	sold Amoren's Crispy Mix 200G x 1450 to Lots For Less at 2022-11-02	3		14	1
101	2022-11-02 08:16:09.923613+00	23	sold Amoren's Crispy Mix 200G x 350 to NCCC Tagum at 2022-11-02	3		14	1
102	2022-11-02 08:16:09.926388+00	22	sold Amoren's Crispy Mix 200G x 850 to Grand at 2022-11-02	3		14	1
103	2022-11-02 08:16:09.929395+00	21	sold Amoren's Crispy Mix 200G x 1450 to Gaisano Mall at 2022-11-02	3		14	1
104	2022-11-02 08:25:34.698435+00	14	GAGA	1	[{"added": {}}]	8	1
105	2022-11-02 08:29:39.847914+00	15	TAGUM	1	[{"added": {}}]	8	1
106	2022-11-02 08:29:47.074734+00	16	DOWNTOWN	1	[{"added": {}}]	8	1
107	2022-11-02 08:29:51.916144+00	17	DIGOS	1	[{"added": {}}]	8	1
108	2022-11-02 08:30:29.455419+00	18	TAGTAG (GENERAL)	1	[{"added": {}}]	8	1
109	2022-11-02 08:34:59.363232+00	19	GCENTER DIGOS	1	[{"added": {}}]	8	1
110	2022-11-02 08:35:10.280077+00	20	GAISANO GRAND DIGOS	1	[{"added": {}}]	8	1
111	2022-11-02 08:35:20.148529+00	21	GMALL DIGOS	1	[{"added": {}}]	8	1
112	2022-11-02 08:36:07.094986+00	22	GAISANO GRAND KIDAPAWAN	1	[{"added": {}}]	8	1
113	2022-11-02 08:36:29.274087+00	23	GAISANO GRAND TAGUM	1	[{"added": {}}]	8	1
114	2022-11-02 08:36:36.492553+00	24	GMALL TAGUM	1	[{"added": {}}]	8	1
115	2022-11-02 08:36:48.30451+00	25	NCCC TAGUM	1	[{"added": {}}]	8	1
116	2022-11-02 08:36:58.043802+00	26	GCENTER TAGUM	1	[{"added": {}}]	8	1
117	2022-11-02 08:37:05.445485+00	27	GAISANO GRAND PANABO	1	[{"added": {}}]	8	1
118	2022-11-02 08:37:46.061741+00	3	GMALL BAJADA	2	[{"changed": {"fields": ["Name"]}}]	8	1
119	2022-11-02 08:38:04.678272+00	28	GAISANO ILUSTRE	1	[{"added": {}}]	8	1
120	2022-11-02 08:38:14.393055+00	29	GMALL TORIL	1	[{"added": {}}]	8	1
121	2022-11-02 08:38:25.253258+00	30	GAISANO GRAND TORIL	1	[{"added": {}}]	8	1
122	2022-11-02 08:38:51.153562+00	31	GAISANO GRAND TIBUNGCO	1	[{"added": {}}]	8	1
123	2022-11-02 08:38:58.671083+00	32	PUAN	1	[{"added": {}}]	8	1
124	2022-11-02 08:39:06.589484+00	33	MATINA	1	[{"added": {}}]	8	1
125	2022-11-02 09:18:37.539098+00	59	Amoren's Crispy Mix 80G + 681 + 2022-10-28	2	[{"changed": {"fields": ["Product"]}}]	13	1
126	2022-11-02 09:20:15.868772+00	305	59 - Plastic Wrap (L) - 681.0	3		15	1
127	2022-11-02 09:20:15.873885+00	304	59 - MSG - 4.0	3		15	1
128	2022-11-02 09:20:15.876458+00	303	59 - Pepper - 1.5	3		15	1
129	2022-11-02 09:20:15.878954+00	302	59 - Iodized Salt - 6.5	3		15	1
130	2022-11-02 09:20:15.881543+00	301	59 - Flour Sack - 2.0	3		15	1
131	2022-11-02 09:20:28.904053+00	59	Amoren's Crispy Mix 80G + 681 + 2022-10-28	3		13	1
132	2022-11-02 09:29:35.017693+00	34	DSTA	1	[{"added": {}}]	8	1
133	2022-11-02 09:29:40.458811+00	35	NANCY	1	[{"added": {}}]	8	1
134	2022-11-02 09:35:07.003203+00	235	sold Amoren's Crispy Mix 80G x 0 to NANCY at 2022-10-03	3		14	1
135	2022-11-02 09:35:07.008596+00	234	sold Amoren's Crispy Mix 80G x 0 to DSTA at 2022-10-03	3		14	1
136	2022-11-02 09:35:07.011912+00	233	sold Amoren's Crispy Mix 80G x 1368 to DIGOS / STA CRUZ at 2022-10-03	3		14	1
137	2022-11-02 09:35:07.014575+00	232	sold Amoren's Crispy Mix 80G x 228 to CARMEN / KAPALONG/ ASUNCION at 2022-10-03	3		14	1
138	2022-11-02 09:35:07.017336+00	231	sold Amoren's Crispy Mix 80G x 0 to PANACAN / TIBUNGCO at 2022-10-03	3		14	1
139	2022-11-02 09:35:07.019906+00	230	sold Amoren's Crispy Mix 80G x 0 to JGH Tagum at 2022-10-03	3		14	1
140	2022-11-02 09:35:07.022541+00	229	sold Amoren's Crispy Mix 80G x 0 to Lots For Less at 2022-10-03	3		14	1
141	2022-11-02 09:35:07.025531+00	228	sold Amoren's Crispy Mix 80G x 0 to NCCC Tagum at 2022-10-03	3		14	1
142	2022-11-02 09:35:07.028402+00	227	sold Amoren's Crispy Mix 80G x 0 to Grand at 2022-10-03	3		14	1
143	2022-11-02 09:35:07.030838+00	226	sold Amoren's Crispy Mix 80G x 0 to GMALL BAJADA at 2022-10-03	3		14	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	web	customertype
8	web	customer
9	web	product
10	web	supplyitem
11	web	supply
12	web	recipe
13	web	production
14	web	sales
15	web	productioningredients
16	web	ingredient
17	web	purchase
18	web	supplier
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-10-31 15:02:51.414586+00
2	auth	0001_initial	2022-10-31 15:02:51.525053+00
3	admin	0001_initial	2022-10-31 15:02:51.552156+00
4	admin	0002_logentry_remove_auto_add	2022-10-31 15:02:51.561535+00
5	admin	0003_logentry_add_action_flag_choices	2022-10-31 15:02:51.570704+00
6	contenttypes	0002_remove_content_type_name	2022-10-31 15:02:51.596227+00
7	auth	0002_alter_permission_name_max_length	2022-10-31 15:02:51.606457+00
8	auth	0003_alter_user_email_max_length	2022-10-31 15:02:51.617285+00
9	auth	0004_alter_user_username_opts	2022-10-31 15:02:51.626395+00
10	auth	0005_alter_user_last_login_null	2022-10-31 15:02:51.63679+00
11	auth	0006_require_contenttypes_0002	2022-10-31 15:02:51.6405+00
12	auth	0007_alter_validators_add_error_messages	2022-10-31 15:02:51.650184+00
13	auth	0008_alter_user_username_max_length	2022-10-31 15:02:51.665329+00
14	auth	0009_alter_user_last_name_max_length	2022-10-31 15:02:51.676501+00
15	auth	0010_alter_group_name_max_length	2022-10-31 15:02:51.687808+00
16	auth	0011_update_proxy_permissions	2022-10-31 15:02:51.699904+00
17	auth	0012_alter_user_first_name_max_length	2022-10-31 15:02:51.709201+00
18	sessions	0001_initial	2022-10-31 15:02:51.732189+00
19	web	0001_initial	2022-10-31 15:04:51.321792+00
20	web	0002_alter_recipe_quantity	2022-10-31 16:25:13.438506+00
21	web	0003_auto_20221101_0633	2022-11-01 06:33:21.280841+00
22	web	0004_auto_20221101_0928	2022-11-01 09:28:42.590211+00
23	web	0005_recipe_name	2022-11-01 09:53:08.059994+00
24	web	0006_alter_ingredient_recipe	2022-11-01 10:01:49.470517+00
25	web	0007_auto_20221101_1238	2022-11-01 12:38:41.893046+00
26	web	0008_ingredient_multiplied_by_production	2022-11-01 12:42:11.816578+00
27	web	0009_auto_20221101_1728	2022-11-01 17:34:04.339545+00
28	web	0010_sales_date	2022-11-01 18:02:53.590993+00
29	web	0011_alter_supply_supplied_at	2022-11-01 18:15:59.034483+00
30	web	0012_auto_20221102_0421	2022-11-02 04:21:16.290754+00
31	web	0013_auto_20221102_0512	2022-11-02 05:12:43.493333+00
32	web	0014_alter_productioningredients_production	2022-11-02 09:20:49.738673+00
33	web	0015_auto_20221102_1128	2022-11-02 11:28:10.107698+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
rc6f5hs70fp6ey3cxzoy158sjyba4ruf	.eJxVjEEOwiAQRe_C2pAOWGbq0n3PQGAYpGpoUtqV8e7apAvd_vfefykftrX4rcnip6QuCtTpd4uBH1J3kO6h3mbNc12XKepd0QdtepyTPK-H-3dQQivfOgZrkBK4JAwZIrNFYzqX0AQwQ2-ZXe4GJGRrxTiMWYiAIFKfz8Lq_QHkEDfX:1opWcg:R1StNP9TEmU0grvJ2fb7rm4ea8_B7TRKapDOIt7onT8	2022-11-14 15:22:46.842492+00
\.


--
-- Data for Name: web_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_customer (id, name, address, contact, customer_type_id) FROM stdin;
4	Grand		\N	4
5	NCCC Tagum		\N	4
6	Lots For Less		\N	4
7	JGH Tagum		\N	4
8	Franco		\N	6
9	PANACAN / TIBUNGCO		\N	5
10	CARMEN / KAPALONG/ ASUNCION		\N	5
11	DIGOS / STA CRUZ		\N	5
12	AMIGO		\N	7
13	LKY		\N	7
14	GAGA		\N	6
15	TAGUM		\N	5
16	DOWNTOWN		\N	5
17	DIGOS		\N	5
18	TAGTAG (GENERAL)		\N	5
19	GCENTER DIGOS		\N	4
20	GAISANO GRAND DIGOS		\N	4
21	GMALL DIGOS		\N	4
22	GAISANO GRAND KIDAPAWAN		\N	4
23	GAISANO GRAND TAGUM		\N	4
24	GMALL TAGUM		\N	4
25	NCCC TAGUM		\N	4
26	GCENTER TAGUM		\N	4
27	GAISANO GRAND PANABO		\N	4
3	GMALL BAJADA		\N	4
28	GAISANO ILUSTRE		\N	4
29	GMALL TORIL		\N	4
30	GAISANO GRAND TORIL		\N	4
31	GAISANO GRAND TIBUNGCO		\N	4
32	PUAN		\N	5
33	MATINA		\N	5
34	DSTA		\N	5
35	NANCY		\N	6
\.


--
-- Data for Name: web_customertype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_customertype (id, name) FROM stdin;
4	MALL
5	MARKET
6	WALK-IN
7	MUSIC STORE
\.


--
-- Data for Name: web_ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_ingredient (id, quantity, ingredient_id, recipe_id, main_ingredient, multiplied_by_main_ingredient, multiplied_by_production) FROM stdin;
2	3.25	2	6	f	t	f
3	0.75	4	6	f	t	f
4	2	3	6	f	t	f
7	3.25	2	7	f	t	f
8	0.75	4	7	f	t	f
9	2	3	7	f	t	f
1	1	1	6	t	f	f
6	1	1	7	t	f	f
5	380	5	6	f	f	t
10	156	6	7	f	f	t
11	1	7	8	t	f	f
12	0.5	4	8	f	t	f
13	3	2	8	f	t	f
14	0.5	3	8	f	t	f
15	12	8	8	f	t	f
16	300	9	8	f	f	t
17	2	10	9	f	t	f
18	1	1	9	t	f	f
19	3.25	2	9	f	t	f
20	2	3	9	f	t	f
21	0.75	4	9	f	t	f
22	420	5	9	f	f	t
\.


--
-- Data for Name: web_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_product (id, name, code, price, recipe_id) FROM stdin;
1	Amoren's Crispy Mix 80G	AMOREN_MIX_80G	11.25	6
2	Amoren's Crispy Mix 200G	AMOREN_MIX_200G	22.25	7
3	Amoren's BBQ Mix	AMORENS_BBQ_MIX	12.5	8
4	Amoren's Garlic Mix	AMORENS_GARLIC_MIX	12	9
\.


--
-- Data for Name: web_production; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_production (id, quantity, product_id, date) FROM stdin;
16	4194	2	2022-09-01
17	11166	1	2022-09-05
18	5490	2	2022-09-05
15	8707	1	2022-09-01
19	6084	3	2022-09-05
20	9700	1	2022-09-12
21	7345	2	2022-09-12
22	3729	3	2022-09-12
23	841	4	2022-09-12
24	12157	1	2022-09-19
25	7182	2	2022-09-19
26	1758	3	2022-09-19
27	206	4	2022-09-19
28	6568	1	2022-09-26
29	3741	2	2022-09-26
30	1630	3	2022-09-26
31	426	4	2022-09-26
32	1148	1	2022-10-15
33	927	2	2022-10-15
34	398	4	2022-10-15
35	1207	3	2022-10-16
36	1755	2	2022-10-17
37	1594	1	2022-10-17
38	1140	1	2022-10-18
39	1152	2	2022-10-18
40	1659	3	2022-10-18
41	1928	1	2022-10-19
42	719	2	2022-10-19
43	1589	3	2022-10-19
44	944	3	2022-10-20
45	1575	1	2022-10-20
46	1169	2	2022-10-20
47	1513	1	2022-10-21
48	1661	2	2022-10-21
49	1525	1	2022-10-22
50	640	2	2022-10-22
51	1987	2	2022-10-24
52	385	1	2022-10-24
53	424	4	2022-10-24
54	2331	2	2022-10-25
55	2132	2	2022-10-26
56	839	4	2022-10-27
57	2518	2	2022-10-27
58	516	3	2022-10-27
60	681	1	2022-10-28
61	1182	2	2022-10-28
\.


--
-- Data for Name: web_productioningredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_productioningredients (id, quantity, ingredient_id, production_id) FROM stdin;
6	8	\N	\N
7	1	\N	\N
8	1	\N	\N
9	1	\N	\N
10	1	\N	\N
11	8	\N	\N
12	1	\N	\N
13	1	\N	\N
14	1	\N	\N
15	1	\N	\N
16	8	\N	\N
17	1	\N	\N
18	1	\N	\N
19	1	\N	\N
20	1	\N	\N
21	8	1	\N
22	1	2	\N
23	1	4	\N
24	1	3	\N
25	1	6	\N
26	8	1	\N
27	1	2	\N
28	1	4	\N
29	1	3	\N
30	1	6	\N
31	8	1	\N
32	1	2	\N
33	1	4	\N
34	1	3	\N
35	1	6	\N
1	123	1	\N
2	123	2	\N
3	123	3	\N
4	123	4	\N
5	123	5	\N
36	8	1	\N
37	1	2	\N
38	1	4	\N
39	1	3	\N
40	1	6	\N
41	4	1	\N
42	13	2	\N
43	3	4	\N
44	8	3	\N
45	1000	5	\N
46	123123	1	\N
47	400149.75	2	\N
48	92342.25	4	\N
49	246246	3	\N
50	123123	5	\N
51	25	1	\N
52	81.25	2	\N
53	18.75	4	\N
54	50	3	\N
55	7000	6	\N
56	4	1	\N
57	13	2	\N
58	3	4	\N
59	8	3	\N
60	1000	5	\N
61	4	1	\N
62	13	2	\N
63	3	4	\N
64	8	3	\N
65	850	6	\N
66	23	1	15
67	74.75	2	15
68	17.25	4	15
69	46	3	15
70	8707	5	15
71	27	1	16
72	87.75	2	16
73	20.25	4	16
74	54	3	16
75	4194	6	16
76	27	1	17
77	87.75	2	17
78	20.25	4	17
79	54	3	17
80	11166	5	17
81	33	1	18
82	107.25	2	18
83	24.75	4	18
84	66	3	18
85	5490	6	18
86	18	7	19
87	9	4	19
88	54	2	19
89	9	3	19
90	216	8	19
91	6084	9	19
92	25	1	20
93	81.25	2	20
94	18.75	4	20
95	50	3	20
96	9700	5	20
97	45	1	21
98	146.25	2	21
99	33.75	4	21
100	90	3	21
101	7345	6	21
102	11	7	22
103	5.5	4	22
104	33	2	22
105	5.5	3	22
106	132	8	22
107	3729	9	22
108	4	10	23
109	2	1	23
110	6.5	2	23
111	4	3	23
112	1.5	4	23
113	841	5	23
114	32.5	1	24
115	105.625	2	24
116	24.375	4	24
117	65	3	24
118	12157	5	24
119	44	1	25
120	143	2	25
121	33	4	25
122	88	3	25
123	7182	6	25
124	7	7	26
125	3.5	4	26
126	21	2	26
127	3.5	3	26
128	84	8	26
129	1758	9	26
130	1	10	27
131	0.5	1	27
132	1.625	2	27
133	1	3	27
134	0.375	4	27
135	206	5	27
136	20	1	28
137	65	2	28
138	15	4	28
139	40	3	28
140	6568	5	28
141	26	1	29
142	84.5	2	29
143	19.5	4	29
144	52	3	29
145	3741	6	29
146	11	7	30
147	5.5	4	30
148	33	2	30
149	5.5	3	30
150	132	8	30
151	1630	9	30
152	2	10	31
153	1	1	31
154	3.25	2	31
155	2	3	31
156	0.75	4	31
157	426	5	31
158	3	1	32
159	9.75	2	32
160	2.25	4	32
161	6	3	32
162	1148	5	32
163	6	1	33
164	19.5	2	33
165	4.5	4	33
166	12	3	33
167	927	6	33
168	2	10	34
169	1	1	34
170	3.25	2	34
171	2	3	34
172	0.75	4	34
173	398	5	34
174	4	7	35
175	2	4	35
176	12	2	35
177	2	3	35
178	48	8	35
179	1207	9	35
180	11	1	36
181	35.75	2	36
182	8.25	4	36
183	22	3	36
184	1755	6	36
185	4	1	37
186	13	2	37
187	3	4	37
188	8	3	37
189	1594	5	37
190	3	1	38
191	9.75	2	38
192	2.25	4	38
193	6	3	38
194	1140	5	38
195	7	1	39
196	22.75	2	39
197	5.25	4	39
198	14	3	39
199	1152	6	39
200	5	7	40
201	2.5	4	40
202	15	2	40
203	2.5	3	40
204	60	8	40
205	1659	9	40
206	5	1	41
207	16.25	2	41
208	3.75	4	41
209	10	3	41
210	1928	5	41
211	4	1	42
212	13	2	42
213	3	4	42
214	8	3	42
215	719	6	42
216	5	7	43
217	2.5	4	43
218	15	2	43
219	2.5	3	43
220	60	8	43
221	1589	9	43
222	3	7	44
223	1.5	4	44
224	9	2	44
225	1.5	3	44
226	36	8	44
227	944	9	44
228	4	1	45
229	13	2	45
230	3	4	45
231	8	3	45
232	1575	5	45
233	7	1	46
234	22.75	2	46
235	5.25	4	46
236	14	3	46
237	1169	6	46
238	4	1	47
239	13	2	47
240	3	4	47
241	8	3	47
242	1513	5	47
243	10	1	48
244	32.5	2	48
245	7.5	4	48
246	20	3	48
247	1661	6	48
248	4	1	49
249	13	2	49
250	3	4	49
251	8	3	49
252	1525	5	49
253	4	1	50
254	13	2	50
255	3	4	50
256	8	3	50
257	640	6	50
258	12	1	51
259	39	2	51
260	9	4	51
261	24	3	51
262	1987	6	51
263	1	1	52
264	3.25	2	52
265	0.75	4	52
266	2	3	52
267	385	5	52
268	2	10	53
269	1	1	53
270	3.25	2	53
271	2	3	53
272	0.75	4	53
273	424	5	53
274	14	1	54
275	45.5	2	54
276	10.5	4	54
277	28	3	54
278	2331	6	54
279	13	1	55
280	42.25	2	55
281	9.75	4	55
282	26	3	55
283	2132	6	55
284	4	10	56
285	2	1	56
286	6.5	2	56
287	4	3	56
288	1.5	4	56
289	839	5	56
290	15	1	57
291	48.75	2	57
292	11.25	4	57
293	30	3	57
294	2518	6	57
295	2	7	58
296	1	4	58
297	6	2	58
298	1	3	58
299	24	8	58
300	516	9	58
306	2	1	60
307	6.5	2	60
308	1.5	4	60
309	4	3	60
310	681	5	60
311	7	1	61
312	22.75	2	61
313	5.25	4	61
314	14	3	61
315	1182	6	61
\.


--
-- Data for Name: web_purchase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_purchase (id, type, amount, notes, date, supplier_id) FROM stdin;
\.


--
-- Data for Name: web_recipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_recipe (id, quantity_produced, name) FROM stdin;
6	380	80G Recipe
7	156	200G Recipe
8	300	BBQ Recipe
9	420	Garlic Recipe
\.


--
-- Data for Name: web_sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_sales (id, sales_type, quantity, customer_id, product_id, actual_sale, freebies, projected_sale, date) FROM stdin;
5	DELIVERY	3050	3	1	0	0	34312.5	2022-09-01
6	DELIVERY	1500	4	1	0	0	16875	2022-09-01
7	DELIVERY	1650	5	1	0	0	18562.5	2022-09-01
8	DELIVERY	100	6	1	0	0	1125	2022-09-01
9	WALK-IN	130	8	1	0	0	1462.5	2022-09-01
10	WALK-IN	234	8	1	0	0	2632.5	2022-09-01
11	DELIVERY	2150	3	2	0	0	47837.5	2022-09-01
12	DELIVERY	1200	4	2	0	0	26700	2022-09-01
13	DELIVERY	550	5	2	0	0	12237.5	2022-09-01
14	DELIVERY	250	6	2	0	0	5562.5	2022-09-01
15	WALK-IN	65	8	2	0	0	1446.25	2022-09-01
16	WALK-IN	65	8	2	0	0	1446.25	2022-09-01
17	WALK-IN	65	8	3	0	0	812.5	2022-09-01
18	WALK-IN	130	8	3	0	0	1625	2022-09-01
19	DELIVERY	120	3	4	0	0	1440	2022-09-01
20	DELIVERY	100	6	4	0	0	1200	2022-09-01
26	DELIVERY	1450	3	2	0	0	32262.5	2022-09-05
27	DELIVERY	850	4	2	0	0	18912.5	2022-09-05
28	DELIVERY	350	5	2	0	0	7787.5	2022-09-05
29	DELIVERY	1450	6	2	0	0	32262.5	2022-09-05
30	DELIVERY	0	7	2	0	0	0	2022-09-05
31	DELIVERY	156	9	2	0	30	3471	2022-09-05
32	DELIVERY	204	10	2	0	30	4539	2022-09-05
33	DELIVERY	864	11	2	0	42	19224	2022-09-05
34	DELIVERY	240	12	2	0	20	5340	2022-09-05
35	DELIVERY	0	13	2	0	0	0	2022-09-05
36	DELIVERY	2550	3	1	0	0	28687.5	2022-09-05
37	DELIVERY	1100	4	1	0	0	12375	2022-09-05
38	DELIVERY	1480	5	1	0	0	16650	2022-09-05
39	DELIVERY	1800	6	1	0	0	20250	2022-09-05
40	DELIVERY	0	7	1	0	0	0	2022-09-05
41	DELIVERY	1164	9	1	0	64	13095	2022-09-05
42	DELIVERY	468	10	1	0	63	5265	2022-09-05
43	DELIVERY	648	11	1	0	63	7290	2022-09-05
44	DELIVERY	900	12	1	0	75	10125	2022-09-05
45	DELIVERY	0	13	1	0	0	0	2022-09-05
46	DELIVERY	0	3	4	0	0	0	2022-09-05
47	DELIVERY	0	4	4	0	0	0	2022-09-05
48	DELIVERY	0	5	4	0	0	0	2022-09-05
49	DELIVERY	550	6	4	0	0	6600	2022-09-05
50	DELIVERY	0	7	4	0	0	0	2022-09-05
51	DELIVERY	0	9	4	0	0	0	2022-09-05
52	DELIVERY	0	10	4	0	0	0	2022-09-05
53	DELIVERY	0	11	4	0	0	0	2022-09-05
54	DELIVERY	0	12	4	0	0	0	2022-09-05
55	DELIVERY	0	13	4	0	0	0	2022-09-05
56	DELIVERY	0	3	3	0	0	0	2022-09-05
57	DELIVERY	0	4	3	0	0	0	2022-09-05
58	DELIVERY	0	5	3	0	0	0	2022-09-05
59	DELIVERY	150	6	3	0	0	1875	2022-09-05
60	DELIVERY	0	7	3	0	0	0	2022-09-05
61	DELIVERY	216	9	3	0	61	2700	2022-09-05
62	DELIVERY	300	10	3	0	61	3750	2022-09-05
63	DELIVERY	1680	11	3	0	61	21000	2022-09-05
64	DELIVERY	0	12	3	0	0	0	2022-09-05
65	DELIVERY	3600	13	3	0	0	45000	2022-09-05
66	DELIVERY	2200	3	2	0	0	48950	2022-09-12
67	DELIVERY	950	4	2	0	0	21137.5	2022-09-12
68	DELIVERY	450	5	2	0	0	10012.5	2022-09-12
69	DELIVERY	1200	6	2	0	0	26700	2022-09-12
70	DELIVERY	150	7	2	0	0	3337.5	2022-09-12
71	DELIVERY	1368	14	2	0	0	30438	2022-09-12
72	DELIVERY	3530	3	1	0	0	39712.5	2022-09-12
73	DELIVERY	1600	4	1	0	0	18000	2022-09-12
74	DELIVERY	900	5	1	0	0	10125	2022-09-12
75	DELIVERY	1300	6	1	0	0	14625	2022-09-12
76	DELIVERY	150	7	1	0	0	1687.5	2022-09-12
77	DELIVERY	1764	14	1	0	0	19845	2022-09-12
78	DELIVERY	150	3	4	0	0	1800	2022-09-12
79	DELIVERY	50	4	4	0	0	600	2022-09-12
80	DELIVERY	0	5	4	0	0	0	2022-09-12
81	DELIVERY	350	6	4	0	0	4200	2022-09-12
82	DELIVERY	50	7	4	0	0	600	2022-09-12
83	DELIVERY	84	14	4	0	0	1008	2022-09-12
84	DELIVERY	0	3	3	0	0	0	2022-09-12
85	DELIVERY	0	4	3	0	0	0	2022-09-12
86	DELIVERY	0	5	3	0	0	0	2022-09-12
87	DELIVERY	50	6	3	0	0	625	2022-09-12
88	DELIVERY	0	7	3	0	0	0	2022-09-12
89	DELIVERY	1176	14	3	0	0	14700	2022-09-12
90	DELIVERY	1200	7	2	0	0	26700	2022-09-19
91	DELIVERY	250	6	2	0	0	5562.5	2022-09-19
92	DELIVERY	1728	18	2	0	0	38448	2022-09-19
93	DELIVERY	1200	17	2	0	0	26700	2022-09-19
94	DELIVERY	1350	15	2	0	0	30037.5	2022-09-19
95	DELIVERY	1350	16	2	0	0	30037.5	2022-09-19
96	DELIVERY	1050	15	2	0	0	23362.5	2022-09-19
97	DELIVERY	120	8	2	0	0	2670	2022-09-19
98	DELIVERY	1100	7	1	0	0	12375	2022-09-19
99	DELIVERY	400	6	1	0	0	4500	2022-09-19
100	DELIVERY	4008	18	1	0	0	45090	2022-09-19
101	DELIVERY	1800	17	1	0	0	20250	2022-09-19
102	DELIVERY	2799	15	1	0	0	31488.75	2022-09-19
103	DELIVERY	1300	16	1	0	0	14625	2022-09-19
104	DELIVERY	2100	15	1	0	0	23625	2022-09-19
105	DELIVERY	240	8	1	0	0	2700	2022-09-19
106	DELIVERY	200	7	4	0	0	2400	2022-09-19
107	DELIVERY	50	6	4	0	0	600	2022-09-19
108	DELIVERY	0	18	4	0	0	0	2022-09-19
109	DELIVERY	100	17	4	0	0	1200	2022-09-19
110	DELIVERY	0	15	4	0	0	0	2022-09-19
111	DELIVERY	0	16	4	0	0	0	2022-09-19
112	DELIVERY	0	15	4	0	0	0	2022-09-19
113	DELIVERY	0	8	4	0	0	0	2022-09-19
114	DELIVERY	200	7	3	0	0	2500	2022-09-19
115	DELIVERY	0	6	3	0	0	0	2022-09-19
116	DELIVERY	2748	18	3	0	0	34350	2022-09-19
117	DELIVERY	100	17	3	0	0	1250	2022-09-19
118	DELIVERY	0	15	3	0	0	0	2022-09-19
119	DELIVERY	0	16	3	0	0	0	2022-09-19
120	DELIVERY	0	15	3	0	0	0	2022-09-19
121	DELIVERY	60	8	3	0	0	750	2022-09-19
122	DELIVERY	200	19	2	0	0	4450	2022-09-26
123	DELIVERY	200	20	2	0	0	4450	2022-09-26
124	DELIVERY	350	21	2	0	0	7787.5	2022-09-26
125	DELIVERY	300	22	2	0	0	6675	2022-09-26
126	DELIVERY	150	23	2	0	0	3337.5	2022-09-26
127	DELIVERY	400	24	2	0	0	8900	2022-09-26
128	DELIVERY	300	5	2	0	0	6675	2022-09-26
129	DELIVERY	100	26	2	0	0	2225	2022-09-26
130	DELIVERY	200	27	2	0	0	4450	2022-09-26
131	DELIVERY	200	27	2	0	0	4450	2022-09-26
132	DELIVERY	300	3	2	0	0	6675	2022-09-26
133	DELIVERY	200	28	2	0	0	4450	2022-09-26
134	DELIVERY	350	29	2	0	0	7787.5	2022-09-26
135	DELIVERY	150	30	2	0	0	3337.5	2022-09-26
136	DELIVERY	100	23	2	0	0	2225	2022-09-26
137	DELIVERY	350	24	2	0	0	7787.5	2022-09-26
138	DELIVERY	200	5	2	0	0	4450	2022-09-26
139	DELIVERY	150	27	2	0	0	3337.5	2022-09-26
140	DELIVERY	100	31	2	0	0	2225	2022-09-26
141	DELIVERY	100	32	2	0	0	2225	2022-09-26
142	DELIVERY	300	33	2	0	0	6675	2022-09-26
143	DELIVERY	500	19	1	0	0	5625	2022-09-26
144	DELIVERY	250	20	1	0	0	2812.5	2022-09-26
145	DELIVERY	700	21	1	0	0	7875	2022-09-26
146	DELIVERY	500	22	1	0	0	5625	2022-09-26
147	DELIVERY	200	23	1	0	0	2250	2022-09-26
148	DELIVERY	700	24	1	0	0	7875	2022-09-26
149	DELIVERY	900	5	1	0	0	10125	2022-09-26
150	DELIVERY	300	26	1	0	0	3375	2022-09-26
151	DELIVERY	200	27	1	0	0	2250	2022-09-26
152	DELIVERY	200	27	1	0	0	2250	2022-09-26
153	DELIVERY	300	3	1	0	0	3375	2022-09-26
154	DELIVERY	200	28	1	0	0	2250	2022-09-26
155	DELIVERY	300	29	1	0	0	3375	2022-09-26
156	DELIVERY	200	30	1	0	0	2250	2022-09-26
157	DELIVERY	200	23	1	0	0	2250	2022-09-26
158	DELIVERY	600	24	1	0	0	6750	2022-09-26
159	DELIVERY	900	5	1	0	0	10125	2022-09-26
160	DELIVERY	150	27	1	0	0	1687.5	2022-09-26
161	DELIVERY	200	31	1	0	0	2250	2022-09-26
162	DELIVERY	100	32	1	0	0	1125	2022-09-26
163	DELIVERY	100	33	1	0	0	1125	2022-09-26
164	DELIVERY	0	19	4	0	0	0	2022-09-26
165	DELIVERY	0	20	4	0	0	0	2022-09-26
166	DELIVERY	0	21	4	0	0	0	2022-09-26
167	DELIVERY	100	22	4	0	0	1200	2022-09-26
168	DELIVERY	0	23	4	0	0	0	2022-09-26
169	DELIVERY	0	24	4	0	0	0	2022-09-26
170	DELIVERY	0	5	4	0	0	0	2022-09-26
171	DELIVERY	0	26	4	0	0	0	2022-09-26
172	DELIVERY	0	27	4	0	0	0	2022-09-26
173	DELIVERY	25	27	4	0	0	300	2022-09-26
174	DELIVERY	50	3	4	0	0	600	2022-09-26
175	DELIVERY	25	28	4	0	0	300	2022-09-26
176	DELIVERY	50	29	4	0	0	600	2022-09-26
177	DELIVERY	0	30	4	0	0	0	2022-09-26
178	DELIVERY	0	23	4	0	0	0	2022-09-26
179	DELIVERY	100	24	4	0	0	1200	2022-09-26
180	DELIVERY	60	5	4	0	0	720	2022-09-26
181	DELIVERY	0	27	4	0	0	0	2022-09-26
182	DELIVERY	0	31	4	0	0	0	2022-09-26
183	DELIVERY	50	32	4	0	0	600	2022-09-26
184	DELIVERY	100	33	4	0	0	1200	2022-09-26
185	DELIVERY	0	19	3	0	0	0	2022-09-26
186	DELIVERY	0	20	3	0	0	0	2022-09-26
187	DELIVERY	0	21	3	0	0	0	2022-09-26
188	DELIVERY	100	22	3	0	0	1250	2022-09-26
189	DELIVERY	0	23	3	0	0	0	2022-09-26
190	DELIVERY	0	24	3	0	0	0	2022-09-26
191	DELIVERY	0	5	3	0	0	0	2022-09-26
192	DELIVERY	0	26	3	0	0	0	2022-09-26
193	DELIVERY	0	27	3	0	0	0	2022-09-26
194	DELIVERY	0	27	3	0	0	0	2022-09-26
195	DELIVERY	25	3	3	0	0	312.5	2022-09-26
196	DELIVERY	0	28	3	0	0	0	2022-09-26
197	DELIVERY	50	29	3	0	0	625	2022-09-26
198	DELIVERY	0	30	3	0	0	0	2022-09-26
199	DELIVERY	0	23	3	0	0	0	2022-09-26
200	DELIVERY	50	24	3	0	0	625	2022-09-26
201	DELIVERY	50	5	3	0	0	625	2022-09-26
202	DELIVERY	0	27	3	0	0	0	2022-09-26
203	DELIVERY	0	31	3	0	0	0	2022-09-26
204	DELIVERY	50	32	3	0	0	625	2022-09-26
205	DELIVERY	0	33	3	0	0	0	2022-09-26
206	DELIVERY	1550	3	2	0	0	34487.5	2022-10-03
207	DELIVERY	1150	4	2	0	0	25587.5	2022-10-03
208	DELIVERY	450	5	2	0	0	10012.5	2022-10-03
209	DELIVERY	0	6	2	0	0	0	2022-10-03
210	DELIVERY	0	7	2	0	0	0	2022-10-03
211	DELIVERY	576	9	2	0	0	12816	2022-10-03
212	DELIVERY	240	10	2	0	0	5340	2022-10-03
213	DELIVERY	744	11	2	0	0	16554	2022-10-03
214	DELIVERY	0	34	2	0	0	0	2022-10-03
215	DELIVERY	500	35	2	0	0	11125	2022-10-03
216	DELIVERY	2900	3	1	0	0	32625	2022-10-03
217	DELIVERY	1500	4	1	0	0	16875	2022-10-03
218	DELIVERY	1500	5	1	0	0	16875	2022-10-03
219	DELIVERY	0	6	1	0	0	0	2022-10-03
220	DELIVERY	0	7	1	0	0	0	2022-10-03
221	DELIVERY	924	9	1	0	0	10395	2022-10-03
222	DELIVERY	720	10	1	0	0	8100	2022-10-03
223	DELIVERY	1284	11	1	0	0	14445	2022-10-03
224	DELIVERY	300	34	1	0	0	3375	2022-10-03
225	DELIVERY	500	35	1	0	0	5625	2022-10-03
236	DELIVERY	0	3	4	0	0	0	2022-10-03
237	DELIVERY	0	4	4	0	0	0	2022-10-03
238	DELIVERY	0	5	4	0	0	0	2022-10-03
239	DELIVERY	0	6	4	0	0	0	2022-10-03
240	DELIVERY	0	7	4	0	0	0	2022-10-03
241	DELIVERY	0	9	4	0	0	0	2022-10-03
242	DELIVERY	228	10	4	0	0	2736	2022-10-03
243	DELIVERY	1368	11	4	0	0	16416	2022-10-03
244	DELIVERY	0	34	4	0	0	0	2022-10-03
245	DELIVERY	0	35	4	0	0	0	2022-10-03
246	DELIVERY	2525	3	3	0	0	31562.5	2022-10-03
247	DELIVERY	0	4	3	0	0	0	2022-10-03
248	DELIVERY	0	5	3	0	0	0	2022-10-03
249	DELIVERY	0	6	3	0	0	0	2022-10-03
250	DELIVERY	0	7	3	0	0	0	2022-10-03
251	DELIVERY	228	9	3	0	0	2850	2022-10-03
252	DELIVERY	0	10	3	0	0	0	2022-10-03
253	DELIVERY	0	11	3	0	0	0	2022-10-03
254	DELIVERY	150	34	3	0	0	1875	2022-10-03
255	DELIVERY	500	35	3	0	0	6250	2022-10-03
256	DELIVERY	2150	3	2	0	0	47837.5	2022-10-10
257	DELIVERY	1150	4	2	0	0	25587.5	2022-10-10
258	DELIVERY	500	5	2	0	0	11125	2022-10-10
259	DELIVERY	1300	6	2	0	0	28925	2022-10-10
260	DELIVERY	0	7	2	0	0	0	2022-10-10
261	DELIVERY	3400	3	1	0	0	38250	2022-10-10
262	DELIVERY	1600	4	1	0	0	18000	2022-10-10
263	DELIVERY	1200	5	1	0	0	13500	2022-10-10
264	DELIVERY	1500	6	1	0	0	16875	2022-10-10
265	DELIVERY	0	7	1	0	0	0	2022-10-10
266	DELIVERY	0	3	4	0	0	0	2022-10-10
267	DELIVERY	45	4	4	0	0	540	2022-10-10
268	DELIVERY	0	5	4	0	0	0	2022-10-10
269	DELIVERY	350	6	4	0	0	4200	2022-10-10
270	DELIVERY	0	7	4	0	0	0	2022-10-10
271	DELIVERY	0	3	3	0	0	0	2022-10-10
272	DELIVERY	50	4	3	0	0	625	2022-10-10
273	DELIVERY	0	5	3	0	0	0	2022-10-10
274	DELIVERY	50	6	3	0	0	625	2022-10-10
275	DELIVERY	0	7	3	0	0	0	2022-10-10
276	DELIVERY	1850	3	2	0	0	41162.5	2022-10-17
277	DELIVERY	650	4	2	0	0	14462.5	2022-10-17
278	DELIVERY	600	5	2	0	0	13350	2022-10-17
279	DELIVERY	0	6	2	0	0	0	2022-10-17
280	DELIVERY	700	7	2	0	0	15575	2022-10-17
281	DELIVERY	276	9	2	0	0	6141	2022-10-17
282	DELIVERY	372	10	2	0	0	8277	2022-10-17
283	DELIVERY	900	11	2	0	0	20025	2022-10-17
284	DELIVERY	1800	3	1	0	0	20250	2022-10-17
285	DELIVERY	700	4	1	0	0	7875	2022-10-17
286	DELIVERY	1200	5	1	0	0	13500	2022-10-17
287	DELIVERY	0	6	1	0	0	0	2022-10-17
288	DELIVERY	2100	7	1	0	0	23625	2022-10-17
289	DELIVERY	552	9	1	0	0	6210	2022-10-17
290	DELIVERY	660	10	1	0	0	7425	2022-10-17
291	DELIVERY	456	11	1	0	0	5130	2022-10-17
292	DELIVERY	225	3	4	0	0	2700	2022-10-17
293	DELIVERY	0	4	4	0	0	0	2022-10-17
294	DELIVERY	100	5	4	0	0	1200	2022-10-17
295	DELIVERY	0	6	4	0	0	0	2022-10-17
296	DELIVERY	0	7	4	0	0	0	2022-10-17
297	DELIVERY	0	9	4	0	0	0	2022-10-17
298	DELIVERY	0	10	4	0	0	0	2022-10-17
299	DELIVERY	0	11	4	0	0	0	2022-10-17
300	DELIVERY	125	3	3	0	0	1562.5	2022-10-17
301	DELIVERY	0	4	3	0	0	0	2022-10-17
302	DELIVERY	100	5	3	0	0	1250	2022-10-17
303	DELIVERY	0	6	3	0	0	0	2022-10-17
304	DELIVERY	100	7	3	0	0	1250	2022-10-17
305	DELIVERY	528	9	3	0	0	6600	2022-10-17
306	DELIVERY	156	10	3	0	0	1950	2022-10-17
307	DELIVERY	984	11	3	0	0	12300	2022-10-17
\.


--
-- Data for Name: web_supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_supplier (id, name) FROM stdin;
\.


--
-- Data for Name: web_supply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_supply (id, quantity, supplied_at, item_id, purchase_order_id) FROM stdin;
\.


--
-- Data for Name: web_supplyitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_supplyitem (id, name, price, unit) FROM stdin;
1	Flour Sack	1000	SACK
2	Iodized Salt	18	KG
4	Pepper	240	KG
3	MSG	167.5	KG
5	Plastic Wrap (S)	1.1	Piece
6	Plastic Wrap (L)	1.3	Piece
7	Hyco	280	Piece
8	Sugar	63	KG
9	Plastic Wrap (BBQ)	1.3	Piece
10	Garlic Powder	340	Piece
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 72, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 143, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 18, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 33, true);


--
-- Name: web_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_customer_id_seq', 35, true);


--
-- Name: web_customertype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_customertype_id_seq', 7, true);


--
-- Name: web_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_ingredient_id_seq', 22, true);


--
-- Name: web_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_product_id_seq', 4, true);


--
-- Name: web_production_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_production_id_seq', 61, true);


--
-- Name: web_productioningredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_productioningredients_id_seq', 315, true);


--
-- Name: web_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_purchase_id_seq', 1, false);


--
-- Name: web_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_recipe_id_seq', 9, true);


--
-- Name: web_sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_sales_id_seq', 307, true);


--
-- Name: web_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_supplier_id_seq', 1, false);


--
-- Name: web_supply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_supply_id_seq', 11, true);


--
-- Name: web_supplyitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_supplyitem_id_seq', 10, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: web_customer web_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_customer
    ADD CONSTRAINT web_customer_pkey PRIMARY KEY (id);


--
-- Name: web_customertype web_customertype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_customertype
    ADD CONSTRAINT web_customertype_pkey PRIMARY KEY (id);


--
-- Name: web_ingredient web_ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_ingredient
    ADD CONSTRAINT web_ingredient_pkey PRIMARY KEY (id);


--
-- Name: web_product web_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_product
    ADD CONSTRAINT web_product_pkey PRIMARY KEY (id);


--
-- Name: web_production web_production_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_production
    ADD CONSTRAINT web_production_pkey PRIMARY KEY (id);


--
-- Name: web_production web_production_product_id_date_3c841a19_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_production
    ADD CONSTRAINT web_production_product_id_date_3c841a19_uniq UNIQUE (product_id, date);


--
-- Name: web_productioningredients web_productioningredients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_productioningredients
    ADD CONSTRAINT web_productioningredients_pkey PRIMARY KEY (id);


--
-- Name: web_purchase web_purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_purchase
    ADD CONSTRAINT web_purchase_pkey PRIMARY KEY (id);


--
-- Name: web_recipe web_recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_recipe
    ADD CONSTRAINT web_recipe_pkey PRIMARY KEY (id);


--
-- Name: web_sales web_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_sales
    ADD CONSTRAINT web_sales_pkey PRIMARY KEY (id);


--
-- Name: web_supplier web_supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supplier
    ADD CONSTRAINT web_supplier_pkey PRIMARY KEY (id);


--
-- Name: web_supply web_supply_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supply
    ADD CONSTRAINT web_supply_pkey PRIMARY KEY (id);


--
-- Name: web_supplyitem web_supplyitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supplyitem
    ADD CONSTRAINT web_supplyitem_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: web_customer_customer_type_id_5a8bc22a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_customer_customer_type_id_5a8bc22a ON public.web_customer USING btree (customer_type_id);


--
-- Name: web_ingredient_ingredient_id_89a4f7eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_ingredient_ingredient_id_89a4f7eb ON public.web_ingredient USING btree (ingredient_id);


--
-- Name: web_ingredient_recipe_id_4e0aeb45; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_ingredient_recipe_id_4e0aeb45 ON public.web_ingredient USING btree (recipe_id);


--
-- Name: web_product_recipe_id_32d28027; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_product_recipe_id_32d28027 ON public.web_product USING btree (recipe_id);


--
-- Name: web_production_product_id_f4104a70; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_production_product_id_f4104a70 ON public.web_production USING btree (product_id);


--
-- Name: web_productioningredients_ingredient_id_4c0d2537; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_productioningredients_ingredient_id_4c0d2537 ON public.web_productioningredients USING btree (ingredient_id);


--
-- Name: web_productioningredients_production_id_df987c6a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_productioningredients_production_id_df987c6a ON public.web_productioningredients USING btree (production_id);


--
-- Name: web_purchase_supplier_id_d0d83215; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_purchase_supplier_id_d0d83215 ON public.web_purchase USING btree (supplier_id);


--
-- Name: web_sales_customer_id_b757fd47; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_sales_customer_id_b757fd47 ON public.web_sales USING btree (customer_id);


--
-- Name: web_sales_product_id_f1ed59b7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_sales_product_id_f1ed59b7 ON public.web_sales USING btree (product_id);


--
-- Name: web_supply_item_id_1adb22ea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_supply_item_id_1adb22ea ON public.web_supply USING btree (item_id);


--
-- Name: web_supply_purchase_order_id_a22a0dc0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_supply_purchase_order_id_a22a0dc0 ON public.web_supply USING btree (purchase_order_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_customer web_customer_customer_type_id_5a8bc22a_fk_web_customertype_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_customer
    ADD CONSTRAINT web_customer_customer_type_id_5a8bc22a_fk_web_customertype_id FOREIGN KEY (customer_type_id) REFERENCES public.web_customertype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_ingredient web_ingredient_ingredient_id_89a4f7eb_fk_web_supplyitem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_ingredient
    ADD CONSTRAINT web_ingredient_ingredient_id_89a4f7eb_fk_web_supplyitem_id FOREIGN KEY (ingredient_id) REFERENCES public.web_supplyitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_ingredient web_ingredient_recipe_id_4e0aeb45_fk_web_recipe_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_ingredient
    ADD CONSTRAINT web_ingredient_recipe_id_4e0aeb45_fk_web_recipe_id FOREIGN KEY (recipe_id) REFERENCES public.web_recipe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_product web_product_recipe_id_32d28027_fk_web_recipe_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_product
    ADD CONSTRAINT web_product_recipe_id_32d28027_fk_web_recipe_id FOREIGN KEY (recipe_id) REFERENCES public.web_recipe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_production web_production_product_id_f4104a70_fk_web_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_production
    ADD CONSTRAINT web_production_product_id_f4104a70_fk_web_product_id FOREIGN KEY (product_id) REFERENCES public.web_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productioningredients web_productioningred_ingredient_id_4c0d2537_fk_web_suppl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_productioningredients
    ADD CONSTRAINT web_productioningred_ingredient_id_4c0d2537_fk_web_suppl FOREIGN KEY (ingredient_id) REFERENCES public.web_supplyitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productioningredients web_productioningred_production_id_df987c6a_fk_web_produ; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_productioningredients
    ADD CONSTRAINT web_productioningred_production_id_df987c6a_fk_web_produ FOREIGN KEY (production_id) REFERENCES public.web_production(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_purchase web_purchase_supplier_id_d0d83215_fk_web_supplier_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_purchase
    ADD CONSTRAINT web_purchase_supplier_id_d0d83215_fk_web_supplier_id FOREIGN KEY (supplier_id) REFERENCES public.web_supplier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_sales web_sales_customer_id_b757fd47_fk_web_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_sales
    ADD CONSTRAINT web_sales_customer_id_b757fd47_fk_web_customer_id FOREIGN KEY (customer_id) REFERENCES public.web_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_sales web_sales_product_id_f1ed59b7_fk_web_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_sales
    ADD CONSTRAINT web_sales_product_id_f1ed59b7_fk_web_product_id FOREIGN KEY (product_id) REFERENCES public.web_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_supply web_supply_item_id_1adb22ea_fk_web_supplyitem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supply
    ADD CONSTRAINT web_supply_item_id_1adb22ea_fk_web_supplyitem_id FOREIGN KEY (item_id) REFERENCES public.web_supplyitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_supply web_supply_purchase_order_id_a22a0dc0_fk_web_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_supply
    ADD CONSTRAINT web_supply_purchase_order_id_a22a0dc0_fk_web_purchase_id FOREIGN KEY (purchase_order_id) REFERENCES public.web_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

