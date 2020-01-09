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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';



--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description text,
    available_on timestamp without time zone,
    deleted_at timestamp without time zone,
    slug character varying,
    meta_description text,
    meta_keywords character varying,
    tax_category_id integer,
    shipping_category_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    catalog_number public.citext,
    brand_id integer,
    new_product boolean,
    discontinued boolean,
    default_color_id integer,
    is_premium boolean,
    color_header_label character varying,
    retail_price numeric DEFAULT 0,
    avg_rating numeric(7,5) DEFAULT 0.0 NOT NULL,
    reviews_count integer DEFAULT 0 NOT NULL,
    promotionable boolean DEFAULT true,
    meta_title character varying,
    companions text,
    short_url character varying,
    closeout boolean DEFAULT false,
    manual_price_white_cents integer,
    manual_price_gray_cents integer,
    manual_price_color_cents integer,
    manual_price_currency character varying DEFAULT 'USD'::character varying,
    ignored_at timestamp without time zone,
    exclusive boolean DEFAULT false NOT NULL,
    comparables character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    reviews_updated_at timestamp without time zone,
    quality_designation integer
);

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);



--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: index_products_on_catalog_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_products_on_catalog_number ON public.products USING btree (catalog_number);


--
-- Name: index_products_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_name ON public.products USING btree (name);


--
-- Name: index_products_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_products_on_slug ON public.products USING btree (slug);










--
-- Name: variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants (
    id integer NOT NULL,
    sku character varying,
    weight numeric(8,2) DEFAULT 0.0,
    height numeric(8,2),
    width numeric(8,2),
    depth numeric(8,2),
    deleted_at timestamp without time zone,
    is_master boolean DEFAULT false,
    product_id integer,
    cost_price numeric(10,2),
    "position" integer,
    cost_currency character varying,
    track_inventory boolean DEFAULT true,
    tax_category_id integer,
    updated_at timestamp without time zone,
    retail_price numeric,
    sold boolean DEFAULT false,
    new_variant boolean DEFAULT true,
    discontinued boolean DEFAULT false,
    hexcode character varying,
    lightness character varying,
    weight_unit character varying,
    volume_unit character varying,
    volume numeric(10,2),
    back_image_source_url character varying,
    front_image_source_url character varying,
    fronthover_image_source_url character varying,
    inside_image_source_url character varying,
    leftside_image_source_url character varying,
    right_image_source_url character varying,
    rightside_image_source_url character varying,
    color_id integer,
    created_at timestamp without time zone,
    case_quantity integer,
    composition_id integer,
    ignored_at timestamp without time zone,
    minimum_advertised_price numeric,
    manual_price_cents integer,
    gtin character varying(14),
    CONSTRAINT composition_id_is_not_null CHECK ((is_master OR (composition_id IS NOT NULL)))
);


--
-- Name: variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variants_id_seq OWNED BY public.variants.id;


--
-- Name: variants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants ALTER COLUMN id SET DEFAULT nextval('public.variants_id_seq'::regclass);


--
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (id);



--
-- Name: index_variants_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_variants_on_product_id ON public.variants USING btree (product_id);



--
-- Name: option_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.option_values (
    id integer NOT NULL,
    "position" integer,
    name public.citext,
    presentation character varying,
    option_type_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);



--
-- Name: option_values_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.option_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: option_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.option_values_id_seq OWNED BY public.option_values.id;


--
-- Name: option_values_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.option_values_variants (
    variant_id integer,
    option_value_id integer,
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: option_values_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.option_values_variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: option_values_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.option_values_variants_id_seq OWNED BY public.option_values_variants.id;

--
-- Name: option_values id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.option_values ALTER COLUMN id SET DEFAULT nextval('public.option_values_id_seq'::regclass);


--
-- Name: option_values_variants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.option_values_variants ALTER COLUMN id SET DEFAULT nextval('public.option_values_variants_id_seq'::regclass);



--
-- Name: option_values option_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.option_values
    ADD CONSTRAINT option_values_pkey PRIMARY KEY (id);


--
-- Name: option_values_variants option_values_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.option_values_variants
    ADD CONSTRAINT option_values_variants_pkey PRIMARY KEY (id);


--
-- Name: index_option_values_variants_on_variant_id_and_option_value_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_option_values_variants_on_variant_id_and_option_value_id ON public.option_values_variants USING btree (variant_id, option_value_id);



--
-- Name: index_option_values_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_option_values_on_id ON public.option_values USING btree (id);

--
-- Name: index_option_values_variants_on_option_value_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_option_values_variants_on_option_value_id ON public.option_values_variants USING btree (option_value_id);


--
-- Name: index_option_values_variants_on_variant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_option_values_variants_on_variant_id ON public.option_values_variants USING btree (variant_id);



