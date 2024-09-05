--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg110+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg110+2)

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
-- Name: template; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA template;


ALTER SCHEMA template OWNER TO admin;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: set_updated_on(); Type: FUNCTION; Schema: template; Owner: postgres
--

CREATE FUNCTION template.set_updated_on() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		NEW.updated_on = NOW();
  		RETURN NEW;
	END;
$$;


ALTER FUNCTION template.set_updated_on() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: description; Type: TABLE; Schema: template; Owner: postgres
--

CREATE TABLE template.description (
    title character varying,
    label character varying,
    description text
);


ALTER TABLE template.description OWNER TO postgres;

--
-- Name: COLUMN description.title; Type: COMMENT; Schema: template; Owner: postgres
--

COMMENT ON COLUMN template.description.title IS 'A very brief description';


--
-- Name: COLUMN description.label; Type: COMMENT; Schema: template; Owner: postgres
--

COMMENT ON COLUMN template.description.label IS 'A medium length description';


--
-- Name: COLUMN description.description; Type: COMMENT; Schema: template; Owner: postgres
--

COMMENT ON COLUMN template.description.description IS 'A full description';


--
-- Name: signature; Type: TABLE; Schema: template; Owner: postgres
--

CREATE TABLE template.signature (
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by character varying,
    updated_by character varying,
    updated_on timestamp with time zone NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE template.signature OWNER TO postgres;

--
-- Name: COLUMN signature.created_on; Type: COMMENT; Schema: template; Owner: postgres
--

COMMENT ON COLUMN template.signature.created_on IS 'Created on';


--
-- Name: COLUMN signature.created_by; Type: COMMENT; Schema: template; Owner: postgres
--

COMMENT ON COLUMN template.signature.created_by IS 'Created by';


--
-- Name: COLUMN signature.updated_by; Type: COMMENT; Schema: template; Owner: postgres
--

COMMENT ON COLUMN template.signature.updated_by IS 'Updated by';


--
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento (
    id bigint NOT NULL,
    started_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    ended_on timestamp with time zone,
    suspended_until timestamp with time zone
)
INHERITS (template.description, template.signature);


ALTER TABLE public.evento OWNER TO postgres;

--
-- Name: evento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evento_id_seq OWNER TO postgres;

--
-- Name: evento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_id_seq OWNED BY public.evento.id;


--
-- Name: segnalazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.segnalazione (
    id bigint NOT NULL,
    started_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    evento_id bigint,
    note text
)
INHERITS (template.description, template.signature);


ALTER TABLE public.segnalazione OWNER TO postgres;

--
-- Name: segnalazione_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.segnalazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.segnalazione_id_seq OWNER TO postgres;

--
-- Name: segnalazione_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.segnalazione_id_seq OWNED BY public.segnalazione.id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.test (
    id bigint NOT NULL,
    nome character varying,
    valore numeric,
    created_on timestamp with time zone DEFAULT now()
);


ALTER TABLE public.test OWNER TO admin;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_id_seq OWNER TO admin;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: evento created_on; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento ALTER COLUMN created_on SET DEFAULT CURRENT_TIMESTAMP;


--
-- Name: evento is_active; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento ALTER COLUMN is_active SET DEFAULT true;


--
-- Name: evento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento ALTER COLUMN id SET DEFAULT nextval('public.evento_id_seq'::regclass);


--
-- Name: segnalazione created_on; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segnalazione ALTER COLUMN created_on SET DEFAULT CURRENT_TIMESTAMP;


--
-- Name: segnalazione is_active; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segnalazione ALTER COLUMN is_active SET DEFAULT true;


--
-- Name: segnalazione id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segnalazione ALTER COLUMN id SET DEFAULT nextval('public.segnalazione_id_seq'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Name: evento evento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pk PRIMARY KEY (id);


--
-- Name: segnalazione segnalazione_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segnalazione
    ADD CONSTRAINT segnalazione_pk PRIMARY KEY (id);


--
-- Name: evento_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX evento_id_idx ON public.evento USING btree (id);


--
-- Name: evento_is_active_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX evento_is_active_idx ON public.evento USING btree (is_active);


--
-- Name: segnalazione_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX segnalazione_id_idx ON public.segnalazione USING btree (id);


--
-- Name: evento updated_on_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER updated_on_tr AFTER INSERT ON public.evento FOR EACH ROW EXECUTE FUNCTION template.set_updated_on();


--
-- Name: segnalazione updated_on_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER updated_on_tr AFTER INSERT ON public.segnalazione FOR EACH ROW EXECUTE FUNCTION template.set_updated_on();


--
-- Name: segnalazione segnalazione_evento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segnalazione
    ADD CONSTRAINT segnalazione_evento_id_fkey FOREIGN KEY (evento_id) REFERENCES public.evento(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO admin;


--
-- Name: TABLE evento; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.evento TO admin;


--
-- Name: TABLE geography_columns; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.geography_columns TO admin;


--
-- Name: TABLE geometry_columns; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.geometry_columns TO admin;


--
-- Name: TABLE spatial_ref_sys; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.spatial_ref_sys TO admin;


--
-- PostgreSQL database dump complete
--

