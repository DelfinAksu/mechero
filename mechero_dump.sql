--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-18 22:27:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16447)
-- Name: appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment (
    appointment_id integer NOT NULL,
    a_date date NOT NULL,
    a_time time without time zone NOT NULL,
    status character varying(20) NOT NULL,
    price numeric(10,2) NOT NULL,
    user_id integer,
    vehicle_id integer,
    dealership_id integer,
    type_id integer,
    CONSTRAINT appointment_status_check CHECK (((status)::text = ANY ((ARRAY['Scheduled'::character varying, 'Cancelled'::character varying, 'Completed'::character varying])::text[])))
);


ALTER TABLE public.appointment OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16446)
-- Name: appointment_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointment_appointment_id_seq OWNER TO postgres;

--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 227
-- Name: appointment_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_appointment_id_seq OWNED BY public.appointment.appointment_id;


--
-- TOC entry 222 (class 1259 OID 16418)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(25) NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16417)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_city_id_seq OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 221
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- TOC entry 224 (class 1259 OID 16425)
-- Name: dealership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dealership (
    dealership_id integer NOT NULL,
    d_name character varying(100) NOT NULL,
    address text NOT NULL,
    d_phone character varying(15) NOT NULL,
    latitude double precision,
    longitude double precision,
    city_id integer
);


ALTER TABLE public.dealership OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16424)
-- Name: dealership_dealership_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dealership_dealership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dealership_dealership_id_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 223
-- Name: dealership_dealership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dealership_dealership_id_seq OWNED BY public.dealership.dealership_id;


--
-- TOC entry 230 (class 1259 OID 16475)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    e_fname character varying(50) NOT NULL,
    e_lname character varying(50) NOT NULL,
    e_phone character varying(15) NOT NULL,
    e_email character varying(100) NOT NULL,
    e_role character varying(50) NOT NULL,
    hire_date date NOT NULL,
    dealership_id integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16474)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_employee_id_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 229
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- TOC entry 232 (class 1259 OID 16487)
-- Name: employee_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_schedule (
    schedule_id integer NOT NULL,
    work_date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    employee_id integer,
    appointment_id integer
);


ALTER TABLE public.employee_schedule OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16486)
-- Name: employee_schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_schedule_schedule_id_seq OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 231
-- Name: employee_schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_schedule_schedule_id_seq OWNED BY public.employee_schedule.schedule_id;


--
-- TOC entry 226 (class 1259 OID 16439)
-- Name: maintenance_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maintenance_type (
    type_id integer NOT NULL,
    type_name character varying(50) NOT NULL,
    CONSTRAINT maintenance_type_type_name_check CHECK (((type_name)::text = ANY ((ARRAY['Periodic'::character varying, 'Mechanical'::character varying, 'Damage Repair'::character varying, 'Other'::character varying])::text[])))
);


ALTER TABLE public.maintenance_type OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16438)
-- Name: maintenance_type_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maintenance_type_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.maintenance_type_type_id_seq OWNER TO postgres;

--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 225
-- Name: maintenance_type_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maintenance_type_type_id_seq OWNED BY public.maintenance_type.type_id;


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    u_fname character varying(50) NOT NULL,
    u_lname character varying(50) NOT NULL,
    u_phone character varying(15) NOT NULL,
    u_mail character varying(100) NOT NULL,
    u_password character varying(255) NOT NULL,
    u_created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 220 (class 1259 OID 16401)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle (
    vehicle_id integer NOT NULL,
    plate_number character varying(30) NOT NULL,
    brand character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    model_year integer NOT NULL,
    fuel_type character varying(30) NOT NULL,
    km integer NOT NULL,
    ownership_count integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    user_id integer,
    CONSTRAINT vehicle_fuel_type_check CHECK (((fuel_type)::text = ANY ((ARRAY['Gas'::character varying, 'Diesel'::character varying, 'Electricity'::character varying, 'LPG'::character varying])::text[])))
);


ALTER TABLE public.vehicle OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16400)
-- Name: vehicle_vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicle_vehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicle_vehicle_id_seq OWNER TO postgres;

--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 219
-- Name: vehicle_vehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicle_vehicle_id_seq OWNED BY public.vehicle.vehicle_id;


--
-- TOC entry 4737 (class 2604 OID 16450)
-- Name: appointment appointment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointment_appointment_id_seq'::regclass);


--
-- TOC entry 4734 (class 2604 OID 16421)
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- TOC entry 4735 (class 2604 OID 16428)
-- Name: dealership dealership_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealership ALTER COLUMN dealership_id SET DEFAULT nextval('public.dealership_dealership_id_seq'::regclass);


--
-- TOC entry 4738 (class 2604 OID 16478)
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- TOC entry 4739 (class 2604 OID 16490)
-- Name: employee_schedule schedule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.employee_schedule_schedule_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 16442)
-- Name: maintenance_type type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenance_type ALTER COLUMN type_id SET DEFAULT nextval('public.maintenance_type_type_id_seq'::regclass);


--
-- TOC entry 4730 (class 2604 OID 16393)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4732 (class 2604 OID 16404)
-- Name: vehicle vehicle_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle ALTER COLUMN vehicle_id SET DEFAULT nextval('public.vehicle_vehicle_id_seq'::regclass);


--
-- TOC entry 4928 (class 0 OID 16447)
-- Dependencies: 228
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.appointment VALUES (1501, '2023-08-13', '07:00:00', 'Completed', 8000.00, 224, 441, 33, 1);
INSERT INTO public.appointment VALUES (1502, '2024-01-11', '07:00:00', 'Completed', 15000.00, 398, 807, 58, 2);
INSERT INTO public.appointment VALUES (1503, '2025-02-12', '07:00:00', 'Completed', 15000.00, 442, 889, 59, 2);
INSERT INTO public.appointment VALUES (1504, '2024-11-16', '07:00:00', 'Completed', 15000.00, 33, 65, 61, 2);
INSERT INTO public.appointment VALUES (1505, '2024-03-13', '07:00:00', 'Completed', 35000.00, 302, 603, 87, 3);
INSERT INTO public.appointment VALUES (1506, '2024-12-17', '07:00:00', 'Completed', 8000.00, 338, 683, 41, 1);
INSERT INTO public.appointment VALUES (1507, '2023-03-29', '07:00:00', 'Completed', 15000.00, 220, 434, 66, 2);
INSERT INTO public.appointment VALUES (1508, '2023-11-19', '07:00:00', 'Completed', 8000.00, 225, 444, 43, 1);
INSERT INTO public.appointment VALUES (1509, '2024-06-27', '07:00:00', 'Completed', 35000.00, 290, 582, 93, 3);
INSERT INTO public.appointment VALUES (1510, '2024-11-22', '07:00:00', 'Completed', 15000.00, 201, 398, 78, 2);
INSERT INTO public.appointment VALUES (1, '2023-10-01', '07:00:00', 'Cancelled', 15000.00, 1, 1, 186, 2);
INSERT INTO public.appointment VALUES (2, '2024-10-20', '13:00:00', 'Completed', 15000.00, 2, 6, 76, 2);
INSERT INTO public.appointment VALUES (3, '2023-07-24', '13:00:00', 'Cancelled', 8000.00, 3, 7, 75, 1);
INSERT INTO public.appointment VALUES (4, '2025-08-12', '16:00:00', 'Scheduled', 10000.00, 4, 9, 174, 4);
INSERT INTO public.appointment VALUES (5, '2024-08-14', '16:00:00', 'Completed', 35000.00, 5, 10, 194, 3);
INSERT INTO public.appointment VALUES (6, '2023-08-08', '07:00:00', 'Completed', 10000.00, 6, 14, 66, 4);
INSERT INTO public.appointment VALUES (7, '2025-08-25', '10:00:00', 'Scheduled', 15000.00, 7, 17, 67, 2);
INSERT INTO public.appointment VALUES (8, '2025-09-17', '10:00:00', 'Scheduled', 8000.00, 8, 18, 207, 1);
INSERT INTO public.appointment VALUES (9, '2024-07-18', '16:00:00', 'Completed', 15000.00, 9, 19, 33, 2);
INSERT INTO public.appointment VALUES (10, '2025-09-08', '07:00:00', 'Scheduled', 8000.00, 10, 21, 3, 1);
INSERT INTO public.appointment VALUES (11, '2024-01-14', '10:00:00', 'Completed', 8000.00, 11, 23, 158, 1);
INSERT INTO public.appointment VALUES (12, '2025-01-21', '10:00:00', 'Completed', 10000.00, 12, 25, 36, 4);
INSERT INTO public.appointment VALUES (13, '2024-07-03', '13:00:00', 'Completed', 15000.00, 13, 26, 24, 2);
INSERT INTO public.appointment VALUES (14, '2025-04-25', '07:00:00', 'Completed', 10000.00, 14, 28, 185, 4);
INSERT INTO public.appointment VALUES (15, '2025-11-23', '13:00:00', 'Scheduled', 35000.00, 15, 29, 79, 3);
INSERT INTO public.appointment VALUES (16, '2025-06-05', '16:00:00', 'Scheduled', 8000.00, 16, 32, 30, 1);
INSERT INTO public.appointment VALUES (17, '2024-02-17', '16:00:00', 'Completed', 8000.00, 17, 35, 201, 1);
INSERT INTO public.appointment VALUES (18, '2024-10-16', '07:00:00', 'Completed', 8000.00, 18, 36, 238, 1);
INSERT INTO public.appointment VALUES (19, '2025-11-04', '16:00:00', 'Scheduled', 35000.00, 19, 39, 229, 3);
INSERT INTO public.appointment VALUES (20, '2025-06-26', '10:00:00', 'Scheduled', 10000.00, 20, 42, 80, 4);
INSERT INTO public.appointment VALUES (21, '2025-06-29', '16:00:00', 'Scheduled', 15000.00, 21, 43, 94, 2);
INSERT INTO public.appointment VALUES (22, '2025-12-17', '07:00:00', 'Scheduled', 35000.00, 22, 44, 216, 3);
INSERT INTO public.appointment VALUES (23, '2024-03-21', '13:00:00', 'Completed', 8000.00, 23, 46, 143, 1);
INSERT INTO public.appointment VALUES (24, '2024-08-27', '10:00:00', 'Completed', 15000.00, 24, 47, 51, 2);
INSERT INTO public.appointment VALUES (25, '2025-11-23', '16:00:00', 'Scheduled', 35000.00, 25, 50, 96, 3);
INSERT INTO public.appointment VALUES (26, '2025-05-19', '07:00:00', 'Scheduled', 10000.00, 26, 54, 206, 4);
INSERT INTO public.appointment VALUES (27, '2025-07-27', '10:00:00', 'Scheduled', 35000.00, 27, 55, 21, 3);
INSERT INTO public.appointment VALUES (28, '2025-11-14', '07:00:00', 'Scheduled', 8000.00, 28, 57, 153, 1);
INSERT INTO public.appointment VALUES (29, '2024-09-28', '10:00:00', 'Completed', 8000.00, 29, 58, 225, 1);
INSERT INTO public.appointment VALUES (30, '2025-05-24', '13:00:00', 'Scheduled', 10000.00, 30, 60, 136, 4);
INSERT INTO public.appointment VALUES (31, '2024-08-29', '10:00:00', 'Cancelled', 10000.00, 31, 61, 132, 4);
INSERT INTO public.appointment VALUES (32, '2025-01-05', '10:00:00', 'Completed', 15000.00, 32, 63, 185, 2);
INSERT INTO public.appointment VALUES (33, '2025-10-19', '07:00:00', 'Scheduled', 15000.00, 33, 66, 197, 2);
INSERT INTO public.appointment VALUES (34, '2025-10-09', '13:00:00', 'Scheduled', 15000.00, 34, 68, 92, 2);
INSERT INTO public.appointment VALUES (35, '2024-03-04', '16:00:00', 'Cancelled', 35000.00, 35, 69, 232, 3);
INSERT INTO public.appointment VALUES (36, '2025-04-16', '13:00:00', 'Completed', 10000.00, 36, 70, 111, 4);
INSERT INTO public.appointment VALUES (37, '2024-03-24', '07:00:00', 'Cancelled', 8000.00, 37, 72, 107, 1);
INSERT INTO public.appointment VALUES (38, '2024-09-05', '16:00:00', 'Completed', 15000.00, 38, 74, 127, 2);
INSERT INTO public.appointment VALUES (39, '2024-08-19', '16:00:00', 'Completed', 35000.00, 39, 76, 52, 3);
INSERT INTO public.appointment VALUES (40, '2025-03-31', '16:00:00', 'Completed', 10000.00, 40, 77, 82, 4);
INSERT INTO public.appointment VALUES (41, '2025-08-14', '10:00:00', 'Scheduled', 8000.00, 41, 79, 85, 1);
INSERT INTO public.appointment VALUES (42, '2024-12-30', '16:00:00', 'Completed', 35000.00, 42, 84, 190, 3);
INSERT INTO public.appointment VALUES (43, '2025-07-26', '10:00:00', 'Scheduled', 10000.00, 43, 85, 156, 4);
INSERT INTO public.appointment VALUES (44, '2025-10-25', '16:00:00', 'Scheduled', 35000.00, 44, 86, 134, 3);
INSERT INTO public.appointment VALUES (45, '2025-05-11', '13:00:00', 'Completed', 8000.00, 45, 90, 102, 1);
INSERT INTO public.appointment VALUES (46, '2025-06-19', '16:00:00', 'Scheduled', 8000.00, 46, 93, 82, 1);
INSERT INTO public.appointment VALUES (47, '2025-03-13', '13:00:00', 'Cancelled', 8000.00, 47, 94, 11, 1);
INSERT INTO public.appointment VALUES (48, '2025-07-13', '07:00:00', 'Scheduled', 15000.00, 48, 97, 117, 2);
INSERT INTO public.appointment VALUES (49, '2025-12-24', '10:00:00', 'Scheduled', 15000.00, 49, 98, 62, 2);
INSERT INTO public.appointment VALUES (50, '2024-12-03', '10:00:00', 'Completed', 8000.00, 50, 101, 126, 1);
INSERT INTO public.appointment VALUES (51, '2023-08-19', '13:00:00', 'Completed', 8000.00, 51, 102, 78, 1);
INSERT INTO public.appointment VALUES (52, '2025-02-28', '07:00:00', 'Completed', 8000.00, 52, 106, 132, 1);
INSERT INTO public.appointment VALUES (53, '2024-07-21', '16:00:00', 'Cancelled', 8000.00, 53, 108, 178, 1);
INSERT INTO public.appointment VALUES (54, '2025-08-11', '07:00:00', 'Scheduled', 15000.00, 54, 109, 51, 2);
INSERT INTO public.appointment VALUES (55, '2025-11-13', '07:00:00', 'Scheduled', 35000.00, 55, 110, 66, 3);
INSERT INTO public.appointment VALUES (56, '2025-02-06', '13:00:00', 'Completed', 10000.00, 56, 112, 208, 4);
INSERT INTO public.appointment VALUES (57, '2024-04-01', '16:00:00', 'Cancelled', 35000.00, 57, 113, 5, 3);
INSERT INTO public.appointment VALUES (58, '2025-01-07', '07:00:00', 'Cancelled', 15000.00, 58, 115, 35, 2);
INSERT INTO public.appointment VALUES (59, '2024-05-08', '16:00:00', 'Completed', 15000.00, 59, 119, 30, 2);
INSERT INTO public.appointment VALUES (60, '2025-11-18', '16:00:00', 'Scheduled', 35000.00, 60, 120, 189, 3);
INSERT INTO public.appointment VALUES (61, '2024-10-17', '10:00:00', 'Completed', 35000.00, 61, 121, 173, 3);
INSERT INTO public.appointment VALUES (62, '2025-04-23', '07:00:00', 'Completed', 15000.00, 62, 122, 206, 2);
INSERT INTO public.appointment VALUES (63, '2025-07-14', '13:00:00', 'Scheduled', 15000.00, 63, 123, 1, 2);
INSERT INTO public.appointment VALUES (64, '2025-01-22', '16:00:00', 'Completed', 15000.00, 64, 124, 169, 2);
INSERT INTO public.appointment VALUES (65, '2024-05-10', '16:00:00', 'Cancelled', 8000.00, 65, 126, 73, 1);
INSERT INTO public.appointment VALUES (66, '2025-02-21', '13:00:00', 'Completed', 15000.00, 66, 129, 119, 2);
INSERT INTO public.appointment VALUES (67, '2025-02-03', '13:00:00', 'Completed', 10000.00, 67, 130, 239, 4);
INSERT INTO public.appointment VALUES (68, '2025-06-22', '10:00:00', 'Scheduled', 10000.00, 68, 134, 235, 4);
INSERT INTO public.appointment VALUES (69, '2024-07-12', '07:00:00', 'Completed', 15000.00, 69, 136, 13, 2);
INSERT INTO public.appointment VALUES (70, '2025-03-06', '10:00:00', 'Completed', 8000.00, 70, 137, 11, 1);
INSERT INTO public.appointment VALUES (71, '2024-04-24', '10:00:00', 'Completed', 10000.00, 71, 138, 236, 4);
INSERT INTO public.appointment VALUES (72, '2025-06-14', '07:00:00', 'Scheduled', 8000.00, 72, 140, 31, 1);
INSERT INTO public.appointment VALUES (73, '2025-08-19', '10:00:00', 'Scheduled', 8000.00, 73, 142, 11, 1);
INSERT INTO public.appointment VALUES (74, '2024-09-12', '10:00:00', 'Completed', 15000.00, 74, 143, 4, 2);
INSERT INTO public.appointment VALUES (75, '2023-04-22', '10:00:00', 'Cancelled', 10000.00, 75, 144, 82, 4);
INSERT INTO public.appointment VALUES (76, '2024-08-23', '16:00:00', 'Cancelled', 8000.00, 76, 147, 166, 1);
INSERT INTO public.appointment VALUES (77, '2024-10-28', '07:00:00', 'Cancelled', 15000.00, 77, 148, 132, 2);
INSERT INTO public.appointment VALUES (78, '2024-06-23', '10:00:00', 'Completed', 15000.00, 78, 149, 11, 2);
INSERT INTO public.appointment VALUES (79, '2024-09-22', '10:00:00', 'Completed', 10000.00, 79, 152, 17, 4);
INSERT INTO public.appointment VALUES (80, '2025-11-18', '13:00:00', 'Scheduled', 15000.00, 80, 154, 63, 2);
INSERT INTO public.appointment VALUES (81, '2025-07-23', '07:00:00', 'Scheduled', 10000.00, 81, 156, 116, 4);
INSERT INTO public.appointment VALUES (82, '2024-07-20', '07:00:00', 'Completed', 8000.00, 82, 157, 187, 1);
INSERT INTO public.appointment VALUES (83, '2026-01-01', '13:00:00', 'Scheduled', 8000.00, 83, 159, 162, 1);
INSERT INTO public.appointment VALUES (84, '2025-01-22', '10:00:00', 'Completed', 8000.00, 84, 160, 164, 1);
INSERT INTO public.appointment VALUES (85, '2023-10-10', '13:00:00', 'Completed', 35000.00, 85, 161, 7, 3);
INSERT INTO public.appointment VALUES (86, '2025-09-17', '16:00:00', 'Scheduled', 10000.00, 86, 164, 79, 4);
INSERT INTO public.appointment VALUES (87, '2025-03-14', '10:00:00', 'Completed', 10000.00, 87, 165, 212, 4);
INSERT INTO public.appointment VALUES (88, '2025-08-05', '16:00:00', 'Scheduled', 10000.00, 88, 169, 104, 4);
INSERT INTO public.appointment VALUES (89, '2025-12-03', '13:00:00', 'Scheduled', 10000.00, 89, 170, 131, 4);
INSERT INTO public.appointment VALUES (90, '2023-12-24', '10:00:00', 'Completed', 8000.00, 90, 174, 237, 1);
INSERT INTO public.appointment VALUES (91, '2025-08-30', '07:00:00', 'Scheduled', 8000.00, 91, 176, 202, 1);
INSERT INTO public.appointment VALUES (92, '2025-05-09', '07:00:00', 'Completed', 10000.00, 92, 179, 184, 4);
INSERT INTO public.appointment VALUES (93, '2025-11-05', '13:00:00', 'Scheduled', 35000.00, 93, 180, 39, 3);
INSERT INTO public.appointment VALUES (94, '2024-12-29', '13:00:00', 'Completed', 8000.00, 94, 183, 209, 1);
INSERT INTO public.appointment VALUES (95, '2025-08-06', '10:00:00', 'Scheduled', 15000.00, 95, 184, 123, 2);
INSERT INTO public.appointment VALUES (96, '2025-03-30', '13:00:00', 'Completed', 10000.00, 96, 186, 208, 4);
INSERT INTO public.appointment VALUES (97, '2025-04-08', '16:00:00', 'Completed', 10000.00, 97, 190, 239, 4);
INSERT INTO public.appointment VALUES (98, '2025-09-29', '10:00:00', 'Scheduled', 15000.00, 98, 192, 222, 2);
INSERT INTO public.appointment VALUES (99, '2024-10-29', '07:00:00', 'Completed', 35000.00, 99, 193, 203, 3);
INSERT INTO public.appointment VALUES (100, '2025-09-20', '13:00:00', 'Scheduled', 10000.00, 100, 196, 201, 4);
INSERT INTO public.appointment VALUES (101, '2024-11-07', '13:00:00', 'Completed', 35000.00, 101, 198, 157, 3);
INSERT INTO public.appointment VALUES (102, '2025-03-30', '07:00:00', 'Cancelled', 8000.00, 102, 200, 229, 1);
INSERT INTO public.appointment VALUES (103, '2025-09-29', '07:00:00', 'Scheduled', 35000.00, 103, 201, 100, 3);
INSERT INTO public.appointment VALUES (104, '2024-12-02', '07:00:00', 'Completed', 35000.00, 104, 204, 152, 3);
INSERT INTO public.appointment VALUES (105, '2025-11-20', '16:00:00', 'Scheduled', 15000.00, 105, 205, 234, 2);
INSERT INTO public.appointment VALUES (106, '2025-10-28', '13:00:00', 'Scheduled', 35000.00, 106, 209, 188, 3);
INSERT INTO public.appointment VALUES (107, '2024-12-21', '13:00:00', 'Completed', 15000.00, 107, 211, 173, 2);
INSERT INTO public.appointment VALUES (108, '2023-04-15', '16:00:00', 'Completed', 10000.00, 108, 214, 9, 4);
INSERT INTO public.appointment VALUES (109, '2025-07-22', '16:00:00', 'Scheduled', 15000.00, 109, 216, 156, 2);
INSERT INTO public.appointment VALUES (110, '2024-12-05', '07:00:00', 'Completed', 10000.00, 110, 217, 240, 4);
INSERT INTO public.appointment VALUES (111, '2023-09-21', '10:00:00', 'Completed', 10000.00, 111, 219, 28, 4);
INSERT INTO public.appointment VALUES (112, '2025-11-13', '16:00:00', 'Scheduled', 10000.00, 112, 221, 8, 4);
INSERT INTO public.appointment VALUES (113, '2025-11-25', '13:00:00', 'Scheduled', 35000.00, 113, 222, 202, 3);
INSERT INTO public.appointment VALUES (114, '2024-11-26', '07:00:00', 'Completed', 15000.00, 114, 225, 190, 2);
INSERT INTO public.appointment VALUES (115, '2025-05-06', '13:00:00', 'Completed', 10000.00, 115, 227, 159, 4);
INSERT INTO public.appointment VALUES (116, '2025-09-21', '10:00:00', 'Scheduled', 10000.00, 116, 230, 113, 4);
INSERT INTO public.appointment VALUES (117, '2025-09-23', '16:00:00', 'Scheduled', 35000.00, 117, 232, 57, 3);
INSERT INTO public.appointment VALUES (118, '2025-06-05', '07:00:00', 'Scheduled', 10000.00, 118, 233, 152, 4);
INSERT INTO public.appointment VALUES (119, '2025-11-26', '07:00:00', 'Scheduled', 8000.00, 119, 234, 234, 1);
INSERT INTO public.appointment VALUES (120, '2025-04-30', '10:00:00', 'Completed', 8000.00, 120, 237, 104, 1);
INSERT INTO public.appointment VALUES (121, '2025-03-18', '10:00:00', 'Completed', 15000.00, 121, 238, 234, 2);
INSERT INTO public.appointment VALUES (122, '2025-09-12', '07:00:00', 'Scheduled', 8000.00, 122, 242, 208, 1);
INSERT INTO public.appointment VALUES (123, '2024-12-23', '16:00:00', 'Completed', 10000.00, 123, 244, 19, 4);
INSERT INTO public.appointment VALUES (124, '2025-08-08', '16:00:00', 'Scheduled', 8000.00, 124, 245, 211, 1);
INSERT INTO public.appointment VALUES (125, '2025-07-31', '13:00:00', 'Scheduled', 35000.00, 125, 247, 123, 3);
INSERT INTO public.appointment VALUES (126, '2025-12-04', '16:00:00', 'Scheduled', 8000.00, 126, 248, 159, 1);
INSERT INTO public.appointment VALUES (127, '2024-12-22', '10:00:00', 'Completed', 10000.00, 127, 252, 188, 4);
INSERT INTO public.appointment VALUES (128, '2025-08-04', '10:00:00', 'Scheduled', 8000.00, 128, 254, 199, 1);
INSERT INTO public.appointment VALUES (129, '2025-11-12', '16:00:00', 'Scheduled', 15000.00, 129, 259, 160, 2);
INSERT INTO public.appointment VALUES (130, '2024-10-20', '07:00:00', 'Completed', 15000.00, 130, 260, 141, 2);
INSERT INTO public.appointment VALUES (131, '2025-09-03', '13:00:00', 'Scheduled', 15000.00, 131, 261, 74, 2);
INSERT INTO public.appointment VALUES (132, '2024-05-15', '10:00:00', 'Completed', 15000.00, 132, 262, 188, 2);
INSERT INTO public.appointment VALUES (133, '2024-12-15', '16:00:00', 'Completed', 10000.00, 133, 264, 128, 4);
INSERT INTO public.appointment VALUES (134, '2025-03-12', '07:00:00', 'Cancelled', 10000.00, 134, 266, 64, 4);
INSERT INTO public.appointment VALUES (135, '2025-02-11', '16:00:00', 'Completed', 35000.00, 135, 268, 205, 3);
INSERT INTO public.appointment VALUES (136, '2024-09-03', '13:00:00', 'Completed', 15000.00, 136, 271, 127, 2);
INSERT INTO public.appointment VALUES (137, '2024-10-05', '13:00:00', 'Completed', 8000.00, 137, 276, 110, 1);
INSERT INTO public.appointment VALUES (138, '2025-09-14', '13:00:00', 'Scheduled', 35000.00, 138, 278, 61, 3);
INSERT INTO public.appointment VALUES (139, '2025-07-05', '07:00:00', 'Scheduled', 8000.00, 139, 280, 123, 1);
INSERT INTO public.appointment VALUES (140, '2023-12-10', '16:00:00', 'Completed', 15000.00, 140, 281, 222, 2);
INSERT INTO public.appointment VALUES (141, '2024-11-09', '07:00:00', 'Cancelled', 10000.00, 141, 284, 73, 4);
INSERT INTO public.appointment VALUES (142, '2025-01-20', '10:00:00', 'Completed', 35000.00, 142, 286, 213, 3);
INSERT INTO public.appointment VALUES (143, '2025-09-14', '13:00:00', 'Scheduled', 8000.00, 143, 287, 147, 1);
INSERT INTO public.appointment VALUES (144, '2025-05-27', '10:00:00', 'Scheduled', 35000.00, 144, 289, 108, 3);
INSERT INTO public.appointment VALUES (145, '2024-04-21', '10:00:00', 'Completed', 10000.00, 145, 293, 51, 4);
INSERT INTO public.appointment VALUES (146, '2025-05-12', '13:00:00', 'Cancelled', 15000.00, 146, 295, 170, 2);
INSERT INTO public.appointment VALUES (147, '2024-10-26', '16:00:00', 'Cancelled', 8000.00, 147, 296, 14, 1);
INSERT INTO public.appointment VALUES (148, '2024-05-13', '10:00:00', 'Completed', 35000.00, 148, 298, 99, 3);
INSERT INTO public.appointment VALUES (149, '2025-05-31', '07:00:00', 'Scheduled', 10000.00, 149, 300, 115, 4);
INSERT INTO public.appointment VALUES (150, '2025-02-23', '10:00:00', 'Cancelled', 10000.00, 150, 303, 1, 4);
INSERT INTO public.appointment VALUES (151, '2025-08-02', '07:00:00', 'Scheduled', 10000.00, 151, 305, 23, 4);
INSERT INTO public.appointment VALUES (152, '2025-02-20', '16:00:00', 'Completed', 8000.00, 152, 306, 36, 1);
INSERT INTO public.appointment VALUES (153, '2024-12-13', '07:00:00', 'Cancelled', 15000.00, 153, 310, 200, 2);
INSERT INTO public.appointment VALUES (154, '2025-03-24', '16:00:00', 'Completed', 8000.00, 154, 314, 239, 1);
INSERT INTO public.appointment VALUES (155, '2025-09-10', '16:00:00', 'Scheduled', 15000.00, 155, 317, 151, 2);
INSERT INTO public.appointment VALUES (156, '2025-04-03', '10:00:00', 'Completed', 10000.00, 156, 320, 231, 4);
INSERT INTO public.appointment VALUES (157, '2025-01-11', '13:00:00', 'Cancelled', 8000.00, 157, 321, 48, 1);
INSERT INTO public.appointment VALUES (158, '2025-10-22', '10:00:00', 'Scheduled', 35000.00, 158, 322, 183, 3);
INSERT INTO public.appointment VALUES (159, '2024-12-07', '16:00:00', 'Cancelled', 8000.00, 159, 323, 24, 1);
INSERT INTO public.appointment VALUES (160, '2025-03-26', '10:00:00', 'Completed', 10000.00, 160, 326, 40, 4);
INSERT INTO public.appointment VALUES (161, '2024-12-05', '16:00:00', 'Completed', 35000.00, 161, 327, 86, 3);
INSERT INTO public.appointment VALUES (162, '2024-11-19', '10:00:00', 'Completed', 10000.00, 162, 329, 181, 4);
INSERT INTO public.appointment VALUES (163, '2024-09-19', '07:00:00', 'Completed', 10000.00, 163, 332, 68, 4);
INSERT INTO public.appointment VALUES (164, '2025-08-29', '13:00:00', 'Scheduled', 35000.00, 164, 335, 155, 3);
INSERT INTO public.appointment VALUES (165, '2025-04-14', '10:00:00', 'Completed', 8000.00, 165, 337, 213, 1);
INSERT INTO public.appointment VALUES (166, '2025-08-28', '10:00:00', 'Scheduled', 15000.00, 166, 338, 48, 2);
INSERT INTO public.appointment VALUES (167, '2025-12-16', '10:00:00', 'Scheduled', 8000.00, 167, 339, 217, 1);
INSERT INTO public.appointment VALUES (168, '2025-11-17', '13:00:00', 'Scheduled', 15000.00, 168, 340, 196, 2);
INSERT INTO public.appointment VALUES (169, '2024-07-24', '16:00:00', 'Completed', 35000.00, 169, 343, 82, 3);
INSERT INTO public.appointment VALUES (170, '2023-09-30', '10:00:00', 'Cancelled', 8000.00, 170, 345, 131, 1);
INSERT INTO public.appointment VALUES (171, '2025-12-16', '10:00:00', 'Scheduled', 8000.00, 171, 346, 81, 1);
INSERT INTO public.appointment VALUES (172, '2025-10-17', '10:00:00', 'Scheduled', 35000.00, 172, 347, 101, 3);
INSERT INTO public.appointment VALUES (173, '2025-02-19', '16:00:00', 'Cancelled', 10000.00, 173, 348, 201, 4);
INSERT INTO public.appointment VALUES (174, '2025-08-11', '07:00:00', 'Scheduled', 35000.00, 174, 351, 46, 3);
INSERT INTO public.appointment VALUES (175, '2023-09-25', '07:00:00', 'Completed', 35000.00, 175, 353, 64, 3);
INSERT INTO public.appointment VALUES (176, '2023-11-25', '10:00:00', 'Cancelled', 8000.00, 176, 354, 167, 1);
INSERT INTO public.appointment VALUES (177, '2025-08-27', '07:00:00', 'Scheduled', 8000.00, 177, 355, 62, 1);
INSERT INTO public.appointment VALUES (178, '2025-05-05', '07:00:00', 'Completed', 35000.00, 178, 356, 13, 3);
INSERT INTO public.appointment VALUES (179, '2025-02-16', '16:00:00', 'Completed', 35000.00, 179, 359, 163, 3);
INSERT INTO public.appointment VALUES (180, '2025-06-15', '13:00:00', 'Scheduled', 35000.00, 180, 360, 160, 3);
INSERT INTO public.appointment VALUES (181, '2025-06-18', '13:00:00', 'Scheduled', 10000.00, 181, 363, 106, 4);
INSERT INTO public.appointment VALUES (182, '2025-12-27', '13:00:00', 'Scheduled', 8000.00, 182, 365, 231, 1);
INSERT INTO public.appointment VALUES (183, '2025-05-02', '16:00:00', 'Completed', 10000.00, 183, 369, 44, 4);
INSERT INTO public.appointment VALUES (184, '2023-12-22', '07:00:00', 'Completed', 35000.00, 184, 370, 170, 3);
INSERT INTO public.appointment VALUES (185, '2025-12-16', '10:00:00', 'Scheduled', 8000.00, 185, 373, 208, 1);
INSERT INTO public.appointment VALUES (186, '2024-10-01', '13:00:00', 'Completed', 10000.00, 186, 374, 125, 4);
INSERT INTO public.appointment VALUES (187, '2024-10-31', '16:00:00', 'Completed', 35000.00, 187, 375, 144, 3);
INSERT INTO public.appointment VALUES (188, '2024-12-23', '07:00:00', 'Completed', 10000.00, 188, 376, 49, 4);
INSERT INTO public.appointment VALUES (189, '2025-09-18', '13:00:00', 'Scheduled', 10000.00, 189, 379, 112, 4);
INSERT INTO public.appointment VALUES (190, '2024-08-02', '07:00:00', 'Completed', 8000.00, 190, 380, 45, 1);
INSERT INTO public.appointment VALUES (191, '2025-02-09', '13:00:00', 'Completed', 10000.00, 191, 382, 88, 4);
INSERT INTO public.appointment VALUES (192, '2025-03-26', '13:00:00', 'Completed', 15000.00, 192, 384, 64, 2);
INSERT INTO public.appointment VALUES (193, '2024-03-04', '10:00:00', 'Completed', 35000.00, 193, 385, 192, 3);
INSERT INTO public.appointment VALUES (194, '2025-06-05', '10:00:00', 'Scheduled', 15000.00, 194, 386, 9, 2);
INSERT INTO public.appointment VALUES (195, '2025-10-17', '16:00:00', 'Scheduled', 10000.00, 195, 389, 199, 4);
INSERT INTO public.appointment VALUES (196, '2024-10-11', '07:00:00', 'Completed', 8000.00, 196, 391, 100, 1);
INSERT INTO public.appointment VALUES (197, '2025-10-04', '13:00:00', 'Scheduled', 15000.00, 197, 392, 203, 2);
INSERT INTO public.appointment VALUES (198, '2023-05-29', '10:00:00', 'Cancelled', 15000.00, 198, 393, 140, 2);
INSERT INTO public.appointment VALUES (199, '2025-09-15', '16:00:00', 'Scheduled', 10000.00, 199, 394, 207, 4);
INSERT INTO public.appointment VALUES (200, '2025-06-23', '10:00:00', 'Scheduled', 35000.00, 200, 396, 23, 3);
INSERT INTO public.appointment VALUES (201, '2025-07-27', '10:00:00', 'Scheduled', 8000.00, 201, 397, 136, 1);
INSERT INTO public.appointment VALUES (202, '2025-08-22', '13:00:00', 'Scheduled', 15000.00, 202, 400, 220, 2);
INSERT INTO public.appointment VALUES (203, '2024-08-19', '07:00:00', 'Completed', 10000.00, 203, 401, 71, 4);
INSERT INTO public.appointment VALUES (204, '2025-10-16', '13:00:00', 'Scheduled', 10000.00, 204, 402, 116, 4);
INSERT INTO public.appointment VALUES (205, '2024-04-22', '13:00:00', 'Completed', 10000.00, 205, 403, 196, 4);
INSERT INTO public.appointment VALUES (206, '2025-07-12', '16:00:00', 'Scheduled', 10000.00, 206, 405, 189, 4);
INSERT INTO public.appointment VALUES (207, '2024-09-28', '16:00:00', 'Completed', 8000.00, 207, 409, 53, 1);
INSERT INTO public.appointment VALUES (208, '2025-02-28', '16:00:00', 'Completed', 35000.00, 208, 410, 76, 3);
INSERT INTO public.appointment VALUES (209, '2024-12-26', '07:00:00', 'Completed', 15000.00, 209, 412, 14, 2);
INSERT INTO public.appointment VALUES (210, '2025-05-26', '13:00:00', 'Scheduled', 8000.00, 210, 413, 102, 1);
INSERT INTO public.appointment VALUES (211, '2025-05-17', '13:00:00', 'Scheduled', 15000.00, 211, 415, 221, 2);
INSERT INTO public.appointment VALUES (212, '2024-11-16', '10:00:00', 'Completed', 10000.00, 212, 417, 181, 4);
INSERT INTO public.appointment VALUES (213, '2025-12-11', '13:00:00', 'Scheduled', 15000.00, 213, 418, 100, 2);
INSERT INTO public.appointment VALUES (214, '2024-11-07', '07:00:00', 'Completed', 8000.00, 214, 419, 204, 1);
INSERT INTO public.appointment VALUES (215, '2025-08-16', '10:00:00', 'Scheduled', 35000.00, 215, 422, 170, 3);
INSERT INTO public.appointment VALUES (216, '2025-06-28', '16:00:00', 'Scheduled', 15000.00, 216, 423, 100, 2);
INSERT INTO public.appointment VALUES (217, '2025-08-20', '16:00:00', 'Scheduled', 10000.00, 217, 426, 179, 4);
INSERT INTO public.appointment VALUES (218, '2025-02-18', '16:00:00', 'Cancelled', 35000.00, 218, 428, 100, 3);
INSERT INTO public.appointment VALUES (219, '2025-02-15', '13:00:00', 'Completed', 8000.00, 219, 431, 232, 1);
INSERT INTO public.appointment VALUES (220, '2024-12-01', '16:00:00', 'Completed', 10000.00, 220, 434, 100, 4);
INSERT INTO public.appointment VALUES (221, '2025-06-26', '07:00:00', 'Scheduled', 35000.00, 221, 435, 28, 3);
INSERT INTO public.appointment VALUES (222, '2025-08-07', '16:00:00', 'Scheduled', 10000.00, 222, 437, 179, 4);
INSERT INTO public.appointment VALUES (223, '2024-11-16', '07:00:00', 'Completed', 15000.00, 223, 439, 52, 2);
INSERT INTO public.appointment VALUES (224, '2025-03-14', '10:00:00', 'Completed', 10000.00, 224, 441, 243, 4);
INSERT INTO public.appointment VALUES (225, '2024-02-14', '07:00:00', 'Completed', 15000.00, 225, 444, 70, 2);
INSERT INTO public.appointment VALUES (226, '2025-05-31', '16:00:00', 'Scheduled', 8000.00, 226, 446, 15, 1);
INSERT INTO public.appointment VALUES (227, '2025-02-07', '10:00:00', 'Completed', 15000.00, 227, 448, 81, 2);
INSERT INTO public.appointment VALUES (228, '2025-11-27', '16:00:00', 'Scheduled', 10000.00, 228, 451, 117, 4);
INSERT INTO public.appointment VALUES (229, '2025-02-11', '07:00:00', 'Completed', 8000.00, 229, 452, 39, 1);
INSERT INTO public.appointment VALUES (230, '2025-10-20', '16:00:00', 'Scheduled', 8000.00, 230, 455, 23, 1);
INSERT INTO public.appointment VALUES (231, '2025-08-24', '07:00:00', 'Scheduled', 15000.00, 231, 456, 109, 2);
INSERT INTO public.appointment VALUES (232, '2025-08-23', '10:00:00', 'Scheduled', 8000.00, 232, 459, 157, 1);
INSERT INTO public.appointment VALUES (233, '2024-08-21', '07:00:00', 'Completed', 10000.00, 233, 460, 143, 4);
INSERT INTO public.appointment VALUES (234, '2025-11-26', '07:00:00', 'Scheduled', 15000.00, 234, 462, 223, 2);
INSERT INTO public.appointment VALUES (235, '2025-04-11', '13:00:00', 'Completed', 15000.00, 235, 465, 242, 2);
INSERT INTO public.appointment VALUES (236, '2025-11-12', '16:00:00', 'Scheduled', 10000.00, 236, 467, 93, 4);
INSERT INTO public.appointment VALUES (237, '2025-07-02', '10:00:00', 'Scheduled', 8000.00, 237, 469, 7, 1);
INSERT INTO public.appointment VALUES (238, '2025-05-21', '10:00:00', 'Scheduled', 10000.00, 238, 471, 214, 4);
INSERT INTO public.appointment VALUES (239, '2024-12-23', '13:00:00', 'Completed', 35000.00, 239, 474, 52, 3);
INSERT INTO public.appointment VALUES (240, '2024-02-21', '13:00:00', 'Completed', 35000.00, 240, 478, 170, 3);
INSERT INTO public.appointment VALUES (241, '2024-10-27', '13:00:00', 'Completed', 35000.00, 241, 481, 233, 3);
INSERT INTO public.appointment VALUES (242, '2025-12-17', '10:00:00', 'Scheduled', 10000.00, 242, 484, 139, 4);
INSERT INTO public.appointment VALUES (243, '2025-10-09', '13:00:00', 'Scheduled', 10000.00, 243, 486, 107, 4);
INSERT INTO public.appointment VALUES (244, '2024-12-25', '16:00:00', 'Completed', 35000.00, 244, 487, 200, 3);
INSERT INTO public.appointment VALUES (245, '2024-08-15', '13:00:00', 'Completed', 15000.00, 245, 488, 209, 2);
INSERT INTO public.appointment VALUES (246, '2024-10-09', '10:00:00', 'Completed', 15000.00, 246, 489, 40, 2);
INSERT INTO public.appointment VALUES (247, '2024-07-21', '10:00:00', 'Completed', 8000.00, 247, 490, 111, 1);
INSERT INTO public.appointment VALUES (248, '2025-08-30', '10:00:00', 'Scheduled', 8000.00, 248, 492, 29, 1);
INSERT INTO public.appointment VALUES (249, '2024-07-02', '07:00:00', 'Completed', 15000.00, 249, 495, 77, 2);
INSERT INTO public.appointment VALUES (250, '2025-07-07', '13:00:00', 'Scheduled', 15000.00, 250, 498, 228, 2);
INSERT INTO public.appointment VALUES (251, '2025-07-17', '10:00:00', 'Scheduled', 8000.00, 251, 499, 82, 1);
INSERT INTO public.appointment VALUES (252, '2025-05-11', '07:00:00', 'Completed', 8000.00, 252, 500, 60, 1);
INSERT INTO public.appointment VALUES (253, '2025-03-07', '13:00:00', 'Completed', 10000.00, 253, 501, 17, 4);
INSERT INTO public.appointment VALUES (254, '2024-09-10', '07:00:00', 'Completed', 8000.00, 254, 504, 82, 1);
INSERT INTO public.appointment VALUES (255, '2024-09-12', '07:00:00', 'Cancelled', 10000.00, 255, 506, 148, 4);
INSERT INTO public.appointment VALUES (256, '2025-04-08', '10:00:00', 'Cancelled', 35000.00, 256, 507, 4, 3);
INSERT INTO public.appointment VALUES (257, '2024-07-14', '16:00:00', 'Completed', 8000.00, 257, 509, 201, 1);
INSERT INTO public.appointment VALUES (258, '2025-03-29', '10:00:00', 'Completed', 8000.00, 258, 512, 77, 1);
INSERT INTO public.appointment VALUES (259, '2025-03-09', '13:00:00', 'Completed', 15000.00, 259, 515, 179, 2);
INSERT INTO public.appointment VALUES (260, '2025-10-20', '07:00:00', 'Scheduled', 8000.00, 260, 519, 47, 1);
INSERT INTO public.appointment VALUES (261, '2025-01-21', '07:00:00', 'Cancelled', 10000.00, 261, 521, 117, 4);
INSERT INTO public.appointment VALUES (262, '2024-03-06', '07:00:00', 'Completed', 10000.00, 262, 522, 67, 4);
INSERT INTO public.appointment VALUES (263, '2025-04-04', '13:00:00', 'Completed', 10000.00, 263, 524, 53, 4);
INSERT INTO public.appointment VALUES (264, '2025-09-02', '16:00:00', 'Scheduled', 8000.00, 264, 527, 90, 1);
INSERT INTO public.appointment VALUES (265, '2024-12-28', '13:00:00', 'Cancelled', 8000.00, 265, 530, 193, 1);
INSERT INTO public.appointment VALUES (266, '2024-02-28', '16:00:00', 'Cancelled', 35000.00, 266, 531, 108, 3);
INSERT INTO public.appointment VALUES (267, '2025-12-16', '10:00:00', 'Scheduled', 8000.00, 267, 532, 193, 1);
INSERT INTO public.appointment VALUES (268, '2025-10-28', '16:00:00', 'Scheduled', 15000.00, 268, 534, 84, 2);
INSERT INTO public.appointment VALUES (269, '2024-10-04', '13:00:00', 'Completed', 8000.00, 269, 538, 105, 1);
INSERT INTO public.appointment VALUES (270, '2024-12-10', '10:00:00', 'Completed', 15000.00, 270, 540, 22, 2);
INSERT INTO public.appointment VALUES (271, '2025-11-27', '10:00:00', 'Scheduled', 10000.00, 271, 541, 94, 4);
INSERT INTO public.appointment VALUES (272, '2025-04-07', '13:00:00', 'Cancelled', 15000.00, 272, 544, 229, 2);
INSERT INTO public.appointment VALUES (273, '2024-09-27', '13:00:00', 'Completed', 15000.00, 273, 547, 2, 2);
INSERT INTO public.appointment VALUES (274, '2025-08-22', '16:00:00', 'Scheduled', 35000.00, 274, 550, 142, 3);
INSERT INTO public.appointment VALUES (275, '2025-12-11', '16:00:00', 'Scheduled', 10000.00, 275, 551, 202, 4);
INSERT INTO public.appointment VALUES (276, '2024-09-12', '13:00:00', 'Completed', 10000.00, 276, 554, 170, 4);
INSERT INTO public.appointment VALUES (277, '2024-03-01', '07:00:00', 'Cancelled', 10000.00, 277, 555, 216, 4);
INSERT INTO public.appointment VALUES (278, '2025-02-28', '07:00:00', 'Completed', 8000.00, 278, 557, 37, 1);
INSERT INTO public.appointment VALUES (279, '2024-02-25', '10:00:00', 'Cancelled', 10000.00, 279, 559, 75, 4);
INSERT INTO public.appointment VALUES (280, '2025-11-01', '16:00:00', 'Scheduled', 10000.00, 280, 561, 63, 4);
INSERT INTO public.appointment VALUES (281, '2024-09-11', '16:00:00', 'Cancelled', 15000.00, 281, 564, 132, 2);
INSERT INTO public.appointment VALUES (282, '2025-07-07', '16:00:00', 'Scheduled', 15000.00, 282, 567, 205, 2);
INSERT INTO public.appointment VALUES (283, '2025-05-28', '07:00:00', 'Scheduled', 8000.00, 283, 568, 182, 1);
INSERT INTO public.appointment VALUES (284, '2025-12-05', '07:00:00', 'Scheduled', 10000.00, 284, 569, 56, 4);
INSERT INTO public.appointment VALUES (285, '2024-12-21', '16:00:00', 'Completed', 35000.00, 285, 571, 69, 3);
INSERT INTO public.appointment VALUES (286, '2025-08-31', '13:00:00', 'Scheduled', 15000.00, 286, 573, 214, 2);
INSERT INTO public.appointment VALUES (287, '2025-06-06', '07:00:00', 'Scheduled', 15000.00, 287, 575, 119, 2);
INSERT INTO public.appointment VALUES (288, '2025-07-12', '07:00:00', 'Scheduled', 15000.00, 288, 576, 99, 2);
INSERT INTO public.appointment VALUES (289, '2025-10-30', '16:00:00', 'Scheduled', 8000.00, 289, 579, 196, 1);
INSERT INTO public.appointment VALUES (290, '2025-09-15', '13:00:00', 'Scheduled', 10000.00, 290, 582, 242, 4);
INSERT INTO public.appointment VALUES (291, '2025-07-19', '16:00:00', 'Scheduled', 15000.00, 291, 583, 18, 2);
INSERT INTO public.appointment VALUES (292, '2025-11-20', '07:00:00', 'Scheduled', 10000.00, 292, 584, 200, 4);
INSERT INTO public.appointment VALUES (293, '2025-12-22', '13:00:00', 'Scheduled', 35000.00, 293, 585, 151, 3);
INSERT INTO public.appointment VALUES (294, '2025-04-29', '07:00:00', 'Completed', 35000.00, 294, 586, 25, 3);
INSERT INTO public.appointment VALUES (295, '2025-11-21', '13:00:00', 'Scheduled', 35000.00, 295, 588, 88, 3);
INSERT INTO public.appointment VALUES (296, '2024-04-04', '13:00:00', 'Completed', 10000.00, 296, 589, 227, 4);
INSERT INTO public.appointment VALUES (297, '2025-11-10', '10:00:00', 'Scheduled', 35000.00, 297, 591, 193, 3);
INSERT INTO public.appointment VALUES (298, '2024-09-16', '13:00:00', 'Completed', 15000.00, 298, 593, 45, 2);
INSERT INTO public.appointment VALUES (299, '2025-01-28', '13:00:00', 'Completed', 10000.00, 299, 598, 76, 4);
INSERT INTO public.appointment VALUES (300, '2025-11-22', '16:00:00', 'Scheduled', 10000.00, 300, 600, 164, 4);
INSERT INTO public.appointment VALUES (301, '2025-08-01', '16:00:00', 'Scheduled', 35000.00, 301, 602, 185, 3);
INSERT INTO public.appointment VALUES (302, '2025-07-22', '16:00:00', 'Scheduled', 35000.00, 302, 604, 174, 3);
INSERT INTO public.appointment VALUES (303, '2025-05-24', '10:00:00', 'Scheduled', 15000.00, 303, 606, 110, 2);
INSERT INTO public.appointment VALUES (304, '2024-09-04', '07:00:00', 'Cancelled', 10000.00, 304, 607, 141, 4);
INSERT INTO public.appointment VALUES (305, '2025-05-30', '16:00:00', 'Scheduled', 15000.00, 305, 609, 3, 2);
INSERT INTO public.appointment VALUES (306, '2023-09-21', '10:00:00', 'Completed', 8000.00, 306, 612, 119, 1);
INSERT INTO public.appointment VALUES (307, '2024-12-11', '07:00:00', 'Completed', 10000.00, 307, 614, 40, 4);
INSERT INTO public.appointment VALUES (308, '2024-02-23', '13:00:00', 'Cancelled', 15000.00, 308, 615, 207, 2);
INSERT INTO public.appointment VALUES (309, '2025-12-23', '16:00:00', 'Scheduled', 35000.00, 309, 618, 215, 3);
INSERT INTO public.appointment VALUES (310, '2025-12-10', '10:00:00', 'Scheduled', 8000.00, 310, 619, 39, 1);
INSERT INTO public.appointment VALUES (311, '2025-09-26', '16:00:00', 'Scheduled', 10000.00, 311, 622, 43, 4);
INSERT INTO public.appointment VALUES (312, '2025-05-21', '10:00:00', 'Scheduled', 15000.00, 312, 623, 234, 2);
INSERT INTO public.appointment VALUES (313, '2023-12-15', '13:00:00', 'Completed', 8000.00, 313, 626, 100, 1);
INSERT INTO public.appointment VALUES (314, '2024-08-10', '07:00:00', 'Completed', 10000.00, 314, 629, 46, 4);
INSERT INTO public.appointment VALUES (315, '2023-08-23', '13:00:00', 'Cancelled', 35000.00, 315, 631, 161, 3);
INSERT INTO public.appointment VALUES (316, '2025-05-18', '07:00:00', 'Scheduled', 10000.00, 316, 635, 142, 4);
INSERT INTO public.appointment VALUES (317, '2025-04-16', '10:00:00', 'Cancelled', 10000.00, 317, 637, 175, 4);
INSERT INTO public.appointment VALUES (318, '2024-10-25', '10:00:00', 'Cancelled', 10000.00, 318, 640, 9, 4);
INSERT INTO public.appointment VALUES (319, '2024-01-18', '13:00:00', 'Completed', 10000.00, 319, 643, 132, 4);
INSERT INTO public.appointment VALUES (320, '2024-08-09', '13:00:00', 'Completed', 15000.00, 320, 644, 92, 2);
INSERT INTO public.appointment VALUES (321, '2025-06-14', '07:00:00', 'Scheduled', 10000.00, 321, 646, 101, 4);
INSERT INTO public.appointment VALUES (322, '2025-01-09', '10:00:00', 'Completed', 35000.00, 322, 648, 114, 3);
INSERT INTO public.appointment VALUES (323, '2025-03-23', '16:00:00', 'Completed', 15000.00, 323, 650, 27, 2);
INSERT INTO public.appointment VALUES (324, '2024-07-31', '13:00:00', 'Completed', 35000.00, 324, 652, 194, 3);
INSERT INTO public.appointment VALUES (325, '2024-08-05', '07:00:00', 'Completed', 15000.00, 325, 654, 144, 2);
INSERT INTO public.appointment VALUES (326, '2025-02-09', '07:00:00', 'Completed', 15000.00, 326, 657, 213, 2);
INSERT INTO public.appointment VALUES (327, '2025-08-27', '16:00:00', 'Scheduled', 8000.00, 327, 659, 110, 1);
INSERT INTO public.appointment VALUES (328, '2025-07-22', '10:00:00', 'Scheduled', 35000.00, 328, 660, 129, 3);
INSERT INTO public.appointment VALUES (329, '2025-05-18', '13:00:00', 'Scheduled', 35000.00, 329, 662, 126, 3);
INSERT INTO public.appointment VALUES (330, '2024-11-12', '07:00:00', 'Completed', 35000.00, 330, 663, 148, 3);
INSERT INTO public.appointment VALUES (331, '2023-10-25', '10:00:00', 'Completed', 35000.00, 331, 669, 164, 3);
INSERT INTO public.appointment VALUES (332, '2024-07-21', '13:00:00', 'Completed', 35000.00, 332, 671, 5, 3);
INSERT INTO public.appointment VALUES (333, '2025-12-30', '10:00:00', 'Scheduled', 8000.00, 333, 673, 160, 1);
INSERT INTO public.appointment VALUES (334, '2025-05-24', '07:00:00', 'Scheduled', 15000.00, 334, 674, 73, 2);
INSERT INTO public.appointment VALUES (335, '2025-12-03', '16:00:00', 'Scheduled', 35000.00, 335, 675, 205, 3);
INSERT INTO public.appointment VALUES (336, '2025-06-21', '13:00:00', 'Scheduled', 8000.00, 336, 678, 62, 1);
INSERT INTO public.appointment VALUES (337, '2025-12-19', '10:00:00', 'Scheduled', 10000.00, 337, 682, 10, 4);
INSERT INTO public.appointment VALUES (338, '2025-06-21', '10:00:00', 'Scheduled', 8000.00, 338, 683, 138, 1);
INSERT INTO public.appointment VALUES (339, '2025-06-03', '13:00:00', 'Scheduled', 8000.00, 339, 684, 237, 1);
INSERT INTO public.appointment VALUES (340, '2025-12-04', '16:00:00', 'Scheduled', 8000.00, 340, 685, 127, 1);
INSERT INTO public.appointment VALUES (341, '2025-08-05', '10:00:00', 'Scheduled', 35000.00, 341, 689, 58, 3);
INSERT INTO public.appointment VALUES (342, '2025-03-09', '10:00:00', 'Cancelled', 10000.00, 342, 692, 141, 4);
INSERT INTO public.appointment VALUES (343, '2025-09-07', '10:00:00', 'Scheduled', 8000.00, 343, 695, 13, 1);
INSERT INTO public.appointment VALUES (344, '2024-12-07', '07:00:00', 'Completed', 10000.00, 344, 697, 130, 4);
INSERT INTO public.appointment VALUES (345, '2025-07-31', '13:00:00', 'Scheduled', 10000.00, 345, 700, 62, 4);
INSERT INTO public.appointment VALUES (346, '2024-07-26', '16:00:00', 'Completed', 10000.00, 346, 702, 226, 4);
INSERT INTO public.appointment VALUES (347, '2025-04-19', '16:00:00', 'Cancelled', 35000.00, 347, 704, 12, 3);
INSERT INTO public.appointment VALUES (348, '2024-08-31', '10:00:00', 'Completed', 15000.00, 348, 705, 42, 2);
INSERT INTO public.appointment VALUES (349, '2025-02-08', '16:00:00', 'Completed', 10000.00, 349, 707, 150, 4);
INSERT INTO public.appointment VALUES (350, '2025-06-12', '16:00:00', 'Scheduled', 35000.00, 350, 709, 27, 3);
INSERT INTO public.appointment VALUES (351, '2025-11-21', '16:00:00', 'Scheduled', 10000.00, 351, 712, 194, 4);
INSERT INTO public.appointment VALUES (352, '2024-12-20', '13:00:00', 'Completed', 15000.00, 352, 714, 33, 2);
INSERT INTO public.appointment VALUES (353, '2024-11-21', '13:00:00', 'Completed', 10000.00, 353, 716, 125, 4);
INSERT INTO public.appointment VALUES (354, '2024-10-09', '16:00:00', 'Completed', 15000.00, 354, 719, 138, 2);
INSERT INTO public.appointment VALUES (355, '2024-09-26', '13:00:00', 'Cancelled', 10000.00, 355, 722, 94, 4);
INSERT INTO public.appointment VALUES (356, '2025-07-08', '16:00:00', 'Scheduled', 35000.00, 356, 723, 229, 3);
INSERT INTO public.appointment VALUES (357, '2024-04-18', '13:00:00', 'Completed', 35000.00, 357, 726, 242, 3);
INSERT INTO public.appointment VALUES (358, '2025-03-31', '07:00:00', 'Completed', 35000.00, 358, 729, 215, 3);
INSERT INTO public.appointment VALUES (359, '2025-08-08', '13:00:00', 'Scheduled', 10000.00, 359, 731, 98, 4);
INSERT INTO public.appointment VALUES (360, '2024-04-30', '13:00:00', 'Completed', 8000.00, 360, 732, 238, 1);
INSERT INTO public.appointment VALUES (361, '2025-09-03', '07:00:00', 'Scheduled', 8000.00, 361, 734, 3, 1);
INSERT INTO public.appointment VALUES (362, '2025-12-25', '16:00:00', 'Scheduled', 15000.00, 362, 736, 172, 2);
INSERT INTO public.appointment VALUES (363, '2024-09-16', '13:00:00', 'Completed', 10000.00, 363, 737, 193, 4);
INSERT INTO public.appointment VALUES (364, '2024-10-22', '16:00:00', 'Completed', 35000.00, 364, 738, 9, 3);
INSERT INTO public.appointment VALUES (365, '2024-09-25', '07:00:00', 'Completed', 8000.00, 365, 740, 201, 1);
INSERT INTO public.appointment VALUES (366, '2024-07-30', '07:00:00', 'Completed', 35000.00, 366, 742, 127, 3);
INSERT INTO public.appointment VALUES (367, '2024-09-14', '13:00:00', 'Completed', 15000.00, 367, 745, 114, 2);
INSERT INTO public.appointment VALUES (368, '2025-05-18', '16:00:00', 'Scheduled', 35000.00, 368, 746, 194, 3);
INSERT INTO public.appointment VALUES (369, '2025-07-30', '10:00:00', 'Scheduled', 10000.00, 369, 747, 175, 4);
INSERT INTO public.appointment VALUES (370, '2024-09-03', '16:00:00', 'Completed', 35000.00, 370, 748, 235, 3);
INSERT INTO public.appointment VALUES (371, '2025-01-12', '07:00:00', 'Completed', 35000.00, 371, 749, 62, 3);
INSERT INTO public.appointment VALUES (372, '2025-01-29', '16:00:00', 'Completed', 8000.00, 372, 752, 82, 1);
INSERT INTO public.appointment VALUES (373, '2025-05-01', '16:00:00', 'Completed', 10000.00, 373, 755, 165, 4);
INSERT INTO public.appointment VALUES (374, '2025-06-18', '10:00:00', 'Scheduled', 15000.00, 374, 756, 25, 2);
INSERT INTO public.appointment VALUES (375, '2025-01-19', '07:00:00', 'Completed', 35000.00, 375, 758, 186, 3);
INSERT INTO public.appointment VALUES (376, '2025-05-09', '13:00:00', 'Completed', 15000.00, 376, 760, 85, 2);
INSERT INTO public.appointment VALUES (377, '2025-09-19', '13:00:00', 'Scheduled', 8000.00, 377, 762, 110, 1);
INSERT INTO public.appointment VALUES (378, '2025-08-18', '07:00:00', 'Scheduled', 8000.00, 378, 764, 63, 1);
INSERT INTO public.appointment VALUES (379, '2025-11-22', '13:00:00', 'Scheduled', 35000.00, 379, 768, 85, 3);
INSERT INTO public.appointment VALUES (380, '2025-12-23', '13:00:00', 'Scheduled', 8000.00, 380, 769, 83, 1);
INSERT INTO public.appointment VALUES (381, '2025-02-17', '13:00:00', 'Completed', 15000.00, 381, 771, 227, 2);
INSERT INTO public.appointment VALUES (382, '2024-03-01', '16:00:00', 'Completed', 10000.00, 382, 773, 108, 4);
INSERT INTO public.appointment VALUES (383, '2024-04-20', '16:00:00', 'Cancelled', 15000.00, 383, 775, 32, 2);
INSERT INTO public.appointment VALUES (384, '2025-08-28', '07:00:00', 'Scheduled', 15000.00, 384, 778, 93, 2);
INSERT INTO public.appointment VALUES (385, '2025-05-27', '16:00:00', 'Scheduled', 15000.00, 385, 781, 104, 2);
INSERT INTO public.appointment VALUES (386, '2024-03-18', '16:00:00', 'Cancelled', 35000.00, 386, 784, 169, 3);
INSERT INTO public.appointment VALUES (387, '2024-05-05', '13:00:00', 'Completed', 35000.00, 387, 786, 25, 3);
INSERT INTO public.appointment VALUES (388, '2025-08-26', '10:00:00', 'Scheduled', 8000.00, 388, 788, 14, 1);
INSERT INTO public.appointment VALUES (389, '2025-06-30', '13:00:00', 'Scheduled', 8000.00, 389, 791, 28, 1);
INSERT INTO public.appointment VALUES (390, '2023-11-19', '07:00:00', 'Completed', 10000.00, 390, 794, 113, 4);
INSERT INTO public.appointment VALUES (391, '2025-04-20', '07:00:00', 'Completed', 35000.00, 391, 795, 89, 3);
INSERT INTO public.appointment VALUES (392, '2024-03-22', '07:00:00', 'Cancelled', 8000.00, 392, 796, 210, 1);
INSERT INTO public.appointment VALUES (393, '2023-09-02', '10:00:00', 'Completed', 8000.00, 393, 797, 82, 1);
INSERT INTO public.appointment VALUES (394, '2025-07-29', '10:00:00', 'Scheduled', 15000.00, 394, 799, 47, 2);
INSERT INTO public.appointment VALUES (395, '2024-03-09', '16:00:00', 'Completed', 15000.00, 395, 800, 223, 2);
INSERT INTO public.appointment VALUES (396, '2025-10-23', '07:00:00', 'Scheduled', 35000.00, 396, 801, 107, 3);
INSERT INTO public.appointment VALUES (397, '2025-04-06', '16:00:00', 'Completed', 35000.00, 397, 804, 26, 3);
INSERT INTO public.appointment VALUES (398, '2024-09-28', '16:00:00', 'Completed', 10000.00, 398, 807, 144, 4);
INSERT INTO public.appointment VALUES (399, '2024-06-10', '16:00:00', 'Completed', 8000.00, 399, 809, 67, 1);
INSERT INTO public.appointment VALUES (400, '2024-02-13', '07:00:00', 'Completed', 15000.00, 400, 812, 167, 2);
INSERT INTO public.appointment VALUES (401, '2024-11-07', '10:00:00', 'Completed', 10000.00, 401, 814, 72, 4);
INSERT INTO public.appointment VALUES (402, '2024-05-20', '07:00:00', 'Completed', 10000.00, 402, 817, 53, 4);
INSERT INTO public.appointment VALUES (403, '2024-08-16', '10:00:00', 'Completed', 35000.00, 403, 818, 202, 3);
INSERT INTO public.appointment VALUES (404, '2025-07-01', '07:00:00', 'Scheduled', 8000.00, 404, 820, 146, 1);
INSERT INTO public.appointment VALUES (405, '2025-07-22', '10:00:00', 'Scheduled', 10000.00, 405, 821, 177, 4);
INSERT INTO public.appointment VALUES (406, '2025-03-22', '07:00:00', 'Completed', 15000.00, 406, 822, 21, 2);
INSERT INTO public.appointment VALUES (407, '2025-08-11', '13:00:00', 'Scheduled', 15000.00, 407, 823, 208, 2);
INSERT INTO public.appointment VALUES (408, '2025-04-08', '16:00:00', 'Completed', 8000.00, 408, 825, 20, 1);
INSERT INTO public.appointment VALUES (409, '2025-10-20', '07:00:00', 'Scheduled', 10000.00, 409, 826, 129, 4);
INSERT INTO public.appointment VALUES (410, '2025-05-31', '13:00:00', 'Scheduled', 8000.00, 410, 827, 198, 1);
INSERT INTO public.appointment VALUES (411, '2025-07-02', '07:00:00', 'Scheduled', 15000.00, 411, 828, 109, 2);
INSERT INTO public.appointment VALUES (412, '2025-08-16', '16:00:00', 'Scheduled', 8000.00, 412, 831, 125, 1);
INSERT INTO public.appointment VALUES (413, '2025-06-01', '10:00:00', 'Scheduled', 10000.00, 413, 833, 217, 4);
INSERT INTO public.appointment VALUES (414, '2024-03-16', '10:00:00', 'Completed', 10000.00, 414, 834, 142, 4);
INSERT INTO public.appointment VALUES (415, '2025-11-06', '10:00:00', 'Scheduled', 8000.00, 415, 837, 168, 1);
INSERT INTO public.appointment VALUES (416, '2025-12-08', '13:00:00', 'Scheduled', 10000.00, 416, 839, 136, 4);
INSERT INTO public.appointment VALUES (417, '2025-09-01', '07:00:00', 'Scheduled', 10000.00, 417, 840, 209, 4);
INSERT INTO public.appointment VALUES (418, '2025-09-11', '16:00:00', 'Scheduled', 35000.00, 418, 842, 49, 3);
INSERT INTO public.appointment VALUES (419, '2025-08-21', '07:00:00', 'Scheduled', 8000.00, 419, 844, 243, 1);
INSERT INTO public.appointment VALUES (420, '2024-03-11', '10:00:00', 'Completed', 15000.00, 420, 846, 199, 2);
INSERT INTO public.appointment VALUES (421, '2024-09-08', '16:00:00', 'Cancelled', 10000.00, 421, 849, 153, 4);
INSERT INTO public.appointment VALUES (422, '2025-06-14', '10:00:00', 'Scheduled', 35000.00, 422, 851, 134, 3);
INSERT INTO public.appointment VALUES (423, '2025-10-26', '16:00:00', 'Scheduled', 10000.00, 423, 852, 126, 4);
INSERT INTO public.appointment VALUES (424, '2025-09-23', '13:00:00', 'Scheduled', 35000.00, 424, 853, 152, 3);
INSERT INTO public.appointment VALUES (425, '2025-07-19', '07:00:00', 'Scheduled', 8000.00, 425, 854, 97, 1);
INSERT INTO public.appointment VALUES (426, '2024-11-19', '16:00:00', 'Completed', 8000.00, 426, 856, 90, 1);
INSERT INTO public.appointment VALUES (427, '2025-03-15', '10:00:00', 'Cancelled', 15000.00, 427, 857, 217, 2);
INSERT INTO public.appointment VALUES (428, '2025-10-18', '07:00:00', 'Scheduled', 35000.00, 428, 859, 4, 3);
INSERT INTO public.appointment VALUES (429, '2023-06-29', '07:00:00', 'Completed', 10000.00, 429, 861, 31, 4);
INSERT INTO public.appointment VALUES (430, '2024-06-26', '16:00:00', 'Completed', 10000.00, 430, 863, 219, 4);
INSERT INTO public.appointment VALUES (431, '2025-12-22', '07:00:00', 'Scheduled', 35000.00, 431, 864, 118, 3);
INSERT INTO public.appointment VALUES (432, '2025-03-19', '10:00:00', 'Completed', 15000.00, 432, 866, 68, 2);
INSERT INTO public.appointment VALUES (433, '2025-10-30', '16:00:00', 'Scheduled', 35000.00, 433, 867, 131, 3);
INSERT INTO public.appointment VALUES (434, '2025-12-07', '13:00:00', 'Scheduled', 35000.00, 434, 869, 173, 3);
INSERT INTO public.appointment VALUES (435, '2024-12-15', '13:00:00', 'Cancelled', 8000.00, 435, 872, 7, 1);
INSERT INTO public.appointment VALUES (436, '2024-06-25', '07:00:00', 'Completed', 8000.00, 436, 875, 48, 1);
INSERT INTO public.appointment VALUES (437, '2024-11-27', '16:00:00', 'Completed', 15000.00, 437, 877, 75, 2);
INSERT INTO public.appointment VALUES (438, '2024-10-27', '13:00:00', 'Completed', 35000.00, 438, 881, 204, 3);
INSERT INTO public.appointment VALUES (439, '2024-05-24', '07:00:00', 'Cancelled', 10000.00, 439, 883, 22, 4);
INSERT INTO public.appointment VALUES (440, '2025-12-04', '13:00:00', 'Scheduled', 8000.00, 440, 884, 21, 1);
INSERT INTO public.appointment VALUES (441, '2025-12-04', '10:00:00', 'Scheduled', 8000.00, 441, 887, 81, 1);
INSERT INTO public.appointment VALUES (442, '2025-08-13', '10:00:00', 'Scheduled', 15000.00, 442, 889, 18, 2);
INSERT INTO public.appointment VALUES (443, '2024-11-16', '13:00:00', 'Completed', 8000.00, 443, 890, 56, 1);
INSERT INTO public.appointment VALUES (444, '2024-08-03', '07:00:00', 'Completed', 10000.00, 444, 891, 185, 4);
INSERT INTO public.appointment VALUES (445, '2025-01-15', '16:00:00', 'Completed', 10000.00, 445, 892, 37, 4);
INSERT INTO public.appointment VALUES (446, '2025-10-27', '16:00:00', 'Scheduled', 8000.00, 446, 893, 238, 1);
INSERT INTO public.appointment VALUES (447, '2024-10-06', '07:00:00', 'Completed', 8000.00, 447, 895, 15, 1);
INSERT INTO public.appointment VALUES (448, '2025-12-06', '10:00:00', 'Scheduled', 8000.00, 448, 896, 183, 1);
INSERT INTO public.appointment VALUES (449, '2024-02-22', '07:00:00', 'Completed', 15000.00, 449, 901, 14, 2);
INSERT INTO public.appointment VALUES (450, '2025-07-03', '16:00:00', 'Scheduled', 10000.00, 450, 902, 94, 4);
INSERT INTO public.appointment VALUES (451, '2025-10-25', '07:00:00', 'Scheduled', 8000.00, 451, 903, 150, 1);
INSERT INTO public.appointment VALUES (452, '2024-10-25', '16:00:00', 'Completed', 15000.00, 452, 904, 226, 2);
INSERT INTO public.appointment VALUES (453, '2024-08-21', '07:00:00', 'Completed', 8000.00, 453, 906, 28, 1);
INSERT INTO public.appointment VALUES (454, '2025-04-11', '13:00:00', 'Completed', 35000.00, 454, 908, 69, 3);
INSERT INTO public.appointment VALUES (455, '2025-02-23', '07:00:00', 'Completed', 8000.00, 455, 910, 29, 1);
INSERT INTO public.appointment VALUES (456, '2024-08-08', '10:00:00', 'Completed', 35000.00, 456, 911, 99, 3);
INSERT INTO public.appointment VALUES (457, '2024-03-06', '16:00:00', 'Cancelled', 35000.00, 457, 913, 11, 3);
INSERT INTO public.appointment VALUES (458, '2025-03-19', '13:00:00', 'Completed', 10000.00, 458, 917, 115, 4);
INSERT INTO public.appointment VALUES (459, '2024-02-07', '16:00:00', 'Completed', 8000.00, 459, 920, 241, 1);
INSERT INTO public.appointment VALUES (460, '2025-03-03', '07:00:00', 'Cancelled', 10000.00, 460, 924, 149, 4);
INSERT INTO public.appointment VALUES (461, '2025-01-08', '16:00:00', 'Cancelled', 35000.00, 461, 925, 124, 3);
INSERT INTO public.appointment VALUES (462, '2025-08-24', '16:00:00', 'Scheduled', 15000.00, 462, 926, 126, 2);
INSERT INTO public.appointment VALUES (463, '2025-12-12', '16:00:00', 'Scheduled', 8000.00, 463, 929, 118, 1);
INSERT INTO public.appointment VALUES (464, '2025-07-05', '13:00:00', 'Scheduled', 10000.00, 464, 932, 51, 4);
INSERT INTO public.appointment VALUES (465, '2025-10-27', '16:00:00', 'Scheduled', 10000.00, 465, 933, 91, 4);
INSERT INTO public.appointment VALUES (466, '2025-09-19', '16:00:00', 'Scheduled', 8000.00, 466, 935, 39, 1);
INSERT INTO public.appointment VALUES (467, '2025-09-02', '13:00:00', 'Scheduled', 15000.00, 467, 937, 122, 2);
INSERT INTO public.appointment VALUES (468, '2025-12-18', '16:00:00', 'Scheduled', 8000.00, 468, 940, 56, 1);
INSERT INTO public.appointment VALUES (469, '2025-11-26', '07:00:00', 'Scheduled', 8000.00, 469, 943, 36, 1);
INSERT INTO public.appointment VALUES (470, '2025-11-16', '16:00:00', 'Scheduled', 10000.00, 470, 946, 158, 4);
INSERT INTO public.appointment VALUES (471, '2024-10-11', '10:00:00', 'Completed', 10000.00, 471, 950, 237, 4);
INSERT INTO public.appointment VALUES (472, '2024-12-29', '10:00:00', 'Completed', 35000.00, 472, 951, 237, 3);
INSERT INTO public.appointment VALUES (473, '2025-03-30', '10:00:00', 'Completed', 35000.00, 473, 952, 84, 3);
INSERT INTO public.appointment VALUES (474, '2025-05-17', '13:00:00', 'Scheduled', 8000.00, 474, 954, 239, 1);
INSERT INTO public.appointment VALUES (475, '2025-07-26', '16:00:00', 'Scheduled', 35000.00, 475, 955, 102, 3);
INSERT INTO public.appointment VALUES (476, '2025-11-11', '13:00:00', 'Scheduled', 8000.00, 476, 959, 231, 1);
INSERT INTO public.appointment VALUES (477, '2025-07-24', '16:00:00', 'Scheduled', 35000.00, 477, 961, 6, 3);
INSERT INTO public.appointment VALUES (478, '2025-09-13', '07:00:00', 'Scheduled', 8000.00, 478, 963, 142, 1);
INSERT INTO public.appointment VALUES (479, '2025-04-13', '10:00:00', 'Completed', 10000.00, 479, 964, 84, 4);
INSERT INTO public.appointment VALUES (480, '2025-11-05', '16:00:00', 'Scheduled', 15000.00, 480, 965, 136, 2);
INSERT INTO public.appointment VALUES (481, '2025-05-18', '07:00:00', 'Scheduled', 15000.00, 481, 969, 159, 2);
INSERT INTO public.appointment VALUES (482, '2025-08-21', '07:00:00', 'Scheduled', 8000.00, 482, 971, 194, 1);
INSERT INTO public.appointment VALUES (483, '2024-10-20', '07:00:00', 'Completed', 35000.00, 483, 972, 217, 3);
INSERT INTO public.appointment VALUES (484, '2025-01-08', '10:00:00', 'Completed', 8000.00, 484, 973, 76, 1);
INSERT INTO public.appointment VALUES (485, '2024-10-06', '13:00:00', 'Completed', 8000.00, 485, 975, 154, 1);
INSERT INTO public.appointment VALUES (486, '2025-07-17', '07:00:00', 'Scheduled', 10000.00, 486, 976, 206, 4);
INSERT INTO public.appointment VALUES (487, '2024-12-20', '10:00:00', 'Completed', 35000.00, 487, 977, 65, 3);
INSERT INTO public.appointment VALUES (488, '2025-03-26', '10:00:00', 'Completed', 35000.00, 488, 978, 20, 3);
INSERT INTO public.appointment VALUES (489, '2025-11-09', '13:00:00', 'Scheduled', 10000.00, 489, 980, 127, 4);
INSERT INTO public.appointment VALUES (490, '2024-03-23', '10:00:00', 'Cancelled', 10000.00, 490, 982, 32, 4);
INSERT INTO public.appointment VALUES (491, '2025-05-05', '10:00:00', 'Cancelled', 10000.00, 491, 983, 75, 4);
INSERT INTO public.appointment VALUES (492, '2025-10-01', '13:00:00', 'Scheduled', 35000.00, 492, 985, 180, 3);
INSERT INTO public.appointment VALUES (493, '2024-12-22', '13:00:00', 'Completed', 10000.00, 493, 988, 209, 4);
INSERT INTO public.appointment VALUES (494, '2023-12-23', '13:00:00', 'Completed', 8000.00, 494, 989, 61, 1);
INSERT INTO public.appointment VALUES (495, '2025-04-11', '16:00:00', 'Cancelled', 8000.00, 495, 990, 97, 1);
INSERT INTO public.appointment VALUES (496, '2025-09-11', '10:00:00', 'Scheduled', 35000.00, 496, 991, 220, 3);
INSERT INTO public.appointment VALUES (497, '2025-02-13', '07:00:00', 'Completed', 8000.00, 497, 992, 152, 1);
INSERT INTO public.appointment VALUES (498, '2025-04-07', '10:00:00', 'Cancelled', 15000.00, 498, 995, 119, 2);
INSERT INTO public.appointment VALUES (499, '2023-09-06', '07:00:00', 'Cancelled', 15000.00, 499, 998, 162, 2);
INSERT INTO public.appointment VALUES (500, '2025-08-27', '13:00:00', 'Scheduled', 15000.00, 500, 999, 49, 2);
INSERT INTO public.appointment VALUES (501, '2025-01-06', '10:00:00', 'Completed', 35000.00, 240, 478, 165, 3);
INSERT INTO public.appointment VALUES (502, '2025-05-08', '13:00:00', 'Cancelled', 10000.00, 368, 746, 196, 4);
INSERT INTO public.appointment VALUES (503, '2024-11-30', '10:00:00', 'Completed', 15000.00, 38, 74, 75, 2);
INSERT INTO public.appointment VALUES (504, '2025-08-01', '10:00:00', 'Scheduled', 10000.00, 441, 887, 235, 4);
INSERT INTO public.appointment VALUES (505, '2025-09-05', '13:00:00', 'Scheduled', 35000.00, 288, 577, 119, 3);
INSERT INTO public.appointment VALUES (506, '2025-12-02', '16:00:00', 'Scheduled', 35000.00, 341, 688, 208, 3);
INSERT INTO public.appointment VALUES (507, '2025-01-09', '07:00:00', 'Completed', 10000.00, 402, 817, 83, 4);
INSERT INTO public.appointment VALUES (508, '2024-10-03', '16:00:00', 'Completed', 35000.00, 402, 816, 238, 3);
INSERT INTO public.appointment VALUES (509, '2025-05-11', '16:00:00', 'Completed', 10000.00, 121, 239, 185, 4);
INSERT INTO public.appointment VALUES (510, '2025-06-25', '10:00:00', 'Scheduled', 35000.00, 113, 222, 12, 3);
INSERT INTO public.appointment VALUES (511, '2024-08-21', '07:00:00', 'Completed', 15000.00, 451, 903, 196, 2);
INSERT INTO public.appointment VALUES (512, '2025-03-27', '07:00:00', 'Completed', 10000.00, 71, 138, 63, 4);
INSERT INTO public.appointment VALUES (513, '2025-10-06', '07:00:00', 'Scheduled', 8000.00, 91, 175, 17, 1);
INSERT INTO public.appointment VALUES (514, '2025-01-21', '07:00:00', 'Completed', 15000.00, 319, 641, 10, 2);
INSERT INTO public.appointment VALUES (515, '2025-05-02', '07:00:00', 'Cancelled', 35000.00, 241, 481, 56, 3);
INSERT INTO public.appointment VALUES (516, '2025-04-30', '10:00:00', 'Completed', 8000.00, 34, 68, 64, 1);
INSERT INTO public.appointment VALUES (517, '2024-01-31', '16:00:00', 'Completed', 8000.00, 310, 620, 15, 1);
INSERT INTO public.appointment VALUES (518, '2024-10-12', '07:00:00', 'Completed', 8000.00, 398, 806, 241, 1);
INSERT INTO public.appointment VALUES (519, '2024-05-07', '13:00:00', 'Completed', 8000.00, 426, 856, 231, 1);
INSERT INTO public.appointment VALUES (520, '2025-12-05', '16:00:00', 'Scheduled', 10000.00, 488, 978, 72, 4);
INSERT INTO public.appointment VALUES (521, '2025-01-10', '13:00:00', 'Cancelled', 15000.00, 107, 211, 133, 2);
INSERT INTO public.appointment VALUES (522, '2025-08-06', '13:00:00', 'Scheduled', 15000.00, 76, 146, 176, 2);
INSERT INTO public.appointment VALUES (523, '2024-09-05', '16:00:00', 'Completed', 8000.00, 205, 404, 21, 1);
INSERT INTO public.appointment VALUES (524, '2024-06-08', '13:00:00', 'Completed', 15000.00, 37, 73, 194, 2);
INSERT INTO public.appointment VALUES (525, '2025-08-09', '10:00:00', 'Scheduled', 35000.00, 164, 334, 191, 3);
INSERT INTO public.appointment VALUES (526, '2025-01-06', '07:00:00', 'Completed', 15000.00, 473, 952, 25, 2);
INSERT INTO public.appointment VALUES (527, '2025-11-22', '13:00:00', 'Scheduled', 8000.00, 147, 296, 211, 1);
INSERT INTO public.appointment VALUES (528, '2025-03-25', '10:00:00', 'Completed', 35000.00, 133, 265, 68, 3);
INSERT INTO public.appointment VALUES (529, '2024-07-28', '07:00:00', 'Completed', 8000.00, 297, 591, 24, 1);
INSERT INTO public.appointment VALUES (530, '2025-01-20', '13:00:00', 'Completed', 10000.00, 116, 229, 168, 4);
INSERT INTO public.appointment VALUES (531, '2024-05-01', '07:00:00', 'Completed', 15000.00, 224, 440, 211, 2);
INSERT INTO public.appointment VALUES (532, '2025-02-15', '16:00:00', 'Completed', 15000.00, 402, 817, 122, 2);
INSERT INTO public.appointment VALUES (533, '2023-10-21', '07:00:00', 'Completed', 10000.00, 228, 449, 212, 4);
INSERT INTO public.appointment VALUES (534, '2025-05-17', '10:00:00', 'Scheduled', 35000.00, 244, 487, 89, 3);
INSERT INTO public.appointment VALUES (535, '2025-09-12', '07:00:00', 'Scheduled', 15000.00, 323, 650, 203, 2);
INSERT INTO public.appointment VALUES (536, '2025-01-05', '13:00:00', 'Completed', 15000.00, 188, 377, 67, 2);
INSERT INTO public.appointment VALUES (537, '2025-12-13', '16:00:00', 'Scheduled', 15000.00, 290, 582, 112, 2);
INSERT INTO public.appointment VALUES (538, '2025-02-15', '10:00:00', 'Completed', 15000.00, 365, 739, 24, 2);
INSERT INTO public.appointment VALUES (539, '2025-09-21', '13:00:00', 'Scheduled', 35000.00, 362, 736, 197, 3);
INSERT INTO public.appointment VALUES (540, '2024-01-12', '13:00:00', 'Completed', 15000.00, 322, 648, 92, 2);
INSERT INTO public.appointment VALUES (541, '2025-10-26', '10:00:00', 'Scheduled', 8000.00, 99, 193, 59, 1);
INSERT INTO public.appointment VALUES (542, '2024-05-23', '16:00:00', 'Completed', 8000.00, 437, 880, 126, 1);
INSERT INTO public.appointment VALUES (543, '2023-09-01', '16:00:00', 'Completed', 15000.00, 232, 457, 225, 2);
INSERT INTO public.appointment VALUES (544, '2023-12-14', '07:00:00', 'Completed', 35000.00, 59, 118, 175, 3);
INSERT INTO public.appointment VALUES (545, '2024-11-13', '10:00:00', 'Completed', 35000.00, 29, 59, 80, 3);
INSERT INTO public.appointment VALUES (546, '2025-10-22', '16:00:00', 'Scheduled', 8000.00, 367, 744, 79, 1);
INSERT INTO public.appointment VALUES (547, '2025-10-24', '10:00:00', 'Scheduled', 15000.00, 365, 740, 227, 2);
INSERT INTO public.appointment VALUES (548, '2023-11-21', '16:00:00', 'Completed', 8000.00, 208, 411, 121, 1);
INSERT INTO public.appointment VALUES (549, '2025-12-11', '13:00:00', 'Scheduled', 35000.00, 271, 542, 213, 3);
INSERT INTO public.appointment VALUES (550, '2025-08-09', '13:00:00', 'Scheduled', 15000.00, 60, 120, 110, 2);
INSERT INTO public.appointment VALUES (551, '2025-11-19', '07:00:00', 'Scheduled', 10000.00, 89, 171, 88, 4);
INSERT INTO public.appointment VALUES (552, '2023-11-25', '16:00:00', 'Completed', 15000.00, 41, 80, 19, 2);
INSERT INTO public.appointment VALUES (553, '2025-12-24', '07:00:00', 'Scheduled', 10000.00, 413, 833, 76, 4);
INSERT INTO public.appointment VALUES (554, '2025-09-18', '13:00:00', 'Scheduled', 8000.00, 119, 235, 163, 1);
INSERT INTO public.appointment VALUES (555, '2025-07-31', '10:00:00', 'Scheduled', 35000.00, 410, 827, 100, 3);
INSERT INTO public.appointment VALUES (556, '2024-05-07', '10:00:00', 'Completed', 10000.00, 272, 543, 70, 4);
INSERT INTO public.appointment VALUES (557, '2025-12-13', '13:00:00', 'Scheduled', 10000.00, 406, 822, 9, 4);
INSERT INTO public.appointment VALUES (558, '2025-02-27', '10:00:00', 'Completed', 15000.00, 216, 424, 145, 2);
INSERT INTO public.appointment VALUES (559, '2024-06-01', '13:00:00', 'Completed', 10000.00, 35, 69, 4, 4);
INSERT INTO public.appointment VALUES (560, '2023-12-11', '10:00:00', 'Completed', 10000.00, 317, 636, 142, 4);
INSERT INTO public.appointment VALUES (561, '2024-12-17', '10:00:00', 'Completed', 15000.00, 88, 169, 176, 2);
INSERT INTO public.appointment VALUES (562, '2025-10-05', '13:00:00', 'Scheduled', 15000.00, 113, 222, 54, 2);
INSERT INTO public.appointment VALUES (563, '2025-05-09', '13:00:00', 'Completed', 8000.00, 178, 358, 221, 1);
INSERT INTO public.appointment VALUES (564, '2025-03-14', '16:00:00', 'Completed', 8000.00, 405, 821, 104, 1);
INSERT INTO public.appointment VALUES (565, '2025-08-20', '10:00:00', 'Scheduled', 10000.00, 259, 516, 190, 4);
INSERT INTO public.appointment VALUES (566, '2024-09-04', '16:00:00', 'Completed', 35000.00, 17, 35, 83, 3);
INSERT INTO public.appointment VALUES (567, '2025-06-17', '13:00:00', 'Scheduled', 35000.00, 444, 891, 226, 3);
INSERT INTO public.appointment VALUES (568, '2025-10-17', '10:00:00', 'Scheduled', 35000.00, 84, 160, 58, 3);
INSERT INTO public.appointment VALUES (569, '2025-09-20', '13:00:00', 'Scheduled', 35000.00, 214, 419, 149, 3);
INSERT INTO public.appointment VALUES (570, '2025-04-11', '10:00:00', 'Completed', 35000.00, 231, 456, 206, 3);
INSERT INTO public.appointment VALUES (571, '2025-03-11', '10:00:00', 'Cancelled', 8000.00, 118, 233, 232, 1);
INSERT INTO public.appointment VALUES (572, '2024-03-15', '16:00:00', 'Cancelled', 10000.00, 85, 161, 87, 4);
INSERT INTO public.appointment VALUES (573, '2024-05-30', '13:00:00', 'Completed', 35000.00, 276, 553, 195, 3);
INSERT INTO public.appointment VALUES (574, '2025-12-31', '07:00:00', 'Scheduled', 8000.00, 32, 63, 193, 1);
INSERT INTO public.appointment VALUES (575, '2025-05-23', '16:00:00', 'Scheduled', 10000.00, 153, 309, 87, 4);
INSERT INTO public.appointment VALUES (576, '2024-12-04', '13:00:00', 'Completed', 15000.00, 27, 55, 206, 2);
INSERT INTO public.appointment VALUES (577, '2024-09-30', '16:00:00', 'Completed', 8000.00, 49, 98, 146, 1);
INSERT INTO public.appointment VALUES (578, '2025-04-29', '07:00:00', 'Cancelled', 10000.00, 303, 606, 231, 4);
INSERT INTO public.appointment VALUES (579, '2025-05-31', '13:00:00', 'Scheduled', 10000.00, 394, 799, 128, 4);
INSERT INTO public.appointment VALUES (580, '2025-05-01', '07:00:00', 'Completed', 35000.00, 134, 267, 238, 3);
INSERT INTO public.appointment VALUES (581, '2025-05-03', '13:00:00', 'Cancelled', 10000.00, 326, 657, 149, 4);
INSERT INTO public.appointment VALUES (582, '2025-11-17', '16:00:00', 'Scheduled', 10000.00, 358, 729, 203, 4);
INSERT INTO public.appointment VALUES (583, '2024-04-22', '16:00:00', 'Completed', 8000.00, 208, 411, 71, 1);
INSERT INTO public.appointment VALUES (584, '2024-11-20', '10:00:00', 'Completed', 10000.00, 158, 322, 26, 4);
INSERT INTO public.appointment VALUES (585, '2025-08-27', '10:00:00', 'Scheduled', 8000.00, 171, 346, 55, 1);
INSERT INTO public.appointment VALUES (586, '2025-09-12', '10:00:00', 'Scheduled', 8000.00, 42, 84, 176, 1);
INSERT INTO public.appointment VALUES (587, '2024-11-29', '07:00:00', 'Completed', 10000.00, 141, 285, 142, 4);
INSERT INTO public.appointment VALUES (588, '2025-05-26', '13:00:00', 'Scheduled', 8000.00, 245, 488, 103, 1);
INSERT INTO public.appointment VALUES (589, '2025-01-28', '13:00:00', 'Completed', 8000.00, 54, 109, 5, 1);
INSERT INTO public.appointment VALUES (590, '2025-04-22', '07:00:00', 'Completed', 10000.00, 399, 809, 52, 4);
INSERT INTO public.appointment VALUES (591, '2025-07-18', '10:00:00', 'Scheduled', 8000.00, 77, 148, 205, 1);
INSERT INTO public.appointment VALUES (592, '2025-05-02', '16:00:00', 'Cancelled', 15000.00, 255, 506, 197, 2);
INSERT INTO public.appointment VALUES (593, '2024-08-17', '13:00:00', 'Completed', 10000.00, 472, 951, 88, 4);
INSERT INTO public.appointment VALUES (594, '2024-11-21', '07:00:00', 'Completed', 35000.00, 17, 35, 239, 3);
INSERT INTO public.appointment VALUES (595, '2025-03-18', '16:00:00', 'Completed', 8000.00, 212, 417, 9, 1);
INSERT INTO public.appointment VALUES (596, '2025-11-23', '13:00:00', 'Scheduled', 15000.00, 234, 461, 23, 2);
INSERT INTO public.appointment VALUES (597, '2025-11-21', '07:00:00', 'Scheduled', 15000.00, 298, 594, 180, 2);
INSERT INTO public.appointment VALUES (598, '2025-02-01', '13:00:00', 'Completed', 8000.00, 386, 783, 189, 1);
INSERT INTO public.appointment VALUES (599, '2024-05-11', '16:00:00', 'Completed', 35000.00, 158, 322, 198, 3);
INSERT INTO public.appointment VALUES (600, '2025-01-21', '13:00:00', 'Completed', 8000.00, 12, 25, 226, 1);
INSERT INTO public.appointment VALUES (601, '2025-05-08', '16:00:00', 'Completed', 35000.00, 304, 608, 193, 3);
INSERT INTO public.appointment VALUES (602, '2024-10-19', '16:00:00', 'Completed', 10000.00, 479, 964, 100, 4);
INSERT INTO public.appointment VALUES (603, '2025-07-26', '10:00:00', 'Scheduled', 15000.00, 418, 843, 152, 2);
INSERT INTO public.appointment VALUES (604, '2025-11-26', '13:00:00', 'Scheduled', 15000.00, 327, 658, 214, 2);
INSERT INTO public.appointment VALUES (605, '2025-08-13', '10:00:00', 'Scheduled', 15000.00, 117, 232, 238, 2);
INSERT INTO public.appointment VALUES (606, '2024-11-16', '13:00:00', 'Cancelled', 35000.00, 355, 722, 132, 3);
INSERT INTO public.appointment VALUES (607, '2025-12-25', '07:00:00', 'Scheduled', 15000.00, 173, 349, 186, 2);
INSERT INTO public.appointment VALUES (608, '2024-12-20', '13:00:00', 'Completed', 35000.00, 232, 459, 37, 3);
INSERT INTO public.appointment VALUES (609, '2025-01-17', '10:00:00', 'Completed', 8000.00, 182, 366, 173, 1);
INSERT INTO public.appointment VALUES (610, '2025-11-19', '16:00:00', 'Scheduled', 8000.00, 202, 400, 109, 1);
INSERT INTO public.appointment VALUES (611, '2025-04-24', '13:00:00', 'Completed', 15000.00, 476, 959, 62, 2);
INSERT INTO public.appointment VALUES (612, '2024-09-13', '07:00:00', 'Completed', 15000.00, 468, 941, 91, 2);
INSERT INTO public.appointment VALUES (613, '2025-05-05', '16:00:00', 'Completed', 8000.00, 53, 108, 167, 1);
INSERT INTO public.appointment VALUES (614, '2024-05-07', '13:00:00', 'Cancelled', 8000.00, 443, 890, 110, 1);
INSERT INTO public.appointment VALUES (615, '2023-07-12', '13:00:00', 'Completed', 10000.00, 17, 35, 125, 4);
INSERT INTO public.appointment VALUES (616, '2025-07-07', '13:00:00', 'Scheduled', 10000.00, 465, 933, 219, 4);
INSERT INTO public.appointment VALUES (617, '2025-10-22', '10:00:00', 'Scheduled', 35000.00, 428, 859, 76, 3);
INSERT INTO public.appointment VALUES (618, '2024-04-10', '13:00:00', 'Completed', 8000.00, 53, 108, 152, 1);
INSERT INTO public.appointment VALUES (619, '2025-12-06', '10:00:00', 'Scheduled', 15000.00, 26, 54, 240, 2);
INSERT INTO public.appointment VALUES (620, '2025-08-23', '16:00:00', 'Scheduled', 15000.00, 451, 903, 200, 2);
INSERT INTO public.appointment VALUES (621, '2025-08-04', '16:00:00', 'Scheduled', 10000.00, 326, 657, 131, 4);
INSERT INTO public.appointment VALUES (622, '2025-05-26', '13:00:00', 'Scheduled', 15000.00, 415, 838, 199, 2);
INSERT INTO public.appointment VALUES (623, '2024-09-02', '13:00:00', 'Completed', 35000.00, 355, 721, 108, 3);
INSERT INTO public.appointment VALUES (624, '2025-02-01', '13:00:00', 'Completed', 35000.00, 223, 439, 205, 3);
INSERT INTO public.appointment VALUES (625, '2024-09-11', '13:00:00', 'Completed', 10000.00, 1, 2, 52, 4);
INSERT INTO public.appointment VALUES (626, '2025-05-03', '07:00:00', 'Completed', 10000.00, 93, 182, 97, 4);
INSERT INTO public.appointment VALUES (627, '2025-02-27', '10:00:00', 'Completed', 35000.00, 59, 117, 83, 3);
INSERT INTO public.appointment VALUES (628, '2024-09-27', '10:00:00', 'Completed', 35000.00, 355, 720, 217, 3);
INSERT INTO public.appointment VALUES (629, '2025-03-06', '13:00:00', 'Completed', 8000.00, 473, 952, 114, 1);
INSERT INTO public.appointment VALUES (630, '2025-04-27', '07:00:00', 'Completed', 35000.00, 44, 86, 192, 3);
INSERT INTO public.appointment VALUES (631, '2025-07-01', '16:00:00', 'Scheduled', 15000.00, 165, 337, 84, 2);
INSERT INTO public.appointment VALUES (632, '2024-07-30', '10:00:00', 'Completed', 10000.00, 101, 198, 123, 4);
INSERT INTO public.appointment VALUES (633, '2024-09-10', '10:00:00', 'Completed', 15000.00, 471, 948, 9, 2);
INSERT INTO public.appointment VALUES (634, '2024-09-06', '16:00:00', 'Completed', 35000.00, 130, 260, 11, 3);
INSERT INTO public.appointment VALUES (635, '2025-08-07', '10:00:00', 'Scheduled', 35000.00, 4, 9, 234, 3);
INSERT INTO public.appointment VALUES (636, '2025-06-22', '13:00:00', 'Scheduled', 10000.00, 288, 577, 19, 4);
INSERT INTO public.appointment VALUES (637, '2025-04-04', '07:00:00', 'Completed', 8000.00, 316, 632, 13, 1);
INSERT INTO public.appointment VALUES (638, '2025-10-26', '13:00:00', 'Scheduled', 15000.00, 243, 486, 57, 2);
INSERT INTO public.appointment VALUES (639, '2025-06-24', '16:00:00', 'Scheduled', 15000.00, 465, 933, 41, 2);
INSERT INTO public.appointment VALUES (640, '2025-07-15', '16:00:00', 'Scheduled', 15000.00, 173, 349, 162, 2);
INSERT INTO public.appointment VALUES (641, '2024-10-02', '07:00:00', 'Completed', 35000.00, 170, 344, 32, 3);
INSERT INTO public.appointment VALUES (642, '2025-02-19', '16:00:00', 'Completed', 10000.00, 59, 119, 18, 4);
INSERT INTO public.appointment VALUES (643, '2025-05-01', '07:00:00', 'Completed', 15000.00, 472, 951, 69, 2);
INSERT INTO public.appointment VALUES (644, '2024-06-08', '16:00:00', 'Completed', 8000.00, 349, 707, 112, 1);
INSERT INTO public.appointment VALUES (645, '2025-01-12', '07:00:00', 'Completed', 15000.00, 436, 875, 179, 2);
INSERT INTO public.appointment VALUES (646, '2025-07-08', '13:00:00', 'Scheduled', 10000.00, 378, 763, 56, 4);
INSERT INTO public.appointment VALUES (647, '2025-06-12', '07:00:00', 'Scheduled', 15000.00, 336, 679, 121, 2);
INSERT INTO public.appointment VALUES (648, '2025-03-28', '07:00:00', 'Completed', 10000.00, 299, 596, 76, 4);
INSERT INTO public.appointment VALUES (649, '2025-03-19', '13:00:00', 'Cancelled', 8000.00, 338, 683, 161, 1);
INSERT INTO public.appointment VALUES (650, '2025-02-27', '13:00:00', 'Completed', 8000.00, 281, 565, 22, 1);
INSERT INTO public.appointment VALUES (651, '2025-09-20', '10:00:00', 'Scheduled', 8000.00, 336, 677, 175, 1);
INSERT INTO public.appointment VALUES (652, '2025-01-07', '07:00:00', 'Completed', 8000.00, 375, 758, 166, 1);
INSERT INTO public.appointment VALUES (653, '2026-01-01', '16:00:00', 'Scheduled', 10000.00, 71, 138, 220, 4);
INSERT INTO public.appointment VALUES (654, '2024-03-24', '07:00:00', 'Cancelled', 15000.00, 114, 225, 150, 2);
INSERT INTO public.appointment VALUES (655, '2023-10-11', '07:00:00', 'Completed', 35000.00, 344, 697, 27, 3);
INSERT INTO public.appointment VALUES (656, '2025-08-23', '07:00:00', 'Scheduled', 8000.00, 376, 760, 215, 1);
INSERT INTO public.appointment VALUES (657, '2025-03-07', '16:00:00', 'Completed', 15000.00, 430, 862, 103, 2);
INSERT INTO public.appointment VALUES (658, '2025-04-20', '13:00:00', 'Completed', 10000.00, 120, 237, 105, 4);
INSERT INTO public.appointment VALUES (659, '2025-11-05', '07:00:00', 'Scheduled', 15000.00, 465, 934, 7, 2);
INSERT INTO public.appointment VALUES (660, '2025-07-26', '07:00:00', 'Scheduled', 10000.00, 252, 500, 106, 4);
INSERT INTO public.appointment VALUES (661, '2024-03-29', '07:00:00', 'Completed', 10000.00, 233, 460, 52, 4);
INSERT INTO public.appointment VALUES (662, '2025-10-13', '07:00:00', 'Scheduled', 15000.00, 424, 853, 50, 2);
INSERT INTO public.appointment VALUES (663, '2025-06-19', '07:00:00', 'Scheduled', 15000.00, 388, 790, 92, 2);
INSERT INTO public.appointment VALUES (664, '2025-12-15', '10:00:00', 'Scheduled', 8000.00, 78, 151, 169, 1);
INSERT INTO public.appointment VALUES (665, '2025-01-19', '13:00:00', 'Completed', 8000.00, 272, 544, 160, 1);
INSERT INTO public.appointment VALUES (666, '2024-09-25', '16:00:00', 'Completed', 8000.00, 230, 455, 216, 1);
INSERT INTO public.appointment VALUES (667, '2024-08-13', '07:00:00', 'Completed', 10000.00, 393, 797, 113, 4);
INSERT INTO public.appointment VALUES (668, '2025-09-03', '07:00:00', 'Scheduled', 10000.00, 55, 110, 82, 4);
INSERT INTO public.appointment VALUES (669, '2024-12-30', '10:00:00', 'Cancelled', 35000.00, 111, 219, 213, 3);
INSERT INTO public.appointment VALUES (670, '2025-09-12', '07:00:00', 'Scheduled', 15000.00, 195, 389, 241, 2);
INSERT INTO public.appointment VALUES (671, '2024-05-14', '13:00:00', 'Completed', 8000.00, 205, 403, 216, 1);
INSERT INTO public.appointment VALUES (672, '2025-11-21', '10:00:00', 'Scheduled', 35000.00, 53, 107, 96, 3);
INSERT INTO public.appointment VALUES (673, '2025-12-21', '13:00:00', 'Scheduled', 10000.00, 141, 285, 20, 4);
INSERT INTO public.appointment VALUES (674, '2025-11-24', '16:00:00', 'Scheduled', 10000.00, 460, 922, 57, 4);
INSERT INTO public.appointment VALUES (675, '2025-08-07', '13:00:00', 'Scheduled', 35000.00, 435, 873, 171, 3);
INSERT INTO public.appointment VALUES (676, '2025-02-03', '16:00:00', 'Completed', 10000.00, 43, 85, 165, 4);
INSERT INTO public.appointment VALUES (677, '2023-12-27', '10:00:00', 'Completed', 35000.00, 47, 94, 171, 3);
INSERT INTO public.appointment VALUES (678, '2025-08-23', '10:00:00', 'Scheduled', 8000.00, 126, 248, 34, 1);
INSERT INTO public.appointment VALUES (679, '2025-01-22', '16:00:00', 'Completed', 15000.00, 410, 827, 237, 2);
INSERT INTO public.appointment VALUES (680, '2025-03-22', '13:00:00', 'Completed', 8000.00, 408, 824, 104, 1);
INSERT INTO public.appointment VALUES (681, '2025-06-02', '13:00:00', 'Scheduled', 35000.00, 244, 487, 234, 3);
INSERT INTO public.appointment VALUES (682, '2025-02-11', '16:00:00', 'Cancelled', 8000.00, 132, 263, 82, 1);
INSERT INTO public.appointment VALUES (683, '2024-12-02', '16:00:00', 'Completed', 35000.00, 311, 621, 66, 3);
INSERT INTO public.appointment VALUES (684, '2025-09-05', '13:00:00', 'Scheduled', 10000.00, 17, 35, 194, 4);
INSERT INTO public.appointment VALUES (685, '2025-03-04', '07:00:00', 'Completed', 35000.00, 29, 58, 202, 3);
INSERT INTO public.appointment VALUES (686, '2024-08-30', '07:00:00', 'Completed', 8000.00, 396, 801, 231, 1);
INSERT INTO public.appointment VALUES (687, '2025-01-08', '10:00:00', 'Completed', 10000.00, 71, 138, 219, 4);
INSERT INTO public.appointment VALUES (688, '2025-01-31', '16:00:00', 'Completed', 10000.00, 349, 707, 197, 4);
INSERT INTO public.appointment VALUES (689, '2025-12-29', '13:00:00', 'Scheduled', 15000.00, 3, 7, 222, 2);
INSERT INTO public.appointment VALUES (690, '2025-07-17', '07:00:00', 'Scheduled', 15000.00, 93, 180, 55, 2);
INSERT INTO public.appointment VALUES (691, '2025-02-13', '13:00:00', 'Completed', 15000.00, 416, 839, 53, 2);
INSERT INTO public.appointment VALUES (692, '2025-12-07', '16:00:00', 'Scheduled', 10000.00, 442, 889, 221, 4);
INSERT INTO public.appointment VALUES (693, '2024-11-24', '07:00:00', 'Completed', 10000.00, 221, 435, 34, 4);
INSERT INTO public.appointment VALUES (694, '2025-04-02', '13:00:00', 'Completed', 10000.00, 40, 78, 1, 4);
INSERT INTO public.appointment VALUES (695, '2024-10-19', '10:00:00', 'Cancelled', 15000.00, 186, 374, 165, 2);
INSERT INTO public.appointment VALUES (696, '2024-10-08', '10:00:00', 'Completed', 10000.00, 172, 347, 72, 4);
INSERT INTO public.appointment VALUES (697, '2024-04-14', '10:00:00', 'Completed', 35000.00, 37, 72, 22, 3);
INSERT INTO public.appointment VALUES (698, '2025-11-17', '10:00:00', 'Scheduled', 15000.00, 292, 584, 128, 2);
INSERT INTO public.appointment VALUES (699, '2024-08-24', '10:00:00', 'Completed', 15000.00, 147, 296, 235, 2);
INSERT INTO public.appointment VALUES (700, '2025-02-17', '07:00:00', 'Completed', 10000.00, 156, 320, 44, 4);
INSERT INTO public.appointment VALUES (701, '2024-08-31', '13:00:00', 'Completed', 10000.00, 132, 262, 233, 4);
INSERT INTO public.appointment VALUES (702, '2025-08-20', '13:00:00', 'Scheduled', 10000.00, 384, 778, 108, 4);
INSERT INTO public.appointment VALUES (703, '2025-09-09', '07:00:00', 'Scheduled', 8000.00, 80, 154, 24, 1);
INSERT INTO public.appointment VALUES (704, '2024-12-03', '10:00:00', 'Completed', 35000.00, 132, 263, 159, 3);
INSERT INTO public.appointment VALUES (705, '2025-08-17', '07:00:00', 'Scheduled', 8000.00, 411, 830, 176, 1);
INSERT INTO public.appointment VALUES (706, '2024-09-18', '10:00:00', 'Cancelled', 10000.00, 399, 809, 102, 4);
INSERT INTO public.appointment VALUES (707, '2025-12-23', '10:00:00', 'Scheduled', 15000.00, 364, 738, 103, 2);
INSERT INTO public.appointment VALUES (708, '2024-11-29', '07:00:00', 'Completed', 15000.00, 390, 794, 56, 2);
INSERT INTO public.appointment VALUES (709, '2025-07-26', '10:00:00', 'Scheduled', 8000.00, 185, 371, 199, 1);
INSERT INTO public.appointment VALUES (710, '2025-10-19', '13:00:00', 'Scheduled', 10000.00, 26, 53, 82, 4);
INSERT INTO public.appointment VALUES (711, '2024-11-17', '07:00:00', 'Completed', 15000.00, 357, 727, 73, 2);
INSERT INTO public.appointment VALUES (712, '2024-12-23', '13:00:00', 'Completed', 15000.00, 427, 857, 222, 2);
INSERT INTO public.appointment VALUES (713, '2025-07-02', '07:00:00', 'Scheduled', 15000.00, 367, 745, 17, 2);
INSERT INTO public.appointment VALUES (714, '2025-03-11', '16:00:00', 'Completed', 10000.00, 150, 303, 237, 4);
INSERT INTO public.appointment VALUES (715, '2025-09-30', '16:00:00', 'Scheduled', 15000.00, 36, 70, 16, 2);
INSERT INTO public.appointment VALUES (716, '2025-06-25', '13:00:00', 'Scheduled', 35000.00, 455, 910, 222, 3);
INSERT INTO public.appointment VALUES (717, '2024-11-23', '13:00:00', 'Cancelled', 15000.00, 263, 526, 64, 2);
INSERT INTO public.appointment VALUES (718, '2025-09-09', '07:00:00', 'Scheduled', 8000.00, 433, 867, 66, 1);
INSERT INTO public.appointment VALUES (719, '2023-07-19', '07:00:00', 'Completed', 15000.00, 176, 354, 195, 2);
INSERT INTO public.appointment VALUES (720, '2024-04-15', '07:00:00', 'Cancelled', 15000.00, 197, 392, 184, 2);
INSERT INTO public.appointment VALUES (721, '2024-11-05', '10:00:00', 'Completed', 8000.00, 182, 365, 59, 1);
INSERT INTO public.appointment VALUES (722, '2025-04-17', '13:00:00', 'Cancelled', 8000.00, 72, 141, 162, 1);
INSERT INTO public.appointment VALUES (723, '2025-09-24', '13:00:00', 'Scheduled', 8000.00, 414, 835, 85, 1);
INSERT INTO public.appointment VALUES (724, '2023-09-16', '13:00:00', 'Cancelled', 8000.00, 251, 499, 241, 1);
INSERT INTO public.appointment VALUES (725, '2025-12-31', '07:00:00', 'Scheduled', 8000.00, 449, 900, 3, 1);
INSERT INTO public.appointment VALUES (726, '2025-03-23', '07:00:00', 'Cancelled', 10000.00, 105, 207, 188, 4);
INSERT INTO public.appointment VALUES (727, '2024-11-26', '07:00:00', 'Cancelled', 8000.00, 245, 488, 182, 1);
INSERT INTO public.appointment VALUES (728, '2024-05-13', '07:00:00', 'Cancelled', 8000.00, 436, 876, 18, 1);
INSERT INTO public.appointment VALUES (729, '2023-08-20', '10:00:00', 'Cancelled', 10000.00, 51, 104, 4, 4);
INSERT INTO public.appointment VALUES (730, '2025-08-24', '16:00:00', 'Scheduled', 15000.00, 29, 59, 18, 2);
INSERT INTO public.appointment VALUES (731, '2025-06-13', '07:00:00', 'Scheduled', 8000.00, 73, 142, 1, 1);
INSERT INTO public.appointment VALUES (732, '2025-04-30', '13:00:00', 'Completed', 15000.00, 431, 864, 121, 2);
INSERT INTO public.appointment VALUES (733, '2025-05-23', '16:00:00', 'Scheduled', 35000.00, 157, 321, 212, 3);
INSERT INTO public.appointment VALUES (734, '2025-07-19', '07:00:00', 'Scheduled', 10000.00, 445, 892, 77, 4);
INSERT INTO public.appointment VALUES (735, '2025-06-20', '10:00:00', 'Scheduled', 15000.00, 149, 300, 126, 2);
INSERT INTO public.appointment VALUES (736, '2025-05-24', '10:00:00', 'Scheduled', 10000.00, 420, 848, 185, 4);
INSERT INTO public.appointment VALUES (737, '2024-06-11', '10:00:00', 'Completed', 10000.00, 371, 750, 114, 4);
INSERT INTO public.appointment VALUES (738, '2024-01-29', '10:00:00', 'Cancelled', 35000.00, 351, 712, 117, 3);
INSERT INTO public.appointment VALUES (739, '2025-10-05', '13:00:00', 'Scheduled', 35000.00, 66, 127, 128, 3);
INSERT INTO public.appointment VALUES (740, '2023-12-01', '13:00:00', 'Completed', 35000.00, 409, 826, 84, 3);
INSERT INTO public.appointment VALUES (741, '2025-05-12', '16:00:00', 'Cancelled', 10000.00, 326, 657, 174, 4);
INSERT INTO public.appointment VALUES (742, '2025-10-16', '10:00:00', 'Scheduled', 8000.00, 242, 482, 118, 1);
INSERT INTO public.appointment VALUES (743, '2025-05-26', '10:00:00', 'Scheduled', 10000.00, 261, 521, 32, 4);
INSERT INTO public.appointment VALUES (744, '2024-09-14', '13:00:00', 'Completed', 8000.00, 358, 728, 205, 1);
INSERT INTO public.appointment VALUES (745, '2025-03-17', '16:00:00', 'Completed', 10000.00, 473, 952, 178, 4);
INSERT INTO public.appointment VALUES (746, '2025-08-18', '13:00:00', 'Scheduled', 15000.00, 367, 744, 18, 2);
INSERT INTO public.appointment VALUES (747, '2025-02-26', '16:00:00', 'Completed', 35000.00, 356, 724, 150, 3);
INSERT INTO public.appointment VALUES (748, '2025-04-04', '07:00:00', 'Completed', 8000.00, 10, 22, 167, 1);
INSERT INTO public.appointment VALUES (749, '2025-09-29', '13:00:00', 'Scheduled', 10000.00, 210, 414, 216, 4);
INSERT INTO public.appointment VALUES (750, '2025-10-08', '07:00:00', 'Scheduled', 35000.00, 331, 668, 119, 3);
INSERT INTO public.appointment VALUES (751, '2024-06-26', '10:00:00', 'Completed', 35000.00, 114, 223, 173, 3);
INSERT INTO public.appointment VALUES (752, '2025-05-26', '10:00:00', 'Scheduled', 35000.00, 86, 164, 101, 3);
INSERT INTO public.appointment VALUES (753, '2025-08-01', '16:00:00', 'Scheduled', 15000.00, 4, 8, 225, 2);
INSERT INTO public.appointment VALUES (754, '2024-10-24', '07:00:00', 'Completed', 35000.00, 437, 879, 16, 3);
INSERT INTO public.appointment VALUES (755, '2025-04-14', '16:00:00', 'Cancelled', 35000.00, 495, 990, 97, 3);
INSERT INTO public.appointment VALUES (756, '2025-08-15', '16:00:00', 'Scheduled', 8000.00, 21, 43, 185, 1);
INSERT INTO public.appointment VALUES (757, '2024-08-31', '07:00:00', 'Cancelled', 8000.00, 459, 918, 161, 1);
INSERT INTO public.appointment VALUES (758, '2025-01-25', '13:00:00', 'Completed', 15000.00, 410, 827, 243, 2);
INSERT INTO public.appointment VALUES (759, '2025-10-13', '16:00:00', 'Scheduled', 8000.00, 416, 839, 93, 1);
INSERT INTO public.appointment VALUES (760, '2025-11-17', '07:00:00', 'Scheduled', 10000.00, 425, 854, 140, 4);
INSERT INTO public.appointment VALUES (761, '2025-06-22', '10:00:00', 'Scheduled', 35000.00, 35, 69, 75, 3);
INSERT INTO public.appointment VALUES (762, '2025-12-01', '13:00:00', 'Scheduled', 10000.00, 14, 28, 21, 4);
INSERT INTO public.appointment VALUES (763, '2025-02-05', '13:00:00', 'Completed', 10000.00, 239, 476, 225, 4);
INSERT INTO public.appointment VALUES (764, '2025-04-25', '13:00:00', 'Completed', 35000.00, 493, 988, 61, 3);
INSERT INTO public.appointment VALUES (765, '2025-02-12', '16:00:00', 'Completed', 35000.00, 383, 775, 102, 3);
INSERT INTO public.appointment VALUES (766, '2024-04-29', '10:00:00', 'Completed', 10000.00, 141, 285, 35, 4);
INSERT INTO public.appointment VALUES (767, '2025-09-07', '13:00:00', 'Scheduled', 35000.00, 293, 585, 151, 3);
INSERT INTO public.appointment VALUES (768, '2025-07-29', '10:00:00', 'Scheduled', 8000.00, 128, 256, 99, 1);
INSERT INTO public.appointment VALUES (769, '2025-05-28', '10:00:00', 'Scheduled', 15000.00, 256, 507, 10, 2);
INSERT INTO public.appointment VALUES (770, '2024-12-11', '13:00:00', 'Completed', 10000.00, 76, 146, 150, 4);
INSERT INTO public.appointment VALUES (771, '2025-09-29', '10:00:00', 'Scheduled', 15000.00, 315, 631, 155, 2);
INSERT INTO public.appointment VALUES (772, '2023-11-02', '16:00:00', 'Completed', 8000.00, 228, 451, 20, 1);
INSERT INTO public.appointment VALUES (773, '2023-11-09', '13:00:00', 'Completed', 8000.00, 78, 150, 161, 1);
INSERT INTO public.appointment VALUES (774, '2025-10-11', '07:00:00', 'Scheduled', 10000.00, 281, 565, 184, 4);
INSERT INTO public.appointment VALUES (775, '2025-09-17', '10:00:00', 'Scheduled', 8000.00, 211, 415, 48, 1);
INSERT INTO public.appointment VALUES (776, '2025-12-13', '10:00:00', 'Scheduled', 35000.00, 92, 179, 88, 3);
INSERT INTO public.appointment VALUES (777, '2024-09-29', '10:00:00', 'Completed', 15000.00, 246, 489, 239, 2);
INSERT INTO public.appointment VALUES (778, '2025-08-15', '13:00:00', 'Scheduled', 8000.00, 468, 939, 213, 1);
INSERT INTO public.appointment VALUES (779, '2025-08-21', '16:00:00', 'Scheduled', 8000.00, 241, 481, 48, 1);
INSERT INTO public.appointment VALUES (780, '2025-09-14', '16:00:00', 'Scheduled', 15000.00, 234, 461, 101, 2);
INSERT INTO public.appointment VALUES (781, '2025-06-20', '16:00:00', 'Scheduled', 10000.00, 143, 287, 72, 4);
INSERT INTO public.appointment VALUES (782, '2024-08-03', '16:00:00', 'Completed', 10000.00, 459, 921, 47, 4);
INSERT INTO public.appointment VALUES (783, '2025-01-25', '16:00:00', 'Completed', 10000.00, 176, 354, 176, 4);
INSERT INTO public.appointment VALUES (784, '2025-07-28', '16:00:00', 'Scheduled', 10000.00, 266, 531, 185, 4);
INSERT INTO public.appointment VALUES (785, '2025-09-17', '10:00:00', 'Scheduled', 10000.00, 422, 851, 111, 4);
INSERT INTO public.appointment VALUES (786, '2025-11-03', '16:00:00', 'Scheduled', 8000.00, 248, 493, 229, 1);
INSERT INTO public.appointment VALUES (787, '2024-05-02', '13:00:00', 'Cancelled', 8000.00, 220, 432, 25, 1);
INSERT INTO public.appointment VALUES (788, '2025-09-17', '10:00:00', 'Scheduled', 8000.00, 293, 585, 88, 1);
INSERT INTO public.appointment VALUES (789, '2025-02-03', '07:00:00', 'Cancelled', 15000.00, 453, 906, 148, 2);
INSERT INTO public.appointment VALUES (790, '2025-09-13', '16:00:00', 'Scheduled', 35000.00, 473, 952, 150, 3);
INSERT INTO public.appointment VALUES (791, '2025-09-23', '10:00:00', 'Scheduled', 8000.00, 316, 634, 57, 1);
INSERT INTO public.appointment VALUES (792, '2025-12-11', '07:00:00', 'Scheduled', 15000.00, 125, 246, 11, 2);
INSERT INTO public.appointment VALUES (793, '2024-10-16', '07:00:00', 'Completed', 10000.00, 485, 974, 87, 4);
INSERT INTO public.appointment VALUES (794, '2024-06-30', '16:00:00', 'Completed', 8000.00, 358, 728, 49, 1);
INSERT INTO public.appointment VALUES (795, '2025-05-15', '16:00:00', 'Cancelled', 8000.00, 326, 657, 198, 1);
INSERT INTO public.appointment VALUES (796, '2024-08-05', '16:00:00', 'Completed', 8000.00, 77, 148, 109, 1);
INSERT INTO public.appointment VALUES (797, '2025-09-19', '07:00:00', 'Scheduled', 10000.00, 321, 646, 25, 4);
INSERT INTO public.appointment VALUES (798, '2024-02-08', '16:00:00', 'Completed', 10000.00, 390, 794, 110, 4);
INSERT INTO public.appointment VALUES (799, '2025-08-22', '16:00:00', 'Scheduled', 10000.00, 339, 684, 94, 4);
INSERT INTO public.appointment VALUES (800, '2025-11-11', '16:00:00', 'Scheduled', 8000.00, 155, 317, 201, 1);
INSERT INTO public.appointment VALUES (801, '2024-06-01', '13:00:00', 'Completed', 35000.00, 29, 58, 22, 3);
INSERT INTO public.appointment VALUES (802, '2025-05-10', '13:00:00', 'Completed', 10000.00, 424, 853, 236, 4);
INSERT INTO public.appointment VALUES (803, '2024-08-12', '07:00:00', 'Cancelled', 10000.00, 99, 193, 16, 4);
INSERT INTO public.appointment VALUES (804, '2024-05-28', '13:00:00', 'Completed', 8000.00, 423, 852, 94, 1);
INSERT INTO public.appointment VALUES (805, '2023-12-12', '10:00:00', 'Cancelled', 35000.00, 3, 7, 85, 3);
INSERT INTO public.appointment VALUES (806, '2024-07-04', '13:00:00', 'Cancelled', 8000.00, 399, 810, 116, 1);
INSERT INTO public.appointment VALUES (807, '2023-10-01', '16:00:00', 'Completed', 8000.00, 309, 618, 47, 1);
INSERT INTO public.appointment VALUES (808, '2024-09-06', '16:00:00', 'Cancelled', 15000.00, 218, 428, 113, 2);
INSERT INTO public.appointment VALUES (809, '2025-09-24', '10:00:00', 'Scheduled', 10000.00, 265, 528, 70, 4);
INSERT INTO public.appointment VALUES (810, '2025-12-16', '10:00:00', 'Scheduled', 15000.00, 12, 25, 8, 2);
INSERT INTO public.appointment VALUES (811, '2025-07-10', '13:00:00', 'Scheduled', 10000.00, 357, 726, 38, 4);
INSERT INTO public.appointment VALUES (812, '2025-03-29', '10:00:00', 'Completed', 8000.00, 32, 63, 117, 1);
INSERT INTO public.appointment VALUES (813, '2025-08-11', '13:00:00', 'Scheduled', 35000.00, 176, 354, 233, 3);
INSERT INTO public.appointment VALUES (814, '2025-04-17', '07:00:00', 'Completed', 8000.00, 447, 895, 154, 1);
INSERT INTO public.appointment VALUES (815, '2025-07-02', '07:00:00', 'Scheduled', 8000.00, 415, 838, 212, 1);
INSERT INTO public.appointment VALUES (816, '2024-03-25', '16:00:00', 'Completed', 35000.00, 218, 428, 174, 3);
INSERT INTO public.appointment VALUES (817, '2025-09-25', '16:00:00', 'Scheduled', 10000.00, 338, 683, 90, 4);
INSERT INTO public.appointment VALUES (818, '2024-04-04', '07:00:00', 'Completed', 15000.00, 254, 503, 6, 2);
INSERT INTO public.appointment VALUES (819, '2025-12-21', '10:00:00', 'Scheduled', 15000.00, 389, 792, 2, 2);
INSERT INTO public.appointment VALUES (820, '2024-04-09', '13:00:00', 'Completed', 35000.00, 198, 393, 14, 3);
INSERT INTO public.appointment VALUES (821, '2025-11-01', '07:00:00', 'Scheduled', 8000.00, 354, 719, 217, 1);
INSERT INTO public.appointment VALUES (822, '2025-06-03', '07:00:00', 'Scheduled', 8000.00, 202, 399, 42, 1);
INSERT INTO public.appointment VALUES (823, '2023-06-30', '10:00:00', 'Completed', 15000.00, 20, 41, 47, 2);
INSERT INTO public.appointment VALUES (824, '2023-11-17', '16:00:00', 'Completed', 35000.00, 226, 447, 212, 3);
INSERT INTO public.appointment VALUES (825, '2025-09-23', '10:00:00', 'Scheduled', 8000.00, 443, 890, 204, 1);
INSERT INTO public.appointment VALUES (826, '2025-03-13', '13:00:00', 'Completed', 8000.00, 16, 33, 202, 1);
INSERT INTO public.appointment VALUES (827, '2025-03-16', '16:00:00', 'Completed', 8000.00, 358, 728, 231, 1);
INSERT INTO public.appointment VALUES (828, '2023-06-11', '10:00:00', 'Cancelled', 15000.00, 169, 342, 6, 2);
INSERT INTO public.appointment VALUES (829, '2025-08-10', '13:00:00', 'Scheduled', 8000.00, 289, 579, 20, 1);
INSERT INTO public.appointment VALUES (830, '2025-10-10', '07:00:00', 'Scheduled', 15000.00, 370, 748, 226, 2);
INSERT INTO public.appointment VALUES (831, '2025-04-18', '07:00:00', 'Completed', 15000.00, 375, 758, 35, 2);
INSERT INTO public.appointment VALUES (832, '2025-10-18', '07:00:00', 'Scheduled', 35000.00, 9, 19, 150, 3);
INSERT INTO public.appointment VALUES (833, '2024-05-23', '10:00:00', 'Completed', 35000.00, 197, 392, 92, 3);
INSERT INTO public.appointment VALUES (834, '2024-10-27', '16:00:00', 'Completed', 15000.00, 304, 608, 49, 2);
INSERT INTO public.appointment VALUES (835, '2025-12-11', '13:00:00', 'Scheduled', 10000.00, 392, 796, 114, 4);
INSERT INTO public.appointment VALUES (836, '2024-02-06', '07:00:00', 'Completed', 8000.00, 436, 876, 149, 1);
INSERT INTO public.appointment VALUES (837, '2024-06-21', '07:00:00', 'Completed', 35000.00, 426, 856, 150, 3);
INSERT INTO public.appointment VALUES (838, '2025-11-04', '13:00:00', 'Scheduled', 35000.00, 268, 534, 44, 3);
INSERT INTO public.appointment VALUES (839, '2025-12-13', '10:00:00', 'Scheduled', 10000.00, 293, 585, 142, 4);
INSERT INTO public.appointment VALUES (840, '2025-05-25', '10:00:00', 'Scheduled', 10000.00, 167, 339, 93, 4);
INSERT INTO public.appointment VALUES (841, '2023-12-07', '10:00:00', 'Cancelled', 8000.00, 306, 612, 11, 1);
INSERT INTO public.appointment VALUES (842, '2025-07-02', '16:00:00', 'Scheduled', 35000.00, 91, 177, 131, 3);
INSERT INTO public.appointment VALUES (843, '2025-01-25', '10:00:00', 'Completed', 15000.00, 444, 891, 191, 2);
INSERT INTO public.appointment VALUES (844, '2025-06-17', '07:00:00', 'Scheduled', 15000.00, 234, 462, 16, 2);
INSERT INTO public.appointment VALUES (845, '2025-11-18', '16:00:00', 'Scheduled', 10000.00, 287, 575, 124, 4);
INSERT INTO public.appointment VALUES (846, '2025-11-08', '13:00:00', 'Scheduled', 8000.00, 453, 906, 195, 1);
INSERT INTO public.appointment VALUES (847, '2023-08-24', '07:00:00', 'Cancelled', 35000.00, 490, 982, 81, 3);
INSERT INTO public.appointment VALUES (848, '2025-05-17', '16:00:00', 'Scheduled', 15000.00, 471, 950, 110, 2);
INSERT INTO public.appointment VALUES (849, '2025-02-11', '16:00:00', 'Completed', 10000.00, 461, 925, 11, 4);
INSERT INTO public.appointment VALUES (850, '2023-11-13', '10:00:00', 'Completed', 8000.00, 29, 59, 34, 1);
INSERT INTO public.appointment VALUES (851, '2025-12-08', '13:00:00', 'Scheduled', 8000.00, 469, 944, 213, 1);
INSERT INTO public.appointment VALUES (852, '2025-08-10', '10:00:00', 'Scheduled', 15000.00, 7, 17, 118, 2);
INSERT INTO public.appointment VALUES (853, '2025-10-11', '07:00:00', 'Scheduled', 8000.00, 329, 662, 114, 1);
INSERT INTO public.appointment VALUES (854, '2025-03-29', '13:00:00', 'Completed', 8000.00, 382, 773, 55, 1);
INSERT INTO public.appointment VALUES (855, '2025-08-04', '16:00:00', 'Scheduled', 35000.00, 322, 648, 7, 3);
INSERT INTO public.appointment VALUES (856, '2025-03-26', '07:00:00', 'Completed', 8000.00, 430, 863, 151, 1);
INSERT INTO public.appointment VALUES (857, '2023-08-26', '13:00:00', 'Completed', 15000.00, 262, 522, 85, 2);
INSERT INTO public.appointment VALUES (858, '2025-04-23', '07:00:00', 'Completed', 8000.00, 327, 658, 118, 1);
INSERT INTO public.appointment VALUES (859, '2025-10-19', '10:00:00', 'Scheduled', 8000.00, 201, 398, 18, 1);
INSERT INTO public.appointment VALUES (860, '2025-12-08', '07:00:00', 'Scheduled', 10000.00, 79, 152, 232, 4);
INSERT INTO public.appointment VALUES (861, '2025-09-25', '16:00:00', 'Scheduled', 8000.00, 171, 346, 153, 1);
INSERT INTO public.appointment VALUES (862, '2025-08-14', '16:00:00', 'Scheduled', 15000.00, 411, 830, 209, 2);
INSERT INTO public.appointment VALUES (863, '2025-09-30', '13:00:00', 'Scheduled', 8000.00, 475, 957, 178, 1);
INSERT INTO public.appointment VALUES (864, '2025-02-06', '10:00:00', 'Completed', 8000.00, 143, 287, 155, 1);
INSERT INTO public.appointment VALUES (865, '2025-09-13', '13:00:00', 'Scheduled', 35000.00, 80, 154, 95, 3);
INSERT INTO public.appointment VALUES (866, '2024-10-17', '13:00:00', 'Cancelled', 10000.00, 63, 123, 70, 4);
INSERT INTO public.appointment VALUES (867, '2025-10-23', '10:00:00', 'Scheduled', 10000.00, 361, 734, 192, 4);
INSERT INTO public.appointment VALUES (868, '2025-11-04', '10:00:00', 'Scheduled', 8000.00, 36, 71, 187, 1);
INSERT INTO public.appointment VALUES (869, '2025-04-02', '16:00:00', 'Completed', 10000.00, 17, 35, 102, 4);
INSERT INTO public.appointment VALUES (870, '2024-08-29', '07:00:00', 'Completed', 8000.00, 265, 528, 239, 1);
INSERT INTO public.appointment VALUES (871, '2024-06-05', '13:00:00', 'Completed', 8000.00, 246, 489, 236, 1);
INSERT INTO public.appointment VALUES (872, '2025-10-17', '07:00:00', 'Scheduled', 10000.00, 69, 136, 186, 4);
INSERT INTO public.appointment VALUES (873, '2024-10-22', '16:00:00', 'Completed', 8000.00, 215, 421, 40, 1);
INSERT INTO public.appointment VALUES (874, '2025-09-12', '16:00:00', 'Scheduled', 10000.00, 139, 279, 110, 4);
INSERT INTO public.appointment VALUES (875, '2025-01-10', '10:00:00', 'Completed', 8000.00, 162, 330, 105, 1);
INSERT INTO public.appointment VALUES (876, '2025-11-07', '10:00:00', 'Scheduled', 15000.00, 428, 859, 143, 2);
INSERT INTO public.appointment VALUES (877, '2025-06-26', '07:00:00', 'Scheduled', 15000.00, 337, 681, 116, 2);
INSERT INTO public.appointment VALUES (878, '2025-09-06', '16:00:00', 'Scheduled', 35000.00, 233, 460, 137, 3);
INSERT INTO public.appointment VALUES (879, '2025-10-10', '16:00:00', 'Scheduled', 35000.00, 184, 370, 190, 3);
INSERT INTO public.appointment VALUES (880, '2025-08-16', '10:00:00', 'Scheduled', 10000.00, 357, 727, 111, 4);
INSERT INTO public.appointment VALUES (881, '2025-03-30', '13:00:00', 'Completed', 35000.00, 17, 35, 188, 3);
INSERT INTO public.appointment VALUES (882, '2024-10-17', '16:00:00', 'Completed', 15000.00, 142, 286, 84, 2);
INSERT INTO public.appointment VALUES (883, '2025-09-19', '07:00:00', 'Scheduled', 35000.00, 180, 361, 160, 3);
INSERT INTO public.appointment VALUES (884, '2025-09-07', '16:00:00', 'Scheduled', 15000.00, 116, 229, 37, 2);
INSERT INTO public.appointment VALUES (885, '2025-03-16', '13:00:00', 'Completed', 15000.00, 25, 49, 172, 2);
INSERT INTO public.appointment VALUES (886, '2025-04-12', '16:00:00', 'Completed', 8000.00, 185, 371, 50, 1);
INSERT INTO public.appointment VALUES (887, '2024-12-11', '10:00:00', 'Cancelled', 35000.00, 107, 211, 24, 3);
INSERT INTO public.appointment VALUES (888, '2025-06-29', '13:00:00', 'Scheduled', 35000.00, 188, 377, 173, 3);
INSERT INTO public.appointment VALUES (889, '2024-11-19', '16:00:00', 'Completed', 8000.00, 166, 338, 133, 1);
INSERT INTO public.appointment VALUES (890, '2023-10-21', '07:00:00', 'Completed', 8000.00, 294, 587, 159, 1);
INSERT INTO public.appointment VALUES (891, '2024-11-05', '16:00:00', 'Completed', 35000.00, 181, 363, 132, 3);
INSERT INTO public.appointment VALUES (892, '2024-06-04', '16:00:00', 'Completed', 35000.00, 193, 385, 154, 3);
INSERT INTO public.appointment VALUES (893, '2024-07-26', '13:00:00', 'Cancelled', 35000.00, 454, 909, 162, 3);
INSERT INTO public.appointment VALUES (894, '2025-05-08', '16:00:00', 'Completed', 8000.00, 2, 6, 158, 1);
INSERT INTO public.appointment VALUES (895, '2025-08-07', '10:00:00', 'Scheduled', 8000.00, 491, 983, 141, 1);
INSERT INTO public.appointment VALUES (896, '2025-06-06', '07:00:00', 'Scheduled', 35000.00, 1, 1, 236, 3);
INSERT INTO public.appointment VALUES (897, '2024-09-10', '13:00:00', 'Completed', 15000.00, 20, 42, 22, 2);
INSERT INTO public.appointment VALUES (898, '2024-12-13', '10:00:00', 'Completed', 15000.00, 20, 41, 26, 2);
INSERT INTO public.appointment VALUES (899, '2025-11-22', '10:00:00', 'Scheduled', 35000.00, 111, 219, 232, 3);
INSERT INTO public.appointment VALUES (900, '2025-05-24', '10:00:00', 'Scheduled', 35000.00, 473, 952, 39, 3);
INSERT INTO public.appointment VALUES (901, '2025-12-19', '07:00:00', 'Scheduled', 15000.00, 37, 72, 203, 2);
INSERT INTO public.appointment VALUES (902, '2025-03-28', '07:00:00', 'Completed', 10000.00, 217, 427, 26, 4);
INSERT INTO public.appointment VALUES (903, '2025-06-09', '16:00:00', 'Scheduled', 8000.00, 353, 717, 129, 1);
INSERT INTO public.appointment VALUES (904, '2025-08-24', '10:00:00', 'Scheduled', 10000.00, 150, 301, 201, 4);
INSERT INTO public.appointment VALUES (905, '2025-09-25', '13:00:00', 'Scheduled', 8000.00, 197, 392, 98, 1);
INSERT INTO public.appointment VALUES (906, '2025-12-08', '13:00:00', 'Scheduled', 35000.00, 328, 660, 45, 3);
INSERT INTO public.appointment VALUES (907, '2025-03-11', '13:00:00', 'Cancelled', 35000.00, 210, 414, 6, 3);
INSERT INTO public.appointment VALUES (908, '2025-04-26', '16:00:00', 'Cancelled', 35000.00, 81, 155, 13, 3);
INSERT INTO public.appointment VALUES (909, '2024-09-25', '10:00:00', 'Completed', 35000.00, 405, 821, 200, 3);
INSERT INTO public.appointment VALUES (910, '2025-08-16', '07:00:00', 'Scheduled', 15000.00, 19, 40, 133, 2);
INSERT INTO public.appointment VALUES (911, '2025-07-17', '16:00:00', 'Scheduled', 10000.00, 282, 566, 164, 4);
INSERT INTO public.appointment VALUES (912, '2023-08-13', '13:00:00', 'Completed', 15000.00, 71, 138, 177, 2);
INSERT INTO public.appointment VALUES (913, '2025-11-05', '16:00:00', 'Scheduled', 10000.00, 367, 745, 12, 4);
INSERT INTO public.appointment VALUES (914, '2024-12-05', '07:00:00', 'Cancelled', 35000.00, 100, 196, 67, 3);
INSERT INTO public.appointment VALUES (915, '2025-03-31', '10:00:00', 'Completed', 8000.00, 181, 362, 104, 1);
INSERT INTO public.appointment VALUES (916, '2025-07-25', '13:00:00', 'Scheduled', 35000.00, 495, 990, 76, 3);
INSERT INTO public.appointment VALUES (917, '2024-11-17', '10:00:00', 'Completed', 15000.00, 182, 365, 234, 2);
INSERT INTO public.appointment VALUES (918, '2025-12-28', '16:00:00', 'Scheduled', 8000.00, 368, 746, 240, 1);
INSERT INTO public.appointment VALUES (919, '2025-09-22', '16:00:00', 'Scheduled', 10000.00, 118, 233, 154, 4);
INSERT INTO public.appointment VALUES (920, '2025-09-08', '10:00:00', 'Scheduled', 8000.00, 139, 280, 185, 1);
INSERT INTO public.appointment VALUES (921, '2025-06-03', '07:00:00', 'Scheduled', 15000.00, 383, 776, 77, 2);
INSERT INTO public.appointment VALUES (922, '2025-02-23', '16:00:00', 'Cancelled', 35000.00, 440, 885, 176, 3);
INSERT INTO public.appointment VALUES (923, '2025-05-24', '07:00:00', 'Scheduled', 10000.00, 210, 414, 58, 4);
INSERT INTO public.appointment VALUES (924, '2025-06-08', '16:00:00', 'Scheduled', 35000.00, 145, 291, 238, 3);
INSERT INTO public.appointment VALUES (925, '2025-01-26', '16:00:00', 'Completed', 15000.00, 435, 872, 222, 2);
INSERT INTO public.appointment VALUES (926, '2024-08-31', '13:00:00', 'Completed', 10000.00, 259, 515, 1, 4);
INSERT INTO public.appointment VALUES (927, '2025-03-23', '16:00:00', 'Completed', 15000.00, 112, 221, 51, 2);
INSERT INTO public.appointment VALUES (928, '2025-04-03', '13:00:00', 'Completed', 35000.00, 297, 591, 92, 3);
INSERT INTO public.appointment VALUES (929, '2023-11-26', '13:00:00', 'Cancelled', 35000.00, 208, 411, 210, 3);
INSERT INTO public.appointment VALUES (930, '2024-07-01', '10:00:00', 'Cancelled', 8000.00, 12, 25, 152, 1);
INSERT INTO public.appointment VALUES (931, '2025-08-28', '16:00:00', 'Scheduled', 35000.00, 36, 70, 71, 3);
INSERT INTO public.appointment VALUES (932, '2025-11-18', '10:00:00', 'Scheduled', 15000.00, 149, 300, 71, 2);
INSERT INTO public.appointment VALUES (933, '2025-07-14', '13:00:00', 'Scheduled', 35000.00, 378, 765, 215, 3);
INSERT INTO public.appointment VALUES (934, '2025-07-12', '16:00:00', 'Scheduled', 35000.00, 2, 3, 25, 3);
INSERT INTO public.appointment VALUES (935, '2025-09-14', '10:00:00', 'Scheduled', 8000.00, 399, 810, 169, 1);
INSERT INTO public.appointment VALUES (936, '2025-10-03', '13:00:00', 'Scheduled', 10000.00, 424, 853, 170, 4);
INSERT INTO public.appointment VALUES (937, '2025-06-25', '07:00:00', 'Scheduled', 10000.00, 1, 1, 21, 4);
INSERT INTO public.appointment VALUES (938, '2025-07-09', '10:00:00', 'Scheduled', 15000.00, 76, 147, 83, 2);
INSERT INTO public.appointment VALUES (939, '2025-01-07', '16:00:00', 'Completed', 35000.00, 482, 971, 230, 3);
INSERT INTO public.appointment VALUES (940, '2024-06-23', '16:00:00', 'Completed', 10000.00, 75, 145, 67, 4);
INSERT INTO public.appointment VALUES (941, '2025-09-05', '13:00:00', 'Scheduled', 15000.00, 234, 462, 51, 2);
INSERT INTO public.appointment VALUES (942, '2025-08-03', '13:00:00', 'Scheduled', 35000.00, 284, 570, 78, 3);
INSERT INTO public.appointment VALUES (943, '2024-02-29', '16:00:00', 'Completed', 8000.00, 6, 12, 89, 1);
INSERT INTO public.appointment VALUES (944, '2025-08-07', '13:00:00', 'Scheduled', 35000.00, 269, 538, 68, 3);
INSERT INTO public.appointment VALUES (945, '2024-08-01', '10:00:00', 'Completed', 8000.00, 77, 148, 102, 1);
INSERT INTO public.appointment VALUES (946, '2023-06-12', '13:00:00', 'Completed', 8000.00, 108, 214, 14, 1);
INSERT INTO public.appointment VALUES (947, '2024-05-22', '13:00:00', 'Completed', 8000.00, 430, 862, 26, 1);
INSERT INTO public.appointment VALUES (948, '2024-03-16', '10:00:00', 'Completed', 8000.00, 68, 134, 157, 1);
INSERT INTO public.appointment VALUES (949, '2025-03-09', '10:00:00', 'Completed', 35000.00, 259, 515, 56, 3);
INSERT INTO public.appointment VALUES (950, '2025-11-16', '10:00:00', 'Scheduled', 8000.00, 140, 283, 235, 1);
INSERT INTO public.appointment VALUES (951, '2025-05-21', '16:00:00', 'Scheduled', 10000.00, 307, 613, 55, 4);
INSERT INTO public.appointment VALUES (952, '2023-08-15', '16:00:00', 'Completed', 15000.00, 436, 875, 134, 2);
INSERT INTO public.appointment VALUES (953, '2025-07-14', '16:00:00', 'Scheduled', 15000.00, 221, 435, 145, 2);
INSERT INTO public.appointment VALUES (954, '2025-11-15', '13:00:00', 'Scheduled', 10000.00, 212, 417, 241, 4);
INSERT INTO public.appointment VALUES (955, '2025-01-11', '13:00:00', 'Completed', 8000.00, 394, 799, 132, 1);
INSERT INTO public.appointment VALUES (956, '2024-12-05', '13:00:00', 'Cancelled', 8000.00, 186, 374, 126, 1);
INSERT INTO public.appointment VALUES (957, '2025-12-30', '13:00:00', 'Scheduled', 8000.00, 138, 277, 97, 1);
INSERT INTO public.appointment VALUES (958, '2025-10-18', '16:00:00', 'Scheduled', 15000.00, 83, 159, 123, 2);
INSERT INTO public.appointment VALUES (959, '2025-03-20', '10:00:00', 'Completed', 15000.00, 165, 336, 44, 2);
INSERT INTO public.appointment VALUES (960, '2024-07-11', '16:00:00', 'Completed', 15000.00, 345, 700, 223, 2);
INSERT INTO public.appointment VALUES (961, '2025-06-16', '13:00:00', 'Scheduled', 35000.00, 416, 839, 185, 3);
INSERT INTO public.appointment VALUES (962, '2025-12-18', '16:00:00', 'Scheduled', 8000.00, 169, 343, 6, 1);
INSERT INTO public.appointment VALUES (963, '2025-07-26', '07:00:00', 'Scheduled', 15000.00, 199, 395, 68, 2);
INSERT INTO public.appointment VALUES (964, '2025-05-29', '07:00:00', 'Scheduled', 8000.00, 54, 109, 114, 1);
INSERT INTO public.appointment VALUES (965, '2025-10-22', '10:00:00', 'Scheduled', 8000.00, 340, 685, 231, 1);
INSERT INTO public.appointment VALUES (966, '2024-01-05', '13:00:00', 'Completed', 35000.00, 219, 430, 98, 3);
INSERT INTO public.appointment VALUES (967, '2025-12-19', '07:00:00', 'Scheduled', 35000.00, 490, 982, 144, 3);
INSERT INTO public.appointment VALUES (968, '2025-10-23', '13:00:00', 'Scheduled', 35000.00, 48, 96, 28, 3);
INSERT INTO public.appointment VALUES (969, '2024-05-12', '10:00:00', 'Cancelled', 35000.00, 30, 60, 97, 3);
INSERT INTO public.appointment VALUES (970, '2025-01-18', '16:00:00', 'Completed', 10000.00, 70, 137, 76, 4);
INSERT INTO public.appointment VALUES (971, '2024-04-20', '07:00:00', 'Completed', 15000.00, 462, 926, 164, 2);
INSERT INTO public.appointment VALUES (972, '2024-10-20', '10:00:00', 'Cancelled', 10000.00, 279, 560, 7, 4);
INSERT INTO public.appointment VALUES (973, '2024-07-01', '16:00:00', 'Cancelled', 35000.00, 242, 483, 109, 3);
INSERT INTO public.appointment VALUES (974, '2023-11-10', '16:00:00', 'Completed', 35000.00, 99, 193, 37, 3);
INSERT INTO public.appointment VALUES (975, '2023-09-13', '16:00:00', 'Completed', 8000.00, 230, 455, 102, 1);
INSERT INTO public.appointment VALUES (976, '2025-09-25', '07:00:00', 'Scheduled', 35000.00, 248, 492, 90, 3);
INSERT INTO public.appointment VALUES (977, '2025-12-21', '10:00:00', 'Scheduled', 15000.00, 147, 296, 109, 2);
INSERT INTO public.appointment VALUES (978, '2025-05-07', '13:00:00', 'Completed', 15000.00, 484, 973, 71, 2);
INSERT INTO public.appointment VALUES (979, '2025-08-28', '07:00:00', 'Scheduled', 8000.00, 275, 551, 126, 1);
INSERT INTO public.appointment VALUES (980, '2024-08-29', '16:00:00', 'Completed', 10000.00, 191, 382, 111, 4);
INSERT INTO public.appointment VALUES (981, '2024-10-20', '16:00:00', 'Cancelled', 35000.00, 200, 396, 98, 3);
INSERT INTO public.appointment VALUES (982, '2024-03-06', '13:00:00', 'Completed', 10000.00, 111, 219, 49, 4);
INSERT INTO public.appointment VALUES (983, '2025-10-23', '13:00:00', 'Scheduled', 10000.00, 478, 962, 116, 4);
INSERT INTO public.appointment VALUES (984, '2024-10-08', '10:00:00', 'Completed', 10000.00, 82, 157, 236, 4);
INSERT INTO public.appointment VALUES (985, '2025-02-08', '13:00:00', 'Completed', 10000.00, 258, 514, 162, 4);
INSERT INTO public.appointment VALUES (986, '2025-11-09', '13:00:00', 'Scheduled', 35000.00, 415, 838, 238, 3);
INSERT INTO public.appointment VALUES (987, '2024-02-28', '07:00:00', 'Completed', 10000.00, 132, 263, 99, 4);
INSERT INTO public.appointment VALUES (988, '2025-12-23', '07:00:00', 'Scheduled', 8000.00, 478, 962, 2, 1);
INSERT INTO public.appointment VALUES (989, '2025-12-26', '16:00:00', 'Scheduled', 35000.00, 22, 44, 88, 3);
INSERT INTO public.appointment VALUES (990, '2024-11-30', '10:00:00', 'Completed', 35000.00, 193, 385, 178, 3);
INSERT INTO public.appointment VALUES (991, '2025-01-06', '07:00:00', 'Completed', 15000.00, 229, 454, 31, 2);
INSERT INTO public.appointment VALUES (992, '2024-12-20', '13:00:00', 'Completed', 10000.00, 124, 245, 119, 4);
INSERT INTO public.appointment VALUES (993, '2025-01-23', '07:00:00', 'Completed', 35000.00, 454, 907, 106, 3);
INSERT INTO public.appointment VALUES (994, '2025-02-25', '16:00:00', 'Completed', 8000.00, 134, 266, 120, 1);
INSERT INTO public.appointment VALUES (995, '2024-02-04', '10:00:00', 'Completed', 8000.00, 140, 282, 213, 1);
INSERT INTO public.appointment VALUES (996, '2025-11-05', '10:00:00', 'Scheduled', 8000.00, 300, 600, 26, 1);
INSERT INTO public.appointment VALUES (997, '2024-11-10', '13:00:00', 'Completed', 10000.00, 263, 524, 145, 4);
INSERT INTO public.appointment VALUES (998, '2024-05-25', '10:00:00', 'Completed', 10000.00, 18, 37, 158, 4);
INSERT INTO public.appointment VALUES (999, '2024-12-16', '10:00:00', 'Completed', 8000.00, 66, 127, 62, 1);
INSERT INTO public.appointment VALUES (1000, '2025-12-21', '16:00:00', 'Scheduled', 15000.00, 376, 761, 176, 2);
INSERT INTO public.appointment VALUES (1001, '2024-01-19', '07:00:00', 'Completed', 8000.00, 274, 548, 103, 1);
INSERT INTO public.appointment VALUES (1002, '2024-01-26', '13:00:00', 'Completed', 8000.00, 279, 559, 172, 1);
INSERT INTO public.appointment VALUES (1003, '2023-10-18', '13:00:00', 'Completed', 15000.00, 438, 881, 152, 2);
INSERT INTO public.appointment VALUES (1004, '2025-07-27', '16:00:00', 'Scheduled', 15000.00, 467, 937, 20, 2);
INSERT INTO public.appointment VALUES (1005, '2024-03-14', '10:00:00', 'Completed', 10000.00, 160, 325, 200, 4);
INSERT INTO public.appointment VALUES (1006, '2025-03-13', '16:00:00', 'Completed', 8000.00, 114, 225, 119, 1);
INSERT INTO public.appointment VALUES (1007, '2025-05-26', '13:00:00', 'Scheduled', 15000.00, 467, 938, 34, 2);
INSERT INTO public.appointment VALUES (1008, '2025-10-08', '10:00:00', 'Scheduled', 15000.00, 147, 296, 154, 2);
INSERT INTO public.appointment VALUES (1009, '2023-10-05', '13:00:00', 'Completed', 15000.00, 75, 145, 194, 2);
INSERT INTO public.appointment VALUES (1010, '2025-08-12', '13:00:00', 'Scheduled', 35000.00, 116, 230, 12, 3);
INSERT INTO public.appointment VALUES (1011, '2023-11-08', '13:00:00', 'Cancelled', 10000.00, 104, 203, 170, 4);
INSERT INTO public.appointment VALUES (1012, '2025-06-07', '07:00:00', 'Scheduled', 8000.00, 206, 408, 171, 1);
INSERT INTO public.appointment VALUES (1013, '2025-01-22', '07:00:00', 'Completed', 35000.00, 179, 359, 184, 3);
INSERT INTO public.appointment VALUES (1014, '2024-08-13', '13:00:00', 'Completed', 10000.00, 138, 277, 84, 4);
INSERT INTO public.appointment VALUES (1015, '2025-01-19', '13:00:00', 'Completed', 10000.00, 72, 141, 75, 4);
INSERT INTO public.appointment VALUES (1016, '2025-08-19', '13:00:00', 'Scheduled', 10000.00, 24, 48, 176, 4);
INSERT INTO public.appointment VALUES (1017, '2025-01-06', '10:00:00', 'Completed', 10000.00, 5, 10, 142, 4);
INSERT INTO public.appointment VALUES (1018, '2023-09-04', '16:00:00', 'Completed', 8000.00, 108, 215, 85, 1);
INSERT INTO public.appointment VALUES (1019, '2025-02-09', '16:00:00', 'Completed', 10000.00, 394, 798, 164, 4);
INSERT INTO public.appointment VALUES (1020, '2025-05-14', '13:00:00', 'Completed', 10000.00, 449, 900, 18, 4);
INSERT INTO public.appointment VALUES (1021, '2025-02-24', '10:00:00', 'Completed', 35000.00, 239, 475, 238, 3);
INSERT INTO public.appointment VALUES (1022, '2023-09-22', '16:00:00', 'Cancelled', 8000.00, 59, 118, 223, 1);
INSERT INTO public.appointment VALUES (1023, '2025-03-02', '07:00:00', 'Completed', 35000.00, 231, 456, 140, 3);
INSERT INTO public.appointment VALUES (1024, '2025-09-19', '16:00:00', 'Scheduled', 8000.00, 460, 922, 19, 1);
INSERT INTO public.appointment VALUES (1025, '2023-05-11', '13:00:00', 'Cancelled', 15000.00, 409, 826, 180, 2);
INSERT INTO public.appointment VALUES (1026, '2024-02-06', '07:00:00', 'Cancelled', 10000.00, 224, 440, 185, 4);
INSERT INTO public.appointment VALUES (1027, '2025-12-02', '13:00:00', 'Scheduled', 35000.00, 434, 870, 195, 3);
INSERT INTO public.appointment VALUES (1028, '2024-09-19', '16:00:00', 'Completed', 8000.00, 74, 143, 100, 1);
INSERT INTO public.appointment VALUES (1029, '2025-11-04', '13:00:00', 'Scheduled', 10000.00, 96, 185, 144, 4);
INSERT INTO public.appointment VALUES (1030, '2025-08-20', '13:00:00', 'Scheduled', 8000.00, 330, 663, 219, 1);
INSERT INTO public.appointment VALUES (1031, '2025-11-11', '13:00:00', 'Scheduled', 35000.00, 323, 649, 37, 3);
INSERT INTO public.appointment VALUES (1032, '2025-03-03', '16:00:00', 'Completed', 8000.00, 391, 795, 125, 1);
INSERT INTO public.appointment VALUES (1033, '2025-12-27', '13:00:00', 'Scheduled', 10000.00, 328, 661, 28, 4);
INSERT INTO public.appointment VALUES (1034, '2024-08-06', '10:00:00', 'Cancelled', 8000.00, 132, 262, 171, 1);
INSERT INTO public.appointment VALUES (1035, '2023-12-12', '07:00:00', 'Completed', 15000.00, 75, 145, 161, 2);
INSERT INTO public.appointment VALUES (1036, '2024-05-15', '13:00:00', 'Cancelled', 10000.00, 88, 169, 90, 4);
INSERT INTO public.appointment VALUES (1037, '2023-07-12', '07:00:00', 'Cancelled', 35000.00, 141, 284, 130, 3);
INSERT INTO public.appointment VALUES (1038, '2026-01-01', '07:00:00', 'Scheduled', 8000.00, 417, 840, 96, 1);
INSERT INTO public.appointment VALUES (1039, '2025-08-08', '07:00:00', 'Scheduled', 15000.00, 118, 233, 127, 2);
INSERT INTO public.appointment VALUES (1040, '2024-06-07', '13:00:00', 'Completed', 15000.00, 398, 806, 185, 2);
INSERT INTO public.appointment VALUES (1041, '2024-09-28', '07:00:00', 'Completed', 10000.00, 468, 942, 243, 4);
INSERT INTO public.appointment VALUES (1042, '2025-12-29', '07:00:00', 'Scheduled', 8000.00, 429, 861, 181, 1);
INSERT INTO public.appointment VALUES (1043, '2025-07-06', '16:00:00', 'Scheduled', 10000.00, 493, 988, 158, 4);
INSERT INTO public.appointment VALUES (1044, '2023-11-21', '13:00:00', 'Completed', 10000.00, 239, 473, 143, 4);
INSERT INTO public.appointment VALUES (1045, '2025-05-07', '13:00:00', 'Completed', 8000.00, 107, 213, 81, 1);
INSERT INTO public.appointment VALUES (1046, '2025-07-08', '10:00:00', 'Scheduled', 8000.00, 180, 361, 111, 1);
INSERT INTO public.appointment VALUES (1047, '2024-10-10', '07:00:00', 'Completed', 10000.00, 317, 637, 239, 4);
INSERT INTO public.appointment VALUES (1048, '2025-12-06', '07:00:00', 'Scheduled', 10000.00, 39, 75, 36, 4);
INSERT INTO public.appointment VALUES (1049, '2023-11-04', '13:00:00', 'Completed', 8000.00, 414, 834, 107, 1);
INSERT INTO public.appointment VALUES (1050, '2024-05-02', '10:00:00', 'Completed', 8000.00, 159, 323, 67, 1);
INSERT INTO public.appointment VALUES (1051, '2024-06-21', '07:00:00', 'Completed', 8000.00, 310, 619, 194, 1);
INSERT INTO public.appointment VALUES (1052, '2025-07-31', '10:00:00', 'Scheduled', 35000.00, 60, 120, 160, 3);
INSERT INTO public.appointment VALUES (1053, '2025-10-27', '07:00:00', 'Scheduled', 8000.00, 100, 197, 227, 1);
INSERT INTO public.appointment VALUES (1054, '2024-10-19', '10:00:00', 'Completed', 15000.00, 372, 753, 6, 2);
INSERT INTO public.appointment VALUES (1055, '2025-08-28', '07:00:00', 'Scheduled', 35000.00, 407, 823, 78, 3);
INSERT INTO public.appointment VALUES (1056, '2025-07-16', '07:00:00', 'Scheduled', 8000.00, 139, 279, 46, 1);
INSERT INTO public.appointment VALUES (1057, '2025-11-12', '10:00:00', 'Scheduled', 35000.00, 497, 992, 43, 3);
INSERT INTO public.appointment VALUES (1058, '2025-01-22', '16:00:00', 'Cancelled', 35000.00, 39, 76, 164, 3);
INSERT INTO public.appointment VALUES (1059, '2025-02-19', '10:00:00', 'Completed', 10000.00, 471, 949, 25, 4);
INSERT INTO public.appointment VALUES (1060, '2024-10-18', '13:00:00', 'Completed', 8000.00, 152, 308, 180, 1);
INSERT INTO public.appointment VALUES (1061, '2025-09-03', '10:00:00', 'Scheduled', 15000.00, 250, 497, 17, 2);
INSERT INTO public.appointment VALUES (1062, '2025-07-21', '07:00:00', 'Scheduled', 15000.00, 379, 767, 30, 2);
INSERT INTO public.appointment VALUES (1063, '2025-05-29', '10:00:00', 'Scheduled', 10000.00, 134, 267, 169, 4);
INSERT INTO public.appointment VALUES (1064, '2025-07-04', '07:00:00', 'Scheduled', 35000.00, 47, 94, 41, 3);
INSERT INTO public.appointment VALUES (1065, '2025-12-24', '07:00:00', 'Scheduled', 35000.00, 144, 290, 195, 3);
INSERT INTO public.appointment VALUES (1066, '2024-10-29', '13:00:00', 'Completed', 35000.00, 126, 250, 238, 3);
INSERT INTO public.appointment VALUES (1067, '2025-12-19', '07:00:00', 'Scheduled', 35000.00, 20, 41, 47, 3);
INSERT INTO public.appointment VALUES (1068, '2025-03-06', '10:00:00', 'Completed', 8000.00, 306, 611, 95, 1);
INSERT INTO public.appointment VALUES (1069, '2025-04-10', '16:00:00', 'Completed', 15000.00, 342, 691, 196, 2);
INSERT INTO public.appointment VALUES (1070, '2025-11-03', '13:00:00', 'Scheduled', 10000.00, 87, 168, 173, 4);
INSERT INTO public.appointment VALUES (1071, '2024-12-24', '16:00:00', 'Cancelled', 35000.00, 464, 932, 7, 3);
INSERT INTO public.appointment VALUES (1072, '2024-09-04', '13:00:00', 'Completed', 10000.00, 40, 78, 67, 4);
INSERT INTO public.appointment VALUES (1073, '2024-12-15', '13:00:00', 'Completed', 15000.00, 423, 852, 107, 2);
INSERT INTO public.appointment VALUES (1074, '2025-11-09', '10:00:00', 'Scheduled', 15000.00, 153, 312, 43, 2);
INSERT INTO public.appointment VALUES (1075, '2025-09-07', '16:00:00', 'Scheduled', 8000.00, 286, 572, 60, 1);
INSERT INTO public.appointment VALUES (1076, '2024-01-29', '10:00:00', 'Cancelled', 10000.00, 251, 499, 78, 4);
INSERT INTO public.appointment VALUES (1077, '2025-07-24', '07:00:00', 'Scheduled', 8000.00, 100, 196, 20, 1);
INSERT INTO public.appointment VALUES (1078, '2024-08-22', '10:00:00', 'Completed', 15000.00, 183, 367, 187, 2);
INSERT INTO public.appointment VALUES (1079, '2025-05-01', '13:00:00', 'Completed', 15000.00, 167, 339, 176, 2);
INSERT INTO public.appointment VALUES (1080, '2025-07-16', '16:00:00', 'Scheduled', 8000.00, 31, 61, 126, 1);
INSERT INTO public.appointment VALUES (1081, '2024-08-13', '10:00:00', 'Completed', 8000.00, 296, 589, 140, 1);
INSERT INTO public.appointment VALUES (1082, '2025-01-21', '07:00:00', 'Completed', 15000.00, 340, 686, 212, 2);
INSERT INTO public.appointment VALUES (1083, '2024-12-23', '07:00:00', 'Completed', 8000.00, 120, 236, 160, 1);
INSERT INTO public.appointment VALUES (1084, '2025-08-12', '13:00:00', 'Scheduled', 15000.00, 360, 732, 103, 2);
INSERT INTO public.appointment VALUES (1085, '2025-11-12', '07:00:00', 'Scheduled', 8000.00, 54, 109, 102, 1);
INSERT INTO public.appointment VALUES (1086, '2025-08-24', '07:00:00', 'Scheduled', 35000.00, 479, 964, 223, 3);
INSERT INTO public.appointment VALUES (1087, '2025-12-11', '16:00:00', 'Scheduled', 35000.00, 431, 864, 208, 3);
INSERT INTO public.appointment VALUES (1088, '2024-04-12', '07:00:00', 'Completed', 35000.00, 331, 669, 150, 3);
INSERT INTO public.appointment VALUES (1089, '2025-08-29', '07:00:00', 'Scheduled', 35000.00, 378, 765, 107, 3);
INSERT INTO public.appointment VALUES (1090, '2025-06-30', '13:00:00', 'Scheduled', 15000.00, 424, 853, 99, 2);
INSERT INTO public.appointment VALUES (1091, '2025-09-01', '07:00:00', 'Scheduled', 8000.00, 22, 44, 54, 1);
INSERT INTO public.appointment VALUES (1092, '2024-01-10', '16:00:00', 'Completed', 15000.00, 229, 453, 60, 2);
INSERT INTO public.appointment VALUES (1093, '2025-02-25', '10:00:00', 'Cancelled', 35000.00, 134, 267, 104, 3);
INSERT INTO public.appointment VALUES (1094, '2024-04-11', '13:00:00', 'Completed', 8000.00, 177, 355, 178, 1);
INSERT INTO public.appointment VALUES (1095, '2025-09-10', '10:00:00', 'Scheduled', 15000.00, 133, 265, 5, 2);
INSERT INTO public.appointment VALUES (1096, '2025-09-12', '07:00:00', 'Scheduled', 15000.00, 359, 730, 204, 2);
INSERT INTO public.appointment VALUES (1097, '2025-02-09', '13:00:00', 'Completed', 8000.00, 492, 985, 133, 1);
INSERT INTO public.appointment VALUES (1098, '2025-07-13', '10:00:00', 'Scheduled', 15000.00, 301, 602, 90, 2);
INSERT INTO public.appointment VALUES (1099, '2024-08-30', '07:00:00', 'Completed', 8000.00, 110, 218, 70, 1);
INSERT INTO public.appointment VALUES (1100, '2025-06-05', '10:00:00', 'Scheduled', 35000.00, 452, 905, 230, 3);
INSERT INTO public.appointment VALUES (1101, '2025-08-19', '13:00:00', 'Scheduled', 8000.00, 375, 757, 218, 1);
INSERT INTO public.appointment VALUES (1102, '2025-05-05', '16:00:00', 'Cancelled', 15000.00, 469, 943, 55, 2);
INSERT INTO public.appointment VALUES (1103, '2024-02-23', '10:00:00', 'Completed', 8000.00, 249, 494, 200, 1);
INSERT INTO public.appointment VALUES (1104, '2025-02-21', '13:00:00', 'Cancelled', 10000.00, 52, 106, 101, 4);
INSERT INTO public.appointment VALUES (1105, '2024-05-30', '10:00:00', 'Completed', 15000.00, 183, 368, 63, 2);
INSERT INTO public.appointment VALUES (1106, '2025-07-28', '07:00:00', 'Scheduled', 35000.00, 169, 342, 147, 3);
INSERT INTO public.appointment VALUES (1107, '2025-06-03', '16:00:00', 'Scheduled', 35000.00, 50, 99, 192, 3);
INSERT INTO public.appointment VALUES (1108, '2024-04-25', '07:00:00', 'Completed', 10000.00, 294, 587, 68, 4);
INSERT INTO public.appointment VALUES (1109, '2025-02-28', '13:00:00', 'Completed', 10000.00, 237, 468, 201, 4);
INSERT INTO public.appointment VALUES (1110, '2023-07-16', '07:00:00', 'Completed', 15000.00, 232, 459, 222, 2);
INSERT INTO public.appointment VALUES (1111, '2025-08-13', '07:00:00', 'Scheduled', 8000.00, 318, 639, 167, 1);
INSERT INTO public.appointment VALUES (1112, '2024-11-10', '07:00:00', 'Completed', 8000.00, 374, 756, 152, 1);
INSERT INTO public.appointment VALUES (1113, '2024-05-22', '13:00:00', 'Completed', 15000.00, 313, 626, 45, 2);
INSERT INTO public.appointment VALUES (1114, '2025-09-24', '07:00:00', 'Scheduled', 35000.00, 213, 418, 20, 3);
INSERT INTO public.appointment VALUES (1115, '2025-06-29', '13:00:00', 'Scheduled', 8000.00, 307, 613, 169, 1);
INSERT INTO public.appointment VALUES (1116, '2025-06-20', '07:00:00', 'Scheduled', 35000.00, 328, 661, 233, 3);
INSERT INTO public.appointment VALUES (1117, '2025-01-01', '13:00:00', 'Cancelled', 8000.00, 35, 69, 81, 1);
INSERT INTO public.appointment VALUES (1118, '2025-07-29', '13:00:00', 'Scheduled', 15000.00, 313, 626, 111, 2);
INSERT INTO public.appointment VALUES (1119, '2025-03-19', '13:00:00', 'Completed', 8000.00, 319, 642, 132, 1);
INSERT INTO public.appointment VALUES (1120, '2025-08-12', '16:00:00', 'Scheduled', 10000.00, 483, 972, 116, 4);
INSERT INTO public.appointment VALUES (1121, '2025-08-16', '10:00:00', 'Scheduled', 8000.00, 211, 415, 69, 1);
INSERT INTO public.appointment VALUES (1122, '2025-05-20', '16:00:00', 'Scheduled', 35000.00, 439, 883, 7, 3);
INSERT INTO public.appointment VALUES (1123, '2024-08-12', '16:00:00', 'Completed', 35000.00, 332, 671, 153, 3);
INSERT INTO public.appointment VALUES (1124, '2024-12-19', '13:00:00', 'Cancelled', 8000.00, 221, 436, 157, 1);
INSERT INTO public.appointment VALUES (1125, '2024-06-22', '16:00:00', 'Completed', 10000.00, 403, 818, 176, 4);
INSERT INTO public.appointment VALUES (1126, '2025-06-14', '13:00:00', 'Scheduled', 10000.00, 338, 683, 72, 4);
INSERT INTO public.appointment VALUES (1127, '2025-04-26', '07:00:00', 'Completed', 8000.00, 377, 762, 29, 1);
INSERT INTO public.appointment VALUES (1128, '2025-02-15', '10:00:00', 'Completed', 8000.00, 41, 82, 150, 1);
INSERT INTO public.appointment VALUES (1129, '2024-10-14', '13:00:00', 'Completed', 35000.00, 330, 664, 73, 3);
INSERT INTO public.appointment VALUES (1130, '2023-08-11', '16:00:00', 'Completed', 10000.00, 75, 145, 28, 4);
INSERT INTO public.appointment VALUES (1131, '2025-10-28', '13:00:00', 'Scheduled', 10000.00, 107, 211, 26, 4);
INSERT INTO public.appointment VALUES (1132, '2025-10-26', '07:00:00', 'Scheduled', 10000.00, 189, 379, 195, 4);
INSERT INTO public.appointment VALUES (1133, '2025-11-29', '10:00:00', 'Scheduled', 15000.00, 174, 350, 179, 2);
INSERT INTO public.appointment VALUES (1134, '2025-11-07', '10:00:00', 'Scheduled', 8000.00, 242, 484, 46, 1);
INSERT INTO public.appointment VALUES (1135, '2025-04-15', '16:00:00', 'Completed', 15000.00, 211, 415, 131, 2);
INSERT INTO public.appointment VALUES (1136, '2024-04-03', '16:00:00', 'Completed', 15000.00, 197, 392, 36, 2);
INSERT INTO public.appointment VALUES (1137, '2024-12-31', '07:00:00', 'Cancelled', 15000.00, 246, 489, 23, 2);
INSERT INTO public.appointment VALUES (1139, '2023-08-21', '16:00:00', 'Cancelled', 8000.00, 383, 777, 90, 1);
INSERT INTO public.appointment VALUES (1140, '2025-11-28', '07:00:00', 'Scheduled', 15000.00, 278, 557, 161, 2);
INSERT INTO public.appointment VALUES (1141, '2025-06-09', '13:00:00', 'Scheduled', 8000.00, 388, 790, 153, 1);
INSERT INTO public.appointment VALUES (1142, '2025-10-07', '13:00:00', 'Scheduled', 35000.00, 417, 840, 60, 3);
INSERT INTO public.appointment VALUES (1143, '2025-07-21', '13:00:00', 'Scheduled', 15000.00, 444, 891, 90, 2);
INSERT INTO public.appointment VALUES (1144, '2025-05-11', '07:00:00', 'Completed', 15000.00, 312, 623, 116, 2);
INSERT INTO public.appointment VALUES (1145, '2024-12-22', '16:00:00', 'Completed', 8000.00, 61, 121, 128, 1);
INSERT INTO public.appointment VALUES (1146, '2025-02-08', '13:00:00', 'Cancelled', 35000.00, 245, 488, 74, 3);
INSERT INTO public.appointment VALUES (1147, '2025-11-19', '16:00:00', 'Scheduled', 15000.00, 67, 130, 199, 2);
INSERT INTO public.appointment VALUES (1148, '2025-09-22', '13:00:00', 'Scheduled', 10000.00, 462, 926, 189, 4);
INSERT INTO public.appointment VALUES (1149, '2024-05-24', '10:00:00', 'Completed', 15000.00, 216, 425, 229, 2);
INSERT INTO public.appointment VALUES (1150, '2024-01-12', '10:00:00', 'Completed', 10000.00, 365, 740, 134, 4);
INSERT INTO public.appointment VALUES (1151, '2025-11-28', '07:00:00', 'Scheduled', 10000.00, 445, 892, 200, 4);
INSERT INTO public.appointment VALUES (1152, '2025-09-14', '16:00:00', 'Scheduled', 8000.00, 411, 828, 238, 1);
INSERT INTO public.appointment VALUES (1153, '2025-10-10', '07:00:00', 'Scheduled', 8000.00, 61, 121, 138, 1);
INSERT INTO public.appointment VALUES (1154, '2024-12-13', '13:00:00', 'Cancelled', 35000.00, 303, 606, 130, 3);
INSERT INTO public.appointment VALUES (1155, '2024-12-24', '07:00:00', 'Completed', 10000.00, 45, 90, 210, 4);
INSERT INTO public.appointment VALUES (1156, '2024-09-14', '13:00:00', 'Completed', 10000.00, 457, 912, 82, 4);
INSERT INTO public.appointment VALUES (1157, '2025-04-10', '13:00:00', 'Completed', 35000.00, 259, 515, 115, 3);
INSERT INTO public.appointment VALUES (1158, '2025-08-09', '10:00:00', 'Scheduled', 15000.00, 95, 184, 88, 2);
INSERT INTO public.appointment VALUES (1159, '2025-05-10', '07:00:00', 'Completed', 8000.00, 132, 262, 29, 1);
INSERT INTO public.appointment VALUES (1160, '2025-01-19', '13:00:00', 'Completed', 35000.00, 81, 156, 208, 3);
INSERT INTO public.appointment VALUES (1161, '2025-10-22', '10:00:00', 'Scheduled', 15000.00, 404, 820, 195, 2);
INSERT INTO public.appointment VALUES (1162, '2025-01-23', '07:00:00', 'Completed', 8000.00, 185, 373, 37, 1);
INSERT INTO public.appointment VALUES (1163, '2023-04-05', '16:00:00', 'Completed', 35000.00, 226, 447, 165, 3);
INSERT INTO public.appointment VALUES (1164, '2025-10-07', '10:00:00', 'Scheduled', 35000.00, 133, 264, 140, 3);
INSERT INTO public.appointment VALUES (1165, '2025-07-31', '10:00:00', 'Scheduled', 35000.00, 222, 437, 21, 3);
INSERT INTO public.appointment VALUES (1166, '2024-09-24', '10:00:00', 'Completed', 10000.00, 207, 409, 37, 4);
INSERT INTO public.appointment VALUES (1167, '2025-10-22', '10:00:00', 'Scheduled', 15000.00, 118, 233, 44, 2);
INSERT INTO public.appointment VALUES (1168, '2024-07-20', '10:00:00', 'Completed', 35000.00, 39, 75, 119, 3);
INSERT INTO public.appointment VALUES (1169, '2025-04-27', '16:00:00', 'Completed', 15000.00, 348, 705, 18, 2);
INSERT INTO public.appointment VALUES (1170, '2025-03-24', '10:00:00', 'Completed', 10000.00, 17, 35, 154, 4);
INSERT INTO public.appointment VALUES (1171, '2023-05-30', '07:00:00', 'Cancelled', 35000.00, 13, 26, 122, 3);
INSERT INTO public.appointment VALUES (1172, '2024-06-17', '13:00:00', 'Completed', 15000.00, 44, 86, 206, 2);
INSERT INTO public.appointment VALUES (1173, '2025-03-03', '07:00:00', 'Completed', 8000.00, 433, 867, 202, 1);
INSERT INTO public.appointment VALUES (1174, '2025-04-28', '07:00:00', 'Completed', 8000.00, 190, 381, 27, 1);
INSERT INTO public.appointment VALUES (1175, '2025-10-07', '07:00:00', 'Scheduled', 35000.00, 22, 44, 199, 3);
INSERT INTO public.appointment VALUES (1176, '2025-06-04', '13:00:00', 'Scheduled', 10000.00, 249, 494, 30, 4);
INSERT INTO public.appointment VALUES (1177, '2025-05-17', '07:00:00', 'Scheduled', 35000.00, 248, 492, 171, 3);
INSERT INTO public.appointment VALUES (1178, '2025-03-02', '07:00:00', 'Completed', 10000.00, 360, 732, 90, 4);
INSERT INTO public.appointment VALUES (1179, '2025-05-10', '16:00:00', 'Completed', 10000.00, 93, 181, 207, 4);
INSERT INTO public.appointment VALUES (1180, '2024-09-20', '16:00:00', 'Completed', 15000.00, 342, 694, 173, 2);
INSERT INTO public.appointment VALUES (1181, '2025-07-03', '13:00:00', 'Scheduled', 15000.00, 189, 378, 196, 2);
INSERT INTO public.appointment VALUES (1182, '2025-04-10', '13:00:00', 'Completed', 15000.00, 56, 112, 129, 2);
INSERT INTO public.appointment VALUES (1183, '2024-04-16', '16:00:00', 'Cancelled', 8000.00, 175, 353, 213, 1);
INSERT INTO public.appointment VALUES (1184, '2025-10-07', '10:00:00', 'Scheduled', 35000.00, 391, 795, 130, 3);
INSERT INTO public.appointment VALUES (1185, '2025-02-03', '13:00:00', 'Completed', 10000.00, 114, 224, 237, 4);
INSERT INTO public.appointment VALUES (1186, '2023-08-07', '16:00:00', 'Cancelled', 35000.00, 371, 750, 136, 3);
INSERT INTO public.appointment VALUES (1187, '2025-05-10', '10:00:00', 'Completed', 35000.00, 461, 925, 118, 3);
INSERT INTO public.appointment VALUES (1188, '2025-10-26', '13:00:00', 'Scheduled', 15000.00, 304, 608, 191, 2);
INSERT INTO public.appointment VALUES (1189, '2025-09-20', '13:00:00', 'Scheduled', 10000.00, 257, 509, 217, 4);
INSERT INTO public.appointment VALUES (1190, '2025-02-05', '07:00:00', 'Completed', 35000.00, 382, 772, 150, 3);
INSERT INTO public.appointment VALUES (1191, '2024-07-14', '13:00:00', 'Completed', 8000.00, 332, 671, 17, 1);
INSERT INTO public.appointment VALUES (1192, '2025-10-08', '07:00:00', 'Scheduled', 35000.00, 24, 48, 44, 3);
INSERT INTO public.appointment VALUES (1193, '2024-10-02', '07:00:00', 'Completed', 8000.00, 105, 206, 232, 1);
INSERT INTO public.appointment VALUES (1194, '2023-12-04', '07:00:00', 'Completed', 15000.00, 294, 586, 57, 2);
INSERT INTO public.appointment VALUES (1195, '2024-07-01', '10:00:00', 'Completed', 15000.00, 50, 101, 193, 2);
INSERT INTO public.appointment VALUES (1196, '2025-08-31', '10:00:00', 'Scheduled', 15000.00, 246, 489, 153, 2);
INSERT INTO public.appointment VALUES (1197, '2023-10-12', '13:00:00', 'Completed', 8000.00, 109, 216, 96, 1);
INSERT INTO public.appointment VALUES (1198, '2025-08-11', '10:00:00', 'Scheduled', 10000.00, 151, 305, 44, 4);
INSERT INTO public.appointment VALUES (1199, '2025-11-04', '16:00:00', 'Scheduled', 8000.00, 222, 437, 161, 1);
INSERT INTO public.appointment VALUES (1200, '2025-09-15', '10:00:00', 'Scheduled', 10000.00, 348, 705, 29, 4);
INSERT INTO public.appointment VALUES (1201, '2025-03-24', '10:00:00', 'Completed', 35000.00, 38, 74, 113, 3);
INSERT INTO public.appointment VALUES (1202, '2025-08-10', '13:00:00', 'Scheduled', 10000.00, 450, 902, 162, 4);
INSERT INTO public.appointment VALUES (1203, '2025-10-16', '13:00:00', 'Scheduled', 35000.00, 80, 154, 166, 3);
INSERT INTO public.appointment VALUES (1204, '2025-06-11', '13:00:00', 'Scheduled', 8000.00, 247, 490, 108, 1);
INSERT INTO public.appointment VALUES (1205, '2025-10-28', '07:00:00', 'Scheduled', 10000.00, 293, 585, 190, 4);
INSERT INTO public.appointment VALUES (1206, '2025-06-03', '16:00:00', 'Scheduled', 35000.00, 185, 373, 210, 3);
INSERT INTO public.appointment VALUES (1207, '2023-09-26', '07:00:00', 'Completed', 10000.00, 126, 249, 108, 4);
INSERT INTO public.appointment VALUES (1208, '2025-04-25', '07:00:00', 'Completed', 8000.00, 342, 691, 184, 1);
INSERT INTO public.appointment VALUES (1209, '2025-12-22', '07:00:00', 'Scheduled', 10000.00, 21, 43, 201, 4);
INSERT INTO public.appointment VALUES (1210, '2024-04-17', '10:00:00', 'Completed', 35000.00, 286, 572, 69, 3);
INSERT INTO public.appointment VALUES (1211, '2025-12-23', '16:00:00', 'Scheduled', 35000.00, 274, 549, 31, 3);
INSERT INTO public.appointment VALUES (1212, '2025-08-01', '07:00:00', 'Scheduled', 15000.00, 438, 881, 170, 2);
INSERT INTO public.appointment VALUES (1213, '2025-05-03', '10:00:00', 'Completed', 8000.00, 256, 507, 147, 1);
INSERT INTO public.appointment VALUES (1214, '2024-11-03', '13:00:00', 'Completed', 8000.00, 109, 216, 200, 1);
INSERT INTO public.appointment VALUES (1215, '2025-11-29', '16:00:00', 'Scheduled', 10000.00, 185, 372, 36, 4);
INSERT INTO public.appointment VALUES (1216, '2024-12-08', '13:00:00', 'Completed', 8000.00, 295, 588, 192, 1);
INSERT INTO public.appointment VALUES (1217, '2025-02-02', '13:00:00', 'Cancelled', 15000.00, 309, 618, 42, 2);
INSERT INTO public.appointment VALUES (1218, '2025-11-19', '16:00:00', 'Scheduled', 35000.00, 143, 287, 169, 3);
INSERT INTO public.appointment VALUES (1219, '2024-11-27', '10:00:00', 'Cancelled', 35000.00, 216, 425, 72, 3);
INSERT INTO public.appointment VALUES (1220, '2025-05-11', '16:00:00', 'Completed', 35000.00, 129, 259, 82, 3);
INSERT INTO public.appointment VALUES (1221, '2024-09-26', '16:00:00', 'Completed', 35000.00, 209, 412, 94, 3);
INSERT INTO public.appointment VALUES (1222, '2025-04-03', '07:00:00', 'Completed', 35000.00, 440, 885, 173, 3);
INSERT INTO public.appointment VALUES (1223, '2025-02-05', '16:00:00', 'Completed', 35000.00, 285, 571, 203, 3);
INSERT INTO public.appointment VALUES (1224, '2024-04-10', '13:00:00', 'Completed', 35000.00, 251, 499, 123, 3);
INSERT INTO public.appointment VALUES (1225, '2025-01-17', '10:00:00', 'Completed', 15000.00, 183, 367, 140, 2);
INSERT INTO public.appointment VALUES (1226, '2025-07-25', '16:00:00', 'Scheduled', 35000.00, 288, 576, 116, 3);
INSERT INTO public.appointment VALUES (1227, '2025-10-08', '16:00:00', 'Scheduled', 8000.00, 233, 460, 59, 1);
INSERT INTO public.appointment VALUES (1228, '2024-09-23', '16:00:00', 'Completed', 35000.00, 330, 665, 205, 3);
INSERT INTO public.appointment VALUES (1229, '2023-09-25', '07:00:00', 'Cancelled', 35000.00, 267, 532, 53, 3);
INSERT INTO public.appointment VALUES (1230, '2025-01-19', '10:00:00', 'Completed', 35000.00, 107, 211, 240, 3);
INSERT INTO public.appointment VALUES (1231, '2025-07-17', '07:00:00', 'Scheduled', 15000.00, 207, 409, 104, 2);
INSERT INTO public.appointment VALUES (1232, '2024-05-14', '07:00:00', 'Completed', 10000.00, 285, 571, 75, 4);
INSERT INTO public.appointment VALUES (1233, '2025-10-02', '10:00:00', 'Scheduled', 15000.00, 404, 820, 26, 2);
INSERT INTO public.appointment VALUES (1234, '2024-04-14', '16:00:00', 'Completed', 8000.00, 183, 369, 214, 1);
INSERT INTO public.appointment VALUES (1235, '2025-08-19', '07:00:00', 'Scheduled', 15000.00, 389, 792, 31, 2);
INSERT INTO public.appointment VALUES (1236, '2024-10-17', '07:00:00', 'Completed', 10000.00, 280, 562, 142, 4);
INSERT INTO public.appointment VALUES (1237, '2025-02-02', '07:00:00', 'Completed', 10000.00, 330, 666, 181, 4);
INSERT INTO public.appointment VALUES (1238, '2025-10-20', '07:00:00', 'Scheduled', 8000.00, 60, 120, 198, 1);
INSERT INTO public.appointment VALUES (1239, '2025-11-08', '07:00:00', 'Scheduled', 15000.00, 446, 893, 203, 2);
INSERT INTO public.appointment VALUES (1240, '2025-05-24', '10:00:00', 'Scheduled', 15000.00, 249, 496, 128, 2);
INSERT INTO public.appointment VALUES (1241, '2025-06-06', '07:00:00', 'Scheduled', 15000.00, 382, 772, 145, 2);
INSERT INTO public.appointment VALUES (1242, '2025-03-27', '10:00:00', 'Cancelled', 10000.00, 32, 62, 130, 4);
INSERT INTO public.appointment VALUES (1243, '2025-04-12', '13:00:00', 'Completed', 8000.00, 143, 287, 92, 1);
INSERT INTO public.appointment VALUES (1244, '2024-01-21', '16:00:00', 'Completed', 15000.00, 29, 59, 129, 2);
INSERT INTO public.appointment VALUES (1245, '2024-09-29', '16:00:00', 'Completed', 15000.00, 215, 422, 52, 2);
INSERT INTO public.appointment VALUES (1246, '2025-06-12', '10:00:00', 'Scheduled', 15000.00, 173, 349, 79, 2);
INSERT INTO public.appointment VALUES (1247, '2025-04-30', '07:00:00', 'Completed', 35000.00, 221, 435, 120, 3);
INSERT INTO public.appointment VALUES (1248, '2024-05-05', '13:00:00', 'Completed', 35000.00, 299, 596, 201, 3);
INSERT INTO public.appointment VALUES (1249, '2025-02-27', '07:00:00', 'Completed', 35000.00, 228, 449, 77, 3);
INSERT INTO public.appointment VALUES (1250, '2025-03-29', '07:00:00', 'Cancelled', 15000.00, 406, 822, 166, 2);
INSERT INTO public.appointment VALUES (1251, '2025-10-26', '10:00:00', 'Scheduled', 15000.00, 410, 827, 33, 2);
INSERT INTO public.appointment VALUES (1252, '2024-07-17', '13:00:00', 'Completed', 10000.00, 197, 392, 44, 4);
INSERT INTO public.appointment VALUES (1253, '2024-09-07', '16:00:00', 'Completed', 10000.00, 197, 392, 141, 4);
INSERT INTO public.appointment VALUES (1254, '2025-03-03', '16:00:00', 'Completed', 8000.00, 76, 146, 119, 1);
INSERT INTO public.appointment VALUES (1255, '2025-09-26', '16:00:00', 'Scheduled', 8000.00, 420, 847, 239, 1);
INSERT INTO public.appointment VALUES (1256, '2024-08-15', '10:00:00', 'Completed', 8000.00, 49, 98, 13, 1);
INSERT INTO public.appointment VALUES (1257, '2024-11-26', '10:00:00', 'Completed', 15000.00, 298, 594, 55, 2);
INSERT INTO public.appointment VALUES (1258, '2025-11-16', '16:00:00', 'Scheduled', 8000.00, 221, 435, 188, 1);
INSERT INTO public.appointment VALUES (1259, '2023-12-04', '13:00:00', 'Completed', 10000.00, 43, 85, 112, 4);
INSERT INTO public.appointment VALUES (1260, '2025-08-16', '07:00:00', 'Scheduled', 8000.00, 417, 841, 220, 1);
INSERT INTO public.appointment VALUES (1261, '2025-06-05', '16:00:00', 'Scheduled', 8000.00, 348, 706, 98, 1);
INSERT INTO public.appointment VALUES (1262, '2025-11-19', '13:00:00', 'Scheduled', 15000.00, 80, 154, 176, 2);
INSERT INTO public.appointment VALUES (1263, '2024-07-24', '07:00:00', 'Completed', 10000.00, 207, 409, 135, 4);
INSERT INTO public.appointment VALUES (1264, '2025-04-25', '10:00:00', 'Completed', 10000.00, 192, 383, 125, 4);
INSERT INTO public.appointment VALUES (1265, '2024-12-29', '16:00:00', 'Completed', 35000.00, 295, 588, 119, 3);
INSERT INTO public.appointment VALUES (1266, '2025-06-27', '13:00:00', 'Scheduled', 35000.00, 339, 684, 1, 3);
INSERT INTO public.appointment VALUES (1267, '2025-02-23', '13:00:00', 'Completed', 35000.00, 499, 997, 151, 3);
INSERT INTO public.appointment VALUES (1268, '2025-04-05', '16:00:00', 'Completed', 35000.00, 212, 417, 204, 3);
INSERT INTO public.appointment VALUES (1269, '2025-08-09', '16:00:00', 'Scheduled', 8000.00, 372, 751, 210, 1);
INSERT INTO public.appointment VALUES (1270, '2024-05-23', '13:00:00', 'Completed', 8000.00, 346, 702, 154, 1);
INSERT INTO public.appointment VALUES (1271, '2025-12-25', '07:00:00', 'Scheduled', 15000.00, 22, 44, 5, 2);
INSERT INTO public.appointment VALUES (1272, '2025-04-02', '13:00:00', 'Cancelled', 8000.00, 180, 361, 228, 1);
INSERT INTO public.appointment VALUES (1273, '2025-09-05', '10:00:00', 'Scheduled', 15000.00, 273, 547, 17, 2);
INSERT INTO public.appointment VALUES (1274, '2024-05-29', '10:00:00', 'Cancelled', 10000.00, 357, 726, 185, 4);
INSERT INTO public.appointment VALUES (1275, '2025-06-02', '10:00:00', 'Scheduled', 15000.00, 422, 851, 224, 2);
INSERT INTO public.appointment VALUES (1276, '2025-09-29', '16:00:00', 'Scheduled', 10000.00, 178, 357, 54, 4);
INSERT INTO public.appointment VALUES (1277, '2025-10-15', '13:00:00', 'Scheduled', 8000.00, 282, 567, 234, 1);
INSERT INTO public.appointment VALUES (1278, '2025-12-30', '13:00:00', 'Scheduled', 10000.00, 475, 956, 182, 4);
INSERT INTO public.appointment VALUES (1279, '2025-06-15', '10:00:00', 'Scheduled', 10000.00, 328, 660, 223, 4);
INSERT INTO public.appointment VALUES (1280, '2025-11-01', '10:00:00', 'Scheduled', 10000.00, 302, 605, 89, 4);
INSERT INTO public.appointment VALUES (1281, '2025-06-30', '07:00:00', 'Scheduled', 35000.00, 474, 954, 59, 3);
INSERT INTO public.appointment VALUES (1282, '2025-07-12', '07:00:00', 'Scheduled', 10000.00, 353, 718, 4, 4);
INSERT INTO public.appointment VALUES (1283, '2024-09-30', '16:00:00', 'Completed', 8000.00, 443, 890, 66, 1);
INSERT INTO public.appointment VALUES (1284, '2023-09-09', '10:00:00', 'Cancelled', 8000.00, 85, 161, 214, 1);
INSERT INTO public.appointment VALUES (1285, '2025-05-19', '07:00:00', 'Scheduled', 15000.00, 348, 705, 189, 2);
INSERT INTO public.appointment VALUES (1286, '2025-01-07', '16:00:00', 'Completed', 15000.00, 259, 516, 65, 2);
INSERT INTO public.appointment VALUES (1287, '2025-09-28', '10:00:00', 'Scheduled', 10000.00, 373, 755, 170, 4);
INSERT INTO public.appointment VALUES (1288, '2025-10-12', '10:00:00', 'Scheduled', 15000.00, 111, 219, 208, 2);
INSERT INTO public.appointment VALUES (1289, '2023-10-11', '13:00:00', 'Completed', 35000.00, 279, 559, 7, 3);
INSERT INTO public.appointment VALUES (1290, '2023-10-23', '07:00:00', 'Completed', 15000.00, 322, 648, 56, 2);
INSERT INTO public.appointment VALUES (1291, '2024-06-22', '10:00:00', 'Completed', 15000.00, 299, 596, 116, 2);
INSERT INTO public.appointment VALUES (1292, '2024-01-31', '07:00:00', 'Completed', 35000.00, 457, 912, 28, 3);
INSERT INTO public.appointment VALUES (1293, '2025-12-01', '07:00:00', 'Scheduled', 15000.00, 155, 316, 226, 2);
INSERT INTO public.appointment VALUES (1294, '2024-07-03', '16:00:00', 'Completed', 8000.00, 245, 488, 235, 1);
INSERT INTO public.appointment VALUES (1295, '2024-09-02', '07:00:00', 'Completed', 10000.00, 71, 138, 211, 4);
INSERT INTO public.appointment VALUES (1296, '2024-12-03', '10:00:00', 'Completed', 35000.00, 421, 849, 120, 3);
INSERT INTO public.appointment VALUES (1297, '2024-03-23', '07:00:00', 'Completed', 10000.00, 20, 42, 189, 4);
INSERT INTO public.appointment VALUES (1298, '2025-07-27', '07:00:00', 'Scheduled', 35000.00, 139, 280, 75, 3);
INSERT INTO public.appointment VALUES (1299, '2025-07-20', '16:00:00', 'Scheduled', 8000.00, 417, 841, 42, 1);
INSERT INTO public.appointment VALUES (1300, '2024-04-07', '07:00:00', 'Completed', 8000.00, 158, 322, 230, 1);
INSERT INTO public.appointment VALUES (1301, '2024-10-07', '13:00:00', 'Cancelled', 35000.00, 224, 441, 160, 3);
INSERT INTO public.appointment VALUES (1302, '2025-10-27', '13:00:00', 'Scheduled', 15000.00, 93, 182, 113, 2);
INSERT INTO public.appointment VALUES (1303, '2025-05-18', '07:00:00', 'Scheduled', 10000.00, 346, 702, 209, 4);
INSERT INTO public.appointment VALUES (1304, '2024-10-04', '07:00:00', 'Cancelled', 15000.00, 179, 359, 147, 2);
INSERT INTO public.appointment VALUES (1305, '2024-01-29', '10:00:00', 'Cancelled', 15000.00, 71, 138, 106, 2);
INSERT INTO public.appointment VALUES (1306, '2025-10-01', '16:00:00', 'Scheduled', 8000.00, 160, 325, 30, 1);
INSERT INTO public.appointment VALUES (1307, '2024-03-09', '07:00:00', 'Completed', 35000.00, 104, 204, 231, 3);
INSERT INTO public.appointment VALUES (1308, '2025-10-04', '13:00:00', 'Scheduled', 10000.00, 497, 993, 192, 4);
INSERT INTO public.appointment VALUES (1309, '2025-04-15', '13:00:00', 'Completed', 10000.00, 273, 547, 47, 4);
INSERT INTO public.appointment VALUES (1310, '2025-12-16', '13:00:00', 'Scheduled', 8000.00, 461, 925, 227, 1);
INSERT INTO public.appointment VALUES (1311, '2024-08-11', '07:00:00', 'Completed', 10000.00, 117, 232, 106, 4);
INSERT INTO public.appointment VALUES (1312, '2024-04-25', '07:00:00', 'Completed', 15000.00, 78, 149, 86, 2);
INSERT INTO public.appointment VALUES (1313, '2025-08-24', '13:00:00', 'Scheduled', 15000.00, 487, 977, 173, 2);
INSERT INTO public.appointment VALUES (1314, '2024-12-10', '13:00:00', 'Completed', 35000.00, 371, 750, 199, 3);
INSERT INTO public.appointment VALUES (1315, '2025-06-27', '10:00:00', 'Scheduled', 35000.00, 454, 908, 235, 3);
INSERT INTO public.appointment VALUES (1316, '2023-04-30', '10:00:00', 'Completed', 8000.00, 325, 656, 21, 1);
INSERT INTO public.appointment VALUES (1317, '2025-09-08', '07:00:00', 'Scheduled', 15000.00, 228, 451, 129, 2);
INSERT INTO public.appointment VALUES (1318, '2025-06-13', '07:00:00', 'Scheduled', 8000.00, 458, 917, 205, 1);
INSERT INTO public.appointment VALUES (1319, '2025-11-26', '10:00:00', 'Scheduled', 8000.00, 485, 975, 223, 1);
INSERT INTO public.appointment VALUES (1320, '2024-12-06', '16:00:00', 'Cancelled', 15000.00, 455, 910, 202, 2);
INSERT INTO public.appointment VALUES (1321, '2025-05-19', '07:00:00', 'Scheduled', 15000.00, 81, 155, 25, 2);
INSERT INTO public.appointment VALUES (1322, '2023-04-16', '07:00:00', 'Completed', 35000.00, 53, 107, 117, 3);
INSERT INTO public.appointment VALUES (1323, '2025-07-30', '16:00:00', 'Scheduled', 8000.00, 270, 540, 13, 1);
INSERT INTO public.appointment VALUES (1324, '2025-06-16', '13:00:00', 'Scheduled', 10000.00, 207, 409, 26, 4);
INSERT INTO public.appointment VALUES (1325, '2024-11-24', '13:00:00', 'Completed', 8000.00, 438, 881, 53, 1);
INSERT INTO public.appointment VALUES (1326, '2025-12-26', '16:00:00', 'Scheduled', 10000.00, 275, 551, 39, 4);
INSERT INTO public.appointment VALUES (1327, '2025-11-14', '16:00:00', 'Scheduled', 35000.00, 356, 724, 187, 3);
INSERT INTO public.appointment VALUES (1328, '2025-12-30', '16:00:00', 'Scheduled', 8000.00, 394, 799, 70, 1);
INSERT INTO public.appointment VALUES (1329, '2024-07-23', '07:00:00', 'Cancelled', 15000.00, 223, 439, 231, 2);
INSERT INTO public.appointment VALUES (1330, '2024-10-09', '07:00:00', 'Completed', 35000.00, 299, 596, 215, 3);
INSERT INTO public.appointment VALUES (1331, '2024-10-31', '13:00:00', 'Completed', 8000.00, 244, 487, 14, 1);
INSERT INTO public.appointment VALUES (1332, '2024-11-20', '13:00:00', 'Cancelled', 8000.00, 192, 383, 112, 1);
INSERT INTO public.appointment VALUES (1333, '2025-12-17', '07:00:00', 'Scheduled', 8000.00, 13, 26, 206, 1);
INSERT INTO public.appointment VALUES (1334, '2025-01-01', '13:00:00', 'Completed', 8000.00, 419, 844, 235, 1);
INSERT INTO public.appointment VALUES (1335, '2024-09-07', '13:00:00', 'Completed', 15000.00, 68, 135, 234, 2);
INSERT INTO public.appointment VALUES (1336, '2024-01-08', '13:00:00', 'Completed', 8000.00, 136, 271, 239, 1);
INSERT INTO public.appointment VALUES (1337, '2024-06-15', '13:00:00', 'Completed', 8000.00, 296, 590, 30, 1);
INSERT INTO public.appointment VALUES (1338, '2025-07-01', '16:00:00', 'Scheduled', 15000.00, 475, 956, 141, 2);
INSERT INTO public.appointment VALUES (1339, '2025-04-05', '13:00:00', 'Completed', 10000.00, 351, 712, 74, 4);
INSERT INTO public.appointment VALUES (1340, '2025-02-28', '10:00:00', 'Completed', 10000.00, 391, 795, 175, 4);
INSERT INTO public.appointment VALUES (1341, '2024-04-30', '07:00:00', 'Completed', 10000.00, 331, 668, 67, 4);
INSERT INTO public.appointment VALUES (1342, '2025-08-28', '10:00:00', 'Scheduled', 8000.00, 66, 127, 162, 1);
INSERT INTO public.appointment VALUES (1343, '2024-09-01', '13:00:00', 'Cancelled', 8000.00, 103, 201, 149, 1);
INSERT INTO public.appointment VALUES (1344, '2024-05-06', '16:00:00', 'Cancelled', 35000.00, 399, 810, 142, 3);
INSERT INTO public.appointment VALUES (1345, '2025-04-03', '10:00:00', 'Cancelled', 10000.00, 9, 19, 241, 4);
INSERT INTO public.appointment VALUES (1346, '2025-03-16', '16:00:00', 'Completed', 8000.00, 267, 532, 82, 1);
INSERT INTO public.appointment VALUES (1347, '2024-01-27', '07:00:00', 'Cancelled', 15000.00, 396, 801, 159, 2);
INSERT INTO public.appointment VALUES (1348, '2023-09-20', '10:00:00', 'Completed', 15000.00, 322, 648, 17, 2);
INSERT INTO public.appointment VALUES (1349, '2024-09-19', '10:00:00', 'Cancelled', 10000.00, 13, 26, 135, 4);
INSERT INTO public.appointment VALUES (1350, '2025-11-05', '16:00:00', 'Scheduled', 15000.00, 477, 961, 44, 2);
INSERT INTO public.appointment VALUES (1351, '2025-10-29', '07:00:00', 'Scheduled', 10000.00, 226, 447, 230, 4);
INSERT INTO public.appointment VALUES (1352, '2025-06-07', '16:00:00', 'Scheduled', 8000.00, 389, 792, 128, 1);
INSERT INTO public.appointment VALUES (1353, '2025-06-14', '10:00:00', 'Scheduled', 10000.00, 484, 973, 11, 4);
INSERT INTO public.appointment VALUES (1354, '2025-11-04', '16:00:00', 'Scheduled', 10000.00, 337, 680, 75, 4);
INSERT INTO public.appointment VALUES (1355, '2024-10-28', '07:00:00', 'Completed', 10000.00, 375, 758, 187, 4);
INSERT INTO public.appointment VALUES (1356, '2024-12-19', '10:00:00', 'Cancelled', 35000.00, 79, 153, 109, 3);
INSERT INTO public.appointment VALUES (1357, '2024-12-30', '13:00:00', 'Completed', 35000.00, 369, 747, 154, 3);
INSERT INTO public.appointment VALUES (1358, '2023-08-26', '07:00:00', 'Completed', 35000.00, 408, 825, 19, 3);
INSERT INTO public.appointment VALUES (1359, '2024-11-17', '13:00:00', 'Completed', 15000.00, 108, 215, 67, 2);
INSERT INTO public.appointment VALUES (1360, '2024-02-28', '13:00:00', 'Completed', 8000.00, 422, 850, 34, 1);
INSERT INTO public.appointment VALUES (1361, '2025-03-31', '16:00:00', 'Completed', 35000.00, 114, 223, 59, 3);
INSERT INTO public.appointment VALUES (1362, '2024-09-20', '10:00:00', 'Completed', 15000.00, 145, 294, 205, 2);
INSERT INTO public.appointment VALUES (1363, '2025-04-21', '10:00:00', 'Completed', 15000.00, 286, 572, 155, 2);
INSERT INTO public.appointment VALUES (1364, '2025-07-14', '07:00:00', 'Scheduled', 8000.00, 441, 887, 103, 1);
INSERT INTO public.appointment VALUES (1365, '2025-11-27', '16:00:00', 'Scheduled', 10000.00, 436, 874, 192, 4);
INSERT INTO public.appointment VALUES (1366, '2024-05-14', '10:00:00', 'Completed', 35000.00, 85, 161, 69, 3);
INSERT INTO public.appointment VALUES (1367, '2024-02-26', '07:00:00', 'Completed', 8000.00, 254, 503, 37, 1);
INSERT INTO public.appointment VALUES (1368, '2025-02-22', '13:00:00', 'Cancelled', 15000.00, 397, 805, 154, 2);
INSERT INTO public.appointment VALUES (1369, '2024-03-01', '16:00:00', 'Cancelled', 8000.00, 325, 654, 56, 1);
INSERT INTO public.appointment VALUES (1370, '2025-03-29', '07:00:00', 'Completed', 35000.00, 100, 197, 157, 3);
INSERT INTO public.appointment VALUES (1371, '2025-03-14', '16:00:00', 'Completed', 8000.00, 443, 890, 14, 1);
INSERT INTO public.appointment VALUES (1372, '2024-09-22', '16:00:00', 'Completed', 10000.00, 252, 500, 178, 4);
INSERT INTO public.appointment VALUES (1373, '2025-03-12', '07:00:00', 'Completed', 8000.00, 8, 18, 205, 1);
INSERT INTO public.appointment VALUES (1374, '2024-01-20', '10:00:00', 'Completed', 15000.00, 196, 391, 109, 2);
INSERT INTO public.appointment VALUES (1375, '2025-03-29', '07:00:00', 'Completed', 8000.00, 210, 414, 13, 1);
INSERT INTO public.appointment VALUES (1376, '2025-01-22', '07:00:00', 'Completed', 15000.00, 117, 232, 51, 2);
INSERT INTO public.appointment VALUES (1377, '2023-08-04', '07:00:00', 'Completed', 15000.00, 401, 814, 114, 2);
INSERT INTO public.appointment VALUES (1378, '2025-08-28', '16:00:00', 'Scheduled', 35000.00, 149, 300, 65, 3);
INSERT INTO public.appointment VALUES (1379, '2024-11-11', '07:00:00', 'Completed', 15000.00, 114, 224, 228, 2);
INSERT INTO public.appointment VALUES (1380, '2025-10-01', '10:00:00', 'Scheduled', 10000.00, 337, 681, 77, 4);
INSERT INTO public.appointment VALUES (1381, '2025-06-03', '07:00:00', 'Scheduled', 8000.00, 394, 799, 147, 1);
INSERT INTO public.appointment VALUES (1382, '2025-02-18', '10:00:00', 'Completed', 10000.00, 491, 983, 26, 4);
INSERT INTO public.appointment VALUES (1383, '2025-03-19', '10:00:00', 'Completed', 8000.00, 437, 878, 241, 1);
INSERT INTO public.appointment VALUES (1384, '2024-09-11', '13:00:00', 'Completed', 8000.00, 148, 299, 125, 1);
INSERT INTO public.appointment VALUES (1385, '2024-09-28', '13:00:00', 'Completed', 10000.00, 29, 59, 234, 4);
INSERT INTO public.appointment VALUES (1386, '2025-10-22', '07:00:00', 'Scheduled', 35000.00, 118, 233, 74, 3);
INSERT INTO public.appointment VALUES (1387, '2025-11-06', '13:00:00', 'Scheduled', 10000.00, 15, 29, 45, 4);
INSERT INTO public.appointment VALUES (1388, '2024-11-22', '13:00:00', 'Completed', 15000.00, 286, 572, 68, 2);
INSERT INTO public.appointment VALUES (1389, '2024-06-11', '07:00:00', 'Cancelled', 35000.00, 174, 350, 109, 3);
INSERT INTO public.appointment VALUES (1390, '2025-09-21', '13:00:00', 'Scheduled', 35000.00, 180, 360, 194, 3);
INSERT INTO public.appointment VALUES (1391, '2025-06-07', '16:00:00', 'Scheduled', 15000.00, 39, 75, 234, 2);
INSERT INTO public.appointment VALUES (1392, '2025-05-15', '13:00:00', 'Completed', 8000.00, 60, 120, 67, 1);
INSERT INTO public.appointment VALUES (1393, '2025-04-28', '16:00:00', 'Completed', 15000.00, 173, 349, 100, 2);
INSERT INTO public.appointment VALUES (1394, '2025-06-18', '07:00:00', 'Scheduled', 15000.00, 122, 241, 185, 2);
INSERT INTO public.appointment VALUES (1395, '2025-03-17', '16:00:00', 'Completed', 15000.00, 110, 218, 120, 2);
INSERT INTO public.appointment VALUES (1396, '2025-02-04', '10:00:00', 'Cancelled', 15000.00, 488, 978, 121, 2);
INSERT INTO public.appointment VALUES (1397, '2025-03-24', '16:00:00', 'Completed', 35000.00, 367, 745, 22, 3);
INSERT INTO public.appointment VALUES (1398, '2024-02-16', '10:00:00', 'Completed', 35000.00, 357, 726, 157, 3);
INSERT INTO public.appointment VALUES (1399, '2024-07-14', '16:00:00', 'Completed', 35000.00, 408, 824, 133, 3);
INSERT INTO public.appointment VALUES (1400, '2025-03-10', '10:00:00', 'Cancelled', 15000.00, 144, 289, 238, 2);
INSERT INTO public.appointment VALUES (1401, '2025-11-24', '07:00:00', 'Scheduled', 8000.00, 248, 493, 102, 1);
INSERT INTO public.appointment VALUES (1402, '2025-11-26', '07:00:00', 'Scheduled', 10000.00, 455, 910, 103, 4);
INSERT INTO public.appointment VALUES (1403, '2026-01-01', '13:00:00', 'Scheduled', 35000.00, 220, 433, 81, 3);
INSERT INTO public.appointment VALUES (1404, '2024-10-21', '10:00:00', 'Completed', 15000.00, 92, 178, 236, 2);
INSERT INTO public.appointment VALUES (1405, '2025-09-28', '07:00:00', 'Scheduled', 10000.00, 97, 190, 70, 4);
INSERT INTO public.appointment VALUES (1406, '2024-05-08', '13:00:00', 'Completed', 35000.00, 356, 724, 38, 3);
INSERT INTO public.appointment VALUES (1407, '2025-01-13', '13:00:00', 'Completed', 35000.00, 342, 693, 70, 3);
INSERT INTO public.appointment VALUES (1408, '2023-11-09', '16:00:00', 'Completed', 15000.00, 109, 216, 200, 2);
INSERT INTO public.appointment VALUES (1409, '2024-03-07', '16:00:00', 'Completed', 35000.00, 141, 284, 101, 3);
INSERT INTO public.appointment VALUES (1410, '2025-12-12', '10:00:00', 'Scheduled', 8000.00, 231, 456, 4, 1);
INSERT INTO public.appointment VALUES (1411, '2025-08-27', '07:00:00', 'Scheduled', 35000.00, 326, 657, 21, 3);
INSERT INTO public.appointment VALUES (1412, '2025-05-19', '07:00:00', 'Scheduled', 15000.00, 315, 631, 46, 2);
INSERT INTO public.appointment VALUES (1413, '2025-12-27', '13:00:00', 'Scheduled', 10000.00, 334, 674, 20, 4);
INSERT INTO public.appointment VALUES (1414, '2024-01-25', '10:00:00', 'Completed', 8000.00, 181, 363, 223, 1);
INSERT INTO public.appointment VALUES (1415, '2024-12-25', '10:00:00', 'Completed', 15000.00, 258, 514, 6, 2);
INSERT INTO public.appointment VALUES (1416, '2024-09-25', '16:00:00', 'Completed', 8000.00, 401, 815, 10, 1);
INSERT INTO public.appointment VALUES (1417, '2024-04-02', '07:00:00', 'Completed', 15000.00, 357, 726, 172, 2);
INSERT INTO public.appointment VALUES (1418, '2025-08-12', '16:00:00', 'Scheduled', 10000.00, 432, 866, 73, 4);
INSERT INTO public.appointment VALUES (1419, '2025-09-27', '13:00:00', 'Scheduled', 15000.00, 377, 762, 94, 2);
INSERT INTO public.appointment VALUES (1420, '2024-11-14', '13:00:00', 'Completed', 35000.00, 122, 243, 64, 3);
INSERT INTO public.appointment VALUES (1421, '2024-02-11', '07:00:00', 'Completed', 15000.00, 400, 812, 82, 2);
INSERT INTO public.appointment VALUES (1422, '2024-06-12', '07:00:00', 'Completed', 10000.00, 148, 299, 109, 4);
INSERT INTO public.appointment VALUES (1423, '2023-06-01', '13:00:00', 'Completed', 8000.00, 344, 697, 205, 1);
INSERT INTO public.appointment VALUES (1424, '2024-01-18', '13:00:00', 'Completed', 35000.00, 219, 431, 141, 3);
INSERT INTO public.appointment VALUES (1425, '2025-07-24', '13:00:00', 'Scheduled', 8000.00, 92, 178, 97, 1);
INSERT INTO public.appointment VALUES (1426, '2024-09-07', '13:00:00', 'Completed', 10000.00, 478, 963, 57, 4);
INSERT INTO public.appointment VALUES (1427, '2024-10-13', '13:00:00', 'Completed', 10000.00, 470, 947, 123, 4);
INSERT INTO public.appointment VALUES (1428, '2024-12-23', '13:00:00', 'Completed', 15000.00, 82, 157, 151, 2);
INSERT INTO public.appointment VALUES (1429, '2025-09-26', '07:00:00', 'Scheduled', 15000.00, 441, 886, 38, 2);
INSERT INTO public.appointment VALUES (1430, '2025-11-01', '10:00:00', 'Scheduled', 8000.00, 307, 614, 167, 1);
INSERT INTO public.appointment VALUES (1431, '2024-10-02', '13:00:00', 'Completed', 10000.00, 364, 738, 201, 4);
INSERT INTO public.appointment VALUES (1432, '2025-06-02', '16:00:00', 'Scheduled', 15000.00, 97, 190, 15, 2);
INSERT INTO public.appointment VALUES (1433, '2025-06-19', '07:00:00', 'Scheduled', 35000.00, 180, 360, 38, 3);
INSERT INTO public.appointment VALUES (1434, '2025-08-18', '16:00:00', 'Scheduled', 35000.00, 418, 843, 243, 3);
INSERT INTO public.appointment VALUES (1435, '2024-05-28', '13:00:00', 'Completed', 35000.00, 313, 625, 54, 3);
INSERT INTO public.appointment VALUES (1436, '2023-05-20', '16:00:00', 'Completed', 35000.00, 251, 499, 20, 3);
INSERT INTO public.appointment VALUES (1437, '2025-01-24', '07:00:00', 'Completed', 10000.00, 30, 60, 72, 4);
INSERT INTO public.appointment VALUES (1438, '2025-08-29', '07:00:00', 'Scheduled', 35000.00, 477, 961, 162, 3);
INSERT INTO public.appointment VALUES (1439, '2024-10-03', '07:00:00', 'Completed', 8000.00, 273, 547, 98, 1);
INSERT INTO public.appointment VALUES (1440, '2025-10-21', '16:00:00', 'Scheduled', 8000.00, 389, 792, 20, 1);
INSERT INTO public.appointment VALUES (1441, '2025-10-09', '10:00:00', 'Scheduled', 8000.00, 269, 537, 59, 1);
INSERT INTO public.appointment VALUES (1442, '2024-10-20', '10:00:00', 'Completed', 35000.00, 304, 607, 237, 3);
INSERT INTO public.appointment VALUES (1443, '2023-09-21', '13:00:00', 'Cancelled', 35000.00, 224, 441, 37, 3);
INSERT INTO public.appointment VALUES (1444, '2025-10-13', '10:00:00', 'Scheduled', 35000.00, 269, 537, 115, 3);
INSERT INTO public.appointment VALUES (1445, '2024-08-28', '10:00:00', 'Cancelled', 15000.00, 88, 169, 152, 2);
INSERT INTO public.appointment VALUES (1446, '2024-06-22', '13:00:00', 'Completed', 8000.00, 17, 35, 100, 1);
INSERT INTO public.appointment VALUES (1447, '2025-12-04', '16:00:00', 'Scheduled', 35000.00, 407, 823, 148, 3);
INSERT INTO public.appointment VALUES (1448, '2025-07-23', '13:00:00', 'Scheduled', 15000.00, 99, 193, 75, 2);
INSERT INTO public.appointment VALUES (1449, '2025-10-11', '10:00:00', 'Scheduled', 35000.00, 271, 542, 14, 3);
INSERT INTO public.appointment VALUES (1450, '2025-06-02', '16:00:00', 'Scheduled', 15000.00, 419, 844, 168, 2);
INSERT INTO public.appointment VALUES (1451, '2025-12-25', '10:00:00', 'Scheduled', 10000.00, 493, 988, 211, 4);
INSERT INTO public.appointment VALUES (1452, '2025-12-12', '13:00:00', 'Scheduled', 15000.00, 482, 970, 155, 2);
INSERT INTO public.appointment VALUES (1453, '2025-02-06', '07:00:00', 'Completed', 10000.00, 88, 169, 234, 4);
INSERT INTO public.appointment VALUES (1454, '2024-08-28', '16:00:00', 'Completed', 35000.00, 259, 515, 20, 3);
INSERT INTO public.appointment VALUES (1455, '2024-09-06', '07:00:00', 'Completed', 15000.00, 332, 670, 236, 2);
INSERT INTO public.appointment VALUES (1456, '2024-06-15', '13:00:00', 'Completed', 15000.00, 283, 568, 48, 2);
INSERT INTO public.appointment VALUES (1457, '2024-04-30', '07:00:00', 'Completed', 15000.00, 230, 455, 215, 2);
INSERT INTO public.appointment VALUES (1458, '2025-05-08', '16:00:00', 'Completed', 8000.00, 303, 606, 234, 1);
INSERT INTO public.appointment VALUES (1459, '2025-03-11', '07:00:00', 'Completed', 10000.00, 209, 412, 29, 4);
INSERT INTO public.appointment VALUES (1460, '2025-01-19', '10:00:00', 'Completed', 15000.00, 322, 648, 87, 2);
INSERT INTO public.appointment VALUES (1461, '2025-11-11', '07:00:00', 'Scheduled', 8000.00, 449, 901, 25, 1);
INSERT INTO public.appointment VALUES (1462, '2024-03-24', '07:00:00', 'Completed', 8000.00, 385, 779, 75, 1);
INSERT INTO public.appointment VALUES (1463, '2025-09-02', '10:00:00', 'Scheduled', 8000.00, 357, 726, 171, 1);
INSERT INTO public.appointment VALUES (1464, '2025-09-02', '16:00:00', 'Scheduled', 8000.00, 215, 422, 190, 1);
INSERT INTO public.appointment VALUES (1465, '2025-05-06', '10:00:00', 'Completed', 8000.00, 52, 105, 16, 1);
INSERT INTO public.appointment VALUES (1466, '2025-09-09', '13:00:00', 'Scheduled', 10000.00, 156, 319, 91, 4);
INSERT INTO public.appointment VALUES (1467, '2025-04-01', '10:00:00', 'Cancelled', 10000.00, 470, 946, 231, 4);
INSERT INTO public.appointment VALUES (1468, '2025-07-23', '13:00:00', 'Scheduled', 8000.00, 241, 481, 15, 1);
INSERT INTO public.appointment VALUES (1469, '2025-07-25', '07:00:00', 'Scheduled', 10000.00, 154, 313, 211, 4);
INSERT INTO public.appointment VALUES (1470, '2025-03-10', '13:00:00', 'Completed', 10000.00, 416, 839, 116, 4);
INSERT INTO public.appointment VALUES (1471, '2023-09-17', '07:00:00', 'Completed', 35000.00, 365, 739, 84, 3);
INSERT INTO public.appointment VALUES (1472, '2025-07-07', '16:00:00', 'Scheduled', 15000.00, 172, 347, 189, 2);
INSERT INTO public.appointment VALUES (1473, '2024-12-01', '10:00:00', 'Completed', 15000.00, 344, 697, 89, 2);
INSERT INTO public.appointment VALUES (1474, '2024-05-27', '10:00:00', 'Completed', 35000.00, 372, 751, 235, 3);
INSERT INTO public.appointment VALUES (1475, '2025-11-22', '13:00:00', 'Scheduled', 35000.00, 446, 893, 97, 3);
INSERT INTO public.appointment VALUES (1476, '2025-05-11', '10:00:00', 'Cancelled', 15000.00, 361, 734, 232, 2);
INSERT INTO public.appointment VALUES (1477, '2025-07-08', '07:00:00', 'Scheduled', 8000.00, 440, 884, 39, 1);
INSERT INTO public.appointment VALUES (1478, '2024-03-18', '16:00:00', 'Completed', 8000.00, 494, 989, 46, 1);
INSERT INTO public.appointment VALUES (1479, '2025-09-02', '16:00:00', 'Scheduled', 10000.00, 288, 576, 162, 4);
INSERT INTO public.appointment VALUES (1480, '2024-07-20', '10:00:00', 'Completed', 8000.00, 212, 417, 155, 1);
INSERT INTO public.appointment VALUES (1481, '2025-10-01', '13:00:00', 'Scheduled', 10000.00, 327, 659, 144, 4);
INSERT INTO public.appointment VALUES (1482, '2024-11-22', '16:00:00', 'Completed', 35000.00, 302, 604, 17, 3);
INSERT INTO public.appointment VALUES (1483, '2025-10-11', '10:00:00', 'Scheduled', 8000.00, 388, 789, 102, 1);
INSERT INTO public.appointment VALUES (1484, '2024-04-13', '16:00:00', 'Cancelled', 10000.00, 197, 392, 4, 4);
INSERT INTO public.appointment VALUES (1485, '2024-12-05', '13:00:00', 'Cancelled', 8000.00, 398, 806, 129, 1);
INSERT INTO public.appointment VALUES (1486, '2025-11-03', '16:00:00', 'Scheduled', 15000.00, 378, 766, 18, 2);
INSERT INTO public.appointment VALUES (1487, '2024-04-21', '07:00:00', 'Completed', 15000.00, 230, 455, 198, 2);
INSERT INTO public.appointment VALUES (1488, '2025-02-26', '10:00:00', 'Completed', 8000.00, 311, 622, 233, 1);
INSERT INTO public.appointment VALUES (1489, '2024-02-12', '07:00:00', 'Completed', 8000.00, 196, 391, 127, 1);
INSERT INTO public.appointment VALUES (1490, '2024-08-04', '16:00:00', 'Completed', 10000.00, 129, 258, 199, 4);
INSERT INTO public.appointment VALUES (1491, '2025-08-12', '07:00:00', 'Scheduled', 35000.00, 495, 990, 41, 3);
INSERT INTO public.appointment VALUES (1492, '2025-06-11', '07:00:00', 'Scheduled', 8000.00, 488, 978, 18, 1);
INSERT INTO public.appointment VALUES (1493, '2024-06-15', '13:00:00', 'Completed', 8000.00, 272, 545, 12, 1);
INSERT INTO public.appointment VALUES (1494, '2024-12-26', '10:00:00', 'Completed', 35000.00, 101, 198, 208, 3);
INSERT INTO public.appointment VALUES (1495, '2024-07-31', '10:00:00', 'Completed', 8000.00, 346, 702, 172, 1);
INSERT INTO public.appointment VALUES (1496, '2024-12-31', '16:00:00', 'Completed', 15000.00, 202, 399, 108, 2);
INSERT INTO public.appointment VALUES (1497, '2023-12-13', '16:00:00', 'Completed', 35000.00, 225, 443, 24, 3);
INSERT INTO public.appointment VALUES (1498, '2024-12-21', '10:00:00', 'Completed', 15000.00, 166, 338, 15, 2);
INSERT INTO public.appointment VALUES (1499, '2023-07-25', '16:00:00', 'Completed', 10000.00, 449, 900, 99, 4);
INSERT INTO public.appointment VALUES (1500, '2025-12-11', '07:00:00', 'Scheduled', 8000.00, 209, 412, 112, 1);
INSERT INTO public.appointment VALUES (1511, '2025-05-19', '07:00:00', 'Scheduled', 35000.00, 151, 305, 103, 3);
INSERT INTO public.appointment VALUES (1512, '2024-06-19', '07:00:00', 'Completed', 35000.00, 290, 580, 104, 3);
INSERT INTO public.appointment VALUES (1513, '2023-02-27', '07:00:00', 'Completed', 35000.00, 141, 285, 109, 3);
INSERT INTO public.appointment VALUES (1514, '2025-04-11', '07:00:00', 'Completed', 35000.00, 477, 961, 110, 3);
INSERT INTO public.appointment VALUES (1515, '2025-01-30', '07:00:00', 'Completed', 8000.00, 16, 32, 65, 1);
INSERT INTO public.appointment VALUES (1516, '2025-01-07', '07:00:00', 'Completed', 8000.00, 377, 762, 68, 1);
INSERT INTO public.appointment VALUES (1517, '2023-10-11', '07:00:00', 'Completed', 15000.00, 247, 490, 95, 2);
INSERT INTO public.appointment VALUES (1518, '2023-10-02', '07:00:00', 'Completed', 15000.00, 428, 858, 96, 2);
INSERT INTO public.appointment VALUES (1519, '2024-08-12', '07:00:00', 'Completed', 15000.00, 96, 186, 97, 2);
INSERT INTO public.appointment VALUES (1520, '2024-01-09', '07:00:00', 'Completed', 15000.00, 68, 134, 98, 2);
INSERT INTO public.appointment VALUES (1521, '2024-11-05', '07:00:00', 'Completed', 8000.00, 311, 621, 74, 1);
INSERT INTO public.appointment VALUES (1522, '2025-02-03', '07:00:00', 'Completed', 35000.00, 16, 34, 121, 3);
INSERT INTO public.appointment VALUES (1523, '2023-07-04', '07:00:00', 'Completed', 35000.00, 393, 797, 122, 3);
INSERT INTO public.appointment VALUES (1524, '2023-03-07', '07:00:00', 'Completed', 35000.00, 219, 431, 125, 3);
INSERT INTO public.appointment VALUES (1525, '2024-08-25', '07:00:00', 'Completed', 8000.00, 237, 469, 80, 1);
INSERT INTO public.appointment VALUES (1526, '2023-01-27', '07:00:00', 'Completed', 15000.00, 232, 457, 105, 2);
INSERT INTO public.appointment VALUES (1527, '2025-03-17', '07:00:00', 'Completed', 8000.00, 102, 199, 84, 1);
INSERT INTO public.appointment VALUES (1528, '2023-03-08', '07:00:00', 'Completed', 8000.00, 226, 447, 86, 1);
INSERT INTO public.appointment VALUES (1529, '2024-08-15', '07:00:00', 'Completed', 35000.00, 493, 988, 138, 3);
INSERT INTO public.appointment VALUES (1530, '2025-04-30', '07:00:00', 'Completed', 15000.00, 48, 95, 115, 2);
INSERT INTO public.appointment VALUES (1531, '2023-10-11', '07:00:00', 'Completed', 8000.00, 247, 490, 91, 1);
INSERT INTO public.appointment VALUES (1532, '2023-09-07', '07:00:00', 'Completed', 35000.00, 254, 503, 139, 3);
INSERT INTO public.appointment VALUES (1533, '2023-08-26', '07:00:00', 'Completed', 35000.00, 479, 964, 143, 3);
INSERT INTO public.appointment VALUES (1534, '2023-06-21', '07:00:00', 'Completed', 35000.00, 294, 587, 145, 3);
INSERT INTO public.appointment VALUES (1535, '2023-12-28', '07:00:00', 'Completed', 35000.00, 459, 919, 146, 3);
INSERT INTO public.appointment VALUES (1536, '2025-04-13', '07:00:00', 'Completed', 15000.00, 434, 870, 124, 2);
INSERT INTO public.appointment VALUES (1537, '2023-01-08', '07:00:00', 'Completed', 15000.00, 51, 102, 130, 2);
INSERT INTO public.appointment VALUES (1538, '2023-04-14', '07:00:00', 'Completed', 15000.00, 251, 499, 132, 2);
INSERT INTO public.appointment VALUES (1539, '2023-03-02', '07:00:00', 'Completed', 35000.00, 427, 857, 156, 3);
INSERT INTO public.appointment VALUES (1540, '2025-04-18', '07:00:00', 'Completed', 15000.00, 248, 493, 135, 2);
INSERT INTO public.appointment VALUES (1541, '2023-08-22', '07:00:00', 'Completed', 15000.00, 57, 114, 137, 2);
INSERT INTO public.appointment VALUES (1542, '2024-08-21', '07:00:00', 'Completed', 35000.00, 458, 914, 161, 3);
INSERT INTO public.appointment VALUES (1543, '2023-06-16', '07:00:00', 'Completed', 15000.00, 244, 487, 139, 2);
INSERT INTO public.appointment VALUES (1544, '2023-12-06', '07:00:00', 'Completed', 35000.00, 181, 364, 167, 3);
INSERT INTO public.appointment VALUES (1545, '2025-02-21', '07:00:00', 'Completed', 35000.00, 194, 388, 168, 3);
INSERT INTO public.appointment VALUES (1546, '2023-04-17', '07:00:00', 'Completed', 15000.00, 341, 690, 146, 2);
INSERT INTO public.appointment VALUES (1547, '2025-01-30', '07:00:00', 'Completed', 15000.00, 16, 32, 147, 2);
INSERT INTO public.appointment VALUES (1548, '2024-07-11', '07:00:00', 'Completed', 15000.00, 480, 967, 148, 2);
INSERT INTO public.appointment VALUES (1549, '2024-06-02', '07:00:00', 'Completed', 15000.00, 67, 133, 149, 2);
INSERT INTO public.appointment VALUES (1550, '2023-07-31', '07:00:00', 'Completed', 8000.00, 422, 850, 122, 1);
INSERT INTO public.appointment VALUES (1551, '2023-06-02', '07:00:00', 'Completed', 8000.00, 435, 871, 124, 1);
INSERT INTO public.appointment VALUES (1552, '2024-01-04', '07:00:00', 'Completed', 35000.00, 11, 23, 172, 3);
INSERT INTO public.appointment VALUES (1553, '2023-08-11', '07:00:00', 'Completed', 35000.00, 383, 775, 176, 3);
INSERT INTO public.appointment VALUES (1554, '2023-03-11', '07:00:00', 'Completed', 35000.00, 42, 84, 177, 3);
INSERT INTO public.appointment VALUES (1555, '2024-12-18', '07:00:00', 'Completed', 35000.00, 415, 838, 179, 3);
INSERT INTO public.appointment VALUES (1556, '2025-02-12', '07:00:00', 'Completed', 15000.00, 442, 889, 157, 2);
INSERT INTO public.appointment VALUES (1557, '2023-05-08', '07:00:00', 'Completed', 8000.00, 126, 248, 134, 1);
INSERT INTO public.appointment VALUES (1558, '2025-02-20', '07:00:00', 'Completed', 8000.00, 234, 462, 135, 1);
INSERT INTO public.appointment VALUES (1559, '2024-07-26', '07:00:00', 'Completed', 35000.00, 367, 745, 181, 3);
INSERT INTO public.appointment VALUES (1560, '2023-07-10', '07:00:00', 'Completed', 8000.00, 190, 381, 137, 1);
INSERT INTO public.appointment VALUES (1561, '2024-02-05', '07:00:00', 'Completed', 35000.00, 63, 123, 182, 3);
INSERT INTO public.appointment VALUES (1562, '2025-04-09', '07:00:00', 'Completed', 15000.00, 106, 209, 163, 2);
INSERT INTO public.appointment VALUES (1563, '2024-02-17', '07:00:00', 'Completed', 15000.00, 233, 460, 165, 2);
INSERT INTO public.appointment VALUES (1564, '2024-04-08', '07:00:00', 'Completed', 15000.00, 215, 421, 166, 2);
INSERT INTO public.appointment VALUES (1565, '2024-06-22', '07:00:00', 'Completed', 8000.00, 67, 131, 145, 1);
INSERT INTO public.appointment VALUES (1566, '2024-12-04', '07:00:00', 'Completed', 15000.00, 288, 578, 171, 2);
INSERT INTO public.appointment VALUES (1567, '2023-08-05', '07:00:00', 'Completed', 8000.00, 383, 777, 148, 1);
INSERT INTO public.appointment VALUES (1568, '2023-07-17', '07:00:00', 'Completed', 35000.00, 279, 559, 196, 3);
INSERT INTO public.appointment VALUES (1569, '2023-04-29', '07:00:00', 'Completed', 15000.00, 240, 478, 175, 2);
INSERT INTO public.appointment VALUES (1570, '2024-09-07', '07:00:00', 'Completed', 15000.00, 491, 983, 183, 2);
INSERT INTO public.appointment VALUES (1571, '2025-01-14', '07:00:00', 'Completed', 35000.00, 489, 979, 209, 3);
INSERT INTO public.appointment VALUES (1572, '2025-05-19', '07:00:00', 'Scheduled', 8000.00, 149, 300, 165, 1);
INSERT INTO public.appointment VALUES (1573, '2024-10-26', '07:00:00', 'Completed', 35000.00, 122, 241, 214, 3);
INSERT INTO public.appointment VALUES (1574, '2025-03-18', '07:00:00', 'Completed', 15000.00, 194, 387, 192, 2);
INSERT INTO public.appointment VALUES (1575, '2024-08-23', '07:00:00', 'Completed', 8000.00, 217, 427, 170, 1);
INSERT INTO public.appointment VALUES (1576, '2024-05-18', '07:00:00', 'Completed', 35000.00, 39, 76, 218, 3);
INSERT INTO public.appointment VALUES (1577, '2024-09-08', '07:00:00', 'Completed', 8000.00, 394, 799, 174, 1);
INSERT INTO public.appointment VALUES (1578, '2024-01-22', '07:00:00', 'Completed', 35000.00, 313, 627, 224, 3);
INSERT INTO public.appointment VALUES (1579, '2024-09-01', '07:00:00', 'Completed', 35000.00, 491, 984, 225, 3);
INSERT INTO public.appointment VALUES (1580, '2024-09-17', '07:00:00', 'Completed', 8000.00, 485, 975, 179, 1);
INSERT INTO public.appointment VALUES (1581, '2023-06-12', '07:00:00', 'Completed', 35000.00, 306, 612, 227, 3);
INSERT INTO public.appointment VALUES (1582, '2024-08-28', '07:00:00', 'Completed', 35000.00, 164, 334, 228, 3);
INSERT INTO public.appointment VALUES (1583, '2025-03-11', '07:00:00', 'Completed', 15000.00, 373, 754, 207, 2);
INSERT INTO public.appointment VALUES (1584, '2023-10-02', '07:00:00', 'Completed', 15000.00, 428, 858, 210, 2);
INSERT INTO public.appointment VALUES (1585, '2024-08-30', '07:00:00', 'Completed', 8000.00, 243, 486, 191, 1);
INSERT INTO public.appointment VALUES (1586, '2025-02-11', '07:00:00', 'Completed', 15000.00, 167, 339, 216, 2);
INSERT INTO public.appointment VALUES (1587, '2023-02-25', '07:00:00', 'Completed', 15000.00, 420, 846, 217, 2);
INSERT INTO public.appointment VALUES (1588, '2024-07-31', '07:00:00', 'Completed', 15000.00, 280, 563, 218, 2);
INSERT INTO public.appointment VALUES (1589, '2023-07-11', '07:00:00', 'Completed', 8000.00, 444, 891, 203, 1);
INSERT INTO public.appointment VALUES (1590, '2025-02-05', '07:00:00', 'Completed', 15000.00, 337, 681, 232, 2);
INSERT INTO public.appointment VALUES (1591, '2023-05-08', '07:00:00', 'Completed', 8000.00, 126, 248, 222, 1);
INSERT INTO public.appointment VALUES (1592, '2024-11-24', '07:00:00', 'Completed', 8000.00, 261, 521, 224, 1);
INSERT INTO public.appointment VALUES (1593, '2025-04-30', '07:00:00', 'Completed', 8000.00, 448, 898, 228, 1);
INSERT INTO public.appointment VALUES (1594, '2023-03-08', '07:00:00', 'Completed', 35000.00, 226, 447, 2, 3);
INSERT INTO public.appointment VALUES (1595, '2023-04-27', '07:00:00', 'Completed', 35000.00, 341, 687, 3, 3);
INSERT INTO public.appointment VALUES (1596, '2023-10-28', '07:00:00', 'Completed', 35000.00, 470, 947, 8, 3);
INSERT INTO public.appointment VALUES (1597, '2024-03-13', '07:00:00', 'Completed', 35000.00, 302, 603, 15, 3);
INSERT INTO public.appointment VALUES (1598, '2024-07-30', '07:00:00', 'Completed', 35000.00, 289, 579, 30, 3);
INSERT INTO public.appointment VALUES (1599, '2023-06-30', '07:00:00', 'Completed', 35000.00, 104, 203, 33, 3);
INSERT INTO public.appointment VALUES (1600, '2024-11-09', '07:00:00', 'Completed', 35000.00, 33, 64, 34, 3);
INSERT INTO public.appointment VALUES (1601, '2024-04-30', '07:00:00', 'Completed', 35000.00, 397, 804, 35, 3);
INSERT INTO public.appointment VALUES (1602, '2024-08-28', '07:00:00', 'Completed', 35000.00, 164, 334, 36, 3);
INSERT INTO public.appointment VALUES (1603, '2024-08-26', '07:00:00', 'Completed', 35000.00, 259, 515, 42, 3);
INSERT INTO public.appointment VALUES (1604, '2025-05-14', '07:00:00', 'Completed', 35000.00, 378, 763, 48, 3);
INSERT INTO public.appointment VALUES (1605, '2025-04-06', '07:00:00', 'Completed', 35000.00, 475, 956, 50, 3);
INSERT INTO public.appointment VALUES (1606, '2023-04-30', '07:00:00', 'Completed', 35000.00, 169, 343, 51, 3);
INSERT INTO public.appointment VALUES (1607, '2023-11-12', '07:00:00', 'Completed', 35000.00, 35, 69, 53, 3);
INSERT INTO public.appointment VALUES (1608, '2024-08-03', '07:00:00', 'Completed', 15000.00, 110, 217, 29, 2);
INSERT INTO public.appointment VALUES (1609, '2023-09-30', '07:00:00', 'Completed', 35000.00, 229, 454, 55, 3);
INSERT INTO public.appointment VALUES (1610, '2024-12-02', '07:00:00', 'Completed', 8000.00, 72, 139, 8, 1);
INSERT INTO public.appointment VALUES (1611, '2023-12-03', '07:00:00', 'Completed', 15000.00, 459, 918, 32, 2);
INSERT INTO public.appointment VALUES (1612, '2024-06-27', '07:00:00', 'Completed', 15000.00, 5, 10, 39, 2);
INSERT INTO public.appointment VALUES (1138, '2025-05-22', '07:00:00', 'Cancelled', 8000.00, 172, 347, 178, 1);
INSERT INTO public.appointment VALUES (1613, '2025-05-23', '18:20:00', 'Scheduled', 10000.00, 172, 1001, 58, 4);
INSERT INTO public.appointment VALUES (1614, '2025-05-25', '10:30:00', 'Cancelled', 35000.00, 27, 55, 26, 3);
INSERT INTO public.appointment VALUES (1615, '2025-05-19', '16:30:00', 'Cancelled', 8000.00, 29, 58, 1, 1);


--
-- TOC entry 4922 (class 0 OID 16418)
-- Dependencies: 222
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.city VALUES (1, 'Adana');
INSERT INTO public.city VALUES (2, 'Adıyaman');
INSERT INTO public.city VALUES (3, 'Afyonkarahisar');
INSERT INTO public.city VALUES (4, 'Ağrı');
INSERT INTO public.city VALUES (5, 'Amasya');
INSERT INTO public.city VALUES (6, 'Ankara');
INSERT INTO public.city VALUES (7, 'Antalya');
INSERT INTO public.city VALUES (8, 'Artvin');
INSERT INTO public.city VALUES (9, 'Aydın');
INSERT INTO public.city VALUES (10, 'Balıkesir');
INSERT INTO public.city VALUES (11, 'Bilecik');
INSERT INTO public.city VALUES (12, 'Bingöl');
INSERT INTO public.city VALUES (13, 'Bitlis');
INSERT INTO public.city VALUES (14, 'Bolu');
INSERT INTO public.city VALUES (15, 'Burdur');
INSERT INTO public.city VALUES (16, 'Bursa');
INSERT INTO public.city VALUES (17, 'Çanakkale');
INSERT INTO public.city VALUES (18, 'Çankırı');
INSERT INTO public.city VALUES (19, 'Çorum');
INSERT INTO public.city VALUES (20, 'Denizli');
INSERT INTO public.city VALUES (21, 'Diyarbakır');
INSERT INTO public.city VALUES (22, 'Edirne');
INSERT INTO public.city VALUES (23, 'Elazığ');
INSERT INTO public.city VALUES (24, 'Erzincan');
INSERT INTO public.city VALUES (25, 'Erzurum');
INSERT INTO public.city VALUES (26, 'Eskişehir');
INSERT INTO public.city VALUES (27, 'Gaziantep');
INSERT INTO public.city VALUES (28, 'Giresun');
INSERT INTO public.city VALUES (29, 'Gümüşhane');
INSERT INTO public.city VALUES (30, 'Hakkâri');
INSERT INTO public.city VALUES (31, 'Hatay');
INSERT INTO public.city VALUES (32, 'Isparta');
INSERT INTO public.city VALUES (33, 'Mersin');
INSERT INTO public.city VALUES (34, 'İstanbul');
INSERT INTO public.city VALUES (35, 'İzmir');
INSERT INTO public.city VALUES (36, 'Kars');
INSERT INTO public.city VALUES (37, 'Kastamonu');
INSERT INTO public.city VALUES (38, 'Kayseri');
INSERT INTO public.city VALUES (39, 'Kırklareli');
INSERT INTO public.city VALUES (40, 'Kırşehir');
INSERT INTO public.city VALUES (41, 'Kocaeli');
INSERT INTO public.city VALUES (42, 'Konya');
INSERT INTO public.city VALUES (43, 'Kütahya');
INSERT INTO public.city VALUES (44, 'Malatya');
INSERT INTO public.city VALUES (45, 'Manisa');
INSERT INTO public.city VALUES (46, 'Kahramanmaraş');
INSERT INTO public.city VALUES (47, 'Mardin');
INSERT INTO public.city VALUES (48, 'Muğla');
INSERT INTO public.city VALUES (49, 'Muş');
INSERT INTO public.city VALUES (50, 'Nevşehir');
INSERT INTO public.city VALUES (51, 'Niğde');
INSERT INTO public.city VALUES (52, 'Ordu');
INSERT INTO public.city VALUES (53, 'Rize');
INSERT INTO public.city VALUES (54, 'Sakarya');
INSERT INTO public.city VALUES (55, 'Samsun');
INSERT INTO public.city VALUES (56, 'Siirt');
INSERT INTO public.city VALUES (57, 'Sinop');
INSERT INTO public.city VALUES (58, 'Sivas');
INSERT INTO public.city VALUES (59, 'Tekirdağ');
INSERT INTO public.city VALUES (60, 'Tokat');
INSERT INTO public.city VALUES (61, 'Trabzon');
INSERT INTO public.city VALUES (62, 'Tunceli');
INSERT INTO public.city VALUES (63, 'Şanlıurfa');
INSERT INTO public.city VALUES (64, 'Uşak');
INSERT INTO public.city VALUES (65, 'Van');
INSERT INTO public.city VALUES (66, 'Yozgat');
INSERT INTO public.city VALUES (67, 'Zonguldak');
INSERT INTO public.city VALUES (68, 'Aksaray');
INSERT INTO public.city VALUES (69, 'Bayburt');
INSERT INTO public.city VALUES (70, 'Karaman');
INSERT INTO public.city VALUES (71, 'Kırıkkale');
INSERT INTO public.city VALUES (72, 'Batman');
INSERT INTO public.city VALUES (73, 'Şırnak');
INSERT INTO public.city VALUES (74, 'Bartın');
INSERT INTO public.city VALUES (75, 'Ardahan');
INSERT INTO public.city VALUES (76, 'Iğdır');
INSERT INTO public.city VALUES (77, 'Yalova');
INSERT INTO public.city VALUES (78, 'Karabük');
INSERT INTO public.city VALUES (79, 'Kilis');
INSERT INTO public.city VALUES (80, 'Osmaniye');
INSERT INTO public.city VALUES (81, 'Düzce');


--
-- TOC entry 4924 (class 0 OID 16425)
-- Dependencies: 224
-- Data for Name: dealership; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dealership VALUES (1, 'TurboCare', 'Sanayi Sok. No:175', '05522393532', 37.023477, 35.270326, 1);
INSERT INTO public.dealership VALUES (2, 'MotorLine', 'İstiklal Cad. No:109', '04714296148', 36.918186, 35.42907, 1);
INSERT INTO public.dealership VALUES (3, 'AutoFix', 'Atatürk Cad. No:171', '04008876050', 37.082041, 35.563852, 1);
INSERT INTO public.dealership VALUES (4, 'FixGarage', 'Cumhuriyet Blv. No:169', '05532794288', 37.769833, 38.263116, 2);
INSERT INTO public.dealership VALUES (5, 'AutoMaster', 'Sakarya Cad. No:98', '03096054745', 37.747403, 38.36278, 2);
INSERT INTO public.dealership VALUES (6, 'CarPoint', 'Hisar Blv. No:114', '04426166299', 37.812087, 38.232562, 2);
INSERT INTO public.dealership VALUES (7, 'FixPro', 'Yunus Emre Sok. No:162', '03401323835', 38.783256, 30.524784, 3);
INSERT INTO public.dealership VALUES (8, 'RapidFix', 'Mevlana Cad. No:50', '04415169133', 38.741279, 30.56625, 3);
INSERT INTO public.dealership VALUES (9, 'RepairZone', 'Devrim Cad. No:122', '03236638503', 38.76454, 30.65864, 3);
INSERT INTO public.dealership VALUES (10, 'GarageX', 'Kahraman Blv. No:169', '02872654802', 39.734115, 43.046291, 4);
INSERT INTO public.dealership VALUES (11, 'TurboCare', 'Sanayi Sok. No:110', '04897394460', 39.711942, 43.051158, 4);
INSERT INTO public.dealership VALUES (12, 'MotorLine', 'İstiklal Cad. No:155', '02617502634', 39.751135, 43.102151, 4);
INSERT INTO public.dealership VALUES (13, 'AutoFix', 'Atatürk Cad. No:65', '05495370296', 40.665338, 35.827693, 5);
INSERT INTO public.dealership VALUES (14, 'FixGarage', 'Cumhuriyet Blv. No:125', '03149689668', 40.660855, 35.83678, 5);
INSERT INTO public.dealership VALUES (15, 'AutoMaster', 'Sakarya Cad. No:131', '04282856397', 40.660975, 35.850317, 5);
INSERT INTO public.dealership VALUES (16, 'CarPoint', 'Hisar Blv. No:173', '05318735374', 39.983453, 32.615597, 6);
INSERT INTO public.dealership VALUES (17, 'FixPro', 'Yunus Emre Sok. No:62', '02623039569', 40.007572, 32.867459, 6);
INSERT INTO public.dealership VALUES (18, 'RapidFix', 'Mevlana Cad. No:118', '03718442310', 39.795034, 32.839755, 6);
INSERT INTO public.dealership VALUES (19, 'RepairZone', 'Devrim Cad. No:35', '02389396185', 36.848106, 31.172832, 7);
INSERT INTO public.dealership VALUES (20, 'GarageX', 'Kahraman Blv. No:142', '03956135774', 36.941192, 30.724707, 7);
INSERT INTO public.dealership VALUES (21, 'TurboCare', 'Sanayi Sok. No:93', '04237090516', 36.758708, 31.535261, 7);
INSERT INTO public.dealership VALUES (22, 'MotorLine', 'İstiklal Cad. No:116', '03746566200', 41.182198, 41.813775, 8);
INSERT INTO public.dealership VALUES (23, 'AutoFix', 'Atatürk Cad. No:15', '02643093991', 41.187783, 41.865015, 8);
INSERT INTO public.dealership VALUES (24, 'FixGarage', 'Cumhuriyet Blv. No:15', '04852337066', 41.174352, 41.873496, 8);
INSERT INTO public.dealership VALUES (25, 'AutoMaster', 'Sakarya Cad. No:182', '03332629899', 37.855029, 27.826432, 9);
INSERT INTO public.dealership VALUES (26, 'CarPoint', 'Hisar Blv. No:140', '04085666268', 37.842249, 27.943969, 9);
INSERT INTO public.dealership VALUES (27, 'FixPro', 'Yunus Emre Sok. No:28', '04179293361', 37.779531, 27.962467, 9);
INSERT INTO public.dealership VALUES (28, 'RapidFix', 'Mevlana Cad. No:48', '04743641369', 39.605599, 27.602572, 10);
INSERT INTO public.dealership VALUES (29, 'RepairZone', 'Devrim Cad. No:66', '04654728904', 39.612925, 28.009085, 10);
INSERT INTO public.dealership VALUES (30, 'GarageX', 'Kahraman Blv. No:35', '02139578904', 39.900361, 28.130207, 10);
INSERT INTO public.dealership VALUES (31, 'TurboCare', 'Sanayi Sok. No:132', '04842400263', 40.134123, 29.978691, 11);
INSERT INTO public.dealership VALUES (32, 'MotorLine', 'İstiklal Cad. No:42', '04797119165', 40.101151, 30.02344, 11);
INSERT INTO public.dealership VALUES (33, 'AutoFix', 'Atatürk Cad. No:41', '04914165872', 40.119146, 30.008131, 11);
INSERT INTO public.dealership VALUES (34, 'FixGarage', 'Cumhuriyet Blv. No:180', '05302915831', 38.911156, 40.546466, 12);
INSERT INTO public.dealership VALUES (35, 'AutoMaster', 'Sakarya Cad. No:79', '04687812936', 38.881604, 40.494684, 12);
INSERT INTO public.dealership VALUES (36, 'CarPoint', 'Hisar Blv. No:38', '05184436514', 38.884316, 40.518466, 12);
INSERT INTO public.dealership VALUES (37, 'FixPro', 'Yunus Emre Sok. No:73', '03462519012', 38.395948, 42.108967, 13);
INSERT INTO public.dealership VALUES (38, 'RapidFix', 'Mevlana Cad. No:177', '03815109345', 38.396359, 42.122669, 13);
INSERT INTO public.dealership VALUES (39, 'RepairZone', 'Devrim Cad. No:168', '03786377910', 38.423151, 42.127398, 13);
INSERT INTO public.dealership VALUES (40, 'GarageX', 'Kahraman Blv. No:171', '04129156095', 40.745808, 31.605576, 14);
INSERT INTO public.dealership VALUES (41, 'TurboCare', 'Sanayi Sok. No:163', '02526028787', 40.717097, 31.630715, 14);
INSERT INTO public.dealership VALUES (42, 'MotorLine', 'İstiklal Cad. No:115', '04399559978', 40.74014, 31.631348, 14);
INSERT INTO public.dealership VALUES (43, 'AutoFix', 'Atatürk Cad. No:36', '02781346827', 37.723842, 30.295543, 15);
INSERT INTO public.dealership VALUES (44, 'FixGarage', 'Cumhuriyet Blv. No:130', '03766007083', 37.717958, 30.234779, 15);
INSERT INTO public.dealership VALUES (45, 'AutoMaster', 'Sakarya Cad. No:83', '04348680683', 37.705904, 30.290231, 15);
INSERT INTO public.dealership VALUES (46, 'CarPoint', 'Hisar Blv. No:48', '05377896705', 40.067525, 29.517264, 16);
INSERT INTO public.dealership VALUES (47, 'FixPro', 'Yunus Emre Sok. No:57', '02233933922', 40.211216, 29.041902, 16);
INSERT INTO public.dealership VALUES (48, 'RapidFix', 'Mevlana Cad. No:159', '05823527918', 40.264077, 28.959558, 16);
INSERT INTO public.dealership VALUES (49, 'RepairZone', 'Devrim Cad. No:144', '02958002138', 40.163691, 26.418408, 17);
INSERT INTO public.dealership VALUES (50, 'GarageX', 'Kahraman Blv. No:116', '03847346185', 40.172592, 26.354871, 17);
INSERT INTO public.dealership VALUES (51, 'TurboCare', 'Sanayi Sok. No:19', '05546007165', 40.057595, 26.70962, 17);
INSERT INTO public.dealership VALUES (52, 'MotorLine', 'İstiklal Cad. No:39', '02631260654', 40.520288, 33.505392, 18);
INSERT INTO public.dealership VALUES (53, 'AutoFix', 'Atatürk Cad. No:1', '04502357060', 40.599755, 33.626889, 18);
INSERT INTO public.dealership VALUES (54, 'FixGarage', 'Cumhuriyet Blv. No:45', '02584809764', 40.580535, 33.652911, 18);
INSERT INTO public.dealership VALUES (55, 'AutoMaster', 'Sakarya Cad. No:161', '02948812700', 40.538547, 34.951198, 19);
INSERT INTO public.dealership VALUES (56, 'CarPoint', 'Hisar Blv. No:188', '04257494362', 40.590883, 34.970397, 19);
INSERT INTO public.dealership VALUES (57, 'FixPro', 'Yunus Emre Sok. No:94', '04178853444', 40.508894, 34.919528, 19);
INSERT INTO public.dealership VALUES (58, 'RapidFix', 'Mevlana Cad. No:87', '04283735720', 37.751905, 29.117607, 20);
INSERT INTO public.dealership VALUES (59, 'RepairZone', 'Devrim Cad. No:102', '05863027800', 37.814537, 29.052039, 20);
INSERT INTO public.dealership VALUES (60, 'GarageX', 'Kahraman Blv. No:54', '03675805182', 37.808161, 29.326123, 20);
INSERT INTO public.dealership VALUES (61, 'TurboCare', 'Sanayi Sok. No:5', '04281253767', 37.95259, 40.174231, 21);
INSERT INTO public.dealership VALUES (62, 'MotorLine', 'İstiklal Cad. No:75', '03266810144', 37.830354, 40.233713, 21);
INSERT INTO public.dealership VALUES (63, 'AutoFix', 'Atatürk Cad. No:9', '02396768509', 37.934504, 40.136217, 21);
INSERT INTO public.dealership VALUES (64, 'FixGarage', 'Cumhuriyet Blv. No:133', '05832073319', 41.675432, 26.568923, 22);
INSERT INTO public.dealership VALUES (65, 'AutoMaster', 'Sakarya Cad. No:180', '02927348772', 41.626158, 26.691001, 22);
INSERT INTO public.dealership VALUES (66, 'CarPoint', 'Hisar Blv. No:186', '04396982676', 41.831684, 26.734129, 22);
INSERT INTO public.dealership VALUES (67, 'FixPro', 'Yunus Emre Sok. No:138', '03625247719', 38.662629, 39.182752, 23);
INSERT INTO public.dealership VALUES (68, 'RapidFix', 'Mevlana Cad. No:82', '03092729207', 38.686397, 39.250384, 23);
INSERT INTO public.dealership VALUES (69, 'RepairZone', 'Devrim Cad. No:104', '05574822937', 38.654203, 39.260211, 23);
INSERT INTO public.dealership VALUES (70, 'GarageX', 'Kahraman Blv. No:103', '03521617822', 39.76638, 39.451305, 24);
INSERT INTO public.dealership VALUES (71, 'TurboCare', 'Sanayi Sok. No:114', '04037086837', 39.73749, 39.512413, 24);
INSERT INTO public.dealership VALUES (72, 'MotorLine', 'İstiklal Cad. No:193', '05801609290', 39.7178, 39.568958, 24);
INSERT INTO public.dealership VALUES (73, 'AutoFix', 'Atatürk Cad. No:151', '04463077492', 39.943251, 41.208997, 25);
INSERT INTO public.dealership VALUES (74, 'FixGarage', 'Cumhuriyet Blv. No:179', '03425128758', 39.900227, 41.278008, 25);
INSERT INTO public.dealership VALUES (75, 'AutoMaster', 'Sakarya Cad. No:136', '04845233095', 39.903472, 41.315853, 25);
INSERT INTO public.dealership VALUES (76, 'CarPoint', 'Hisar Blv. No:115', '02362788247', 39.782629, 30.51212, 26);
INSERT INTO public.dealership VALUES (77, 'FixPro', 'Yunus Emre Sok. No:28', '02604286606', 39.840347, 30.549137, 26);
INSERT INTO public.dealership VALUES (78, 'RapidFix', 'Mevlana Cad. No:162', '04453764707', 39.448549, 30.694958, 26);
INSERT INTO public.dealership VALUES (79, 'RepairZone', 'Devrim Cad. No:24', '04178139565', 37.013625, 37.37118, 27);
INSERT INTO public.dealership VALUES (80, 'GarageX', 'Kahraman Blv. No:8', '03516713200', 37.061914, 37.376357, 27);
INSERT INTO public.dealership VALUES (81, 'TurboCare', 'Sanayi Sok. No:169', '02543982241', 37.030296, 37.176422, 27);
INSERT INTO public.dealership VALUES (82, 'MotorLine', 'İstiklal Cad. No:92', '05854954811', 37.048455, 37.379997, 28);
INSERT INTO public.dealership VALUES (83, 'AutoFix', 'Atatürk Cad. No:180', '05166121013', 37.09378, 37.333386, 28);
INSERT INTO public.dealership VALUES (84, 'FixGarage', 'Cumhuriyet Blv. No:76', '05355918388', 37.078816, 37.447717, 28);
INSERT INTO public.dealership VALUES (85, 'AutoMaster', 'Sakarya Cad. No:75', '04138752024', 40.461885, 39.463664, 29);
INSERT INTO public.dealership VALUES (86, 'CarPoint', 'Hisar Blv. No:37', '02236094280', 40.49527, 39.482596, 29);
INSERT INTO public.dealership VALUES (87, 'FixPro', 'Yunus Emre Sok. No:54', '03742299740', 40.435787, 39.366792, 29);
INSERT INTO public.dealership VALUES (88, 'RapidFix', 'Mevlana Cad. No:145', '05125163047', 37.566882, 43.749027, 30);
INSERT INTO public.dealership VALUES (89, 'RepairZone', 'Devrim Cad. No:94', '03686721696', 37.565698, 43.727639, 30);
INSERT INTO public.dealership VALUES (90, 'GarageX', 'Kahraman Blv. No:83', '02553592480', 37.579482, 43.736581, 30);
INSERT INTO public.dealership VALUES (91, 'TurboCare', 'Sanayi Sok. No:170', '04348568893', 36.227693, 36.180127, 31);
INSERT INTO public.dealership VALUES (92, 'MotorLine', 'İstiklal Cad. No:194', '04528686650', 36.568172, 36.125283, 31);
INSERT INTO public.dealership VALUES (93, 'AutoFix', 'Atatürk Cad. No:155', '03986035341', 36.837272, 36.222572, 31);
INSERT INTO public.dealership VALUES (94, 'FixGarage', 'Cumhuriyet Blv. No:75', '03364812848', 37.771921, 30.534524, 32);
INSERT INTO public.dealership VALUES (95, 'AutoMaster', 'Sakarya Cad. No:13', '05503478709', 37.868522, 30.841931, 32);
INSERT INTO public.dealership VALUES (96, 'CarPoint', 'Hisar Blv. No:11', '04098056165', 37.825655, 30.5127, 32);
INSERT INTO public.dealership VALUES (97, 'FixPro', 'Yunus Emre Sok. No:29', '02511029755', 36.801115, 34.608941, 33);
INSERT INTO public.dealership VALUES (98, 'RapidFix', 'Mevlana Cad. No:134', '03672222158', 36.88028, 34.592264, 33);
INSERT INTO public.dealership VALUES (99, 'RepairZone', 'Devrim Cad. No:8', '02454407257', 37.130645, 34.520214, 33);
INSERT INTO public.dealership VALUES (100, 'GarageX', 'Kahraman Blv. No:89', '05337025309', 40.989977, 29.126666, 34);
INSERT INTO public.dealership VALUES (101, 'TurboCare', 'Sanayi Sok. No:61', '04769411770', 41.00448, 28.783849, 34);
INSERT INTO public.dealership VALUES (102, 'MotorLine', 'İstiklal Cad. No:109', '05744216611', 41.099966, 29.069008, 34);
INSERT INTO public.dealership VALUES (103, 'AutoFix', 'Atatürk Cad. No:183', '03972078692', 38.385427, 27.184228, 35);
INSERT INTO public.dealership VALUES (104, 'FixGarage', 'Cumhuriyet Blv. No:98', '02852655611', 38.360634, 26.779442, 35);
INSERT INTO public.dealership VALUES (105, 'AutoMaster', 'Sakarya Cad. No:55', '04057602362', 38.305931, 27.15688, 35);
INSERT INTO public.dealership VALUES (106, 'CarPoint', 'Hisar Blv. No:171', '02455561152', 40.595698, 43.103489, 36);
INSERT INTO public.dealership VALUES (107, 'FixPro', 'Yunus Emre Sok. No:16', '03619611864', 40.576864, 43.039573, 36);
INSERT INTO public.dealership VALUES (108, 'RapidFix', 'Mevlana Cad. No:78', '05341275275', 40.62447, 43.127914, 36);
INSERT INTO public.dealership VALUES (109, 'RepairZone', 'Devrim Cad. No:78', '02331911777', 41.014458, 34.039357, 37);
INSERT INTO public.dealership VALUES (110, 'GarageX', 'Kahraman Blv. No:46', '03145096999', 41.401448, 33.792733, 37);
INSERT INTO public.dealership VALUES (111, 'TurboCare', 'Sanayi Sok. No:193', '02468574671', 41.509158, 34.217874, 37);
INSERT INTO public.dealership VALUES (112, 'MotorLine', 'İstiklal Cad. No:68', '02557145593', 38.725389, 35.510467, 38);
INSERT INTO public.dealership VALUES (113, 'AutoFix', 'Atatürk Cad. No:96', '02264029873', 38.699852, 35.513479, 38);
INSERT INTO public.dealership VALUES (114, 'FixGarage', 'Cumhuriyet Blv. No:64', '04263365356', 38.743322, 35.408294, 38);
INSERT INTO public.dealership VALUES (115, 'AutoMaster', 'Sakarya Cad. No:177', '05235376686', 41.726095, 27.225384, 39);
INSERT INTO public.dealership VALUES (116, 'CarPoint', 'Hisar Blv. No:158', '02774322257', 41.756442, 27.214055, 39);
INSERT INTO public.dealership VALUES (117, 'FixPro', 'Yunus Emre Sok. No:163', '05679782300', 41.750532, 27.182672, 39);
INSERT INTO public.dealership VALUES (118, 'RapidFix', 'Mevlana Cad. No:91', '04203732123', 39.121512, 34.190116, 40);
INSERT INTO public.dealership VALUES (119, 'RepairZone', 'Devrim Cad. No:51', '03457386882', 39.146056, 34.14888, 40);
INSERT INTO public.dealership VALUES (120, 'GarageX', 'Kahraman Blv. No:37', '03516246172', 39.183775, 34.170194, 40);
INSERT INTO public.dealership VALUES (121, 'TurboCare', 'Sanayi Sok. No:118', '05084270864', 40.726767, 29.801609, 41);
INSERT INTO public.dealership VALUES (122, 'MotorLine', 'İstiklal Cad. No:88', '02248142332', 40.769265, 29.955312, 41);
INSERT INTO public.dealership VALUES (123, 'AutoFix', 'Atatürk Cad. No:151', '04837921582', 40.774545, 29.718419, 41);
INSERT INTO public.dealership VALUES (124, 'FixGarage', 'Cumhuriyet Blv. No:149', '05706211990', 37.834503, 32.437172, 42);
INSERT INTO public.dealership VALUES (125, 'AutoMaster', 'Sakarya Cad. No:200', '03828020763', 37.907454, 32.512944, 42);
INSERT INTO public.dealership VALUES (126, 'CarPoint', 'Hisar Blv. No:49', '04042580404', 38.277949, 31.911815, 42);
INSERT INTO public.dealership VALUES (127, 'FixPro', 'Yunus Emre Sok. No:65', '05725005794', 39.390687, 30.121094, 43);
INSERT INTO public.dealership VALUES (128, 'RapidFix', 'Mevlana Cad. No:122', '04403708629', 39.429859, 29.966327, 43);
INSERT INTO public.dealership VALUES (129, 'RepairZone', 'Devrim Cad. No:89', '02525667002', 39.457519, 29.999028, 43);
INSERT INTO public.dealership VALUES (130, 'GarageX', 'Kahraman Blv. No:77', '04318745088', 38.300851, 38.244903, 44);
INSERT INTO public.dealership VALUES (131, 'TurboCare', 'Sanayi Sok. No:72', '05841670731', 38.348576, 38.335542, 44);
INSERT INTO public.dealership VALUES (132, 'MotorLine', 'İstiklal Cad. No:196', '05177243861', 38.382402, 38.274987, 44);
INSERT INTO public.dealership VALUES (133, 'AutoFix', 'Atatürk Cad. No:105', '04114761668', 38.622907, 27.392544, 45);
INSERT INTO public.dealership VALUES (134, 'FixGarage', 'Cumhuriyet Blv. No:130', '02774797478', 38.48561, 27.541806, 45);
INSERT INTO public.dealership VALUES (135, 'AutoMaster', 'Sakarya Cad. No:5', '03346436802', 38.607576, 27.472898, 45);
INSERT INTO public.dealership VALUES (136, 'CarPoint', 'Hisar Blv. No:10', '05071240945', 37.528009, 36.981781, 46);
INSERT INTO public.dealership VALUES (137, 'FixPro', 'Yunus Emre Sok. No:122', '03289837787', 37.599409, 36.836854, 46);
INSERT INTO public.dealership VALUES (138, 'RapidFix', 'Mevlana Cad. No:106', '04316279381', 37.585683, 36.933857, 46);
INSERT INTO public.dealership VALUES (139, 'RepairZone', 'Devrim Cad. No:8', '05331107759', 37.308882, 40.744477, 47);
INSERT INTO public.dealership VALUES (140, 'GarageX', 'Kahraman Blv. No:14', '04878633519', 37.32488, 40.736481, 47);
INSERT INTO public.dealership VALUES (141, 'TurboCare', 'Sanayi Sok. No:140', '04603525338', 37.327761, 40.715241, 47);
INSERT INTO public.dealership VALUES (142, 'MotorLine', 'İstiklal Cad. No:13', '04407273883', 36.843974, 28.24896, 48);
INSERT INTO public.dealership VALUES (143, 'AutoFix', 'Atatürk Cad. No:25', '02972109649', 37.102997, 28.412749, 48);
INSERT INTO public.dealership VALUES (144, 'FixGarage', 'Cumhuriyet Blv. No:112', '03217091210', 37.03185, 27.438392, 48);
INSERT INTO public.dealership VALUES (145, 'AutoMaster', 'Sakarya Cad. No:186', '04302491013', 38.77461, 41.436634, 49);
INSERT INTO public.dealership VALUES (146, 'CarPoint', 'Hisar Blv. No:189', '03342665892', 38.731398, 41.487364, 49);
INSERT INTO public.dealership VALUES (147, 'FixPro', 'Yunus Emre Sok. No:89', '04336963275', 38.763699, 41.510143, 49);
INSERT INTO public.dealership VALUES (148, 'RapidFix', 'Mevlana Cad. No:175', '02454297330', 38.62635, 34.79933, 50);
INSERT INTO public.dealership VALUES (149, 'RepairZone', 'Devrim Cad. No:175', '02838343180', 38.610792, 34.695475, 50);
INSERT INTO public.dealership VALUES (150, 'GarageX', 'Kahraman Blv. No:133', '04222634029', 38.651826, 34.737286, 50);
INSERT INTO public.dealership VALUES (151, 'TurboCare', 'Sanayi Sok. No:84', '05525000109', 37.890108, 34.565962, 51);
INSERT INTO public.dealership VALUES (152, 'MotorLine', 'İstiklal Cad. No:98', '05694454350', 37.940877, 34.626181, 51);
INSERT INTO public.dealership VALUES (153, 'AutoFix', 'Atatürk Cad. No:43', '02603818266', 37.962333, 34.687642, 51);
INSERT INTO public.dealership VALUES (154, 'FixGarage', 'Cumhuriyet Blv. No:135', '02266883518', 40.975797, 37.961801, 52);
INSERT INTO public.dealership VALUES (155, 'AutoMaster', 'Sakarya Cad. No:64', '02922314883', 40.980943, 37.882583, 52);
INSERT INTO public.dealership VALUES (156, 'CarPoint', 'Hisar Blv. No:190', '02315387092', 40.985368, 37.928039, 52);
INSERT INTO public.dealership VALUES (157, 'FixPro', 'Yunus Emre Sok. No:32', '04526836903', 41.031501, 40.475122, 53);
INSERT INTO public.dealership VALUES (158, 'RapidFix', 'Mevlana Cad. No:42', '04933000410', 41.024935, 40.527724, 53);
INSERT INTO public.dealership VALUES (159, 'RepairZone', 'Devrim Cad. No:108', '04841317470', 41.026749, 40.425973, 53);
INSERT INTO public.dealership VALUES (160, 'GarageX', 'Kahraman Blv. No:80', '03384258716', 40.71656, 30.365351, 54);
INSERT INTO public.dealership VALUES (161, 'TurboCare', 'Sanayi Sok. No:74', '03398913178', 40.769845, 30.390978, 54);
INSERT INTO public.dealership VALUES (162, 'MotorLine', 'İstiklal Cad. No:2', '05577078723', 40.789831, 30.4025, 54);
INSERT INTO public.dealership VALUES (163, 'AutoFix', 'Atatürk Cad. No:96', '02627561255', 41.24082, 36.426765, 55);
INSERT INTO public.dealership VALUES (164, 'FixGarage', 'Cumhuriyet Blv. No:47', '03371491296', 41.313515, 36.319696, 55);
INSERT INTO public.dealership VALUES (165, 'AutoMaster', 'Sakarya Cad. No:26', '04386997153', 41.27625, 36.351006, 55);
INSERT INTO public.dealership VALUES (166, 'CarPoint', 'Hisar Blv. No:50', '03711772608', 37.91963, 41.91931, 56);
INSERT INTO public.dealership VALUES (167, 'FixPro', 'Yunus Emre Sok. No:146', '03244084113', 37.937483, 41.931238, 56);
INSERT INTO public.dealership VALUES (168, 'RapidFix', 'Mevlana Cad. No:187', '05849572471', 37.951594, 41.908146, 56);
INSERT INTO public.dealership VALUES (169, 'RepairZone', 'Devrim Cad. No:158', '05423428314', 42.023977, 35.161262, 57);
INSERT INTO public.dealership VALUES (170, 'GarageX', 'Kahraman Blv. No:178', '05822843184', 41.979361, 35.097221, 57);
INSERT INTO public.dealership VALUES (171, 'TurboCare', 'Sanayi Sok. No:180', '04348962142', 42.021184, 35.013735, 57);
INSERT INTO public.dealership VALUES (172, 'MotorLine', 'İstiklal Cad. No:112', '02938168440', 39.792072, 37.086902, 58);
INSERT INTO public.dealership VALUES (173, 'AutoFix', 'Atatürk Cad. No:72', '03588727459', 39.705227, 36.95438, 58);
INSERT INTO public.dealership VALUES (174, 'FixGarage', 'Cumhuriyet Blv. No:160', '04132831755', 39.748795, 37.001072, 58);
INSERT INTO public.dealership VALUES (175, 'AutoMaster', 'Sakarya Cad. No:193', '05486615588', 40.979265, 27.550915, 59);
INSERT INTO public.dealership VALUES (176, 'CarPoint', 'Hisar Blv. No:12', '04376612647', 40.980364, 27.496172, 59);
INSERT INTO public.dealership VALUES (177, 'FixPro', 'Yunus Emre Sok. No:77', '02607536190', 40.912366, 27.466891, 59);
INSERT INTO public.dealership VALUES (178, 'RapidFix', 'Mevlana Cad. No:110', '02583580839', 40.296076, 36.554892, 60);
INSERT INTO public.dealership VALUES (179, 'RepairZone', 'Devrim Cad. No:158', '03834801239', 40.327079, 36.524944, 60);
INSERT INTO public.dealership VALUES (180, 'GarageX', 'Kahraman Blv. No:195', '04101704111', 40.335394, 36.554098, 60);
INSERT INTO public.dealership VALUES (181, 'TurboCare', 'Sanayi Sok. No:48', '04469548661', 41.015509, 39.602493, 61);
INSERT INTO public.dealership VALUES (182, 'MotorLine', 'İstiklal Cad. No:34', '04956549781', 40.951807, 39.739775, 61);
INSERT INTO public.dealership VALUES (183, 'AutoFix', 'Atatürk Cad. No:51', '02599677733', 41.009496, 39.720907, 61);
INSERT INTO public.dealership VALUES (184, 'FixGarage', 'Cumhuriyet Blv. No:62', '03792761873', 39.07292, 39.517859, 62);
INSERT INTO public.dealership VALUES (185, 'AutoMaster', 'Sakarya Cad. No:185', '04077635178', 39.107176, 39.548568, 62);
INSERT INTO public.dealership VALUES (186, 'CarPoint', 'Hisar Blv. No:135', '05035639751', 39.10614, 39.536369, 62);
INSERT INTO public.dealership VALUES (187, 'FixPro', 'Yunus Emre Sok. No:97', '05659639343', 37.197376, 38.85403, 63);
INSERT INTO public.dealership VALUES (188, 'RapidFix', 'Mevlana Cad. No:104', '04683797405', 37.148739, 38.728137, 63);
INSERT INTO public.dealership VALUES (189, 'RepairZone', 'Devrim Cad. No:51', '05499879195', 37.168121, 38.785376, 63);
INSERT INTO public.dealership VALUES (190, 'GarageX', 'Kahraman Blv. No:145', '04847097168', 38.6215, 29.481878, 64);
INSERT INTO public.dealership VALUES (191, 'TurboCare', 'Sanayi Sok. No:24', '05633957600', 38.66433, 29.392746, 64);
INSERT INTO public.dealership VALUES (192, 'MotorLine', 'İstiklal Cad. No:63', '04133428907', 38.685449, 29.429447, 64);
INSERT INTO public.dealership VALUES (193, 'AutoFix', 'Atatürk Cad. No:116', '03487971257', 38.518407, 43.315136, 65);
INSERT INTO public.dealership VALUES (194, 'FixGarage', 'Cumhuriyet Blv. No:193', '02775600186', 38.541524, 43.430961, 65);
INSERT INTO public.dealership VALUES (195, 'AutoMaster', 'Sakarya Cad. No:63', '03273525730', 38.493119, 43.448054, 65);
INSERT INTO public.dealership VALUES (196, 'CarPoint', 'Hisar Blv. No:161', '05863642973', 39.797592, 34.780073, 66);
INSERT INTO public.dealership VALUES (197, 'FixPro', 'Yunus Emre Sok. No:188', '05751519584', 39.819878, 34.820414, 66);
INSERT INTO public.dealership VALUES (198, 'RapidFix', 'Mevlana Cad. No:46', '05537873328', 39.826733, 34.848395, 66);
INSERT INTO public.dealership VALUES (199, 'RepairZone', 'Devrim Cad. No:180', '04083231264', 41.475488, 31.884495, 67);
INSERT INTO public.dealership VALUES (200, 'GarageX', 'Kahraman Blv. No:81', '03962470203', 41.452674, 31.771583, 67);
INSERT INTO public.dealership VALUES (201, 'TurboCare', 'Sanayi Sok. No:106', '04174036110', 41.304581, 31.853822, 67);
INSERT INTO public.dealership VALUES (202, 'MotorLine', 'İstiklal Cad. No:194', '03008322834', 38.335897, 34.042556, 68);
INSERT INTO public.dealership VALUES (203, 'AutoFix', 'Atatürk Cad. No:84', '03236879241', 38.366864, 34.042146, 68);
INSERT INTO public.dealership VALUES (204, 'FixGarage', 'Cumhuriyet Blv. No:186', '03591748566', 38.398886, 33.99682, 68);
INSERT INTO public.dealership VALUES (205, 'AutoMaster', 'Sakarya Cad. No:135', '05356855236', 40.24345, 40.234414, 69);
INSERT INTO public.dealership VALUES (206, 'CarPoint', 'Hisar Blv. No:38', '03252481636', 40.259752, 40.229765, 69);
INSERT INTO public.dealership VALUES (207, 'FixPro', 'Yunus Emre Sok. No:178', '02594506587', 40.265377, 40.208368, 69);
INSERT INTO public.dealership VALUES (208, 'RapidFix', 'Mevlana Cad. No:48', '04054792585', 36.992331, 33.302319, 70);
INSERT INTO public.dealership VALUES (209, 'RepairZone', 'Devrim Cad. No:72', '05834656429', 37.179155, 33.197886, 70);
INSERT INTO public.dealership VALUES (210, 'GarageX', 'Kahraman Blv. No:152', '02941624082', 37.205498, 33.210487, 70);
INSERT INTO public.dealership VALUES (211, 'TurboCare', 'Sanayi Sok. No:54', '03743060033', 39.851496, 33.566412, 71);
INSERT INTO public.dealership VALUES (212, 'MotorLine', 'İstiklal Cad. No:33', '02183732778', 39.840334, 33.516273, 71);
INSERT INTO public.dealership VALUES (213, 'AutoFix', 'Atatürk Cad. No:139', '04824117828', 39.852037, 33.454927, 71);
INSERT INTO public.dealership VALUES (214, 'FixGarage', 'Cumhuriyet Blv. No:118', '02574787316', 37.862206, 41.126243, 72);
INSERT INTO public.dealership VALUES (215, 'AutoMaster', 'Sakarya Cad. No:163', '04197812642', 37.88331, 41.157161, 72);
INSERT INTO public.dealership VALUES (216, 'CarPoint', 'Hisar Blv. No:136', '04274741611', 37.936759, 41.092268, 72);
INSERT INTO public.dealership VALUES (217, 'FixPro', 'Yunus Emre Sok. No:113', '03528327832', 37.529816, 42.445831, 73);
INSERT INTO public.dealership VALUES (218, 'RapidFix', 'Mevlana Cad. No:64', '04118916747', 37.555727, 42.29866, 73);
INSERT INTO public.dealership VALUES (219, 'RepairZone', 'Devrim Cad. No:73', '05171943677', 37.327505, 42.648948, 73);
INSERT INTO public.dealership VALUES (220, 'GarageX', 'Kahraman Blv. No:44', '04975996636', 41.616575, 32.355114, 74);
INSERT INTO public.dealership VALUES (221, 'TurboCare', 'Sanayi Sok. No:126', '02173340603', 41.686766, 32.243008, 74);
INSERT INTO public.dealership VALUES (222, 'MotorLine', 'İstiklal Cad. No:40', '02515027516', 41.686766, 32.193008, 74);
INSERT INTO public.dealership VALUES (223, 'AutoFix', 'Atatürk Cad. No:114', '05413069322', 41.127074, 42.83455, 75);
INSERT INTO public.dealership VALUES (224, 'FixGarage', 'Cumhuriyet Blv. No:20', '02985497736', 41.101371, 42.707221, 75);
INSERT INTO public.dealership VALUES (225, 'AutoMaster', 'Sakarya Cad. No:118', '02365231996', 41.17443, 42.613165, 75);
INSERT INTO public.dealership VALUES (226, 'CarPoint', 'Hisar Blv. No:43', '03552440508', 39.882953, 44.089811, 76);
INSERT INTO public.dealership VALUES (227, 'FixPro', 'Yunus Emre Sok. No:52', '05733163157', 39.930625, 44.043861, 76);
INSERT INTO public.dealership VALUES (228, 'RapidFix', 'Mevlana Cad. No:155', '04563210816', 39.950166, 43.967898, 76);
INSERT INTO public.dealership VALUES (229, 'RepairZone', 'Devrim Cad. No:82', '03296630710', 40.625956, 29.224111, 77);
INSERT INTO public.dealership VALUES (230, 'GarageX', 'Kahraman Blv. No:101', '02723231142', 40.659724, 29.273921, 77);
INSERT INTO public.dealership VALUES (231, 'TurboCare', 'Sanayi Sok. No:181', '05313572597', 40.686036, 29.45164, 77);
INSERT INTO public.dealership VALUES (232, 'MotorLine', 'İstiklal Cad. No:140', '03255914379', 41.251028, 32.676157, 78);
INSERT INTO public.dealership VALUES (233, 'AutoFix', 'Atatürk Cad. No:103', '03263919033', 41.175926, 32.615003, 78);
INSERT INTO public.dealership VALUES (234, 'FixGarage', 'Cumhuriyet Blv. No:3', '05554543319', 41.231816, 32.620587, 78);
INSERT INTO public.dealership VALUES (235, 'AutoMaster', 'Sakarya Cad. No:195', '05455829635', 36.722584, 37.214593, 79);
INSERT INTO public.dealership VALUES (236, 'CarPoint', 'Hisar Blv. No:36', '05403484641', 36.715469, 37.197615, 79);
INSERT INTO public.dealership VALUES (237, 'FixPro', 'Yunus Emre Sok. No:138', '05236847385', 36.717856, 37.109289, 79);
INSERT INTO public.dealership VALUES (238, 'RapidFix', 'Mevlana Cad. No:105', '05495467982', 37.069272, 36.144211, 80);
INSERT INTO public.dealership VALUES (239, 'RepairZone', 'Devrim Cad. No:45', '05765315524', 37.057204, 36.242513, 80);
INSERT INTO public.dealership VALUES (240, 'GarageX', 'Kahraman Blv. No:146', '04557677434', 37.091209, 36.244117, 80);
INSERT INTO public.dealership VALUES (241, 'TurboCare', 'Sanayi Sok. No:57', '04046734989', 40.856179, 31.108063, 81);
INSERT INTO public.dealership VALUES (242, 'MotorLine', 'İstiklal Cad. No:160', '04772263277', 40.843399, 31.16122, 81);
INSERT INTO public.dealership VALUES (243, 'AutoFix', 'Atatürk Cad. No:9', '02694249668', 40.862073, 31.232167, 81);


--
-- TOC entry 4930 (class 0 OID 16475)
-- Dependencies: 230
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employee VALUES (1001, 'Lale', 'Torun', '072-865-8226', '1001@mechero.com', 'Technician', '2021-11-03', 1);
INSERT INTO public.employee VALUES (2001, 'Sonat', 'Ergün', '039-266-8000', '2001@mechero.com', 'Electrical Systems Specialist', '2021-10-04', 1);
INSERT INTO public.employee VALUES (3001, 'Başak', 'Tekin', '081-277-8616', '3001@mechero.com', 'Maintenance Advisor', '2021-01-23', 1);
INSERT INTO public.employee VALUES (1002, 'Merve', 'Uyar', '066-239-2791', '1002@mechero.com', 'Technician', '2020-01-25', 2);
INSERT INTO public.employee VALUES (2002, 'Sevi̇', 'Esen', '018-577-3031', '2002@mechero.com', 'Electrical Systems Specialist', '2021-07-22', 2);
INSERT INTO public.employee VALUES (3002, 'Ayşegül', 'Türk', '022-244-1822', '3002@mechero.com', 'Maintenance Advisor', '2021-09-25', 2);
INSERT INTO public.employee VALUES (1003, 'Hatice', 'Soylu', '017-869-8277', '1003@mechero.com', 'Technician', '2021-03-30', 3);
INSERT INTO public.employee VALUES (2003, 'Berkant', 'Can', '056-735-5197', '2003@mechero.com', 'Electrical Systems Specialist', '2021-12-12', 3);
INSERT INTO public.employee VALUES (3003, 'Hakan', 'Akın', '043-606-7325', '3003@mechero.com', 'Maintenance Advisor', '2020-07-16', 3);
INSERT INTO public.employee VALUES (1004, 'Ataberk', 'Akyol', '063-328-6235', '1004@mechero.com', 'Technician', '2021-12-03', 4);
INSERT INTO public.employee VALUES (2004, 'Sevi̇n', 'Kurt', '001-733-1137', '2004@mechero.com', 'Electrical Systems Specialist', '2020-12-13', 4);
INSERT INTO public.employee VALUES (3004, 'Alphan', 'Altın', '069-906-5721', '3004@mechero.com', 'Maintenance Advisor', '2021-04-10', 4);
INSERT INTO public.employee VALUES (1005, 'Cemali̇', 'Alkan', '029-510-4133', '1005@mechero.com', 'Technician', '2020-01-02', 5);
INSERT INTO public.employee VALUES (2005, 'Gülten', 'Atalay', '052-606-6132', '2005@mechero.com', 'Electrical Systems Specialist', '2021-06-08', 5);
INSERT INTO public.employee VALUES (3005, 'Ataberk', 'Özçelik', '050-658-1585', '3005@mechero.com', 'Maintenance Advisor', '2020-11-18', 5);
INSERT INTO public.employee VALUES (1006, 'Gülşen', 'Önal', '095-546-3954', '1006@mechero.com', 'Technician', '2021-10-17', 6);
INSERT INTO public.employee VALUES (2006, 'Yusuf', 'Karaman', '028-777-1129', '2006@mechero.com', 'Electrical Systems Specialist', '2020-10-28', 6);
INSERT INTO public.employee VALUES (3006, 'Alp', 'Tunç', '053-060-6764', '3006@mechero.com', 'Maintenance Advisor', '2021-02-03', 6);
INSERT INTO public.employee VALUES (1007, 'Ercan', 'Sevinç', '072-731-8714', '1007@mechero.com', 'Technician', '2021-09-07', 7);
INSERT INTO public.employee VALUES (2007, 'Mehmet', 'Akgün', '075-462-7424', '2007@mechero.com', 'Electrical Systems Specialist', '2021-06-28', 7);
INSERT INTO public.employee VALUES (3007, 'Fi̇li̇z', 'Karadağ', '047-172-9386', '3007@mechero.com', 'Maintenance Advisor', '2020-06-20', 7);
INSERT INTO public.employee VALUES (1008, 'Furkan', 'Sönmez', '052-568-4255', '1008@mechero.com', 'Technician', '2021-09-09', 8);
INSERT INTO public.employee VALUES (2008, 'Berkcan', 'Ertürk', '047-595-1645', '2008@mechero.com', 'Electrical Systems Specialist', '2021-04-02', 8);
INSERT INTO public.employee VALUES (3008, 'Cemre', 'Doğru', '071-184-1146', '3008@mechero.com', 'Maintenance Advisor', '2021-01-26', 8);
INSERT INTO public.employee VALUES (1009, 'Can', 'Karaman', '091-113-5788', '1009@mechero.com', 'Technician', '2021-07-08', 9);
INSERT INTO public.employee VALUES (2009, 'Şahi̇n', 'Kuru', '056-226-7681', '2009@mechero.com', 'Electrical Systems Specialist', '2020-08-28', 9);
INSERT INTO public.employee VALUES (3009, 'Ömer', 'Koç', '004-542-8214', '3009@mechero.com', 'Maintenance Advisor', '2021-06-30', 9);
INSERT INTO public.employee VALUES (1010, 'Dilek', 'Yüce', '016-186-7531', '1010@mechero.com', 'Technician', '2021-12-01', 10);
INSERT INTO public.employee VALUES (2010, 'Cemali̇', 'Güçlü', '072-747-5291', '2010@mechero.com', 'Electrical Systems Specialist', '2021-12-20', 10);
INSERT INTO public.employee VALUES (3010, 'Ayşenur', 'Adıgüzel', '073-320-5467', '3010@mechero.com', 'Maintenance Advisor', '2020-02-05', 10);
INSERT INTO public.employee VALUES (1011, 'Berkehan', 'Köse', '025-013-4476', '1011@mechero.com', 'Technician', '2021-10-05', 11);
INSERT INTO public.employee VALUES (2011, 'Suna', 'Çakır', '056-750-2363', '2011@mechero.com', 'Electrical Systems Specialist', '2021-02-08', 11);
INSERT INTO public.employee VALUES (3011, 'Ata', 'Korkmaz', '091-026-1354', '3011@mechero.com', 'Maintenance Advisor', '2020-09-13', 11);
INSERT INTO public.employee VALUES (1012, 'Ahmet', 'Aydoğdu', '034-356-4647', '1012@mechero.com', 'Technician', '2021-12-05', 12);
INSERT INTO public.employee VALUES (2012, 'Adem', 'Güney', '001-728-3046', '2012@mechero.com', 'Electrical Systems Specialist', '2020-10-10', 12);
INSERT INTO public.employee VALUES (3012, 'Kübra', 'Çakır', '099-177-9648', '3012@mechero.com', 'Maintenance Advisor', '2021-04-04', 12);
INSERT INTO public.employee VALUES (1013, 'Esra', 'Durmaz', '031-537-2030', '1013@mechero.com', 'Technician', '2021-04-10', 13);
INSERT INTO public.employee VALUES (2013, 'Mert', 'Turan', '072-432-8255', '2013@mechero.com', 'Electrical Systems Specialist', '2021-05-22', 13);
INSERT INTO public.employee VALUES (3013, 'Ümmügülsüm', 'Ateş', '081-212-4562', '3013@mechero.com', 'Maintenance Advisor', '2021-08-30', 13);
INSERT INTO public.employee VALUES (1014, 'Canberk', 'Güven', '097-806-8364', '1014@mechero.com', 'Technician', '2021-03-09', 14);
INSERT INTO public.employee VALUES (2014, 'Buket', 'Akar', '021-061-4436', '2014@mechero.com', 'Electrical Systems Specialist', '2020-10-06', 14);
INSERT INTO public.employee VALUES (3014, 'Lale', 'Dinçer', '019-676-6130', '3014@mechero.com', 'Maintenance Advisor', '2020-02-07', 14);
INSERT INTO public.employee VALUES (1015, 'Lale', 'Köse', '021-264-9084', '1015@mechero.com', 'Technician', '2020-05-18', 15);
INSERT INTO public.employee VALUES (2015, 'Nazmi̇ye', 'Altuntaş', '002-122-3018', '2015@mechero.com', 'Electrical Systems Specialist', '2020-09-28', 15);
INSERT INTO public.employee VALUES (3015, 'Furkan', 'Ertaş', '072-226-6651', '3015@mechero.com', 'Maintenance Advisor', '2021-10-17', 15);
INSERT INTO public.employee VALUES (1016, 'Berkan', 'Karataş', '012-462-1454', '1016@mechero.com', 'Technician', '2021-09-28', 16);
INSERT INTO public.employee VALUES (2016, 'Ceylan', 'Tuna', '023-282-3496', '2016@mechero.com', 'Electrical Systems Specialist', '2021-12-14', 16);
INSERT INTO public.employee VALUES (3016, 'Nureddi̇n', 'Yazici', '063-047-0347', '3016@mechero.com', 'Maintenance Advisor', '2020-10-13', 16);
INSERT INTO public.employee VALUES (1017, 'İbrahi̇m', 'Yıldırım', '037-828-1964', '1017@mechero.com', 'Technician', '2021-11-27', 17);
INSERT INTO public.employee VALUES (2017, 'Nazmi̇ye', 'Atalay', '031-627-6425', '2017@mechero.com', 'Electrical Systems Specialist', '2020-05-20', 17);
INSERT INTO public.employee VALUES (3017, 'Ali̇han', 'Güçlü', '099-365-8341', '3017@mechero.com', 'Maintenance Advisor', '2020-12-17', 17);
INSERT INTO public.employee VALUES (1018, 'Ebru', 'Atalay', '087-284-1482', '1018@mechero.com', 'Technician', '2020-09-15', 18);
INSERT INTO public.employee VALUES (2018, 'Olcay', 'Eker', '091-886-2558', '2018@mechero.com', 'Electrical Systems Specialist', '2020-09-12', 18);
INSERT INTO public.employee VALUES (3018, 'Berki̇n', 'Sönmez', '055-583-6051', '3018@mechero.com', 'Maintenance Advisor', '2021-11-02', 18);
INSERT INTO public.employee VALUES (1019, 'Mustafa', 'Ayhan', '088-965-4946', '1019@mechero.com', 'Technician', '2021-06-10', 19);
INSERT INTO public.employee VALUES (2019, 'Murat', 'Aras', '070-843-3181', '2019@mechero.com', 'Electrical Systems Specialist', '2020-04-30', 19);
INSERT INTO public.employee VALUES (3019, 'Alperen', 'Akkaya', '071-264-5964', '3019@mechero.com', 'Maintenance Advisor', '2020-09-29', 19);
INSERT INTO public.employee VALUES (1020, 'Sevi̇nç', 'Özmen', '080-898-7001', '1020@mechero.com', 'Technician', '2021-11-01', 20);
INSERT INTO public.employee VALUES (2020, 'Eda', 'Bilgin', '015-235-6286', '2020@mechero.com', 'Electrical Systems Specialist', '2021-08-11', 20);
INSERT INTO public.employee VALUES (3020, 'Ali̇han', 'Tunç', '063-591-6123', '3020@mechero.com', 'Maintenance Advisor', '2021-03-14', 20);
INSERT INTO public.employee VALUES (1021, 'Emine', 'Turhan', '063-476-2827', '1021@mechero.com', 'Technician', '2020-05-27', 21);
INSERT INTO public.employee VALUES (2021, 'Aysel', 'Atmaca', '053-614-7749', '2021@mechero.com', 'Electrical Systems Specialist', '2020-07-17', 21);
INSERT INTO public.employee VALUES (3021, 'Alp', 'Yalçın', '099-933-6796', '3021@mechero.com', 'Maintenance Advisor', '2020-05-25', 21);
INSERT INTO public.employee VALUES (1022, 'Emirhan', 'Akkuş', '044-688-4361', '1022@mechero.com', 'Technician', '2021-04-15', 22);
INSERT INTO public.employee VALUES (2022, 'Berkant', 'Boz', '061-731-8662', '2022@mechero.com', 'Electrical Systems Specialist', '2021-07-28', 22);
INSERT INTO public.employee VALUES (3022, 'Şennur', 'Yaşar', '003-843-6768', '3022@mechero.com', 'Maintenance Advisor', '2021-12-22', 22);
INSERT INTO public.employee VALUES (1023, 'Tayfun', 'Özel', '067-277-8497', '1023@mechero.com', 'Technician', '2021-02-02', 23);
INSERT INTO public.employee VALUES (2023, 'Berki̇n', 'Çınar', '043-943-7347', '2023@mechero.com', 'Electrical Systems Specialist', '2021-12-09', 23);
INSERT INTO public.employee VALUES (3023, 'Nazar', 'Ergin', '066-201-2312', '3023@mechero.com', 'Maintenance Advisor', '2020-10-13', 23);
INSERT INTO public.employee VALUES (1024, 'Samet', 'Karahan', '072-898-2411', '1024@mechero.com', 'Technician', '2020-10-14', 24);
INSERT INTO public.employee VALUES (2024, 'Mahmut', 'Bilgin', '034-118-9783', '2024@mechero.com', 'Electrical Systems Specialist', '2021-12-17', 24);
INSERT INTO public.employee VALUES (3024, 'Can', 'Şahin', '064-287-8280', '3024@mechero.com', 'Maintenance Advisor', '2021-09-07', 24);
INSERT INTO public.employee VALUES (1025, 'Şenay', 'Çevik', '031-382-4510', '1025@mechero.com', 'Technician', '2021-09-16', 25);
INSERT INTO public.employee VALUES (2025, 'Kübra', 'Karahan', '067-795-4041', '2025@mechero.com', 'Electrical Systems Specialist', '2020-09-08', 25);
INSERT INTO public.employee VALUES (3025, 'Furkan', 'İpek', '023-443-6375', '3025@mechero.com', 'Maintenance Advisor', '2021-10-21', 25);
INSERT INTO public.employee VALUES (1026, 'Sümeyra', 'Özdemir', '047-167-7481', '1026@mechero.com', 'Technician', '2021-06-13', 26);
INSERT INTO public.employee VALUES (2026, 'Ceylan', 'Ay', '054-947-6461', '2026@mechero.com', 'Electrical Systems Specialist', '2020-06-11', 26);
INSERT INTO public.employee VALUES (3026, 'Gürsel', 'Genç', '016-238-3965', '3026@mechero.com', 'Maintenance Advisor', '2021-10-25', 26);
INSERT INTO public.employee VALUES (1027, 'Suzan', 'Ünal', '015-462-1334', '1027@mechero.com', 'Technician', '2021-12-27', 27);
INSERT INTO public.employee VALUES (2027, 'Esra', 'Özen', '012-266-8475', '2027@mechero.com', 'Electrical Systems Specialist', '2021-08-25', 27);
INSERT INTO public.employee VALUES (3027, 'Emi̇n', 'Aydoğan', '045-876-7608', '3027@mechero.com', 'Maintenance Advisor', '2020-04-27', 27);
INSERT INTO public.employee VALUES (1028, 'Alparslan', 'Bozkurt', '014-673-5793', '1028@mechero.com', 'Technician', '2021-04-01', 28);
INSERT INTO public.employee VALUES (2028, 'Volkan', 'Yaşar', '026-863-4551', '2028@mechero.com', 'Electrical Systems Specialist', '2021-02-27', 28);
INSERT INTO public.employee VALUES (3028, 'Meral', 'Akyüz', '053-191-2425', '3028@mechero.com', 'Maintenance Advisor', '2021-06-24', 28);
INSERT INTO public.employee VALUES (1029, 'Recep', 'Köksal', '027-729-5468', '1029@mechero.com', 'Technician', '2020-06-21', 29);
INSERT INTO public.employee VALUES (2029, 'Nazi̇fe', 'Çalışkan', '043-493-7024', '2029@mechero.com', 'Electrical Systems Specialist', '2020-04-18', 29);
INSERT INTO public.employee VALUES (3029, 'Güllü', 'Eroğlu', '017-660-6799', '3029@mechero.com', 'Maintenance Advisor', '2021-09-22', 29);
INSERT INTO public.employee VALUES (1030, 'Sude', 'Boz', '020-424-5538', '1030@mechero.com', 'Technician', '2020-07-20', 30);
INSERT INTO public.employee VALUES (2030, 'Kardelen', 'Güleç', '002-085-7838', '2030@mechero.com', 'Electrical Systems Specialist', '2021-12-13', 30);
INSERT INTO public.employee VALUES (3030, 'Rıza', 'Kılıç', '050-299-7438', '3030@mechero.com', 'Maintenance Advisor', '2021-02-08', 30);
INSERT INTO public.employee VALUES (1031, 'Temel', 'Efe', '028-367-5868', '1031@mechero.com', 'Technician', '2021-06-22', 31);
INSERT INTO public.employee VALUES (2031, 'Tayfun', 'Özer', '059-815-7546', '2031@mechero.com', 'Electrical Systems Specialist', '2021-03-30', 31);
INSERT INTO public.employee VALUES (3031, 'Güllü', 'Yüce', '053-179-0664', '3031@mechero.com', 'Maintenance Advisor', '2020-06-15', 31);
INSERT INTO public.employee VALUES (1032, 'Alperen', 'Kaplan', '096-842-0421', '1032@mechero.com', 'Technician', '2021-01-14', 32);
INSERT INTO public.employee VALUES (2032, 'Su', 'Gün', '027-869-4228', '2032@mechero.com', 'Electrical Systems Specialist', '2021-12-08', 32);
INSERT INTO public.employee VALUES (3032, 'Kubilay', 'Bilgin', '088-204-3748', '3032@mechero.com', 'Maintenance Advisor', '2021-01-11', 32);
INSERT INTO public.employee VALUES (1033, 'Nazmi̇ye', 'Köksal', '066-840-7180', '1033@mechero.com', 'Technician', '2020-02-05', 33);
INSERT INTO public.employee VALUES (2033, 'Defne', 'Savaş', '054-463-8974', '2033@mechero.com', 'Electrical Systems Specialist', '2020-12-06', 33);
INSERT INTO public.employee VALUES (3033, 'Abuzer', 'Ünsal', '093-928-7431', '3033@mechero.com', 'Maintenance Advisor', '2020-05-24', 33);
INSERT INTO public.employee VALUES (1034, 'Tuğba', 'Karabulut', '069-536-3317', '1034@mechero.com', 'Technician', '2020-06-05', 34);
INSERT INTO public.employee VALUES (2034, 'Berker', 'Aksoy', '047-793-2739', '2034@mechero.com', 'Electrical Systems Specialist', '2020-06-26', 34);
INSERT INTO public.employee VALUES (3034, 'İlknur', 'Güven', '049-180-5655', '3034@mechero.com', 'Maintenance Advisor', '2020-01-20', 34);
INSERT INTO public.employee VALUES (1035, 'Büşra', 'Akgün', '038-553-6164', '1035@mechero.com', 'Technician', '2021-02-22', 35);
INSERT INTO public.employee VALUES (2035, 'Sevi̇lay', 'Gökçe', '015-455-8931', '2035@mechero.com', 'Electrical Systems Specialist', '2021-11-08', 35);
INSERT INTO public.employee VALUES (3035, 'Songül', 'Tuncer', '089-042-0824', '3035@mechero.com', 'Maintenance Advisor', '2020-02-25', 35);
INSERT INTO public.employee VALUES (1036, 'Cemre', 'Gürsoy', '061-129-2506', '1036@mechero.com', 'Technician', '2020-12-21', 36);
INSERT INTO public.employee VALUES (2036, 'Abuzer', 'Mutlu', '032-261-8836', '2036@mechero.com', 'Electrical Systems Specialist', '2021-12-09', 36);
INSERT INTO public.employee VALUES (3036, 'Ali̇', 'Taşdemir', '007-936-8746', '3036@mechero.com', 'Maintenance Advisor', '2021-08-08', 36);
INSERT INTO public.employee VALUES (1037, 'Merve', 'Deniz', '089-678-1707', '1037@mechero.com', 'Technician', '2020-11-24', 37);
INSERT INTO public.employee VALUES (2037, 'Sultan', 'Baş', '067-728-0836', '2037@mechero.com', 'Electrical Systems Specialist', '2021-06-22', 37);
INSERT INTO public.employee VALUES (3037, 'Lale', 'Çoban', '012-337-8127', '3037@mechero.com', 'Maintenance Advisor', '2020-11-09', 37);
INSERT INTO public.employee VALUES (1038, 'Sonat', 'Köksal', '048-152-9478', '1038@mechero.com', 'Technician', '2020-10-08', 38);
INSERT INTO public.employee VALUES (2038, 'Burak', 'Arslan', '033-361-8678', '2038@mechero.com', 'Electrical Systems Specialist', '2021-01-31', 38);
INSERT INTO public.employee VALUES (3038, 'Cemal', 'Köse', '016-025-7030', '3038@mechero.com', 'Maintenance Advisor', '2020-11-26', 38);
INSERT INTO public.employee VALUES (1039, 'Ali̇han', 'Akar', '046-984-8679', '1039@mechero.com', 'Technician', '2020-06-11', 39);
INSERT INTO public.employee VALUES (2039, 'Serkan', 'Özer', '064-952-8338', '2039@mechero.com', 'Electrical Systems Specialist', '2021-01-20', 39);
INSERT INTO public.employee VALUES (3039, 'Suna', 'Şeker', '022-656-3141', '3039@mechero.com', 'Maintenance Advisor', '2021-02-16', 39);
INSERT INTO public.employee VALUES (1040, 'Murat', 'Duman', '060-129-6206', '1040@mechero.com', 'Technician', '2021-02-28', 40);
INSERT INTO public.employee VALUES (2040, 'Aysel', 'Özkan', '052-383-8715', '2040@mechero.com', 'Electrical Systems Specialist', '2020-01-31', 40);
INSERT INTO public.employee VALUES (3040, 'Alpteki̇n', 'Ergün', '042-182-0022', '3040@mechero.com', 'Maintenance Advisor', '2020-02-14', 40);
INSERT INTO public.employee VALUES (1041, 'Volkan', 'Yılmaz', '032-475-7408', '1041@mechero.com', 'Technician', '2021-12-04', 41);
INSERT INTO public.employee VALUES (2041, 'Gülşen', 'Ekici', '072-680-3396', '2041@mechero.com', 'Electrical Systems Specialist', '2021-12-21', 41);
INSERT INTO public.employee VALUES (3041, 'Nuretti̇n', 'Metin', '036-357-1607', '3041@mechero.com', 'Maintenance Advisor', '2020-09-23', 41);
INSERT INTO public.employee VALUES (1042, 'Fatma', 'Akbaş', '063-313-7852', '1042@mechero.com', 'Technician', '2020-07-07', 42);
INSERT INTO public.employee VALUES (2042, 'Keri̇m', 'Yaman', '048-219-7524', '2042@mechero.com', 'Electrical Systems Specialist', '2020-08-29', 42);
INSERT INTO public.employee VALUES (3042, 'Sude', 'Arslan', '025-348-5596', '3042@mechero.com', 'Maintenance Advisor', '2021-03-22', 42);
INSERT INTO public.employee VALUES (1043, 'Ergun', 'İlhan', '025-708-5873', '1043@mechero.com', 'Technician', '2021-05-28', 43);
INSERT INTO public.employee VALUES (2043, 'Sudenaz', 'Kaçar', '042-097-6632', '2043@mechero.com', 'Electrical Systems Specialist', '2021-06-11', 43);
INSERT INTO public.employee VALUES (3043, 'Gülbahar', 'Gül', '071-300-1723', '3043@mechero.com', 'Maintenance Advisor', '2020-02-20', 43);
INSERT INTO public.employee VALUES (1044, 'Sunay', 'Yıldız', '074-811-5577', '1044@mechero.com', 'Technician', '2021-02-23', 44);
INSERT INTO public.employee VALUES (2044, 'Tayfun', 'Özel', '044-751-6930', '2044@mechero.com', 'Electrical Systems Specialist', '2021-03-15', 44);
INSERT INTO public.employee VALUES (3044, 'Alp', 'Kılıç', '073-183-3126', '3044@mechero.com', 'Maintenance Advisor', '2021-08-11', 44);
INSERT INTO public.employee VALUES (1045, 'Melek', 'Korkmaz', '011-554-2872', '1045@mechero.com', 'Technician', '2021-07-04', 45);
INSERT INTO public.employee VALUES (2045, 'Müge', 'Bayram', '044-747-6035', '2045@mechero.com', 'Electrical Systems Specialist', '2021-12-23', 45);
INSERT INTO public.employee VALUES (3045, 'Abdullah', 'Yavuz', '019-481-8715', '3045@mechero.com', 'Maintenance Advisor', '2020-11-25', 45);
INSERT INTO public.employee VALUES (1046, 'Sonat', 'Ateş', '023-357-7489', '1046@mechero.com', 'Technician', '2021-12-02', 46);
INSERT INTO public.employee VALUES (2046, 'Eda', 'Tuna', '016-732-8418', '2046@mechero.com', 'Electrical Systems Specialist', '2021-08-18', 46);
INSERT INTO public.employee VALUES (3046, 'Kubilay', 'Ay', '071-755-6553', '3046@mechero.com', 'Maintenance Advisor', '2020-04-10', 46);
INSERT INTO public.employee VALUES (1047, 'İbrahi̇m', 'Yalçınkaya', '051-587-6650', '1047@mechero.com', 'Technician', '2021-09-10', 47);
INSERT INTO public.employee VALUES (2047, 'Mahmut', 'Karakaş', '086-517-7967', '2047@mechero.com', 'Electrical Systems Specialist', '2020-06-20', 47);
INSERT INTO public.employee VALUES (3047, 'Ceylan', 'Köksal', '061-093-6518', '3047@mechero.com', 'Maintenance Advisor', '2020-06-08', 47);
INSERT INTO public.employee VALUES (1048, 'Aynur', 'Çoban', '072-513-3166', '1048@mechero.com', 'Technician', '2020-09-11', 48);
INSERT INTO public.employee VALUES (2048, 'Alparslan', 'Özkaya', '064-018-3716', '2048@mechero.com', 'Electrical Systems Specialist', '2020-11-28', 48);
INSERT INTO public.employee VALUES (3048, 'Nuri̇', 'Ercan', '052-423-2136', '3048@mechero.com', 'Maintenance Advisor', '2021-02-17', 48);
INSERT INTO public.employee VALUES (1049, 'Enes', 'Köksal', '063-413-5498', '1049@mechero.com', 'Technician', '2021-06-15', 49);
INSERT INTO public.employee VALUES (2049, 'Meli̇sa', 'Özkan', '042-845-5734', '2049@mechero.com', 'Electrical Systems Specialist', '2020-06-03', 49);
INSERT INTO public.employee VALUES (3049, 'Şenel', 'Demirel', '077-045-1772', '3049@mechero.com', 'Maintenance Advisor', '2020-08-26', 49);
INSERT INTO public.employee VALUES (1050, 'Aysel', 'Sezer', '033-122-5494', '1050@mechero.com', 'Technician', '2021-08-26', 50);
INSERT INTO public.employee VALUES (2050, 'Bedirhan', 'Ayaz', '022-833-8435', '2050@mechero.com', 'Electrical Systems Specialist', '2020-12-25', 50);
INSERT INTO public.employee VALUES (3050, 'Meryem', 'Şentürk', '080-405-8676', '3050@mechero.com', 'Maintenance Advisor', '2021-04-02', 50);
INSERT INTO public.employee VALUES (1051, 'Zehra', 'Budak', '054-402-8266', '1051@mechero.com', 'Technician', '2020-12-24', 51);
INSERT INTO public.employee VALUES (2051, 'Tayfun', 'Cengiz', '061-731-7856', '2051@mechero.com', 'Electrical Systems Specialist', '2021-03-29', 51);
INSERT INTO public.employee VALUES (3051, 'Ayşenaz', 'Çalışkan', '040-581-4997', '3051@mechero.com', 'Maintenance Advisor', '2021-10-25', 51);
INSERT INTO public.employee VALUES (1052, 'Beyza', 'Arslan', '098-652-0266', '1052@mechero.com', 'Technician', '2021-09-01', 52);
INSERT INTO public.employee VALUES (2052, 'Cemaletti̇n', 'Bulut', '098-330-4494', '2052@mechero.com', 'Electrical Systems Specialist', '2021-04-12', 52);
INSERT INTO public.employee VALUES (3052, 'Berke', 'Akman', '074-771-3665', '3052@mechero.com', 'Maintenance Advisor', '2021-09-28', 52);
INSERT INTO public.employee VALUES (1053, 'Çiçek', 'Karakoç', '065-625-5633', '1053@mechero.com', 'Technician', '2021-12-07', 53);
INSERT INTO public.employee VALUES (2053, 'Sudenaz', 'Gür', '056-238-3247', '2053@mechero.com', 'Electrical Systems Specialist', '2021-01-28', 53);
INSERT INTO public.employee VALUES (3053, 'Nurgül', 'Akça', '024-507-1755', '3053@mechero.com', 'Maintenance Advisor', '2020-11-10', 53);
INSERT INTO public.employee VALUES (1054, 'Zeynep', 'Çakmak', '044-643-0615', '1054@mechero.com', 'Technician', '2020-12-17', 54);
INSERT INTO public.employee VALUES (2054, 'Berkan', 'Gündüz', '046-188-3241', '2054@mechero.com', 'Electrical Systems Specialist', '2020-03-22', 54);
INSERT INTO public.employee VALUES (3054, 'Fi̇li̇z', 'Önder', '053-037-8131', '3054@mechero.com', 'Maintenance Advisor', '2021-12-04', 54);
INSERT INTO public.employee VALUES (1055, 'Serkan', 'Yavuz', '056-454-3481', '1055@mechero.com', 'Technician', '2020-09-28', 55);
INSERT INTO public.employee VALUES (2055, 'Atay', 'Uysal', '038-114-6394', '2055@mechero.com', 'Electrical Systems Specialist', '2021-03-15', 55);
INSERT INTO public.employee VALUES (3055, 'Berkay', 'Karakaya', '044-178-5219', '3055@mechero.com', 'Maintenance Advisor', '2020-02-11', 55);
INSERT INTO public.employee VALUES (1056, 'Azi̇z', 'Dursun', '093-361-8427', '1056@mechero.com', 'Technician', '2021-12-29', 56);
INSERT INTO public.employee VALUES (2056, 'Nuran', 'Güler', '010-656-1342', '2056@mechero.com', 'Electrical Systems Specialist', '2020-11-09', 56);
INSERT INTO public.employee VALUES (3056, 'Lale', 'Eroğlu', '083-547-2597', '3056@mechero.com', 'Maintenance Advisor', '2021-12-25', 56);
INSERT INTO public.employee VALUES (1057, 'Serkan', 'Özden', '016-414-2772', '1057@mechero.com', 'Technician', '2021-06-06', 57);
INSERT INTO public.employee VALUES (2057, 'Hacer', 'İnce', '043-761-5387', '2057@mechero.com', 'Electrical Systems Specialist', '2020-07-18', 57);
INSERT INTO public.employee VALUES (3057, 'Mehmet', 'Tan', '094-115-3469', '3057@mechero.com', 'Maintenance Advisor', '2021-07-09', 57);
INSERT INTO public.employee VALUES (1058, 'Berk', 'Özbek', '033-486-2666', '1058@mechero.com', 'Technician', '2021-05-16', 58);
INSERT INTO public.employee VALUES (2058, 'Yasemin', 'Ercan', '023-821-9777', '2058@mechero.com', 'Electrical Systems Specialist', '2020-02-21', 58);
INSERT INTO public.employee VALUES (3058, 'Olcay', 'Akkuş', '026-556-4863', '3058@mechero.com', 'Maintenance Advisor', '2020-02-18', 58);
INSERT INTO public.employee VALUES (1059, 'Cansu', 'Albayrak', '027-194-5775', '1059@mechero.com', 'Technician', '2021-12-08', 59);
INSERT INTO public.employee VALUES (2059, 'Alpay', 'Türkmen', '050-527-5518', '2059@mechero.com', 'Electrical Systems Specialist', '2021-01-09', 59);
INSERT INTO public.employee VALUES (3059, 'Mehmet', 'Yiğit', '042-795-7787', '3059@mechero.com', 'Maintenance Advisor', '2021-11-27', 59);
INSERT INTO public.employee VALUES (1060, 'Suna', 'Taşdemir', '037-700-6450', '1060@mechero.com', 'Technician', '2021-09-16', 60);
INSERT INTO public.employee VALUES (2060, 'Manolya', 'Çetinkaya', '071-817-4245', '2060@mechero.com', 'Electrical Systems Specialist', '2021-06-03', 60);
INSERT INTO public.employee VALUES (3060, 'Dilek', 'Bayram', '038-804-1936', '3060@mechero.com', 'Maintenance Advisor', '2021-02-16', 60);
INSERT INTO public.employee VALUES (1061, 'Can', 'Akdoğan', '036-141-7704', '1061@mechero.com', 'Technician', '2021-10-09', 61);
INSERT INTO public.employee VALUES (2061, 'Meral', 'Metin', '073-747-4738', '2061@mechero.com', 'Electrical Systems Specialist', '2021-01-06', 61);
INSERT INTO public.employee VALUES (3061, 'Nuri̇', 'Dağ', '005-568-7773', '3061@mechero.com', 'Maintenance Advisor', '2021-05-08', 61);
INSERT INTO public.employee VALUES (1062, 'Başak', 'Duman', '064-245-1143', '1062@mechero.com', 'Technician', '2020-02-18', 62);
INSERT INTO public.employee VALUES (2062, 'Emre', 'Çoban', '086-828-0841', '2062@mechero.com', 'Electrical Systems Specialist', '2020-11-29', 62);
INSERT INTO public.employee VALUES (3062, 'Alpcan', 'Karagöz', '011-579-5847', '3062@mechero.com', 'Maintenance Advisor', '2020-07-30', 62);
INSERT INTO public.employee VALUES (1063, 'Gülten', 'Ekici', '018-894-1712', '1063@mechero.com', 'Technician', '2020-09-16', 63);
INSERT INTO public.employee VALUES (2063, 'Samet', 'Akkaya', '089-333-7338', '2063@mechero.com', 'Electrical Systems Specialist', '2020-04-27', 63);
INSERT INTO public.employee VALUES (3063, 'Kadi̇r', 'Tuna', '005-760-5835', '3063@mechero.com', 'Maintenance Advisor', '2020-05-11', 63);
INSERT INTO public.employee VALUES (1064, 'Emirhan', 'Soylu', '065-782-1888', '1064@mechero.com', 'Technician', '2020-09-03', 64);
INSERT INTO public.employee VALUES (2064, 'Menekşe', 'Uysal', '048-758-6963', '2064@mechero.com', 'Electrical Systems Specialist', '2021-12-25', 64);
INSERT INTO public.employee VALUES (3064, 'Ayşen', 'Dinçer', '013-561-1620', '3064@mechero.com', 'Maintenance Advisor', '2021-08-06', 64);
INSERT INTO public.employee VALUES (1065, 'Naz', 'İlhan', '032-763-2371', '1065@mechero.com', 'Technician', '2021-08-19', 65);
INSERT INTO public.employee VALUES (2065, 'Başak', 'Gürsoy', '000-576-6481', '2065@mechero.com', 'Electrical Systems Specialist', '2020-07-10', 65);
INSERT INTO public.employee VALUES (3065, 'Can', 'Özdemir', '037-928-4610', '3065@mechero.com', 'Maintenance Advisor', '2021-07-05', 65);
INSERT INTO public.employee VALUES (1066, 'Osman', 'Deniz', '078-578-6678', '1066@mechero.com', 'Technician', '2020-04-12', 66);
INSERT INTO public.employee VALUES (2066, 'Alparslan', 'Eren', '022-602-3142', '2066@mechero.com', 'Electrical Systems Specialist', '2020-02-22', 66);
INSERT INTO public.employee VALUES (3066, 'Şerife', 'Ersoy', '058-973-3083', '3066@mechero.com', 'Maintenance Advisor', '2021-12-08', 66);
INSERT INTO public.employee VALUES (1067, 'Nazar', 'Kaya', '065-407-4734', '1067@mechero.com', 'Technician', '2021-03-13', 67);
INSERT INTO public.employee VALUES (2067, 'Kemal', 'Yaşar', '071-442-4586', '2067@mechero.com', 'Electrical Systems Specialist', '2021-03-05', 67);
INSERT INTO public.employee VALUES (3067, 'Leyla', 'Akbaş', '004-840-4977', '3067@mechero.com', 'Maintenance Advisor', '2021-12-07', 67);
INSERT INTO public.employee VALUES (1068, 'Keri̇m', 'Özen', '035-948-0748', '1068@mechero.com', 'Technician', '2020-09-03', 68);
INSERT INTO public.employee VALUES (2068, 'Nurullah', 'Çiçek', '031-702-8347', '2068@mechero.com', 'Electrical Systems Specialist', '2021-07-08', 68);
INSERT INTO public.employee VALUES (3068, 'Berkan', 'Öner', '011-153-9177', '3068@mechero.com', 'Maintenance Advisor', '2021-10-11', 68);
INSERT INTO public.employee VALUES (1069, 'Ceren', 'Özkaya', '059-115-7460', '1069@mechero.com', 'Technician', '2020-05-16', 69);
INSERT INTO public.employee VALUES (2069, 'Buket', 'Bolat', '057-414-1876', '2069@mechero.com', 'Electrical Systems Specialist', '2020-02-14', 69);
INSERT INTO public.employee VALUES (3069, 'Cansu', 'Çalışkan', '037-208-2426', '3069@mechero.com', 'Maintenance Advisor', '2021-06-28', 69);
INSERT INTO public.employee VALUES (1070, 'Cankat', 'Ekinci', '067-224-4618', '1070@mechero.com', 'Technician', '2020-06-24', 70);
INSERT INTO public.employee VALUES (2070, 'Ali̇can', 'Güleç', '053-581-8263', '2070@mechero.com', 'Electrical Systems Specialist', '2021-07-02', 70);
INSERT INTO public.employee VALUES (3070, 'Aynur', 'Şener', '054-077-6427', '3070@mechero.com', 'Maintenance Advisor', '2021-08-19', 70);
INSERT INTO public.employee VALUES (1071, 'Hasan', 'Çimen', '075-575-4708', '1071@mechero.com', 'Technician', '2021-07-19', 71);
INSERT INTO public.employee VALUES (2071, 'Ali̇han', 'Çelik', '052-327-3446', '2071@mechero.com', 'Electrical Systems Specialist', '2020-08-13', 71);
INSERT INTO public.employee VALUES (3071, 'Sevi̇', 'Çınar', '086-325-3314', '3071@mechero.com', 'Maintenance Advisor', '2021-12-19', 71);
INSERT INTO public.employee VALUES (1072, 'Olcay', 'Güçlü', '046-321-5431', '1072@mechero.com', 'Technician', '2021-10-15', 72);
INSERT INTO public.employee VALUES (2072, 'Çağla', 'Boz', '057-912-6892', '2072@mechero.com', 'Electrical Systems Specialist', '2020-05-27', 72);
INSERT INTO public.employee VALUES (3072, 'Gülten', 'Gürbüz', '046-764-4945', '3072@mechero.com', 'Maintenance Advisor', '2021-07-18', 72);
INSERT INTO public.employee VALUES (1073, 'Ayşenaz', 'Bayraktar', '012-965-2525', '1073@mechero.com', 'Technician', '2020-04-04', 73);
INSERT INTO public.employee VALUES (2073, 'Aysel', 'Gök', '073-370-4201', '2073@mechero.com', 'Electrical Systems Specialist', '2020-06-18', 73);
INSERT INTO public.employee VALUES (3073, 'Ceren', 'Gültekin', '073-751-5841', '3073@mechero.com', 'Maintenance Advisor', '2020-05-28', 73);
INSERT INTO public.employee VALUES (1074, 'Ata', 'Çakar', '016-947-0347', '1074@mechero.com', 'Technician', '2020-06-21', 74);
INSERT INTO public.employee VALUES (2074, 'Alpteki̇n', 'Turhan', '095-526-6178', '2074@mechero.com', 'Electrical Systems Specialist', '2020-07-15', 74);
INSERT INTO public.employee VALUES (3074, 'Enes', 'Sevim', '011-850-7761', '3074@mechero.com', 'Maintenance Advisor', '2021-07-02', 74);
INSERT INTO public.employee VALUES (1075, 'Alparslan', 'Sarıkaya', '046-533-3805', '1075@mechero.com', 'Technician', '2020-11-12', 75);
INSERT INTO public.employee VALUES (2075, 'İhsan', 'Günay', '045-324-2318', '2075@mechero.com', 'Electrical Systems Specialist', '2020-06-10', 75);
INSERT INTO public.employee VALUES (3075, 'Merve', 'Savaş', '033-712-3491', '3075@mechero.com', 'Maintenance Advisor', '2020-11-04', 75);
INSERT INTO public.employee VALUES (1076, 'Nur', 'Güngör', '016-368-8453', '1076@mechero.com', 'Technician', '2020-03-02', 76);
INSERT INTO public.employee VALUES (2076, 'Keri̇m', 'Akyol', '071-365-1381', '2076@mechero.com', 'Electrical Systems Specialist', '2020-11-16', 76);
INSERT INTO public.employee VALUES (3076, 'Nazlican', 'Karakaya', '023-095-2823', '3076@mechero.com', 'Maintenance Advisor', '2021-11-11', 76);
INSERT INTO public.employee VALUES (1077, 'Ali̇m', 'Aslan', '064-251-5336', '1077@mechero.com', 'Technician', '2021-06-05', 77);
INSERT INTO public.employee VALUES (2077, 'Serhat', 'Bülbül', '061-154-0367', '2077@mechero.com', 'Electrical Systems Specialist', '2021-01-23', 77);
INSERT INTO public.employee VALUES (3077, 'Nur', 'Dönmez', '070-627-1376', '3077@mechero.com', 'Maintenance Advisor', '2021-03-10', 77);
INSERT INTO public.employee VALUES (1078, 'Berki̇n', 'Bolat', '096-370-6836', '1078@mechero.com', 'Technician', '2020-05-31', 78);
INSERT INTO public.employee VALUES (2078, 'Lale', 'Korkmaz', '066-173-0859', '2078@mechero.com', 'Electrical Systems Specialist', '2020-10-21', 78);
INSERT INTO public.employee VALUES (3078, 'Gülbahar', 'Özkaya', '096-510-6337', '3078@mechero.com', 'Maintenance Advisor', '2020-09-25', 78);
INSERT INTO public.employee VALUES (1079, 'Serkan', 'Yılmaz', '033-906-0941', '1079@mechero.com', 'Technician', '2021-06-07', 79);
INSERT INTO public.employee VALUES (2079, 'Dilek', 'Koçak', '057-552-6553', '2079@mechero.com', 'Electrical Systems Specialist', '2020-03-23', 79);
INSERT INTO public.employee VALUES (3079, 'Emirhan', 'Karaman', '043-534-5554', '3079@mechero.com', 'Maintenance Advisor', '2021-02-01', 79);
INSERT INTO public.employee VALUES (1080, 'Nuran', 'Güven', '022-771-4751', '1080@mechero.com', 'Technician', '2020-06-24', 80);
INSERT INTO public.employee VALUES (2080, 'Hasan', 'Akyüz', '001-250-5873', '2080@mechero.com', 'Electrical Systems Specialist', '2020-06-23', 80);
INSERT INTO public.employee VALUES (3080, 'Ali̇şan', 'Parlak', '024-254-0551', '3080@mechero.com', 'Maintenance Advisor', '2021-07-20', 80);
INSERT INTO public.employee VALUES (1081, 'Keri̇m', 'Gökçe', '052-422-3745', '1081@mechero.com', 'Technician', '2021-06-15', 81);
INSERT INTO public.employee VALUES (2081, 'Ataman', 'Ayhan', '003-968-8642', '2081@mechero.com', 'Electrical Systems Specialist', '2020-12-30', 81);
INSERT INTO public.employee VALUES (3081, 'Süleyman', 'Akay', '041-364-4686', '3081@mechero.com', 'Maintenance Advisor', '2021-04-03', 81);
INSERT INTO public.employee VALUES (1082, 'Şeni̇z', 'Sarı', '099-716-4622', '1082@mechero.com', 'Technician', '2020-11-28', 82);
INSERT INTO public.employee VALUES (2082, 'Nurcan', 'Şimşek', '071-705-7872', '2082@mechero.com', 'Electrical Systems Specialist', '2020-06-24', 82);
INSERT INTO public.employee VALUES (3082, 'Merve', 'Ölmez', '096-517-6832', '3082@mechero.com', 'Maintenance Advisor', '2021-07-11', 82);
INSERT INTO public.employee VALUES (1083, 'Azi̇z', 'Karaman', '075-842-5045', '1083@mechero.com', 'Technician', '2021-11-26', 83);
INSERT INTO public.employee VALUES (2083, 'Ahmet', 'Özkan', '084-332-6192', '2083@mechero.com', 'Electrical Systems Specialist', '2020-02-21', 83);
INSERT INTO public.employee VALUES (3083, 'Nur', 'Özmen', '081-768-6562', '3083@mechero.com', 'Maintenance Advisor', '2020-05-09', 83);
INSERT INTO public.employee VALUES (1084, 'Ataman', 'Er', '057-614-8244', '1084@mechero.com', 'Technician', '2020-08-18', 84);
INSERT INTO public.employee VALUES (2084, 'Nuray', 'Toprak', '003-165-1455', '2084@mechero.com', 'Electrical Systems Specialist', '2021-09-10', 84);
INSERT INTO public.employee VALUES (3084, 'Cemal', 'Budak', '057-374-1739', '3084@mechero.com', 'Maintenance Advisor', '2020-10-12', 84);
INSERT INTO public.employee VALUES (1085, 'Ataman', 'Sağlam', '048-964-8246', '1085@mechero.com', 'Technician', '2020-07-21', 85);
INSERT INTO public.employee VALUES (2085, 'Fati̇h', 'Özkan', '084-328-5573', '2085@mechero.com', 'Electrical Systems Specialist', '2021-04-27', 85);
INSERT INTO public.employee VALUES (3085, 'Çiçek', 'Güney', '088-482-0222', '3085@mechero.com', 'Maintenance Advisor', '2021-10-25', 85);
INSERT INTO public.employee VALUES (1086, 'Nuretti̇n', 'Şentürk', '068-473-3281', '1086@mechero.com', 'Technician', '2021-09-27', 86);
INSERT INTO public.employee VALUES (2086, 'Nurullah', 'Güner', '041-026-6822', '2086@mechero.com', 'Electrical Systems Specialist', '2021-09-22', 86);
INSERT INTO public.employee VALUES (3086, 'Gülten', 'Karaman', '028-405-0336', '3086@mechero.com', 'Maintenance Advisor', '2021-02-08', 86);
INSERT INTO public.employee VALUES (1087, 'Sude', 'Altun', '013-569-8287', '1087@mechero.com', 'Technician', '2020-08-20', 87);
INSERT INTO public.employee VALUES (2087, 'Sevim', 'Turan', '096-654-0216', '2087@mechero.com', 'Electrical Systems Specialist', '2021-09-07', 87);
INSERT INTO public.employee VALUES (3087, 'Can', 'Akman', '056-475-9064', '3087@mechero.com', 'Maintenance Advisor', '2021-03-03', 87);
INSERT INTO public.employee VALUES (1088, 'Ali̇can', 'Çakmak', '044-137-4585', '1088@mechero.com', 'Technician', '2021-05-10', 88);
INSERT INTO public.employee VALUES (2088, 'Berki̇n', 'Kara', '057-169-5273', '2088@mechero.com', 'Electrical Systems Specialist', '2021-02-27', 88);
INSERT INTO public.employee VALUES (3088, 'Tayfun', 'Cengiz', '054-123-7387', '3088@mechero.com', 'Maintenance Advisor', '2021-07-14', 88);
INSERT INTO public.employee VALUES (1089, 'Mustafa', 'Doğan', '011-453-3305', '1089@mechero.com', 'Technician', '2021-06-13', 89);
INSERT INTO public.employee VALUES (2089, 'Canan', 'Aydın', '036-172-7177', '2089@mechero.com', 'Electrical Systems Specialist', '2020-12-11', 89);
INSERT INTO public.employee VALUES (3089, 'Müge', 'Budak', '063-133-1218', '3089@mechero.com', 'Maintenance Advisor', '2021-05-23', 89);
INSERT INTO public.employee VALUES (1090, 'Alpcan', 'Tosun', '096-424-1585', '1090@mechero.com', 'Technician', '2020-03-26', 90);
INSERT INTO public.employee VALUES (2090, 'Ebru', 'Akpınar', '051-118-6229', '2090@mechero.com', 'Electrical Systems Specialist', '2020-03-11', 90);
INSERT INTO public.employee VALUES (3090, 'Cemre', 'Ak', '011-379-4218', '3090@mechero.com', 'Maintenance Advisor', '2021-02-16', 90);
INSERT INTO public.employee VALUES (1091, 'Atacan', 'Yalçın', '036-112-8546', '1091@mechero.com', 'Technician', '2021-01-23', 91);
INSERT INTO public.employee VALUES (2091, 'Hanife', 'Sönmez', '015-452-3972', '2091@mechero.com', 'Electrical Systems Specialist', '2021-07-25', 91);
INSERT INTO public.employee VALUES (3091, 'Büşra', 'Güler', '053-760-6277', '3091@mechero.com', 'Maintenance Advisor', '2020-10-04', 91);
INSERT INTO public.employee VALUES (1092, 'Alp', 'Gültekin', '038-849-9355', '1092@mechero.com', 'Technician', '2020-12-21', 92);
INSERT INTO public.employee VALUES (2092, 'Menderes', 'Aydoğan', '036-034-6734', '2092@mechero.com', 'Electrical Systems Specialist', '2020-09-20', 92);
INSERT INTO public.employee VALUES (3092, 'Zehra', 'Altın', '037-436-4374', '3092@mechero.com', 'Maintenance Advisor', '2020-06-10', 92);
INSERT INTO public.employee VALUES (1093, 'Nur', 'Akçay', '086-639-1614', '1093@mechero.com', 'Technician', '2021-02-25', 93);
INSERT INTO public.employee VALUES (2093, 'Sevi̇', 'Özmen', '055-528-3664', '2093@mechero.com', 'Electrical Systems Specialist', '2020-06-20', 93);
INSERT INTO public.employee VALUES (3093, 'Can', 'İlhan', '016-742-6253', '3093@mechero.com', 'Maintenance Advisor', '2021-06-15', 93);
INSERT INTO public.employee VALUES (1094, 'Adem', 'Yavuz', '042-767-6032', '1094@mechero.com', 'Technician', '2020-04-05', 94);
INSERT INTO public.employee VALUES (2094, 'Cemaletti̇n', 'Uğur', '043-655-0261', '2094@mechero.com', 'Electrical Systems Specialist', '2020-02-07', 94);
INSERT INTO public.employee VALUES (3094, 'Alparslan', 'Demir', '055-734-8382', '3094@mechero.com', 'Maintenance Advisor', '2021-11-20', 94);
INSERT INTO public.employee VALUES (1095, 'Gülsüm', 'Varol', '002-726-6678', '1095@mechero.com', 'Technician', '2021-11-28', 95);
INSERT INTO public.employee VALUES (2095, 'Naz', 'Aydın', '040-462-0249', '2095@mechero.com', 'Electrical Systems Specialist', '2021-01-18', 95);
INSERT INTO public.employee VALUES (3095, 'Yusuf', 'Öner', '064-844-5628', '3095@mechero.com', 'Maintenance Advisor', '2020-06-12', 95);
INSERT INTO public.employee VALUES (1096, 'Gökçe', 'Er', '077-384-1917', '1096@mechero.com', 'Technician', '2020-03-13', 96);
INSERT INTO public.employee VALUES (2096, 'Hatice', 'Güner', '025-425-6119', '2096@mechero.com', 'Electrical Systems Specialist', '2021-01-16', 96);
INSERT INTO public.employee VALUES (3096, 'Alptuğ', 'Özen', '036-577-5196', '3096@mechero.com', 'Maintenance Advisor', '2020-11-13', 96);
INSERT INTO public.employee VALUES (1097, 'Eren', 'Altıntaş', '025-527-3300', '1097@mechero.com', 'Technician', '2021-11-09', 97);
INSERT INTO public.employee VALUES (2097, 'Su', 'Akgün', '030-608-8033', '2097@mechero.com', 'Electrical Systems Specialist', '2021-04-18', 97);
INSERT INTO public.employee VALUES (3097, 'Kardelen', 'Günay', '047-496-9328', '3097@mechero.com', 'Maintenance Advisor', '2021-10-05', 97);
INSERT INTO public.employee VALUES (1098, 'Sultan', 'Özkaya', '086-030-4873', '1098@mechero.com', 'Technician', '2020-02-24', 98);
INSERT INTO public.employee VALUES (2098, 'Can', 'Aydoğdu', '041-751-4012', '2098@mechero.com', 'Electrical Systems Specialist', '2020-07-26', 98);
INSERT INTO public.employee VALUES (3098, 'Nuri̇', 'Adıgüzel', '043-246-0571', '3098@mechero.com', 'Maintenance Advisor', '2021-03-25', 98);
INSERT INTO public.employee VALUES (1099, 'Şerife', 'Şahin', '023-013-2262', '1099@mechero.com', 'Technician', '2021-11-29', 99);
INSERT INTO public.employee VALUES (2099, 'Alparslan', 'Güleç', '096-706-5379', '2099@mechero.com', 'Electrical Systems Specialist', '2021-06-04', 99);
INSERT INTO public.employee VALUES (3099, 'Gülten', 'Eser', '034-409-2378', '3099@mechero.com', 'Maintenance Advisor', '2020-06-11', 99);
INSERT INTO public.employee VALUES (1100, 'Nurgül', 'Çetin', '040-546-4316', '1100@mechero.com', 'Technician', '2021-11-19', 100);
INSERT INTO public.employee VALUES (2100, 'Şennur', 'Akkaya', '058-626-3266', '2100@mechero.com', 'Electrical Systems Specialist', '2020-09-07', 100);
INSERT INTO public.employee VALUES (3100, 'Berke', 'Kutlu', '031-443-8765', '3100@mechero.com', 'Maintenance Advisor', '2020-01-23', 100);
INSERT INTO public.employee VALUES (1101, 'Kadi̇r', 'Çetin', '014-997-1157', '1101@mechero.com', 'Technician', '2020-10-06', 101);
INSERT INTO public.employee VALUES (2101, 'Cankat', 'Uysal', '075-669-9932', '2101@mechero.com', 'Electrical Systems Specialist', '2021-12-06', 101);
INSERT INTO public.employee VALUES (3101, 'Ali̇m', 'Durmuş', '013-395-2573', '3101@mechero.com', 'Maintenance Advisor', '2021-04-27', 101);
INSERT INTO public.employee VALUES (1102, 'Ali̇', 'Koçak', '057-527-6373', '1102@mechero.com', 'Technician', '2020-08-28', 102);
INSERT INTO public.employee VALUES (2102, 'Gül', 'Köksal', '044-654-2674', '2102@mechero.com', 'Electrical Systems Specialist', '2021-08-13', 102);
INSERT INTO public.employee VALUES (3102, 'Güler', 'Akçay', '019-839-1331', '3102@mechero.com', 'Maintenance Advisor', '2020-08-22', 102);
INSERT INTO public.employee VALUES (1103, 'Nurgül', 'Bilgin', '055-767-8959', '1103@mechero.com', 'Technician', '2021-08-31', 103);
INSERT INTO public.employee VALUES (2103, 'Osman', 'Akgül', '072-465-2685', '2103@mechero.com', 'Electrical Systems Specialist', '2020-05-04', 103);
INSERT INTO public.employee VALUES (3103, 'Berki̇n', 'Albayrak', '004-688-3384', '3103@mechero.com', 'Maintenance Advisor', '2021-06-13', 103);
INSERT INTO public.employee VALUES (1104, 'Merve', 'Yiğit', '013-589-6882', '1104@mechero.com', 'Technician', '2021-05-27', 104);
INSERT INTO public.employee VALUES (2104, 'Cemal', 'Kandemir', '041-702-9044', '2104@mechero.com', 'Electrical Systems Specialist', '2020-06-11', 104);
INSERT INTO public.employee VALUES (3104, 'Güllü', 'Bozkurt', '076-556-8752', '3104@mechero.com', 'Maintenance Advisor', '2021-09-09', 104);
INSERT INTO public.employee VALUES (1105, 'Melike', 'Bayraktar', '018-865-4340', '1105@mechero.com', 'Technician', '2021-02-19', 105);
INSERT INTO public.employee VALUES (2105, 'Gülşen', 'Aslan', '053-426-2025', '2105@mechero.com', 'Electrical Systems Specialist', '2020-07-25', 105);
INSERT INTO public.employee VALUES (3105, 'Ayşenaz', 'Doğru', '034-336-2865', '3105@mechero.com', 'Maintenance Advisor', '2020-04-25', 105);
INSERT INTO public.employee VALUES (1106, 'Ceren', 'Zengin', '035-427-3133', '1106@mechero.com', 'Technician', '2020-04-27', 106);
INSERT INTO public.employee VALUES (2106, 'Cansel', 'Sert', '061-659-8875', '2106@mechero.com', 'Electrical Systems Specialist', '2021-04-29', 106);
INSERT INTO public.employee VALUES (3106, 'Özlem', 'Kılınç', '003-857-5455', '3106@mechero.com', 'Maintenance Advisor', '2021-07-11', 106);
INSERT INTO public.employee VALUES (1107, 'Hali̇l', 'Özkan', '052-775-1320', '1107@mechero.com', 'Technician', '2021-09-02', 107);
INSERT INTO public.employee VALUES (2107, 'Ayşen', 'Özer', '080-274-9568', '2107@mechero.com', 'Electrical Systems Specialist', '2020-04-22', 107);
INSERT INTO public.employee VALUES (3107, 'Atalay', 'Mert', '088-571-0715', '3107@mechero.com', 'Maintenance Advisor', '2021-07-22', 107);
INSERT INTO public.employee VALUES (1108, 'Hanife', 'Taşçi', '032-685-9240', '1108@mechero.com', 'Technician', '2020-05-27', 108);
INSERT INTO public.employee VALUES (2108, 'Sali̇h', 'Ercan', '023-707-2160', '2108@mechero.com', 'Electrical Systems Specialist', '2021-06-21', 108);
INSERT INTO public.employee VALUES (3108, 'Fati̇h', 'Akay', '080-315-7517', '3108@mechero.com', 'Maintenance Advisor', '2021-07-09', 108);
INSERT INTO public.employee VALUES (1109, 'Menderes', 'Gökçe', '084-774-6481', '1109@mechero.com', 'Technician', '2020-07-05', 109);
INSERT INTO public.employee VALUES (2109, 'İsmai̇L', 'Güleç', '004-245-1325', '2109@mechero.com', 'Electrical Systems Specialist', '2020-04-29', 109);
INSERT INTO public.employee VALUES (3109, 'Ramazan', 'Korkmaz', '051-768-3338', '3109@mechero.com', 'Maintenance Advisor', '2020-11-08', 109);
INSERT INTO public.employee VALUES (1110, 'Nureddi̇n', 'Cengiz', '065-036-5248', '1110@mechero.com', 'Technician', '2021-01-11', 110);
INSERT INTO public.employee VALUES (2110, 'Manolya', 'Akdağ', '028-956-1661', '2110@mechero.com', 'Electrical Systems Specialist', '2021-11-03', 110);
INSERT INTO public.employee VALUES (3110, 'Sali̇h', 'Kaya', '083-838-9463', '3110@mechero.com', 'Maintenance Advisor', '2020-08-05', 110);
INSERT INTO public.employee VALUES (1111, 'Nurten', 'Ersoy', '035-497-4821', '1111@mechero.com', 'Technician', '2020-03-07', 111);
INSERT INTO public.employee VALUES (2111, 'Ahmet', 'Koyuncu', '006-730-4558', '2111@mechero.com', 'Electrical Systems Specialist', '2020-01-29', 111);
INSERT INTO public.employee VALUES (3111, 'Ümmü', 'Budak', '050-871-7416', '3111@mechero.com', 'Maintenance Advisor', '2021-05-30', 111);
INSERT INTO public.employee VALUES (1112, 'Mahmut', 'Fırat', '084-218-4151', '1112@mechero.com', 'Technician', '2020-06-19', 112);
INSERT INTO public.employee VALUES (2112, 'Menekşe', 'Keskin', '057-475-0538', '2112@mechero.com', 'Electrical Systems Specialist', '2020-08-17', 112);
INSERT INTO public.employee VALUES (3112, 'Nazi̇fe', 'Mutlu', '055-092-5776', '3112@mechero.com', 'Maintenance Advisor', '2020-07-25', 112);
INSERT INTO public.employee VALUES (1113, 'Sevim', 'Çelebi', '016-685-3857', '1113@mechero.com', 'Technician', '2020-03-07', 113);
INSERT INTO public.employee VALUES (2113, 'Nureddi̇n', 'Türkmen', '007-242-2853', '2113@mechero.com', 'Electrical Systems Specialist', '2021-05-10', 113);
INSERT INTO public.employee VALUES (3113, 'Mehmet', 'Güner', '089-441-6484', '3113@mechero.com', 'Maintenance Advisor', '2020-01-23', 113);
INSERT INTO public.employee VALUES (1114, 'Alptuğ', 'Can', '031-717-9479', '1114@mechero.com', 'Technician', '2020-11-16', 114);
INSERT INTO public.employee VALUES (2114, 'Alphan', 'Çiftçi', '071-142-5886', '2114@mechero.com', 'Electrical Systems Specialist', '2020-06-30', 114);
INSERT INTO public.employee VALUES (3114, 'Berke', 'Çimen', '026-850-7674', '3114@mechero.com', 'Maintenance Advisor', '2021-08-01', 114);
INSERT INTO public.employee VALUES (1115, 'Berki̇n', 'Yıldız', '069-464-4689', '1115@mechero.com', 'Technician', '2021-11-20', 115);
INSERT INTO public.employee VALUES (2115, 'Ceren', 'Uzun', '016-424-4455', '2115@mechero.com', 'Electrical Systems Specialist', '2021-08-30', 115);
INSERT INTO public.employee VALUES (3115, 'Nuriye', 'Kaplan', '028-714-8097', '3115@mechero.com', 'Maintenance Advisor', '2020-07-10', 115);
INSERT INTO public.employee VALUES (1116, 'Gülbahar', 'Demirel', '076-626-6087', '1116@mechero.com', 'Technician', '2020-10-17', 116);
INSERT INTO public.employee VALUES (2116, 'Caner', 'Dursun', '073-745-0933', '2116@mechero.com', 'Electrical Systems Specialist', '2021-10-05', 116);
INSERT INTO public.employee VALUES (3116, 'Mert', 'Sönmez', '066-097-4346', '3116@mechero.com', 'Maintenance Advisor', '2020-02-12', 116);
INSERT INTO public.employee VALUES (1117, 'İhsan', 'Çetin', '075-326-3878', '1117@mechero.com', 'Technician', '2020-06-15', 117);
INSERT INTO public.employee VALUES (2117, 'Hüseyi̇n', 'Kuru', '023-994-3834', '2117@mechero.com', 'Electrical Systems Specialist', '2020-11-13', 117);
INSERT INTO public.employee VALUES (3117, 'Hacer', 'Toprak', '066-714-4091', '3117@mechero.com', 'Maintenance Advisor', '2020-11-28', 117);
INSERT INTO public.employee VALUES (1118, 'Olcay', 'Yavuz', '081-272-1583', '1118@mechero.com', 'Technician', '2020-04-09', 118);
INSERT INTO public.employee VALUES (2118, 'Ataberk', 'Uğur', '077-144-1249', '2118@mechero.com', 'Electrical Systems Specialist', '2021-02-01', 118);
INSERT INTO public.employee VALUES (3118, 'Fatma', 'Ceylan', '061-945-6127', '3118@mechero.com', 'Maintenance Advisor', '2021-10-02', 118);
INSERT INTO public.employee VALUES (1119, 'Cemre', 'Çelebi', '013-507-0584', '1119@mechero.com', 'Technician', '2020-01-03', 119);
INSERT INTO public.employee VALUES (2119, 'Nazmi̇ye', 'Özden', '042-754-5267', '2119@mechero.com', 'Electrical Systems Specialist', '2021-06-01', 119);
INSERT INTO public.employee VALUES (3119, 'Nazmi̇ye', 'Erdem', '063-523-3322', '3119@mechero.com', 'Maintenance Advisor', '2020-07-20', 119);
INSERT INTO public.employee VALUES (1120, 'Şahi̇n', 'Aksu', '001-144-1289', '1120@mechero.com', 'Technician', '2021-10-02', 120);
INSERT INTO public.employee VALUES (2120, 'Mehmet', 'Özden', '081-585-2581', '2120@mechero.com', 'Electrical Systems Specialist', '2021-07-13', 120);
INSERT INTO public.employee VALUES (3120, 'Samet', 'Karakaya', '031-567-8545', '3120@mechero.com', 'Maintenance Advisor', '2020-03-09', 120);
INSERT INTO public.employee VALUES (1121, 'Berker', 'Atmaca', '042-758-2379', '1121@mechero.com', 'Technician', '2020-07-04', 121);
INSERT INTO public.employee VALUES (2121, 'Cemaletti̇n', 'Özçelik', '088-328-4642', '2121@mechero.com', 'Electrical Systems Specialist', '2020-05-13', 121);
INSERT INTO public.employee VALUES (3121, 'Caner', 'Esen', '015-728-5776', '3121@mechero.com', 'Maintenance Advisor', '2020-03-03', 121);
INSERT INTO public.employee VALUES (1122, 'Cemi̇l', 'Uçar', '056-802-7734', '1122@mechero.com', 'Technician', '2020-12-03', 122);
INSERT INTO public.employee VALUES (2122, 'Nurullah', 'Er', '004-552-7057', '2122@mechero.com', 'Electrical Systems Specialist', '2021-09-27', 122);
INSERT INTO public.employee VALUES (3122, 'Nida', 'Türkmen', '026-428-1732', '3122@mechero.com', 'Maintenance Advisor', '2020-10-04', 122);
INSERT INTO public.employee VALUES (1123, 'Sevi̇', 'Öner', '046-693-4257', '1123@mechero.com', 'Technician', '2021-12-11', 123);
INSERT INTO public.employee VALUES (2123, 'Alperen', 'İnce', '084-942-1168', '2123@mechero.com', 'Electrical Systems Specialist', '2021-06-24', 123);
INSERT INTO public.employee VALUES (3123, 'İbrahi̇m', 'Durmaz', '056-890-1400', '3123@mechero.com', 'Maintenance Advisor', '2020-09-13', 123);
INSERT INTO public.employee VALUES (1124, 'Samet', 'Öz', '058-899-8832', '1124@mechero.com', 'Technician', '2021-02-26', 124);
INSERT INTO public.employee VALUES (2124, 'Efe', 'Altuntaş', '040-694-2029', '2124@mechero.com', 'Electrical Systems Specialist', '2020-09-09', 124);
INSERT INTO public.employee VALUES (3124, 'Burak', 'Genç', '076-927-3182', '3124@mechero.com', 'Maintenance Advisor', '2020-10-24', 124);
INSERT INTO public.employee VALUES (1125, 'Emirhan', 'Küçük', '081-651-0450', '1125@mechero.com', 'Technician', '2021-10-04', 125);
INSERT INTO public.employee VALUES (2125, 'Fadime', 'Balcı', '052-172-8912', '2125@mechero.com', 'Electrical Systems Specialist', '2020-12-23', 125);
INSERT INTO public.employee VALUES (3125, 'Osman', 'Akbaş', '048-712-2488', '3125@mechero.com', 'Maintenance Advisor', '2020-04-13', 125);
INSERT INTO public.employee VALUES (1126, 'Ömer', 'Öz', '077-374-2994', '1126@mechero.com', 'Technician', '2020-03-16', 126);
INSERT INTO public.employee VALUES (2126, 'Nurullah', 'Çevik', '041-872-7141', '2126@mechero.com', 'Electrical Systems Specialist', '2021-04-18', 126);
INSERT INTO public.employee VALUES (3126, 'Menderes', 'Akyol', '058-803-6263', '3126@mechero.com', 'Maintenance Advisor', '2021-01-19', 126);
INSERT INTO public.employee VALUES (1127, 'Gülsüm', 'Bülbül', '035-987-0558', '1127@mechero.com', 'Technician', '2021-01-27', 127);
INSERT INTO public.employee VALUES (2127, 'Semra', 'Atmaca', '087-341-8851', '2127@mechero.com', 'Electrical Systems Specialist', '2021-08-08', 127);
INSERT INTO public.employee VALUES (3127, 'Serkan', 'Çalışkan', '006-552-4182', '3127@mechero.com', 'Maintenance Advisor', '2020-01-04', 127);
INSERT INTO public.employee VALUES (1128, 'Berke', 'Şimşek', '026-525-2905', '1128@mechero.com', 'Technician', '2020-06-10', 128);
INSERT INTO public.employee VALUES (2128, 'Sultan', 'Türk', '011-301-3147', '2128@mechero.com', 'Electrical Systems Specialist', '2020-05-28', 128);
INSERT INTO public.employee VALUES (3128, 'Sevi̇lay', 'Doğru', '072-718-3675', '3128@mechero.com', 'Maintenance Advisor', '2021-02-18', 128);
INSERT INTO public.employee VALUES (1129, 'Ataberk', 'Altuntaş', '006-402-0316', '1129@mechero.com', 'Technician', '2020-04-30', 129);
INSERT INTO public.employee VALUES (2129, 'Gökçe', 'Demir', '029-431-1030', '2129@mechero.com', 'Electrical Systems Specialist', '2021-02-20', 129);
INSERT INTO public.employee VALUES (3129, 'Atay', 'Ataş', '002-315-7283', '3129@mechero.com', 'Maintenance Advisor', '2020-07-05', 129);
INSERT INTO public.employee VALUES (1130, 'Müge', 'Karahan', '006-327-1368', '1130@mechero.com', 'Technician', '2021-01-28', 130);
INSERT INTO public.employee VALUES (2130, 'Kardelen', 'Esen', '084-067-4763', '2130@mechero.com', 'Electrical Systems Specialist', '2021-03-07', 130);
INSERT INTO public.employee VALUES (3130, 'Fi̇li̇z', 'Sarıkaya', '013-282-6112', '3130@mechero.com', 'Maintenance Advisor', '2020-06-14', 130);
INSERT INTO public.employee VALUES (1131, 'Mahmut', 'Çiçek', '089-536-3659', '1131@mechero.com', 'Technician', '2021-07-19', 131);
INSERT INTO public.employee VALUES (2131, 'Büşra', 'Şengül', '035-816-5471', '2131@mechero.com', 'Electrical Systems Specialist', '2021-11-05', 131);
INSERT INTO public.employee VALUES (3131, 'Nurcan', 'Arıkan', '072-350-2678', '3131@mechero.com', 'Maintenance Advisor', '2021-10-22', 131);
INSERT INTO public.employee VALUES (1132, 'Gülşen', 'Güngör', '028-901-2674', '1132@mechero.com', 'Technician', '2021-03-25', 132);
INSERT INTO public.employee VALUES (2132, 'Esra', 'Torun', '066-371-3936', '2132@mechero.com', 'Electrical Systems Specialist', '2021-06-03', 132);
INSERT INTO public.employee VALUES (3132, 'Suna', 'Coşkun', '045-022-5544', '3132@mechero.com', 'Maintenance Advisor', '2020-03-01', 132);
INSERT INTO public.employee VALUES (1133, 'Yasemin', 'Zengin', '065-313-2436', '1133@mechero.com', 'Technician', '2020-10-19', 133);
INSERT INTO public.employee VALUES (2133, 'Kübra', 'Aksu', '006-056-9877', '2133@mechero.com', 'Electrical Systems Specialist', '2021-07-06', 133);
INSERT INTO public.employee VALUES (3133, 'Emre', 'Şener', '053-357-7742', '3133@mechero.com', 'Maintenance Advisor', '2021-11-14', 133);
INSERT INTO public.employee VALUES (1134, 'Atabey', 'Kaçar', '008-939-8463', '1134@mechero.com', 'Technician', '2020-06-21', 134);
INSERT INTO public.employee VALUES (2134, 'Sali̇h', 'Pehlivan', '069-441-7242', '2134@mechero.com', 'Electrical Systems Specialist', '2020-07-10', 134);
INSERT INTO public.employee VALUES (3134, 'Emi̇n', 'Taşdemir', '004-016-2369', '3134@mechero.com', 'Maintenance Advisor', '2020-02-02', 134);
INSERT INTO public.employee VALUES (1135, 'Emre', 'Tuncer', '072-928-4488', '1135@mechero.com', 'Technician', '2021-03-30', 135);
INSERT INTO public.employee VALUES (2135, 'Cemal', 'Özmen', '030-387-0567', '2135@mechero.com', 'Electrical Systems Specialist', '2021-05-15', 135);
INSERT INTO public.employee VALUES (3135, 'Havva', 'Sert', '069-445-6071', '3135@mechero.com', 'Maintenance Advisor', '2020-01-16', 135);
INSERT INTO public.employee VALUES (1136, 'Sudenaz', 'Gezer', '004-465-8732', '1136@mechero.com', 'Technician', '2020-12-17', 136);
INSERT INTO public.employee VALUES (2136, 'Şahi̇n', 'Dinç', '077-702-5793', '2136@mechero.com', 'Electrical Systems Specialist', '2020-02-15', 136);
INSERT INTO public.employee VALUES (3136, 'Nurcan', 'Ergin', '032-462-4792', '3136@mechero.com', 'Maintenance Advisor', '2021-05-20', 136);
INSERT INTO public.employee VALUES (1137, 'Samet', 'Kartal', '014-053-4587', '1137@mechero.com', 'Technician', '2021-12-11', 137);
INSERT INTO public.employee VALUES (2137, 'Osman', 'Gündoğdu', '098-335-7580', '2137@mechero.com', 'Electrical Systems Specialist', '2020-04-15', 137);
INSERT INTO public.employee VALUES (3137, 'Nuran', 'Taş', '011-674-6855', '3137@mechero.com', 'Maintenance Advisor', '2020-05-06', 137);
INSERT INTO public.employee VALUES (1138, 'Menderes', 'Aydın', '047-783-8583', '1138@mechero.com', 'Technician', '2020-02-06', 138);
INSERT INTO public.employee VALUES (2138, 'Ramazan', 'İlhan', '073-080-2579', '2138@mechero.com', 'Electrical Systems Specialist', '2021-03-14', 138);
INSERT INTO public.employee VALUES (3138, 'Defne', 'Bal', '051-543-4308', '3138@mechero.com', 'Maintenance Advisor', '2020-10-11', 138);
INSERT INTO public.employee VALUES (1139, 'Ata', 'Başaran', '011-510-0887', '1139@mechero.com', 'Technician', '2020-09-03', 139);
INSERT INTO public.employee VALUES (2139, 'Cemi̇l', 'Yaşar', '029-422-7431', '2139@mechero.com', 'Electrical Systems Specialist', '2020-11-14', 139);
INSERT INTO public.employee VALUES (3139, 'Dilek', 'Orhan', '034-526-1947', '3139@mechero.com', 'Maintenance Advisor', '2021-10-01', 139);
INSERT INTO public.employee VALUES (1140, 'Mustafa', 'Yıldırım', '014-139-6387', '1140@mechero.com', 'Technician', '2020-01-15', 140);
INSERT INTO public.employee VALUES (2140, 'Nazi̇re', 'Genç', '020-158-2973', '2140@mechero.com', 'Electrical Systems Specialist', '2020-01-29', 140);
INSERT INTO public.employee VALUES (3140, 'Nuriye', 'Budak', '020-048-5351', '3140@mechero.com', 'Maintenance Advisor', '2020-07-05', 140);
INSERT INTO public.employee VALUES (1141, 'Aysel', 'Türk', '045-330-6554', '1141@mechero.com', 'Technician', '2020-07-07', 141);
INSERT INTO public.employee VALUES (2141, 'Zeynep', 'Dağ', '076-616-9122', '2141@mechero.com', 'Electrical Systems Specialist', '2020-07-01', 141);
INSERT INTO public.employee VALUES (3141, 'Sevi̇m', 'Özçelik', '028-743-2044', '3141@mechero.com', 'Maintenance Advisor', '2020-08-20', 141);
INSERT INTO public.employee VALUES (1142, 'Meryem', 'Karahan', '072-231-7559', '1142@mechero.com', 'Technician', '2021-01-27', 142);
INSERT INTO public.employee VALUES (2142, 'Mustafa', 'Türk', '058-936-5279', '2142@mechero.com', 'Electrical Systems Specialist', '2020-05-04', 142);
INSERT INTO public.employee VALUES (3142, 'Cemali̇', 'Dinç', '000-037-7176', '3142@mechero.com', 'Maintenance Advisor', '2020-05-29', 142);
INSERT INTO public.employee VALUES (1143, 'Berke', 'Gündüz', '071-731-1812', '1143@mechero.com', 'Technician', '2020-08-01', 143);
INSERT INTO public.employee VALUES (2143, 'Sonat', 'Keskin', '070-754-7614', '2143@mechero.com', 'Electrical Systems Specialist', '2020-12-08', 143);
INSERT INTO public.employee VALUES (3143, 'Yusuf', 'Altay', '020-694-0138', '3143@mechero.com', 'Maintenance Advisor', '2021-10-15', 143);
INSERT INTO public.employee VALUES (1144, 'Şennur', 'Çalışkan', '014-716-6568', '1144@mechero.com', 'Technician', '2021-02-14', 144);
INSERT INTO public.employee VALUES (2144, 'Gülşen', 'Karakoç', '055-340-0513', '2144@mechero.com', 'Electrical Systems Specialist', '2020-01-23', 144);
INSERT INTO public.employee VALUES (3144, 'Gülay', 'Çam', '019-361-6565', '3144@mechero.com', 'Maintenance Advisor', '2020-01-18', 144);
INSERT INTO public.employee VALUES (1145, 'Sunay', 'İnce', '043-171-4550', '1145@mechero.com', 'Technician', '2021-12-15', 145);
INSERT INTO public.employee VALUES (2145, 'Kardelen', 'Ekici', '035-367-2618', '2145@mechero.com', 'Electrical Systems Specialist', '2020-05-25', 145);
INSERT INTO public.employee VALUES (3145, 'Sudenaz', 'Turgut', '033-408-6064', '3145@mechero.com', 'Maintenance Advisor', '2021-07-14', 145);
INSERT INTO public.employee VALUES (1146, 'Nazar', 'Özcan', '005-366-4658', '1146@mechero.com', 'Technician', '2020-11-10', 146);
INSERT INTO public.employee VALUES (2146, 'Nazi̇re', 'Güleç', '035-989-5875', '2146@mechero.com', 'Electrical Systems Specialist', '2021-11-24', 146);
INSERT INTO public.employee VALUES (3146, 'Ali̇can', 'Akgül', '028-988-1780', '3146@mechero.com', 'Maintenance Advisor', '2020-12-25', 146);
INSERT INTO public.employee VALUES (1147, 'Bedirhan', 'Yiğit', '080-540-1992', '1147@mechero.com', 'Technician', '2021-08-19', 147);
INSERT INTO public.employee VALUES (2147, 'Eda', 'Eroğlu', '071-797-6735', '2147@mechero.com', 'Electrical Systems Specialist', '2021-09-18', 147);
INSERT INTO public.employee VALUES (3147, 'Alperen', 'Günay', '098-186-8747', '3147@mechero.com', 'Maintenance Advisor', '2021-06-02', 147);
INSERT INTO public.employee VALUES (1148, 'Serhat', 'Akçay', '098-242-3767', '1148@mechero.com', 'Technician', '2021-10-10', 148);
INSERT INTO public.employee VALUES (2148, 'Nazi̇k', 'Ergin', '073-218-6854', '2148@mechero.com', 'Electrical Systems Specialist', '2020-11-08', 148);
INSERT INTO public.employee VALUES (3148, 'Volkan', 'Temel', '047-250-6877', '3148@mechero.com', 'Maintenance Advisor', '2020-08-29', 148);
INSERT INTO public.employee VALUES (1149, 'Ergun', 'Taşçi', '078-658-6320', '1149@mechero.com', 'Technician', '2020-08-02', 149);
INSERT INTO public.employee VALUES (2149, 'Kardelen', 'Özer', '025-851-3076', '2149@mechero.com', 'Electrical Systems Specialist', '2020-03-15', 149);
INSERT INTO public.employee VALUES (3149, 'Gülşen', 'Aydın', '088-418-2854', '3149@mechero.com', 'Maintenance Advisor', '2021-02-26', 149);
INSERT INTO public.employee VALUES (1150, 'Serkan', 'Akgün', '023-245-0262', '1150@mechero.com', 'Technician', '2020-01-17', 150);
INSERT INTO public.employee VALUES (2150, 'Can', 'Akyol', '083-852-5891', '2150@mechero.com', 'Electrical Systems Specialist', '2020-12-04', 150);
INSERT INTO public.employee VALUES (3150, 'Azi̇z', 'Akyol', '073-682-1226', '3150@mechero.com', 'Maintenance Advisor', '2020-02-24', 150);
INSERT INTO public.employee VALUES (1151, 'Sümeyra', 'Ünal', '051-141-5434', '1151@mechero.com', 'Technician', '2021-10-27', 151);
INSERT INTO public.employee VALUES (2151, 'Serkan', 'Şimşek', '046-636-1147', '2151@mechero.com', 'Electrical Systems Specialist', '2021-10-17', 151);
INSERT INTO public.employee VALUES (3151, 'Nida', 'Yüksel', '093-548-4158', '3151@mechero.com', 'Maintenance Advisor', '2020-02-25', 151);
INSERT INTO public.employee VALUES (1152, 'Nazlican', 'Gündüz', '041-285-7824', '1152@mechero.com', 'Technician', '2020-10-31', 152);
INSERT INTO public.employee VALUES (2152, 'Meli̇sa', 'Özkan', '032-588-2365', '2152@mechero.com', 'Electrical Systems Specialist', '2021-02-18', 152);
INSERT INTO public.employee VALUES (3152, 'Özlem', 'Akpınar', '011-494-9766', '3152@mechero.com', 'Maintenance Advisor', '2021-01-02', 152);
INSERT INTO public.employee VALUES (1153, 'Yasemin', 'Kahraman', '037-769-2133', '1153@mechero.com', 'Technician', '2020-10-24', 153);
INSERT INTO public.employee VALUES (2153, 'Kardelen', 'Kurt', '082-366-6306', '2153@mechero.com', 'Electrical Systems Specialist', '2020-12-14', 153);
INSERT INTO public.employee VALUES (3153, 'Elif', 'Karataş', '070-817-9889', '3153@mechero.com', 'Maintenance Advisor', '2020-05-01', 153);
INSERT INTO public.employee VALUES (1154, 'Defne', 'Öztürk', '057-700-3698', '1154@mechero.com', 'Technician', '2020-03-26', 154);
INSERT INTO public.employee VALUES (2154, 'Melike', 'Koyuncu', '028-539-4699', '2154@mechero.com', 'Electrical Systems Specialist', '2021-07-03', 154);
INSERT INTO public.employee VALUES (3154, 'Gökçe', 'Akkaya', '081-236-7762', '3154@mechero.com', 'Maintenance Advisor', '2021-11-03', 154);
INSERT INTO public.employee VALUES (1155, 'Rabia', 'Aksu', '022-595-0568', '1155@mechero.com', 'Technician', '2020-04-11', 155);
INSERT INTO public.employee VALUES (2155, 'Berkehan', 'Çoban', '066-734-2313', '2155@mechero.com', 'Electrical Systems Specialist', '2021-12-03', 155);
INSERT INTO public.employee VALUES (3155, 'Nida', 'Uçar', '025-868-5586', '3155@mechero.com', 'Maintenance Advisor', '2021-02-04', 155);
INSERT INTO public.employee VALUES (1156, 'Nurten', 'Karadeniz', '065-047-3155', '1156@mechero.com', 'Technician', '2021-10-16', 156);
INSERT INTO public.employee VALUES (2156, 'Aysel', 'Demircan', '062-297-7268', '2156@mechero.com', 'Electrical Systems Specialist', '2021-12-21', 156);
INSERT INTO public.employee VALUES (3156, 'Rıza', 'Ekici', '083-219-6787', '3156@mechero.com', 'Maintenance Advisor', '2021-09-25', 156);
INSERT INTO public.employee VALUES (1157, 'Ceren', 'Öz', '013-383-0888', '1157@mechero.com', 'Technician', '2020-04-19', 157);
INSERT INTO public.employee VALUES (2157, 'Kadi̇r', 'Karadeniz', '016-628-2835', '2157@mechero.com', 'Electrical Systems Specialist', '2020-04-26', 157);
INSERT INTO public.employee VALUES (3157, 'Poyraz', 'Sönmez', '032-439-7118', '3157@mechero.com', 'Maintenance Advisor', '2020-12-27', 157);
INSERT INTO public.employee VALUES (1158, 'Cankat', 'Duran', '038-237-0877', '1158@mechero.com', 'Technician', '2021-02-20', 158);
INSERT INTO public.employee VALUES (2158, 'Leyla', 'Atalay', '048-711-8778', '2158@mechero.com', 'Electrical Systems Specialist', '2021-02-02', 158);
INSERT INTO public.employee VALUES (3158, 'Berk', 'Ölmez', '061-552-4204', '3158@mechero.com', 'Maintenance Advisor', '2020-05-12', 158);
INSERT INTO public.employee VALUES (1159, 'Alpay', 'Karakoç', '044-240-1795', '1159@mechero.com', 'Technician', '2020-06-22', 159);
INSERT INTO public.employee VALUES (2159, 'Alphan', 'Karataş', '071-124-4189', '2159@mechero.com', 'Electrical Systems Specialist', '2021-02-01', 159);
INSERT INTO public.employee VALUES (3159, 'Berke', 'Torun', '066-043-3671', '3159@mechero.com', 'Maintenance Advisor', '2020-05-09', 159);
INSERT INTO public.employee VALUES (1160, 'Yasemin', 'Yeşil', '061-455-0897', '1160@mechero.com', 'Technician', '2020-09-23', 160);
INSERT INTO public.employee VALUES (2160, 'Nurullah', 'Kahraman', '035-473-5583', '2160@mechero.com', 'Electrical Systems Specialist', '2021-05-27', 160);
INSERT INTO public.employee VALUES (3160, 'Atahan', 'Gökçe', '050-177-3875', '3160@mechero.com', 'Maintenance Advisor', '2020-12-22', 160);
INSERT INTO public.employee VALUES (1161, 'İsmai̇L', 'Şen', '083-827-1358', '1161@mechero.com', 'Technician', '2020-01-08', 161);
INSERT INTO public.employee VALUES (2161, 'Efe', 'Doğru', '054-948-8301', '2161@mechero.com', 'Electrical Systems Specialist', '2020-05-07', 161);
INSERT INTO public.employee VALUES (3161, 'Zeynep', 'Mutlu', '021-650-9561', '3161@mechero.com', 'Maintenance Advisor', '2020-01-15', 161);
INSERT INTO public.employee VALUES (1162, 'Emirhan', 'Gökçe', '056-017-5187', '1162@mechero.com', 'Technician', '2020-10-28', 162);
INSERT INTO public.employee VALUES (2162, 'Ercan', 'Dinç', '048-085-8760', '2162@mechero.com', 'Electrical Systems Specialist', '2020-03-15', 162);
INSERT INTO public.employee VALUES (3162, 'Meral', 'Tan', '023-242-8475', '3162@mechero.com', 'Maintenance Advisor', '2021-07-27', 162);
INSERT INTO public.employee VALUES (1163, 'Dilek', 'Karakuş', '039-726-1304', '1163@mechero.com', 'Technician', '2021-03-31', 163);
INSERT INTO public.employee VALUES (2163, 'Atalay', 'Yeşil', '061-251-6000', '2163@mechero.com', 'Electrical Systems Specialist', '2020-10-19', 163);
INSERT INTO public.employee VALUES (3163, 'Hüseyi̇n', 'Esen', '049-331-4756', '3163@mechero.com', 'Maintenance Advisor', '2021-08-06', 163);
INSERT INTO public.employee VALUES (1164, 'Ali̇can', 'Güngör', '080-215-5316', '1164@mechero.com', 'Technician', '2021-10-29', 164);
INSERT INTO public.employee VALUES (2164, 'Sudenur', 'Özdemir', '064-452-2853', '2164@mechero.com', 'Electrical Systems Specialist', '2020-10-28', 164);
INSERT INTO public.employee VALUES (3164, 'Ümmü', 'Şahin', '052-807-5386', '3164@mechero.com', 'Maintenance Advisor', '2020-07-18', 164);
INSERT INTO public.employee VALUES (1165, 'Dilek', 'Şentürk', '088-126-6614', '1165@mechero.com', 'Technician', '2020-06-20', 165);
INSERT INTO public.employee VALUES (2165, 'Enes', 'Kartal', '053-934-8494', '2165@mechero.com', 'Electrical Systems Specialist', '2020-06-05', 165);
INSERT INTO public.employee VALUES (3165, 'Nida', 'Pehlivan', '045-047-9773', '3165@mechero.com', 'Maintenance Advisor', '2021-07-19', 165);
INSERT INTO public.employee VALUES (1166, 'Tayfun', 'Keleş', '066-844-2497', '1166@mechero.com', 'Technician', '2020-01-21', 166);
INSERT INTO public.employee VALUES (2166, 'Meryem', 'Bulut', '011-511-2875', '2166@mechero.com', 'Electrical Systems Specialist', '2020-10-17', 166);
INSERT INTO public.employee VALUES (3166, 'Nazi̇me', 'Altay', '066-537-6855', '3166@mechero.com', 'Maintenance Advisor', '2020-08-26', 166);
INSERT INTO public.employee VALUES (1167, 'Sevi̇n', 'Karakoç', '068-387-6661', '1167@mechero.com', 'Technician', '2021-10-29', 167);
INSERT INTO public.employee VALUES (2167, 'Aysel', 'Adıgüzel', '036-044-5164', '2167@mechero.com', 'Electrical Systems Specialist', '2021-03-15', 167);
INSERT INTO public.employee VALUES (3167, 'Hüseyi̇n', 'Boz', '072-865-6826', '3167@mechero.com', 'Maintenance Advisor', '2020-05-24', 167);
INSERT INTO public.employee VALUES (1168, 'Güllü', 'Orhan', '039-266-8320', '1168@mechero.com', 'Technician', '2021-02-14', 168);
INSERT INTO public.employee VALUES (2168, 'Serhat', 'Aksu', '081-269-8616', '2168@mechero.com', 'Electrical Systems Specialist', '2020-11-14', 168);
INSERT INTO public.employee VALUES (3168, 'Cem', 'Baş', '066-239-5691', '3168@mechero.com', 'Maintenance Advisor', '2020-08-10', 168);
INSERT INTO public.employee VALUES (1169, 'İsmai̇l', 'Doğan', '018-577-3941', '1169@mechero.com', 'Technician', '2020-07-14', 169);
INSERT INTO public.employee VALUES (2169, 'Ali̇m', 'Gökçe', '022-244-4722', '2169@mechero.com', 'Electrical Systems Specialist', '2021-11-19', 169);
INSERT INTO public.employee VALUES (3169, 'Caner', 'İnan', '017-489-8277', '3169@mechero.com', 'Maintenance Advisor', '2020-08-04', 169);
INSERT INTO public.employee VALUES (1170, 'Menekşe', 'Topal', '036-735-5197', '1170@mechero.com', 'Technician', '2020-06-14', 170);
INSERT INTO public.employee VALUES (2170, 'İsmai̇L', 'Bilgin', '043-606-7775', '2170@mechero.com', 'Electrical Systems Specialist', '2020-07-23', 170);
INSERT INTO public.employee VALUES (3170, 'Mahmut', 'Kahraman', '091-328-6235', '3170@mechero.com', 'Maintenance Advisor', '2020-04-13', 170);
INSERT INTO public.employee VALUES (1171, 'Başak', 'Yaman', '001-053-1137', '1171@mechero.com', 'Technician', '2021-01-31', 171);
INSERT INTO public.employee VALUES (2171, 'Nida', 'Erdoğan', '069-906-5991', '2171@mechero.com', 'Electrical Systems Specialist', '2020-05-19', 171);
INSERT INTO public.employee VALUES (3171, 'Suna', 'Gök', '029-510-4192', '3171@mechero.com', 'Maintenance Advisor', '2020-12-10', 171);
INSERT INTO public.employee VALUES (1172, 'Eda', 'Sarıkaya', '052-606-6632', '1172@mechero.com', 'Technician', '2020-02-14', 172);
INSERT INTO public.employee VALUES (2172, 'Cemal', 'Baş', '050-888-1585', '2172@mechero.com', 'Electrical Systems Specialist', '2020-04-26', 172);
INSERT INTO public.employee VALUES (3172, 'Kemal', 'Akça', '095-956-3954', '3172@mechero.com', 'Maintenance Advisor', '2021-05-17', 172);
INSERT INTO public.employee VALUES (1173, 'Nur', 'Karataş', '028-777-1136', '1173@mechero.com', 'Technician', '2020-06-27', 173);
INSERT INTO public.employee VALUES (2173, 'Sümeyra', 'Orhan', '053-310-6764', '2173@mechero.com', 'Electrical Systems Specialist', '2020-12-14', 173);
INSERT INTO public.employee VALUES (3173, 'Canberk', 'Çiftçi', '010-731-8714', '3173@mechero.com', 'Maintenance Advisor', '2021-05-28', 173);
INSERT INTO public.employee VALUES (1174, 'Ayşe', 'Gümüş', '075-462-7914', '1174@mechero.com', 'Technician', '2020-07-15', 174);
INSERT INTO public.employee VALUES (2174, 'Ataberk', 'Orhan', '047-172-9426', '2174@mechero.com', 'Electrical Systems Specialist', '2021-05-26', 174);
INSERT INTO public.employee VALUES (3174, 'Dilek', 'Akgün', '052-568-4287', '3174@mechero.com', 'Maintenance Advisor', '2020-07-26', 174);
INSERT INTO public.employee VALUES (1175, 'Nursel', 'Koç', '047-556-1645', '1175@mechero.com', 'Technician', '2021-08-13', 175);
INSERT INTO public.employee VALUES (2175, 'Olcay', 'Ak', '071-184-1316', '2175@mechero.com', 'Electrical Systems Specialist', '2020-02-10', 175);
INSERT INTO public.employee VALUES (3175, 'Serhat', 'Yaman', '091-113-5754', '3175@mechero.com', 'Maintenance Advisor', '2020-02-04', 175);
INSERT INTO public.employee VALUES (1176, 'Sümeyra', 'Göktaş', '056-226-7131', '1176@mechero.com', 'Technician', '2020-11-01', 176);
INSERT INTO public.employee VALUES (2176, 'Semra', 'Akın', '004-542-8564', '2176@mechero.com', 'Electrical Systems Specialist', '2021-08-13', 176);
INSERT INTO public.employee VALUES (3176, 'Nazli', 'Yaman', '016-186-7351', '3176@mechero.com', 'Maintenance Advisor', '2021-09-06', 176);
INSERT INTO public.employee VALUES (1177, 'Şeni̇z', 'Akgün', '072-747-5561', '1177@mechero.com', 'Technician', '2021-03-13', 177);
INSERT INTO public.employee VALUES (2177, 'Eren', 'Acar', '073-320-5747', '2177@mechero.com', 'Electrical Systems Specialist', '2021-11-10', 177);
INSERT INTO public.employee VALUES (3177, 'Nazi̇re', 'Ergün', '025-013-4566', '3177@mechero.com', 'Maintenance Advisor', '2020-06-28', 177);
INSERT INTO public.employee VALUES (1178, 'Ataman', 'Tuna', '056-750-2473', '1178@mechero.com', 'Technician', '2020-10-29', 178);
INSERT INTO public.employee VALUES (2178, 'Buket', 'Akyol', '091-026-1564', '2178@mechero.com', 'Electrical Systems Specialist', '2020-12-09', 178);
INSERT INTO public.employee VALUES (3178, 'Gürsel', 'Şener', '034-356-4007', '3178@mechero.com', 'Maintenance Advisor', '2020-10-05', 178);
INSERT INTO public.employee VALUES (1179, 'Berki̇n', 'Yüce', '001-728-3106', '1179@mechero.com', 'Technician', '2021-08-12', 179);
INSERT INTO public.employee VALUES (2179, 'Nurten', 'Ay', '099-177-9998', '2179@mechero.com', 'Electrical Systems Specialist', '2020-12-10', 179);
INSERT INTO public.employee VALUES (3179, 'Alpteki̇n', 'Eker', '031-537-2054', '3179@mechero.com', 'Maintenance Advisor', '2021-05-26', 179);
INSERT INTO public.employee VALUES (1180, 'Nuri̇', 'Özkan', '072-432-8254', '1180@mechero.com', 'Technician', '2021-08-28', 180);
INSERT INTO public.employee VALUES (2180, 'Nazi̇me', 'Gültekin', '081-212-4561', '2180@mechero.com', 'Electrical Systems Specialist', '2020-01-26', 180);
INSERT INTO public.employee VALUES (3180, 'Sevi̇nç', 'Akbulut', '097-806-8363', '3180@mechero.com', 'Maintenance Advisor', '2020-05-05', 180);
INSERT INTO public.employee VALUES (1181, 'Kemal', 'Aslan', '021-061-4435', '1181@mechero.com', 'Technician', '2021-02-16', 181);
INSERT INTO public.employee VALUES (2181, 'Ceren', 'Turgut', '019-676-6139', '2181@mechero.com', 'Electrical Systems Specialist', '2020-12-17', 181);
INSERT INTO public.employee VALUES (3181, 'Gülcan', 'Kandemir', '021-264-9083', '3181@mechero.com', 'Maintenance Advisor', '2020-04-06', 181);
INSERT INTO public.employee VALUES (1182, 'Tayfun', 'Kaya', '002-122-3017', '1182@mechero.com', 'Technician', '2020-05-30', 182);
INSERT INTO public.employee VALUES (2182, 'Lale', 'Özer', '072-226-6650', '2182@mechero.com', 'Electrical Systems Specialist', '2021-03-27', 182);
INSERT INTO public.employee VALUES (3182, 'Cansel', 'Çevik', '012-462-1453', '3182@mechero.com', 'Maintenance Advisor', '2020-10-06', 182);
INSERT INTO public.employee VALUES (1183, 'Ebru', 'Türkmen', '023-282-3495', '1183@mechero.com', 'Technician', '2020-06-22', 183);
INSERT INTO public.employee VALUES (2183, 'Enes', 'Demirbaş', '063-047-0346', '2183@mechero.com', 'Electrical Systems Specialist', '2020-11-24', 183);
INSERT INTO public.employee VALUES (3183, 'Nureddi̇n', 'Savaş', '037-828-1963', '3183@mechero.com', 'Maintenance Advisor', '2020-07-30', 183);
INSERT INTO public.employee VALUES (1184, 'Meli̇sa', 'Dursun', '031-627-6424', '1184@mechero.com', 'Technician', '2021-05-13', 184);
INSERT INTO public.employee VALUES (2184, 'Berke', 'Aydoğdu', '099-365-8340', '2184@mechero.com', 'Electrical Systems Specialist', '2021-09-26', 184);
INSERT INTO public.employee VALUES (3184, 'Gül', 'Gültekin', '087-284-1481', '3184@mechero.com', 'Maintenance Advisor', '2021-11-06', 184);
INSERT INTO public.employee VALUES (1185, 'Cemal', 'Kaya', '091-886-2557', '1185@mechero.com', 'Technician', '2021-05-11', 185);
INSERT INTO public.employee VALUES (2185, 'Nuriye', 'Öner', '055-583-6050', '2185@mechero.com', 'Electrical Systems Specialist', '2021-02-02', 185);
INSERT INTO public.employee VALUES (3185, 'Beyza', 'Arıkan', '088-965-4945', '3185@mechero.com', 'Maintenance Advisor', '2020-02-18', 185);
INSERT INTO public.employee VALUES (1186, 'Sevi̇', 'Adıgüzel', '070-843-3180', '1186@mechero.com', 'Technician', '2021-12-07', 186);
INSERT INTO public.employee VALUES (2186, 'Nurten', 'Demirbaş', '071-264-5963', '2186@mechero.com', 'Electrical Systems Specialist', '2020-02-25', 186);
INSERT INTO public.employee VALUES (3186, 'Buket', 'Yalçın', '080-898-7000', '3186@mechero.com', 'Maintenance Advisor', '2020-02-22', 186);
INSERT INTO public.employee VALUES (1187, 'İsmai̇L', 'Gümüş', '015-235-6285', '1187@mechero.com', 'Technician', '2020-01-15', 187);
INSERT INTO public.employee VALUES (2187, 'Atabey', 'Türk', '063-591-6122', '2187@mechero.com', 'Electrical Systems Specialist', '2020-08-07', 187);
INSERT INTO public.employee VALUES (3187, 'Berker', 'Sezgin', '063-476-2826', '3187@mechero.com', 'Maintenance Advisor', '2020-12-22', 187);
INSERT INTO public.employee VALUES (1188, 'Atabey', 'Çiçek', '053-614-7748', '1188@mechero.com', 'Technician', '2021-10-25', 188);
INSERT INTO public.employee VALUES (2188, 'Gülsüm', 'Avcı', '099-933-6795', '2188@mechero.com', 'Electrical Systems Specialist', '2020-03-02', 188);
INSERT INTO public.employee VALUES (3188, 'Suzan', 'Efe', '044-688-4360', '3188@mechero.com', 'Maintenance Advisor', '2021-03-24', 188);
INSERT INTO public.employee VALUES (1189, 'Poyraz', 'Dursun', '061-731-8661', '1189@mechero.com', 'Technician', '2021-12-01', 189);
INSERT INTO public.employee VALUES (2189, 'Melek', 'Doğru', '003-843-6767', '2189@mechero.com', 'Electrical Systems Specialist', '2021-05-17', 189);
INSERT INTO public.employee VALUES (3189, 'Atalay', 'Yazici', '067-277-8496', '3189@mechero.com', 'Maintenance Advisor', '2020-07-11', 189);
INSERT INTO public.employee VALUES (1190, 'Ali̇can', 'Altın', '043-943-7346', '1190@mechero.com', 'Technician', '2021-04-09', 190);
INSERT INTO public.employee VALUES (2190, 'Şerife', 'Çevik', '066-201-2311', '2190@mechero.com', 'Electrical Systems Specialist', '2021-05-16', 190);
INSERT INTO public.employee VALUES (3190, 'Çiçek', 'Uğur', '072-898-2410', '3190@mechero.com', 'Maintenance Advisor', '2021-01-17', 190);
INSERT INTO public.employee VALUES (1191, 'Ebru', 'Bektaş', '034-118-9782', '1191@mechero.com', 'Technician', '2021-06-15', 191);
INSERT INTO public.employee VALUES (2191, 'Sevim', 'Uğurlu', '064-287-8289', '2191@mechero.com', 'Electrical Systems Specialist', '2020-05-13', 191);
INSERT INTO public.employee VALUES (3191, 'Alphan', 'Taşdemir', '031-382-4519', '3191@mechero.com', 'Maintenance Advisor', '2021-03-24', 191);
INSERT INTO public.employee VALUES (1192, 'Büşra', 'Güçlü', '067-795-4040', '1192@mechero.com', 'Technician', '2021-11-24', 192);
INSERT INTO public.employee VALUES (2192, 'Suna', 'Kaplan', '023-443-6374', '2192@mechero.com', 'Electrical Systems Specialist', '2020-01-13', 192);
INSERT INTO public.employee VALUES (3192, 'Nuray', 'Oruç', '047-167-7480', '3192@mechero.com', 'Maintenance Advisor', '2020-04-29', 192);
INSERT INTO public.employee VALUES (1193, 'Gülseren', 'Sarıkaya', '054-947-6460', '1193@mechero.com', 'Technician', '2021-06-22', 193);
INSERT INTO public.employee VALUES (2193, 'Alphan', 'Özcan', '016-238-3964', '2193@mechero.com', 'Electrical Systems Specialist', '2021-08-25', 193);
INSERT INTO public.employee VALUES (3193, 'Atacan', 'Yücel', '015-462-1333', '3193@mechero.com', 'Maintenance Advisor', '2020-07-09', 193);
INSERT INTO public.employee VALUES (1194, 'Melike', 'Yeşil', '012-266-8474', '1194@mechero.com', 'Technician', '2020-12-25', 194);
INSERT INTO public.employee VALUES (2194, 'Keri̇m', 'Güngör', '045-876-7607', '2194@mechero.com', 'Electrical Systems Specialist', '2021-10-27', 194);
INSERT INTO public.employee VALUES (3194, 'Rabia', 'Oral', '014-673-5792', '3194@mechero.com', 'Maintenance Advisor', '2020-09-07', 194);
INSERT INTO public.employee VALUES (1195, 'Müge', 'Cengiz', '026-863-4550', '1195@mechero.com', 'Technician', '2021-02-14', 195);
INSERT INTO public.employee VALUES (2195, 'Berki̇n', 'Bilgin', '053-191-2424', '2195@mechero.com', 'Electrical Systems Specialist', '2021-01-02', 195);
INSERT INTO public.employee VALUES (3195, 'İhsan', 'Turan', '027-729-5467', '3195@mechero.com', 'Maintenance Advisor', '2020-08-03', 195);
INSERT INTO public.employee VALUES (1196, 'Güllü', 'Demircan', '043-493-7023', '1196@mechero.com', 'Technician', '2020-01-30', 196);
INSERT INTO public.employee VALUES (2196, 'İlknur', 'Öz', '017-660-6798', '2196@mechero.com', 'Electrical Systems Specialist', '2020-08-23', 196);
INSERT INTO public.employee VALUES (3196, 'Hanife', 'Gümüş', '020-424-5537', '3196@mechero.com', 'Maintenance Advisor', '2021-02-25', 196);
INSERT INTO public.employee VALUES (1197, 'Ömer', 'Duran', '002-085-7837', '1197@mechero.com', 'Technician', '2020-10-20', 197);
INSERT INTO public.employee VALUES (2197, 'Güler', 'Uzun', '050-299-7437', '2197@mechero.com', 'Electrical Systems Specialist', '2020-01-02', 197);
INSERT INTO public.employee VALUES (3197, 'Berker', 'Çiftçi', '028-367-5867', '3197@mechero.com', 'Maintenance Advisor', '2021-04-30', 197);
INSERT INTO public.employee VALUES (1198, 'Burak', 'Altın', '059-815-7545', '1198@mechero.com', 'Technician', '2021-07-23', 198);
INSERT INTO public.employee VALUES (2198, 'Hami̇t', 'Karakaya', '053-179-0663', '2198@mechero.com', 'Electrical Systems Specialist', '2021-05-15', 198);
INSERT INTO public.employee VALUES (3198, 'Mert', 'Yaşar', '096-842-0420', '3198@mechero.com', 'Maintenance Advisor', '2020-06-22', 198);
INSERT INTO public.employee VALUES (1199, 'Burak', 'Temel', '027-869-4227', '1199@mechero.com', 'Technician', '2020-09-09', 199);
INSERT INTO public.employee VALUES (2199, 'Caner', 'Bozkurt', '088-204-3747', '2199@mechero.com', 'Electrical Systems Specialist', '2021-10-02', 199);
INSERT INTO public.employee VALUES (3199, 'Efe', 'Kandemir', '066-840-7189', '3199@mechero.com', 'Maintenance Advisor', '2021-05-23', 199);
INSERT INTO public.employee VALUES (1200, 'Melike', 'Akgün', '054-463-8973', '1200@mechero.com', 'Technician', '2021-11-17', 200);
INSERT INTO public.employee VALUES (2200, 'İlknur', 'Ünlü', '093-928-7430', '2200@mechero.com', 'Electrical Systems Specialist', '2021-11-09', 200);
INSERT INTO public.employee VALUES (3200, 'Dilek', 'Biçer', '069-536-3316', '3200@mechero.com', 'Maintenance Advisor', '2020-08-23', 200);
INSERT INTO public.employee VALUES (1201, 'Gülcan', 'Eren', '047-793-2738', '1201@mechero.com', 'Technician', '2021-02-10', 201);
INSERT INTO public.employee VALUES (2201, 'Hülya', 'Ataş', '049-180-5654', '2201@mechero.com', 'Electrical Systems Specialist', '2020-12-31', 201);
INSERT INTO public.employee VALUES (3201, 'Gülseren', 'Koca', '038-553-6163', '3201@mechero.com', 'Maintenance Advisor', '2021-01-26', 201);
INSERT INTO public.employee VALUES (1202, 'Gülbahar', 'Çimen', '015-455-8930', '1202@mechero.com', 'Technician', '2021-07-03', 202);
INSERT INTO public.employee VALUES (2202, 'Nur', 'Çelik', '089-042-0823', '2202@mechero.com', 'Electrical Systems Specialist', '2020-02-26', 202);
INSERT INTO public.employee VALUES (3202, 'Canan', 'Çoban', '061-129-2505', '3202@mechero.com', 'Maintenance Advisor', '2021-10-22', 202);
INSERT INTO public.employee VALUES (1203, 'Ömer', 'Adıgüzel', '032-261-8835', '1203@mechero.com', 'Technician', '2020-07-13', 203);
INSERT INTO public.employee VALUES (2203, 'Ayşe', 'Topal', '007-936-8745', '2203@mechero.com', 'Electrical Systems Specialist', '2020-04-17', 203);
INSERT INTO public.employee VALUES (3203, 'Azi̇z', 'Akkaya', '089-678-1706', '3203@mechero.com', 'Maintenance Advisor', '2020-03-15', 203);
INSERT INTO public.employee VALUES (1204, 'Cansel', 'Duran', '067-728-0835', '1204@mechero.com', 'Technician', '2020-03-01', 204);
INSERT INTO public.employee VALUES (2204, 'Ayşenur', 'Avcı', '012-337-8126', '2204@mechero.com', 'Electrical Systems Specialist', '2020-11-02', 204);
INSERT INTO public.employee VALUES (3204, 'Nur', 'Yüksel', '048-152-9477', '3204@mechero.com', 'Maintenance Advisor', '2021-09-09', 204);
INSERT INTO public.employee VALUES (1205, 'Nurdan', 'Ayhan', '033-361-8677', '1205@mechero.com', 'Technician', '2021-01-12', 205);
INSERT INTO public.employee VALUES (2205, 'Cankat', 'Yıldırım', '016-025-7039', '2205@mechero.com', 'Electrical Systems Specialist', '2020-05-15', 205);
INSERT INTO public.employee VALUES (3205, 'Hatice', 'Erkan', '046-984-8678', '3205@mechero.com', 'Maintenance Advisor', '2021-03-03', 205);
INSERT INTO public.employee VALUES (1206, 'İhsan', 'Akyol', '064-952-8337', '1206@mechero.com', 'Technician', '2020-01-11', 206);
INSERT INTO public.employee VALUES (2206, 'Lale', 'Arıkan', '022-656-3140', '2206@mechero.com', 'Electrical Systems Specialist', '2021-01-29', 206);
INSERT INTO public.employee VALUES (3206, 'Hanife', 'Gün', '060-129-6205', '3206@mechero.com', 'Maintenance Advisor', '2020-09-03', 206);
INSERT INTO public.employee VALUES (1207, 'Berkay', 'Güner', '052-383-8714', '1207@mechero.com', 'Technician', '2021-07-25', 207);
INSERT INTO public.employee VALUES (2207, 'Enes', 'Altay', '042-182-0021', '2207@mechero.com', 'Electrical Systems Specialist', '2020-05-29', 207);
INSERT INTO public.employee VALUES (3207, 'Sali̇h', 'Eker', '032-475-7407', '3207@mechero.com', 'Maintenance Advisor', '2021-02-24', 207);
INSERT INTO public.employee VALUES (1208, 'Cemal', 'Akgül', '072-680-3395', '1208@mechero.com', 'Technician', '2021-07-01', 208);
INSERT INTO public.employee VALUES (2208, 'Fadime', 'Bal', '036-357-1606', '2208@mechero.com', 'Electrical Systems Specialist', '2020-09-19', 208);
INSERT INTO public.employee VALUES (3208, 'Beyza', 'Keleş', '063-313-7851', '3208@mechero.com', 'Maintenance Advisor', '2021-02-07', 208);
INSERT INTO public.employee VALUES (1209, 'Gülbahar', 'Aslan', '048-219-7523', '1209@mechero.com', 'Technician', '2020-08-19', 209);
INSERT INTO public.employee VALUES (2209, 'Elif', 'Atmaca', '025-348-5595', '2209@mechero.com', 'Electrical Systems Specialist', '2020-07-13', 209);
INSERT INTO public.employee VALUES (3209, 'Sevi̇n', 'Sağlam', '025-708-5872', '3209@mechero.com', 'Maintenance Advisor', '2021-10-06', 209);
INSERT INTO public.employee VALUES (1210, 'Nureddi̇n', 'Topçu', '042-097-6631', '1210@mechero.com', 'Technician', '2020-04-02', 210);
INSERT INTO public.employee VALUES (2210, 'Alpay', 'Tuna', '071-300-1722', '2210@mechero.com', 'Electrical Systems Specialist', '2020-03-29', 210);
INSERT INTO public.employee VALUES (3210, 'Atalay', 'Taşçi', '074-811-5576', '3210@mechero.com', 'Maintenance Advisor', '2021-07-25', 210);
INSERT INTO public.employee VALUES (1211, 'Mustafa', 'Demirel', '044-751-6939', '1211@mechero.com', 'Technician', '2021-01-20', 211);
INSERT INTO public.employee VALUES (2211, 'Eda', 'Eren', '073-183-3125', '2211@mechero.com', 'Electrical Systems Specialist', '2020-03-29', 211);
INSERT INTO public.employee VALUES (3211, 'Nuray', 'Durmaz', '011-554-2871', '3211@mechero.com', 'Maintenance Advisor', '2020-12-07', 211);
INSERT INTO public.employee VALUES (1212, 'Dilek', 'Bulut', '044-747-6034', '1212@mechero.com', 'Technician', '2021-04-20', 212);
INSERT INTO public.employee VALUES (2212, 'Gülay', 'Orhan', '019-481-8714', '2212@mechero.com', 'Electrical Systems Specialist', '2020-05-06', 212);
INSERT INTO public.employee VALUES (3212, 'Fadime', 'Göktaş', '023-357-7488', '3212@mechero.com', 'Maintenance Advisor', '2021-11-16', 212);
INSERT INTO public.employee VALUES (1213, 'Mert', 'Eren', '016-732-8417', '1213@mechero.com', 'Technician', '2021-09-04', 213);
INSERT INTO public.employee VALUES (2213, 'Nazmi̇ye', 'Boz', '071-755-6552', '2213@mechero.com', 'Electrical Systems Specialist', '2020-10-04', 213);
INSERT INTO public.employee VALUES (3213, 'Serhat', 'Bakır', '051-587-66509', '3213@mechero.com', 'Maintenance Advisor', '2020-12-06', 213);
INSERT INTO public.employee VALUES (1214, 'Ümmügülsüm', 'Uzun', '086-517-7966', '1214@mechero.com', 'Technician', '2021-11-22', 214);
INSERT INTO public.employee VALUES (2214, 'Mustafa', 'Ayaz', '061-093-6517', '2214@mechero.com', 'Electrical Systems Specialist', '2021-06-15', 214);
INSERT INTO public.employee VALUES (3214, 'Ebru', 'Polat', '072-513-3165', '3214@mechero.com', 'Maintenance Advisor', '2020-04-28', 214);
INSERT INTO public.employee VALUES (1215, 'Emine', 'Akay', '064-018-3715', '1215@mechero.com', 'Technician', '2020-08-30', 215);
INSERT INTO public.employee VALUES (2215, 'Emi̇n', 'Karakuş', '052-423-2135', '2215@mechero.com', 'Electrical Systems Specialist', '2020-05-22', 215);
INSERT INTO public.employee VALUES (3215, 'Ceren', 'Tekin', '063-413-5497', '3215@mechero.com', 'Maintenance Advisor', '2020-02-23', 215);
INSERT INTO public.employee VALUES (1216, 'Ali̇m', 'Günay', '042-845-5733', '1216@mechero.com', 'Technician', '2021-12-21', 216);
INSERT INTO public.employee VALUES (2216, 'Nazi̇me', 'Aras', '077-045-1771', '2216@mechero.com', 'Electrical Systems Specialist', '2021-08-29', 216);
INSERT INTO public.employee VALUES (3216, 'Cemi̇l', 'Taşçi', '033-122-5493', '3216@mechero.com', 'Maintenance Advisor', '2020-03-03', 216);
INSERT INTO public.employee VALUES (1217, 'Gülcan', 'Durmuş', '022-833-8434', '1217@mechero.com', 'Technician', '2020-03-11', 217);
INSERT INTO public.employee VALUES (2217, 'Olcay', 'Aydoğan', '080-405-8675', '2217@mechero.com', 'Electrical Systems Specialist', '2021-08-07', 217);
INSERT INTO public.employee VALUES (3217, 'Lale', 'Çetin', '054-402-8265', '3217@mechero.com', 'Maintenance Advisor', '2021-03-03', 217);
INSERT INTO public.employee VALUES (1218, 'Zeynep', 'Koç', '061-731-7855', '1218@mechero.com', 'Technician', '2021-04-29', 218);
INSERT INTO public.employee VALUES (2218, 'Mehmet', 'Akça', '040-581-4996', '2218@mechero.com', 'Electrical Systems Specialist', '2020-07-26', 218);
INSERT INTO public.employee VALUES (3218, 'İsmai̇l', 'Mert', '098-652-0267', '3218@mechero.com', 'Maintenance Advisor', '2021-01-24', 218);
INSERT INTO public.employee VALUES (1219, 'Yasemin', 'Durmaz', '098-330-4495', '1219@mechero.com', 'Technician', '2021-07-09', 219);
INSERT INTO public.employee VALUES (2219, 'Alptuğ', 'Başaran', '074-771-3666', '2219@mechero.com', 'Electrical Systems Specialist', '2021-04-06', 219);
INSERT INTO public.employee VALUES (3219, 'Alperen', 'Ceylan', '065-625-5634', '3219@mechero.com', 'Maintenance Advisor', '2021-02-24', 219);
INSERT INTO public.employee VALUES (1220, 'Dilek', 'Akdeniz', '056-238-3248', '1220@mechero.com', 'Technician', '2020-11-13', 220);
INSERT INTO public.employee VALUES (2220, 'Atay', 'Ergün', '024-507-1756', '2220@mechero.com', 'Electrical Systems Specialist', '2021-05-10', 220);
INSERT INTO public.employee VALUES (3220, 'Enes', 'Dinç', '044-643-0616', '3220@mechero.com', 'Maintenance Advisor', '2021-09-27', 220);
INSERT INTO public.employee VALUES (1221, 'Aynur', 'İlhan', '046-188-3242', '1221@mechero.com', 'Technician', '2020-12-09', 221);
INSERT INTO public.employee VALUES (2221, 'Nurgül', 'Demirel', '053-037-8132', '2221@mechero.com', 'Electrical Systems Specialist', '2020-12-10', 221);
INSERT INTO public.employee VALUES (3221, 'Şennur', 'Sönmez', '056-454-3482', '3221@mechero.com', 'Maintenance Advisor', '2020-05-29', 221);
INSERT INTO public.employee VALUES (1222, 'Ayşe', 'Kalkan', '038-114-6395', '1222@mechero.com', 'Technician', '2021-12-01', 222);
INSERT INTO public.employee VALUES (2222, 'Manolya', 'Karaman', '044-178-5210', '2222@mechero.com', 'Electrical Systems Specialist', '2020-03-23', 222);
INSERT INTO public.employee VALUES (3222, 'Defne', 'Özbek', '093-361-8428', '3222@mechero.com', 'Maintenance Advisor', '2021-04-28', 222);
INSERT INTO public.employee VALUES (1223, 'Murat', 'Uyar', '010-656-1343', '1223@mechero.com', 'Technician', '2021-02-22', 223);
INSERT INTO public.employee VALUES (2223, 'Atacan', 'Doğru', '083-547-2598', '2223@mechero.com', 'Electrical Systems Specialist', '2020-02-02', 223);
INSERT INTO public.employee VALUES (3223, 'Kardelen', 'Akar', '016-414-2773', '3223@mechero.com', 'Maintenance Advisor', '2021-05-03', 223);
INSERT INTO public.employee VALUES (1224, 'Nazar', 'Şentürk', '043-761-5388', '1224@mechero.com', 'Technician', '2021-06-04', 224);
INSERT INTO public.employee VALUES (2224, 'Alpay', 'Ünsal', '094-115-3460', '2224@mechero.com', 'Electrical Systems Specialist', '2021-12-21', 224);
INSERT INTO public.employee VALUES (3224, 'Berke', 'Demir', '033-486-2667', '3224@mechero.com', 'Maintenance Advisor', '2020-05-20', 224);
INSERT INTO public.employee VALUES (1225, 'Berker', 'Duran', '023-821-9778', '1225@mechero.com', 'Technician', '2020-01-09', 225);
INSERT INTO public.employee VALUES (2225, 'Atahan', 'Ölmez', '026-556-4864', '2225@mechero.com', 'Electrical Systems Specialist', '2020-08-23', 225);
INSERT INTO public.employee VALUES (3225, 'Berkehan', 'Uslu', '027-194-5776', '3225@mechero.com', 'Maintenance Advisor', '2021-05-27', 225);
INSERT INTO public.employee VALUES (1226, 'Nuray', 'Akın', '050-527-5519', '1226@mechero.com', 'Technician', '2021-07-06', 226);
INSERT INTO public.employee VALUES (2226, 'Elmas', 'Çakmak', '042-795-7788', '2226@mechero.com', 'Electrical Systems Specialist', '2020-08-08', 226);
INSERT INTO public.employee VALUES (3226, 'Kemal', 'Karakaş', '037-700-6451', '3226@mechero.com', 'Maintenance Advisor', '2021-04-06', 226);
INSERT INTO public.employee VALUES (1227, 'Hasan', 'Güney', '071-817-4246', '1227@mechero.com', 'Technician', '2021-03-28', 227);
INSERT INTO public.employee VALUES (2227, 'Mehmet', 'Kuru', '038-804-1937', '2227@mechero.com', 'Electrical Systems Specialist', '2020-09-03', 227);
INSERT INTO public.employee VALUES (3227, 'İbrahi̇m', 'Tuna', '036-141-7705', '3227@mechero.com', 'Maintenance Advisor', '2020-12-01', 227);
INSERT INTO public.employee VALUES (1228, 'Fadime', 'Akay', '073-747-4739', '1228@mechero.com', 'Technician', '2021-06-02', 228);
INSERT INTO public.employee VALUES (2228, 'Leyla', 'Kaçar', '005-568-7774', '2228@mechero.com', 'Electrical Systems Specialist', '2021-01-02', 228);
INSERT INTO public.employee VALUES (3228, 'İlknur', 'Uğur', '064-245-1144', '3228@mechero.com', 'Maintenance Advisor', '2021-01-31', 228);
INSERT INTO public.employee VALUES (1229, 'Nurten', 'Çelik', '086-828-0842', '1229@mechero.com', 'Technician', '2020-06-13', 229);
INSERT INTO public.employee VALUES (2229, 'Sudenur', 'Temel', '011-579-5848', '2229@mechero.com', 'Electrical Systems Specialist', '2021-09-20', 229);
INSERT INTO public.employee VALUES (3229, 'Berker', 'Turan', '018-894-1713', '3229@mechero.com', 'Maintenance Advisor', '2021-10-20', 229);
INSERT INTO public.employee VALUES (1230, 'Nazi̇me', 'Koç', '089-333-7339', '1230@mechero.com', 'Technician', '2021-04-22', 230);
INSERT INTO public.employee VALUES (2230, 'Esra', 'Tan', '005-760-5836', '2230@mechero.com', 'Electrical Systems Specialist', '2020-03-18', 230);
INSERT INTO public.employee VALUES (3230, 'İsmai̇L', 'Ayaz', '065-782-1889', '3230@mechero.com', 'Maintenance Advisor', '2020-06-17', 230);
INSERT INTO public.employee VALUES (1231, 'Zehra', 'Erkan', '048-758-6964', '1231@mechero.com', 'Technician', '2020-06-10', 231);
INSERT INTO public.employee VALUES (2231, 'Berkcan', 'Efe', '013-561-1621', '2231@mechero.com', 'Electrical Systems Specialist', '2020-12-31', 231);
INSERT INTO public.employee VALUES (3231, 'Şennur', 'Yücel', '032-763-2372', '3231@mechero.com', 'Maintenance Advisor', '2020-12-06', 231);
INSERT INTO public.employee VALUES (1232, 'Ahmet', 'Eker', '000-576-6482', '1232@mechero.com', 'Technician', '2021-06-06', 232);
INSERT INTO public.employee VALUES (2232, 'Mert', 'Ay', '037-928-4611', '2232@mechero.com', 'Electrical Systems Specialist', '2021-03-03', 232);
INSERT INTO public.employee VALUES (3232, 'Hülya', 'Güler', '078-578-6679', '3232@mechero.com', 'Maintenance Advisor', '2020-11-29', 232);
INSERT INTO public.employee VALUES (1233, 'Gülseren', 'Gürsoy', '022-602-3143', '1233@mechero.com', 'Technician', '2021-10-21', 233);
INSERT INTO public.employee VALUES (2233, 'Ayşenur', 'Akay', '058-973-3084', '2233@mechero.com', 'Electrical Systems Specialist', '2021-02-10', 233);
INSERT INTO public.employee VALUES (3233, 'Nuretti̇n', 'Kılınç', '065-407-4735', '3233@mechero.com', 'Maintenance Advisor', '2021-07-31', 233);
INSERT INTO public.employee VALUES (1234, 'Songül', 'Özer', '071-442-4587', '1234@mechero.com', 'Technician', '2020-06-15', 234);
INSERT INTO public.employee VALUES (2234, 'Emine', 'Tuna', '004-840-4978', '2234@mechero.com', 'Electrical Systems Specialist', '2020-01-11', 234);
INSERT INTO public.employee VALUES (3234, 'Ali̇şan', 'Çakar', '035-948-0749', '3234@mechero.com', 'Maintenance Advisor', '2020-05-13', 234);
INSERT INTO public.employee VALUES (1235, 'Güllü', 'Turan', '031-702-8348', '1235@mechero.com', 'Technician', '2020-01-15', 235);
INSERT INTO public.employee VALUES (2235, 'Şennur', 'Keleş', '011-153-9178', '2235@mechero.com', 'Electrical Systems Specialist', '2021-03-31', 235);
INSERT INTO public.employee VALUES (3235, 'Sonat', 'Ergün', '059-115-7461', '3235@mechero.com', 'Maintenance Advisor', '2020-08-31', 235);
INSERT INTO public.employee VALUES (1236, 'Müge', 'Keleş', '057-414-1877', '1236@mechero.com', 'Technician', '2020-03-30', 236);
INSERT INTO public.employee VALUES (2236, 'Beyza', 'Baran', '037-208-2427', '2236@mechero.com', 'Electrical Systems Specialist', '2020-10-18', 236);
INSERT INTO public.employee VALUES (3236, 'Buket', 'Özkan', '067-224-4619', '3236@mechero.com', 'Maintenance Advisor', '2021-08-02', 236);
INSERT INTO public.employee VALUES (1237, 'Mert', 'Zengin', '053-581-8264', '1237@mechero.com', 'Technician', '2020-12-31', 237);
INSERT INTO public.employee VALUES (2237, 'Nuray', 'Türk', '054-077-6428', '2237@mechero.com', 'Electrical Systems Specialist', '2021-03-14', 237);
INSERT INTO public.employee VALUES (3237, 'Nazar', 'Çiçek', '075-575-4709', '3237@mechero.com', 'Maintenance Advisor', '2020-11-05', 237);
INSERT INTO public.employee VALUES (1238, 'Beyza', 'Tekin', '052-327-3447', '1238@mechero.com', 'Technician', '2021-08-02', 238);
INSERT INTO public.employee VALUES (2238, 'Berkan', 'Arslan', '086-325-3315', '2238@mechero.com', 'Electrical Systems Specialist', '2021-04-24', 238);
INSERT INTO public.employee VALUES (3238, 'Fi̇li̇z', 'Karakuş', '046-321-5432', '3238@mechero.com', 'Maintenance Advisor', '2021-05-15', 238);
INSERT INTO public.employee VALUES (1239, 'Meryem', 'Ceylan', '057-912-6893', '1239@mechero.com', 'Technician', '2020-09-26', 239);
INSERT INTO public.employee VALUES (2239, 'Şenel', 'Çınar', '046-764-4946', '2239@mechero.com', 'Electrical Systems Specialist', '2020-09-24', 239);
INSERT INTO public.employee VALUES (3239, 'Süleyman', 'Gültekin', '012-965-2526', '3239@mechero.com', 'Maintenance Advisor', '2021-05-24', 239);
INSERT INTO public.employee VALUES (1240, 'Berk', 'Altay', '073-370-4202', '1240@mechero.com', 'Technician', '2021-03-04', 240);
INSERT INTO public.employee VALUES (2240, 'Berk', 'Aksu', '073-751-5842', '2240@mechero.com', 'Electrical Systems Specialist', '2020-08-05', 240);
INSERT INTO public.employee VALUES (3240, 'Kemal', 'Korkmaz', '016-947-0348', '3240@mechero.com', 'Maintenance Advisor', '2021-12-28', 240);
INSERT INTO public.employee VALUES (1241, 'Elif', 'Karakoç', '095-526-6179', '1241@mechero.com', 'Technician', '2020-01-22', 241);
INSERT INTO public.employee VALUES (2241, 'Nisa', 'Şener', '011-850-7762', '2241@mechero.com', 'Electrical Systems Specialist', '2020-11-12', 241);
INSERT INTO public.employee VALUES (3241, 'Nurullah', 'Balcı', '046-533-3806', '3241@mechero.com', 'Maintenance Advisor', '2020-09-18', 241);
INSERT INTO public.employee VALUES (1242, 'Meral', 'Çoban', '045-324-2319', '1242@mechero.com', 'Technician', '2021-03-23', 242);
INSERT INTO public.employee VALUES (2242, 'Canberk', 'Çelebi', '033-712-3492', '2242@mechero.com', 'Electrical Systems Specialist', '2020-06-21', 242);
INSERT INTO public.employee VALUES (3242, 'Sevi̇m', 'Erdem', '016-368-8454', '3242@mechero.com', 'Maintenance Advisor', '2020-05-06', 242);
INSERT INTO public.employee VALUES (1243, 'Alpcan', 'İpek', '071-365-1382', '1243@mechero.com', 'Technician', '2021-10-01', 243);
INSERT INTO public.employee VALUES (2243, 'Aynur', 'Oral', '023-095-2824', '2243@mechero.com', 'Electrical Systems Specialist', '2020-05-05', 243);
INSERT INTO public.employee VALUES (3243, 'Cansel', 'Kuru', '064-251-5337', '3243@mechero.com', 'Maintenance Advisor', '2021-05-04', 243);


--
-- TOC entry 4932 (class 0 OID 16487)
-- Dependencies: 232
-- Data for Name: employee_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employee_schedule VALUES (1337, '2023-08-13', '07:00:00', '09:30:00', 1033, 1501);
INSERT INTO public.employee_schedule VALUES (1338, '2024-01-11', '07:00:00', '09:00:00', 2058, 1502);
INSERT INTO public.employee_schedule VALUES (1339, '2025-02-12', '07:00:00', '09:30:00', 2059, 1503);
INSERT INTO public.employee_schedule VALUES (1340, '2024-11-16', '07:00:00', '09:30:00', 2061, 1504);
INSERT INTO public.employee_schedule VALUES (1, '2024-10-20', '13:00:00', '15:30:00', 2076, 2);
INSERT INTO public.employee_schedule VALUES (2, '2025-08-12', '16:00:00', '18:00:00', 2174, 4);
INSERT INTO public.employee_schedule VALUES (3, '2024-08-14', '16:00:00', '18:30:00', 3194, 5);
INSERT INTO public.employee_schedule VALUES (4, '2023-08-08', '07:00:00', '09:00:00', 3066, 6);
INSERT INTO public.employee_schedule VALUES (5, '2025-08-25', '10:00:00', '12:30:00', 2067, 7);
INSERT INTO public.employee_schedule VALUES (6, '2025-09-17', '10:00:00', '12:00:00', 1207, 8);
INSERT INTO public.employee_schedule VALUES (7, '2024-07-18', '16:00:00', '18:30:00', 2033, 9);
INSERT INTO public.employee_schedule VALUES (8, '2025-09-08', '07:00:00', '09:30:00', 1003, 10);
INSERT INTO public.employee_schedule VALUES (9, '2024-01-14', '10:00:00', '12:00:00', 1158, 11);
INSERT INTO public.employee_schedule VALUES (10, '2025-01-21', '10:00:00', '12:00:00', 2036, 12);
INSERT INTO public.employee_schedule VALUES (11, '2024-07-03', '13:00:00', '15:30:00', 2024, 13);
INSERT INTO public.employee_schedule VALUES (12, '2025-04-25', '07:00:00', '09:00:00', 1185, 14);
INSERT INTO public.employee_schedule VALUES (13, '2025-11-23', '13:00:00', '15:30:00', 3079, 15);
INSERT INTO public.employee_schedule VALUES (14, '2025-06-05', '16:00:00', '18:30:00', 1030, 16);
INSERT INTO public.employee_schedule VALUES (15, '2024-02-17', '16:00:00', '18:00:00', 1201, 17);
INSERT INTO public.employee_schedule VALUES (16, '2024-10-16', '07:00:00', '09:30:00', 1238, 18);
INSERT INTO public.employee_schedule VALUES (17, '2025-11-04', '16:00:00', '18:00:00', 3229, 19);
INSERT INTO public.employee_schedule VALUES (18, '2025-06-26', '10:00:00', '12:30:00', 2080, 20);
INSERT INTO public.employee_schedule VALUES (19, '2025-06-29', '16:00:00', '18:30:00', 2094, 21);
INSERT INTO public.employee_schedule VALUES (20, '2025-12-17', '07:00:00', '09:30:00', 3216, 22);
INSERT INTO public.employee_schedule VALUES (21, '2024-03-21', '13:00:00', '15:00:00', 1143, 23);
INSERT INTO public.employee_schedule VALUES (22, '2024-08-27', '10:00:00', '12:30:00', 2051, 24);
INSERT INTO public.employee_schedule VALUES (23, '2025-11-23', '16:00:00', '18:30:00', 3096, 25);
INSERT INTO public.employee_schedule VALUES (24, '2025-05-19', '07:00:00', '09:30:00', 2206, 26);
INSERT INTO public.employee_schedule VALUES (25, '2025-07-27', '10:00:00', '12:30:00', 3021, 27);
INSERT INTO public.employee_schedule VALUES (26, '2025-11-14', '07:00:00', '09:30:00', 1153, 28);
INSERT INTO public.employee_schedule VALUES (27, '2024-09-28', '10:00:00', '12:30:00', 1225, 29);
INSERT INTO public.employee_schedule VALUES (28, '2025-05-24', '13:00:00', '15:30:00', 3136, 30);
INSERT INTO public.employee_schedule VALUES (29, '2025-01-05', '10:00:00', '12:30:00', 2185, 32);
INSERT INTO public.employee_schedule VALUES (30, '2025-10-19', '07:00:00', '09:30:00', 2197, 33);
INSERT INTO public.employee_schedule VALUES (31, '2025-10-09', '13:00:00', '15:30:00', 2092, 34);
INSERT INTO public.employee_schedule VALUES (32, '2025-04-16', '13:00:00', '15:30:00', 1111, 36);
INSERT INTO public.employee_schedule VALUES (33, '2024-09-05', '16:00:00', '18:30:00', 2127, 38);
INSERT INTO public.employee_schedule VALUES (34, '2024-08-19', '16:00:00', '18:00:00', 3052, 39);
INSERT INTO public.employee_schedule VALUES (35, '2025-03-31', '16:00:00', '18:00:00', 1082, 40);
INSERT INTO public.employee_schedule VALUES (36, '2025-08-14', '10:00:00', '12:30:00', 1085, 41);
INSERT INTO public.employee_schedule VALUES (37, '2024-12-30', '16:00:00', '18:00:00', 3190, 42);
INSERT INTO public.employee_schedule VALUES (38, '2025-07-26', '10:00:00', '12:30:00', 1156, 43);
INSERT INTO public.employee_schedule VALUES (39, '2025-10-25', '16:00:00', '18:30:00', 3134, 44);
INSERT INTO public.employee_schedule VALUES (40, '2025-05-11', '13:00:00', '15:30:00', 1102, 45);
INSERT INTO public.employee_schedule VALUES (41, '2025-06-19', '16:00:00', '18:00:00', 1082, 46);
INSERT INTO public.employee_schedule VALUES (42, '2025-07-13', '07:00:00', '09:30:00', 2117, 48);
INSERT INTO public.employee_schedule VALUES (43, '2025-12-24', '10:00:00', '12:30:00', 2062, 49);
INSERT INTO public.employee_schedule VALUES (44, '2024-12-03', '10:00:00', '12:00:00', 1126, 50);
INSERT INTO public.employee_schedule VALUES (45, '2023-08-19', '13:00:00', '15:00:00', 1078, 51);
INSERT INTO public.employee_schedule VALUES (46, '2025-02-28', '07:00:00', '09:00:00', 1132, 52);
INSERT INTO public.employee_schedule VALUES (47, '2025-08-11', '07:00:00', '09:00:00', 2051, 54);
INSERT INTO public.employee_schedule VALUES (48, '2025-11-13', '07:00:00', '09:30:00', 3066, 55);
INSERT INTO public.employee_schedule VALUES (49, '2025-02-06', '13:00:00', '15:30:00', 3208, 56);
INSERT INTO public.employee_schedule VALUES (50, '2024-05-08', '16:00:00', '18:00:00', 2030, 59);
INSERT INTO public.employee_schedule VALUES (51, '2025-11-18', '16:00:00', '18:00:00', 3189, 60);
INSERT INTO public.employee_schedule VALUES (52, '2024-10-17', '10:00:00', '12:30:00', 3173, 61);
INSERT INTO public.employee_schedule VALUES (53, '2025-04-23', '07:00:00', '09:30:00', 2206, 62);
INSERT INTO public.employee_schedule VALUES (54, '2025-07-14', '13:00:00', '15:00:00', 2001, 63);
INSERT INTO public.employee_schedule VALUES (55, '2025-01-22', '16:00:00', '18:30:00', 2169, 64);
INSERT INTO public.employee_schedule VALUES (56, '2025-02-21', '13:00:00', '15:00:00', 2119, 66);
INSERT INTO public.employee_schedule VALUES (57, '2025-02-03', '13:00:00', '15:00:00', 2239, 67);
INSERT INTO public.employee_schedule VALUES (58, '2025-06-22', '10:00:00', '12:30:00', 1235, 68);
INSERT INTO public.employee_schedule VALUES (59, '2024-07-12', '07:00:00', '09:30:00', 2013, 69);
INSERT INTO public.employee_schedule VALUES (60, '2025-03-06', '10:00:00', '12:00:00', 1011, 70);
INSERT INTO public.employee_schedule VALUES (61, '2024-04-24', '10:00:00', '12:00:00', 1236, 71);
INSERT INTO public.employee_schedule VALUES (62, '2025-06-14', '07:00:00', '09:00:00', 1031, 72);
INSERT INTO public.employee_schedule VALUES (63, '2025-08-19', '10:00:00', '12:00:00', 1011, 73);
INSERT INTO public.employee_schedule VALUES (64, '2024-09-12', '10:00:00', '12:00:00', 2004, 74);
INSERT INTO public.employee_schedule VALUES (65, '2024-06-23', '10:00:00', '12:30:00', 2011, 78);
INSERT INTO public.employee_schedule VALUES (66, '2024-09-22', '10:00:00', '12:00:00', 2017, 79);
INSERT INTO public.employee_schedule VALUES (67, '2025-11-18', '13:00:00', '15:30:00', 2063, 80);
INSERT INTO public.employee_schedule VALUES (68, '2025-07-23', '07:00:00', '09:30:00', 1116, 81);
INSERT INTO public.employee_schedule VALUES (69, '2024-07-20', '07:00:00', '09:00:00', 1187, 82);
INSERT INTO public.employee_schedule VALUES (70, '2026-01-01', '13:00:00', '15:30:00', 1162, 83);
INSERT INTO public.employee_schedule VALUES (71, '2025-01-22', '10:00:00', '12:00:00', 1164, 84);
INSERT INTO public.employee_schedule VALUES (72, '2023-10-10', '13:00:00', '15:00:00', 3007, 85);
INSERT INTO public.employee_schedule VALUES (73, '2025-09-17', '16:00:00', '18:00:00', 2079, 86);
INSERT INTO public.employee_schedule VALUES (74, '2025-03-14', '10:00:00', '12:30:00', 2212, 87);
INSERT INTO public.employee_schedule VALUES (75, '2025-08-05', '16:00:00', '18:00:00', 1104, 88);
INSERT INTO public.employee_schedule VALUES (76, '2025-12-03', '13:00:00', '15:00:00', 1131, 89);
INSERT INTO public.employee_schedule VALUES (77, '2023-12-24', '10:00:00', '12:00:00', 1237, 90);
INSERT INTO public.employee_schedule VALUES (78, '2025-08-30', '07:00:00', '09:00:00', 1202, 91);
INSERT INTO public.employee_schedule VALUES (79, '2025-05-09', '07:00:00', '09:30:00', 1184, 92);
INSERT INTO public.employee_schedule VALUES (80, '2025-11-05', '13:00:00', '15:30:00', 3039, 93);
INSERT INTO public.employee_schedule VALUES (81, '2024-12-29', '13:00:00', '15:30:00', 1209, 94);
INSERT INTO public.employee_schedule VALUES (82, '2025-08-06', '10:00:00', '12:00:00', 2123, 95);
INSERT INTO public.employee_schedule VALUES (83, '2025-03-30', '13:00:00', '15:30:00', 3208, 96);
INSERT INTO public.employee_schedule VALUES (84, '2025-04-08', '16:00:00', '18:30:00', 1239, 97);
INSERT INTO public.employee_schedule VALUES (85, '2025-09-29', '10:00:00', '12:30:00', 2222, 98);
INSERT INTO public.employee_schedule VALUES (86, '2024-10-29', '07:00:00', '09:00:00', 3203, 99);
INSERT INTO public.employee_schedule VALUES (87, '2025-09-20', '13:00:00', '15:00:00', 2201, 100);
INSERT INTO public.employee_schedule VALUES (88, '2024-11-07', '13:00:00', '15:30:00', 3157, 101);
INSERT INTO public.employee_schedule VALUES (89, '2025-09-29', '07:00:00', '09:00:00', 3100, 103);
INSERT INTO public.employee_schedule VALUES (90, '2024-12-02', '07:00:00', '09:00:00', 3152, 104);
INSERT INTO public.employee_schedule VALUES (91, '2025-11-20', '16:00:00', '18:00:00', 2234, 105);
INSERT INTO public.employee_schedule VALUES (92, '2025-10-28', '13:00:00', '15:00:00', 3188, 106);
INSERT INTO public.employee_schedule VALUES (93, '2024-12-21', '13:00:00', '15:30:00', 2173, 107);
INSERT INTO public.employee_schedule VALUES (94, '2023-04-15', '16:00:00', '18:00:00', 1009, 108);
INSERT INTO public.employee_schedule VALUES (95, '2025-07-22', '16:00:00', '18:30:00', 2156, 109);
INSERT INTO public.employee_schedule VALUES (96, '2024-12-05', '07:00:00', '09:00:00', 1240, 110);
INSERT INTO public.employee_schedule VALUES (97, '2023-09-21', '10:00:00', '12:30:00', 1028, 111);
INSERT INTO public.employee_schedule VALUES (98, '2025-11-13', '16:00:00', '18:00:00', 2008, 112);
INSERT INTO public.employee_schedule VALUES (99, '2025-11-25', '13:00:00', '15:30:00', 3202, 113);
INSERT INTO public.employee_schedule VALUES (100, '2024-11-26', '07:00:00', '09:00:00', 2190, 114);
INSERT INTO public.employee_schedule VALUES (101, '2025-05-06', '13:00:00', '15:00:00', 1159, 115);
INSERT INTO public.employee_schedule VALUES (102, '2025-09-21', '10:00:00', '12:00:00', 2113, 116);
INSERT INTO public.employee_schedule VALUES (103, '2025-09-23', '16:00:00', '18:00:00', 3057, 117);
INSERT INTO public.employee_schedule VALUES (104, '2025-06-05', '07:00:00', '09:30:00', 1152, 118);
INSERT INTO public.employee_schedule VALUES (105, '2025-11-26', '07:00:00', '09:00:00', 1234, 119);
INSERT INTO public.employee_schedule VALUES (106, '2025-04-30', '10:00:00', '12:30:00', 1104, 120);
INSERT INTO public.employee_schedule VALUES (107, '2025-03-18', '10:00:00', '12:30:00', 2234, 121);
INSERT INTO public.employee_schedule VALUES (108, '2025-09-12', '07:00:00', '09:30:00', 1208, 122);
INSERT INTO public.employee_schedule VALUES (109, '2024-12-23', '16:00:00', '18:00:00', 1019, 123);
INSERT INTO public.employee_schedule VALUES (110, '2025-08-08', '16:00:00', '18:30:00', 1211, 124);
INSERT INTO public.employee_schedule VALUES (111, '2025-07-31', '13:00:00', '15:00:00', 3123, 125);
INSERT INTO public.employee_schedule VALUES (112, '2025-12-04', '16:00:00', '18:30:00', 1159, 126);
INSERT INTO public.employee_schedule VALUES (113, '2024-12-22', '10:00:00', '12:00:00', 1188, 127);
INSERT INTO public.employee_schedule VALUES (114, '2025-08-04', '10:00:00', '12:00:00', 1199, 128);
INSERT INTO public.employee_schedule VALUES (115, '2025-11-12', '16:00:00', '18:30:00', 2160, 129);
INSERT INTO public.employee_schedule VALUES (116, '2024-10-20', '07:00:00', '09:30:00', 2141, 130);
INSERT INTO public.employee_schedule VALUES (117, '2025-09-03', '13:00:00', '15:00:00', 2074, 131);
INSERT INTO public.employee_schedule VALUES (118, '2024-05-15', '10:00:00', '12:00:00', 2188, 132);
INSERT INTO public.employee_schedule VALUES (119, '2024-12-15', '16:00:00', '18:30:00', 2128, 133);
INSERT INTO public.employee_schedule VALUES (120, '2025-02-11', '16:00:00', '18:00:00', 3205, 135);
INSERT INTO public.employee_schedule VALUES (121, '2024-09-03', '13:00:00', '15:30:00', 2127, 136);
INSERT INTO public.employee_schedule VALUES (122, '2024-10-05', '13:00:00', '15:30:00', 1110, 137);
INSERT INTO public.employee_schedule VALUES (123, '2025-09-14', '13:00:00', '15:00:00', 3061, 138);
INSERT INTO public.employee_schedule VALUES (124, '2025-07-05', '07:00:00', '09:30:00', 1123, 139);
INSERT INTO public.employee_schedule VALUES (125, '2023-12-10', '16:00:00', '18:30:00', 2222, 140);
INSERT INTO public.employee_schedule VALUES (126, '2025-01-20', '10:00:00', '12:30:00', 3213, 142);
INSERT INTO public.employee_schedule VALUES (127, '2025-09-14', '13:00:00', '15:00:00', 1147, 143);
INSERT INTO public.employee_schedule VALUES (128, '2025-05-27', '10:00:00', '12:00:00', 3108, 144);
INSERT INTO public.employee_schedule VALUES (129, '2024-04-21', '10:00:00', '12:00:00', 1051, 145);
INSERT INTO public.employee_schedule VALUES (130, '2024-05-13', '10:00:00', '12:30:00', 3099, 148);
INSERT INTO public.employee_schedule VALUES (131, '2025-05-31', '07:00:00', '09:00:00', 3115, 149);
INSERT INTO public.employee_schedule VALUES (132, '2025-08-02', '07:00:00', '09:00:00', 2023, 151);
INSERT INTO public.employee_schedule VALUES (133, '2025-02-20', '16:00:00', '18:30:00', 1036, 152);
INSERT INTO public.employee_schedule VALUES (134, '2025-03-24', '16:00:00', '18:00:00', 1239, 154);
INSERT INTO public.employee_schedule VALUES (135, '2025-09-10', '16:00:00', '18:00:00', 2151, 155);
INSERT INTO public.employee_schedule VALUES (136, '2025-04-03', '10:00:00', '12:30:00', 2231, 156);
INSERT INTO public.employee_schedule VALUES (137, '2025-10-22', '10:00:00', '12:00:00', 3183, 158);
INSERT INTO public.employee_schedule VALUES (138, '2025-03-26', '10:00:00', '12:30:00', 1040, 160);
INSERT INTO public.employee_schedule VALUES (139, '2024-12-05', '16:00:00', '18:00:00', 3086, 161);
INSERT INTO public.employee_schedule VALUES (140, '2024-11-19', '10:00:00', '12:00:00', 2181, 162);
INSERT INTO public.employee_schedule VALUES (141, '2024-09-19', '07:00:00', '09:00:00', 3068, 163);
INSERT INTO public.employee_schedule VALUES (142, '2025-08-29', '13:00:00', '15:30:00', 3155, 164);
INSERT INTO public.employee_schedule VALUES (143, '2025-04-14', '10:00:00', '12:00:00', 1213, 165);
INSERT INTO public.employee_schedule VALUES (144, '2025-08-28', '10:00:00', '12:00:00', 2048, 166);
INSERT INTO public.employee_schedule VALUES (145, '2025-12-16', '10:00:00', '12:00:00', 1217, 167);
INSERT INTO public.employee_schedule VALUES (146, '2025-11-17', '13:00:00', '15:00:00', 2196, 168);
INSERT INTO public.employee_schedule VALUES (147, '2024-07-24', '16:00:00', '18:00:00', 3082, 169);
INSERT INTO public.employee_schedule VALUES (148, '2025-12-16', '10:00:00', '12:30:00', 1081, 171);
INSERT INTO public.employee_schedule VALUES (149, '2025-10-17', '10:00:00', '12:00:00', 3101, 172);
INSERT INTO public.employee_schedule VALUES (150, '2025-08-11', '07:00:00', '09:30:00', 3046, 174);
INSERT INTO public.employee_schedule VALUES (151, '2023-09-25', '07:00:00', '09:30:00', 3064, 175);
INSERT INTO public.employee_schedule VALUES (152, '2025-08-27', '07:00:00', '09:00:00', 1062, 177);
INSERT INTO public.employee_schedule VALUES (153, '2025-05-05', '07:00:00', '09:30:00', 3013, 178);
INSERT INTO public.employee_schedule VALUES (154, '2025-02-16', '16:00:00', '18:00:00', 3163, 179);
INSERT INTO public.employee_schedule VALUES (155, '2025-06-15', '13:00:00', '15:30:00', 3160, 180);
INSERT INTO public.employee_schedule VALUES (156, '2025-06-18', '13:00:00', '15:30:00', 1106, 181);
INSERT INTO public.employee_schedule VALUES (157, '2025-12-27', '13:00:00', '15:30:00', 1231, 182);
INSERT INTO public.employee_schedule VALUES (158, '2025-05-02', '16:00:00', '18:00:00', 2044, 183);
INSERT INTO public.employee_schedule VALUES (159, '2023-12-22', '07:00:00', '09:00:00', 3170, 184);
INSERT INTO public.employee_schedule VALUES (160, '2025-12-16', '10:00:00', '12:30:00', 1208, 185);
INSERT INTO public.employee_schedule VALUES (161, '2024-10-01', '13:00:00', '15:00:00', 2125, 186);
INSERT INTO public.employee_schedule VALUES (162, '2024-10-31', '16:00:00', '18:30:00', 3144, 187);
INSERT INTO public.employee_schedule VALUES (163, '2024-12-23', '07:00:00', '09:00:00', 3049, 188);
INSERT INTO public.employee_schedule VALUES (164, '2025-09-18', '13:00:00', '15:30:00', 1112, 189);
INSERT INTO public.employee_schedule VALUES (165, '2024-08-02', '07:00:00', '09:30:00', 1045, 190);
INSERT INTO public.employee_schedule VALUES (166, '2025-02-09', '13:00:00', '15:30:00', 2088, 191);
INSERT INTO public.employee_schedule VALUES (167, '2025-03-26', '13:00:00', '15:00:00', 2064, 192);
INSERT INTO public.employee_schedule VALUES (168, '2024-03-04', '10:00:00', '12:30:00', 3192, 193);
INSERT INTO public.employee_schedule VALUES (169, '2025-06-05', '10:00:00', '12:00:00', 2009, 194);
INSERT INTO public.employee_schedule VALUES (170, '2025-10-17', '16:00:00', '18:00:00', 2199, 195);
INSERT INTO public.employee_schedule VALUES (171, '2024-10-11', '07:00:00', '09:00:00', 1100, 196);
INSERT INTO public.employee_schedule VALUES (172, '2025-10-04', '13:00:00', '15:30:00', 2203, 197);
INSERT INTO public.employee_schedule VALUES (173, '2025-09-15', '16:00:00', '18:30:00', 1207, 199);
INSERT INTO public.employee_schedule VALUES (174, '2025-06-23', '10:00:00', '12:00:00', 3023, 200);
INSERT INTO public.employee_schedule VALUES (175, '2025-07-27', '10:00:00', '12:30:00', 1136, 201);
INSERT INTO public.employee_schedule VALUES (176, '2025-08-22', '13:00:00', '15:30:00', 2220, 202);
INSERT INTO public.employee_schedule VALUES (177, '2024-08-19', '07:00:00', '09:00:00', 1071, 203);
INSERT INTO public.employee_schedule VALUES (178, '2025-10-16', '13:00:00', '15:00:00', 1116, 204);
INSERT INTO public.employee_schedule VALUES (179, '2024-04-22', '13:00:00', '15:00:00', 2196, 205);
INSERT INTO public.employee_schedule VALUES (180, '2025-07-12', '16:00:00', '18:00:00', 3189, 206);
INSERT INTO public.employee_schedule VALUES (181, '2024-09-28', '16:00:00', '18:30:00', 1053, 207);
INSERT INTO public.employee_schedule VALUES (182, '2025-02-28', '16:00:00', '18:00:00', 3076, 208);
INSERT INTO public.employee_schedule VALUES (183, '2024-12-26', '07:00:00', '09:30:00', 2014, 209);
INSERT INTO public.employee_schedule VALUES (184, '2025-05-26', '13:00:00', '15:00:00', 1102, 210);
INSERT INTO public.employee_schedule VALUES (185, '2025-05-17', '13:00:00', '15:30:00', 2221, 211);
INSERT INTO public.employee_schedule VALUES (186, '2024-11-16', '10:00:00', '12:30:00', 2181, 212);
INSERT INTO public.employee_schedule VALUES (187, '2025-12-11', '13:00:00', '15:30:00', 2100, 213);
INSERT INTO public.employee_schedule VALUES (188, '2024-11-07', '07:00:00', '09:30:00', 1204, 214);
INSERT INTO public.employee_schedule VALUES (189, '2025-08-16', '10:00:00', '12:30:00', 3170, 215);
INSERT INTO public.employee_schedule VALUES (190, '2025-06-28', '16:00:00', '18:00:00', 2100, 216);
INSERT INTO public.employee_schedule VALUES (191, '2025-08-20', '16:00:00', '18:30:00', 2179, 217);
INSERT INTO public.employee_schedule VALUES (192, '2025-02-15', '13:00:00', '15:00:00', 1232, 219);
INSERT INTO public.employee_schedule VALUES (193, '2024-12-01', '16:00:00', '18:00:00', 1100, 220);
INSERT INTO public.employee_schedule VALUES (194, '2025-06-26', '07:00:00', '09:00:00', 3028, 221);
INSERT INTO public.employee_schedule VALUES (195, '2025-08-07', '16:00:00', '18:00:00', 2179, 222);
INSERT INTO public.employee_schedule VALUES (196, '2024-11-16', '07:00:00', '09:00:00', 2052, 223);
INSERT INTO public.employee_schedule VALUES (197, '2025-03-14', '10:00:00', '12:30:00', 1243, 224);
INSERT INTO public.employee_schedule VALUES (198, '2024-02-14', '07:00:00', '09:30:00', 2070, 225);
INSERT INTO public.employee_schedule VALUES (199, '2025-05-31', '16:00:00', '18:00:00', 1015, 226);
INSERT INTO public.employee_schedule VALUES (200, '2025-02-07', '10:00:00', '12:30:00', 2081, 227);
INSERT INTO public.employee_schedule VALUES (201, '2025-11-27', '16:00:00', '18:30:00', 3117, 228);
INSERT INTO public.employee_schedule VALUES (202, '2025-02-11', '07:00:00', '09:00:00', 1039, 229);
INSERT INTO public.employee_schedule VALUES (203, '2025-10-20', '16:00:00', '18:30:00', 1023, 230);
INSERT INTO public.employee_schedule VALUES (204, '2025-08-24', '07:00:00', '09:00:00', 2109, 231);
INSERT INTO public.employee_schedule VALUES (205, '2025-08-23', '10:00:00', '12:30:00', 1157, 232);
INSERT INTO public.employee_schedule VALUES (206, '2024-08-21', '07:00:00', '09:30:00', 1143, 233);
INSERT INTO public.employee_schedule VALUES (207, '2025-11-26', '07:00:00', '09:00:00', 2223, 234);
INSERT INTO public.employee_schedule VALUES (208, '2025-04-11', '13:00:00', '15:30:00', 2242, 235);
INSERT INTO public.employee_schedule VALUES (209, '2025-11-12', '16:00:00', '18:30:00', 2093, 236);
INSERT INTO public.employee_schedule VALUES (210, '2025-07-02', '10:00:00', '12:00:00', 1007, 237);
INSERT INTO public.employee_schedule VALUES (211, '2025-05-21', '10:00:00', '12:00:00', 1214, 238);
INSERT INTO public.employee_schedule VALUES (212, '2024-12-23', '13:00:00', '15:30:00', 3052, 239);
INSERT INTO public.employee_schedule VALUES (213, '2024-02-21', '13:00:00', '15:00:00', 3170, 240);
INSERT INTO public.employee_schedule VALUES (214, '2024-10-27', '13:00:00', '15:00:00', 3233, 241);
INSERT INTO public.employee_schedule VALUES (215, '2025-12-17', '10:00:00', '12:00:00', 1139, 242);
INSERT INTO public.employee_schedule VALUES (216, '2025-10-09', '13:00:00', '15:00:00', 1107, 243);
INSERT INTO public.employee_schedule VALUES (217, '2024-12-25', '16:00:00', '18:00:00', 3200, 244);
INSERT INTO public.employee_schedule VALUES (218, '2024-08-15', '13:00:00', '15:00:00', 2209, 245);
INSERT INTO public.employee_schedule VALUES (219, '2024-10-09', '10:00:00', '12:00:00', 2040, 246);
INSERT INTO public.employee_schedule VALUES (220, '2024-07-21', '10:00:00', '12:00:00', 1111, 247);
INSERT INTO public.employee_schedule VALUES (221, '2025-08-30', '10:00:00', '12:00:00', 1029, 248);
INSERT INTO public.employee_schedule VALUES (222, '2024-07-02', '07:00:00', '09:00:00', 2077, 249);
INSERT INTO public.employee_schedule VALUES (223, '2025-07-07', '13:00:00', '15:00:00', 2228, 250);
INSERT INTO public.employee_schedule VALUES (224, '2025-07-17', '10:00:00', '12:30:00', 1082, 251);
INSERT INTO public.employee_schedule VALUES (225, '2025-05-11', '07:00:00', '09:00:00', 1060, 252);
INSERT INTO public.employee_schedule VALUES (226, '2025-03-07', '13:00:00', '15:30:00', 3017, 253);
INSERT INTO public.employee_schedule VALUES (227, '2024-09-10', '07:00:00', '09:30:00', 1082, 254);
INSERT INTO public.employee_schedule VALUES (228, '2024-07-14', '16:00:00', '18:30:00', 1201, 257);
INSERT INTO public.employee_schedule VALUES (229, '2025-03-29', '10:00:00', '12:30:00', 1077, 258);
INSERT INTO public.employee_schedule VALUES (230, '2025-03-09', '13:00:00', '15:00:00', 2179, 259);
INSERT INTO public.employee_schedule VALUES (231, '2025-10-20', '07:00:00', '09:00:00', 1047, 260);
INSERT INTO public.employee_schedule VALUES (232, '2024-03-06', '07:00:00', '09:30:00', 1067, 262);
INSERT INTO public.employee_schedule VALUES (233, '2025-04-04', '13:00:00', '15:00:00', 1053, 263);
INSERT INTO public.employee_schedule VALUES (234, '2025-09-02', '16:00:00', '18:30:00', 1090, 264);
INSERT INTO public.employee_schedule VALUES (235, '2025-12-16', '10:00:00', '12:00:00', 1193, 267);
INSERT INTO public.employee_schedule VALUES (236, '2025-10-28', '16:00:00', '18:30:00', 2084, 268);
INSERT INTO public.employee_schedule VALUES (237, '2024-10-04', '13:00:00', '15:30:00', 1105, 269);
INSERT INTO public.employee_schedule VALUES (238, '2024-12-10', '10:00:00', '12:00:00', 2022, 270);
INSERT INTO public.employee_schedule VALUES (239, '2025-11-27', '10:00:00', '12:00:00', 2094, 271);
INSERT INTO public.employee_schedule VALUES (240, '2024-09-27', '13:00:00', '15:30:00', 2002, 273);
INSERT INTO public.employee_schedule VALUES (241, '2025-08-22', '16:00:00', '18:00:00', 3142, 274);
INSERT INTO public.employee_schedule VALUES (242, '2025-12-11', '16:00:00', '18:30:00', 2202, 275);
INSERT INTO public.employee_schedule VALUES (243, '2024-09-12', '13:00:00', '15:30:00', 2170, 276);
INSERT INTO public.employee_schedule VALUES (244, '2025-02-28', '07:00:00', '09:00:00', 1037, 278);
INSERT INTO public.employee_schedule VALUES (245, '2025-11-01', '16:00:00', '18:30:00', 2063, 280);
INSERT INTO public.employee_schedule VALUES (246, '2025-07-07', '16:00:00', '18:30:00', 2205, 282);
INSERT INTO public.employee_schedule VALUES (247, '2025-05-28', '07:00:00', '09:00:00', 1182, 283);
INSERT INTO public.employee_schedule VALUES (248, '2025-12-05', '07:00:00', '09:30:00', 3056, 284);
INSERT INTO public.employee_schedule VALUES (249, '2024-12-21', '16:00:00', '18:00:00', 3069, 285);
INSERT INTO public.employee_schedule VALUES (250, '2025-08-31', '13:00:00', '15:30:00', 2214, 286);
INSERT INTO public.employee_schedule VALUES (251, '2025-06-06', '07:00:00', '09:00:00', 2119, 287);
INSERT INTO public.employee_schedule VALUES (252, '2025-07-12', '07:00:00', '09:30:00', 2099, 288);
INSERT INTO public.employee_schedule VALUES (253, '2025-10-30', '16:00:00', '18:00:00', 1196, 289);
INSERT INTO public.employee_schedule VALUES (254, '2025-09-15', '13:00:00', '15:00:00', 1242, 290);
INSERT INTO public.employee_schedule VALUES (255, '2025-07-19', '16:00:00', '18:00:00', 2018, 291);
INSERT INTO public.employee_schedule VALUES (256, '2025-11-20', '07:00:00', '09:30:00', 2200, 292);
INSERT INTO public.employee_schedule VALUES (257, '2025-12-22', '13:00:00', '15:30:00', 3151, 293);
INSERT INTO public.employee_schedule VALUES (258, '2025-04-29', '07:00:00', '09:00:00', 3025, 294);
INSERT INTO public.employee_schedule VALUES (259, '2025-11-21', '13:00:00', '15:30:00', 3088, 295);
INSERT INTO public.employee_schedule VALUES (260, '2024-04-04', '13:00:00', '15:00:00', 1227, 296);
INSERT INTO public.employee_schedule VALUES (261, '2025-11-10', '10:00:00', '12:00:00', 3193, 297);
INSERT INTO public.employee_schedule VALUES (262, '2024-09-16', '13:00:00', '15:00:00', 2045, 298);
INSERT INTO public.employee_schedule VALUES (263, '2025-01-28', '13:00:00', '15:30:00', 3076, 299);
INSERT INTO public.employee_schedule VALUES (264, '2025-11-22', '16:00:00', '18:00:00', 3164, 300);
INSERT INTO public.employee_schedule VALUES (265, '2025-08-01', '16:00:00', '18:30:00', 3185, 301);
INSERT INTO public.employee_schedule VALUES (266, '2025-07-22', '16:00:00', '18:30:00', 3174, 302);
INSERT INTO public.employee_schedule VALUES (267, '2025-05-24', '10:00:00', '12:00:00', 2110, 303);
INSERT INTO public.employee_schedule VALUES (268, '2025-05-30', '16:00:00', '18:00:00', 2003, 305);
INSERT INTO public.employee_schedule VALUES (269, '2023-09-21', '10:00:00', '12:00:00', 1119, 306);
INSERT INTO public.employee_schedule VALUES (270, '2024-12-11', '07:00:00', '09:30:00', 3040, 307);
INSERT INTO public.employee_schedule VALUES (271, '2025-12-23', '16:00:00', '18:00:00', 3215, 309);
INSERT INTO public.employee_schedule VALUES (272, '2025-12-10', '10:00:00', '12:30:00', 1039, 310);
INSERT INTO public.employee_schedule VALUES (273, '2025-09-26', '16:00:00', '18:00:00', 2043, 311);
INSERT INTO public.employee_schedule VALUES (274, '2025-05-21', '10:00:00', '12:30:00', 2234, 312);
INSERT INTO public.employee_schedule VALUES (275, '2023-12-15', '13:00:00', '15:30:00', 1100, 313);
INSERT INTO public.employee_schedule VALUES (276, '2024-08-10', '07:00:00', '09:00:00', 2046, 314);
INSERT INTO public.employee_schedule VALUES (277, '2025-05-18', '07:00:00', '09:00:00', 2142, 316);
INSERT INTO public.employee_schedule VALUES (278, '2024-01-18', '13:00:00', '15:00:00', 3132, 319);
INSERT INTO public.employee_schedule VALUES (279, '2024-08-09', '13:00:00', '15:30:00', 2092, 320);
INSERT INTO public.employee_schedule VALUES (280, '2025-06-14', '07:00:00', '09:30:00', 1101, 321);
INSERT INTO public.employee_schedule VALUES (281, '2025-01-09', '10:00:00', '12:00:00', 3114, 322);
INSERT INTO public.employee_schedule VALUES (282, '2025-03-23', '16:00:00', '18:30:00', 2027, 323);
INSERT INTO public.employee_schedule VALUES (283, '2024-07-31', '13:00:00', '15:00:00', 3194, 324);
INSERT INTO public.employee_schedule VALUES (284, '2024-08-05', '07:00:00', '09:30:00', 2144, 325);
INSERT INTO public.employee_schedule VALUES (285, '2025-02-09', '07:00:00', '09:00:00', 2213, 326);
INSERT INTO public.employee_schedule VALUES (286, '2025-08-27', '16:00:00', '18:30:00', 1110, 327);
INSERT INTO public.employee_schedule VALUES (287, '2025-07-22', '10:00:00', '12:00:00', 3129, 328);
INSERT INTO public.employee_schedule VALUES (288, '2025-05-18', '13:00:00', '15:00:00', 3126, 329);
INSERT INTO public.employee_schedule VALUES (289, '2024-11-12', '07:00:00', '09:00:00', 3148, 330);
INSERT INTO public.employee_schedule VALUES (290, '2023-10-25', '10:00:00', '12:00:00', 3164, 331);
INSERT INTO public.employee_schedule VALUES (291, '2024-07-21', '13:00:00', '15:00:00', 3005, 332);
INSERT INTO public.employee_schedule VALUES (292, '2025-12-30', '10:00:00', '12:30:00', 1160, 333);
INSERT INTO public.employee_schedule VALUES (293, '2025-05-24', '07:00:00', '09:00:00', 2073, 334);
INSERT INTO public.employee_schedule VALUES (294, '2025-12-03', '16:00:00', '18:30:00', 3205, 335);
INSERT INTO public.employee_schedule VALUES (295, '2025-06-21', '13:00:00', '15:30:00', 1062, 336);
INSERT INTO public.employee_schedule VALUES (296, '2025-12-19', '10:00:00', '12:30:00', 3010, 337);
INSERT INTO public.employee_schedule VALUES (297, '2025-06-21', '10:00:00', '12:00:00', 1138, 338);
INSERT INTO public.employee_schedule VALUES (298, '2025-06-03', '13:00:00', '15:00:00', 1237, 339);
INSERT INTO public.employee_schedule VALUES (299, '2025-12-04', '16:00:00', '18:30:00', 1127, 340);
INSERT INTO public.employee_schedule VALUES (300, '2025-08-05', '10:00:00', '12:30:00', 3058, 341);
INSERT INTO public.employee_schedule VALUES (301, '2025-09-07', '10:00:00', '12:00:00', 1013, 343);
INSERT INTO public.employee_schedule VALUES (302, '2024-12-07', '07:00:00', '09:00:00', 1130, 344);
INSERT INTO public.employee_schedule VALUES (303, '2025-07-31', '13:00:00', '15:00:00', 2062, 345);
INSERT INTO public.employee_schedule VALUES (304, '2024-07-26', '16:00:00', '18:30:00', 1226, 346);
INSERT INTO public.employee_schedule VALUES (305, '2024-08-31', '10:00:00', '12:30:00', 2042, 348);
INSERT INTO public.employee_schedule VALUES (306, '2025-02-08', '16:00:00', '18:30:00', 2150, 349);
INSERT INTO public.employee_schedule VALUES (307, '2025-06-12', '16:00:00', '18:30:00', 3027, 350);
INSERT INTO public.employee_schedule VALUES (308, '2025-11-21', '16:00:00', '18:30:00', 3194, 351);
INSERT INTO public.employee_schedule VALUES (309, '2024-12-20', '13:00:00', '15:30:00', 2033, 352);
INSERT INTO public.employee_schedule VALUES (310, '2024-11-21', '13:00:00', '15:30:00', 2125, 353);
INSERT INTO public.employee_schedule VALUES (311, '2024-10-09', '16:00:00', '18:00:00', 2138, 354);
INSERT INTO public.employee_schedule VALUES (312, '2025-07-08', '16:00:00', '18:00:00', 3229, 356);
INSERT INTO public.employee_schedule VALUES (313, '2024-04-18', '13:00:00', '15:30:00', 3242, 357);
INSERT INTO public.employee_schedule VALUES (314, '2025-03-31', '07:00:00', '09:00:00', 3215, 358);
INSERT INTO public.employee_schedule VALUES (315, '2025-08-08', '13:00:00', '15:30:00', 1098, 359);
INSERT INTO public.employee_schedule VALUES (316, '2024-04-30', '13:00:00', '15:30:00', 1238, 360);
INSERT INTO public.employee_schedule VALUES (317, '2025-09-03', '07:00:00', '09:00:00', 1003, 361);
INSERT INTO public.employee_schedule VALUES (318, '2025-12-25', '16:00:00', '18:30:00', 2172, 362);
INSERT INTO public.employee_schedule VALUES (319, '2024-09-16', '13:00:00', '15:00:00', 2193, 363);
INSERT INTO public.employee_schedule VALUES (320, '2024-10-22', '16:00:00', '18:30:00', 3009, 364);
INSERT INTO public.employee_schedule VALUES (321, '2024-09-25', '07:00:00', '09:30:00', 1201, 365);
INSERT INTO public.employee_schedule VALUES (322, '2024-07-30', '07:00:00', '09:00:00', 3127, 366);
INSERT INTO public.employee_schedule VALUES (323, '2024-09-14', '13:00:00', '15:00:00', 2114, 367);
INSERT INTO public.employee_schedule VALUES (324, '2025-05-18', '16:00:00', '18:00:00', 3194, 368);
INSERT INTO public.employee_schedule VALUES (325, '2025-07-30', '10:00:00', '12:00:00', 3175, 369);
INSERT INTO public.employee_schedule VALUES (326, '2024-09-03', '16:00:00', '18:00:00', 3235, 370);
INSERT INTO public.employee_schedule VALUES (327, '2025-01-12', '07:00:00', '09:30:00', 3062, 371);
INSERT INTO public.employee_schedule VALUES (328, '2025-01-29', '16:00:00', '18:00:00', 1082, 372);
INSERT INTO public.employee_schedule VALUES (329, '2025-05-01', '16:00:00', '18:00:00', 3165, 373);
INSERT INTO public.employee_schedule VALUES (330, '2025-06-18', '10:00:00', '12:30:00', 2025, 374);
INSERT INTO public.employee_schedule VALUES (331, '2025-01-19', '07:00:00', '09:00:00', 3186, 375);
INSERT INTO public.employee_schedule VALUES (332, '2025-05-09', '13:00:00', '15:30:00', 2085, 376);
INSERT INTO public.employee_schedule VALUES (333, '2025-09-19', '13:00:00', '15:30:00', 1110, 377);
INSERT INTO public.employee_schedule VALUES (334, '2025-08-18', '07:00:00', '09:30:00', 1063, 378);
INSERT INTO public.employee_schedule VALUES (335, '2025-11-22', '13:00:00', '15:30:00', 3085, 379);
INSERT INTO public.employee_schedule VALUES (336, '2025-12-23', '13:00:00', '15:00:00', 1083, 380);
INSERT INTO public.employee_schedule VALUES (337, '2025-02-17', '13:00:00', '15:30:00', 2227, 381);
INSERT INTO public.employee_schedule VALUES (338, '2024-03-01', '16:00:00', '18:30:00', 3108, 382);
INSERT INTO public.employee_schedule VALUES (339, '2025-08-28', '07:00:00', '09:00:00', 2093, 384);
INSERT INTO public.employee_schedule VALUES (340, '2025-05-27', '16:00:00', '18:00:00', 2104, 385);
INSERT INTO public.employee_schedule VALUES (341, '2024-05-05', '13:00:00', '15:30:00', 3025, 387);
INSERT INTO public.employee_schedule VALUES (342, '2025-08-26', '10:00:00', '12:30:00', 1014, 388);
INSERT INTO public.employee_schedule VALUES (343, '2025-06-30', '13:00:00', '15:30:00', 1028, 389);
INSERT INTO public.employee_schedule VALUES (344, '2023-11-19', '07:00:00', '09:30:00', 1113, 390);
INSERT INTO public.employee_schedule VALUES (345, '2025-04-20', '07:00:00', '09:30:00', 3089, 391);
INSERT INTO public.employee_schedule VALUES (346, '2023-09-02', '10:00:00', '12:30:00', 1082, 393);
INSERT INTO public.employee_schedule VALUES (347, '2025-07-29', '10:00:00', '12:30:00', 2047, 394);
INSERT INTO public.employee_schedule VALUES (348, '2024-03-09', '16:00:00', '18:30:00', 2223, 395);
INSERT INTO public.employee_schedule VALUES (349, '2025-10-23', '07:00:00', '09:00:00', 3107, 396);
INSERT INTO public.employee_schedule VALUES (350, '2025-04-06', '16:00:00', '18:00:00', 3026, 397);
INSERT INTO public.employee_schedule VALUES (351, '2024-09-28', '16:00:00', '18:30:00', 1144, 398);
INSERT INTO public.employee_schedule VALUES (352, '2024-06-10', '16:00:00', '18:30:00', 1067, 399);
INSERT INTO public.employee_schedule VALUES (353, '2024-02-13', '07:00:00', '09:30:00', 2167, 400);
INSERT INTO public.employee_schedule VALUES (354, '2024-11-07', '10:00:00', '12:30:00', 2072, 401);
INSERT INTO public.employee_schedule VALUES (355, '2024-05-20', '07:00:00', '09:30:00', 2053, 402);
INSERT INTO public.employee_schedule VALUES (356, '2024-08-16', '10:00:00', '12:00:00', 3202, 403);
INSERT INTO public.employee_schedule VALUES (357, '2025-07-01', '07:00:00', '09:30:00', 1146, 404);
INSERT INTO public.employee_schedule VALUES (358, '2025-07-22', '10:00:00', '12:00:00', 1177, 405);
INSERT INTO public.employee_schedule VALUES (359, '2025-03-22', '07:00:00', '09:00:00', 2021, 406);
INSERT INTO public.employee_schedule VALUES (360, '2025-08-11', '13:00:00', '15:30:00', 2208, 407);
INSERT INTO public.employee_schedule VALUES (361, '2025-04-08', '16:00:00', '18:30:00', 1020, 408);
INSERT INTO public.employee_schedule VALUES (362, '2025-10-20', '07:00:00', '09:30:00', 2129, 409);
INSERT INTO public.employee_schedule VALUES (363, '2025-05-31', '13:00:00', '15:30:00', 1198, 410);
INSERT INTO public.employee_schedule VALUES (364, '2025-07-02', '07:00:00', '09:30:00', 2109, 411);
INSERT INTO public.employee_schedule VALUES (365, '2025-08-16', '16:00:00', '18:30:00', 1125, 412);
INSERT INTO public.employee_schedule VALUES (366, '2025-06-01', '10:00:00', '12:30:00', 3217, 413);
INSERT INTO public.employee_schedule VALUES (367, '2024-03-16', '10:00:00', '12:30:00', 2142, 414);
INSERT INTO public.employee_schedule VALUES (368, '2025-11-06', '10:00:00', '12:30:00', 1168, 415);
INSERT INTO public.employee_schedule VALUES (369, '2025-12-08', '13:00:00', '15:30:00', 2136, 416);
INSERT INTO public.employee_schedule VALUES (370, '2025-09-01', '07:00:00', '09:00:00', 1209, 417);
INSERT INTO public.employee_schedule VALUES (371, '2025-09-11', '16:00:00', '18:30:00', 3049, 418);
INSERT INTO public.employee_schedule VALUES (372, '2025-08-21', '07:00:00', '09:30:00', 1243, 419);
INSERT INTO public.employee_schedule VALUES (373, '2024-03-11', '10:00:00', '12:30:00', 2199, 420);
INSERT INTO public.employee_schedule VALUES (374, '2025-06-14', '10:00:00', '12:00:00', 3134, 422);
INSERT INTO public.employee_schedule VALUES (375, '2025-10-26', '16:00:00', '18:00:00', 1126, 423);
INSERT INTO public.employee_schedule VALUES (376, '2025-09-23', '13:00:00', '15:00:00', 3152, 424);
INSERT INTO public.employee_schedule VALUES (377, '2025-07-19', '07:00:00', '09:30:00', 1097, 425);
INSERT INTO public.employee_schedule VALUES (378, '2024-11-19', '16:00:00', '18:00:00', 1090, 426);
INSERT INTO public.employee_schedule VALUES (379, '2025-10-18', '07:00:00', '09:30:00', 3004, 428);
INSERT INTO public.employee_schedule VALUES (380, '2023-06-29', '07:00:00', '09:00:00', 3031, 429);
INSERT INTO public.employee_schedule VALUES (381, '2024-06-26', '16:00:00', '18:30:00', 2219, 430);
INSERT INTO public.employee_schedule VALUES (382, '2025-12-22', '07:00:00', '09:00:00', 3118, 431);
INSERT INTO public.employee_schedule VALUES (383, '2025-03-19', '10:00:00', '12:00:00', 2068, 432);
INSERT INTO public.employee_schedule VALUES (384, '2025-10-30', '16:00:00', '18:00:00', 3131, 433);
INSERT INTO public.employee_schedule VALUES (385, '2025-12-07', '13:00:00', '15:00:00', 3173, 434);
INSERT INTO public.employee_schedule VALUES (386, '2024-06-25', '07:00:00', '09:00:00', 1048, 436);
INSERT INTO public.employee_schedule VALUES (387, '2024-11-27', '16:00:00', '18:00:00', 2075, 437);
INSERT INTO public.employee_schedule VALUES (388, '2024-10-27', '13:00:00', '15:00:00', 3204, 438);
INSERT INTO public.employee_schedule VALUES (389, '2025-12-04', '13:00:00', '15:00:00', 1021, 440);
INSERT INTO public.employee_schedule VALUES (390, '2025-12-04', '10:00:00', '12:30:00', 1081, 441);
INSERT INTO public.employee_schedule VALUES (391, '2025-08-13', '10:00:00', '12:30:00', 2018, 442);
INSERT INTO public.employee_schedule VALUES (392, '2024-11-16', '13:00:00', '15:30:00', 1056, 443);
INSERT INTO public.employee_schedule VALUES (393, '2024-08-03', '07:00:00', '09:00:00', 3185, 444);
INSERT INTO public.employee_schedule VALUES (394, '2025-01-15', '16:00:00', '18:00:00', 2037, 445);
INSERT INTO public.employee_schedule VALUES (395, '2025-10-27', '16:00:00', '18:30:00', 1238, 446);
INSERT INTO public.employee_schedule VALUES (396, '2024-10-06', '07:00:00', '09:30:00', 1015, 447);
INSERT INTO public.employee_schedule VALUES (397, '2025-12-06', '10:00:00', '12:00:00', 1183, 448);
INSERT INTO public.employee_schedule VALUES (398, '2024-02-22', '07:00:00', '09:30:00', 2014, 449);
INSERT INTO public.employee_schedule VALUES (399, '2025-07-03', '16:00:00', '18:30:00', 2094, 450);
INSERT INTO public.employee_schedule VALUES (400, '2025-10-25', '07:00:00', '09:30:00', 1150, 451);
INSERT INTO public.employee_schedule VALUES (401, '2024-10-25', '16:00:00', '18:00:00', 2226, 452);
INSERT INTO public.employee_schedule VALUES (402, '2024-08-21', '07:00:00', '09:30:00', 1028, 453);
INSERT INTO public.employee_schedule VALUES (403, '2025-04-11', '13:00:00', '15:00:00', 3069, 454);
INSERT INTO public.employee_schedule VALUES (404, '2025-02-23', '07:00:00', '09:30:00', 1029, 455);
INSERT INTO public.employee_schedule VALUES (405, '2024-08-08', '10:00:00', '12:00:00', 3099, 456);
INSERT INTO public.employee_schedule VALUES (406, '2025-03-19', '13:00:00', '15:00:00', 1115, 458);
INSERT INTO public.employee_schedule VALUES (407, '2024-02-07', '16:00:00', '18:00:00', 1241, 459);
INSERT INTO public.employee_schedule VALUES (408, '2025-08-24', '16:00:00', '18:00:00', 2126, 462);
INSERT INTO public.employee_schedule VALUES (409, '2025-12-12', '16:00:00', '18:30:00', 1118, 463);
INSERT INTO public.employee_schedule VALUES (410, '2025-07-05', '13:00:00', '15:00:00', 1051, 464);
INSERT INTO public.employee_schedule VALUES (411, '2025-10-27', '16:00:00', '18:00:00', 2091, 465);
INSERT INTO public.employee_schedule VALUES (412, '2025-09-19', '16:00:00', '18:00:00', 1039, 466);
INSERT INTO public.employee_schedule VALUES (413, '2025-09-02', '13:00:00', '15:00:00', 2122, 467);
INSERT INTO public.employee_schedule VALUES (414, '2025-12-18', '16:00:00', '18:30:00', 1056, 468);
INSERT INTO public.employee_schedule VALUES (415, '2025-11-26', '07:00:00', '09:00:00', 1036, 469);
INSERT INTO public.employee_schedule VALUES (416, '2025-11-16', '16:00:00', '18:00:00', 3158, 470);
INSERT INTO public.employee_schedule VALUES (417, '2024-10-11', '10:00:00', '12:00:00', 3237, 471);
INSERT INTO public.employee_schedule VALUES (418, '2024-12-29', '10:00:00', '12:00:00', 3237, 472);
INSERT INTO public.employee_schedule VALUES (419, '2025-03-30', '10:00:00', '12:30:00', 3084, 473);
INSERT INTO public.employee_schedule VALUES (420, '2025-05-17', '13:00:00', '15:30:00', 1239, 474);
INSERT INTO public.employee_schedule VALUES (421, '2025-07-26', '16:00:00', '18:00:00', 3102, 475);
INSERT INTO public.employee_schedule VALUES (422, '2025-11-11', '13:00:00', '15:30:00', 1231, 476);
INSERT INTO public.employee_schedule VALUES (423, '2025-07-24', '16:00:00', '18:00:00', 3006, 477);
INSERT INTO public.employee_schedule VALUES (424, '2025-09-13', '07:00:00', '09:00:00', 1142, 478);
INSERT INTO public.employee_schedule VALUES (425, '2025-04-13', '10:00:00', '12:30:00', 3084, 479);
INSERT INTO public.employee_schedule VALUES (426, '2025-11-05', '16:00:00', '18:00:00', 2136, 480);
INSERT INTO public.employee_schedule VALUES (427, '2025-05-18', '07:00:00', '09:00:00', 2159, 481);
INSERT INTO public.employee_schedule VALUES (428, '2025-08-21', '07:00:00', '09:30:00', 1194, 482);
INSERT INTO public.employee_schedule VALUES (429, '2024-10-20', '07:00:00', '09:30:00', 3217, 483);
INSERT INTO public.employee_schedule VALUES (430, '2025-01-08', '10:00:00', '12:00:00', 1076, 484);
INSERT INTO public.employee_schedule VALUES (431, '2024-10-06', '13:00:00', '15:30:00', 1154, 485);
INSERT INTO public.employee_schedule VALUES (432, '2025-07-17', '07:00:00', '09:00:00', 2206, 486);
INSERT INTO public.employee_schedule VALUES (433, '2024-12-20', '10:00:00', '12:30:00', 3065, 487);
INSERT INTO public.employee_schedule VALUES (434, '2025-03-26', '10:00:00', '12:30:00', 3020, 488);
INSERT INTO public.employee_schedule VALUES (435, '2025-11-09', '13:00:00', '15:00:00', 2127, 489);
INSERT INTO public.employee_schedule VALUES (436, '2025-10-01', '13:00:00', '15:00:00', 3180, 492);
INSERT INTO public.employee_schedule VALUES (437, '2024-12-22', '13:00:00', '15:00:00', 1209, 493);
INSERT INTO public.employee_schedule VALUES (438, '2023-12-23', '13:00:00', '15:00:00', 1061, 494);
INSERT INTO public.employee_schedule VALUES (439, '2025-09-11', '10:00:00', '12:30:00', 3220, 496);
INSERT INTO public.employee_schedule VALUES (440, '2025-02-13', '07:00:00', '09:30:00', 1152, 497);
INSERT INTO public.employee_schedule VALUES (441, '2025-08-27', '13:00:00', '15:30:00', 2049, 500);
INSERT INTO public.employee_schedule VALUES (442, '2025-01-06', '10:00:00', '12:30:00', 3165, 501);
INSERT INTO public.employee_schedule VALUES (443, '2024-11-30', '10:00:00', '12:00:00', 2075, 503);
INSERT INTO public.employee_schedule VALUES (444, '2025-08-01', '10:00:00', '12:00:00', 1235, 504);
INSERT INTO public.employee_schedule VALUES (445, '2025-09-05', '13:00:00', '15:00:00', 3119, 505);
INSERT INTO public.employee_schedule VALUES (446, '2025-12-02', '16:00:00', '18:30:00', 3208, 506);
INSERT INTO public.employee_schedule VALUES (447, '2025-01-09', '07:00:00', '09:00:00', 2083, 507);
INSERT INTO public.employee_schedule VALUES (448, '2024-10-03', '16:00:00', '18:00:00', 3238, 508);
INSERT INTO public.employee_schedule VALUES (449, '2025-05-11', '16:00:00', '18:30:00', 3185, 509);
INSERT INTO public.employee_schedule VALUES (450, '2025-06-25', '10:00:00', '12:00:00', 3012, 510);
INSERT INTO public.employee_schedule VALUES (451, '2024-08-21', '07:00:00', '09:00:00', 2196, 511);
INSERT INTO public.employee_schedule VALUES (452, '2025-03-27', '07:00:00', '09:00:00', 3063, 512);
INSERT INTO public.employee_schedule VALUES (453, '2025-10-06', '07:00:00', '09:30:00', 1017, 513);
INSERT INTO public.employee_schedule VALUES (454, '2025-01-21', '07:00:00', '09:30:00', 2010, 514);
INSERT INTO public.employee_schedule VALUES (455, '2025-04-30', '10:00:00', '12:30:00', 1064, 516);
INSERT INTO public.employee_schedule VALUES (456, '2024-01-31', '16:00:00', '18:30:00', 1015, 517);
INSERT INTO public.employee_schedule VALUES (457, '2024-10-12', '07:00:00', '09:00:00', 1241, 518);
INSERT INTO public.employee_schedule VALUES (458, '2024-05-07', '13:00:00', '15:30:00', 1231, 519);
INSERT INTO public.employee_schedule VALUES (459, '2025-12-05', '16:00:00', '18:30:00', 3072, 520);
INSERT INTO public.employee_schedule VALUES (460, '2025-08-06', '13:00:00', '15:00:00', 2176, 522);
INSERT INTO public.employee_schedule VALUES (461, '2024-09-05', '16:00:00', '18:30:00', 1021, 523);
INSERT INTO public.employee_schedule VALUES (462, '2024-06-08', '13:00:00', '15:00:00', 2194, 524);
INSERT INTO public.employee_schedule VALUES (463, '2025-08-09', '10:00:00', '12:00:00', 3191, 525);
INSERT INTO public.employee_schedule VALUES (464, '2025-01-06', '07:00:00', '09:30:00', 2025, 526);
INSERT INTO public.employee_schedule VALUES (465, '2025-11-22', '13:00:00', '15:30:00', 1211, 527);
INSERT INTO public.employee_schedule VALUES (466, '2025-03-25', '10:00:00', '12:30:00', 3068, 528);
INSERT INTO public.employee_schedule VALUES (467, '2024-07-28', '07:00:00', '09:30:00', 1024, 529);
INSERT INTO public.employee_schedule VALUES (468, '2025-01-20', '13:00:00', '15:30:00', 2168, 530);
INSERT INTO public.employee_schedule VALUES (469, '2024-05-01', '07:00:00', '09:30:00', 2211, 531);
INSERT INTO public.employee_schedule VALUES (470, '2025-02-15', '16:00:00', '18:30:00', 2122, 532);
INSERT INTO public.employee_schedule VALUES (471, '2023-10-21', '07:00:00', '09:00:00', 2212, 533);
INSERT INTO public.employee_schedule VALUES (472, '2025-05-17', '10:00:00', '12:30:00', 3089, 534);
INSERT INTO public.employee_schedule VALUES (473, '2025-09-12', '07:00:00', '09:30:00', 2203, 535);
INSERT INTO public.employee_schedule VALUES (474, '2025-01-05', '13:00:00', '15:30:00', 2067, 536);
INSERT INTO public.employee_schedule VALUES (475, '2025-12-13', '16:00:00', '18:30:00', 2112, 537);
INSERT INTO public.employee_schedule VALUES (476, '2025-02-15', '10:00:00', '12:30:00', 2024, 538);
INSERT INTO public.employee_schedule VALUES (477, '2025-09-21', '13:00:00', '15:00:00', 3197, 539);
INSERT INTO public.employee_schedule VALUES (478, '2024-01-12', '13:00:00', '15:00:00', 2092, 540);
INSERT INTO public.employee_schedule VALUES (479, '2025-10-26', '10:00:00', '12:00:00', 1059, 541);
INSERT INTO public.employee_schedule VALUES (480, '2024-05-23', '16:00:00', '18:30:00', 1126, 542);
INSERT INTO public.employee_schedule VALUES (481, '2023-09-01', '16:00:00', '18:30:00', 2225, 543);
INSERT INTO public.employee_schedule VALUES (482, '2023-12-14', '07:00:00', '09:00:00', 3175, 544);
INSERT INTO public.employee_schedule VALUES (483, '2024-11-13', '10:00:00', '12:30:00', 3080, 545);
INSERT INTO public.employee_schedule VALUES (484, '2025-10-22', '16:00:00', '18:00:00', 1079, 546);
INSERT INTO public.employee_schedule VALUES (485, '2025-10-24', '10:00:00', '12:00:00', 2227, 547);
INSERT INTO public.employee_schedule VALUES (486, '2023-11-21', '16:00:00', '18:00:00', 1121, 548);
INSERT INTO public.employee_schedule VALUES (487, '2025-12-11', '13:00:00', '15:30:00', 3213, 549);
INSERT INTO public.employee_schedule VALUES (488, '2025-08-09', '13:00:00', '15:30:00', 2110, 550);
INSERT INTO public.employee_schedule VALUES (489, '2025-11-19', '07:00:00', '09:00:00', 2088, 551);
INSERT INTO public.employee_schedule VALUES (490, '2023-11-25', '16:00:00', '18:30:00', 2019, 552);
INSERT INTO public.employee_schedule VALUES (491, '2025-12-24', '07:00:00', '09:30:00', 3076, 553);
INSERT INTO public.employee_schedule VALUES (492, '2025-09-18', '13:00:00', '15:30:00', 1163, 554);
INSERT INTO public.employee_schedule VALUES (493, '2025-07-31', '10:00:00', '12:00:00', 3100, 555);
INSERT INTO public.employee_schedule VALUES (494, '2024-05-07', '10:00:00', '12:30:00', 3070, 556);
INSERT INTO public.employee_schedule VALUES (495, '2025-12-13', '13:00:00', '15:00:00', 3009, 557);
INSERT INTO public.employee_schedule VALUES (496, '2025-02-27', '10:00:00', '12:00:00', 2145, 558);
INSERT INTO public.employee_schedule VALUES (497, '2024-06-01', '13:00:00', '15:30:00', 2004, 559);
INSERT INTO public.employee_schedule VALUES (498, '2023-12-11', '10:00:00', '12:00:00', 2142, 560);
INSERT INTO public.employee_schedule VALUES (499, '2024-12-17', '10:00:00', '12:00:00', 2176, 561);
INSERT INTO public.employee_schedule VALUES (500, '2025-10-05', '13:00:00', '15:30:00', 2054, 562);
INSERT INTO public.employee_schedule VALUES (501, '2025-05-09', '13:00:00', '15:30:00', 1221, 563);
INSERT INTO public.employee_schedule VALUES (502, '2025-03-14', '16:00:00', '18:30:00', 1104, 564);
INSERT INTO public.employee_schedule VALUES (503, '2025-08-20', '10:00:00', '12:30:00', 1190, 565);
INSERT INTO public.employee_schedule VALUES (504, '2024-09-04', '16:00:00', '18:30:00', 3083, 566);
INSERT INTO public.employee_schedule VALUES (505, '2025-06-17', '13:00:00', '15:00:00', 3226, 567);
INSERT INTO public.employee_schedule VALUES (506, '2025-10-17', '10:00:00', '12:30:00', 3058, 568);
INSERT INTO public.employee_schedule VALUES (507, '2025-09-20', '13:00:00', '15:00:00', 3149, 569);
INSERT INTO public.employee_schedule VALUES (508, '2025-04-11', '10:00:00', '12:30:00', 3206, 570);
INSERT INTO public.employee_schedule VALUES (509, '2024-05-30', '13:00:00', '15:00:00', 3195, 573);
INSERT INTO public.employee_schedule VALUES (510, '2025-12-31', '07:00:00', '09:30:00', 1193, 574);
INSERT INTO public.employee_schedule VALUES (511, '2025-05-23', '16:00:00', '18:00:00', 1087, 575);
INSERT INTO public.employee_schedule VALUES (512, '2024-12-04', '13:00:00', '15:30:00', 2206, 576);
INSERT INTO public.employee_schedule VALUES (513, '2024-09-30', '16:00:00', '18:00:00', 1146, 577);
INSERT INTO public.employee_schedule VALUES (514, '2025-05-31', '13:00:00', '15:00:00', 3128, 579);
INSERT INTO public.employee_schedule VALUES (515, '2025-05-01', '07:00:00', '09:30:00', 3238, 580);
INSERT INTO public.employee_schedule VALUES (516, '2025-11-17', '16:00:00', '18:30:00', 3203, 582);
INSERT INTO public.employee_schedule VALUES (517, '2024-04-22', '16:00:00', '18:30:00', 1071, 583);
INSERT INTO public.employee_schedule VALUES (518, '2024-11-20', '10:00:00', '12:30:00', 1026, 584);
INSERT INTO public.employee_schedule VALUES (519, '2025-08-27', '10:00:00', '12:00:00', 1055, 585);
INSERT INTO public.employee_schedule VALUES (520, '2025-09-12', '10:00:00', '12:30:00', 1176, 586);
INSERT INTO public.employee_schedule VALUES (521, '2024-11-29', '07:00:00', '09:00:00', 1142, 587);
INSERT INTO public.employee_schedule VALUES (522, '2025-05-26', '13:00:00', '15:30:00', 1103, 588);
INSERT INTO public.employee_schedule VALUES (523, '2025-01-28', '13:00:00', '15:30:00', 1005, 589);
INSERT INTO public.employee_schedule VALUES (524, '2025-04-22', '07:00:00', '09:00:00', 1052, 590);
INSERT INTO public.employee_schedule VALUES (525, '2025-07-18', '10:00:00', '12:30:00', 1205, 591);
INSERT INTO public.employee_schedule VALUES (526, '2024-08-17', '13:00:00', '15:00:00', 1088, 593);
INSERT INTO public.employee_schedule VALUES (527, '2024-11-21', '07:00:00', '09:30:00', 3239, 594);
INSERT INTO public.employee_schedule VALUES (528, '2025-03-18', '16:00:00', '18:00:00', 1009, 595);
INSERT INTO public.employee_schedule VALUES (529, '2025-11-23', '13:00:00', '15:00:00', 2023, 596);
INSERT INTO public.employee_schedule VALUES (530, '2025-11-21', '07:00:00', '09:00:00', 2180, 597);
INSERT INTO public.employee_schedule VALUES (531, '2025-02-01', '13:00:00', '15:00:00', 1189, 598);
INSERT INTO public.employee_schedule VALUES (532, '2024-05-11', '16:00:00', '18:30:00', 3198, 599);
INSERT INTO public.employee_schedule VALUES (533, '2025-01-21', '13:00:00', '15:30:00', 1226, 600);
INSERT INTO public.employee_schedule VALUES (534, '2025-05-08', '16:00:00', '18:30:00', 3193, 601);
INSERT INTO public.employee_schedule VALUES (535, '2024-10-19', '16:00:00', '18:00:00', 3100, 602);
INSERT INTO public.employee_schedule VALUES (536, '2025-07-26', '10:00:00', '12:30:00', 2152, 603);
INSERT INTO public.employee_schedule VALUES (537, '2025-11-26', '13:00:00', '15:00:00', 2214, 604);
INSERT INTO public.employee_schedule VALUES (538, '2025-08-13', '10:00:00', '12:30:00', 2238, 605);
INSERT INTO public.employee_schedule VALUES (539, '2025-12-25', '07:00:00', '09:30:00', 2186, 607);
INSERT INTO public.employee_schedule VALUES (540, '2024-12-20', '13:00:00', '15:00:00', 3037, 608);
INSERT INTO public.employee_schedule VALUES (541, '2025-01-17', '10:00:00', '12:30:00', 1173, 609);
INSERT INTO public.employee_schedule VALUES (542, '2025-11-19', '16:00:00', '18:00:00', 1109, 610);
INSERT INTO public.employee_schedule VALUES (543, '2025-04-24', '13:00:00', '15:00:00', 2062, 611);
INSERT INTO public.employee_schedule VALUES (544, '2024-09-13', '07:00:00', '09:30:00', 2091, 612);
INSERT INTO public.employee_schedule VALUES (545, '2025-05-05', '16:00:00', '18:00:00', 1167, 613);
INSERT INTO public.employee_schedule VALUES (546, '2023-07-12', '13:00:00', '15:00:00', 1125, 615);
INSERT INTO public.employee_schedule VALUES (547, '2025-07-07', '13:00:00', '15:30:00', 1219, 616);
INSERT INTO public.employee_schedule VALUES (548, '2025-10-22', '10:00:00', '12:00:00', 3076, 617);
INSERT INTO public.employee_schedule VALUES (549, '2024-04-10', '13:00:00', '15:00:00', 1152, 618);
INSERT INTO public.employee_schedule VALUES (550, '2025-12-06', '10:00:00', '12:00:00', 2240, 619);
INSERT INTO public.employee_schedule VALUES (551, '2025-08-23', '16:00:00', '18:00:00', 2200, 620);
INSERT INTO public.employee_schedule VALUES (552, '2025-08-04', '16:00:00', '18:00:00', 3131, 621);
INSERT INTO public.employee_schedule VALUES (553, '2025-05-26', '13:00:00', '15:00:00', 2199, 622);
INSERT INTO public.employee_schedule VALUES (554, '2024-09-02', '13:00:00', '15:30:00', 3108, 623);
INSERT INTO public.employee_schedule VALUES (555, '2025-02-01', '13:00:00', '15:00:00', 3205, 624);
INSERT INTO public.employee_schedule VALUES (556, '2024-09-11', '13:00:00', '15:00:00', 1052, 625);
INSERT INTO public.employee_schedule VALUES (557, '2025-05-03', '07:00:00', '09:00:00', 1097, 626);
INSERT INTO public.employee_schedule VALUES (558, '2025-02-27', '10:00:00', '12:30:00', 3083, 627);
INSERT INTO public.employee_schedule VALUES (559, '2024-09-27', '10:00:00', '12:00:00', 3217, 628);
INSERT INTO public.employee_schedule VALUES (560, '2025-03-06', '13:00:00', '15:00:00', 1114, 629);
INSERT INTO public.employee_schedule VALUES (561, '2025-04-27', '07:00:00', '09:00:00', 3192, 630);
INSERT INTO public.employee_schedule VALUES (562, '2025-07-01', '16:00:00', '18:30:00', 2084, 631);
INSERT INTO public.employee_schedule VALUES (563, '2024-07-30', '10:00:00', '12:00:00', 1123, 632);
INSERT INTO public.employee_schedule VALUES (564, '2024-09-10', '10:00:00', '12:30:00', 2009, 633);
INSERT INTO public.employee_schedule VALUES (565, '2024-09-06', '16:00:00', '18:30:00', 3011, 634);
INSERT INTO public.employee_schedule VALUES (566, '2025-08-07', '10:00:00', '12:00:00', 3234, 635);
INSERT INTO public.employee_schedule VALUES (567, '2025-06-22', '13:00:00', '15:00:00', 3019, 636);
INSERT INTO public.employee_schedule VALUES (568, '2025-04-04', '07:00:00', '09:00:00', 1013, 637);
INSERT INTO public.employee_schedule VALUES (569, '2025-10-26', '13:00:00', '15:00:00', 2057, 638);
INSERT INTO public.employee_schedule VALUES (570, '2025-06-24', '16:00:00', '18:30:00', 2041, 639);
INSERT INTO public.employee_schedule VALUES (571, '2025-07-15', '16:00:00', '18:30:00', 2162, 640);
INSERT INTO public.employee_schedule VALUES (572, '2024-10-02', '07:00:00', '09:00:00', 3032, 641);
INSERT INTO public.employee_schedule VALUES (573, '2025-02-19', '16:00:00', '18:30:00', 2018, 642);
INSERT INTO public.employee_schedule VALUES (574, '2025-05-01', '07:00:00', '09:00:00', 2069, 643);
INSERT INTO public.employee_schedule VALUES (575, '2024-06-08', '16:00:00', '18:00:00', 1112, 644);
INSERT INTO public.employee_schedule VALUES (576, '2025-01-12', '07:00:00', '09:30:00', 2179, 645);
INSERT INTO public.employee_schedule VALUES (577, '2025-07-08', '13:00:00', '15:30:00', 1056, 646);
INSERT INTO public.employee_schedule VALUES (578, '2025-06-12', '07:00:00', '09:00:00', 2121, 647);
INSERT INTO public.employee_schedule VALUES (579, '2025-03-28', '07:00:00', '09:30:00', 2076, 648);
INSERT INTO public.employee_schedule VALUES (580, '2025-02-27', '13:00:00', '15:00:00', 1022, 650);
INSERT INTO public.employee_schedule VALUES (581, '2025-09-20', '10:00:00', '12:30:00', 1175, 651);
INSERT INTO public.employee_schedule VALUES (582, '2025-01-07', '07:00:00', '09:30:00', 1166, 652);
INSERT INTO public.employee_schedule VALUES (583, '2026-01-01', '16:00:00', '18:30:00', 1220, 653);
INSERT INTO public.employee_schedule VALUES (584, '2023-10-11', '07:00:00', '09:30:00', 3027, 655);
INSERT INTO public.employee_schedule VALUES (585, '2025-08-23', '07:00:00', '09:00:00', 1215, 656);
INSERT INTO public.employee_schedule VALUES (586, '2025-03-07', '16:00:00', '18:00:00', 2103, 657);
INSERT INTO public.employee_schedule VALUES (587, '2025-04-20', '13:00:00', '15:00:00', 3105, 658);
INSERT INTO public.employee_schedule VALUES (588, '2025-11-05', '07:00:00', '09:00:00', 2007, 659);
INSERT INTO public.employee_schedule VALUES (589, '2025-07-26', '07:00:00', '09:30:00', 2106, 660);
INSERT INTO public.employee_schedule VALUES (590, '2024-03-29', '07:00:00', '09:00:00', 2052, 661);
INSERT INTO public.employee_schedule VALUES (591, '2025-10-13', '07:00:00', '09:30:00', 2050, 662);
INSERT INTO public.employee_schedule VALUES (592, '2025-06-19', '07:00:00', '09:30:00', 2092, 663);
INSERT INTO public.employee_schedule VALUES (593, '2025-12-15', '10:00:00', '12:30:00', 1169, 664);
INSERT INTO public.employee_schedule VALUES (594, '2025-01-19', '13:00:00', '15:30:00', 1160, 665);
INSERT INTO public.employee_schedule VALUES (595, '2024-09-25', '16:00:00', '18:00:00', 1216, 666);
INSERT INTO public.employee_schedule VALUES (596, '2024-08-13', '07:00:00', '09:30:00', 1113, 667);
INSERT INTO public.employee_schedule VALUES (597, '2025-09-03', '07:00:00', '09:00:00', 1082, 668);
INSERT INTO public.employee_schedule VALUES (598, '2025-09-12', '07:00:00', '09:30:00', 2241, 670);
INSERT INTO public.employee_schedule VALUES (599, '2024-05-14', '13:00:00', '15:00:00', 1216, 671);
INSERT INTO public.employee_schedule VALUES (600, '2025-11-21', '10:00:00', '12:30:00', 3096, 672);
INSERT INTO public.employee_schedule VALUES (601, '2025-12-21', '13:00:00', '15:30:00', 3020, 673);
INSERT INTO public.employee_schedule VALUES (602, '2025-11-24', '16:00:00', '18:00:00', 2057, 674);
INSERT INTO public.employee_schedule VALUES (603, '2025-08-07', '13:00:00', '15:30:00', 3171, 675);
INSERT INTO public.employee_schedule VALUES (604, '2025-02-03', '16:00:00', '18:00:00', 3165, 676);
INSERT INTO public.employee_schedule VALUES (605, '2023-12-27', '10:00:00', '12:30:00', 3171, 677);
INSERT INTO public.employee_schedule VALUES (606, '2025-08-23', '10:00:00', '12:30:00', 1034, 678);
INSERT INTO public.employee_schedule VALUES (607, '2025-01-22', '16:00:00', '18:30:00', 2237, 679);
INSERT INTO public.employee_schedule VALUES (608, '2025-03-22', '13:00:00', '15:30:00', 1104, 680);
INSERT INTO public.employee_schedule VALUES (609, '2025-06-02', '13:00:00', '15:00:00', 3234, 681);
INSERT INTO public.employee_schedule VALUES (610, '2024-12-02', '16:00:00', '18:00:00', 3066, 683);
INSERT INTO public.employee_schedule VALUES (611, '2025-09-05', '13:00:00', '15:30:00', 2194, 684);
INSERT INTO public.employee_schedule VALUES (612, '2025-03-04', '07:00:00', '09:00:00', 3202, 685);
INSERT INTO public.employee_schedule VALUES (613, '2024-08-30', '07:00:00', '09:30:00', 1231, 686);
INSERT INTO public.employee_schedule VALUES (614, '2025-01-08', '10:00:00', '12:30:00', 3219, 687);
INSERT INTO public.employee_schedule VALUES (615, '2025-01-31', '16:00:00', '18:00:00', 1197, 688);
INSERT INTO public.employee_schedule VALUES (616, '2025-12-29', '13:00:00', '15:30:00', 2222, 689);
INSERT INTO public.employee_schedule VALUES (617, '2025-07-17', '07:00:00', '09:00:00', 2055, 690);
INSERT INTO public.employee_schedule VALUES (618, '2025-02-13', '13:00:00', '15:30:00', 2053, 691);
INSERT INTO public.employee_schedule VALUES (619, '2025-12-07', '16:00:00', '18:30:00', 3221, 692);
INSERT INTO public.employee_schedule VALUES (620, '2024-11-24', '07:00:00', '09:30:00', 2034, 693);
INSERT INTO public.employee_schedule VALUES (621, '2025-04-02', '13:00:00', '15:30:00', 3001, 694);
INSERT INTO public.employee_schedule VALUES (622, '2024-10-08', '10:00:00', '12:00:00', 3072, 696);
INSERT INTO public.employee_schedule VALUES (623, '2024-04-14', '10:00:00', '12:30:00', 3022, 697);
INSERT INTO public.employee_schedule VALUES (624, '2025-11-17', '10:00:00', '12:00:00', 2128, 698);
INSERT INTO public.employee_schedule VALUES (625, '2024-08-24', '10:00:00', '12:30:00', 2235, 699);
INSERT INTO public.employee_schedule VALUES (626, '2025-02-17', '07:00:00', '09:00:00', 1044, 700);
INSERT INTO public.employee_schedule VALUES (627, '2024-08-31', '13:00:00', '15:00:00', 2233, 701);
INSERT INTO public.employee_schedule VALUES (628, '2025-08-20', '13:00:00', '15:30:00', 1108, 702);
INSERT INTO public.employee_schedule VALUES (629, '2025-09-09', '07:00:00', '09:00:00', 1024, 703);
INSERT INTO public.employee_schedule VALUES (630, '2024-12-03', '10:00:00', '12:00:00', 3159, 704);
INSERT INTO public.employee_schedule VALUES (631, '2025-08-17', '07:00:00', '09:30:00', 1176, 705);
INSERT INTO public.employee_schedule VALUES (632, '2025-12-23', '10:00:00', '12:30:00', 2103, 707);
INSERT INTO public.employee_schedule VALUES (633, '2024-11-29', '07:00:00', '09:00:00', 2056, 708);
INSERT INTO public.employee_schedule VALUES (634, '2025-07-26', '10:00:00', '12:00:00', 1199, 709);
INSERT INTO public.employee_schedule VALUES (635, '2025-10-19', '13:00:00', '15:30:00', 3082, 710);
INSERT INTO public.employee_schedule VALUES (636, '2024-11-17', '07:00:00', '09:00:00', 2073, 711);
INSERT INTO public.employee_schedule VALUES (637, '2024-12-23', '13:00:00', '15:00:00', 2222, 712);
INSERT INTO public.employee_schedule VALUES (638, '2025-07-02', '07:00:00', '09:30:00', 2017, 713);
INSERT INTO public.employee_schedule VALUES (639, '2025-03-11', '16:00:00', '18:30:00', 1237, 714);
INSERT INTO public.employee_schedule VALUES (640, '2025-09-30', '16:00:00', '18:30:00', 2016, 715);
INSERT INTO public.employee_schedule VALUES (641, '2025-06-25', '13:00:00', '15:30:00', 3222, 716);
INSERT INTO public.employee_schedule VALUES (642, '2025-09-09', '07:00:00', '09:00:00', 1066, 718);
INSERT INTO public.employee_schedule VALUES (643, '2023-07-19', '07:00:00', '09:30:00', 2195, 719);
INSERT INTO public.employee_schedule VALUES (644, '2024-11-05', '10:00:00', '12:00:00', 1059, 721);
INSERT INTO public.employee_schedule VALUES (645, '2025-09-24', '13:00:00', '15:30:00', 1085, 723);
INSERT INTO public.employee_schedule VALUES (646, '2025-12-31', '07:00:00', '09:00:00', 1003, 725);
INSERT INTO public.employee_schedule VALUES (647, '2025-08-24', '16:00:00', '18:00:00', 2018, 730);
INSERT INTO public.employee_schedule VALUES (648, '2025-06-13', '07:00:00', '09:30:00', 1001, 731);
INSERT INTO public.employee_schedule VALUES (649, '2025-04-30', '13:00:00', '15:00:00', 2121, 732);
INSERT INTO public.employee_schedule VALUES (650, '2025-05-23', '16:00:00', '18:00:00', 3212, 733);
INSERT INTO public.employee_schedule VALUES (651, '2025-07-19', '07:00:00', '09:30:00', 3077, 734);
INSERT INTO public.employee_schedule VALUES (652, '2025-06-20', '10:00:00', '12:30:00', 2126, 735);
INSERT INTO public.employee_schedule VALUES (653, '2025-05-24', '10:00:00', '12:30:00', 2185, 736);
INSERT INTO public.employee_schedule VALUES (654, '2024-06-11', '10:00:00', '12:30:00', 2114, 737);
INSERT INTO public.employee_schedule VALUES (655, '2025-10-05', '13:00:00', '15:30:00', 3128, 739);
INSERT INTO public.employee_schedule VALUES (656, '2023-12-01', '13:00:00', '15:00:00', 3084, 740);
INSERT INTO public.employee_schedule VALUES (657, '2025-10-16', '10:00:00', '12:30:00', 1118, 742);
INSERT INTO public.employee_schedule VALUES (658, '2025-05-26', '10:00:00', '12:00:00', 1032, 743);
INSERT INTO public.employee_schedule VALUES (659, '2024-09-14', '13:00:00', '15:00:00', 1205, 744);
INSERT INTO public.employee_schedule VALUES (660, '2025-03-17', '16:00:00', '18:30:00', 3178, 745);
INSERT INTO public.employee_schedule VALUES (661, '2025-08-18', '13:00:00', '15:00:00', 2018, 746);
INSERT INTO public.employee_schedule VALUES (662, '2025-02-26', '16:00:00', '18:30:00', 3150, 747);
INSERT INTO public.employee_schedule VALUES (663, '2025-04-04', '07:00:00', '09:00:00', 1167, 748);
INSERT INTO public.employee_schedule VALUES (664, '2025-09-29', '13:00:00', '15:30:00', 1216, 749);
INSERT INTO public.employee_schedule VALUES (665, '2025-10-08', '07:00:00', '09:00:00', 3119, 750);
INSERT INTO public.employee_schedule VALUES (666, '2024-06-26', '10:00:00', '12:30:00', 3173, 751);
INSERT INTO public.employee_schedule VALUES (667, '2025-05-26', '10:00:00', '12:30:00', 3101, 752);
INSERT INTO public.employee_schedule VALUES (668, '2025-08-01', '16:00:00', '18:30:00', 2225, 753);
INSERT INTO public.employee_schedule VALUES (669, '2024-10-24', '07:00:00', '09:00:00', 3016, 754);
INSERT INTO public.employee_schedule VALUES (670, '2025-08-15', '16:00:00', '18:00:00', 1185, 756);
INSERT INTO public.employee_schedule VALUES (671, '2025-01-25', '13:00:00', '15:30:00', 2243, 758);
INSERT INTO public.employee_schedule VALUES (672, '2025-10-13', '16:00:00', '18:30:00', 1093, 759);
INSERT INTO public.employee_schedule VALUES (673, '2025-11-17', '07:00:00', '09:00:00', 3140, 760);
INSERT INTO public.employee_schedule VALUES (674, '2025-06-22', '10:00:00', '12:00:00', 3075, 761);
INSERT INTO public.employee_schedule VALUES (675, '2025-12-01', '13:00:00', '15:00:00', 3021, 762);
INSERT INTO public.employee_schedule VALUES (676, '2025-02-05', '13:00:00', '15:00:00', 2225, 763);
INSERT INTO public.employee_schedule VALUES (677, '2025-04-25', '13:00:00', '15:00:00', 3061, 764);
INSERT INTO public.employee_schedule VALUES (678, '2025-02-12', '16:00:00', '18:00:00', 3102, 765);
INSERT INTO public.employee_schedule VALUES (679, '2024-04-29', '10:00:00', '12:30:00', 1035, 766);
INSERT INTO public.employee_schedule VALUES (680, '2025-09-07', '13:00:00', '15:30:00', 3151, 767);
INSERT INTO public.employee_schedule VALUES (681, '2025-07-29', '10:00:00', '12:00:00', 1099, 768);
INSERT INTO public.employee_schedule VALUES (682, '2025-05-28', '10:00:00', '12:30:00', 2010, 769);
INSERT INTO public.employee_schedule VALUES (683, '2024-12-11', '13:00:00', '15:30:00', 3150, 770);
INSERT INTO public.employee_schedule VALUES (684, '2025-09-29', '10:00:00', '12:00:00', 2155, 771);
INSERT INTO public.employee_schedule VALUES (685, '2023-11-02', '16:00:00', '18:30:00', 1020, 772);
INSERT INTO public.employee_schedule VALUES (686, '2023-11-09', '13:00:00', '15:30:00', 1161, 773);
INSERT INTO public.employee_schedule VALUES (687, '2025-10-11', '07:00:00', '09:00:00', 2184, 774);
INSERT INTO public.employee_schedule VALUES (688, '2025-09-17', '10:00:00', '12:30:00', 1048, 775);
INSERT INTO public.employee_schedule VALUES (689, '2025-12-13', '10:00:00', '12:30:00', 3088, 776);
INSERT INTO public.employee_schedule VALUES (690, '2024-09-29', '10:00:00', '12:30:00', 2239, 777);
INSERT INTO public.employee_schedule VALUES (691, '2025-08-15', '13:00:00', '15:30:00', 1213, 778);
INSERT INTO public.employee_schedule VALUES (692, '2025-08-21', '16:00:00', '18:30:00', 1048, 779);
INSERT INTO public.employee_schedule VALUES (693, '2025-09-14', '16:00:00', '18:30:00', 2101, 780);
INSERT INTO public.employee_schedule VALUES (694, '2025-06-20', '16:00:00', '18:30:00', 2072, 781);
INSERT INTO public.employee_schedule VALUES (695, '2024-08-03', '16:00:00', '18:00:00', 3047, 782);
INSERT INTO public.employee_schedule VALUES (696, '2025-01-25', '16:00:00', '18:00:00', 1176, 783);
INSERT INTO public.employee_schedule VALUES (697, '2025-07-28', '16:00:00', '18:00:00', 3185, 784);
INSERT INTO public.employee_schedule VALUES (698, '2025-09-17', '10:00:00', '12:00:00', 1111, 785);
INSERT INTO public.employee_schedule VALUES (699, '2025-11-03', '16:00:00', '18:30:00', 1229, 786);
INSERT INTO public.employee_schedule VALUES (700, '2025-09-17', '10:00:00', '12:00:00', 1088, 788);
INSERT INTO public.employee_schedule VALUES (701, '2025-09-13', '16:00:00', '18:00:00', 3150, 790);
INSERT INTO public.employee_schedule VALUES (702, '2025-09-23', '10:00:00', '12:00:00', 1057, 791);
INSERT INTO public.employee_schedule VALUES (703, '2025-12-11', '07:00:00', '09:00:00', 2011, 792);
INSERT INTO public.employee_schedule VALUES (704, '2024-10-16', '07:00:00', '09:00:00', 2087, 793);
INSERT INTO public.employee_schedule VALUES (705, '2024-06-30', '16:00:00', '18:00:00', 1049, 794);
INSERT INTO public.employee_schedule VALUES (706, '2024-08-05', '16:00:00', '18:30:00', 1109, 796);
INSERT INTO public.employee_schedule VALUES (707, '2025-09-19', '07:00:00', '09:30:00', 2025, 797);
INSERT INTO public.employee_schedule VALUES (708, '2024-02-08', '16:00:00', '18:30:00', 2110, 798);
INSERT INTO public.employee_schedule VALUES (709, '2025-08-22', '16:00:00', '18:00:00', 3094, 799);
INSERT INTO public.employee_schedule VALUES (710, '2025-11-11', '16:00:00', '18:30:00', 1201, 800);
INSERT INTO public.employee_schedule VALUES (711, '2024-06-01', '13:00:00', '15:00:00', 3022, 801);
INSERT INTO public.employee_schedule VALUES (712, '2025-05-10', '13:00:00', '15:30:00', 2236, 802);
INSERT INTO public.employee_schedule VALUES (713, '2024-05-28', '13:00:00', '15:30:00', 1094, 804);
INSERT INTO public.employee_schedule VALUES (714, '2023-10-01', '16:00:00', '18:30:00', 1047, 807);
INSERT INTO public.employee_schedule VALUES (715, '2025-09-24', '10:00:00', '12:00:00', 1070, 809);
INSERT INTO public.employee_schedule VALUES (716, '2025-12-16', '10:00:00', '12:30:00', 2008, 810);
INSERT INTO public.employee_schedule VALUES (717, '2025-07-10', '13:00:00', '15:30:00', 1038, 811);
INSERT INTO public.employee_schedule VALUES (718, '2025-03-29', '10:00:00', '12:30:00', 1117, 812);
INSERT INTO public.employee_schedule VALUES (719, '2025-08-11', '13:00:00', '15:00:00', 3233, 813);
INSERT INTO public.employee_schedule VALUES (720, '2025-04-17', '07:00:00', '09:00:00', 1154, 814);
INSERT INTO public.employee_schedule VALUES (721, '2025-07-02', '07:00:00', '09:30:00', 1212, 815);
INSERT INTO public.employee_schedule VALUES (722, '2024-03-25', '16:00:00', '18:00:00', 3174, 816);
INSERT INTO public.employee_schedule VALUES (723, '2025-09-25', '16:00:00', '18:30:00', 1090, 817);
INSERT INTO public.employee_schedule VALUES (724, '2024-04-04', '07:00:00', '09:30:00', 2006, 818);
INSERT INTO public.employee_schedule VALUES (725, '2025-12-21', '10:00:00', '12:00:00', 2002, 819);
INSERT INTO public.employee_schedule VALUES (726, '2024-04-09', '13:00:00', '15:30:00', 3014, 820);
INSERT INTO public.employee_schedule VALUES (727, '2025-11-01', '07:00:00', '09:00:00', 1217, 821);
INSERT INTO public.employee_schedule VALUES (728, '2025-06-03', '07:00:00', '09:30:00', 1042, 822);
INSERT INTO public.employee_schedule VALUES (729, '2023-06-30', '10:00:00', '12:00:00', 2047, 823);
INSERT INTO public.employee_schedule VALUES (730, '2023-11-17', '16:00:00', '18:00:00', 3212, 824);
INSERT INTO public.employee_schedule VALUES (731, '2025-09-23', '10:00:00', '12:00:00', 1204, 825);
INSERT INTO public.employee_schedule VALUES (732, '2025-03-13', '13:00:00', '15:30:00', 1202, 826);
INSERT INTO public.employee_schedule VALUES (733, '2025-03-16', '16:00:00', '18:30:00', 1231, 827);
INSERT INTO public.employee_schedule VALUES (734, '2025-08-10', '13:00:00', '15:30:00', 1020, 829);
INSERT INTO public.employee_schedule VALUES (735, '2025-10-10', '07:00:00', '09:00:00', 2226, 830);
INSERT INTO public.employee_schedule VALUES (736, '2025-04-18', '07:00:00', '09:30:00', 2035, 831);
INSERT INTO public.employee_schedule VALUES (737, '2025-10-18', '07:00:00', '09:00:00', 3150, 832);
INSERT INTO public.employee_schedule VALUES (738, '2024-05-23', '10:00:00', '12:00:00', 3092, 833);
INSERT INTO public.employee_schedule VALUES (739, '2024-10-27', '16:00:00', '18:00:00', 2049, 834);
INSERT INTO public.employee_schedule VALUES (740, '2025-12-11', '13:00:00', '15:30:00', 2114, 835);
INSERT INTO public.employee_schedule VALUES (741, '2024-02-06', '07:00:00', '09:30:00', 1149, 836);
INSERT INTO public.employee_schedule VALUES (742, '2024-06-21', '07:00:00', '09:00:00', 3150, 837);
INSERT INTO public.employee_schedule VALUES (743, '2025-11-04', '13:00:00', '15:00:00', 3044, 838);
INSERT INTO public.employee_schedule VALUES (744, '2025-12-13', '10:00:00', '12:30:00', 3142, 839);
INSERT INTO public.employee_schedule VALUES (745, '2025-05-25', '10:00:00', '12:00:00', 1093, 840);
INSERT INTO public.employee_schedule VALUES (746, '2025-07-02', '16:00:00', '18:00:00', 3131, 842);
INSERT INTO public.employee_schedule VALUES (747, '2025-01-25', '10:00:00', '12:00:00', 2191, 843);
INSERT INTO public.employee_schedule VALUES (748, '2025-06-17', '07:00:00', '09:30:00', 2016, 844);
INSERT INTO public.employee_schedule VALUES (749, '2025-11-18', '16:00:00', '18:00:00', 3124, 845);
INSERT INTO public.employee_schedule VALUES (750, '2025-11-08', '13:00:00', '15:30:00', 1195, 846);
INSERT INTO public.employee_schedule VALUES (751, '2025-05-17', '16:00:00', '18:00:00', 2110, 848);
INSERT INTO public.employee_schedule VALUES (752, '2025-02-11', '16:00:00', '18:00:00', 1011, 849);
INSERT INTO public.employee_schedule VALUES (753, '2023-11-13', '10:00:00', '12:00:00', 1034, 850);
INSERT INTO public.employee_schedule VALUES (754, '2025-12-08', '13:00:00', '15:30:00', 1213, 851);
INSERT INTO public.employee_schedule VALUES (755, '2025-08-10', '10:00:00', '12:30:00', 2118, 852);
INSERT INTO public.employee_schedule VALUES (756, '2025-10-11', '07:00:00', '09:30:00', 1114, 853);
INSERT INTO public.employee_schedule VALUES (757, '2025-03-29', '13:00:00', '15:30:00', 1055, 854);
INSERT INTO public.employee_schedule VALUES (758, '2025-08-04', '16:00:00', '18:30:00', 3007, 855);
INSERT INTO public.employee_schedule VALUES (759, '2025-03-26', '07:00:00', '09:00:00', 1151, 856);
INSERT INTO public.employee_schedule VALUES (760, '2023-08-26', '13:00:00', '15:30:00', 2085, 857);
INSERT INTO public.employee_schedule VALUES (761, '2025-04-23', '07:00:00', '09:00:00', 1118, 858);
INSERT INTO public.employee_schedule VALUES (762, '2025-10-19', '10:00:00', '12:30:00', 1018, 859);
INSERT INTO public.employee_schedule VALUES (763, '2025-12-08', '07:00:00', '09:30:00', 3232, 860);
INSERT INTO public.employee_schedule VALUES (764, '2025-09-25', '16:00:00', '18:30:00', 1153, 861);
INSERT INTO public.employee_schedule VALUES (765, '2025-08-14', '16:00:00', '18:00:00', 2209, 862);
INSERT INTO public.employee_schedule VALUES (766, '2025-09-30', '13:00:00', '15:30:00', 1178, 863);
INSERT INTO public.employee_schedule VALUES (767, '2025-02-06', '10:00:00', '12:00:00', 1155, 864);
INSERT INTO public.employee_schedule VALUES (768, '2025-09-13', '13:00:00', '15:30:00', 3095, 865);
INSERT INTO public.employee_schedule VALUES (769, '2025-10-23', '10:00:00', '12:30:00', 3192, 867);
INSERT INTO public.employee_schedule VALUES (770, '2025-11-04', '10:00:00', '12:00:00', 1187, 868);
INSERT INTO public.employee_schedule VALUES (771, '2025-04-02', '16:00:00', '18:00:00', 2102, 869);
INSERT INTO public.employee_schedule VALUES (772, '2024-08-29', '07:00:00', '09:00:00', 1239, 870);
INSERT INTO public.employee_schedule VALUES (773, '2024-06-05', '13:00:00', '15:30:00', 1236, 871);
INSERT INTO public.employee_schedule VALUES (774, '2025-10-17', '07:00:00', '09:00:00', 1186, 872);
INSERT INTO public.employee_schedule VALUES (775, '2024-10-22', '16:00:00', '18:30:00', 1040, 873);
INSERT INTO public.employee_schedule VALUES (776, '2025-09-12', '16:00:00', '18:00:00', 1110, 874);
INSERT INTO public.employee_schedule VALUES (777, '2025-01-10', '10:00:00', '12:30:00', 1105, 875);
INSERT INTO public.employee_schedule VALUES (778, '2025-11-07', '10:00:00', '12:00:00', 2143, 876);
INSERT INTO public.employee_schedule VALUES (779, '2025-06-26', '07:00:00', '09:00:00', 2116, 877);
INSERT INTO public.employee_schedule VALUES (780, '2025-09-06', '16:00:00', '18:00:00', 3137, 878);
INSERT INTO public.employee_schedule VALUES (781, '2025-10-10', '16:00:00', '18:00:00', 3190, 879);
INSERT INTO public.employee_schedule VALUES (782, '2025-08-16', '10:00:00', '12:30:00', 3111, 880);
INSERT INTO public.employee_schedule VALUES (783, '2025-03-30', '13:00:00', '15:30:00', 3188, 881);
INSERT INTO public.employee_schedule VALUES (784, '2024-10-17', '16:00:00', '18:30:00', 2084, 882);
INSERT INTO public.employee_schedule VALUES (785, '2025-09-19', '07:00:00', '09:30:00', 3160, 883);
INSERT INTO public.employee_schedule VALUES (786, '2025-09-07', '16:00:00', '18:00:00', 2037, 884);
INSERT INTO public.employee_schedule VALUES (787, '2025-03-16', '13:00:00', '15:30:00', 2172, 885);
INSERT INTO public.employee_schedule VALUES (788, '2025-04-12', '16:00:00', '18:00:00', 1050, 886);
INSERT INTO public.employee_schedule VALUES (789, '2025-06-29', '13:00:00', '15:00:00', 3173, 888);
INSERT INTO public.employee_schedule VALUES (790, '2024-11-19', '16:00:00', '18:00:00', 1133, 889);
INSERT INTO public.employee_schedule VALUES (791, '2023-10-21', '07:00:00', '09:30:00', 1159, 890);
INSERT INTO public.employee_schedule VALUES (792, '2024-11-05', '16:00:00', '18:00:00', 3132, 891);
INSERT INTO public.employee_schedule VALUES (793, '2024-06-04', '16:00:00', '18:00:00', 3154, 892);
INSERT INTO public.employee_schedule VALUES (794, '2025-05-08', '16:00:00', '18:00:00', 1158, 894);
INSERT INTO public.employee_schedule VALUES (795, '2025-08-07', '10:00:00', '12:00:00', 1141, 895);
INSERT INTO public.employee_schedule VALUES (796, '2025-06-06', '07:00:00', '09:00:00', 3236, 896);
INSERT INTO public.employee_schedule VALUES (797, '2024-09-10', '13:00:00', '15:30:00', 2022, 897);
INSERT INTO public.employee_schedule VALUES (798, '2024-12-13', '10:00:00', '12:00:00', 2026, 898);
INSERT INTO public.employee_schedule VALUES (799, '2025-11-22', '10:00:00', '12:30:00', 3232, 899);
INSERT INTO public.employee_schedule VALUES (800, '2025-05-24', '10:00:00', '12:00:00', 3039, 900);
INSERT INTO public.employee_schedule VALUES (801, '2025-12-19', '07:00:00', '09:30:00', 2203, 901);
INSERT INTO public.employee_schedule VALUES (802, '2025-03-28', '07:00:00', '09:00:00', 1026, 902);
INSERT INTO public.employee_schedule VALUES (803, '2025-06-09', '16:00:00', '18:30:00', 1129, 903);
INSERT INTO public.employee_schedule VALUES (804, '2025-08-24', '10:00:00', '12:30:00', 3201, 904);
INSERT INTO public.employee_schedule VALUES (805, '2025-09-25', '13:00:00', '15:00:00', 1098, 905);
INSERT INTO public.employee_schedule VALUES (806, '2025-12-08', '13:00:00', '15:30:00', 3045, 906);
INSERT INTO public.employee_schedule VALUES (807, '2024-09-25', '10:00:00', '12:00:00', 3200, 909);
INSERT INTO public.employee_schedule VALUES (808, '2025-08-16', '07:00:00', '09:00:00', 2133, 910);
INSERT INTO public.employee_schedule VALUES (809, '2025-07-17', '16:00:00', '18:00:00', 2164, 911);
INSERT INTO public.employee_schedule VALUES (810, '2023-08-13', '13:00:00', '15:30:00', 2177, 912);
INSERT INTO public.employee_schedule VALUES (811, '2025-11-05', '16:00:00', '18:00:00', 2012, 913);
INSERT INTO public.employee_schedule VALUES (812, '2025-03-31', '10:00:00', '12:30:00', 1104, 915);
INSERT INTO public.employee_schedule VALUES (813, '2025-07-25', '13:00:00', '15:30:00', 3076, 916);
INSERT INTO public.employee_schedule VALUES (814, '2024-11-17', '10:00:00', '12:30:00', 2234, 917);
INSERT INTO public.employee_schedule VALUES (815, '2025-12-28', '16:00:00', '18:30:00', 1240, 918);
INSERT INTO public.employee_schedule VALUES (816, '2025-09-22', '16:00:00', '18:30:00', 2154, 919);
INSERT INTO public.employee_schedule VALUES (817, '2025-09-08', '10:00:00', '12:30:00', 1185, 920);
INSERT INTO public.employee_schedule VALUES (818, '2025-06-03', '07:00:00', '09:00:00', 2077, 921);
INSERT INTO public.employee_schedule VALUES (819, '2025-05-24', '07:00:00', '09:30:00', 1058, 923);
INSERT INTO public.employee_schedule VALUES (820, '2025-06-08', '16:00:00', '18:00:00', 3238, 924);
INSERT INTO public.employee_schedule VALUES (821, '2025-01-26', '16:00:00', '18:00:00', 2222, 925);
INSERT INTO public.employee_schedule VALUES (822, '2024-08-31', '13:00:00', '15:00:00', 1001, 926);
INSERT INTO public.employee_schedule VALUES (823, '2025-03-23', '16:00:00', '18:30:00', 2051, 927);
INSERT INTO public.employee_schedule VALUES (824, '2025-04-03', '13:00:00', '15:00:00', 3092, 928);
INSERT INTO public.employee_schedule VALUES (825, '2025-08-28', '16:00:00', '18:30:00', 3071, 931);
INSERT INTO public.employee_schedule VALUES (826, '2025-11-18', '10:00:00', '12:00:00', 2071, 932);
INSERT INTO public.employee_schedule VALUES (827, '2025-07-14', '13:00:00', '15:00:00', 3215, 933);
INSERT INTO public.employee_schedule VALUES (828, '2025-07-12', '16:00:00', '18:00:00', 3025, 934);
INSERT INTO public.employee_schedule VALUES (829, '2025-09-14', '10:00:00', '12:00:00', 1169, 935);
INSERT INTO public.employee_schedule VALUES (830, '2025-10-03', '13:00:00', '15:30:00', 3170, 936);
INSERT INTO public.employee_schedule VALUES (831, '2025-06-25', '07:00:00', '09:30:00', 2021, 937);
INSERT INTO public.employee_schedule VALUES (832, '2025-07-09', '10:00:00', '12:00:00', 2083, 938);
INSERT INTO public.employee_schedule VALUES (833, '2025-01-07', '16:00:00', '18:00:00', 3230, 939);
INSERT INTO public.employee_schedule VALUES (834, '2024-06-23', '16:00:00', '18:30:00', 1067, 940);
INSERT INTO public.employee_schedule VALUES (835, '2025-09-05', '13:00:00', '15:00:00', 2051, 941);
INSERT INTO public.employee_schedule VALUES (836, '2025-08-03', '13:00:00', '15:30:00', 3078, 942);
INSERT INTO public.employee_schedule VALUES (837, '2024-02-29', '16:00:00', '18:00:00', 1089, 943);
INSERT INTO public.employee_schedule VALUES (838, '2025-08-07', '13:00:00', '15:30:00', 3068, 944);
INSERT INTO public.employee_schedule VALUES (839, '2024-08-01', '10:00:00', '12:00:00', 1102, 945);
INSERT INTO public.employee_schedule VALUES (840, '2023-06-12', '13:00:00', '15:00:00', 1014, 946);
INSERT INTO public.employee_schedule VALUES (841, '2024-05-22', '13:00:00', '15:30:00', 1026, 947);
INSERT INTO public.employee_schedule VALUES (842, '2024-03-16', '10:00:00', '12:30:00', 1157, 948);
INSERT INTO public.employee_schedule VALUES (843, '2025-03-09', '10:00:00', '12:30:00', 3056, 949);
INSERT INTO public.employee_schedule VALUES (844, '2025-11-16', '10:00:00', '12:30:00', 1235, 950);
INSERT INTO public.employee_schedule VALUES (845, '2025-05-21', '16:00:00', '18:30:00', 1055, 951);
INSERT INTO public.employee_schedule VALUES (846, '2023-08-15', '16:00:00', '18:00:00', 2134, 952);
INSERT INTO public.employee_schedule VALUES (847, '2025-07-14', '16:00:00', '18:30:00', 2145, 953);
INSERT INTO public.employee_schedule VALUES (848, '2025-11-15', '13:00:00', '15:00:00', 3241, 954);
INSERT INTO public.employee_schedule VALUES (849, '2025-01-11', '13:00:00', '15:00:00', 1132, 955);
INSERT INTO public.employee_schedule VALUES (850, '2025-12-30', '13:00:00', '15:30:00', 1097, 957);
INSERT INTO public.employee_schedule VALUES (851, '2025-10-18', '16:00:00', '18:00:00', 2123, 958);
INSERT INTO public.employee_schedule VALUES (852, '2025-03-20', '10:00:00', '12:30:00', 2044, 959);
INSERT INTO public.employee_schedule VALUES (853, '2024-07-11', '16:00:00', '18:30:00', 2223, 960);
INSERT INTO public.employee_schedule VALUES (854, '2025-06-16', '13:00:00', '15:00:00', 3185, 961);
INSERT INTO public.employee_schedule VALUES (855, '2025-12-18', '16:00:00', '18:30:00', 1006, 962);
INSERT INTO public.employee_schedule VALUES (856, '2025-07-26', '07:00:00', '09:30:00', 2068, 963);
INSERT INTO public.employee_schedule VALUES (857, '2025-05-29', '07:00:00', '09:30:00', 1114, 964);
INSERT INTO public.employee_schedule VALUES (858, '2025-10-22', '10:00:00', '12:00:00', 1231, 965);
INSERT INTO public.employee_schedule VALUES (859, '2024-01-05', '13:00:00', '15:30:00', 3098, 966);
INSERT INTO public.employee_schedule VALUES (860, '2025-12-19', '07:00:00', '09:00:00', 3144, 967);
INSERT INTO public.employee_schedule VALUES (861, '2025-10-23', '13:00:00', '15:30:00', 3028, 968);
INSERT INTO public.employee_schedule VALUES (862, '2025-01-18', '16:00:00', '18:00:00', 1076, 970);
INSERT INTO public.employee_schedule VALUES (863, '2024-04-20', '07:00:00', '09:00:00', 2164, 971);
INSERT INTO public.employee_schedule VALUES (864, '2023-11-10', '16:00:00', '18:00:00', 3037, 974);
INSERT INTO public.employee_schedule VALUES (865, '2023-09-13', '16:00:00', '18:00:00', 1102, 975);
INSERT INTO public.employee_schedule VALUES (866, '2025-09-25', '07:00:00', '09:30:00', 3090, 976);
INSERT INTO public.employee_schedule VALUES (867, '2025-12-21', '10:00:00', '12:30:00', 2109, 977);
INSERT INTO public.employee_schedule VALUES (868, '2025-05-07', '13:00:00', '15:30:00', 2071, 978);
INSERT INTO public.employee_schedule VALUES (869, '2025-08-28', '07:00:00', '09:30:00', 1126, 979);
INSERT INTO public.employee_schedule VALUES (870, '2024-08-29', '16:00:00', '18:30:00', 2111, 980);
INSERT INTO public.employee_schedule VALUES (871, '2024-03-06', '13:00:00', '15:30:00', 2049, 982);
INSERT INTO public.employee_schedule VALUES (872, '2025-10-23', '13:00:00', '15:00:00', 2116, 983);
INSERT INTO public.employee_schedule VALUES (873, '2024-10-08', '10:00:00', '12:00:00', 3236, 984);
INSERT INTO public.employee_schedule VALUES (874, '2025-02-08', '13:00:00', '15:30:00', 2162, 985);
INSERT INTO public.employee_schedule VALUES (875, '2025-11-09', '13:00:00', '15:00:00', 3238, 986);
INSERT INTO public.employee_schedule VALUES (876, '2024-02-28', '07:00:00', '09:30:00', 2099, 987);
INSERT INTO public.employee_schedule VALUES (877, '2025-12-23', '07:00:00', '09:30:00', 1002, 988);
INSERT INTO public.employee_schedule VALUES (878, '2025-12-26', '16:00:00', '18:00:00', 3088, 989);
INSERT INTO public.employee_schedule VALUES (879, '2024-11-30', '10:00:00', '12:00:00', 3178, 990);
INSERT INTO public.employee_schedule VALUES (880, '2025-01-06', '07:00:00', '09:30:00', 2031, 991);
INSERT INTO public.employee_schedule VALUES (881, '2024-12-20', '13:00:00', '15:30:00', 1119, 992);
INSERT INTO public.employee_schedule VALUES (882, '2025-01-23', '07:00:00', '09:00:00', 3106, 993);
INSERT INTO public.employee_schedule VALUES (883, '2025-02-25', '16:00:00', '18:00:00', 1120, 994);
INSERT INTO public.employee_schedule VALUES (884, '2024-02-04', '10:00:00', '12:00:00', 1213, 995);
INSERT INTO public.employee_schedule VALUES (885, '2025-11-05', '10:00:00', '12:30:00', 1026, 996);
INSERT INTO public.employee_schedule VALUES (886, '2024-11-10', '13:00:00', '15:00:00', 2145, 997);
INSERT INTO public.employee_schedule VALUES (887, '2024-05-25', '10:00:00', '12:00:00', 2158, 998);
INSERT INTO public.employee_schedule VALUES (888, '2024-12-16', '10:00:00', '12:30:00', 1062, 999);
INSERT INTO public.employee_schedule VALUES (889, '2025-12-21', '16:00:00', '18:30:00', 2176, 1000);
INSERT INTO public.employee_schedule VALUES (890, '2024-01-19', '07:00:00', '09:30:00', 1103, 1001);
INSERT INTO public.employee_schedule VALUES (891, '2024-01-26', '13:00:00', '15:00:00', 1172, 1002);
INSERT INTO public.employee_schedule VALUES (892, '2023-10-18', '13:00:00', '15:00:00', 2152, 1003);
INSERT INTO public.employee_schedule VALUES (893, '2025-07-27', '16:00:00', '18:00:00', 2020, 1004);
INSERT INTO public.employee_schedule VALUES (894, '2024-03-14', '10:00:00', '12:30:00', 2200, 1005);
INSERT INTO public.employee_schedule VALUES (895, '2025-03-13', '16:00:00', '18:00:00', 1119, 1006);
INSERT INTO public.employee_schedule VALUES (896, '2025-05-26', '13:00:00', '15:30:00', 2034, 1007);
INSERT INTO public.employee_schedule VALUES (897, '2025-10-08', '10:00:00', '12:30:00', 2154, 1008);
INSERT INTO public.employee_schedule VALUES (898, '2023-10-05', '13:00:00', '15:30:00', 2194, 1009);
INSERT INTO public.employee_schedule VALUES (899, '2025-08-12', '13:00:00', '15:30:00', 3012, 1010);
INSERT INTO public.employee_schedule VALUES (900, '2025-06-07', '07:00:00', '09:30:00', 1171, 1012);
INSERT INTO public.employee_schedule VALUES (901, '2025-01-22', '07:00:00', '09:30:00', 3184, 1013);
INSERT INTO public.employee_schedule VALUES (902, '2024-08-13', '13:00:00', '15:00:00', 2084, 1014);
INSERT INTO public.employee_schedule VALUES (903, '2025-01-19', '13:00:00', '15:00:00', 1075, 1015);
INSERT INTO public.employee_schedule VALUES (904, '2025-08-19', '13:00:00', '15:00:00', 1176, 1016);
INSERT INTO public.employee_schedule VALUES (905, '2025-01-06', '10:00:00', '12:00:00', 1142, 1017);
INSERT INTO public.employee_schedule VALUES (906, '2023-09-04', '16:00:00', '18:00:00', 1085, 1018);
INSERT INTO public.employee_schedule VALUES (907, '2025-02-09', '16:00:00', '18:30:00', 3164, 1019);
INSERT INTO public.employee_schedule VALUES (908, '2025-05-14', '13:00:00', '15:00:00', 3018, 1020);
INSERT INTO public.employee_schedule VALUES (909, '2025-02-24', '10:00:00', '12:30:00', 3238, 1021);
INSERT INTO public.employee_schedule VALUES (910, '2025-03-02', '07:00:00', '09:00:00', 3140, 1023);
INSERT INTO public.employee_schedule VALUES (911, '2025-09-19', '16:00:00', '18:30:00', 1019, 1024);
INSERT INTO public.employee_schedule VALUES (912, '2025-12-02', '13:00:00', '15:30:00', 3195, 1027);
INSERT INTO public.employee_schedule VALUES (913, '2024-09-19', '16:00:00', '18:00:00', 1100, 1028);
INSERT INTO public.employee_schedule VALUES (914, '2025-11-04', '13:00:00', '15:00:00', 1144, 1029);
INSERT INTO public.employee_schedule VALUES (915, '2025-08-20', '13:00:00', '15:00:00', 1219, 1030);
INSERT INTO public.employee_schedule VALUES (916, '2025-11-11', '13:00:00', '15:00:00', 3037, 1031);
INSERT INTO public.employee_schedule VALUES (917, '2025-03-03', '16:00:00', '18:30:00', 1125, 1032);
INSERT INTO public.employee_schedule VALUES (918, '2025-12-27', '13:00:00', '15:00:00', 2028, 1033);
INSERT INTO public.employee_schedule VALUES (919, '2023-12-12', '07:00:00', '09:00:00', 2161, 1035);
INSERT INTO public.employee_schedule VALUES (920, '2026-01-01', '07:00:00', '09:00:00', 1096, 1038);
INSERT INTO public.employee_schedule VALUES (921, '2025-08-08', '07:00:00', '09:30:00', 2127, 1039);
INSERT INTO public.employee_schedule VALUES (922, '2024-06-07', '13:00:00', '15:00:00', 2185, 1040);
INSERT INTO public.employee_schedule VALUES (923, '2024-09-28', '07:00:00', '09:30:00', 1243, 1041);
INSERT INTO public.employee_schedule VALUES (924, '2025-12-29', '07:00:00', '09:00:00', 1181, 1042);
INSERT INTO public.employee_schedule VALUES (925, '2025-07-06', '16:00:00', '18:30:00', 3158, 1043);
INSERT INTO public.employee_schedule VALUES (926, '2023-11-21', '13:00:00', '15:00:00', 2143, 1044);
INSERT INTO public.employee_schedule VALUES (927, '2025-05-07', '13:00:00', '15:00:00', 1081, 1045);
INSERT INTO public.employee_schedule VALUES (928, '2025-07-08', '10:00:00', '12:30:00', 1111, 1046);
INSERT INTO public.employee_schedule VALUES (929, '2024-10-10', '07:00:00', '09:30:00', 2239, 1047);
INSERT INTO public.employee_schedule VALUES (930, '2025-12-06', '07:00:00', '09:00:00', 1036, 1048);
INSERT INTO public.employee_schedule VALUES (931, '2023-11-04', '13:00:00', '15:30:00', 1107, 1049);
INSERT INTO public.employee_schedule VALUES (932, '2024-05-02', '10:00:00', '12:30:00', 1067, 1050);
INSERT INTO public.employee_schedule VALUES (933, '2024-06-21', '07:00:00', '09:30:00', 1194, 1051);
INSERT INTO public.employee_schedule VALUES (934, '2025-07-31', '10:00:00', '12:00:00', 3160, 1052);
INSERT INTO public.employee_schedule VALUES (935, '2025-10-27', '07:00:00', '09:30:00', 1227, 1053);
INSERT INTO public.employee_schedule VALUES (936, '2024-10-19', '10:00:00', '12:30:00', 2006, 1054);
INSERT INTO public.employee_schedule VALUES (937, '2025-08-28', '07:00:00', '09:00:00', 3078, 1055);
INSERT INTO public.employee_schedule VALUES (938, '2025-07-16', '07:00:00', '09:00:00', 1046, 1056);
INSERT INTO public.employee_schedule VALUES (939, '2025-11-12', '10:00:00', '12:30:00', 3043, 1057);
INSERT INTO public.employee_schedule VALUES (940, '2025-02-19', '10:00:00', '12:00:00', 2025, 1059);
INSERT INTO public.employee_schedule VALUES (941, '2024-10-18', '13:00:00', '15:00:00', 1180, 1060);
INSERT INTO public.employee_schedule VALUES (942, '2025-09-03', '10:00:00', '12:00:00', 2017, 1061);
INSERT INTO public.employee_schedule VALUES (943, '2025-07-21', '07:00:00', '09:00:00', 2030, 1062);
INSERT INTO public.employee_schedule VALUES (944, '2025-05-29', '10:00:00', '12:00:00', 1169, 1063);
INSERT INTO public.employee_schedule VALUES (945, '2025-07-04', '07:00:00', '09:00:00', 3041, 1064);
INSERT INTO public.employee_schedule VALUES (946, '2025-12-24', '07:00:00', '09:30:00', 3195, 1065);
INSERT INTO public.employee_schedule VALUES (947, '2024-10-29', '13:00:00', '15:00:00', 3238, 1066);
INSERT INTO public.employee_schedule VALUES (948, '2025-12-19', '07:00:00', '09:00:00', 3047, 1067);
INSERT INTO public.employee_schedule VALUES (949, '2025-03-06', '10:00:00', '12:30:00', 1095, 1068);
INSERT INTO public.employee_schedule VALUES (950, '2025-04-10', '16:00:00', '18:00:00', 2196, 1069);
INSERT INTO public.employee_schedule VALUES (951, '2025-11-03', '13:00:00', '15:00:00', 2173, 1070);
INSERT INTO public.employee_schedule VALUES (952, '2024-09-04', '13:00:00', '15:00:00', 3067, 1072);
INSERT INTO public.employee_schedule VALUES (953, '2024-12-15', '13:00:00', '15:00:00', 2107, 1073);
INSERT INTO public.employee_schedule VALUES (954, '2025-11-09', '10:00:00', '12:00:00', 2043, 1074);
INSERT INTO public.employee_schedule VALUES (955, '2025-09-07', '16:00:00', '18:30:00', 1060, 1075);
INSERT INTO public.employee_schedule VALUES (956, '2025-07-24', '07:00:00', '09:00:00', 1020, 1077);
INSERT INTO public.employee_schedule VALUES (957, '2024-08-22', '10:00:00', '12:30:00', 2187, 1078);
INSERT INTO public.employee_schedule VALUES (958, '2025-05-01', '13:00:00', '15:00:00', 2176, 1079);
INSERT INTO public.employee_schedule VALUES (959, '2025-07-16', '16:00:00', '18:00:00', 1126, 1080);
INSERT INTO public.employee_schedule VALUES (960, '2024-08-13', '10:00:00', '12:30:00', 1140, 1081);
INSERT INTO public.employee_schedule VALUES (961, '2025-01-21', '07:00:00', '09:30:00', 2212, 1082);
INSERT INTO public.employee_schedule VALUES (962, '2024-12-23', '07:00:00', '09:30:00', 1160, 1083);
INSERT INTO public.employee_schedule VALUES (963, '2025-08-12', '13:00:00', '15:30:00', 2103, 1084);
INSERT INTO public.employee_schedule VALUES (964, '2025-11-12', '07:00:00', '09:30:00', 1102, 1085);
INSERT INTO public.employee_schedule VALUES (965, '2025-08-24', '07:00:00', '09:00:00', 3223, 1086);
INSERT INTO public.employee_schedule VALUES (966, '2025-12-11', '16:00:00', '18:00:00', 3208, 1087);
INSERT INTO public.employee_schedule VALUES (967, '2024-04-12', '07:00:00', '09:00:00', 3150, 1088);
INSERT INTO public.employee_schedule VALUES (968, '2025-08-29', '07:00:00', '09:00:00', 3107, 1089);
INSERT INTO public.employee_schedule VALUES (969, '2025-06-30', '13:00:00', '15:00:00', 2099, 1090);
INSERT INTO public.employee_schedule VALUES (970, '2025-09-01', '07:00:00', '09:00:00', 1054, 1091);
INSERT INTO public.employee_schedule VALUES (971, '2024-01-10', '16:00:00', '18:30:00', 2060, 1092);
INSERT INTO public.employee_schedule VALUES (972, '2024-04-11', '13:00:00', '15:30:00', 1178, 1094);
INSERT INTO public.employee_schedule VALUES (973, '2025-09-10', '10:00:00', '12:30:00', 2005, 1095);
INSERT INTO public.employee_schedule VALUES (974, '2025-09-12', '07:00:00', '09:30:00', 2204, 1096);
INSERT INTO public.employee_schedule VALUES (975, '2025-02-09', '13:00:00', '15:30:00', 1133, 1097);
INSERT INTO public.employee_schedule VALUES (976, '2025-07-13', '10:00:00', '12:00:00', 2090, 1098);
INSERT INTO public.employee_schedule VALUES (977, '2024-08-30', '07:00:00', '09:00:00', 1070, 1099);
INSERT INTO public.employee_schedule VALUES (978, '2025-06-05', '10:00:00', '12:00:00', 3230, 1100);
INSERT INTO public.employee_schedule VALUES (979, '2025-08-19', '13:00:00', '15:00:00', 1218, 1101);
INSERT INTO public.employee_schedule VALUES (980, '2024-02-23', '10:00:00', '12:30:00', 1200, 1103);
INSERT INTO public.employee_schedule VALUES (981, '2024-05-30', '10:00:00', '12:00:00', 2063, 1105);
INSERT INTO public.employee_schedule VALUES (982, '2025-07-28', '07:00:00', '09:00:00', 3147, 1106);
INSERT INTO public.employee_schedule VALUES (983, '2025-06-03', '16:00:00', '18:00:00', 3192, 1107);
INSERT INTO public.employee_schedule VALUES (984, '2024-04-25', '07:00:00', '09:00:00', 3068, 1108);
INSERT INTO public.employee_schedule VALUES (985, '2025-02-28', '13:00:00', '15:00:00', 1201, 1109);
INSERT INTO public.employee_schedule VALUES (986, '2023-07-16', '07:00:00', '09:30:00', 2222, 1110);
INSERT INTO public.employee_schedule VALUES (987, '2025-08-13', '07:00:00', '09:00:00', 1167, 1111);
INSERT INTO public.employee_schedule VALUES (988, '2024-11-10', '07:00:00', '09:00:00', 1152, 1112);
INSERT INTO public.employee_schedule VALUES (989, '2024-05-22', '13:00:00', '15:00:00', 2045, 1113);
INSERT INTO public.employee_schedule VALUES (990, '2025-09-24', '07:00:00', '09:30:00', 3020, 1114);
INSERT INTO public.employee_schedule VALUES (991, '2025-06-29', '13:00:00', '15:30:00', 1169, 1115);
INSERT INTO public.employee_schedule VALUES (992, '2025-06-20', '07:00:00', '09:30:00', 3233, 1116);
INSERT INTO public.employee_schedule VALUES (993, '2025-07-29', '13:00:00', '15:30:00', 2111, 1118);
INSERT INTO public.employee_schedule VALUES (994, '2025-03-19', '13:00:00', '15:30:00', 1132, 1119);
INSERT INTO public.employee_schedule VALUES (995, '2025-08-12', '16:00:00', '18:00:00', 3116, 1120);
INSERT INTO public.employee_schedule VALUES (996, '2025-08-16', '10:00:00', '12:00:00', 1069, 1121);
INSERT INTO public.employee_schedule VALUES (997, '2025-05-20', '16:00:00', '18:00:00', 3007, 1122);
INSERT INTO public.employee_schedule VALUES (998, '2024-08-12', '16:00:00', '18:30:00', 3153, 1123);
INSERT INTO public.employee_schedule VALUES (999, '2024-06-22', '16:00:00', '18:30:00', 2176, 1125);
INSERT INTO public.employee_schedule VALUES (1000, '2025-06-14', '13:00:00', '15:30:00', 1072, 1126);
INSERT INTO public.employee_schedule VALUES (1001, '2025-04-26', '07:00:00', '09:00:00', 1029, 1127);
INSERT INTO public.employee_schedule VALUES (1002, '2025-02-15', '10:00:00', '12:30:00', 1150, 1128);
INSERT INTO public.employee_schedule VALUES (1003, '2024-10-14', '13:00:00', '15:00:00', 3073, 1129);
INSERT INTO public.employee_schedule VALUES (1004, '2023-08-11', '16:00:00', '18:30:00', 3028, 1130);
INSERT INTO public.employee_schedule VALUES (1005, '2025-10-28', '13:00:00', '15:00:00', 2026, 1131);
INSERT INTO public.employee_schedule VALUES (1006, '2025-10-26', '07:00:00', '09:00:00', 2195, 1132);
INSERT INTO public.employee_schedule VALUES (1007, '2025-11-29', '10:00:00', '12:00:00', 2179, 1133);
INSERT INTO public.employee_schedule VALUES (1008, '2025-11-07', '10:00:00', '12:30:00', 1046, 1134);
INSERT INTO public.employee_schedule VALUES (1009, '2025-04-15', '16:00:00', '18:30:00', 2131, 1135);
INSERT INTO public.employee_schedule VALUES (1010, '2024-04-03', '16:00:00', '18:00:00', 2036, 1136);
INSERT INTO public.employee_schedule VALUES (1011, '2025-05-22', '07:00:00', '09:00:00', 1178, 1138);
INSERT INTO public.employee_schedule VALUES (1012, '2025-11-28', '07:00:00', '09:00:00', 2161, 1140);
INSERT INTO public.employee_schedule VALUES (1013, '2025-06-09', '13:00:00', '15:00:00', 1153, 1141);
INSERT INTO public.employee_schedule VALUES (1014, '2025-10-07', '13:00:00', '15:30:00', 3060, 1142);
INSERT INTO public.employee_schedule VALUES (1015, '2025-07-21', '13:00:00', '15:30:00', 2090, 1143);
INSERT INTO public.employee_schedule VALUES (1016, '2025-05-11', '07:00:00', '09:30:00', 2116, 1144);
INSERT INTO public.employee_schedule VALUES (1017, '2024-12-22', '16:00:00', '18:00:00', 1128, 1145);
INSERT INTO public.employee_schedule VALUES (1018, '2025-11-19', '16:00:00', '18:30:00', 2199, 1147);
INSERT INTO public.employee_schedule VALUES (1019, '2025-09-22', '13:00:00', '15:00:00', 2189, 1148);
INSERT INTO public.employee_schedule VALUES (1020, '2024-05-24', '10:00:00', '12:30:00', 2229, 1149);
INSERT INTO public.employee_schedule VALUES (1021, '2024-01-12', '10:00:00', '12:30:00', 2134, 1150);
INSERT INTO public.employee_schedule VALUES (1022, '2025-11-28', '07:00:00', '09:00:00', 2200, 1151);
INSERT INTO public.employee_schedule VALUES (1023, '2025-09-14', '16:00:00', '18:30:00', 1238, 1152);
INSERT INTO public.employee_schedule VALUES (1024, '2025-10-10', '07:00:00', '09:30:00', 1138, 1153);
INSERT INTO public.employee_schedule VALUES (1025, '2024-12-24', '07:00:00', '09:30:00', 3210, 1155);
INSERT INTO public.employee_schedule VALUES (1026, '2024-09-14', '13:00:00', '15:00:00', 3082, 1156);
INSERT INTO public.employee_schedule VALUES (1027, '2025-04-10', '13:00:00', '15:30:00', 3115, 1157);
INSERT INTO public.employee_schedule VALUES (1028, '2025-08-09', '10:00:00', '12:30:00', 2088, 1158);
INSERT INTO public.employee_schedule VALUES (1029, '2025-05-10', '07:00:00', '09:30:00', 1029, 1159);
INSERT INTO public.employee_schedule VALUES (1030, '2025-01-19', '13:00:00', '15:00:00', 3208, 1160);
INSERT INTO public.employee_schedule VALUES (1031, '2025-10-22', '10:00:00', '12:00:00', 2195, 1161);
INSERT INTO public.employee_schedule VALUES (1032, '2025-01-23', '07:00:00', '09:00:00', 1037, 1162);
INSERT INTO public.employee_schedule VALUES (1033, '2023-04-05', '16:00:00', '18:00:00', 3165, 1163);
INSERT INTO public.employee_schedule VALUES (1034, '2025-10-07', '10:00:00', '12:00:00', 3140, 1164);
INSERT INTO public.employee_schedule VALUES (1035, '2025-07-31', '10:00:00', '12:00:00', 3021, 1165);
INSERT INTO public.employee_schedule VALUES (1036, '2024-09-24', '10:00:00', '12:00:00', 2037, 1166);
INSERT INTO public.employee_schedule VALUES (1037, '2025-10-22', '10:00:00', '12:30:00', 2044, 1167);
INSERT INTO public.employee_schedule VALUES (1038, '2024-07-20', '10:00:00', '12:30:00', 3119, 1168);
INSERT INTO public.employee_schedule VALUES (1039, '2025-04-27', '16:00:00', '18:30:00', 2018, 1169);
INSERT INTO public.employee_schedule VALUES (1040, '2025-03-24', '10:00:00', '12:00:00', 1154, 1170);
INSERT INTO public.employee_schedule VALUES (1041, '2024-06-17', '13:00:00', '15:00:00', 2206, 1172);
INSERT INTO public.employee_schedule VALUES (1042, '2025-03-03', '07:00:00', '09:00:00', 1202, 1173);
INSERT INTO public.employee_schedule VALUES (1043, '2025-04-28', '07:00:00', '09:00:00', 1027, 1174);
INSERT INTO public.employee_schedule VALUES (1044, '2025-10-07', '07:00:00', '09:30:00', 3199, 1175);
INSERT INTO public.employee_schedule VALUES (1045, '2025-06-04', '13:00:00', '15:00:00', 2030, 1176);
INSERT INTO public.employee_schedule VALUES (1046, '2025-05-17', '07:00:00', '09:00:00', 3171, 1177);
INSERT INTO public.employee_schedule VALUES (1047, '2025-03-02', '07:00:00', '09:00:00', 3090, 1178);
INSERT INTO public.employee_schedule VALUES (1048, '2025-05-10', '16:00:00', '18:00:00', 3207, 1179);
INSERT INTO public.employee_schedule VALUES (1049, '2024-09-20', '16:00:00', '18:00:00', 2173, 1180);
INSERT INTO public.employee_schedule VALUES (1050, '2025-07-03', '13:00:00', '15:00:00', 2196, 1181);
INSERT INTO public.employee_schedule VALUES (1051, '2025-04-10', '13:00:00', '15:30:00', 2129, 1182);
INSERT INTO public.employee_schedule VALUES (1052, '2025-10-07', '10:00:00', '12:00:00', 3130, 1184);
INSERT INTO public.employee_schedule VALUES (1053, '2025-02-03', '13:00:00', '15:00:00', 3237, 1185);
INSERT INTO public.employee_schedule VALUES (1054, '2025-05-10', '10:00:00', '12:00:00', 3118, 1187);
INSERT INTO public.employee_schedule VALUES (1055, '2025-10-26', '13:00:00', '15:00:00', 2191, 1188);
INSERT INTO public.employee_schedule VALUES (1056, '2025-09-20', '13:00:00', '15:00:00', 3217, 1189);
INSERT INTO public.employee_schedule VALUES (1057, '2025-02-05', '07:00:00', '09:00:00', 3150, 1190);
INSERT INTO public.employee_schedule VALUES (1058, '2024-07-14', '13:00:00', '15:00:00', 1017, 1191);
INSERT INTO public.employee_schedule VALUES (1059, '2025-10-08', '07:00:00', '09:30:00', 3044, 1192);
INSERT INTO public.employee_schedule VALUES (1060, '2024-10-02', '07:00:00', '09:30:00', 1232, 1193);
INSERT INTO public.employee_schedule VALUES (1061, '2023-12-04', '07:00:00', '09:30:00', 2057, 1194);
INSERT INTO public.employee_schedule VALUES (1062, '2024-07-01', '10:00:00', '12:00:00', 2193, 1195);
INSERT INTO public.employee_schedule VALUES (1063, '2025-08-31', '10:00:00', '12:30:00', 2153, 1196);
INSERT INTO public.employee_schedule VALUES (1064, '2023-10-12', '13:00:00', '15:30:00', 1096, 1197);
INSERT INTO public.employee_schedule VALUES (1065, '2025-08-11', '10:00:00', '12:00:00', 1044, 1198);
INSERT INTO public.employee_schedule VALUES (1066, '2025-11-04', '16:00:00', '18:00:00', 1161, 1199);
INSERT INTO public.employee_schedule VALUES (1067, '2025-09-15', '10:00:00', '12:30:00', 1029, 1200);
INSERT INTO public.employee_schedule VALUES (1068, '2025-03-24', '10:00:00', '12:00:00', 3113, 1201);
INSERT INTO public.employee_schedule VALUES (1069, '2025-08-10', '13:00:00', '15:30:00', 2162, 1202);
INSERT INTO public.employee_schedule VALUES (1070, '2025-10-16', '13:00:00', '15:00:00', 3166, 1203);
INSERT INTO public.employee_schedule VALUES (1071, '2025-06-11', '13:00:00', '15:30:00', 1108, 1204);
INSERT INTO public.employee_schedule VALUES (1072, '2025-10-28', '07:00:00', '09:30:00', 2190, 1205);
INSERT INTO public.employee_schedule VALUES (1073, '2025-06-03', '16:00:00', '18:00:00', 3210, 1206);
INSERT INTO public.employee_schedule VALUES (1074, '2023-09-26', '07:00:00', '09:30:00', 3108, 1207);
INSERT INTO public.employee_schedule VALUES (1075, '2025-04-25', '07:00:00', '09:30:00', 1184, 1208);
INSERT INTO public.employee_schedule VALUES (1076, '2025-12-22', '07:00:00', '09:00:00', 2201, 1209);
INSERT INTO public.employee_schedule VALUES (1077, '2024-04-17', '10:00:00', '12:00:00', 3069, 1210);
INSERT INTO public.employee_schedule VALUES (1078, '2025-12-23', '16:00:00', '18:30:00', 3031, 1211);
INSERT INTO public.employee_schedule VALUES (1079, '2025-08-01', '07:00:00', '09:30:00', 2170, 1212);
INSERT INTO public.employee_schedule VALUES (1080, '2025-05-03', '10:00:00', '12:00:00', 1147, 1213);
INSERT INTO public.employee_schedule VALUES (1081, '2024-11-03', '13:00:00', '15:30:00', 1200, 1214);
INSERT INTO public.employee_schedule VALUES (1082, '2025-11-29', '16:00:00', '18:30:00', 1036, 1215);
INSERT INTO public.employee_schedule VALUES (1083, '2024-12-08', '13:00:00', '15:30:00', 1192, 1216);
INSERT INTO public.employee_schedule VALUES (1084, '2025-11-19', '16:00:00', '18:00:00', 3169, 1218);
INSERT INTO public.employee_schedule VALUES (1085, '2025-05-11', '16:00:00', '18:00:00', 3082, 1220);
INSERT INTO public.employee_schedule VALUES (1086, '2024-09-26', '16:00:00', '18:30:00', 3094, 1221);
INSERT INTO public.employee_schedule VALUES (1087, '2025-04-03', '07:00:00', '09:30:00', 3173, 1222);
INSERT INTO public.employee_schedule VALUES (1088, '2025-02-05', '16:00:00', '18:00:00', 3203, 1223);
INSERT INTO public.employee_schedule VALUES (1089, '2024-04-10', '13:00:00', '15:30:00', 3123, 1224);
INSERT INTO public.employee_schedule VALUES (1090, '2025-01-17', '10:00:00', '12:00:00', 2140, 1225);
INSERT INTO public.employee_schedule VALUES (1091, '2025-07-25', '16:00:00', '18:30:00', 3116, 1226);
INSERT INTO public.employee_schedule VALUES (1092, '2025-10-08', '16:00:00', '18:00:00', 1059, 1227);
INSERT INTO public.employee_schedule VALUES (1093, '2024-09-23', '16:00:00', '18:30:00', 3205, 1228);
INSERT INTO public.employee_schedule VALUES (1094, '2025-01-19', '10:00:00', '12:00:00', 3240, 1230);
INSERT INTO public.employee_schedule VALUES (1095, '2025-07-17', '07:00:00', '09:00:00', 2104, 1231);
INSERT INTO public.employee_schedule VALUES (1096, '2024-05-14', '07:00:00', '09:00:00', 3075, 1232);
INSERT INTO public.employee_schedule VALUES (1097, '2025-10-02', '10:00:00', '12:30:00', 2026, 1233);
INSERT INTO public.employee_schedule VALUES (1098, '2024-04-14', '16:00:00', '18:30:00', 1214, 1234);
INSERT INTO public.employee_schedule VALUES (1099, '2025-08-19', '07:00:00', '09:00:00', 2031, 1235);
INSERT INTO public.employee_schedule VALUES (1100, '2024-10-17', '07:00:00', '09:30:00', 2142, 1236);
INSERT INTO public.employee_schedule VALUES (1101, '2025-02-02', '07:00:00', '09:30:00', 1181, 1237);
INSERT INTO public.employee_schedule VALUES (1102, '2025-10-20', '07:00:00', '09:30:00', 1198, 1238);
INSERT INTO public.employee_schedule VALUES (1103, '2025-11-08', '07:00:00', '09:00:00', 2203, 1239);
INSERT INTO public.employee_schedule VALUES (1104, '2025-05-24', '10:00:00', '12:30:00', 2128, 1240);
INSERT INTO public.employee_schedule VALUES (1105, '2025-06-06', '07:00:00', '09:30:00', 2145, 1241);
INSERT INTO public.employee_schedule VALUES (1106, '2025-04-12', '13:00:00', '15:00:00', 1092, 1243);
INSERT INTO public.employee_schedule VALUES (1107, '2024-01-21', '16:00:00', '18:30:00', 2129, 1244);
INSERT INTO public.employee_schedule VALUES (1108, '2024-09-29', '16:00:00', '18:00:00', 2052, 1245);
INSERT INTO public.employee_schedule VALUES (1109, '2025-06-12', '10:00:00', '12:30:00', 2079, 1246);
INSERT INTO public.employee_schedule VALUES (1110, '2025-04-30', '07:00:00', '09:00:00', 3120, 1247);
INSERT INTO public.employee_schedule VALUES (1111, '2024-05-05', '13:00:00', '15:00:00', 3201, 1248);
INSERT INTO public.employee_schedule VALUES (1112, '2025-02-27', '07:00:00', '09:00:00', 3077, 1249);
INSERT INTO public.employee_schedule VALUES (1113, '2025-10-26', '10:00:00', '12:30:00', 2033, 1251);
INSERT INTO public.employee_schedule VALUES (1114, '2024-07-17', '13:00:00', '15:00:00', 2044, 1252);
INSERT INTO public.employee_schedule VALUES (1115, '2024-09-07', '16:00:00', '18:00:00', 3141, 1253);
INSERT INTO public.employee_schedule VALUES (1116, '2025-03-03', '16:00:00', '18:00:00', 1119, 1254);
INSERT INTO public.employee_schedule VALUES (1117, '2025-09-26', '16:00:00', '18:30:00', 1239, 1255);
INSERT INTO public.employee_schedule VALUES (1118, '2024-08-15', '10:00:00', '12:30:00', 1013, 1256);
INSERT INTO public.employee_schedule VALUES (1119, '2024-11-26', '10:00:00', '12:30:00', 2055, 1257);
INSERT INTO public.employee_schedule VALUES (1120, '2025-11-16', '16:00:00', '18:00:00', 1188, 1258);
INSERT INTO public.employee_schedule VALUES (1121, '2023-12-04', '13:00:00', '15:00:00', 3112, 1259);
INSERT INTO public.employee_schedule VALUES (1122, '2025-08-16', '07:00:00', '09:00:00', 1220, 1260);
INSERT INTO public.employee_schedule VALUES (1123, '2025-06-05', '16:00:00', '18:30:00', 1098, 1261);
INSERT INTO public.employee_schedule VALUES (1124, '2025-11-19', '13:00:00', '15:00:00', 2176, 1262);
INSERT INTO public.employee_schedule VALUES (1125, '2024-07-24', '07:00:00', '09:00:00', 3135, 1263);
INSERT INTO public.employee_schedule VALUES (1126, '2025-04-25', '10:00:00', '12:00:00', 1125, 1264);
INSERT INTO public.employee_schedule VALUES (1127, '2024-12-29', '16:00:00', '18:00:00', 3119, 1265);
INSERT INTO public.employee_schedule VALUES (1128, '2025-06-27', '13:00:00', '15:30:00', 3001, 1266);
INSERT INTO public.employee_schedule VALUES (1129, '2025-02-23', '13:00:00', '15:30:00', 3151, 1267);
INSERT INTO public.employee_schedule VALUES (1130, '2025-04-05', '16:00:00', '18:00:00', 3204, 1268);
INSERT INTO public.employee_schedule VALUES (1131, '2025-08-09', '16:00:00', '18:30:00', 1210, 1269);
INSERT INTO public.employee_schedule VALUES (1132, '2024-05-23', '13:00:00', '15:00:00', 1154, 1270);
INSERT INTO public.employee_schedule VALUES (1133, '2025-12-25', '07:00:00', '09:00:00', 2005, 1271);
INSERT INTO public.employee_schedule VALUES (1134, '2025-09-05', '10:00:00', '12:30:00', 2017, 1273);
INSERT INTO public.employee_schedule VALUES (1135, '2025-06-02', '10:00:00', '12:00:00', 2224, 1275);
INSERT INTO public.employee_schedule VALUES (1136, '2025-09-29', '16:00:00', '18:30:00', 1054, 1276);
INSERT INTO public.employee_schedule VALUES (1137, '2025-10-15', '13:00:00', '15:30:00', 1234, 1277);
INSERT INTO public.employee_schedule VALUES (1138, '2025-12-30', '13:00:00', '15:30:00', 2182, 1278);
INSERT INTO public.employee_schedule VALUES (1139, '2025-06-15', '10:00:00', '12:30:00', 2223, 1279);
INSERT INTO public.employee_schedule VALUES (1140, '2025-11-01', '10:00:00', '12:30:00', 1089, 1280);
INSERT INTO public.employee_schedule VALUES (1141, '2025-06-30', '07:00:00', '09:00:00', 3059, 1281);
INSERT INTO public.employee_schedule VALUES (1142, '2025-07-12', '07:00:00', '09:30:00', 1004, 1282);
INSERT INTO public.employee_schedule VALUES (1143, '2024-09-30', '16:00:00', '18:30:00', 1066, 1283);
INSERT INTO public.employee_schedule VALUES (1144, '2025-05-19', '07:00:00', '09:00:00', 2189, 1285);
INSERT INTO public.employee_schedule VALUES (1145, '2025-01-07', '16:00:00', '18:00:00', 2065, 1286);
INSERT INTO public.employee_schedule VALUES (1146, '2025-09-28', '10:00:00', '12:30:00', 3170, 1287);
INSERT INTO public.employee_schedule VALUES (1147, '2025-10-12', '10:00:00', '12:30:00', 2208, 1288);
INSERT INTO public.employee_schedule VALUES (1148, '2023-10-11', '13:00:00', '15:00:00', 3007, 1289);
INSERT INTO public.employee_schedule VALUES (1149, '2023-10-23', '07:00:00', '09:00:00', 2056, 1290);
INSERT INTO public.employee_schedule VALUES (1150, '2024-06-22', '10:00:00', '12:30:00', 2116, 1291);
INSERT INTO public.employee_schedule VALUES (1151, '2024-01-31', '07:00:00', '09:30:00', 3028, 1292);
INSERT INTO public.employee_schedule VALUES (1152, '2025-12-01', '07:00:00', '09:00:00', 2226, 1293);
INSERT INTO public.employee_schedule VALUES (1153, '2024-07-03', '16:00:00', '18:30:00', 1235, 1294);
INSERT INTO public.employee_schedule VALUES (1154, '2024-09-02', '07:00:00', '09:30:00', 3211, 1295);
INSERT INTO public.employee_schedule VALUES (1155, '2024-12-03', '10:00:00', '12:30:00', 3120, 1296);
INSERT INTO public.employee_schedule VALUES (1156, '2024-03-23', '07:00:00', '09:00:00', 2189, 1297);
INSERT INTO public.employee_schedule VALUES (1157, '2025-07-27', '07:00:00', '09:30:00', 3075, 1298);
INSERT INTO public.employee_schedule VALUES (1158, '2025-07-20', '16:00:00', '18:30:00', 1042, 1299);
INSERT INTO public.employee_schedule VALUES (1159, '2024-04-07', '07:00:00', '09:00:00', 1230, 1300);
INSERT INTO public.employee_schedule VALUES (1160, '2025-10-27', '13:00:00', '15:00:00', 2113, 1302);
INSERT INTO public.employee_schedule VALUES (1161, '2025-05-18', '07:00:00', '09:00:00', 1209, 1303);
INSERT INTO public.employee_schedule VALUES (1162, '2025-10-01', '16:00:00', '18:00:00', 1030, 1306);
INSERT INTO public.employee_schedule VALUES (1163, '2024-03-09', '07:00:00', '09:00:00', 3231, 1307);
INSERT INTO public.employee_schedule VALUES (1164, '2025-10-04', '13:00:00', '15:00:00', 3192, 1308);
INSERT INTO public.employee_schedule VALUES (1165, '2025-04-15', '13:00:00', '15:00:00', 3047, 1309);
INSERT INTO public.employee_schedule VALUES (1166, '2025-12-16', '13:00:00', '15:00:00', 1227, 1310);
INSERT INTO public.employee_schedule VALUES (1167, '2024-08-11', '07:00:00', '09:00:00', 1106, 1311);
INSERT INTO public.employee_schedule VALUES (1168, '2024-04-25', '07:00:00', '09:30:00', 2086, 1312);
INSERT INTO public.employee_schedule VALUES (1169, '2025-08-24', '13:00:00', '15:00:00', 2173, 1313);
INSERT INTO public.employee_schedule VALUES (1170, '2024-12-10', '13:00:00', '15:30:00', 3199, 1314);
INSERT INTO public.employee_schedule VALUES (1171, '2025-06-27', '10:00:00', '12:00:00', 3235, 1315);
INSERT INTO public.employee_schedule VALUES (1172, '2023-04-30', '10:00:00', '12:30:00', 1021, 1316);
INSERT INTO public.employee_schedule VALUES (1173, '2025-09-08', '07:00:00', '09:30:00', 2129, 1317);
INSERT INTO public.employee_schedule VALUES (1174, '2025-06-13', '07:00:00', '09:30:00', 1205, 1318);
INSERT INTO public.employee_schedule VALUES (1175, '2025-11-26', '10:00:00', '12:00:00', 1223, 1319);
INSERT INTO public.employee_schedule VALUES (1176, '2025-05-19', '07:00:00', '09:30:00', 2025, 1321);
INSERT INTO public.employee_schedule VALUES (1177, '2023-04-16', '07:00:00', '09:30:00', 3117, 1322);
INSERT INTO public.employee_schedule VALUES (1178, '2025-07-30', '16:00:00', '18:30:00', 1013, 1323);
INSERT INTO public.employee_schedule VALUES (1179, '2025-06-16', '13:00:00', '15:00:00', 3026, 1324);
INSERT INTO public.employee_schedule VALUES (1180, '2024-11-24', '13:00:00', '15:30:00', 1053, 1325);
INSERT INTO public.employee_schedule VALUES (1181, '2025-12-26', '16:00:00', '18:30:00', 1039, 1326);
INSERT INTO public.employee_schedule VALUES (1182, '2025-11-14', '16:00:00', '18:30:00', 3187, 1327);
INSERT INTO public.employee_schedule VALUES (1183, '2025-12-30', '16:00:00', '18:30:00', 1070, 1328);
INSERT INTO public.employee_schedule VALUES (1184, '2024-10-09', '07:00:00', '09:30:00', 3215, 1330);
INSERT INTO public.employee_schedule VALUES (1185, '2024-10-31', '13:00:00', '15:00:00', 1014, 1331);
INSERT INTO public.employee_schedule VALUES (1186, '2025-12-17', '07:00:00', '09:00:00', 1206, 1333);
INSERT INTO public.employee_schedule VALUES (1187, '2025-01-01', '13:00:00', '15:00:00', 1235, 1334);
INSERT INTO public.employee_schedule VALUES (1188, '2024-09-07', '13:00:00', '15:30:00', 2234, 1335);
INSERT INTO public.employee_schedule VALUES (1189, '2024-01-08', '13:00:00', '15:30:00', 1239, 1336);
INSERT INTO public.employee_schedule VALUES (1190, '2024-06-15', '13:00:00', '15:30:00', 1030, 1337);
INSERT INTO public.employee_schedule VALUES (1191, '2025-07-01', '16:00:00', '18:00:00', 2141, 1338);
INSERT INTO public.employee_schedule VALUES (1192, '2025-04-05', '13:00:00', '15:30:00', 3074, 1339);
INSERT INTO public.employee_schedule VALUES (1193, '2025-02-28', '10:00:00', '12:30:00', 1175, 1340);
INSERT INTO public.employee_schedule VALUES (1194, '2024-04-30', '07:00:00', '09:30:00', 1067, 1341);
INSERT INTO public.employee_schedule VALUES (1195, '2025-08-28', '10:00:00', '12:00:00', 1162, 1342);
INSERT INTO public.employee_schedule VALUES (1196, '2025-03-16', '16:00:00', '18:30:00', 1082, 1346);
INSERT INTO public.employee_schedule VALUES (1197, '2023-09-20', '10:00:00', '12:00:00', 2017, 1348);
INSERT INTO public.employee_schedule VALUES (1198, '2025-11-05', '16:00:00', '18:00:00', 2044, 1350);
INSERT INTO public.employee_schedule VALUES (1199, '2025-10-29', '07:00:00', '09:00:00', 2230, 1351);
INSERT INTO public.employee_schedule VALUES (1200, '2025-06-07', '16:00:00', '18:30:00', 1128, 1352);
INSERT INTO public.employee_schedule VALUES (1201, '2025-06-14', '10:00:00', '12:00:00', 1011, 1353);
INSERT INTO public.employee_schedule VALUES (1202, '2025-11-04', '16:00:00', '18:30:00', 1075, 1354);
INSERT INTO public.employee_schedule VALUES (1203, '2024-10-28', '07:00:00', '09:00:00', 2187, 1355);
INSERT INTO public.employee_schedule VALUES (1204, '2024-12-30', '13:00:00', '15:00:00', 3154, 1357);
INSERT INTO public.employee_schedule VALUES (1205, '2023-08-26', '07:00:00', '09:00:00', 3019, 1358);
INSERT INTO public.employee_schedule VALUES (1206, '2024-11-17', '13:00:00', '15:00:00', 2067, 1359);
INSERT INTO public.employee_schedule VALUES (1207, '2024-02-28', '13:00:00', '15:00:00', 1034, 1360);
INSERT INTO public.employee_schedule VALUES (1208, '2025-03-31', '16:00:00', '18:00:00', 3059, 1361);
INSERT INTO public.employee_schedule VALUES (1209, '2024-09-20', '10:00:00', '12:00:00', 2205, 1362);
INSERT INTO public.employee_schedule VALUES (1210, '2025-04-21', '10:00:00', '12:30:00', 2155, 1363);
INSERT INTO public.employee_schedule VALUES (1211, '2025-07-14', '07:00:00', '09:00:00', 1103, 1364);
INSERT INTO public.employee_schedule VALUES (1212, '2025-11-27', '16:00:00', '18:00:00', 1192, 1365);
INSERT INTO public.employee_schedule VALUES (1213, '2024-05-14', '10:00:00', '12:00:00', 3069, 1366);
INSERT INTO public.employee_schedule VALUES (1214, '2024-02-26', '07:00:00', '09:30:00', 1037, 1367);
INSERT INTO public.employee_schedule VALUES (1215, '2025-03-29', '07:00:00', '09:30:00', 3157, 1370);
INSERT INTO public.employee_schedule VALUES (1216, '2025-03-14', '16:00:00', '18:00:00', 1014, 1371);
INSERT INTO public.employee_schedule VALUES (1217, '2024-09-22', '16:00:00', '18:30:00', 2178, 1372);
INSERT INTO public.employee_schedule VALUES (1218, '2025-03-12', '07:00:00', '09:30:00', 1205, 1373);
INSERT INTO public.employee_schedule VALUES (1219, '2024-01-20', '10:00:00', '12:00:00', 2109, 1374);
INSERT INTO public.employee_schedule VALUES (1220, '2025-03-29', '07:00:00', '09:00:00', 1013, 1375);
INSERT INTO public.employee_schedule VALUES (1221, '2025-01-22', '07:00:00', '09:00:00', 2051, 1376);
INSERT INTO public.employee_schedule VALUES (1222, '2023-08-04', '07:00:00', '09:00:00', 2114, 1377);
INSERT INTO public.employee_schedule VALUES (1223, '2025-08-28', '16:00:00', '18:00:00', 3065, 1378);
INSERT INTO public.employee_schedule VALUES (1224, '2024-11-11', '07:00:00', '09:30:00', 2228, 1379);
INSERT INTO public.employee_schedule VALUES (1225, '2025-10-01', '10:00:00', '12:00:00', 2077, 1380);
INSERT INTO public.employee_schedule VALUES (1226, '2025-06-03', '07:00:00', '09:00:00', 1147, 1381);
INSERT INTO public.employee_schedule VALUES (1227, '2025-02-18', '10:00:00', '12:00:00', 2026, 1382);
INSERT INTO public.employee_schedule VALUES (1228, '2025-03-19', '10:00:00', '12:30:00', 1241, 1383);
INSERT INTO public.employee_schedule VALUES (1229, '2024-09-11', '13:00:00', '15:30:00', 1125, 1384);
INSERT INTO public.employee_schedule VALUES (1230, '2024-09-28', '13:00:00', '15:00:00', 2234, 1385);
INSERT INTO public.employee_schedule VALUES (1231, '2025-10-22', '07:00:00', '09:30:00', 3074, 1386);
INSERT INTO public.employee_schedule VALUES (1232, '2025-11-06', '13:00:00', '15:30:00', 3045, 1387);
INSERT INTO public.employee_schedule VALUES (1233, '2024-11-22', '13:00:00', '15:30:00', 2068, 1388);
INSERT INTO public.employee_schedule VALUES (1234, '2025-09-21', '13:00:00', '15:00:00', 3194, 1390);
INSERT INTO public.employee_schedule VALUES (1235, '2025-06-07', '16:00:00', '18:30:00', 2234, 1391);
INSERT INTO public.employee_schedule VALUES (1236, '2025-05-15', '13:00:00', '15:30:00', 1067, 1392);
INSERT INTO public.employee_schedule VALUES (1237, '2025-04-28', '16:00:00', '18:30:00', 2100, 1393);
INSERT INTO public.employee_schedule VALUES (1238, '2025-06-18', '07:00:00', '09:30:00', 2185, 1394);
INSERT INTO public.employee_schedule VALUES (1239, '2025-03-17', '16:00:00', '18:30:00', 2120, 1395);
INSERT INTO public.employee_schedule VALUES (1240, '2025-03-24', '16:00:00', '18:00:00', 3022, 1397);
INSERT INTO public.employee_schedule VALUES (1241, '2024-02-16', '10:00:00', '12:30:00', 3157, 1398);
INSERT INTO public.employee_schedule VALUES (1242, '2024-07-14', '16:00:00', '18:30:00', 3133, 1399);
INSERT INTO public.employee_schedule VALUES (1243, '2025-11-24', '07:00:00', '09:30:00', 1102, 1401);
INSERT INTO public.employee_schedule VALUES (1244, '2025-11-26', '07:00:00', '09:30:00', 1103, 1402);
INSERT INTO public.employee_schedule VALUES (1245, '2026-01-01', '13:00:00', '15:00:00', 3081, 1403);
INSERT INTO public.employee_schedule VALUES (1246, '2024-10-21', '10:00:00', '12:30:00', 2236, 1404);
INSERT INTO public.employee_schedule VALUES (1247, '2025-09-28', '07:00:00', '09:00:00', 1070, 1405);
INSERT INTO public.employee_schedule VALUES (1248, '2024-05-08', '13:00:00', '15:30:00', 3038, 1406);
INSERT INTO public.employee_schedule VALUES (1249, '2025-01-13', '13:00:00', '15:00:00', 3070, 1407);
INSERT INTO public.employee_schedule VALUES (1250, '2023-11-09', '16:00:00', '18:00:00', 2200, 1408);
INSERT INTO public.employee_schedule VALUES (1251, '2024-03-07', '16:00:00', '18:00:00', 3101, 1409);
INSERT INTO public.employee_schedule VALUES (1252, '2025-12-12', '10:00:00', '12:00:00', 1004, 1410);
INSERT INTO public.employee_schedule VALUES (1253, '2025-08-27', '07:00:00', '09:00:00', 3021, 1411);
INSERT INTO public.employee_schedule VALUES (1254, '2025-05-19', '07:00:00', '09:30:00', 2046, 1412);
INSERT INTO public.employee_schedule VALUES (1255, '2025-12-27', '13:00:00', '15:00:00', 1020, 1413);
INSERT INTO public.employee_schedule VALUES (1256, '2024-01-25', '10:00:00', '12:30:00', 1223, 1414);
INSERT INTO public.employee_schedule VALUES (1257, '2024-12-25', '10:00:00', '12:00:00', 2006, 1415);
INSERT INTO public.employee_schedule VALUES (1258, '2024-09-25', '16:00:00', '18:30:00', 1010, 1416);
INSERT INTO public.employee_schedule VALUES (1259, '2024-04-02', '07:00:00', '09:00:00', 2172, 1417);
INSERT INTO public.employee_schedule VALUES (1260, '2025-08-12', '16:00:00', '18:00:00', 1073, 1418);
INSERT INTO public.employee_schedule VALUES (1261, '2025-09-27', '13:00:00', '15:00:00', 2094, 1419);
INSERT INTO public.employee_schedule VALUES (1262, '2024-11-14', '13:00:00', '15:30:00', 3064, 1420);
INSERT INTO public.employee_schedule VALUES (1263, '2024-02-11', '07:00:00', '09:30:00', 2082, 1421);
INSERT INTO public.employee_schedule VALUES (1264, '2024-06-12', '07:00:00', '09:30:00', 1109, 1422);
INSERT INTO public.employee_schedule VALUES (1265, '2023-06-01', '13:00:00', '15:00:00', 1205, 1423);
INSERT INTO public.employee_schedule VALUES (1266, '2024-01-18', '13:00:00', '15:30:00', 3141, 1424);
INSERT INTO public.employee_schedule VALUES (1267, '2025-07-24', '13:00:00', '15:30:00', 1097, 1425);
INSERT INTO public.employee_schedule VALUES (1268, '2024-09-07', '13:00:00', '15:00:00', 3057, 1426);
INSERT INTO public.employee_schedule VALUES (1269, '2024-10-13', '13:00:00', '15:30:00', 2123, 1427);
INSERT INTO public.employee_schedule VALUES (1270, '2024-12-23', '13:00:00', '15:00:00', 2151, 1428);
INSERT INTO public.employee_schedule VALUES (1271, '2025-09-26', '07:00:00', '09:00:00', 2038, 1429);
INSERT INTO public.employee_schedule VALUES (1272, '2025-11-01', '10:00:00', '12:30:00', 1167, 1430);
INSERT INTO public.employee_schedule VALUES (1273, '2024-10-02', '13:00:00', '15:30:00', 3201, 1431);
INSERT INTO public.employee_schedule VALUES (1274, '2025-06-02', '16:00:00', '18:30:00', 2015, 1432);
INSERT INTO public.employee_schedule VALUES (1275, '2025-06-19', '07:00:00', '09:00:00', 3038, 1433);
INSERT INTO public.employee_schedule VALUES (1276, '2025-08-18', '16:00:00', '18:30:00', 3243, 1434);
INSERT INTO public.employee_schedule VALUES (1277, '2024-05-28', '13:00:00', '15:00:00', 3054, 1435);
INSERT INTO public.employee_schedule VALUES (1278, '2023-05-20', '16:00:00', '18:30:00', 3020, 1436);
INSERT INTO public.employee_schedule VALUES (1279, '2025-01-24', '07:00:00', '09:00:00', 3072, 1437);
INSERT INTO public.employee_schedule VALUES (1280, '2025-08-29', '07:00:00', '09:00:00', 3162, 1438);
INSERT INTO public.employee_schedule VALUES (1281, '2024-10-03', '07:00:00', '09:00:00', 1098, 1439);
INSERT INTO public.employee_schedule VALUES (1282, '2025-10-21', '16:00:00', '18:00:00', 1020, 1440);
INSERT INTO public.employee_schedule VALUES (1283, '2025-10-09', '10:00:00', '12:30:00', 1059, 1441);
INSERT INTO public.employee_schedule VALUES (1284, '2024-10-20', '10:00:00', '12:00:00', 3237, 1442);
INSERT INTO public.employee_schedule VALUES (1285, '2025-10-13', '10:00:00', '12:30:00', 3115, 1444);
INSERT INTO public.employee_schedule VALUES (1286, '2024-06-22', '13:00:00', '15:30:00', 1100, 1446);
INSERT INTO public.employee_schedule VALUES (1287, '2025-12-04', '16:00:00', '18:00:00', 3148, 1447);
INSERT INTO public.employee_schedule VALUES (1288, '2025-07-23', '13:00:00', '15:00:00', 2075, 1448);
INSERT INTO public.employee_schedule VALUES (1289, '2025-10-11', '10:00:00', '12:00:00', 3014, 1449);
INSERT INTO public.employee_schedule VALUES (1290, '2025-06-02', '16:00:00', '18:30:00', 2168, 1450);
INSERT INTO public.employee_schedule VALUES (1291, '2025-12-25', '10:00:00', '12:30:00', 1211, 1451);
INSERT INTO public.employee_schedule VALUES (1292, '2025-12-12', '13:00:00', '15:30:00', 2155, 1452);
INSERT INTO public.employee_schedule VALUES (1293, '2025-02-06', '07:00:00', '09:00:00', 1234, 1453);
INSERT INTO public.employee_schedule VALUES (1294, '2024-08-28', '16:00:00', '18:30:00', 3020, 1454);
INSERT INTO public.employee_schedule VALUES (1295, '2024-09-06', '07:00:00', '09:00:00', 2236, 1455);
INSERT INTO public.employee_schedule VALUES (1296, '2024-06-15', '13:00:00', '15:30:00', 2048, 1456);
INSERT INTO public.employee_schedule VALUES (1297, '2024-04-30', '07:00:00', '09:30:00', 2215, 1457);
INSERT INTO public.employee_schedule VALUES (1298, '2025-05-08', '16:00:00', '18:00:00', 1234, 1458);
INSERT INTO public.employee_schedule VALUES (1299, '2025-03-11', '07:00:00', '09:00:00', 3029, 1459);
INSERT INTO public.employee_schedule VALUES (1300, '2025-01-19', '10:00:00', '12:00:00', 2087, 1460);
INSERT INTO public.employee_schedule VALUES (1301, '2025-11-11', '07:00:00', '09:00:00', 1025, 1461);
INSERT INTO public.employee_schedule VALUES (1302, '2024-03-24', '07:00:00', '09:00:00', 1075, 1462);
INSERT INTO public.employee_schedule VALUES (1303, '2025-09-02', '10:00:00', '12:00:00', 1171, 1463);
INSERT INTO public.employee_schedule VALUES (1304, '2025-09-02', '16:00:00', '18:00:00', 1190, 1464);
INSERT INTO public.employee_schedule VALUES (1305, '2025-05-06', '10:00:00', '12:00:00', 1016, 1465);
INSERT INTO public.employee_schedule VALUES (1306, '2025-09-09', '13:00:00', '15:00:00', 3091, 1466);
INSERT INTO public.employee_schedule VALUES (1307, '2025-07-23', '13:00:00', '15:00:00', 1015, 1468);
INSERT INTO public.employee_schedule VALUES (1308, '2025-07-25', '07:00:00', '09:00:00', 1211, 1469);
INSERT INTO public.employee_schedule VALUES (1309, '2025-03-10', '13:00:00', '15:00:00', 2116, 1470);
INSERT INTO public.employee_schedule VALUES (1310, '2023-09-17', '07:00:00', '09:00:00', 3084, 1471);
INSERT INTO public.employee_schedule VALUES (1311, '2025-07-07', '16:00:00', '18:30:00', 2189, 1472);
INSERT INTO public.employee_schedule VALUES (1312, '2024-12-01', '10:00:00', '12:30:00', 2089, 1473);
INSERT INTO public.employee_schedule VALUES (1313, '2024-05-27', '10:00:00', '12:30:00', 3235, 1474);
INSERT INTO public.employee_schedule VALUES (1314, '2025-11-22', '13:00:00', '15:00:00', 3097, 1475);
INSERT INTO public.employee_schedule VALUES (1315, '2025-07-08', '07:00:00', '09:30:00', 1039, 1477);
INSERT INTO public.employee_schedule VALUES (1316, '2024-03-18', '16:00:00', '18:00:00', 1046, 1478);
INSERT INTO public.employee_schedule VALUES (1317, '2025-09-02', '16:00:00', '18:30:00', 1162, 1479);
INSERT INTO public.employee_schedule VALUES (1318, '2024-07-20', '10:00:00', '12:30:00', 1155, 1480);
INSERT INTO public.employee_schedule VALUES (1319, '2025-10-01', '13:00:00', '15:00:00', 2144, 1481);
INSERT INTO public.employee_schedule VALUES (1320, '2024-11-22', '16:00:00', '18:00:00', 3017, 1482);
INSERT INTO public.employee_schedule VALUES (1321, '2025-10-11', '10:00:00', '12:00:00', 1102, 1483);
INSERT INTO public.employee_schedule VALUES (1322, '2025-11-03', '16:00:00', '18:30:00', 2018, 1486);
INSERT INTO public.employee_schedule VALUES (1323, '2024-04-21', '07:00:00', '09:00:00', 2198, 1487);
INSERT INTO public.employee_schedule VALUES (1324, '2025-02-26', '10:00:00', '12:00:00', 1233, 1488);
INSERT INTO public.employee_schedule VALUES (1325, '2024-02-12', '07:00:00', '09:30:00', 1127, 1489);
INSERT INTO public.employee_schedule VALUES (1326, '2024-08-04', '16:00:00', '18:30:00', 1199, 1490);
INSERT INTO public.employee_schedule VALUES (1327, '2025-08-12', '07:00:00', '09:30:00', 3041, 1491);
INSERT INTO public.employee_schedule VALUES (1328, '2025-06-11', '07:00:00', '09:00:00', 1018, 1492);
INSERT INTO public.employee_schedule VALUES (1329, '2024-06-15', '13:00:00', '15:00:00', 1012, 1493);
INSERT INTO public.employee_schedule VALUES (1330, '2024-12-26', '10:00:00', '12:30:00', 3208, 1494);
INSERT INTO public.employee_schedule VALUES (1331, '2024-07-31', '10:00:00', '12:30:00', 1172, 1495);
INSERT INTO public.employee_schedule VALUES (1332, '2024-12-31', '16:00:00', '18:30:00', 2108, 1496);
INSERT INTO public.employee_schedule VALUES (1333, '2023-12-13', '16:00:00', '18:00:00', 3024, 1497);
INSERT INTO public.employee_schedule VALUES (1334, '2024-12-21', '10:00:00', '12:00:00', 2015, 1498);
INSERT INTO public.employee_schedule VALUES (1335, '2023-07-25', '16:00:00', '18:00:00', 3099, 1499);
INSERT INTO public.employee_schedule VALUES (1336, '2025-12-11', '07:00:00', '09:00:00', 1112, 1500);
INSERT INTO public.employee_schedule VALUES (1341, '2024-03-13', '07:00:00', '09:00:00', 3087, 1505);
INSERT INTO public.employee_schedule VALUES (1342, '2024-12-17', '07:00:00', '09:00:00', 1041, 1506);
INSERT INTO public.employee_schedule VALUES (1343, '2023-03-29', '07:00:00', '09:30:00', 2066, 1507);
INSERT INTO public.employee_schedule VALUES (1344, '2023-11-19', '07:00:00', '09:00:00', 1043, 1508);
INSERT INTO public.employee_schedule VALUES (1345, '2024-06-27', '07:00:00', '09:30:00', 3093, 1509);
INSERT INTO public.employee_schedule VALUES (1346, '2024-11-22', '07:00:00', '09:00:00', 2078, 1510);
INSERT INTO public.employee_schedule VALUES (1347, '2025-05-19', '07:00:00', '09:30:00', 3103, 1511);
INSERT INTO public.employee_schedule VALUES (1348, '2024-06-19', '07:00:00', '09:00:00', 3104, 1512);
INSERT INTO public.employee_schedule VALUES (1349, '2023-02-27', '07:00:00', '09:00:00', 3109, 1513);
INSERT INTO public.employee_schedule VALUES (1350, '2025-04-11', '07:00:00', '09:30:00', 3110, 1514);
INSERT INTO public.employee_schedule VALUES (1351, '2025-01-30', '07:00:00', '09:00:00', 1065, 1515);
INSERT INTO public.employee_schedule VALUES (1352, '2025-01-07', '07:00:00', '09:00:00', 1068, 1516);
INSERT INTO public.employee_schedule VALUES (1353, '2023-10-11', '07:00:00', '09:00:00', 2095, 1517);
INSERT INTO public.employee_schedule VALUES (1354, '2023-10-02', '07:00:00', '09:30:00', 2096, 1518);
INSERT INTO public.employee_schedule VALUES (1355, '2024-08-12', '07:00:00', '09:30:00', 2097, 1519);
INSERT INTO public.employee_schedule VALUES (1356, '2024-01-09', '07:00:00', '09:30:00', 2098, 1520);
INSERT INTO public.employee_schedule VALUES (1357, '2024-11-05', '07:00:00', '09:30:00', 1074, 1521);
INSERT INTO public.employee_schedule VALUES (1358, '2025-02-03', '07:00:00', '09:00:00', 3121, 1522);
INSERT INTO public.employee_schedule VALUES (1359, '2023-07-04', '07:00:00', '09:00:00', 3122, 1523);
INSERT INTO public.employee_schedule VALUES (1360, '2023-03-07', '07:00:00', '09:00:00', 3125, 1524);
INSERT INTO public.employee_schedule VALUES (1361, '2024-08-25', '07:00:00', '09:30:00', 1080, 1525);
INSERT INTO public.employee_schedule VALUES (1362, '2023-01-27', '07:00:00', '09:30:00', 2105, 1526);
INSERT INTO public.employee_schedule VALUES (1363, '2025-03-17', '07:00:00', '09:30:00', 1084, 1527);
INSERT INTO public.employee_schedule VALUES (1364, '2023-03-08', '07:00:00', '09:00:00', 1086, 1528);
INSERT INTO public.employee_schedule VALUES (1365, '2024-08-15', '07:00:00', '09:00:00', 3138, 1529);
INSERT INTO public.employee_schedule VALUES (1366, '2025-04-30', '07:00:00', '09:00:00', 2115, 1530);
INSERT INTO public.employee_schedule VALUES (1367, '2023-10-11', '07:00:00', '09:30:00', 1091, 1531);
INSERT INTO public.employee_schedule VALUES (1368, '2023-09-07', '07:00:00', '09:00:00', 3139, 1532);
INSERT INTO public.employee_schedule VALUES (1369, '2023-08-26', '07:00:00', '09:30:00', 3143, 1533);
INSERT INTO public.employee_schedule VALUES (1370, '2023-06-21', '07:00:00', '09:30:00', 3145, 1534);
INSERT INTO public.employee_schedule VALUES (1371, '2023-12-28', '07:00:00', '09:30:00', 3146, 1535);
INSERT INTO public.employee_schedule VALUES (1372, '2025-04-13', '07:00:00', '09:00:00', 2124, 1536);
INSERT INTO public.employee_schedule VALUES (1373, '2023-01-08', '07:00:00', '09:30:00', 2130, 1537);
INSERT INTO public.employee_schedule VALUES (1374, '2023-04-14', '07:00:00', '09:00:00', 2132, 1538);
INSERT INTO public.employee_schedule VALUES (1375, '2023-03-02', '07:00:00', '09:00:00', 3156, 1539);
INSERT INTO public.employee_schedule VALUES (1376, '2025-04-18', '07:00:00', '09:00:00', 2135, 1540);
INSERT INTO public.employee_schedule VALUES (1377, '2023-08-22', '07:00:00', '09:30:00', 2137, 1541);
INSERT INTO public.employee_schedule VALUES (1378, '2024-08-21', '07:00:00', '09:30:00', 3161, 1542);
INSERT INTO public.employee_schedule VALUES (1379, '2023-06-16', '07:00:00', '09:30:00', 2139, 1543);
INSERT INTO public.employee_schedule VALUES (1380, '2023-12-06', '07:00:00', '09:00:00', 3167, 1544);
INSERT INTO public.employee_schedule VALUES (1381, '2025-02-21', '07:00:00', '09:00:00', 3168, 1545);
INSERT INTO public.employee_schedule VALUES (1382, '2023-04-17', '07:00:00', '09:30:00', 2146, 1546);
INSERT INTO public.employee_schedule VALUES (1383, '2025-01-30', '07:00:00', '09:30:00', 2147, 1547);
INSERT INTO public.employee_schedule VALUES (1384, '2024-07-11', '07:00:00', '09:00:00', 2148, 1548);
INSERT INTO public.employee_schedule VALUES (1385, '2024-06-02', '07:00:00', '09:00:00', 2149, 1549);
INSERT INTO public.employee_schedule VALUES (1386, '2023-07-31', '07:00:00', '09:30:00', 1122, 1550);
INSERT INTO public.employee_schedule VALUES (1387, '2023-06-02', '07:00:00', '09:30:00', 1124, 1551);
INSERT INTO public.employee_schedule VALUES (1388, '2024-01-04', '07:00:00', '09:30:00', 3172, 1552);
INSERT INTO public.employee_schedule VALUES (1389, '2023-08-11', '07:00:00', '09:30:00', 3176, 1553);
INSERT INTO public.employee_schedule VALUES (1390, '2023-03-11', '07:00:00', '09:00:00', 3177, 1554);
INSERT INTO public.employee_schedule VALUES (1391, '2024-12-18', '07:00:00', '09:30:00', 3179, 1555);
INSERT INTO public.employee_schedule VALUES (1392, '2025-02-12', '07:00:00', '09:00:00', 2157, 1556);
INSERT INTO public.employee_schedule VALUES (1393, '2023-05-08', '07:00:00', '09:30:00', 1134, 1557);
INSERT INTO public.employee_schedule VALUES (1394, '2025-02-20', '07:00:00', '09:00:00', 1135, 1558);
INSERT INTO public.employee_schedule VALUES (1395, '2024-07-26', '07:00:00', '09:30:00', 3181, 1559);
INSERT INTO public.employee_schedule VALUES (1396, '2023-07-10', '07:00:00', '09:00:00', 1137, 1560);
INSERT INTO public.employee_schedule VALUES (1397, '2024-02-05', '07:00:00', '09:30:00', 3182, 1561);
INSERT INTO public.employee_schedule VALUES (1398, '2025-04-09', '07:00:00', '09:30:00', 2163, 1562);
INSERT INTO public.employee_schedule VALUES (1399, '2024-02-17', '07:00:00', '09:30:00', 2165, 1563);
INSERT INTO public.employee_schedule VALUES (1400, '2024-04-08', '07:00:00', '09:00:00', 2166, 1564);
INSERT INTO public.employee_schedule VALUES (1401, '2024-06-22', '07:00:00', '09:00:00', 1145, 1565);
INSERT INTO public.employee_schedule VALUES (1402, '2024-12-04', '07:00:00', '09:00:00', 2171, 1566);
INSERT INTO public.employee_schedule VALUES (1403, '2023-08-05', '07:00:00', '09:30:00', 1148, 1567);
INSERT INTO public.employee_schedule VALUES (1404, '2023-07-17', '07:00:00', '09:00:00', 3196, 1568);
INSERT INTO public.employee_schedule VALUES (1405, '2023-04-29', '07:00:00', '09:00:00', 2175, 1569);
INSERT INTO public.employee_schedule VALUES (1406, '2024-09-07', '07:00:00', '09:30:00', 2183, 1570);
INSERT INTO public.employee_schedule VALUES (1407, '2025-01-14', '07:00:00', '09:00:00', 3209, 1571);
INSERT INTO public.employee_schedule VALUES (1408, '2025-05-19', '07:00:00', '09:30:00', 1165, 1572);
INSERT INTO public.employee_schedule VALUES (1409, '2024-10-26', '07:00:00', '09:00:00', 3214, 1573);
INSERT INTO public.employee_schedule VALUES (1410, '2025-03-18', '07:00:00', '09:30:00', 2192, 1574);
INSERT INTO public.employee_schedule VALUES (1411, '2024-08-23', '07:00:00', '09:00:00', 1170, 1575);
INSERT INTO public.employee_schedule VALUES (1412, '2024-05-18', '07:00:00', '09:00:00', 3218, 1576);
INSERT INTO public.employee_schedule VALUES (1413, '2024-09-08', '07:00:00', '09:30:00', 1174, 1577);
INSERT INTO public.employee_schedule VALUES (1414, '2024-01-22', '07:00:00', '09:00:00', 3224, 1578);
INSERT INTO public.employee_schedule VALUES (1415, '2024-09-01', '07:00:00', '09:30:00', 3225, 1579);
INSERT INTO public.employee_schedule VALUES (1416, '2024-09-17', '07:00:00', '09:00:00', 1179, 1580);
INSERT INTO public.employee_schedule VALUES (1417, '2023-06-12', '07:00:00', '09:30:00', 3227, 1581);
INSERT INTO public.employee_schedule VALUES (1418, '2024-08-28', '07:00:00', '09:00:00', 3228, 1582);
INSERT INTO public.employee_schedule VALUES (1419, '2025-03-11', '07:00:00', '09:00:00', 2207, 1583);
INSERT INTO public.employee_schedule VALUES (1420, '2023-10-02', '07:00:00', '09:30:00', 2210, 1584);
INSERT INTO public.employee_schedule VALUES (1421, '2024-08-30', '07:00:00', '09:00:00', 1191, 1585);
INSERT INTO public.employee_schedule VALUES (1422, '2025-02-11', '07:00:00', '09:00:00', 2216, 1586);
INSERT INTO public.employee_schedule VALUES (1423, '2023-02-25', '07:00:00', '09:00:00', 2217, 1587);
INSERT INTO public.employee_schedule VALUES (1424, '2024-07-31', '07:00:00', '09:30:00', 2218, 1588);
INSERT INTO public.employee_schedule VALUES (1425, '2023-07-11', '07:00:00', '09:30:00', 1203, 1589);
INSERT INTO public.employee_schedule VALUES (1426, '2025-02-05', '07:00:00', '09:30:00', 2232, 1590);
INSERT INTO public.employee_schedule VALUES (1427, '2023-05-08', '07:00:00', '09:30:00', 1222, 1591);
INSERT INTO public.employee_schedule VALUES (1428, '2024-11-24', '07:00:00', '09:00:00', 1224, 1592);
INSERT INTO public.employee_schedule VALUES (1429, '2025-04-30', '07:00:00', '09:30:00', 1228, 1593);
INSERT INTO public.employee_schedule VALUES (1430, '2023-03-08', '07:00:00', '09:30:00', 3002, 1594);
INSERT INTO public.employee_schedule VALUES (1431, '2023-04-27', '07:00:00', '09:30:00', 3003, 1595);
INSERT INTO public.employee_schedule VALUES (1432, '2023-10-28', '07:00:00', '09:00:00', 3008, 1596);
INSERT INTO public.employee_schedule VALUES (1433, '2024-03-13', '07:00:00', '09:30:00', 3015, 1597);
INSERT INTO public.employee_schedule VALUES (1434, '2024-07-30', '07:00:00', '09:30:00', 3030, 1598);
INSERT INTO public.employee_schedule VALUES (1435, '2023-06-30', '07:00:00', '09:00:00', 3033, 1599);
INSERT INTO public.employee_schedule VALUES (1436, '2024-11-09', '07:00:00', '09:00:00', 3034, 1600);
INSERT INTO public.employee_schedule VALUES (1437, '2024-04-30', '07:00:00', '09:00:00', 3035, 1601);
INSERT INTO public.employee_schedule VALUES (1438, '2024-08-28', '07:00:00', '09:00:00', 3036, 1602);
INSERT INTO public.employee_schedule VALUES (1439, '2024-08-26', '07:00:00', '09:30:00', 3042, 1603);
INSERT INTO public.employee_schedule VALUES (1440, '2025-05-14', '07:00:00', '09:30:00', 3048, 1604);
INSERT INTO public.employee_schedule VALUES (1441, '2025-04-06', '07:00:00', '09:30:00', 3050, 1605);
INSERT INTO public.employee_schedule VALUES (1442, '2023-04-30', '07:00:00', '09:30:00', 3051, 1606);
INSERT INTO public.employee_schedule VALUES (1443, '2023-11-12', '07:00:00', '09:00:00', 3053, 1607);
INSERT INTO public.employee_schedule VALUES (1444, '2024-08-03', '07:00:00', '09:00:00', 2029, 1608);
INSERT INTO public.employee_schedule VALUES (1445, '2023-09-30', '07:00:00', '09:30:00', 3055, 1609);
INSERT INTO public.employee_schedule VALUES (1446, '2024-12-02', '07:00:00', '09:00:00', 1008, 1610);
INSERT INTO public.employee_schedule VALUES (1447, '2023-12-03', '07:00:00', '09:30:00', 2032, 1611);
INSERT INTO public.employee_schedule VALUES (1448, '2024-06-27', '07:00:00', '09:30:00', 2039, 1612);
INSERT INTO public.employee_schedule VALUES (1449, '2025-05-23', '18:20:00', '19:20:00', 1058, 1613);
INSERT INTO public.employee_schedule VALUES (1450, '2025-05-25', '10:30:00', '11:30:00', 3026, 1614);
INSERT INTO public.employee_schedule VALUES (1451, '2025-05-19', '16:30:00', '17:30:00', 3001, 1615);


--
-- TOC entry 4926 (class 0 OID 16439)
-- Dependencies: 226
-- Data for Name: maintenance_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.maintenance_type VALUES (1, 'Periodic');
INSERT INTO public.maintenance_type VALUES (2, 'Mechanical');
INSERT INTO public.maintenance_type VALUES (3, 'Damage Repair');
INSERT INTO public.maintenance_type VALUES (4, 'Other');


--
-- TOC entry 4918 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Atabey', 'Sağlam', '048-936-5343', 'a.salam669@google.com', 'E6T25JHF0T7', '2023-09-14 00:00:00');
INSERT INTO public.users VALUES (2, 'Fatma', 'Dündar', '022-769-0279', 'f_dndar@google.com', 'Y0T35ZJI2P2', '2023-12-31 00:00:00');
INSERT INTO public.users VALUES (3, 'Ramazan', 'Açıkgöz', '035-997-3752', 'akgzramazan9930@google.com', 'U9S67BLP2M1', '2023-05-04 00:00:00');
INSERT INTO public.users VALUES (4, 'Cemali̇', 'Fidan', '088-311-3837', 'f_cemali@hotmail.com', 'G2K44GFJ7D0', '2024-08-13 00:00:00');
INSERT INTO public.users VALUES (5, 'Şengül', 'Sezer', '024-548-5725', 's_engl@hotmail.com', 'K4L92IMS0Y9', '2024-06-18 00:00:00');
INSERT INTO public.users VALUES (6, 'Ramazan', 'Karahan', '071-473-4072', 'ramazan.karahan5746@google.com', 'Y0M86ESE2Q3', '2023-03-15 00:00:00');
INSERT INTO public.users VALUES (7, 'Cankat', 'Şenol', '052-314-7182', 'cankat_enol@google.com', 'A7I86VBZ5X7', '2025-04-05 00:00:00');
INSERT INTO public.users VALUES (8, 'Nuriye', 'Dinç', '014-675-4832', 'nuriye-din@hotmail.com', 'P6Y65QMI1F3', '2023-05-24 00:00:00');
INSERT INTO public.users VALUES (9, 'Nureddi̇n', 'Ekici', '094-853-4274', 'ekici_nureddin@hotmail.com', 'P5U13OBC5G6', '2024-03-14 00:00:00');
INSERT INTO public.users VALUES (10, 'Fatma', 'Şenol', '021-485-1088', 'enol_fatma5516@google.com', 'Q3W60LOJ3P6', '2024-12-20 00:00:00');
INSERT INTO public.users VALUES (11, 'Murat', 'Ünlü', '042-057-3548', 'nl_murat@hotmail.com', 'U5Y68HRO5P7', '2023-11-16 00:00:00');
INSERT INTO public.users VALUES (12, 'Nazi̇fe', 'Çakmak', '020-764-5067', 'nazifeakmak@google.com', 'D7Q68BXK3I9', '2023-12-04 00:00:00');
INSERT INTO public.users VALUES (13, 'Cansu', 'Durak', '018-383-8228', 'cansu.durak7665@google.com', 'P3V91VBR7G2', '2023-04-01 00:00:00');
INSERT INTO public.users VALUES (14, 'Nazi̇me', 'Kutlu', '094-626-8872', 'nazime.kutlu9659@hotmail.com', 'P2E61DFF2M8', '2024-09-13 00:00:00');
INSERT INTO public.users VALUES (15, 'Gülay', 'İpek', '060-351-3871', 'g_pek2697@google.com', 'M4P56DVY2M7', '2025-04-26 00:00:00');
INSERT INTO public.users VALUES (16, 'Merve', 'Güney', '077-651-1249', 'merve.gney@google.com', 'U2W24NBR5G8', '2024-12-10 00:00:00');
INSERT INTO public.users VALUES (17, 'Güler', 'Doğan', '008-631-6265', 'gdoan4384@google.com', 'L9Y74BJF5D8', '2023-03-24 00:00:00');
INSERT INTO public.users VALUES (18, 'Sude', 'Çelebi', '013-966-6214', 'elebi.sude5103@hotmail.com', 'Y3V08KMS9G2', '2024-03-26 00:00:00');
INSERT INTO public.users VALUES (19, 'Efe', 'Tan', '090-627-4745', 'tanefe@hotmail.com', 'R4M85EFH8L8', '2025-02-11 00:00:00');
INSERT INTO public.users VALUES (20, 'Sultan', 'Akdoğan', '023-789-6736', 'akdoan-sultan3333@hotmail.com', 'U5I15DVC1F1', '2023-06-27 00:00:00');
INSERT INTO public.users VALUES (21, 'Sevi̇', 'Yüksel', '025-170-4493', 'ykselsevi@google.com', 'U5L74MPC3S0', '2025-04-26 00:00:00');
INSERT INTO public.users VALUES (22, 'Fati̇h', 'Akbulut', '037-371-4878', 'f_akbulut@google.com', 'X8I69ETX8R7', '2025-04-03 00:00:00');
INSERT INTO public.users VALUES (23, 'Gülşen', 'Sezer', '081-268-2736', 's-glen9553@google.com', 'J1C15YUO1T5', '2023-03-25 00:00:00');
INSERT INTO public.users VALUES (24, 'Ataberk', 'Arıkan', '062-056-4874', 'a.arkan@hotmail.com', 'T1W48SDP0X3', '2023-12-17 00:00:00');
INSERT INTO public.users VALUES (25, 'Poyraz', 'Çetinkaya', '052-606-5354', 'p-etinkaya@hotmail.com', 'R8J57QVA6X2', '2024-05-26 00:00:00');
INSERT INTO public.users VALUES (26, 'Gülten', 'Kaplan', '066-820-4234', 'kaplanglten3409@hotmail.com', 'N8I57GFV2F2', '2023-08-13 00:00:00');
INSERT INTO public.users VALUES (27, 'Büşra', 'Torun', '024-881-2662', 'torun_bra@hotmail.com', 'W7A74SMR8S8', '2024-06-21 00:00:00');
INSERT INTO public.users VALUES (28, 'Gülsüm', 'Bolat', '075-175-6823', 'g_bolat@google.com', 'J1T06XRF1B5', '2024-10-30 00:00:00');
INSERT INTO public.users VALUES (29, 'Berk', 'Bayram', '077-463-1876', 'b_bayram@hotmail.com', 'U7T07BIK5U4', '2023-06-17 00:00:00');
INSERT INTO public.users VALUES (30, 'Atalay', 'Karaman', '078-811-7111', 'atalay.karaman@hotmail.com', 'W7W10XRD2Y4', '2023-11-03 00:00:00');
INSERT INTO public.users VALUES (31, 'İsmai̇l', 'İlhan', '012-435-6959', 'l-ismail766@hotmail.com', 'R6L34AEQ3J0', '2024-03-02 00:00:00');
INSERT INTO public.users VALUES (32, 'İbrahi̇m', 'Ersoy', '020-562-6666', 'ersoy.ibrahim@hotmail.com', 'O4L34OYR0C7', '2024-12-02 00:00:00');
INSERT INTO public.users VALUES (33, 'Emre', 'Kılınç', '005-991-6075', 'klnemre6517@hotmail.com', 'Y1P45KKT5O3', '2024-10-31 00:00:00');
INSERT INTO public.users VALUES (34, 'Başak', 'Kurt', '066-784-7864', 'baak-kurt567@hotmail.com', 'B5L49IIV8B5', '2024-12-30 00:00:00');
INSERT INTO public.users VALUES (35, 'Sevi̇m', 'Yılmaz', '048-775-2763', 's_ylmaz3724@google.com', 'L4K86VQL4V2', '2023-10-05 00:00:00');
INSERT INTO public.users VALUES (36, 'Fati̇h', 'Topal', '049-121-8689', 'fatih-topal@google.com', 'R7I80NGS1J4', '2025-01-22 00:00:00');
INSERT INTO public.users VALUES (37, 'Can', 'Coşkun', '058-276-6243', 'ccokun9889@google.com', 'J9S52IDQ4O6', '2023-08-11 00:00:00');
INSERT INTO public.users VALUES (38, 'Nazmi̇ye', 'Atmaca', '049-485-5250', 'atmacanazmiye8136@hotmail.com', 'M8B67EWW4N7', '2024-03-09 00:00:00');
INSERT INTO public.users VALUES (39, 'Ahmet', 'Gürbüz', '039-799-1253', 'a_grbz6469@google.com', 'O4H77EYL2I5', '2024-05-14 00:00:00');
INSERT INTO public.users VALUES (40, 'Alpteki̇n', 'Öztürk', '064-066-8442', 'alptekin_ztrk4848@hotmail.com', 'F4D94HMP7M9', '2024-08-07 00:00:00');
INSERT INTO public.users VALUES (41, 'Şahi̇n', 'Açıkgöz', '068-482-2344', 'akgzahin@google.com', 'I7A52LIV1H9', '2023-01-17 00:00:00');
INSERT INTO public.users VALUES (42, 'Nur', 'Ertürk', '008-815-4238', 'n-ertrk3346@hotmail.com', 'U8K26HJJ5T3', '2023-03-03 00:00:00');
INSERT INTO public.users VALUES (43, 'Canberk', 'Dönmez', '081-547-8229', 'dnmez-canberk@hotmail.com', 'Z3Q65SXH3U9', '2023-02-14 00:00:00');
INSERT INTO public.users VALUES (44, 'Eren', 'Bilgin', '075-841-0317', 'e.bilgin1364@google.com', 'Y9R72SIG7Q9', '2023-07-20 00:00:00');
INSERT INTO public.users VALUES (45, 'Berki̇n', 'Altun', '074-646-6871', 'baltun4431@hotmail.com', 'T1U52WII5P3', '2024-11-26 00:00:00');
INSERT INTO public.users VALUES (46, 'Berkan', 'Oruç', '080-486-2273', 'b-oru@google.com', 'Y4X94WMK6N5', '2024-04-08 00:00:00');
INSERT INTO public.users VALUES (47, 'Ümmügülsüm', 'Ay', '029-541-9406', 'ay.mmglsm1660@hotmail.com', 'R6K96QWC6Q7', '2023-03-04 00:00:00');
INSERT INTO public.users VALUES (48, 'İhsan', 'Akman', '078-351-4131', 'akman-ihsan7164@hotmail.com', 'U1J72SFS3W4', '2025-04-28 00:00:00');
INSERT INTO public.users VALUES (49, 'İbrahi̇m', 'Günay', '083-421-6882', 'g_ibrahim@google.com', 'J3Y84ENI6F0', '2023-04-19 00:00:00');
INSERT INTO public.users VALUES (50, 'Nazli', 'Demir', '036-672-2910', 'n-demir@google.com', 'K5P06SKT3E3', '2023-07-20 00:00:00');
INSERT INTO public.users VALUES (51, 'Berke', 'Pehlivan', '092-971-8680', 'pehlivan-berke@google.com', 'H2L92MKH6D1', '2023-01-03 00:00:00');
INSERT INTO public.users VALUES (52, 'Mustafa', 'Güleç', '091-556-4358', 'mgle@hotmail.com', 'L3J69JML3J2', '2024-01-13 00:00:00');
INSERT INTO public.users VALUES (53, 'Gül', 'Avcı', '067-806-9264', 'g.avc2450@hotmail.com', 'Y8Q02JMS9Q8', '2023-02-04 00:00:00');
INSERT INTO public.users VALUES (54, 'Ali̇', 'Bilgin', '021-017-2845', 'a_bilgin@google.com', 'C8N82GWI8H8', '2023-09-18 00:00:00');
INSERT INTO public.users VALUES (55, 'Kemal', 'Akpınar', '024-795-7495', 'k.akpnar8436@hotmail.com', 'V8N88UWW6X9', '2024-08-30 00:00:00');
INSERT INTO public.users VALUES (56, 'Ali̇', 'Ünal', '018-548-9015', 'nal-ali6596@google.com', 'Z2X55RQS0J7', '2024-11-21 00:00:00');
INSERT INTO public.users VALUES (57, 'Caner', 'Doğru', '067-055-6011', 'canerdoru@google.com', 'T3H11RLZ3K3', '2023-07-22 00:00:00');
INSERT INTO public.users VALUES (58, 'Ahmet', 'Karataş', '078-873-7242', 'karata.ahmet@hotmail.com', 'S7J49HRB4N8', '2023-03-01 00:00:00');
INSERT INTO public.users VALUES (59, 'Gülseren', 'Savaş', '087-970-4155', 'gsava@google.com', 'Y3L47IWH3G4', '2023-07-20 00:00:00');
INSERT INTO public.users VALUES (60, 'Zeynep', 'Eker', '066-502-8358', 'z.eker@google.com', 'I8M48YZP0B6', '2025-01-28 00:00:00');
INSERT INTO public.users VALUES (61, 'Hami̇t', 'Güleç', '053-237-9865', 'gle-hamit@google.com', 'G8K57KKJ6W7', '2024-03-24 00:00:00');
INSERT INTO public.users VALUES (62, 'Atahan', 'Şeker', '047-057-0313', 'eker_atahan@hotmail.com', 'D2N81NOQ7R6', '2023-04-02 00:00:00');
INSERT INTO public.users VALUES (63, 'Canberk', 'Tuna', '082-114-5475', 't_canberk@hotmail.com', 'N4J41NOR2E0', '2024-01-22 00:00:00');
INSERT INTO public.users VALUES (64, 'Suna', 'Şanli', '051-854-5441', 's.anli5493@hotmail.com', 'Q6V45QXW3Q3', '2024-09-09 00:00:00');
INSERT INTO public.users VALUES (65, 'Kubilay', 'Ertaş', '025-553-4416', 'k-erta@google.com', 'C8V54EVA4X1', '2023-05-01 00:00:00');
INSERT INTO public.users VALUES (66, 'Berkay', 'Özen', '072-546-6222', 'zen.berkay8369@google.com', 'V5B05TIW8K6', '2024-04-14 00:00:00');
INSERT INTO public.users VALUES (67, 'Leyla', 'Akın', '042-117-8739', 'l-akn@google.com', 'L5Q80KYD5N9', '2024-05-16 00:00:00');
INSERT INTO public.users VALUES (68, 'Süleyman', 'Sert', '032-434-8083', 'ssert@hotmail.com', 'W5X35IAN2L1', '2024-01-05 00:00:00');
INSERT INTO public.users VALUES (69, 'Caner', 'Karaman', '014-566-4145', 'caner_karaman@google.com', 'C6O70HNE5J1', '2024-05-10 00:00:00');
INSERT INTO public.users VALUES (70, 'Nur', 'Bakır', '031-863-7572', 'bakr-nur3484@hotmail.com', 'F7R48MXP8J2', '2024-08-23 00:00:00');
INSERT INTO public.users VALUES (71, 'Mehmet', 'Ertaş', '070-265-3150', 'emehmet2656@hotmail.com', 'H4O96WYY7P5', '2023-05-14 00:00:00');
INSERT INTO public.users VALUES (72, 'İbrahi̇m', 'Erkan', '068-317-1335', 'erkan.ibrahim@hotmail.com', 'M1W65HYL0Q4', '2024-10-11 00:00:00');
INSERT INTO public.users VALUES (73, 'Ergun', 'Çelik', '041-401-6045', 'ergun_elik1431@google.com', 'W8U69ZZU6Z7', '2024-11-01 00:00:00');
INSERT INTO public.users VALUES (74, 'Sevim', 'Demirci', '049-344-4488', 'd.sevim@google.com', 'H4K59LTH5L3', '2023-01-02 00:00:00');
INSERT INTO public.users VALUES (75, 'Abuzer', 'Göktaş', '089-788-0106', 'a_gkta@google.com', 'B7H34JVT2P6', '2023-02-26 00:00:00');
INSERT INTO public.users VALUES (76, 'Gülten', 'Coşkun', '048-089-2495', 'c.glten@google.com', 'F1J38CKK6T3', '2024-04-01 00:00:00');
INSERT INTO public.users VALUES (77, 'Başak', 'Kılınç', '037-510-4641', 'kln_baak@hotmail.com', 'H6O89RBI4N9', '2023-09-27 00:00:00');
INSERT INTO public.users VALUES (78, 'Keri̇m', 'İlhan', '053-048-5784', 'lhan_kerim@hotmail.com', 'J1U17MLQ6U6', '2023-04-11 00:00:00');
INSERT INTO public.users VALUES (79, 'Atalay', 'Koca', '043-687-1626', 'atalay.koca@hotmail.com', 'J3I84HSC3M4', '2023-04-28 00:00:00');
INSERT INTO public.users VALUES (80, 'Süleyman', 'Bolat', '015-816-6109', 's-bolat@google.com', 'D9Y74RRL0Q4', '2024-06-14 00:00:00');
INSERT INTO public.users VALUES (81, 'Olcay', 'Gündoğdu', '078-847-0317', 'olcay-gndodu7310@hotmail.com', 'K9L11UGP5O3', '2024-12-11 00:00:00');
INSERT INTO public.users VALUES (82, 'Yusuf', 'Çiftçi', '031-722-2663', 'yifti1246@hotmail.com', 'S2F30REO1Y8', '2023-05-02 00:00:00');
INSERT INTO public.users VALUES (83, 'Şahi̇n', 'Boz', '090-158-5107', 'bozahin@google.com', 'D7P76OQM5D8', '2025-02-22 00:00:00');
INSERT INTO public.users VALUES (84, 'Ahmet', 'Karadeniz', '031-421-8452', 'a-karadeniz9288@google.com', 'Q1S44XJJ2S2', '2024-11-19 00:00:00');
INSERT INTO public.users VALUES (85, 'Zehra', 'Kandemir', '071-725-9474', 'z-kandemir@google.com', 'V2X86DLY5K6', '2023-06-04 00:00:00');
INSERT INTO public.users VALUES (86, 'Meral', 'Öztürk', '045-945-1256', 'ztrk_meral@google.com', 'R0S14KTM4H8', '2024-12-14 00:00:00');
INSERT INTO public.users VALUES (87, 'Zehra', 'Dönmez', '026-774-6638', 'z-dnmez@google.com', 'Y5Q75TVS6U1', '2023-11-27 00:00:00');
INSERT INTO public.users VALUES (88, 'Mehmet', 'Şener', '009-866-5443', 'enermehmet2177@google.com', 'Q8H61JIB3B5', '2023-12-10 00:00:00');
INSERT INTO public.users VALUES (89, 'Berk', 'Zengin', '062-735-7224', 'b-zengin@google.com', 'P5C50RSO1G4', '2025-03-02 00:00:00');
INSERT INTO public.users VALUES (90, 'Gül', 'Çolak', '064-338-5888', 'g_olak@google.com', 'Q2D53LQK7Q0', '2023-10-18 00:00:00');
INSERT INTO public.users VALUES (91, 'Dilek', 'Adıgüzel', '032-044-0443', 'adgzel-dilek@google.com', 'O3V73TWU6L0', '2024-05-03 00:00:00');
INSERT INTO public.users VALUES (92, 'Suna', 'Gündoğdu', '097-311-7863', 'gndodu_suna@hotmail.com', 'G7P27COD5Y6', '2023-05-19 00:00:00');
INSERT INTO public.users VALUES (93, 'Caner', 'Savaş', '031-680-8354', 'c-sava@hotmail.com', 'N3G44FNV2O7', '2024-11-18 00:00:00');
INSERT INTO public.users VALUES (94, 'Ümmü', 'Altıntaş', '004-813-5227', 'altntamm@hotmail.com', 'B6P34CQT4Q8', '2023-05-28 00:00:00');
INSERT INTO public.users VALUES (95, 'Berki̇n', 'Yücel', '004-023-3495', 'ycel_berkin3249@hotmail.com', 'L2W04VGL5A1', '2024-04-08 00:00:00');
INSERT INTO public.users VALUES (96, 'Berki̇n', 'Boz', '025-885-3446', 'b_berkin9429@hotmail.com', 'Y2U74BXN2J0', '2024-08-08 00:00:00');
INSERT INTO public.users VALUES (97, 'Melek', 'Ergün', '016-563-0628', 'm-ergn983@hotmail.com', 'M9H74OLY4H8', '2025-03-09 00:00:00');
INSERT INTO public.users VALUES (98, 'Nuriye', 'Arslan', '075-075-4615', 'n-arslan@google.com', 'S9U53JOE8M7', '2024-12-08 00:00:00');
INSERT INTO public.users VALUES (99, 'Gülcan', 'Eren', '065-898-4342', 'eren_glcan8322@hotmail.com', 'T3Q84ABQ2M9', '2023-08-14 00:00:00');
INSERT INTO public.users VALUES (100, 'Ebru', 'Esen', '072-231-2777', 'esen-ebru@google.com', 'M8X33JIR6R1', '2024-11-07 00:00:00');
INSERT INTO public.users VALUES (101, 'Abdullah', 'Pehlivan', '015-578-5469', 'pehlivan.abdullah412@hotmail.com', 'K6E21YVR6P6', '2023-12-29 00:00:00');
INSERT INTO public.users VALUES (102, 'Manolya', 'Albayrak', '029-797-8172', 'm-albayrak2904@google.com', 'P4K63GSG7X6', '2025-03-09 00:00:00');
INSERT INTO public.users VALUES (103, 'Eda', 'Uğur', '060-271-8782', 'uur_eda@google.com', 'D1W52LFS3J5', '2023-09-18 00:00:00');
INSERT INTO public.users VALUES (104, 'İsmai̇l', 'Fidan', '012-251-8664', 'ifidan@hotmail.com', 'H4D83EDH6I5', '2023-06-27 00:00:00');
INSERT INTO public.users VALUES (105, 'Cemre', 'Yılmaz', '095-530-1221', 'c_ylmaz@hotmail.com', 'Y3I31SLK0Q4', '2023-11-22 00:00:00');
INSERT INTO public.users VALUES (106, 'Yasemin', 'Akdoğan', '077-764-5241', 'a-yasemin@google.com', 'X5Y65IBO7D9', '2025-03-06 00:00:00');
INSERT INTO public.users VALUES (107, 'Havva', 'Şentürk', '063-711-3895', 'entrk.havva8832@google.com', 'R4I68OMJ6T2', '2024-10-24 00:00:00');
INSERT INTO public.users VALUES (108, 'Berkehan', 'Akman', '012-159-5682', 'bakman9901@hotmail.com', 'P0U09IPR4C4', '2023-02-15 00:00:00');
INSERT INTO public.users VALUES (109, 'Elmas', 'Güner', '031-024-6826', 'elmas.gner5670@google.com', 'M9J83MHU1B7', '2023-07-30 00:00:00');
INSERT INTO public.users VALUES (110, 'Nazi̇re', 'Altıntaş', '049-273-2597', 'anazire2753@google.com', 'T5Z17BXB6V1', '2024-06-19 00:00:00');
INSERT INTO public.users VALUES (111, 'İbrahi̇m', 'Akman', '053-893-1156', 'aibrahim@google.com', 'O3V87ZNO4D6', '2023-04-10 00:00:00');
INSERT INTO public.users VALUES (112, 'Nazar', 'Kuru', '006-193-3576', 'kuru.nazar9975@google.com', 'A3T32BKG7O1', '2025-02-09 00:00:00');
INSERT INTO public.users VALUES (113, 'Adem', 'Alkan', '059-637-4566', 'a.alkan@google.com', 'B2N06LYJ4E0', '2025-03-22 00:00:00');
INSERT INTO public.users VALUES (114, 'Berki̇n', 'Ertaş', '058-904-2491', 'berkin-erta@google.com', 'X4O21LZM1N6', '2023-09-25 00:00:00');
INSERT INTO public.users VALUES (115, 'Kemal', 'Oruç', '065-339-2462', 'k.oru@google.com', 'T8B45ZRE2I4', '2024-11-25 00:00:00');
INSERT INTO public.users VALUES (116, 'Burak', 'Ceylan', '098-613-3337', 'burak-ceylan8285@hotmail.com', 'G1V61HHG5G6', '2025-01-02 00:00:00');
INSERT INTO public.users VALUES (117, 'İsmai̇L', 'Uğurlu', '047-548-2548', 'ismail-uurlu812@google.com', 'E9U11GTI0B2', '2024-06-14 00:00:00');
INSERT INTO public.users VALUES (118, 'İsmai̇l', 'Dursun', '042-751-4248', 'd-ismail@hotmail.com', 'I2G63FLM6R7', '2025-01-20 00:00:00');
INSERT INTO public.users VALUES (119, 'Dilek', 'Akçay', '037-847-6306', 'a-dilek@google.com', 'F9B73IRC1L3', '2024-02-01 00:00:00');
INSERT INTO public.users VALUES (120, 'Ataman', 'Öz', '052-783-4126', 'z-ataman@google.com', 'S8X58TKG3M7', '2024-08-06 00:00:00');
INSERT INTO public.users VALUES (121, 'Cansu', 'Avcı', '008-240-7572', 'c.avc@hotmail.com', 'O4N13CMM9T1', '2024-08-10 00:00:00');
INSERT INTO public.users VALUES (122, 'Kemal', 'Demirel', '084-246-5352', 'demirel_kemal@hotmail.com', 'U5B44VEL4A7', '2024-09-02 00:00:00');
INSERT INTO public.users VALUES (123, 'Manolya', 'Aydemir', '017-778-9377', 'manolyaaydemir@hotmail.com', 'O5T23GIS8F8', '2023-07-29 00:00:00');
INSERT INTO public.users VALUES (124, 'Cemali̇', 'Ak', '049-403-1425', 'c-ak7938@hotmail.com', 'M4X64ZAD6W8', '2024-03-07 00:00:00');
INSERT INTO public.users VALUES (125, 'Emre', 'Çetinkaya', '013-546-3115', 'etinkaya-emre7464@google.com', 'G4E26LGR7Q6', '2023-12-02 00:00:00');
INSERT INTO public.users VALUES (126, 'Ali̇can', 'Akdeniz', '087-214-5014', 'a_akdeniz@hotmail.com', 'Q3T25JXQ1F3', '2023-03-28 00:00:00');
INSERT INTO public.users VALUES (127, 'Fi̇li̇z', 'Çam', '013-827-6298', 'am-filiz@hotmail.com', 'C5A62SHN7L2', '2024-03-17 00:00:00');
INSERT INTO public.users VALUES (128, 'Serhat', 'Güven', '087-582-3787', 'serhat_gven5247@hotmail.com', 'Y2X30QHQ9S8', '2024-01-26 00:00:00');
INSERT INTO public.users VALUES (129, 'Nazan', 'Gül', '069-915-3783', 'gl.nazan8799@hotmail.com', 'R4U65RGD1T5', '2024-02-27 00:00:00');
INSERT INTO public.users VALUES (130, 'Can', 'Altın', '082-518-7432', 'a_can5611@hotmail.com', 'K2B94QSX3A2', '2024-07-15 00:00:00');
INSERT INTO public.users VALUES (131, 'Şennur', 'Can', '049-569-1253', 'can-ennur@google.com', 'W4S04ESR0W7', '2024-06-19 00:00:00');
INSERT INTO public.users VALUES (132, 'Şenay', 'Türkoğlu', '035-267-2308', 'trkolu-enay3347@google.com', 'D0G65QRX6S2', '2023-10-24 00:00:00');
INSERT INTO public.users VALUES (133, 'Gürsel', 'Esen', '000-126-5386', 'grsel_esen@google.com', 'I4F07TMY1N2', '2024-09-08 00:00:00');
INSERT INTO public.users VALUES (134, 'Ali̇', 'Karagöz', '024-016-2722', 'akaragz2154@google.com', 'N6G58YOL2P0', '2025-01-06 00:00:00');
INSERT INTO public.users VALUES (135, 'Nazlican', 'Akçay', '077-063-5492', 'akay-nazlican191@google.com', 'N8R42SXU0N2', '2024-03-14 00:00:00');
INSERT INTO public.users VALUES (136, 'Ümmügülsüm', 'Erol', '051-148-7512', 'erol.mmglsm5272@hotmail.com', 'F1X66HVL6A5', '2023-05-27 00:00:00');
INSERT INTO public.users VALUES (137, 'Sali̇h', 'Yücel', '073-535-1585', 'sycel1119@hotmail.com', 'T1V84YLL3H9', '2024-03-05 00:00:00');
INSERT INTO public.users VALUES (138, 'Gülay', 'Sezgin', '086-255-5122', 'g.sezgin@google.com', 'V4F98VRI1V1', '2024-05-02 00:00:00');
INSERT INTO public.users VALUES (139, 'Hakan', 'Şen', '001-786-1555', 'en-hakan@hotmail.com', 'X3C46OPJ9Z3', '2025-03-15 00:00:00');
INSERT INTO public.users VALUES (140, 'Zehra', 'Uğurlu', '025-101-3573', 'u-zehra1876@hotmail.com', 'G1P66EKR1M2', '2023-07-12 00:00:00');
INSERT INTO public.users VALUES (141, 'Sevi̇n', 'Akdeniz', '078-270-1627', 's_akdeniz8521@hotmail.com', 'C1J34ZWX1M1', '2023-02-14 00:00:00');
INSERT INTO public.users VALUES (142, 'Cemi̇l', 'Çakar', '028-276-2219', 'c-akar@google.com', 'F1F30BTX3B7', '2024-06-01 00:00:00');
INSERT INTO public.users VALUES (143, 'Canan', 'Özkan', '017-372-0382', 'zkan-canan1343@google.com', 'L8L22EKY0T6', '2024-12-06 00:00:00');
INSERT INTO public.users VALUES (144, 'Ceren', 'Metin', '025-887-2238', 'metin.ceren@hotmail.com', 'U6D45PVK3L6', '2023-09-07 00:00:00');
INSERT INTO public.users VALUES (145, 'Havva', 'Mutlu', '025-873-7952', 'mutlu-havva@hotmail.com', 'M1X71VGX2H6', '2023-06-01 00:00:00');
INSERT INTO public.users VALUES (146, 'Nurcan', 'Erdoğan', '073-482-1552', 'erdoan.nurcan@google.com', 'Y3D26XHP9D6', '2024-05-06 00:00:00');
INSERT INTO public.users VALUES (147, 'Nurhan', 'Güler', '065-426-2261', 'gler-nurhan@hotmail.com', 'X3L44JNQ1D7', '2024-05-09 00:00:00');
INSERT INTO public.users VALUES (148, 'Esra', 'Ertürk', '057-242-8573', 'ertrk.esra889@google.com', 'I2J97WPA5B8', '2024-03-10 00:00:00');
INSERT INTO public.users VALUES (149, 'Hasan', 'Tuna', '071-910-2772', 'tuna_hasan7544@hotmail.com', 'D1K19LHO7K1', '2025-04-26 00:00:00');
INSERT INTO public.users VALUES (150, 'Alper', 'Erdem', '038-196-5616', 'aerdem@google.com', 'M6S53CFU4R7', '2024-04-25 00:00:00');
INSERT INTO public.users VALUES (151, 'Gürsel', 'Ergin', '031-057-8230', 'ergin-grsel@google.com', 'W4R31MTB3F6', '2025-03-21 00:00:00');
INSERT INTO public.users VALUES (152, 'Ayşen', 'Eser', '051-786-7695', 'ayen-eser@google.com', 'C5Y60FPF1U7', '2023-01-15 00:00:00');
INSERT INTO public.users VALUES (153, 'Atabey', 'Bal', '055-812-3405', 'bal-atabey121@hotmail.com', 'R2P22ZHN3Q6', '2023-06-11 00:00:00');
INSERT INTO public.users VALUES (154, 'Temel', 'Kutlu', '073-525-6729', 't-kutlu@google.com', 'B3H92FCB4F2', '2024-07-24 00:00:00');
INSERT INTO public.users VALUES (155, 'Ayşegül', 'Gürsoy', '051-134-6534', 'gayegl9806@hotmail.com', 'Q9P60XVH4A4', '2024-10-04 00:00:00');
INSERT INTO public.users VALUES (156, 'Mehmet', 'Topal', '003-353-8103', 'topal-mehmet@hotmail.com', 'H9X68OVA8L6', '2024-12-09 00:00:00');
INSERT INTO public.users VALUES (157, 'Ercan', 'Kaya', '085-377-9758', 'kaya-ercan2733@hotmail.com', 'Q4R75HOT1W4', '2024-08-16 00:00:00');
INSERT INTO public.users VALUES (158, 'Sudenur', 'Şimşek', '012-204-5083', 'sudenurimek@google.com', 'T8H97XQF6Q3', '2024-02-10 00:00:00');
INSERT INTO public.users VALUES (159, 'Nuriye', 'Avcı', '067-717-2233', 'n_avc4007@google.com', 'J6Y11JGF8H1', '2024-01-03 00:00:00');
INSERT INTO public.users VALUES (160, 'Şerife', 'Karakaş', '009-815-4182', 'karaka_erife272@google.com', 'P1W47QQS8F5', '2023-08-16 00:00:00');
INSERT INTO public.users VALUES (161, 'Nurten', 'Ünsal', '052-327-5366', 'nurten_nsal@hotmail.com', 'W8X65UBM3Y7', '2024-07-17 00:00:00');
INSERT INTO public.users VALUES (162, 'Sümeyra', 'Demirel', '063-718-8812', 'demirel.smeyra5966@hotmail.com', 'O8F57MJW1Y5', '2023-12-14 00:00:00');
INSERT INTO public.users VALUES (163, 'Şengül', 'Göktaş', '065-238-6266', 'gkta-engl353@hotmail.com', 'X2B26BOR3F3', '2023-07-02 00:00:00');
INSERT INTO public.users VALUES (164, 'Canberk', 'Çınar', '045-962-8839', 'canberk-nar7593@hotmail.com', 'C0E55KUN2H4', '2024-07-02 00:00:00');
INSERT INTO public.users VALUES (165, 'Gülay', 'Budak', '040-681-9665', 'g.budak6832@hotmail.com', 'M5X48VOR3N4', '2025-03-09 00:00:00');
INSERT INTO public.users VALUES (166, 'İbrahi̇m', 'Gültekin', '062-385-3813', 'ibrahim_gltekin431@google.com', 'H3F51IXB6N3', '2024-10-13 00:00:00');
INSERT INTO public.users VALUES (167, 'Alparslan', 'Ay', '086-351-5450', 'a-ay7607@google.com', 'J7H19EVP4Q6', '2025-01-23 00:00:00');
INSERT INTO public.users VALUES (168, 'Nur', 'Bulut', '086-017-8776', 'bulut_nur6237@google.com', 'S0Y66ZHA7C7', '2024-12-31 00:00:00');
INSERT INTO public.users VALUES (169, 'Buket', 'Altıntaş', '014-044-1475', 'b-altnta3016@hotmail.com', 'J2A61YLG6U8', '2023-04-18 00:00:00');
INSERT INTO public.users VALUES (170, 'Gülşen', 'Akdağ', '011-470-1257', 'g-akda9015@google.com', 'H2L13CCY1I2', '2023-09-07 00:00:00');
INSERT INTO public.users VALUES (171, 'Berkan', 'Aygün', '083-642-4596', 'aygn_berkan2494@hotmail.com', 'U3K24XZR2P6', '2024-07-24 00:00:00');
INSERT INTO public.users VALUES (172, 'Sevi̇m', 'Çimen', '036-223-6057', 's.imen8341@google.com', 'A4Q27UKK6J3', '2024-04-04 00:00:00');
INSERT INTO public.users VALUES (173, 'Nazi̇k', 'Ak', '036-686-2338', 'ak-nazik@google.com', 'N5H10KCE1O2', '2024-11-20 00:00:00');
INSERT INTO public.users VALUES (174, 'Berkant', 'Zengin', '081-118-5027', 'zengin_berkant4304@google.com', 'E9L22LOE6Y3', '2023-12-19 00:00:00');
INSERT INTO public.users VALUES (175, 'Rıza', 'Altıntaş', '001-473-2405', 'altnta.rza7043@hotmail.com', 'F6Z74VVV6T7', '2023-02-14 00:00:00');
INSERT INTO public.users VALUES (176, 'Ali̇şan', 'Kaya', '038-202-6042', 'alian-kaya@google.com', 'U4S16UOL2B1', '2023-07-15 00:00:00');
INSERT INTO public.users VALUES (177, 'Melike', 'Kara', '082-548-5633', 'm-kara@hotmail.com', 'U8F76XVV1V3', '2024-02-11 00:00:00');
INSERT INTO public.users VALUES (178, 'Sudenur', 'Önal', '012-690-1505', 's_nal@hotmail.com', 'Y4P71JBE6L3', '2025-01-11 00:00:00');
INSERT INTO public.users VALUES (179, 'Osman', 'Güven', '000-118-8211', 'o-gven4840@hotmail.com', 'I8P18XQV1Q6', '2023-02-12 00:00:00');
INSERT INTO public.users VALUES (180, 'Ataberk', 'Akay', '051-010-2785', 'akay-ataberk7009@google.com', 'J0W10MAW3B6', '2024-06-11 00:00:00');
INSERT INTO public.users VALUES (181, 'Ayşegül', 'Sarı', '092-224-5112', 'sar-ayegl1187@hotmail.com', 'A3Z85RKP6M4', '2023-10-11 00:00:00');
INSERT INTO public.users VALUES (182, 'Alpay', 'Koçak', '071-853-1144', 'koak-alpay2768@google.com', 'R3U96PIE1Q6', '2023-08-23 00:00:00');
INSERT INTO public.users VALUES (183, 'Nazi̇k', 'Uğur', '020-119-8478', 'n.uur@google.com', 'W0R80WHA3T3', '2024-01-29 00:00:00');
INSERT INTO public.users VALUES (184, 'Şenel', 'Ay', '081-223-7958', 'a-enel6792@google.com', 'I6J11UVV3W7', '2023-10-18 00:00:00');
INSERT INTO public.users VALUES (185, 'Nazar', 'Doğru', '001-885-7814', 'nazar_doru4841@hotmail.com', 'Q4Z42JLI2D7', '2024-09-12 00:00:00');
INSERT INTO public.users VALUES (186, 'Gürsel', 'Sağlam', '094-384-3479', 'salam.grsel@google.com', 'J5F25GLY7R1', '2023-04-04 00:00:00');
INSERT INTO public.users VALUES (187, 'Berk', 'Özcan', '013-955-4053', 'zcan-berk@google.com', 'V0U80RGV9R6', '2024-05-30 00:00:00');
INSERT INTO public.users VALUES (188, 'Cemre', 'Köse', '067-345-2226', 'k-cemre4350@google.com', 'Y8N18AMD4C3', '2024-02-17 00:00:00');
INSERT INTO public.users VALUES (189, 'Tuğba', 'Aras', '069-523-7227', 'taras@hotmail.com', 'F8Y05VEK3K7', '2024-11-25 00:00:00');
INSERT INTO public.users VALUES (190, 'Canan', 'Er', '088-336-7359', 'ercanan@google.com', 'K9F24EOK1J3', '2023-06-21 00:00:00');
INSERT INTO public.users VALUES (191, 'Nuretti̇n', 'Şenol', '074-823-2476', 'n-enol@google.com', 'Y6Q80MWD6I2', '2024-06-25 00:00:00');
INSERT INTO public.users VALUES (192, 'Mustafa', 'Gün', '008-856-2343', 'g-mustafa2812@hotmail.com', 'O2H08JKI5L0', '2023-11-05 00:00:00');
INSERT INTO public.users VALUES (193, 'Nazlican', 'Efe', '028-762-2352', 'efe_nazlican@google.com', 'X5G16LIX0E6', '2024-02-08 00:00:00');
INSERT INTO public.users VALUES (194, 'Berk', 'Sezgin', '014-498-5672', 'sezgin-berk4798@hotmail.com', 'S0O66PHN1H1', '2025-01-23 00:00:00');
INSERT INTO public.users VALUES (195, 'Alptuğ', 'Çetin', '069-352-2564', 'etinalptu@google.com', 'Z4N29NTS8H7', '2024-02-16 00:00:00');
INSERT INTO public.users VALUES (196, 'Kubilay', 'Günay', '053-135-2243', 'gnay-kubilay@google.com', 'D8U45MUY8Z5', '2023-09-22 00:00:00');
INSERT INTO public.users VALUES (197, 'Berke', 'Oğuz', '014-125-7483', 'ouzberke@hotmail.com', 'G0Y02BLV1Q8', '2023-07-03 00:00:00');
INSERT INTO public.users VALUES (198, 'Olcay', 'Balcı', '032-972-5561', 'o_balc9487@google.com', 'C3I75XYJ4Y2', '2023-03-29 00:00:00');
INSERT INTO public.users VALUES (199, 'Keri̇m', 'Bektaş', '085-730-9496', 'bekta.kerim@google.com', 'W3C66DTT2S4', '2025-01-23 00:00:00');
INSERT INTO public.users VALUES (200, 'Ali̇can', 'Gür', '046-305-1206', 'a_gr2316@google.com', 'I2J35MIC1J9', '2024-03-08 00:00:00');
INSERT INTO public.users VALUES (201, 'Büşra', 'Koç', '044-116-9767', 'ko.bra8751@google.com', 'Y6E47DAF3N1', '2024-10-22 00:00:00');
INSERT INTO public.users VALUES (202, 'Cemre', 'Altay', '052-489-4588', 'a_cemre2459@hotmail.com', 'W4P17TIE4T7', '2024-11-09 00:00:00');
INSERT INTO public.users VALUES (203, 'Gülay', 'Usta', '061-231-8558', 'usta-glay782@hotmail.com', 'G1I76TBR7Q5', '2024-02-26 00:00:00');
INSERT INTO public.users VALUES (204, 'Semra', 'Tuna', '050-558-2757', 'tunasemra9752@google.com', 'C3B03FHP6S8', '2025-04-15 00:00:00');
INSERT INTO public.users VALUES (205, 'Hatice', 'Türkmen', '045-191-7687', 'trkmen.hatice@google.com', 'G1Y40JST0P1', '2024-01-05 00:00:00');
INSERT INTO public.users VALUES (206, 'Atahan', 'Özçelik', '066-132-3417', 'zelik_atahan7834@google.com', 'F5B05QIN3H2', '2025-03-27 00:00:00');
INSERT INTO public.users VALUES (207, 'Ayşe', 'Bülbül', '044-303-4056', 'baye@google.com', 'H4S12HSG5Y9', '2023-04-28 00:00:00');
INSERT INTO public.users VALUES (208, 'Gülsüm', 'Çevik', '063-524-5617', 'evik_glsm7769@google.com', 'Z1U78SEN2Z8', '2023-09-12 00:00:00');
INSERT INTO public.users VALUES (209, 'İsmai̇L', 'Ünsal', '034-145-1622', 'nsal.ismail9791@hotmail.com', 'N1S03ZWC5U7', '2024-01-28 00:00:00');
INSERT INTO public.users VALUES (210, 'Ahmet', 'Özbek', '098-186-8604', 'zbekahmet6047@google.com', 'H6L88WND7Y9', '2024-11-22 00:00:00');
INSERT INTO public.users VALUES (211, 'Emi̇n', 'Eker', '037-281-8763', 'e-eker8004@hotmail.com', 'W4U55YPI1I5', '2025-02-15 00:00:00');
INSERT INTO public.users VALUES (212, 'Alpay', 'Akgül', '001-646-1426', 'alpayakgl@google.com', 'C1M76DJE5Y8', '2024-07-14 00:00:00');
INSERT INTO public.users VALUES (213, 'Eda', 'Durak', '039-893-2129', 'durakeda@google.com', 'K2X46VJI9G4', '2023-06-30 00:00:00');
INSERT INTO public.users VALUES (214, 'Berk', 'Türk', '078-325-1066', 't_berk@google.com', 'Q4R15FXQ4I4', '2024-09-09 00:00:00');
INSERT INTO public.users VALUES (215, 'Abuzer', 'Bayrak', '096-554-1892', 'a-bayrak@google.com', 'B7V22CYB1D2', '2024-02-14 00:00:00');
INSERT INTO public.users VALUES (216, 'Cemali̇', 'Doğan', '072-530-4121', 'd_cemali@google.com', 'N4H21ROR6I0', '2024-03-20 00:00:00');
INSERT INTO public.users VALUES (217, 'Sudenaz', 'Uğur', '033-637-2753', 'uur-sudenaz5872@google.com', 'E6P11RXB1U0', '2024-08-14 00:00:00');
INSERT INTO public.users VALUES (218, 'Fi̇li̇z', 'Atmaca', '035-886-3136', 'atmaca.filiz6201@google.com', 'O4R83BTS5K8', '2024-03-12 00:00:00');
INSERT INTO public.users VALUES (219, 'Nursel', 'Eroğlu', '030-134-3444', 'nerolu6514@hotmail.com', 'V5I65QJF2O2', '2023-02-04 00:00:00');
INSERT INTO public.users VALUES (220, 'Ergun', 'Uzun', '066-326-3416', 'uzun.ergun@hotmail.com', 'Q7U88NMT4F2', '2023-02-10 00:00:00');
INSERT INTO public.users VALUES (221, 'Merve', 'Yaman', '072-826-1462', 'y_merve@hotmail.com', 'D5T55YXN6S3', '2024-10-01 00:00:00');
INSERT INTO public.users VALUES (222, 'Berker', 'Acar', '077-791-9934', 'berker-acar9073@hotmail.com', 'X0O31JYB3C8', '2025-04-27 00:00:00');
INSERT INTO public.users VALUES (223, 'Cemaletti̇n', 'Işık', '063-345-4675', 'ik-cemalettin4489@google.com', 'W1H33BYB8V7', '2024-04-13 00:00:00');
INSERT INTO public.users VALUES (224, 'Nida', 'Fidan', '064-376-2342', 'n.fidan3472@google.com', 'N6T76MLH7A7', '2023-06-21 00:00:00');
INSERT INTO public.users VALUES (225, 'Furkan', 'Aydoğan', '095-413-9660', 'f.aydoan@hotmail.com', 'J2Z53TTD3K4', '2023-10-03 00:00:00');
INSERT INTO public.users VALUES (226, 'Sevi̇lay', 'Dinçer', '019-363-8420', 'd.sevilay@google.com', 'X2S44KIO8Y1', '2023-01-16 00:00:00');
INSERT INTO public.users VALUES (227, 'Gülten', 'Alkan', '068-005-2426', 'alkan.glten6982@google.com', 'U1K67PDA3H7', '2023-09-30 00:00:00');
INSERT INTO public.users VALUES (228, 'Nuray', 'Yazici', '023-019-6067', 'yazici.nuray@google.com', 'H7Q86JXK6C5', '2023-03-26 00:00:00');
INSERT INTO public.users VALUES (229, 'Kubilay', 'Çelebi', '035-566-8093', 'kubilayelebi@hotmail.com', 'U8S77EBP2T7', '2023-09-06 00:00:00');
INSERT INTO public.users VALUES (230, 'Cemali̇', 'Köksal', '023-444-4231', 'cemali-kksal855@google.com', 'W6R81PVN2A1', '2023-01-09 00:00:00');
INSERT INTO public.users VALUES (231, 'Mehmet', 'Güzel', '014-555-6134', 'gzelmehmet@google.com', 'M5M13XQI2Y2', '2025-02-08 00:00:00');
INSERT INTO public.users VALUES (232, 'Kardelen', 'Parlak', '073-395-3707', 'k.parlak2267@google.com', 'Q1M56YKL1C1', '2023-01-07 00:00:00');
INSERT INTO public.users VALUES (233, 'Fati̇h', 'Şanli', '052-823-0338', 'fatih.anli6450@google.com', 'J9E62CVH3L7', '2024-01-29 00:00:00');
INSERT INTO public.users VALUES (234, 'Nuriye', 'Yıldız', '082-383-7147', 'yldz.nuriye@google.com', 'C5V92NOQ2Y5', '2025-01-07 00:00:00');
INSERT INTO public.users VALUES (235, 'Hasan', 'Ayaz', '023-643-4512', 'ayazhasan1625@hotmail.com', 'K6N37ZXH1J5', '2024-03-03 00:00:00');
INSERT INTO public.users VALUES (236, 'Atacan', 'Bilgin', '049-221-5166', 'bilgin_atacan5430@google.com', 'G1M31KXH3T0', '2023-02-06 00:00:00');
INSERT INTO public.users VALUES (237, 'Güler', 'Fidan', '054-681-6374', 'fidan_gler@hotmail.com', 'P8B22QOG8U5', '2024-07-09 00:00:00');
INSERT INTO public.users VALUES (238, 'İbrahi̇m', 'Koyuncu', '011-810-9911', 'koyuncuibrahim692@hotmail.com', 'G8D58XAE7S8', '2024-06-28 00:00:00');
INSERT INTO public.users VALUES (239, 'Ceren', 'Yaşar', '062-681-9115', 'yceren@hotmail.com', 'I5O78FJU8M2', '2023-07-18 00:00:00');
INSERT INTO public.users VALUES (240, 'Keri̇m', 'Güneş', '025-632-1923', 'kgne9665@google.com', 'X7P62WSQ5K2', '2023-03-05 00:00:00');
INSERT INTO public.users VALUES (241, 'Suzan', 'Ergün', '075-286-5227', 'esuzan4728@google.com', 'P4N63QLE4I8', '2024-04-13 00:00:00');
INSERT INTO public.users VALUES (242, 'Nurten', 'Aydemir', '035-282-5543', 'n-aydemir9003@google.com', 'J5O63QBX7B0', '2023-11-19 00:00:00');
INSERT INTO public.users VALUES (243, 'Nazar', 'Arslan', '043-939-2401', 'arslan-nazar3435@hotmail.com', 'E4R13LUM8F8', '2024-08-15 00:00:00');
INSERT INTO public.users VALUES (244, 'Şennur', 'Özkaya', '061-142-3337', 'z-ennur3201@hotmail.com', 'Y6O82YBC6K2', '2023-05-26 00:00:00');
INSERT INTO public.users VALUES (245, 'Ercan', 'Turhan', '073-125-5197', 'e-turhan@hotmail.com', 'K5C14HXW5U2', '2023-11-15 00:00:00');
INSERT INTO public.users VALUES (246, 'Sudenaz', 'Altuntaş', '014-415-8957', 'a_sudenaz@hotmail.com', 'V9M33XPE4T4', '2024-04-18 00:00:00');
INSERT INTO public.users VALUES (247, 'Berker', 'Kahraman', '065-492-3586', 'b.kahraman3417@google.com', 'M2Z27BSV2W7', '2023-10-04 00:00:00');
INSERT INTO public.users VALUES (248, 'İbrahi̇m', 'Bayraktar', '022-305-2836', 'ibrahimbayraktar7308@hotmail.com', 'I4Q72IVK8W2', '2025-03-20 00:00:00');
INSERT INTO public.users VALUES (249, 'Emre', 'Karadağ', '010-345-8412', 'karada_emre@hotmail.com', 'L6T11HBE2D3', '2023-08-14 00:00:00');
INSERT INTO public.users VALUES (250, 'Melek', 'Temel', '017-088-9199', 'mtemel@hotmail.com', 'M7H02CKN4T1', '2024-06-13 00:00:00');
INSERT INTO public.users VALUES (251, 'Sultan', 'Türk', '067-438-3553', 't.sultan7038@hotmail.com', 'Y2R42XIZ2X6', '2023-02-13 00:00:00');
INSERT INTO public.users VALUES (252, 'Samet', 'Gündoğdu', '088-316-0258', 'g_samet6854@hotmail.com', 'U2P71EOK7D1', '2024-04-03 00:00:00');
INSERT INTO public.users VALUES (253, 'Serhat', 'Güleç', '073-478-0862', 'gserhat5363@hotmail.com', 'M0B77SYU3P1', '2024-03-30 00:00:00');
INSERT INTO public.users VALUES (254, 'Nazlican', 'Şanli', '043-462-0346', 'nazlican.anli@google.com', 'N7K41OUY2U5', '2023-08-31 00:00:00');
INSERT INTO public.users VALUES (255, 'Alp', 'Özmen', '054-446-2035', 'azmen9081@google.com', 'E8N27NJW2R3', '2023-04-21 00:00:00');
INSERT INTO public.users VALUES (256, 'Hanife', 'Atmaca', '097-771-3735', 'atmaca-hanife7784@hotmail.com', 'V2P67GCX4S7', '2024-09-29 00:00:00');
INSERT INTO public.users VALUES (257, 'Cansu', 'Karadağ', '002-829-5377', 'karadacansu@hotmail.com', 'Y1L70UFF5G7', '2023-07-12 00:00:00');
INSERT INTO public.users VALUES (258, 'Ahmet', 'Demircan', '052-865-5856', 'ademircan3030@google.com', 'M7F74ROG7O1', '2024-09-01 00:00:00');
INSERT INTO public.users VALUES (259, 'Gülten', 'Ay', '072-556-4831', 'ay.glten4687@hotmail.com', 'G6Z74WRV5B4', '2024-07-28 00:00:00');
INSERT INTO public.users VALUES (260, 'Nazi̇me', 'Çiçek', '001-228-2330', 'iek-nazime@hotmail.com', 'H1Q75FKH3G0', '2025-02-24 00:00:00');
INSERT INTO public.users VALUES (261, 'Serhat', 'Soylu', '098-770-7124', 'soylu.serhat9119@google.com', 'X2I16YBQ7D2', '2024-09-24 00:00:00');
INSERT INTO public.users VALUES (262, 'Nur', 'Uyar', '023-764-0577', 'n.uyar2697@hotmail.com', 'M8M90TZY3O2', '2023-03-06 00:00:00');
INSERT INTO public.users VALUES (263, 'Enes', 'Turgut', '068-746-5144', 'enes_turgut9658@hotmail.com', 'K8N67QUZ7G2', '2024-08-23 00:00:00');
INSERT INTO public.users VALUES (264, 'Nazi̇k', 'Pehlivan', '053-323-6423', 'pehlivan.nazik@hotmail.com', 'J1I13OVV4C3', '2024-03-31 00:00:00');
INSERT INTO public.users VALUES (265, 'Hami̇t', 'Kaplan', '034-785-2763', 'hamit-kaplan@google.com', 'V6U87GTU5U1', '2024-03-30 00:00:00');
INSERT INTO public.users VALUES (266, 'Ali̇şan', 'Tan', '083-282-1894', 'tan.alian9937@google.com', 'R9I85ATR8Y6', '2023-12-05 00:00:00');
INSERT INTO public.users VALUES (267, 'Nureddi̇n', 'Alkan', '031-258-9725', 'alkan-nureddin@google.com', 'W4Y44SRF5F1', '2023-01-02 00:00:00');
INSERT INTO public.users VALUES (268, 'Alper', 'Kurt', '066-748-8472', 'kurtalper6743@hotmail.com', 'D4Q11SPH2T5', '2024-12-07 00:00:00');
INSERT INTO public.users VALUES (269, 'Sevi̇n', 'Durmaz', '019-519-2868', 'd_sevin2460@google.com', 'M6F74QHB3Y3', '2023-04-15 00:00:00');
INSERT INTO public.users VALUES (270, 'Sevim', 'Çakır', '002-195-0242', 's.akr6829@google.com', 'R6L88PAI5F8', '2024-07-23 00:00:00');
INSERT INTO public.users VALUES (271, 'Abdullah', 'Arslan', '067-193-9386', 'arslan_abdullah@hotmail.com', 'I2E74XHE1B1', '2023-09-12 00:00:00');
INSERT INTO public.users VALUES (272, 'Cansu', 'Gür', '014-495-7484', 'g.cansu@google.com', 'A1H22ODM6F8', '2024-01-26 00:00:00');
INSERT INTO public.users VALUES (273, 'Kemal', 'Dönmez', '081-800-7251', 'dnmezkemal@hotmail.com', 'L0D53ENJ3J3', '2024-05-25 00:00:00');
INSERT INTO public.users VALUES (274, 'Tuğba', 'Şeker', '088-669-6656', 'eker.tuba@hotmail.com', 'L8U85EJP6P2', '2023-09-08 00:00:00');
INSERT INTO public.users VALUES (275, 'Mert', 'Özmen', '045-535-8178', 'mzmen6104@google.com', 'U6P26BNS8Z6', '2025-03-08 00:00:00');
INSERT INTO public.users VALUES (276, 'Berke', 'Zengin', '052-573-2730', 'bzengin@google.com', 'S7U71HRE8B4', '2024-01-27 00:00:00');
INSERT INTO public.users VALUES (277, 'Alpcan', 'Ayaz', '007-613-2363', 'alpcan-ayaz4035@google.com', 'B2I27XTS5R3', '2023-06-17 00:00:00');
INSERT INTO public.users VALUES (278, 'Hakan', 'Usta', '065-744-5178', 'h.usta2078@google.com', 'U8Y07GST7B0', '2024-11-23 00:00:00');
INSERT INTO public.users VALUES (279, 'Suzan', 'Dinçer', '051-651-7729', 'd.suzan9925@hotmail.com', 'W3K68PPA3G7', '2023-05-19 00:00:00');
INSERT INTO public.users VALUES (280, 'Nuriye', 'Yüce', '080-766-4612', 'n_yce9869@google.com', 'H0M10FYJ3P4', '2024-07-23 00:00:00');
INSERT INTO public.users VALUES (281, 'Nurdan', 'Kuş', '055-562-4831', 'ku_nurdan5211@google.com', 'M2D64JYT5C8', '2024-05-08 00:00:00');
INSERT INTO public.users VALUES (282, 'Süleyman', 'Turan', '065-513-4596', 'sleyman_turan8416@google.com', 'K9S74HIV3F7', '2025-03-01 00:00:00');
INSERT INTO public.users VALUES (283, 'Çağla', 'Özmen', '060-198-5881', 'zmen.ala@hotmail.com', 'X7U87YIU6N7', '2023-10-15 00:00:00');
INSERT INTO public.users VALUES (284, 'Şengül', 'Ak', '075-711-6148', 'engl-ak@google.com', 'A0E25AEL7B4', '2023-11-29 00:00:00');
INSERT INTO public.users VALUES (285, 'Songül', 'Kaçar', '031-228-1960', 'songlkaar4259@google.com', 'X8C58VIC3M2', '2023-11-18 00:00:00');
INSERT INTO public.users VALUES (286, 'Dilek', 'Sert', '020-134-3857', 'dsert3419@google.com', 'Z3Z85LNT7V5', '2024-02-11 00:00:00');
INSERT INTO public.users VALUES (287, 'Alphan', 'Mert', '052-845-1568', 'a_mert803@google.com', 'B9H02PBS5M9', '2025-03-09 00:00:00');
INSERT INTO public.users VALUES (288, 'Berki̇n', 'Karaca', '046-086-7248', 'karaca.berkin@hotmail.com', 'B2J00QVY6H3', '2024-11-10 00:00:00');
INSERT INTO public.users VALUES (289, 'Esra', 'Akbulut', '065-571-9140', 'akbulutesra@google.com', 'H5U18CVY2D5', '2024-05-30 00:00:00');
INSERT INTO public.users VALUES (290, 'Kemal', 'Karakuş', '016-152-3655', 'k.kemal@hotmail.com', 'M4T15PQY4J1', '2024-06-02 00:00:00');
INSERT INTO public.users VALUES (291, 'Berker', 'Çınar', '073-046-5151', 'berker.nar8414@hotmail.com', 'X4J18JWE6A9', '2023-12-25 00:00:00');
INSERT INTO public.users VALUES (292, 'Alper', 'Sevinç', '018-251-3542', 'a_sevin3841@hotmail.com', 'O4G13BSB2I6', '2025-02-12 00:00:00');
INSERT INTO public.users VALUES (293, 'Mert', 'Özer', '015-884-0707', 'm-zer3551@google.com', 'R4P11HOE1K6', '2025-04-28 00:00:00');
INSERT INTO public.users VALUES (294, 'Aysel', 'Işık', '051-812-2574', 'a-ik@hotmail.com', 'S6M62LWE3Z2', '2023-05-22 00:00:00');
INSERT INTO public.users VALUES (295, 'Sevi̇m', 'Erdoğan', '042-982-8047', 'serdoan7418@google.com', 'S8N12WPR4W1', '2023-06-28 00:00:00');
INSERT INTO public.users VALUES (296, 'Cansel', 'Bozkurt', '045-523-8858', 'c.bozkurt@hotmail.com', 'Q7N21MPS0C2', '2023-10-11 00:00:00');
INSERT INTO public.users VALUES (297, 'Hasan', 'Topal', '064-653-1579', 'h.topal1266@google.com', 'S6M73OSG5G4', '2023-01-24 00:00:00');
INSERT INTO public.users VALUES (298, 'Ceylan', 'Kaplan', '061-628-4411', 'kaplan_ceylan@hotmail.com', 'T2G61YRS0J3', '2023-07-23 00:00:00');
INSERT INTO public.users VALUES (299, 'Kubilay', 'Ateş', '059-699-0044', 'kate518@hotmail.com', 'U5E65XRT8B2', '2023-08-26 00:00:00');
INSERT INTO public.users VALUES (300, 'Nazi̇re', 'Zengin', '012-223-9068', 'z_nazire6983@hotmail.com', 'U4R81PJS8D8', '2025-02-02 00:00:00');
INSERT INTO public.users VALUES (301, 'Gül', 'Koca', '042-784-8814', 'koca.gl5576@hotmail.com', 'T6G02HQR5D3', '2025-04-20 00:00:00');
INSERT INTO public.users VALUES (302, 'Nazlican', 'Dündar', '085-230-1028', 'd.nazlican@hotmail.com', 'P6Q13AEJ7N8', '2024-02-29 00:00:00');
INSERT INTO public.users VALUES (303, 'Emi̇n', 'Sevim', '023-826-4592', 'emin-sevim@google.com', 'B4T57TUM1G2', '2023-05-29 00:00:00');
INSERT INTO public.users VALUES (304, 'Lale', 'Karadeniz', '028-756-6114', 'l.karadeniz711@google.com', 'J1N14NRG3B9', '2024-05-20 00:00:00');
INSERT INTO public.users VALUES (305, 'Ataberk', 'Ateş', '005-505-1711', 'ate_ataberk@hotmail.com', 'P1M28FXY1F5', '2024-05-11 00:00:00');
INSERT INTO public.users VALUES (306, 'Çiçek', 'Koçak', '085-420-4861', 'i-koak6770@google.com', 'N7U19EPL8T5', '2023-05-26 00:00:00');
INSERT INTO public.users VALUES (307, 'Emirhan', 'Öksüz', '010-220-2869', 'k-emirhan2735@hotmail.com', 'G3Q71GID5M9', '2024-10-01 00:00:00');
INSERT INTO public.users VALUES (308, 'Cemre', 'Arıkan', '019-947-9274', 'arkan.cemre@hotmail.com', 'A2L58KTT3G4', '2023-11-27 00:00:00');
INSERT INTO public.users VALUES (309, 'Manolya', 'Altın', '076-167-5311', 'a-manolya@hotmail.com', 'S1Y57OLE2F8', '2023-03-08 00:00:00');
INSERT INTO public.users VALUES (310, 'Fati̇h', 'Çam', '046-876-5399', 'f_am1321@google.com', 'Y7W97HIO3C6', '2023-10-05 00:00:00');
INSERT INTO public.users VALUES (311, 'Adem', 'Akyol', '045-389-4438', 'akyol-adem3547@hotmail.com', 'D8D91CGU7N6', '2024-10-02 00:00:00');
INSERT INTO public.users VALUES (312, 'Nuretti̇n', 'Aktaş', '063-377-5275', 'n.akta@hotmail.com', 'O8D21JGX7V6', '2024-10-12 00:00:00');
INSERT INTO public.users VALUES (313, 'Hami̇t', 'Orhan', '013-210-1562', 'ohamit@hotmail.com', 'W7Z70NRN4M2', '2023-12-08 00:00:00');
INSERT INTO public.users VALUES (314, 'Fatma', 'Demirbaş', '015-642-1853', 'demirbafatma8742@hotmail.com', 'S2Q72DDX4G9', '2023-07-17 00:00:00');
INSERT INTO public.users VALUES (315, 'Elif', 'Uyar', '089-861-1326', 'elif_uyar@google.com', 'U1O16VBS1N2', '2023-08-22 00:00:00');
INSERT INTO public.users VALUES (316, 'Elif', 'Ünsal', '005-351-3169', 'e.nsal4383@hotmail.com', 'Q3F61NIB3K2', '2023-04-04 00:00:00');
INSERT INTO public.users VALUES (317, 'Kardelen', 'Ergün', '048-787-1433', 'ergnkardelen@google.com', 'F1G21YRX6J4', '2023-10-02 00:00:00');
INSERT INTO public.users VALUES (318, 'Ayşenaz', 'Güleç', '031-771-5625', 'gle.ayenaz@google.com', 'T6B45LMJ2Q1', '2024-04-29 00:00:00');
INSERT INTO public.users VALUES (319, 'Nurten', 'Altun', '086-795-3121', 'altunnurten4758@hotmail.com', 'X7T50DOU3M7', '2023-07-04 00:00:00');
INSERT INTO public.users VALUES (320, 'Meli̇sa', 'Korkmaz', '083-179-1223', 'korkmazmelisa7683@google.com', 'Y4S44GOV6C5', '2024-04-23 00:00:00');
INSERT INTO public.users VALUES (321, 'Hami̇t', 'Kaplan', '058-456-1246', 'k.hamit@google.com', 'N8T63RBS8W4', '2024-09-25 00:00:00');
INSERT INTO public.users VALUES (322, 'Nazan', 'Akça', '081-841-0715', 'nazan.aka5765@google.com', 'Y3H28DGC9W5', '2023-05-03 00:00:00');
INSERT INTO public.users VALUES (323, 'Nurdan', 'Özel', '077-689-6345', 'z_nurdan@google.com', 'V7V14VCF4X8', '2025-02-02 00:00:00');
INSERT INTO public.users VALUES (324, 'Atalay', 'Keleş', '050-121-9834', 'kele_atalay@google.com', 'H8Y24FJL3F7', '2024-05-15 00:00:00');
INSERT INTO public.users VALUES (325, 'Alparslan', 'Demirci', '047-135-4452', 'dalparslan2770@google.com', 'R4F61VWE3S7', '2023-02-11 00:00:00');
INSERT INTO public.users VALUES (326, 'Lale', 'Karakoç', '052-347-8011', 'lale-karako4222@hotmail.com', 'R3R43HNM6W4', '2024-06-23 00:00:00');
INSERT INTO public.users VALUES (327, 'Nuran', 'Akkuş', '017-939-6801', 'nuran-akku@google.com', 'G4T48BEI6A6', '2025-01-14 00:00:00');
INSERT INTO public.users VALUES (328, 'Canberk', 'Turan', '004-872-1384', 'turan_canberk436@hotmail.com', 'X9X77BAF6K3', '2025-03-25 00:00:00');
INSERT INTO public.users VALUES (329, 'Şahi̇n', 'Temel', '034-156-0735', 'temelahin@google.com', 'X7Q39RQF5K8', '2025-02-17 00:00:00');
INSERT INTO public.users VALUES (330, 'Şahi̇n', 'Kılıç', '037-168-5729', 'ahinkl6270@hotmail.com', 'I5Q40IVA0U3', '2024-06-14 00:00:00');
INSERT INTO public.users VALUES (331, 'Nazi̇k', 'Şimşek', '051-847-1374', 'nimek3444@hotmail.com', 'H2G62BUO0N6', '2023-08-25 00:00:00');
INSERT INTO public.users VALUES (332, 'Başak', 'Çetin', '057-752-0423', 'etin-baak@hotmail.com', 'V6O73GTP5B3', '2023-08-08 00:00:00');
INSERT INTO public.users VALUES (333, 'Ali̇han', 'Taşçi', '080-298-9408', 'tai-alihan3402@hotmail.com', 'K3C84PSW6M0', '2025-01-20 00:00:00');
INSERT INTO public.users VALUES (334, 'Mehmet', 'Akçay', '089-509-5223', 'm_akay@google.com', 'X4M86NIC2V3', '2024-10-01 00:00:00');
INSERT INTO public.users VALUES (335, 'Nursel', 'Demirci', '096-137-7624', 'nurseldemirci@hotmail.com', 'N4M18KCB5G6', '2024-03-10 00:00:00');
INSERT INTO public.users VALUES (336, 'Bedirhan', 'Coşkun', '085-191-6022', 'b_cokun@google.com', 'X9L93HOY3T7', '2024-06-13 00:00:00');
INSERT INTO public.users VALUES (337, 'Melek', 'Güzel', '062-331-3781', 'm_gzel@google.com', 'H1M31ABM1N4', '2024-12-16 00:00:00');
INSERT INTO public.users VALUES (338, 'Sümeyra', 'Yalçınkaya', '061-672-6033', 'yalnkaya.smeyra271@google.com', 'L3B63DID8E2', '2024-10-26 00:00:00');
INSERT INTO public.users VALUES (339, 'Murat', 'Öksüz', '014-675-6141', 'ksz.murat@google.com', 'F9D74XXX2G1', '2024-10-26 00:00:00');
INSERT INTO public.users VALUES (340, 'Abdullah', 'Şener', '060-801-8184', 'abdullah_ener@google.com', 'V2D25LVI1O2', '2024-09-10 00:00:00');
INSERT INTO public.users VALUES (341, 'Ahmet', 'Eser', '087-869-4791', 'e-ahmet2706@google.com', 'H8D25LLE3Z5', '2023-03-16 00:00:00');
INSERT INTO public.users VALUES (342, 'Mert', 'Akman', '014-543-7213', 'mert_akman@google.com', 'B1D06KBL4N1', '2024-07-13 00:00:00');
INSERT INTO public.users VALUES (343, 'Serkan', 'Polat', '017-738-6318', 'polatserkan@hotmail.com', 'C0X93FIV8T3', '2024-12-30 00:00:00');
INSERT INTO public.users VALUES (344, 'Nur', 'Göktaş', '025-290-3560', 'gkta_nur9319@google.com', 'T0N33UUF8Q4', '2023-02-05 00:00:00');
INSERT INTO public.users VALUES (345, 'Abdullah', 'Durmaz', '073-759-8368', 'a_durmaz3123@hotmail.com', 'H6A69SRQ5O0', '2024-06-06 00:00:00');
INSERT INTO public.users VALUES (346, 'Nur', 'Göktaş', '086-745-6132', 'ngkta6741@hotmail.com', 'P7J11AFD2J3', '2024-05-08 00:00:00');
INSERT INTO public.users VALUES (347, 'Alp', 'Akgül', '067-312-8948', 'aakgl@hotmail.com', 'G6C30SMN7S3', '2025-04-01 00:00:00');
INSERT INTO public.users VALUES (348, 'Melek', 'Şenol', '021-559-4830', 'm.enol285@hotmail.com', 'Y3Q17UMT5U6', '2023-08-02 00:00:00');
INSERT INTO public.users VALUES (349, 'Şahi̇n', 'Altay', '004-757-3054', 'ahin.altay@google.com', 'P2Q65XQT5F5', '2023-11-26 00:00:00');
INSERT INTO public.users VALUES (350, 'Şengül', 'Keleş', '051-286-5455', 'kele-engl@hotmail.com', 'H1H20WOD9X4', '2023-02-05 00:00:00');
INSERT INTO public.users VALUES (351, 'Sali̇h', 'Topal', '023-992-2207', 's.topal3877@google.com', 'X2R08ZGV8T3', '2023-11-12 00:00:00');
INSERT INTO public.users VALUES (352, 'Ata', 'Altuntaş', '066-432-3432', 'altunta-ata@hotmail.com', 'P7T87OCU0U2', '2024-02-24 00:00:00');
INSERT INTO public.users VALUES (353, 'Nazlican', 'Akbaş', '065-220-4782', 'n.akba1225@hotmail.com', 'C4T58RVO3S2', '2024-10-31 00:00:00');
INSERT INTO public.users VALUES (354, 'Ayşegül', 'Kara', '092-853-2765', 'ayeglkara@google.com', 'N5J63USB7P1', '2023-12-15 00:00:00');
INSERT INTO public.users VALUES (355, 'Nazi̇me', 'Savaş', '069-626-1875', 'nsava@hotmail.com', 'J8X71JRG5T5', '2024-02-05 00:00:00');
INSERT INTO public.users VALUES (356, 'Kadi̇r', 'Şahin', '049-357-4351', 'kadir_ahin5743@google.com', 'U8T57LPY6L9', '2024-03-25 00:00:00');
INSERT INTO public.users VALUES (357, 'Olcay', 'Şeker', '099-015-4222', 'e.olcay@google.com', 'X4F42RZK2O2', '2023-07-13 00:00:00');
INSERT INTO public.users VALUES (358, 'Gülseren', 'Topçu', '087-559-1838', 'tglseren@hotmail.com', 'D5A85CYI8J8', '2023-12-29 00:00:00');
INSERT INTO public.users VALUES (359, 'Manolya', 'Akyol', '083-207-7353', 'm-akyol@hotmail.com', 'F0X74QLT9J5', '2025-05-01 00:00:00');
INSERT INTO public.users VALUES (360, 'Ahmet', 'Güçlü', '025-353-7132', 'ahmet.gl@hotmail.com', 'N6R15PSL9S2', '2023-01-31 00:00:00');
INSERT INTO public.users VALUES (361, 'Şengül', 'Ertürk', '013-043-2498', 'e_ertrk4789@hotmail.com', 'F5B96GTW4B8', '2025-01-17 00:00:00');
INSERT INTO public.users VALUES (362, 'Tayfun', 'Oğuz', '077-764-7393', 't-ouz6924@hotmail.com', 'T0T58EIB5B5', '2023-08-09 00:00:00');
INSERT INTO public.users VALUES (363, 'Gülsüm', 'Erkan', '083-825-3675', 'g_erkan1334@hotmail.com', 'D6L47XJS1U4', '2024-02-25 00:00:00');
INSERT INTO public.users VALUES (364, 'Poyraz', 'Fırat', '027-278-5687', 'f.poyraz@google.com', 'V3X15IKJ4Y1', '2023-12-07 00:00:00');
INSERT INTO public.users VALUES (365, 'Caner', 'Bayraktar', '021-865-2684', 'bayraktarcaner@hotmail.com', 'M3G79VZU5F2', '2023-06-15 00:00:00');
INSERT INTO public.users VALUES (366, 'Nursel', 'Bulut', '064-636-2643', 'n_bulut7387@hotmail.com', 'J7U59BCT1Y0', '2023-07-29 00:00:00');
INSERT INTO public.users VALUES (367, 'Berkcan', 'Yavuz', '067-180-3886', 'berkcanyavuz@hotmail.com', 'P7F61GVP3N3', '2024-06-29 00:00:00');
INSERT INTO public.users VALUES (368, 'Manolya', 'Sezer', '012-465-9555', 'manolya-sezer2714@google.com', 'O2S38RIG1P3', '2024-06-20 00:00:00');
INSERT INTO public.users VALUES (369, 'Gülbahar', 'Güngör', '042-397-4138', 'g.gngr@google.com', 'J4A97TIT2P6', '2024-10-21 00:00:00');
INSERT INTO public.users VALUES (370, 'İbrahi̇m', 'Kahraman', '087-122-0518', 'kahraman-ibrahim1402@hotmail.com', 'F4L23WON6G4', '2023-11-03 00:00:00');
INSERT INTO public.users VALUES (371, 'Çağla', 'Yıldız', '002-017-2886', 'yldz.ala@google.com', 'V2N35FXS1A4', '2023-01-29 00:00:00');
INSERT INTO public.users VALUES (372, 'Furkan', 'Ölmez', '031-419-1324', 'furkan-lmez1416@hotmail.com', 'D8T02BVC3Q6', '2023-06-28 00:00:00');
INSERT INTO public.users VALUES (373, 'Şahi̇n', 'Yıldırım', '073-644-9837', 'yldrm_ahin@google.com', 'X4J88VOE2S4', '2025-02-20 00:00:00');
INSERT INTO public.users VALUES (374, 'Ümmü', 'Bektaş', '073-130-8109', 'bekta-mm2823@google.com', 'S0Y30EMO5J4', '2024-09-27 00:00:00');
INSERT INTO public.users VALUES (375, 'Berkant', 'Yılmaz', '074-276-4197', 'b.ylmaz@google.com', 'L6L58XSI4K3', '2024-08-14 00:00:00');
INSERT INTO public.users VALUES (376, 'Berkay', 'Gül', '058-883-7040', 'b-gl@google.com', 'Y7T38XOT4T3', '2023-07-05 00:00:00');
INSERT INTO public.users VALUES (377, 'Ceylan', 'Şenol', '052-366-5255', 'c.enol@google.com', 'V2P76ZYW4Y4', '2024-12-02 00:00:00');
INSERT INTO public.users VALUES (378, 'Cemi̇l', 'Akgül', '029-151-1424', 'cemil_akgl@hotmail.com', 'D1L34VUG1D8', '2025-04-27 00:00:00');
INSERT INTO public.users VALUES (379, 'Murat', 'Gündüz', '034-553-9745', 'gmurat2427@google.com', 'M3V41AGC3P3', '2025-04-27 00:00:00');
INSERT INTO public.users VALUES (380, 'Nur', 'Aygün', '021-447-8828', 'aygnnur@hotmail.com', 'C4M53FMP7B9', '2024-09-01 00:00:00');
INSERT INTO public.users VALUES (381, 'Azi̇z', 'Uzun', '044-157-0556', 'a_uzun594@google.com', 'M4V41FOY7A7', '2024-05-11 00:00:00');
INSERT INTO public.users VALUES (382, 'Nazan', 'Uğur', '062-226-4817', 'u-nazan@hotmail.com', 'P4U55QHB2J0', '2024-01-16 00:00:00');
INSERT INTO public.users VALUES (383, 'Aynur', 'Durak', '002-893-6935', 'durakaynur4962@hotmail.com', 'G1C55DSW4L8', '2023-06-25 00:00:00');
INSERT INTO public.users VALUES (384, 'Olcay', 'Akkuş', '065-303-2538', 'a.olcay@google.com', 'Y4M02JMT3R3', '2023-12-02 00:00:00');
INSERT INTO public.users VALUES (385, 'Emirhan', 'Fidan', '043-091-1166', 'fidan-emirhan2065@hotmail.com', 'L7H83ZNJ1L7', '2023-11-29 00:00:00');
INSERT INTO public.users VALUES (386, 'Murat', 'Topçu', '074-576-4496', 'mtopu9010@google.com', 'Q1P70OZI6E9', '2023-08-29 00:00:00');
INSERT INTO public.users VALUES (387, 'İsmai̇L', 'Uzun', '036-035-8130', 'uzun.ismail8286@google.com', 'T5H33JCQ9G4', '2023-05-26 00:00:00');
INSERT INTO public.users VALUES (388, 'Berkant', 'Kahraman', '035-063-2717', 'berkant.kahraman9982@google.com', 'J4G82HYJ1T3', '2024-12-29 00:00:00');
INSERT INTO public.users VALUES (389, 'Menekşe', 'Gür', '022-861-1674', 'grmeneke@hotmail.com', 'H8N57ISK2Y8', '2025-04-24 00:00:00');
INSERT INTO public.users VALUES (390, 'Hasan', 'Sevim', '067-038-1157', 'h-sevim@google.com', 'X4J91OMH5G1', '2023-09-11 00:00:00');
INSERT INTO public.users VALUES (391, 'Ümmü', 'Ölmez', '040-380-4778', 'mlmez7002@hotmail.com', 'Q8P66NDX1N8', '2024-09-04 00:00:00');
INSERT INTO public.users VALUES (392, 'Emre', 'Balcı', '013-783-7615', 'balc-emre@hotmail.com', 'X3I79VXW2B4', '2024-01-07 00:00:00');
INSERT INTO public.users VALUES (393, 'Sonat', 'Kartal', '045-257-2332', 'kartal.sonat@google.com', 'N9E34TFL2N5', '2023-05-07 00:00:00');
INSERT INTO public.users VALUES (394, 'Cemi̇l', 'Özdemir', '032-674-1461', 'czdemir6007@hotmail.com', 'J7W14VIM3Y4', '2024-08-05 00:00:00');
INSERT INTO public.users VALUES (395, 'Nur', 'Tuna', '013-633-1030', 't_nur7339@google.com', 'E8Y96CTU8I2', '2023-07-01 00:00:00');
INSERT INTO public.users VALUES (396, 'Berkant', 'Cengiz', '025-829-3287', 'cengiz_berkant5247@google.com', 'K0H78ENW3L3', '2023-07-13 00:00:00');
INSERT INTO public.users VALUES (397, 'Elmas', 'Akdoğan', '012-482-4761', 'e-akdoan@hotmail.com', 'W3N08WYP5Q8', '2024-03-21 00:00:00');
INSERT INTO public.users VALUES (398, 'Büşra', 'Akpınar', '057-773-4829', 'akpnar-bra@hotmail.com', 'M2B35IPU2R3', '2023-11-15 00:00:00');
INSERT INTO public.users VALUES (399, 'Berkehan', 'Güneş', '003-856-6812', 'gneberkehan5954@google.com', 'X5E36TRI5I8', '2024-03-11 00:00:00');
INSERT INTO public.users VALUES (400, 'Berkay', 'Öner', '074-024-7082', 'b_ner2488@hotmail.com', 'J9B78MFN6N1', '2023-12-19 00:00:00');
INSERT INTO public.users VALUES (401, 'Berker', 'Aras', '036-224-8611', 'b-aras8298@hotmail.com', 'L2N16NLE1J3', '2023-05-21 00:00:00');
INSERT INTO public.users VALUES (402, 'Mustafa', 'Dinç', '086-320-7649', 'm_din743@hotmail.com', 'A4U56HVE8J1', '2024-03-01 00:00:00');
INSERT INTO public.users VALUES (403, 'Ayşenaz', 'Şentürk', '043-955-5695', 'ayenaz_entrk7336@hotmail.com', 'J5M13JJP6H2', '2023-06-12 00:00:00');
INSERT INTO public.users VALUES (404, 'Berk', 'Ercan', '035-863-5922', 'berk_ercan@google.com', 'W4Y46ELP8O6', '2025-03-14 00:00:00');
INSERT INTO public.users VALUES (405, 'Fati̇h', 'Eren', '035-842-3343', 'feren@google.com', 'O6H02ZKY5R1', '2024-02-21 00:00:00');
INSERT INTO public.users VALUES (406, 'Sümeyra', 'Tan', '087-443-2710', 'tansmeyra@google.com', 'P6E27OFG6B7', '2024-12-03 00:00:00');
INSERT INTO public.users VALUES (407, 'Rabia', 'Dinç', '045-571-0873', 'rabia.din6003@google.com', 'G6X36SCI5D6', '2025-01-20 00:00:00');
INSERT INTO public.users VALUES (408, 'Nazi̇re', 'Akyüz', '074-006-7697', 'a.nazire9030@hotmail.com', 'N8Q90KOS0H2', '2023-03-10 00:00:00');
INSERT INTO public.users VALUES (409, 'Nureddi̇n', 'Ertaş', '002-493-6155', 'n_erta@hotmail.com', 'A3M18AQU9S9', '2023-01-07 00:00:00');
INSERT INTO public.users VALUES (410, 'Müge', 'Kurt', '028-535-5145', 'kurt.mge@google.com', 'V5P57MHR9I6', '2024-07-01 00:00:00');
INSERT INTO public.users VALUES (411, 'Nurcan', 'Gündoğdu', '064-432-3651', 'gnurcan4461@google.com', 'R3T63IPJ4I8', '2024-07-13 00:00:00');
INSERT INTO public.users VALUES (412, 'Sudenaz', 'Tekin', '027-954-2751', 'sudenaz_tekin6271@google.com', 'J8W83PGE9C4', '2024-07-24 00:00:00');
INSERT INTO public.users VALUES (413, 'Cemali̇', 'Karaca', '024-619-7168', 'cemali_karaca5609@hotmail.com', 'H8C84WER3X7', '2024-12-04 00:00:00');
INSERT INTO public.users VALUES (414, 'Nureddi̇n', 'Çalışkan', '032-822-5081', 'nureddin.alkan@google.com', 'W5N26JSV3E5', '2023-10-07 00:00:00');
INSERT INTO public.users VALUES (415, 'Süleyman', 'Uyar', '078-722-6183', 'sleyman_uyar@google.com', 'X8M67BNX1P4', '2024-12-09 00:00:00');
INSERT INTO public.users VALUES (416, 'Suzan', 'Ak', '082-724-6267', 'a-suzan@google.com', 'F9N24EUE2F6', '2024-12-27 00:00:00');
INSERT INTO public.users VALUES (417, 'Hülya', 'Aslan', '064-921-3441', 'h-aslan2854@hotmail.com', 'V6S35GMR2B1', '2025-04-19 00:00:00');
INSERT INTO public.users VALUES (418, 'Cankat', 'Akbulut', '044-336-2884', 'c-akbulut6353@hotmail.com', 'G6K06DRQ4I6', '2025-03-21 00:00:00');
INSERT INTO public.users VALUES (419, 'Süleyman', 'Akkaya', '040-376-3030', 's.akkaya@hotmail.com', 'R2V17UCC9I9', '2024-11-03 00:00:00');
INSERT INTO public.users VALUES (420, 'Mustafa', 'Ateş', '065-687-1836', 'ate-mustafa@hotmail.com', 'P7W46YWW4G4', '2023-01-20 00:00:00');
INSERT INTO public.users VALUES (421, 'Zeynep', 'Aras', '028-288-4461', 'araszeynep960@google.com', 'U8F13KCM2K3', '2023-08-07 00:00:00');
INSERT INTO public.users VALUES (422, 'Atacan', 'Durmaz', '044-568-4103', 'durmaz.atacan@google.com', 'B8C22SCS3G6', '2023-06-04 00:00:00');
INSERT INTO public.users VALUES (423, 'Atahan', 'Uğur', '087-175-9471', 'uur-atahan314@google.com', 'R2U63VGR5R4', '2023-02-27 00:00:00');
INSERT INTO public.users VALUES (424, 'Çiçek', 'Yeşil', '077-985-3416', 'yeil-iek2210@hotmail.com', 'G2E42YAW5M6', '2024-11-08 00:00:00');
INSERT INTO public.users VALUES (425, 'Ali̇can', 'Özdemir', '077-021-1357', 'azdemir857@google.com', 'I5I72WFG3U8', '2025-02-19 00:00:00');
INSERT INTO public.users VALUES (426, 'Nazan', 'Özer', '039-883-2781', 'zer_nazan@hotmail.com', 'X2H96NGJ3T7', '2024-02-18 00:00:00');
INSERT INTO public.users VALUES (427, 'Cemre', 'Tuna', '041-486-6247', 't.cemre1420@google.com', 'L2G48WFF0D3', '2023-01-13 00:00:00');
INSERT INTO public.users VALUES (428, 'Sultan', 'Gündüz', '026-244-7799', 'sultan_gndz2951@hotmail.com', 'R0Q65BJJ4M9', '2023-08-18 00:00:00');
INSERT INTO public.users VALUES (429, 'Ahmet', 'Yiğit', '063-633-1164', 'a-yiit3573@google.com', 'K9T19DPH8F6', '2023-06-09 00:00:00');
INSERT INTO public.users VALUES (430, 'Atalay', 'Varol', '021-393-6026', 'v.atalay@hotmail.com', 'X8R89CEY6K5', '2023-11-06 00:00:00');
INSERT INTO public.users VALUES (431, 'Mehmet', 'Karahan', '012-764-1625', 'karahan_mehmet4307@hotmail.com', 'G7Z23JUO9Y5', '2024-12-09 00:00:00');
INSERT INTO public.users VALUES (432, 'Sevi̇n', 'Kurt', '061-430-4514', 'kurtsevin@google.com', 'S7K45MEM8C2', '2025-01-10 00:00:00');
INSERT INTO public.users VALUES (433, 'Bedirhan', 'Albayrak', '075-727-7571', 'albayrak.bedirhan@hotmail.com', 'I2M88TRY6F1', '2025-01-14 00:00:00');
INSERT INTO public.users VALUES (434, 'Fadime', 'Çakır', '014-863-2180', 'f.akr6714@google.com', 'L4M33CNU8E1', '2025-03-20 00:00:00');
INSERT INTO public.users VALUES (435, 'Suzan', 'Eser', '049-878-5974', 'eser_suzan@hotmail.com', 'R2K57UPK3B5', '2023-04-05 00:00:00');
INSERT INTO public.users VALUES (436, 'Tayfun', 'Çınar', '068-475-6814', 't_nar572@google.com', 'H2I15DIB6Y6', '2023-05-27 00:00:00');
INSERT INTO public.users VALUES (437, 'Su', 'Usta', '088-851-2835', 'usta-su2424@hotmail.com', 'Q5W22ICF1I9', '2024-05-01 00:00:00');
INSERT INTO public.users VALUES (438, 'Gülsüm', 'Yalçınkaya', '055-279-8373', 'glsm-yalnkaya@hotmail.com', 'Q0W53WSS5S7', '2023-02-27 00:00:00');
INSERT INTO public.users VALUES (439, 'Enes', 'Şener', '015-874-0213', 'eenes@hotmail.com', 'Q5F27FVI3N6', '2024-03-16 00:00:00');
INSERT INTO public.users VALUES (440, 'Nazar', 'Baş', '030-713-6645', 'banazar@hotmail.com', 'Y3Y50ERD5F1', '2023-07-26 00:00:00');
INSERT INTO public.users VALUES (441, 'Nurcan', 'Ünsal', '055-638-4650', 'nsal_nurcan@hotmail.com', 'E6Q71YEZ8G7', '2024-10-03 00:00:00');
INSERT INTO public.users VALUES (442, 'Gül', 'Er', '034-231-9126', 'er-gl@hotmail.com', 'K1F65FBD8J1', '2025-01-01 00:00:00');
INSERT INTO public.users VALUES (443, 'Hakan', 'Doğan', '086-717-2211', 'h_doan@hotmail.com', 'V9J73VNH6O8', '2024-03-30 00:00:00');
INSERT INTO public.users VALUES (444, 'Gürsel', 'Kahraman', '012-578-3106', 'kahraman-grsel@google.com', 'I6D38PBQ5I4', '2023-06-30 00:00:00');
INSERT INTO public.users VALUES (445, 'Nurullah', 'Güngör', '042-383-8992', 'gngrnurullah3564@hotmail.com', 'R6J25SUY9Y4', '2024-11-25 00:00:00');
INSERT INTO public.users VALUES (446, 'Suna', 'Güneş', '043-477-8804', 'gnesuna93@google.com', 'H2L74SCE7F7', '2025-03-17 00:00:00');
INSERT INTO public.users VALUES (447, 'Süleyman', 'Akman', '049-548-9716', 's-akman8089@hotmail.com', 'C2U55EBP4B4', '2024-03-10 00:00:00');
INSERT INTO public.users VALUES (448, 'Şerife', 'Dinç', '098-028-4790', 'din.erife1610@hotmail.com', 'O8A33HWS2I5', '2025-03-08 00:00:00');
INSERT INTO public.users VALUES (449, 'Abdullah', 'Özer', '021-278-7814', 'z_abdullah6006@google.com', 'L0M29HWT2M6', '2023-03-24 00:00:00');
INSERT INTO public.users VALUES (450, 'Gül', 'Akkuş', '045-385-6516', 'glakku@hotmail.com', 'U2W57KAC9E7', '2025-04-27 00:00:00');
INSERT INTO public.users VALUES (451, 'Havva', 'Kaya', '018-664-2321', 'h_kaya3923@google.com', 'G8H95GMV0T9', '2023-11-14 00:00:00');
INSERT INTO public.users VALUES (452, 'Elif', 'Ünsal', '086-982-2995', 'e-nsal@google.com', 'Y8A69OWA2F6', '2024-08-26 00:00:00');
INSERT INTO public.users VALUES (453, 'Nur', 'Yaşar', '034-215-3933', 'nuryaar3901@hotmail.com', 'Z1V62ZRH0S3', '2024-02-29 00:00:00');
INSERT INTO public.users VALUES (454, 'Berkehan', 'Toprak', '084-982-1162', 't.berkehan@hotmail.com', 'T3L91YDU6V7', '2023-03-23 00:00:00');
INSERT INTO public.users VALUES (455, 'Yasemin', 'Akman', '019-297-5557', 'akman.yasemin@google.com', 'S2L31NET7Y3', '2024-01-08 00:00:00');
INSERT INTO public.users VALUES (456, 'Alparslan', 'Şen', '082-542-5208', 'aen@google.com', 'B6H44OPC4O8', '2023-10-27 00:00:00');
INSERT INTO public.users VALUES (457, 'Lale', 'Erdem', '025-126-1663', 'erdem.lale5724@google.com', 'M2C63EIY2B1', '2023-05-17 00:00:00');
INSERT INTO public.users VALUES (458, 'Merve', 'Gültekin', '013-235-2652', 'merve_gltekin234@hotmail.com', 'J0O27ECL7N2', '2024-07-20 00:00:00');
INSERT INTO public.users VALUES (459, 'Eren', 'Balcı', '011-162-3159', 'eren.balc107@google.com', 'I2X32NBM9K1', '2023-11-11 00:00:00');
INSERT INTO public.users VALUES (460, 'Tuğba', 'Uyar', '085-593-1826', 't.uyar3459@hotmail.com', 'S1V31URR7N4', '2024-07-23 00:00:00');
INSERT INTO public.users VALUES (461, 'Can', 'Karaca', '056-375-4894', 'c_karaca@google.com', 'X1X42WYR1G6', '2024-09-17 00:00:00');
INSERT INTO public.users VALUES (462, 'Nisa', 'Baş', '024-527-1163', 'nisa_ba@google.com', 'F3O42YNQ1L4', '2024-02-03 00:00:00');
INSERT INTO public.users VALUES (463, 'Berkan', 'Şenol', '016-683-8932', 'eberkan@google.com', 'X4B83PQM6G4', '2025-03-26 00:00:00');
INSERT INTO public.users VALUES (464, 'Ali̇can', 'Özer', '081-138-1164', 'zeralican@hotmail.com', 'U9T48XXX6I9', '2023-12-05 00:00:00');
INSERT INTO public.users VALUES (465, 'Emirhan', 'Kutlu', '058-524-4573', 'kutlu_emirhan@hotmail.com', 'U1H75WBW8Z8', '2025-03-17 00:00:00');
INSERT INTO public.users VALUES (466, 'Alp', 'Öz', '092-864-5944', 'z.alp7683@hotmail.com', 'A3M43QLJ9A2', '2023-09-20 00:00:00');
INSERT INTO public.users VALUES (467, 'Hatice', 'Altuntaş', '012-859-8642', 'altunta-hatice@google.com', 'M3Q25MTS9T8', '2024-11-21 00:00:00');
INSERT INTO public.users VALUES (468, 'Nur', 'Keskin', '023-632-0987', 'nur.keskin2482@hotmail.com', 'F1P57AWF4U6', '2024-06-07 00:00:00');
INSERT INTO public.users VALUES (469, 'Sevim', 'Arıkan', '063-389-3711', 'sevimarkan@hotmail.com', 'W1F65MVY1G0', '2025-03-10 00:00:00');
INSERT INTO public.users VALUES (470, 'Berker', 'Atmaca', '065-145-5474', 'a-berker@hotmail.com', 'X1U21YSS1S1', '2023-10-13 00:00:00');
INSERT INTO public.users VALUES (471, 'Gülseren', 'Topçu', '053-818-1445', 'g_topu@hotmail.com', 'N2Y82CJG3C6', '2023-11-13 00:00:00');
INSERT INTO public.users VALUES (472, 'Cansel', 'Bingöl', '026-043-4738', 'c_bingl4440@hotmail.com', 'S4Y46AGV9X3', '2024-06-05 00:00:00');
INSERT INTO public.users VALUES (473, 'Alpcan', 'Doğru', '097-267-4677', 'a.doru@hotmail.com', 'H2E58REE2F5', '2024-07-26 00:00:00');
INSERT INTO public.users VALUES (474, 'Şennur', 'Usta', '064-085-4923', 'u_ennur2545@hotmail.com', 'B1P40BHV5L6', '2023-05-21 00:00:00');
INSERT INTO public.users VALUES (475, 'Ayşenur', 'Demirel', '068-053-8425', 'd-ayenur2625@hotmail.com', 'B7Y44GDW8F2', '2025-03-19 00:00:00');
INSERT INTO public.users VALUES (476, 'Rıza', 'Kaçar', '019-567-5313', 'r_kaar702@google.com', 'I3S14FFD1J1', '2024-08-29 00:00:00');
INSERT INTO public.users VALUES (477, 'Nazmi̇ye', 'Demirel', '040-962-8878', 'demirel.nazmiye7998@google.com', 'D1U46UFP7J2', '2025-03-23 00:00:00');
INSERT INTO public.users VALUES (478, 'Elif', 'Durak', '059-785-9134', 'elif.durak6586@google.com', 'R7L77FIV2G1', '2024-06-12 00:00:00');
INSERT INTO public.users VALUES (479, 'Nazan', 'Turan', '081-225-3157', 'n.turan@google.com', 'J5I58PMV4J7', '2023-08-22 00:00:00');
INSERT INTO public.users VALUES (480, 'Meral', 'Duran', '048-277-1218', 'mduran4933@google.com', 'J8T84IRE6S7', '2024-05-29 00:00:00');
INSERT INTO public.users VALUES (481, 'Kadi̇r', 'Kara', '015-847-1271', 'karakadir9894@hotmail.com', 'Q3K47RFG6P7', '2024-12-30 00:00:00');
INSERT INTO public.users VALUES (482, 'Nuray', 'Durmaz', '074-768-4302', 'n-durmaz@hotmail.com', 'R2D63NGC7P4', '2024-07-31 00:00:00');
INSERT INTO public.users VALUES (483, 'Keri̇m', 'Uysal', '001-123-5858', 'kuysal1271@google.com', 'E3Q11UIR6Y0', '2023-03-01 00:00:00');
INSERT INTO public.users VALUES (484, 'Alp', 'Oğuz', '074-070-3274', 'ouz_alp@google.com', 'X4S75MPM6W2', '2024-11-07 00:00:00');
INSERT INTO public.users VALUES (485, 'Ceylan', 'Şanli', '071-430-9592', 'anli.ceylan815@hotmail.com', 'S2E30LXG8A8', '2024-08-18 00:00:00');
INSERT INTO public.users VALUES (486, 'Cemre', 'Uyar', '061-341-5221', 'ucemre3020@google.com', 'D1S44FDC5T2', '2023-01-15 00:00:00');
INSERT INTO public.users VALUES (487, 'Atacan', 'Güney', '006-283-2341', 'a-gney@hotmail.com', 'M7A42HBA2B4', '2024-07-09 00:00:00');
INSERT INTO public.users VALUES (488, 'Alp', 'Ertaş', '034-881-1334', 'ertaalp@hotmail.com', 'Y2Y15KAW5N9', '2024-12-09 00:00:00');
INSERT INTO public.users VALUES (489, 'Can', 'Efe', '045-166-6018', 'c.efe@hotmail.com', 'I8K77PPL5I2', '2024-12-10 00:00:00');
INSERT INTO public.users VALUES (490, 'Zeynep', 'Kalkan', '081-676-2323', 'kalkan_zeynep@google.com', 'X2V31EQX4S5', '2023-03-05 00:00:00');
INSERT INTO public.users VALUES (491, 'Alperen', 'Ersoy', '018-588-7158', 'ersoy-alperen@google.com', 'W1S23IQU5K1', '2024-08-16 00:00:00');
INSERT INTO public.users VALUES (492, 'Ali̇can', 'Kara', '006-264-4467', 'karaalican@google.com', 'L4Q10JQE1R7', '2024-04-26 00:00:00');
INSERT INTO public.users VALUES (493, 'Ali̇şan', 'Gündüz', '051-955-1413', 'alian_gndz6101@google.com', 'R1P54ZFJ6E6', '2024-06-23 00:00:00');
INSERT INTO public.users VALUES (494, 'Hülya', 'Uslu', '086-232-5058', 'uslu.hlya@google.com', 'Q2Q07AJR1P3', '2023-07-04 00:00:00');
INSERT INTO public.users VALUES (495, 'Sudenur', 'Yücel', '043-372-4433', 'sycel1182@hotmail.com', 'W7J22PTD7D1', '2024-12-18 00:00:00');
INSERT INTO public.users VALUES (496, 'Cankat', 'Akbulut', '018-938-8556', 'c-akbulut@hotmail.com', 'F8J33UTK1V5', '2023-09-14 00:00:00');
INSERT INTO public.users VALUES (497, 'Can', 'Şentürk', '092-734-2677', 'c-entrk7058@hotmail.com', 'T7Q54HTV7H1', '2024-11-26 00:00:00');
INSERT INTO public.users VALUES (498, 'Samet', 'Akpınar', '043-472-5207', 'a.samet@google.com', 'J0E68EOM7O5', '2024-05-06 00:00:00');
INSERT INTO public.users VALUES (499, 'Nazan', 'Akdeniz', '010-709-0693', 'n-akdeniz@google.com', 'H1R84DPA3T6', '2023-04-16 00:00:00');
INSERT INTO public.users VALUES (500, 'Güler', 'Taş', '081-872-2386', 't.gler5685@google.com', 'W2H53EMV0Y1', '2024-03-28 00:00:00');
INSERT INTO public.users VALUES (501, 'Miray', 'Topcu', '055-097-2708', 'admin@admin.com', '123456', '2025-05-15 22:03:02.44769');


--
-- TOC entry 4920 (class 0 OID 16401)
-- Dependencies: 220
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vehicle VALUES (1001, '26 ABC 123', 'Ford', 'Fiesta', 2016, 'Electricity', 10000, 2, '2025-05-15 15:10:04.852796', 172);
INSERT INTO public.vehicle VALUES (1, '01 DZ 653', 'Suzuki', 'Equator', 2009, 'Gas', 35707, 5, '2023-09-26 00:00:00', 1);
INSERT INTO public.vehicle VALUES (2, '01 ED 5616', 'Mitsubishi', 'Diamante', 1999, 'Diesel', 47609, 3, '2023-09-30 00:00:00', 1);
INSERT INTO public.vehicle VALUES (3, '01 FT 4593', 'Chevrolet', 'Cobalt', 2010, 'Electricity', 57684, 3, '2024-02-29 00:00:00', 2);
INSERT INTO public.vehicle VALUES (4, '01 HR 8287', 'Cadillac', 'Escalade EXT', 2003, 'LPG', 13613, 5, '2024-01-12 00:00:00', 2);
INSERT INTO public.vehicle VALUES (5, '01 KA 1850', 'Ford', 'Explorer Sport Trac', 2005, 'Gas', 54395, 4, '2024-01-28 00:00:00', 2);
INSERT INTO public.vehicle VALUES (6, '01 PY 277', 'Ford', 'Econoline E150', 2002, 'Diesel', 51613, 1, '2024-01-27 00:00:00', 2);
INSERT INTO public.vehicle VALUES (7, '01 UU 2139', 'Pontiac', 'Bonneville', 1987, 'Electricity', 12689, 1, '2023-05-21 00:00:00', 3);
INSERT INTO public.vehicle VALUES (8, '01 VI 3574', 'Infiniti', 'EX', 2009, 'LPG', 56425, 4, '2024-08-13 00:00:00', 4);
INSERT INTO public.vehicle VALUES (9, '01 VU 4668', 'Chevrolet', 'Corvette', 2011, 'Gas', 35379, 5, '2024-08-17 00:00:00', 4);
INSERT INTO public.vehicle VALUES (10, '02 CC 906', 'BMW', 'M3', 1999, 'Diesel', 18495, 3, '2024-06-26 00:00:00', 5);
INSERT INTO public.vehicle VALUES (11, '02 JZ 7347', 'Volvo', 'XC60', 2009, 'Electricity', 46044, 2, '2023-04-02 00:00:00', 6);
INSERT INTO public.vehicle VALUES (12, '02 KD 2001', 'Dodge', 'Dakota', 1998, 'LPG', 37549, 4, '2023-04-20 00:00:00', 6);
INSERT INTO public.vehicle VALUES (13, '03 AP 8769', 'Dodge', 'Ram 3500', 1996, 'Gas', 30422, 3, '2023-05-13 00:00:00', 6);
INSERT INTO public.vehicle VALUES (14, '03 BJ 4017', 'Toyota', 'RAV4', 2007, 'Diesel', 44206, 2, '2023-04-13 00:00:00', 6);
INSERT INTO public.vehicle VALUES (15, '03 MP 5418', 'Toyota', 'Camry', 1993, 'Electricity', 40496, 3, '2023-05-10 00:00:00', 6);
INSERT INTO public.vehicle VALUES (16, '03 PD 1230', 'Volkswagen', 'Golf', 1990, 'LPG', 21655, 2, '2025-05-04 00:00:00', 7);
INSERT INTO public.vehicle VALUES (17, '03 PM 3540', 'Lincoln', 'MKZ', 2008, 'Gas', 11949, 4, '2025-05-27 00:00:00', 7);
INSERT INTO public.vehicle VALUES (18, '03 S 751', 'BMW', '7 Series', 1999, 'Diesel', 27157, 2, '2023-07-10 00:00:00', 8);
INSERT INTO public.vehicle VALUES (19, '03 TG 6117', 'Bentley', 'Azure', 2008, 'Electricity', 20495, 1, '2024-04-28 00:00:00', 9);
INSERT INTO public.vehicle VALUES (20, '03 YN 9730', 'Jeep', 'Compass', 2008, 'LPG', 49895, 4, '2024-04-26 00:00:00', 9);
INSERT INTO public.vehicle VALUES (21, '04 FH 5957', 'Dodge', 'Ram', 2010, 'Gas', 28608, 1, '2025-01-28 00:00:00', 10);
INSERT INTO public.vehicle VALUES (22, '04 GE 7108', 'Ford', 'Mustang', 2001, 'Diesel', 57875, 3, '2025-02-04 00:00:00', 10);
INSERT INTO public.vehicle VALUES (23, '04 IM 7673', 'Nissan', 'Sentra', 2011, 'Electricity', 34404, 1, '2024-01-03 00:00:00', 11);
INSERT INTO public.vehicle VALUES (24, '04 P 3092', 'Ford', 'Escape', 2000, 'LPG', 47117, 4, '2023-12-08 00:00:00', 11);
INSERT INTO public.vehicle VALUES (25, '04 YA 2594', 'Chevrolet', 'Camaro', 1975, 'Gas', 22021, 3, '2023-12-21 00:00:00', 12);
INSERT INTO public.vehicle VALUES (26, '05 B 8284', 'Volkswagen', 'Touareg', 2004, 'Diesel', 50488, 3, '2023-05-23 00:00:00', 13);
INSERT INTO public.vehicle VALUES (27, '05 IK 2932', 'Oldsmobile', 'Cutlass Supreme', 1993, 'Electricity', 32618, 5, '2024-11-05 00:00:00', 14);
INSERT INTO public.vehicle VALUES (28, '05 JS 9165', 'Aston Martin', 'V8 Vantage', 2011, 'LPG', 16769, 2, '2024-11-09 00:00:00', 14);
INSERT INTO public.vehicle VALUES (29, '05 VU 5434', 'Mazda', 'B-Series', 1995, 'Gas', 48292, 4, '2025-06-25 00:00:00', 15);
INSERT INTO public.vehicle VALUES (30, '05 YH 7035', 'Hyundai', 'Elantra', 2004, 'Diesel', 59166, 5, '2025-06-07 00:00:00', 15);
INSERT INTO public.vehicle VALUES (31, '05 YO 8812', 'Kia', 'Sephia', 1997, 'Electricity', 50816, 3, '2025-01-21 00:00:00', 16);
INSERT INTO public.vehicle VALUES (32, '05 YP 5190', 'Toyota', 'T100', 1998, 'LPG', 46895, 5, '2025-01-29 00:00:00', 16);
INSERT INTO public.vehicle VALUES (33, '06 CZ 3119', 'Honda', 'CR-V', 2007, 'Gas', 39214, 4, '2024-12-10 00:00:00', 16);
INSERT INTO public.vehicle VALUES (34, '06 GM 6490', 'Toyota', 'Tacoma', 2011, 'Diesel', 21002, 1, '2025-02-02 00:00:00', 16);
INSERT INTO public.vehicle VALUES (35, '06 KM 2471', 'Lotus', 'Esprit', 2002, 'Electricity', 17111, 3, '2023-05-12 00:00:00', 17);
INSERT INTO public.vehicle VALUES (36, '06 NJ 1419', 'Toyota', 'RAV4', 1997, 'LPG', 38991, 2, '2024-05-19 00:00:00', 18);
INSERT INTO public.vehicle VALUES (37, '06 ST 2201', 'Pontiac', 'Grand Prix', 1994, 'Gas', 38619, 2, '2024-04-24 00:00:00', 18);
INSERT INTO public.vehicle VALUES (38, '06 VP 5762', 'Dodge', 'Avenger', 2010, 'Diesel', 55888, 5, '2025-04-01 00:00:00', 19);
INSERT INTO public.vehicle VALUES (39, '07 JN 930', 'Mitsubishi', 'Pajero', 2002, 'Electricity', 37165, 4, '2025-04-01 00:00:00', 19);
INSERT INTO public.vehicle VALUES (40, '07 JO 1315', 'Mitsubishi', 'Expo', 1993, 'LPG', 49700, 5, '2025-02-13 00:00:00', 19);
INSERT INTO public.vehicle VALUES (41, '07 NC 6211', 'BMW', 'X3', 2006, 'Gas', 33045, 3, '2023-06-29 00:00:00', 20);
INSERT INTO public.vehicle VALUES (42, '07 OI 6977', 'MINI', 'Cooper Countryman', 2012, 'Diesel', 22259, 4, '2023-07-19 00:00:00', 20);
INSERT INTO public.vehicle VALUES (43, '07 RU 9346', 'Chevrolet', 'Aveo', 2009, 'Electricity', 54928, 4, '2025-06-24 00:00:00', 21);
INSERT INTO public.vehicle VALUES (44, '07 SI 6717', 'Buick', 'Skyhawk', 1984, 'LPG', 56608, 1, '2025-05-02 00:00:00', 22);
INSERT INTO public.vehicle VALUES (45, '07 TJ 4247', 'Subaru', 'XT', 1989, 'Gas', 27911, 4, '2023-03-28 00:00:00', 23);
INSERT INTO public.vehicle VALUES (46, '07 VV 3242', 'Lexus', 'GX', 2012, 'Diesel', 40776, 2, '2023-04-02 00:00:00', 23);
INSERT INTO public.vehicle VALUES (47, '08 BF 9395', 'Lexus', 'GX', 2003, 'Electricity', 43379, 5, '2024-02-03 00:00:00', 24);
INSERT INTO public.vehicle VALUES (48, '08 F 8859', 'Lincoln', 'Town Car', 1986, 'LPG', 20408, 2, '2024-02-03 00:00:00', 24);
INSERT INTO public.vehicle VALUES (49, '08 PC 5013', 'Mercedes-Benz', 'E-Class', 2011, 'Gas', 30765, 3, '2024-07-09 00:00:00', 25);
INSERT INTO public.vehicle VALUES (50, '08 VG 6868', 'Nissan', 'Altima', 2001, 'Diesel', 45159, 1, '2024-07-02 00:00:00', 25);
INSERT INTO public.vehicle VALUES (51, '08 YT 5246', 'Jeep', 'Wrangler', 1999, 'Electricity', 27435, 5, '2024-05-27 00:00:00', 25);
INSERT INTO public.vehicle VALUES (52, '09 AN 3032', 'Chevrolet', 'Camaro', 1998, 'LPG', 43104, 1, '2024-07-04 00:00:00', 25);
INSERT INTO public.vehicle VALUES (53, '09 BD 1033', 'Mercedes-Benz', 'CLS-Class', 2009, 'Gas', 52585, 2, '2023-09-08 00:00:00', 26);
INSERT INTO public.vehicle VALUES (54, '09 IO 227', 'GMC', 'Savana Cargo Van', 2006, 'Diesel', 34476, 5, '2023-10-08 00:00:00', 26);
INSERT INTO public.vehicle VALUES (55, '09 IU 8593', 'Jeep', 'Compass', 2007, 'Electricity', 26162, 4, '2024-07-24 00:00:00', 27);
INSERT INTO public.vehicle VALUES (56, '09 OO 878', 'Chevrolet', 'Suburban 1500', 2009, 'LPG', 13154, 2, '2024-11-17 00:00:00', 28);
INSERT INTO public.vehicle VALUES (57, '09 SU 1273', 'GMC', '1500 Club Coupe', 1996, 'Gas', 10734, 5, '2024-12-21 00:00:00', 28);
INSERT INTO public.vehicle VALUES (58, '09 ZE 5250', 'Land Rover', 'Discovery', 2011, 'Diesel', 29491, 2, '2023-07-31 00:00:00', 29);
INSERT INTO public.vehicle VALUES (59, '10 IK 162', 'Honda', 'Passport', 1997, 'Electricity', 15480, 1, '2023-08-03 00:00:00', 29);
INSERT INTO public.vehicle VALUES (60, '10 LD 4238', 'BMW', 'M5', 2008, 'LPG', 34265, 4, '2023-12-28 00:00:00', 30);
INSERT INTO public.vehicle VALUES (61, '10 LP 5065', 'Volkswagen', 'Passat', 2012, 'Gas', 43290, 5, '2024-03-20 00:00:00', 31);
INSERT INTO public.vehicle VALUES (62, '10 NM 9968', 'Chrysler', 'Voyager', 2000, 'Diesel', 42412, 4, '2025-01-23 00:00:00', 32);
INSERT INTO public.vehicle VALUES (63, '11 AL 7078', 'Mazda', 'MPV', 1990, 'Electricity', 30573, 1, '2024-12-12 00:00:00', 32);
INSERT INTO public.vehicle VALUES (64, '11 HN 2619', 'Mitsubishi', 'Galant', 1984, 'LPG', 29233, 2, '2024-11-08 00:00:00', 33);
INSERT INTO public.vehicle VALUES (65, '11 KE 6402', 'Audi', 'Allroad', 2005, 'Gas', 18000, 4, '2024-11-15 00:00:00', 33);
INSERT INTO public.vehicle VALUES (66, '11 ME 1995', 'Suzuki', 'Swift', 2005, 'Diesel', 21368, 4, '2024-12-28 00:00:00', 33);
INSERT INTO public.vehicle VALUES (67, '11 OA 2195', 'Mercury', 'Topaz', 1992, 'Electricity', 36283, 4, '2024-12-01 00:00:00', 33);
INSERT INTO public.vehicle VALUES (68, '11 PH 1882', 'Ford', 'Bronco II', 1987, 'LPG', 20592, 4, '2025-02-13 00:00:00', 34);
INSERT INTO public.vehicle VALUES (69, '11 VY 5188', 'GMC', 'Envoy XL', 2005, 'Gas', 47119, 4, '2023-11-11 00:00:00', 35);
INSERT INTO public.vehicle VALUES (70, '12 BB 3568', 'Ford', 'F-Series', 1987, 'Diesel', 55172, 4, '2025-03-22 00:00:00', 36);
INSERT INTO public.vehicle VALUES (71, '12 BY 2985', 'Chevrolet', 'Suburban 1500', 2002, 'Electricity', 57583, 5, '2025-01-31 00:00:00', 36);
INSERT INTO public.vehicle VALUES (72, '12 GU 4932', 'Mazda', 'MX-3', 1996, 'LPG', 19579, 1, '2023-08-30 00:00:00', 37);
INSERT INTO public.vehicle VALUES (73, '12 JZ 6806', 'Scion', 'xD', 2012, 'Gas', 31659, 3, '2023-10-04 00:00:00', 37);
INSERT INTO public.vehicle VALUES (74, '12 ZT 5222', 'Mazda', 'Mazdaspeed 3', 2009, 'Diesel', 34407, 2, '2024-05-02 00:00:00', 38);
INSERT INTO public.vehicle VALUES (75, '13 KB 8898', 'Mercury', 'Grand Marquis', 2009, 'Electricity', 12487, 3, '2024-06-19 00:00:00', 39);
INSERT INTO public.vehicle VALUES (76, '13 OD 4178', 'Mercury', 'Villager', 1994, 'LPG', 10077, 4, '2024-05-17 00:00:00', 39);
INSERT INTO public.vehicle VALUES (77, '13 SF 5388', 'Subaru', 'Justy', 1990, 'Gas', 25131, 4, '2024-08-08 00:00:00', 40);
INSERT INTO public.vehicle VALUES (78, '13 UI 3489', 'Ferrari', 'F430 Spider', 2006, 'Diesel', 38571, 5, '2024-09-02 00:00:00', 40);
INSERT INTO public.vehicle VALUES (79, '13 VH 2641', 'Pontiac', 'Chevette', 1987, 'Electricity', 29701, 1, '2023-03-05 00:00:00', 41);
INSERT INTO public.vehicle VALUES (80, '14 GH 446', 'Ford', 'Windstar', 1997, 'LPG', 18503, 5, '2023-02-11 00:00:00', 41);
INSERT INTO public.vehicle VALUES (81, '14 LC 1242', 'Toyota', 'Matrix', 2007, 'Gas', 59780, 3, '2023-02-14 00:00:00', 41);
INSERT INTO public.vehicle VALUES (82, '14 OY 071', 'GMC', 'EV1', 1999, 'Diesel', 50137, 4, '2023-01-26 00:00:00', 41);
INSERT INTO public.vehicle VALUES (83, '14 SL 1741', 'Dodge', 'Challenger', 2011, 'Electricity', 50917, 3, '2023-04-03 00:00:00', 42);
INSERT INTO public.vehicle VALUES (84, '14 TO 8841', 'Toyota', 'Prius', 2001, 'LPG', 35998, 2, '2023-03-10 00:00:00', 42);
INSERT INTO public.vehicle VALUES (85, '14 YV 5287', 'BMW', '3 Series', 1997, 'Gas', 10426, 3, '2023-04-10 00:00:00', 43);
INSERT INTO public.vehicle VALUES (86, '15 EB 3440', 'Acura', 'NSX', 1998, 'Diesel', 10566, 1, '2023-09-10 00:00:00', 44);
INSERT INTO public.vehicle VALUES (87, '15 GF 7487', 'Volkswagen', 'rio', 2002, 'Electricity', 32482, 1, '2023-08-13 00:00:00', 44);
INSERT INTO public.vehicle VALUES (88, '15 NF 6700', 'Chevrolet', 'Silverado 3500', 2007, 'LPG', 28936, 5, '2024-12-09 00:00:00', 45);
INSERT INTO public.vehicle VALUES (89, '15 NY 9618', 'Ford', 'Laser', 1988, 'Gas', 12748, 3, '2025-01-25 00:00:00', 45);
INSERT INTO public.vehicle VALUES (90, '15 SJ 1442', 'Pontiac', 'Bonneville', 1999, 'Diesel', 32987, 5, '2024-12-15 00:00:00', 45);
INSERT INTO public.vehicle VALUES (91, '16 AK 6587', 'Chevrolet', 'Avalanche 2500', 2003, 'Electricity', 22692, 1, '2024-12-17 00:00:00', 45);
INSERT INTO public.vehicle VALUES (92, '16 GV 478', 'Mercury', 'Mariner', 2005, 'LPG', 44005, 2, '2024-05-10 00:00:00', 46);
INSERT INTO public.vehicle VALUES (93, '16 ID 6946', 'Maybach', '57', 2003, 'Gas', 30482, 5, '2024-05-20 00:00:00', 46);
INSERT INTO public.vehicle VALUES (94, '16 MD 5188', 'Dodge', 'Avenger', 2009, 'Diesel', 57094, 3, '2023-04-27 00:00:00', 47);
INSERT INTO public.vehicle VALUES (95, '16 RK 1166', 'Lincoln', 'Mark VIII', 1995, 'Electricity', 33240, 2, '2025-04-29 00:00:00', 48);
INSERT INTO public.vehicle VALUES (96, '17 CN 194', 'Nissan', 'Maxima', 2000, 'LPG', 27149, 5, '2025-06-21 00:00:00', 48);
INSERT INTO public.vehicle VALUES (97, '17 EH 3897', 'Hyundai', 'Excel', 1992, 'Gas', 22699, 4, '2025-05-20 00:00:00', 48);
INSERT INTO public.vehicle VALUES (98, '17 MT 2401', 'Nissan', 'Maxima', 2007, 'Diesel', 10970, 5, '2023-06-01 00:00:00', 49);
INSERT INTO public.vehicle VALUES (99, '17 ZC 4777', 'Chevrolet', 'Express 2500', 1997, 'Electricity', 12974, 2, '2023-09-05 00:00:00', 50);
INSERT INTO public.vehicle VALUES (100, '18 GC 7482', 'Ford', 'Thunderbird', 1967, 'LPG', 31786, 2, '2023-08-04 00:00:00', 50);
INSERT INTO public.vehicle VALUES (101, '18 IO 579', 'Mazda', '929', 1992, 'Gas', 20183, 1, '2023-08-19 00:00:00', 50);
INSERT INTO public.vehicle VALUES (102, '18 JA 5123', 'Lexus', 'RX', 2010, 'Diesel', 23712, 4, '2023-01-07 00:00:00', 51);
INSERT INTO public.vehicle VALUES (103, '18 JF 727', 'Mitsubishi', 'Galant', 2010, 'Electricity', 35423, 1, '2023-01-28 00:00:00', 51);
INSERT INTO public.vehicle VALUES (104, '18 PK 1348', 'Dodge', 'Ram 3500', 2006, 'LPG', 26495, 5, '2023-01-12 00:00:00', 51);
INSERT INTO public.vehicle VALUES (105, '18 SC 7667', 'Honda', 'S2000', 2009, 'Gas', 48047, 4, '2024-03-13 00:00:00', 52);
INSERT INTO public.vehicle VALUES (106, '19 FA 9652', 'Acura', 'RL', 2008, 'Diesel', 30819, 4, '2024-02-21 00:00:00', 52);
INSERT INTO public.vehicle VALUES (107, '19 IU 5337', 'GMC', 'Envoy', 1999, 'Electricity', 17301, 1, '2023-02-05 00:00:00', 53);
INSERT INTO public.vehicle VALUES (108, '19 OV 7029', 'Kia', 'Sephia', 1994, 'LPG', 43924, 5, '2023-03-03 00:00:00', 53);
INSERT INTO public.vehicle VALUES (109, '19 VR 9728', 'Lincoln', 'Town Car', 1995, 'Gas', 55847, 4, '2023-10-30 00:00:00', 54);
INSERT INTO public.vehicle VALUES (110, '20 AO 2189', 'Mitsubishi', 'Galant', 1984, 'Diesel', 47524, 1, '2024-10-07 00:00:00', 55);
INSERT INTO public.vehicle VALUES (111, '20 GU 7047', 'Lexus', 'LS', 1993, 'Electricity', 15923, 5, '2024-09-02 00:00:00', 55);
INSERT INTO public.vehicle VALUES (112, '20 KT 7554', 'Lexus', 'GS', 1997, 'LPG', 11918, 2, '2024-11-27 00:00:00', 56);
INSERT INTO public.vehicle VALUES (113, '20 MH 6218', 'Toyota', 'Tacoma Xtra', 1996, 'Gas', 55691, 4, '2023-07-31 00:00:00', 57);
INSERT INTO public.vehicle VALUES (114, '20 SZ 1883', 'Suzuki', 'Swift', 2004, 'Diesel', 29890, 2, '2023-08-21 00:00:00', 57);
INSERT INTO public.vehicle VALUES (115, '20 TL 7294', 'Ford', 'Mustang', 2001, 'Electricity', 54824, 5, '2023-03-21 00:00:00', 58);
INSERT INTO public.vehicle VALUES (116, '20 UC 4998', 'Buick', 'Riviera', 1995, 'LPG', 33825, 3, '2023-03-14 00:00:00', 58);
INSERT INTO public.vehicle VALUES (117, '20 VS 9341', 'Kia', 'Spectra', 2004, 'Gas', 36809, 2, '2023-08-02 00:00:00', 59);
INSERT INTO public.vehicle VALUES (118, '20 YS 2311', 'Honda', 'Civic', 1988, 'Diesel', 58464, 2, '2023-08-21 00:00:00', 59);
INSERT INTO public.vehicle VALUES (119, '21 BU 5770', 'Volkswagen', 'Routan', 2009, 'Electricity', 11430, 3, '2023-09-18 00:00:00', 59);
INSERT INTO public.vehicle VALUES (120, '21 BZ 330', 'Volvo', 'S60', 2013, 'LPG', 58860, 4, '2025-02-23 00:00:00', 60);
INSERT INTO public.vehicle VALUES (121, '21 HV 350', 'GMC', 'Canyon', 2004, 'Gas', 51245, 5, '2024-04-07 00:00:00', 61);
INSERT INTO public.vehicle VALUES (122, '21 IR 5659', 'Suzuki', 'SJ', 1990, 'Diesel', 28345, 2, '2023-04-06 00:00:00', 62);
INSERT INTO public.vehicle VALUES (123, '21 LI 3423', 'Mercedes-Benz', 'SL-Class', 2012, 'Electricity', 25100, 1, '2024-02-04 00:00:00', 63);
INSERT INTO public.vehicle VALUES (124, '21 TL 2061', 'Chevrolet', 'Tahoe', 2013, 'LPG', 40301, 3, '2024-09-30 00:00:00', 64);
INSERT INTO public.vehicle VALUES (125, '21 ZS 4101', 'Ford', 'E150', 1984, 'Gas', 48960, 3, '2023-05-29 00:00:00', 65);
INSERT INTO public.vehicle VALUES (126, '22 BM 4764', 'Audi', 'TT', 2002, 'Diesel', 22575, 5, '2023-05-23 00:00:00', 65);
INSERT INTO public.vehicle VALUES (127, '22 DY 8966', 'Subaru', 'Impreza', 2002, 'Electricity', 44557, 4, '2024-06-07 00:00:00', 66);
INSERT INTO public.vehicle VALUES (128, '22 GR 2255', 'GMC', '2500', 1994, 'LPG', 58974, 4, '2024-04-25 00:00:00', 66);
INSERT INTO public.vehicle VALUES (129, '22 HI 1114', 'Acura', 'Integra', 1995, 'Gas', 32747, 2, '2024-05-17 00:00:00', 66);
INSERT INTO public.vehicle VALUES (130, '22 NV 2544', 'Chrysler', 'Crossfire', 2004, 'Diesel', 20508, 5, '2024-05-29 00:00:00', 67);
INSERT INTO public.vehicle VALUES (131, '22 OL 1182', 'Mitsubishi', 'Galant', 2005, 'Electricity', 25870, 2, '2024-06-21 00:00:00', 67);
INSERT INTO public.vehicle VALUES (132, '23 BE 6284', 'Chevrolet', 'Malibu', 2011, 'LPG', 24234, 3, '2024-06-03 00:00:00', 67);
INSERT INTO public.vehicle VALUES (133, '23 IF 8240', 'Volkswagen', 'Jetta', 2010, 'Gas', 19850, 4, '2024-06-01 00:00:00', 67);
INSERT INTO public.vehicle VALUES (134, '23 IJ 7539', 'Ford', 'Taurus', 2002, 'Diesel', 58247, 2, '2024-01-08 00:00:00', 68);
INSERT INTO public.vehicle VALUES (135, '23 KD 2234', 'Cadillac', 'Allante', 1992, 'Electricity', 43205, 1, '2024-01-12 00:00:00', 68);
INSERT INTO public.vehicle VALUES (136, '23 Y 7678', 'Porsche', '911', 1987, 'LPG', 50243, 2, '2024-05-23 00:00:00', 69);
INSERT INTO public.vehicle VALUES (137, '24 CU 2650', 'BMW', '3 Series', 2004, 'Gas', 56829, 4, '2024-09-17 00:00:00', 70);
INSERT INTO public.vehicle VALUES (138, '24 HB 4712', 'Acura', 'CL', 1997, 'Diesel', 14728, 1, '2023-07-12 00:00:00', 71);
INSERT INTO public.vehicle VALUES (139, '24 HF 3566', 'Ford', 'Escort', 1999, 'Electricity', 26956, 4, '2024-12-01 00:00:00', 72);
INSERT INTO public.vehicle VALUES (140, '24 TF 4314', 'Lincoln', 'Mark LT', 2006, 'LPG', 25440, 4, '2024-11-04 00:00:00', 72);
INSERT INTO public.vehicle VALUES (141, '24 UZ 2418', 'Cadillac', 'Escalade ESV', 2004, 'Gas', 51246, 5, '2024-11-27 00:00:00', 72);
INSERT INTO public.vehicle VALUES (142, '25 BR 2430', 'Pontiac', '6000', 1989, 'Diesel', 35598, 2, '2024-12-05 00:00:00', 73);
INSERT INTO public.vehicle VALUES (143, '25 CN 8999', 'Toyota', 'Sienna', 2004, 'Electricity', 33214, 1, '2023-02-25 00:00:00', 74);
INSERT INTO public.vehicle VALUES (144, '25 EL 206', 'Ford', 'Escort', 2002, 'LPG', 18729, 1, '2023-03-21 00:00:00', 75);
INSERT INTO public.vehicle VALUES (145, '25 ER 3025', 'Mazda', 'MPV', 1993, 'Gas', 23173, 3, '2023-04-15 00:00:00', 75);
INSERT INTO public.vehicle VALUES (146, '25 JB 4555', 'Ford', 'Bronco', 1995, 'Diesel', 16121, 2, '2024-04-01 00:00:00', 76);
INSERT INTO public.vehicle VALUES (147, '25 LI 9959', 'Hummer', 'H1', 2002, 'Electricity', 12838, 4, '2024-04-29 00:00:00', 76);
INSERT INTO public.vehicle VALUES (148, '25 LN 7726', 'Infiniti', 'G25', 2011, 'LPG', 27730, 2, '2023-10-05 00:00:00', 77);
INSERT INTO public.vehicle VALUES (149, '25 UL 5150', 'Chevrolet', 'Avalanche 2500', 2004, 'Gas', 57108, 4, '2023-05-15 00:00:00', 78);
INSERT INTO public.vehicle VALUES (150, '26 GB 5996', 'BMW', 'Z4', 2005, 'Diesel', 36284, 1, '2023-06-10 00:00:00', 78);
INSERT INTO public.vehicle VALUES (151, '26 HS 6117', 'Infiniti', 'QX', 2003, 'Electricity', 12746, 1, '2023-04-19 00:00:00', 78);
INSERT INTO public.vehicle VALUES (152, '26 II 4627', 'Volvo', 'V70', 2006, 'LPG', 37685, 1, '2023-06-04 00:00:00', 79);
INSERT INTO public.vehicle VALUES (153, '26 PD 8637', 'Lincoln', 'MKS', 2010, 'Gas', 31012, 2, '2023-05-16 00:00:00', 79);
INSERT INTO public.vehicle VALUES (154, '27 BN 5715', 'Toyota', 'Supra', 1992, 'Diesel', 11313, 1, '2024-07-03 00:00:00', 80);
INSERT INTO public.vehicle VALUES (155, '27 DA 3068', 'Ford', 'F350', 2000, 'Electricity', 44167, 1, '2025-01-24 00:00:00', 81);
INSERT INTO public.vehicle VALUES (156, '27 DO 5855', 'Land Rover', 'Range Rover Evoque', 2012, 'LPG', 51119, 4, '2024-12-23 00:00:00', 81);
INSERT INTO public.vehicle VALUES (157, '27 JB 4892', 'Honda', 'Accord Crosstour', 2010, 'Gas', 45732, 3, '2023-06-19 00:00:00', 82);
INSERT INTO public.vehicle VALUES (158, '27 JO 5715', 'Mazda', '626', 1988, 'Diesel', 43299, 3, '2023-05-23 00:00:00', 82);
INSERT INTO public.vehicle VALUES (159, '27 LC 5164', 'Volkswagen', 'Passat', 1995, 'Electricity', 24841, 4, '2025-04-10 00:00:00', 83);
INSERT INTO public.vehicle VALUES (160, '27 UM 9478', 'Chevrolet', 'Suburban 2500', 2009, 'LPG', 52517, 4, '2025-01-07 00:00:00', 84);
INSERT INTO public.vehicle VALUES (161, '28 CL 5836', 'Pontiac', 'Grand Am', 2000, 'Gas', 18303, 2, '2023-06-13 00:00:00', 85);
INSERT INTO public.vehicle VALUES (162, '28 KY 776', 'Dodge', 'Ram 1500 Club', 1997, 'Diesel', 13982, 1, '2025-01-18 00:00:00', 86);
INSERT INTO public.vehicle VALUES (163, '28 PH 4066', 'Ford', 'Mustang', 1965, 'Electricity', 38750, 4, '2024-12-25 00:00:00', 86);
INSERT INTO public.vehicle VALUES (164, '28 TZ 9284', 'Volkswagen', 'Type 2', 1986, 'LPG', 46360, 3, '2025-01-07 00:00:00', 86);
INSERT INTO public.vehicle VALUES (165, '28 ZN 3170', 'Ford', 'Mustang', 1967, 'Gas', 31488, 3, '2023-12-18 00:00:00', 87);
INSERT INTO public.vehicle VALUES (166, '29 BT 4816', 'Ford', 'F150', 2003, 'Diesel', 23325, 3, '2024-01-02 00:00:00', 87);
INSERT INTO public.vehicle VALUES (167, '29 CS 331', 'Chevrolet', 'Impala', 1995, 'Electricity', 14877, 5, '2024-01-15 00:00:00', 87);
INSERT INTO public.vehicle VALUES (168, '29 HE 9073', 'Honda', 'Fit', 2008, 'LPG', 44264, 5, '2024-01-19 00:00:00', 87);
INSERT INTO public.vehicle VALUES (169, '29 IF 073', 'Ford', 'Econoline E150', 2000, 'Gas', 58992, 4, '2024-01-19 00:00:00', 88);
INSERT INTO public.vehicle VALUES (170, '29 JZ 4000', 'GMC', 'Savana 1500', 2009, 'Diesel', 18845, 2, '2025-04-19 00:00:00', 89);
INSERT INTO public.vehicle VALUES (171, '29 LH 7246', 'Lamborghini', 'Diablo', 1994, 'Electricity', 28294, 3, '2025-04-05 00:00:00', 89);
INSERT INTO public.vehicle VALUES (172, '29 ZF 698', 'Suzuki', 'Grand Vitara', 2005, 'LPG', 11616, 2, '2023-11-03 00:00:00', 90);
INSERT INTO public.vehicle VALUES (173, '29 ZP 5246', 'Mazda', 'Miata MX-5', 2001, 'Gas', 28262, 4, '2023-11-25 00:00:00', 90);
INSERT INTO public.vehicle VALUES (174, '30 CZ 5597', 'Toyota', '4Runner', 2002, 'Diesel', 34386, 3, '2023-11-21 00:00:00', 90);
INSERT INTO public.vehicle VALUES (175, '30 DI 6205', 'Chrysler', '300M', 2002, 'Electricity', 25421, 1, '2024-06-13 00:00:00', 91);
INSERT INTO public.vehicle VALUES (176, '30 JY 7461', 'Kia', 'Optima', 2001, 'LPG', 54751, 4, '2024-05-07 00:00:00', 91);
INSERT INTO public.vehicle VALUES (177, '30 MT 2181', 'Lexus', 'IS', 2008, 'Gas', 27802, 3, '2024-05-26 00:00:00', 91);
INSERT INTO public.vehicle VALUES (178, '30 RD 5993', 'Ford', 'Taurus', 1994, 'Diesel', 57211, 4, '2023-06-28 00:00:00', 92);
INSERT INTO public.vehicle VALUES (179, '30 RJ 6551', 'Shelby', 'GT350', 1969, 'Electricity', 49633, 5, '2023-05-31 00:00:00', 92);
INSERT INTO public.vehicle VALUES (180, '30 US 6734', 'Mercedes-Benz', 'S-Class', 2012, 'LPG', 24159, 4, '2024-12-09 00:00:00', 93);
INSERT INTO public.vehicle VALUES (181, '30 ZN 6161', 'Dodge', 'Stratus', 1999, 'Gas', 32063, 4, '2024-11-21 00:00:00', 93);
INSERT INTO public.vehicle VALUES (182, '31 DB 2122', 'Mitsubishi', 'Outlander', 2003, 'Diesel', 16309, 4, '2024-12-13 00:00:00', 93);
INSERT INTO public.vehicle VALUES (183, '31 IT 1561', 'Mercedes-Benz', 'Sprinter', 2011, 'Electricity', 54439, 1, '2023-05-31 00:00:00', 94);
INSERT INTO public.vehicle VALUES (184, '31 V 5614', 'Lexus', 'SC', 2002, 'LPG', 24358, 3, '2024-04-19 00:00:00', 95);
INSERT INTO public.vehicle VALUES (185, '31 YD 1469', 'Mercedes-Benz', 'W201', 1993, 'Gas', 24383, 2, '2024-09-28 00:00:00', 96);
INSERT INTO public.vehicle VALUES (186, '31 YD 4459', 'Dodge', 'Colt', 1992, 'Diesel', 35942, 1, '2024-08-11 00:00:00', 96);
INSERT INTO public.vehicle VALUES (187, '32 BH 3352', 'BMW', 'Z4 M', 2008, 'Electricity', 15750, 1, '2024-09-15 00:00:00', 96);
INSERT INTO public.vehicle VALUES (188, '32 HY 2592', 'Ford', 'Mustang', 1983, 'LPG', 45180, 3, '2024-09-08 00:00:00', 96);
INSERT INTO public.vehicle VALUES (189, '32 TL 6637', 'Oldsmobile', 'Bravada', 2000, 'Gas', 21302, 2, '2025-05-07 00:00:00', 97);
INSERT INTO public.vehicle VALUES (190, '32 UL 5538', 'Mitsubishi', 'Challenger', 1999, 'Diesel', 20491, 5, '2025-03-15 00:00:00', 97);
INSERT INTO public.vehicle VALUES (191, '32 ZR 4541', 'Audi', '90', 1990, 'Electricity', 22057, 1, '2024-12-16 00:00:00', 98);
INSERT INTO public.vehicle VALUES (192, '33 DI 885', 'Ford', 'E-Series', 2001, 'LPG', 49912, 4, '2025-01-11 00:00:00', 98);
INSERT INTO public.vehicle VALUES (193, '33 EN 8952', 'Cadillac', 'Seville', 1999, 'Gas', 11397, 5, '2023-09-20 00:00:00', 99);
INSERT INTO public.vehicle VALUES (194, '33 GC 9087', 'Pontiac', 'GTO', 1970, 'Diesel', 43284, 5, '2023-09-16 00:00:00', 99);
INSERT INTO public.vehicle VALUES (195, '33 HD 9459', 'Buick', 'Riviera', 1992, 'Electricity', 31368, 5, '2023-09-15 00:00:00', 99);
INSERT INTO public.vehicle VALUES (196, '33 LP 3666', 'Lotus', 'Esprit', 1994, 'LPG', 17187, 5, '2024-11-16 00:00:00', 100);
INSERT INTO public.vehicle VALUES (197, '33 SK 3187', 'Volvo', 'S80', 2000, 'Gas', 12536, 2, '2024-11-24 00:00:00', 100);
INSERT INTO public.vehicle VALUES (198, '34 BD 9698', 'Isuzu', 'Ascender', 2007, 'Diesel', 17554, 3, '2024-01-16 00:00:00', 101);
INSERT INTO public.vehicle VALUES (199, '34 IF 9444', 'BMW', '530', 2002, 'Electricity', 35681, 4, '2025-03-16 00:00:00', 102);
INSERT INTO public.vehicle VALUES (200, '34 VN 5471', 'Holden', 'VS Commodore', 1995, 'LPG', 41800, 5, '2025-03-14 00:00:00', 102);
INSERT INTO public.vehicle VALUES (201, '35 GI 9761', 'Audi', 'A4', 2002, 'Gas', 38888, 4, '2023-10-25 00:00:00', 103);
INSERT INTO public.vehicle VALUES (202, '35 OA 6978', 'BMW', 'X6', 2013, 'Diesel', 54643, 2, '2023-09-24 00:00:00', 103);
INSERT INTO public.vehicle VALUES (203, '35 RS 1992', 'Suzuki', 'Kizashi', 2011, 'Electricity', 59810, 5, '2023-06-29 00:00:00', 104);
INSERT INTO public.vehicle VALUES (204, '35 SH 7702', 'Toyota', 'Tercel', 1992, 'LPG', 46776, 4, '2023-06-30 00:00:00', 104);
INSERT INTO public.vehicle VALUES (205, '35 TR 9849', 'BMW', '7 Series', 1998, 'Gas', 15049, 1, '2024-01-10 00:00:00', 105);
INSERT INTO public.vehicle VALUES (206, '35 UM 478', 'Nissan', 'Murano', 2005, 'Diesel', 43353, 4, '2023-12-18 00:00:00', 105);
INSERT INTO public.vehicle VALUES (207, '35 UO 2230', 'BMW', '3 Series', 2009, 'Electricity', 32866, 3, '2024-01-11 00:00:00', 105);
INSERT INTO public.vehicle VALUES (208, '35 VH 5732', 'Mitsubishi', 'Montero', 1996, 'LPG', 52914, 2, '2024-01-16 00:00:00', 105);
INSERT INTO public.vehicle VALUES (209, '36 DA 9238', 'Dodge', 'Durango', 1998, 'Gas', 44663, 3, '2025-04-08 00:00:00', 106);
INSERT INTO public.vehicle VALUES (210, '36 GZ 1178', 'Maybach', 'Landaulet', 2012, 'Diesel', 55620, 4, '2025-03-18 00:00:00', 106);
INSERT INTO public.vehicle VALUES (211, '36 NY 199', 'Cadillac', 'DTS', 2008, 'Electricity', 51299, 2, '2024-12-01 00:00:00', 107);
INSERT INTO public.vehicle VALUES (212, '36 PS 6442', 'Ford', 'F250', 2002, 'LPG', 34105, 3, '2024-10-31 00:00:00', 107);
INSERT INTO public.vehicle VALUES (213, '36 TF 1996', 'Toyota', 'Matrix', 2011, 'Gas', 13550, 5, '2024-12-20 00:00:00', 107);
INSERT INTO public.vehicle VALUES (214, '36 UN 2615', 'Lexus', 'LX', 2013, 'Diesel', 45056, 3, '2023-02-18 00:00:00', 108);
INSERT INTO public.vehicle VALUES (215, '37 DK 910', 'Dodge', 'Ram 2500 Club', 1999, 'Electricity', 44342, 4, '2023-03-26 00:00:00', 108);
INSERT INTO public.vehicle VALUES (216, '37 ID 8695', 'Dodge', 'Dakota Club', 1994, 'LPG', 45752, 3, '2023-08-29 00:00:00', 109);
INSERT INTO public.vehicle VALUES (217, '37 LC 1233', 'Pontiac', 'G8', 2008, 'Gas', 45487, 2, '2024-08-02 00:00:00', 110);
INSERT INTO public.vehicle VALUES (218, '37 PC 3874', 'Porsche', '911', 1986, 'Diesel', 15958, 1, '2024-07-07 00:00:00', 110);
INSERT INTO public.vehicle VALUES (219, '37 RE 7837', 'Pontiac', 'Bonneville', 1965, 'Electricity', 52653, 2, '2023-05-23 00:00:00', 111);
INSERT INTO public.vehicle VALUES (220, '37 UF 3159', 'Isuzu', 'Space', 1993, 'LPG', 33089, 3, '2025-04-10 00:00:00', 112);
INSERT INTO public.vehicle VALUES (221, '37 US 9250', 'GMC', 'Yukon XL 1500', 2006, 'Gas', 11383, 3, '2025-02-25 00:00:00', 112);
INSERT INTO public.vehicle VALUES (222, '38 EN 6262', 'Chevrolet', 'Corvette', 2002, 'Diesel', 35176, 4, '2025-05-13 00:00:00', 113);
INSERT INTO public.vehicle VALUES (223, '38 IN 3728', 'Honda', 'Civic', 1996, 'Electricity', 11864, 5, '2023-11-10 00:00:00', 114);
INSERT INTO public.vehicle VALUES (224, '38 KJ 9239', 'Nissan', 'Pathfinder', 1995, 'LPG', 38019, 1, '2023-11-06 00:00:00', 114);
INSERT INTO public.vehicle VALUES (225, '38 OG 1134', 'Pontiac', 'Firebird', 1967, 'Gas', 57515, 4, '2023-10-30 00:00:00', 114);
INSERT INTO public.vehicle VALUES (226, '39 MD 101', 'Pontiac', 'Bonneville', 2000, 'Diesel', 30748, 4, '2024-12-20 00:00:00', 115);
INSERT INTO public.vehicle VALUES (227, '39 TM 2066', 'Chevrolet', 'Bel Air', 1967, 'Electricity', 57441, 3, '2025-01-08 00:00:00', 115);
INSERT INTO public.vehicle VALUES (228, '39 UR 1336', 'Ford', 'Five Hundred', 2006, 'LPG', 50513, 1, '2024-12-04 00:00:00', 115);
INSERT INTO public.vehicle VALUES (229, '39 ZK 2438', 'Volvo', '940', 1994, 'Gas', 53574, 1, '2025-01-05 00:00:00', 116);
INSERT INTO public.vehicle VALUES (230, '39 ZR 5923', 'Dodge', 'Viper', 1999, 'Diesel', 11377, 5, '2025-02-25 00:00:00', 116);
INSERT INTO public.vehicle VALUES (231, '40 SD 4401', 'Toyota', 'Corolla', 2012, 'Electricity', 34081, 3, '2024-06-19 00:00:00', 117);
INSERT INTO public.vehicle VALUES (232, '40 UG 9294', 'Porsche', '911', 2011, 'LPG', 10009, 2, '2024-07-15 00:00:00', 117);
INSERT INTO public.vehicle VALUES (233, '41 AR 8011', 'BMW', 'M Roadster', 2008, 'Gas', 57836, 2, '2025-03-03 00:00:00', 118);
INSERT INTO public.vehicle VALUES (234, '41 FC 4096', 'Toyota', 'Xtra', 1993, 'Diesel', 40677, 5, '2024-02-04 00:00:00', 119);
INSERT INTO public.vehicle VALUES (235, '41 GJ 9958', 'Dodge', 'Shadow', 1994, 'Electricity', 53738, 3, '2024-03-16 00:00:00', 119);
INSERT INTO public.vehicle VALUES (236, '41 GL 4779', 'Lexus', 'GS', 2006, 'LPG', 51882, 4, '2024-08-19 00:00:00', 120);
INSERT INTO public.vehicle VALUES (237, '41 L 8431', 'Buick', 'Hearse', 1996, 'Gas', 47772, 4, '2024-09-03 00:00:00', 120);
INSERT INTO public.vehicle VALUES (238, '41 MB 8536', 'Mazda', 'Miata MX-5', 2011, 'Diesel', 48881, 2, '2024-08-11 00:00:00', 121);
INSERT INTO public.vehicle VALUES (239, '41 NM 013', 'Saab', '900', 1995, 'Electricity', 20279, 4, '2024-09-26 00:00:00', 121);
INSERT INTO public.vehicle VALUES (240, '41 PK 6002', 'Ford', 'Econoline E350', 1993, 'LPG', 11280, 1, '2024-10-06 00:00:00', 121);
INSERT INTO public.vehicle VALUES (241, '41 RG 981', 'Maybach', '57', 2006, 'Gas', 54740, 1, '2024-10-25 00:00:00', 122);
INSERT INTO public.vehicle VALUES (242, '41 UC 2124', 'Chrysler', 'Concorde', 1998, 'Diesel', 38576, 5, '2024-09-02 00:00:00', 122);
INSERT INTO public.vehicle VALUES (243, '41 UD 7136', 'Acura', 'RL', 1999, 'Electricity', 23499, 4, '2024-10-14 00:00:00', 122);
INSERT INTO public.vehicle VALUES (244, '41 UH 4458', 'Hummer', 'H2 SUV', 2006, 'LPG', 27093, 4, '2023-07-29 00:00:00', 123);
INSERT INTO public.vehicle VALUES (245, '42 AT 5803', 'Dodge', 'Ram 1500', 1995, 'Gas', 45854, 4, '2024-03-19 00:00:00', 124);
INSERT INTO public.vehicle VALUES (246, '42 BL 5345', 'Dodge', 'Dakota Club', 1993, 'Diesel', 21922, 5, '2023-12-08 00:00:00', 125);
INSERT INTO public.vehicle VALUES (247, '42 IR 3211', 'Bentley', 'Continental GTC', 2008, 'Electricity', 47015, 2, '2023-12-02 00:00:00', 125);
INSERT INTO public.vehicle VALUES (248, '42 NR 7950', 'Lexus', 'LS', 1999, 'LPG', 17148, 2, '2023-05-07 00:00:00', 126);
INSERT INTO public.vehicle VALUES (249, '42 NS 3679', 'Isuzu', 'Stylus', 1993, 'Gas', 48742, 1, '2023-05-05 00:00:00', 126);
INSERT INTO public.vehicle VALUES (250, '42 OC 377', 'Suzuki', 'Samurai', 1993, 'Diesel', 56756, 5, '2023-05-14 00:00:00', 126);
INSERT INTO public.vehicle VALUES (251, '42 OC 8367', 'Mazda', 'B-Series', 2004, 'Electricity', 39876, 1, '2024-03-28 00:00:00', 127);
INSERT INTO public.vehicle VALUES (252, '42 UK 3623', 'Toyota', '4Runner', 1992, 'LPG', 16880, 5, '2024-03-18 00:00:00', 127);
INSERT INTO public.vehicle VALUES (253, '43 AD 3615', 'Pontiac', 'Grand Prix', 2006, 'Gas', 15563, 4, '2024-01-30 00:00:00', 128);
INSERT INTO public.vehicle VALUES (254, '43 AT 778', 'Oldsmobile', 'Silhouette', 1995, 'Diesel', 10938, 1, '2024-03-08 00:00:00', 128);
INSERT INTO public.vehicle VALUES (255, '43 GN 5478', 'Mercedes-Benz', 'M-Class', 2008, 'Electricity', 15185, 3, '2024-02-08 00:00:00', 128);
INSERT INTO public.vehicle VALUES (256, '43 LL 6856', 'Mercedes-Benz', 'S-Class', 1990, 'LPG', 40734, 1, '2024-03-23 00:00:00', 128);
INSERT INTO public.vehicle VALUES (257, '43 UK 7153', 'Toyota', 'Celica', 1998, 'Gas', 55787, 3, '2024-03-18 00:00:00', 128);
INSERT INTO public.vehicle VALUES (258, '43 VY 8384', 'Mitsubishi', 'Galant', 2008, 'Diesel', 26424, 4, '2024-02-28 00:00:00', 129);
INSERT INTO public.vehicle VALUES (259, '44 CJ 8156', 'Isuzu', 'Trooper', 1999, 'Electricity', 24347, 1, '2024-03-28 00:00:00', 129);
INSERT INTO public.vehicle VALUES (260, '44 FD 1716', 'GMC', '3500', 1997, 'LPG', 19186, 2, '2024-08-05 00:00:00', 130);
INSERT INTO public.vehicle VALUES (261, '44 GP 4022', 'Ford', 'Explorer', 2003, 'Gas', 15851, 1, '2024-07-13 00:00:00', 131);
INSERT INTO public.vehicle VALUES (262, '44 NM 9795', 'Infiniti', 'QX', 2010, 'Diesel', 46025, 4, '2023-12-01 00:00:00', 132);
INSERT INTO public.vehicle VALUES (263, '44 PR 2504', 'Ford', 'F-Series', 2011, 'Electricity', 54817, 3, '2023-11-19 00:00:00', 132);
INSERT INTO public.vehicle VALUES (264, '45 CN 2073', 'Volkswagen', 'Corrado', 1994, 'LPG', 44562, 1, '2024-09-21 00:00:00', 133);
INSERT INTO public.vehicle VALUES (265, '45 DU 8487', 'Kia', 'Optima', 2006, 'Gas', 11920, 5, '2024-09-22 00:00:00', 133);
INSERT INTO public.vehicle VALUES (266, '45 EA 5940', 'Infiniti', 'QX56', 2010, 'Diesel', 46641, 1, '2025-01-29 00:00:00', 134);
INSERT INTO public.vehicle VALUES (267, '45 ED 1147', 'Lexus', 'LS', 2012, 'Electricity', 29447, 3, '2025-01-21 00:00:00', 134);
INSERT INTO public.vehicle VALUES (268, '45 EL 075', 'Merkur', 'XR4Ti', 1985, 'LPG', 24923, 5, '2024-03-17 00:00:00', 135);
INSERT INTO public.vehicle VALUES (269, '45 IE 5321', 'Ford', 'Expedition', 2010, 'Gas', 30973, 4, '2024-03-28 00:00:00', 135);
INSERT INTO public.vehicle VALUES (270, '45 OD 9694', 'Lincoln', 'MKS', 2012, 'Diesel', 44040, 1, '2024-04-03 00:00:00', 135);
INSERT INTO public.vehicle VALUES (271, '45 SL 959', 'Ford', 'F-Series', 2006, 'Electricity', 14945, 4, '2023-07-04 00:00:00', 136);
INSERT INTO public.vehicle VALUES (272, '45 UC 8031', 'Volkswagen', 'Passat', 1999, 'LPG', 49874, 2, '2024-04-19 00:00:00', 137);
INSERT INTO public.vehicle VALUES (273, '46 BM 6017', 'Saturn', 'VUE', 2003, 'Gas', 18223, 4, '2024-04-16 00:00:00', 137);
INSERT INTO public.vehicle VALUES (274, '46 F 5928', 'Dodge', 'Avenger', 1997, 'Diesel', 50833, 1, '2024-04-11 00:00:00', 137);
INSERT INTO public.vehicle VALUES (275, '46 JL 4249', 'Ford', 'Econoline E250', 1997, 'Electricity', 21306, 3, '2024-03-11 00:00:00', 137);
INSERT INTO public.vehicle VALUES (276, '46 KE 644', 'Hyundai', 'Tiburon', 2008, 'LPG', 56130, 5, '2024-04-28 00:00:00', 137);
INSERT INTO public.vehicle VALUES (277, '46 MU 3926', 'Nissan', 'Pathfinder', 2005, 'Gas', 18140, 4, '2024-05-11 00:00:00', 138);
INSERT INTO public.vehicle VALUES (278, '46 RP 2415', 'Honda', 'FCX Clarity', 2012, 'Diesel', 32604, 4, '2024-06-17 00:00:00', 138);
INSERT INTO public.vehicle VALUES (279, '46 UO 597', 'Chevrolet', 'Express 2500', 2010, 'Electricity', 54148, 4, '2025-04-14 00:00:00', 139);
INSERT INTO public.vehicle VALUES (280, '46 ZV 7354', 'Pontiac', 'Firebird', 2002, 'LPG', 57182, 4, '2025-04-12 00:00:00', 139);
INSERT INTO public.vehicle VALUES (281, '47 AY 2635', 'Audi', 'A6', 1999, 'Gas', 51798, 1, '2023-08-01 00:00:00', 140);
INSERT INTO public.vehicle VALUES (282, '47 BT 6845', 'Mercury', 'Grand Marquis', 2001, 'Diesel', 25777, 4, '2023-08-10 00:00:00', 140);
INSERT INTO public.vehicle VALUES (283, '47 CR 6756', 'Mercedes-Benz', 'S-Class', 1993, 'Electricity', 14873, 4, '2023-08-17 00:00:00', 140);
INSERT INTO public.vehicle VALUES (284, '47 DF 5605', 'Toyota', 'T100 Xtra', 1997, 'LPG', 43353, 5, '2023-04-11 00:00:00', 141);
INSERT INTO public.vehicle VALUES (285, '47 GB 4310', 'Mercedes-Benz', 'SL-Class', 1992, 'Gas', 14110, 1, '2023-02-26 00:00:00', 141);
INSERT INTO public.vehicle VALUES (286, '47 JS 1442', 'Subaru', 'Impreza', 2000, 'Diesel', 43791, 4, '2024-06-17 00:00:00', 142);
INSERT INTO public.vehicle VALUES (287, '47 NB 8188', 'Kia', 'Carens', 2009, 'Electricity', 24068, 1, '2025-01-29 00:00:00', 143);
INSERT INTO public.vehicle VALUES (288, '47 RZ 842', 'Ford', 'EXP', 1986, 'LPG', 47702, 1, '2023-09-22 00:00:00', 144);
INSERT INTO public.vehicle VALUES (289, '47 SB 1418', 'Pontiac', 'GTO', 1973, 'Gas', 14150, 2, '2023-10-15 00:00:00', 144);
INSERT INTO public.vehicle VALUES (290, '47 TS 1195', 'Toyota', 'Tacoma', 1999, 'Diesel', 55966, 5, '2023-10-19 00:00:00', 144);
INSERT INTO public.vehicle VALUES (291, '47 ZB 8484', 'Subaru', 'XT', 1988, 'Electricity', 53452, 2, '2023-06-11 00:00:00', 145);
INSERT INTO public.vehicle VALUES (292, '48 ER 3655', 'Toyota', 'Matrix', 2010, 'LPG', 51771, 3, '2023-07-24 00:00:00', 145);
INSERT INTO public.vehicle VALUES (293, '48 LS 8729', 'Chevrolet', 'Equinox', 2011, 'Gas', 32386, 2, '2023-07-03 00:00:00', 145);
INSERT INTO public.vehicle VALUES (294, '48 YH 207', 'Chevrolet', 'Tahoe', 2013, 'Diesel', 17491, 1, '2023-07-21 00:00:00', 145);
INSERT INTO public.vehicle VALUES (295, '49 AO 6485', 'Studebaker', 'Avanti', 1963, 'Electricity', 49397, 2, '2024-05-31 00:00:00', 146);
INSERT INTO public.vehicle VALUES (296, '49 BP 5613', 'Ford', 'F450', 2012, 'LPG', 28882, 2, '2024-05-19 00:00:00', 147);
INSERT INTO public.vehicle VALUES (297, '49 DZ 4537', 'Mitsubishi', 'Endeavor', 2008, 'Gas', 32103, 1, '2024-05-28 00:00:00', 147);
INSERT INTO public.vehicle VALUES (298, '49 FY 2731', 'Rolls-Royce', 'Phantom', 2009, 'Diesel', 57391, 4, '2024-03-19 00:00:00', 148);
INSERT INTO public.vehicle VALUES (299, '49 JI 7999', 'Chevrolet', 'S10', 1999, 'Electricity', 34607, 1, '2024-04-24 00:00:00', 148);
INSERT INTO public.vehicle VALUES (300, '49 VZ 6997', 'Acura', 'Integra', 1998, 'LPG', 42172, 4, '2025-05-18 00:00:00', 149);
INSERT INTO public.vehicle VALUES (301, '50 BZ 1254', 'Volvo', 'XC70', 2007, 'Gas', 15002, 1, '2024-06-11 00:00:00', 150);
INSERT INTO public.vehicle VALUES (302, '50 KY 1662', 'Chevrolet', 'Camaro', 1993, 'Diesel', 17366, 4, '2024-05-30 00:00:00', 150);
INSERT INTO public.vehicle VALUES (303, '50 PC 306', 'Dodge', 'Ram Van 1500', 1995, 'Electricity', 51923, 3, '2024-06-17 00:00:00', 150);
INSERT INTO public.vehicle VALUES (304, '50 SL 9598', 'Cadillac', 'STS-V', 2006, 'LPG', 15464, 4, '2024-05-11 00:00:00', 150);
INSERT INTO public.vehicle VALUES (305, '50 SU 5931', 'Dodge', 'Stratus', 2002, 'Gas', 43445, 2, '2025-05-18 00:00:00', 151);
INSERT INTO public.vehicle VALUES (306, '51 FC 8144', 'Ford', 'Econoline E350', 1999, 'Diesel', 16619, 5, '2023-01-16 00:00:00', 152);
INSERT INTO public.vehicle VALUES (307, '51 FE 910', 'Mercury', 'Topaz', 1993, 'Electricity', 26824, 1, '2023-02-11 00:00:00', 152);
INSERT INTO public.vehicle VALUES (308, '51 GY 9777', 'Saab', '900', 1989, 'LPG', 46363, 2, '2023-01-28 00:00:00', 152);
INSERT INTO public.vehicle VALUES (309, '51 RB 5781', 'Volvo', 'S70', 1999, 'Gas', 28044, 1, '2023-06-20 00:00:00', 153);
INSERT INTO public.vehicle VALUES (310, '51 YV 125', 'Mazda', 'Mazdaspeed 3', 2012, 'Diesel', 47827, 3, '2023-07-22 00:00:00', 153);
INSERT INTO public.vehicle VALUES (311, '52 FI 4277', 'MINI', 'Cooper', 2007, 'Electricity', 23204, 2, '2023-06-30 00:00:00', 153);
INSERT INTO public.vehicle VALUES (312, '52 GR 5485', 'Pontiac', 'Bonneville', 1967, 'LPG', 37282, 5, '2023-06-23 00:00:00', 153);
INSERT INTO public.vehicle VALUES (313, '52 M 734', 'Honda', 'Civic', 1995, 'Gas', 41179, 2, '2024-09-08 00:00:00', 154);
INSERT INTO public.vehicle VALUES (314, '52 OV 9183', 'Ford', 'Ranger', 1990, 'Diesel', 38229, 1, '2024-07-26 00:00:00', 154);
INSERT INTO public.vehicle VALUES (315, '52 SR 7338', 'Chevrolet', 'HHR', 2010, 'Electricity', 31940, 5, '2024-08-10 00:00:00', 154);
INSERT INTO public.vehicle VALUES (316, '52 V 8910', 'Mitsubishi', 'RVR', 1993, 'LPG', 11269, 5, '2024-11-01 00:00:00', 155);
INSERT INTO public.vehicle VALUES (317, '52 VR 8793', 'Maybach', '62', 2010, 'Gas', 41881, 5, '2024-11-11 00:00:00', 155);
INSERT INTO public.vehicle VALUES (318, '53 EJ 5295', 'Chevrolet', 'Express 2500', 2009, 'Diesel', 16005, 2, '2024-10-07 00:00:00', 155);
INSERT INTO public.vehicle VALUES (319, '53 LK 6593', 'Cadillac', 'Eldorado', 1995, 'Electricity', 49611, 5, '2024-12-13 00:00:00', 156);
INSERT INTO public.vehicle VALUES (320, '53 MO 8298', 'Ford', 'Crown Victoria', 2006, 'LPG', 34004, 5, '2025-01-30 00:00:00', 156);
INSERT INTO public.vehicle VALUES (321, '53 PT 8559', 'Suzuki', 'Esteem', 2002, 'Gas', 54886, 1, '2024-09-19 00:00:00', 157);
INSERT INTO public.vehicle VALUES (322, '53 RM 2220', 'GMC', 'Savana 2500', 2009, 'Diesel', 59109, 2, '2024-03-27 00:00:00', 158);
INSERT INTO public.vehicle VALUES (323, '53 VP 8499', 'Aston Martin', 'Vantage', 2008, 'Electricity', 31053, 1, '2024-01-29 00:00:00', 159);
INSERT INTO public.vehicle VALUES (324, '54 BD 1370', 'Chevrolet', 'Silverado', 2002, 'LPG', 48329, 1, '2023-09-27 00:00:00', 160);
INSERT INTO public.vehicle VALUES (325, '54 BR 9843', 'Plymouth', 'Neon', 2001, 'Gas', 50382, 5, '2023-09-05 00:00:00', 160);
INSERT INTO public.vehicle VALUES (326, '54 KY 8133', 'BMW', '7 Series', 2003, 'Diesel', 39932, 2, '2023-09-21 00:00:00', 160);
INSERT INTO public.vehicle VALUES (327, '54 TN 484', 'Dodge', 'Nitro', 2009, 'Electricity', 10684, 2, '2024-09-13 00:00:00', 161);
INSERT INTO public.vehicle VALUES (328, '54 VR 3914', 'BMW', 'Alpina B7', 2008, 'LPG', 30239, 1, '2024-09-08 00:00:00', 161);
INSERT INTO public.vehicle VALUES (329, '54 VY 2040', 'Mitsubishi', 'Tundra', 2009, 'Gas', 36538, 5, '2024-01-01 00:00:00', 162);
INSERT INTO public.vehicle VALUES (330, '54 YV 2467', 'Mercury', 'Tracer', 1993, 'Diesel', 13281, 5, '2024-02-05 00:00:00', 162);
INSERT INTO public.vehicle VALUES (331, '55 AT 2002', 'Audi', 'A6', 2010, 'Electricity', 55574, 2, '2023-07-20 00:00:00', 163);
INSERT INTO public.vehicle VALUES (332, '55 BO 5859', 'Honda', 'Accord', 2011, 'LPG', 42675, 1, '2023-08-26 00:00:00', 163);
INSERT INTO public.vehicle VALUES (333, '55 DK 8393', 'Aston Martin', 'Rapide', 2011, 'Gas', 13808, 2, '2024-08-08 00:00:00', 164);
INSERT INTO public.vehicle VALUES (334, '55 JR 1950', 'Toyota', 'Tacoma', 2005, 'Diesel', 30709, 5, '2024-08-27 00:00:00', 164);
INSERT INTO public.vehicle VALUES (335, '55 OA 7795', 'Pontiac', 'Vibe', 2009, 'Electricity', 38673, 5, '2024-08-27 00:00:00', 164);
INSERT INTO public.vehicle VALUES (336, '55 SE 823', 'Ford', 'E-Series', 1993, 'LPG', 20367, 2, '2025-03-16 00:00:00', 165);
INSERT INTO public.vehicle VALUES (337, '55 VY 8337', 'Audi', 'A6', 2008, 'Gas', 13783, 1, '2025-03-26 00:00:00', 165);
INSERT INTO public.vehicle VALUES (338, '55 YG 476', 'BMW', 'Z8', 2000, 'Diesel', 11964, 1, '2024-10-28 00:00:00', 166);
INSERT INTO public.vehicle VALUES (339, '56 AG 3620', 'GMC', 'Savana 2500', 2003, 'Electricity', 33097, 2, '2025-02-10 00:00:00', 167);
INSERT INTO public.vehicle VALUES (340, '56 BO 3708', 'Nissan', 'Altima', 2003, 'LPG', 17050, 3, '2025-01-05 00:00:00', 168);
INSERT INTO public.vehicle VALUES (341, '56 EM 1544', 'Ferrari', 'F430', 2009, 'Gas', 11858, 3, '2025-02-09 00:00:00', 168);
INSERT INTO public.vehicle VALUES (342, '56 HH 2687', 'Mitsubishi', 'Eclipse', 1997, 'Diesel', 22117, 3, '2023-06-07 00:00:00', 169);
INSERT INTO public.vehicle VALUES (343, '56 JM 917', 'GMC', 'Vandura 3500', 1993, 'Electricity', 19514, 5, '2023-04-29 00:00:00', 169);
INSERT INTO public.vehicle VALUES (344, '56 MN 5063', 'Mercedes-Benz', 'SLK-Class', 1999, 'LPG', 24804, 5, '2023-09-24 00:00:00', 170);
INSERT INTO public.vehicle VALUES (345, '56 RB 3088', 'Saturn', 'VUE', 2003, 'Gas', 55761, 3, '2023-09-28 00:00:00', 170);
INSERT INTO public.vehicle VALUES (346, '57 DO 1763', 'Jeep', 'Liberty', 2009, 'Diesel', 36286, 3, '2024-09-01 00:00:00', 171);
INSERT INTO public.vehicle VALUES (347, '57 DS 9627', 'Saturn', 'Relay', 2007, 'Electricity', 13978, 2, '2024-04-27 00:00:00', 172);
INSERT INTO public.vehicle VALUES (348, '57 HT 1724', 'Mercury', 'Capri', 1991, 'LPG', 33662, 4, '2024-12-17 00:00:00', 173);
INSERT INTO public.vehicle VALUES (349, '57 KK 7862', 'BMW', '3 Series', 2002, 'Gas', 21085, 4, '2024-11-30 00:00:00', 173);
INSERT INTO public.vehicle VALUES (350, '57 LO 3715', 'Cadillac', 'Seville', 1999, 'Diesel', 54018, 3, '2024-02-02 00:00:00', 174);
INSERT INTO public.vehicle VALUES (351, '57 LV 4086', 'Jaguar', 'XJ Series', 1996, 'Electricity', 52919, 1, '2024-02-13 00:00:00', 174);
INSERT INTO public.vehicle VALUES (352, '57 UJ 9428', 'Toyota', 'Yaris', 2009, 'LPG', 48073, 2, '2024-01-08 00:00:00', 174);
INSERT INTO public.vehicle VALUES (353, '57 YS 1941', 'Mazda', 'Millenia', 2001, 'Gas', 39880, 3, '2023-03-29 00:00:00', 175);
INSERT INTO public.vehicle VALUES (354, '57 ZB 5155', 'Mitsubishi', 'Galant', 2003, 'Diesel', 11413, 2, '2023-07-17 00:00:00', 176);
INSERT INTO public.vehicle VALUES (355, '58 LE 9700', 'Mazda', 'Miata MX-5', 2008, 'Electricity', 58843, 3, '2024-03-28 00:00:00', 177);
INSERT INTO public.vehicle VALUES (356, '58 OH 3756', 'Maybach', 'Landaulet', 2012, 'LPG', 33325, 2, '2025-01-21 00:00:00', 178);
INSERT INTO public.vehicle VALUES (357, '58 OL 7836', 'Lamborghini', 'Diablo', 1990, 'Gas', 40126, 4, '2025-02-12 00:00:00', 178);
INSERT INTO public.vehicle VALUES (358, '58 P 4854', 'Mercedes-Benz', 'SL-Class', 2008, 'Diesel', 51422, 2, '2025-02-15 00:00:00', 178);
INSERT INTO public.vehicle VALUES (359, '58 RB 8898', 'Mitsubishi', 'Galant', 2001, 'Electricity', 22325, 1, '2023-03-21 00:00:00', 179);
INSERT INTO public.vehicle VALUES (360, '58 YC 6750', 'Porsche', '928', 1988, 'LPG', 39756, 5, '2024-07-20 00:00:00', 180);
INSERT INTO public.vehicle VALUES (361, '58 YT 4419', 'Chevrolet', 'Tahoe', 2012, 'Gas', 40990, 1, '2024-07-25 00:00:00', 180);
INSERT INTO public.vehicle VALUES (362, '58 YZ 6723', 'Volkswagen', 'Golf', 1991, 'Diesel', 16401, 4, '2023-11-19 00:00:00', 181);
INSERT INTO public.vehicle VALUES (363, '59 LF 7001', 'Kia', 'Optima', 2007, 'Electricity', 57848, 5, '2023-12-10 00:00:00', 181);
INSERT INTO public.vehicle VALUES (364, '59 OK 1887', 'GMC', 'Suburban 1500', 1996, 'LPG', 11999, 4, '2023-12-05 00:00:00', 181);
INSERT INTO public.vehicle VALUES (365, '60 CI 3527', 'Chevrolet', 'Silverado 1500', 2010, 'Gas', 46205, 3, '2023-10-12 00:00:00', 182);
INSERT INTO public.vehicle VALUES (366, '60 CK 5641', 'BMW', '325', 2004, 'Diesel', 55423, 5, '2023-10-02 00:00:00', 182);
INSERT INTO public.vehicle VALUES (367, '60 FN 5820', 'Dodge', 'Avenger', 1998, 'Electricity', 58993, 1, '2024-02-16 00:00:00', 183);
INSERT INTO public.vehicle VALUES (368, '60 IU 7404', 'Ford', 'E350', 2006, 'LPG', 32035, 3, '2024-03-27 00:00:00', 183);
INSERT INTO public.vehicle VALUES (369, '60 UV 2035', 'Dodge', 'Ram 1500', 2007, 'Gas', 40193, 3, '2024-02-08 00:00:00', 183);
INSERT INTO public.vehicle VALUES (370, '60 ZG 610', 'Land Rover', 'Defender 90', 1994, 'Diesel', 49038, 5, '2023-11-21 00:00:00', 184);
INSERT INTO public.vehicle VALUES (371, '61 DI 803', 'Suzuki', 'Sidekick', 1993, 'Electricity', 59274, 4, '2024-10-17 00:00:00', 185);
INSERT INTO public.vehicle VALUES (372, '61 HT 5010', 'Honda', 'Odyssey', 1999, 'LPG', 20830, 2, '2024-10-16 00:00:00', 185);
INSERT INTO public.vehicle VALUES (373, '61 PE 1598', 'Pontiac', 'G6', 2008, 'Gas', 11749, 3, '2024-09-23 00:00:00', 185);
INSERT INTO public.vehicle VALUES (374, '61 TU 4234', 'Chevrolet', 'Lumina', 1995, 'Diesel', 17612, 5, '2023-04-18 00:00:00', 186);
INSERT INTO public.vehicle VALUES (375, '61 VL 3754', 'GMC', 'Savana 3500', 1997, 'Electricity', 50673, 1, '2024-06-03 00:00:00', 187);
INSERT INTO public.vehicle VALUES (376, '62 CS 2367', 'Infiniti', 'G', 2007, 'LPG', 14107, 2, '2024-04-06 00:00:00', 188);
INSERT INTO public.vehicle VALUES (377, '62 NA 2326', 'Land Rover', 'Range Rover', 1990, 'Gas', 32911, 1, '2024-04-01 00:00:00', 188);
INSERT INTO public.vehicle VALUES (378, '62 O 9004', 'Mercury', 'Grand Marquis', 2001, 'Diesel', 56231, 5, '2025-01-09 00:00:00', 189);
INSERT INTO public.vehicle VALUES (379, '62 OI 6625', 'Mitsubishi', 'Galant', 1998, 'Electricity', 45495, 5, '2024-12-21 00:00:00', 189);
INSERT INTO public.vehicle VALUES (380, '62 TV 2101', 'Chevrolet', 'Avalanche 2500', 2002, 'LPG', 23476, 5, '2023-07-12 00:00:00', 190);
INSERT INTO public.vehicle VALUES (381, '62 ZA 9277', 'Mercedes-Benz', 'S-Class', 2007, 'Gas', 38124, 4, '2023-07-09 00:00:00', 190);
INSERT INTO public.vehicle VALUES (382, '62 ZU 6978', 'Nissan', 'Pathfinder', 1999, 'Diesel', 57566, 5, '2024-07-26 00:00:00', 191);
INSERT INTO public.vehicle VALUES (383, '63 FD 2446', 'Saturn', 'S-Series', 1992, 'Electricity', 43761, 3, '2023-12-31 00:00:00', 192);
INSERT INTO public.vehicle VALUES (384, '63 LC 7772', 'Pontiac', 'Grand Am', 1992, 'LPG', 41546, 5, '2023-11-18 00:00:00', 192);
INSERT INTO public.vehicle VALUES (385, '63 SS 9826', 'Ford', 'EXP', 1988, 'Gas', 15379, 4, '2024-02-09 00:00:00', 193);
INSERT INTO public.vehicle VALUES (386, '64 FZ 3534', 'Dodge', 'Ram 2500', 2009, 'Diesel', 53221, 2, '2025-03-07 00:00:00', 194);
INSERT INTO public.vehicle VALUES (387, '64 JL 616', 'Toyota', 'Highlander', 2005, 'Electricity', 37808, 1, '2025-03-17 00:00:00', 194);
INSERT INTO public.vehicle VALUES (388, '64 JR 8111', 'Volvo', 'V40', 2004, 'LPG', 31483, 5, '2025-02-20 00:00:00', 194);
INSERT INTO public.vehicle VALUES (389, '64 NC 122', 'Mercedes-Benz', 'CL-Class', 2001, 'Gas', 36780, 5, '2024-03-14 00:00:00', 195);
INSERT INTO public.vehicle VALUES (390, '64 SU 1893', 'Subaru', 'Alcyone SVX', 1995, 'Diesel', 23079, 3, '2023-09-28 00:00:00', 196);
INSERT INTO public.vehicle VALUES (391, '64 TS 1388', 'Lamborghini', 'Countach', 1985, 'Electricity', 55604, 3, '2023-11-07 00:00:00', 196);
INSERT INTO public.vehicle VALUES (392, '64 UA 1760', 'Land Rover', 'LR2', 2008, 'LPG', 33511, 1, '2023-08-02 00:00:00', 197);
INSERT INTO public.vehicle VALUES (393, '64 UD 3582', 'Panoz', 'Esperante', 2006, 'Gas', 11822, 3, '2023-04-23 00:00:00', 198);
INSERT INTO public.vehicle VALUES (394, '65 AJ 5712', 'Ford', 'Thunderbird', 1989, 'Diesel', 19144, 5, '2025-03-01 00:00:00', 199);
INSERT INTO public.vehicle VALUES (395, '65 BA 9981', 'Cadillac', 'Escalade', 2005, 'Electricity', 55895, 4, '2025-02-09 00:00:00', 199);
INSERT INTO public.vehicle VALUES (396, '65 CP 5479', 'Ford', 'Mustang', 2011, 'LPG', 40439, 4, '2024-04-12 00:00:00', 200);
INSERT INTO public.vehicle VALUES (397, '65 KH 1441', 'Mazda', 'MPV', 2005, 'Gas', 39032, 3, '2024-11-29 00:00:00', 201);
INSERT INTO public.vehicle VALUES (398, '65 LC 1148', 'Chevrolet', 'APV', 1993, 'Diesel', 34489, 2, '2024-11-21 00:00:00', 201);
INSERT INTO public.vehicle VALUES (399, '65 LR 7758', 'Audi', '100', 1990, 'Electricity', 45897, 5, '2024-12-07 00:00:00', 202);
INSERT INTO public.vehicle VALUES (400, '65 OA 8447', 'Mercedes-Benz', 'CLK-Class', 2006, 'LPG', 45892, 2, '2025-01-07 00:00:00', 202);
INSERT INTO public.vehicle VALUES (401, '65 PO 6945', 'Chevrolet', 'Tahoe', 2000, 'Gas', 29304, 5, '2024-04-01 00:00:00', 203);
INSERT INTO public.vehicle VALUES (402, '65 SN 5504', 'Mazda', 'Mazdaspeed 3', 2008, 'Diesel', 19062, 5, '2025-05-03 00:00:00', 204);
INSERT INTO public.vehicle VALUES (403, '65 VC 4864', 'Buick', 'Park Avenue', 2001, 'Electricity', 25403, 2, '2024-03-03 00:00:00', 205);
INSERT INTO public.vehicle VALUES (404, '66 B 4080', 'Buick', 'Skylark', 1990, 'LPG', 32701, 3, '2024-03-02 00:00:00', 205);
INSERT INTO public.vehicle VALUES (405, '66 FY 816', 'Dodge', 'Ram Van 1500', 2002, 'Gas', 37000, 4, '2025-05-17 00:00:00', 206);
INSERT INTO public.vehicle VALUES (406, '66 NM 3378', 'Mitsubishi', 'Lancer', 2011, 'Diesel', 55236, 1, '2025-05-12 00:00:00', 206);
INSERT INTO public.vehicle VALUES (407, '66 UB 6089', 'Volkswagen', 'GTI', 1995, 'Electricity', 58538, 4, '2025-04-19 00:00:00', 206);
INSERT INTO public.vehicle VALUES (408, '67 BC 3008', 'Cadillac', 'XLR', 2007, 'LPG', 34053, 1, '2025-04-15 00:00:00', 206);
INSERT INTO public.vehicle VALUES (409, '67 JB 1851', 'Plymouth', 'Neon', 2000, 'Gas', 39807, 2, '2023-05-19 00:00:00', 207);
INSERT INTO public.vehicle VALUES (410, '67 KT 4051', 'Isuzu', 'VehiCROSS', 2001, 'Diesel', 53466, 1, '2023-10-23 00:00:00', 208);
INSERT INTO public.vehicle VALUES (411, '67 VD 5340', 'Volkswagen', 'New Beetle', 2003, 'Electricity', 35977, 5, '2023-11-11 00:00:00', 208);
INSERT INTO public.vehicle VALUES (412, '68 BE 4161', 'Ford', 'E-Series', 1995, 'LPG', 45958, 5, '2024-03-03 00:00:00', 209);
INSERT INTO public.vehicle VALUES (413, '68 HE 9458', 'Porsche', '911', 1988, 'Gas', 35540, 3, '2024-12-28 00:00:00', 210);
INSERT INTO public.vehicle VALUES (414, '68 MA 9758', 'Cadillac', 'DeVille', 1995, 'Diesel', 31365, 5, '2025-01-07 00:00:00', 210);
INSERT INTO public.vehicle VALUES (415, '68 NR 1501', 'Nissan', 'Titan', 2007, 'Electricity', 49406, 1, '2025-03-03 00:00:00', 211);
INSERT INTO public.vehicle VALUES (416, '68 OR 1052', 'Mitsubishi', 'Pajero', 1989, 'LPG', 56846, 5, '2024-07-18 00:00:00', 212);
INSERT INTO public.vehicle VALUES (417, '68 SY 6758', 'Buick', 'Roadmaster', 1995, 'Gas', 42950, 4, '2024-07-17 00:00:00', 212);
INSERT INTO public.vehicle VALUES (418, '69 AV 4141', 'Chevrolet', 'Corvette', 1978, 'Diesel', 41987, 5, '2023-07-08 00:00:00', 213);
INSERT INTO public.vehicle VALUES (419, '69 EZ 7991', 'GMC', 'Yukon XL 2500', 2003, 'Electricity', 23444, 4, '2024-09-10 00:00:00', 214);
INSERT INTO public.vehicle VALUES (420, '69 FI 8077', 'Hillman', 'Minx Magnificent', 1950, 'LPG', 42971, 4, '2024-09-16 00:00:00', 214);
INSERT INTO public.vehicle VALUES (421, '69 GZ 9976', 'Infiniti', 'G', 2001, 'Gas', 19272, 1, '2024-04-07 00:00:00', 215);
INSERT INTO public.vehicle VALUES (422, '69 P 7137', 'Ford', 'Fusion', 2007, 'Diesel', 42627, 3, '2024-03-01 00:00:00', 215);
INSERT INTO public.vehicle VALUES (423, '69 PF 5603', 'Ford', 'Mustang', 2008, 'Electricity', 23624, 4, '2024-05-06 00:00:00', 216);
INSERT INTO public.vehicle VALUES (424, '69 TR 3298', 'Chevrolet', 'Caprice', 1994, 'LPG', 34502, 2, '2024-05-06 00:00:00', 216);
INSERT INTO public.vehicle VALUES (425, '70 OH 423', 'Land Rover', 'Range Rover Evoque', 2012, 'Gas', 26010, 2, '2024-05-17 00:00:00', 216);
INSERT INTO public.vehicle VALUES (426, '70 RO 7821', 'Ford', 'Aerostar', 1995, 'Diesel', 41278, 3, '2024-10-12 00:00:00', 217);
INSERT INTO public.vehicle VALUES (427, '70 SO 9448', 'Toyota', 'RAV4', 1996, 'Electricity', 40161, 1, '2024-08-22 00:00:00', 217);
INSERT INTO public.vehicle VALUES (428, '70 YY 9065', 'Bentley', 'Continental', 2009, 'LPG', 24794, 2, '2024-03-24 00:00:00', 218);
INSERT INTO public.vehicle VALUES (429, '71 EJ 2457', 'Buick', 'Terraza', 2005, 'Gas', 58032, 5, '2023-03-08 00:00:00', 219);
INSERT INTO public.vehicle VALUES (430, '71 HE 9365', 'Nissan', '370Z', 2009, 'Diesel', 39675, 3, '2023-03-14 00:00:00', 219);
INSERT INTO public.vehicle VALUES (431, '71 HK 1518', 'GMC', 'Envoy', 2007, 'Electricity', 29925, 1, '2023-03-06 00:00:00', 219);
INSERT INTO public.vehicle VALUES (432, '71 VI 1421', 'Toyota', 'Highlander', 2011, 'LPG', 57736, 4, '2023-03-28 00:00:00', 220);
INSERT INTO public.vehicle VALUES (433, '71 VK 1982', 'Chevrolet', 'Silverado 1500', 2007, 'Gas', 36120, 5, '2023-03-31 00:00:00', 220);
INSERT INTO public.vehicle VALUES (434, '72 BL 6804', 'Mercedes-Benz', '300TE', 1993, 'Diesel', 36960, 4, '2023-03-28 00:00:00', 220);
INSERT INTO public.vehicle VALUES (435, '72 HS 8575', 'Mitsubishi', 'Diamante', 1995, 'Electricity', 26343, 4, '2024-11-08 00:00:00', 221);
INSERT INTO public.vehicle VALUES (436, '72 RJ 6886', 'Dodge', 'Stratus', 2002, 'LPG', 10066, 3, '2024-11-22 00:00:00', 221);
INSERT INTO public.vehicle VALUES (437, '72 RJ 9703', 'Chrysler', 'Crossfire', 2006, 'Gas', 58945, 4, '2025-06-19 00:00:00', 222);
INSERT INTO public.vehicle VALUES (438, '73 DI 6232', 'Peugeot', '207', 2007, 'Diesel', 18547, 3, '2025-05-09 00:00:00', 222);
INSERT INTO public.vehicle VALUES (439, '73 FJ 9797', 'Ford', 'Crown Victoria', 2011, 'Electricity', 52257, 5, '2024-05-06 00:00:00', 223);
INSERT INTO public.vehicle VALUES (440, '73 FS 074', 'Toyota', 'Sienna', 2005, 'LPG', 21334, 4, '2023-07-13 00:00:00', 224);
INSERT INTO public.vehicle VALUES (441, '73 GI 1013', 'Chevrolet', 'Suburban 2500', 2009, 'Gas', 31947, 3, '2023-08-12 00:00:00', 224);
INSERT INTO public.vehicle VALUES (442, '73 KC 5993', 'Jaguar', 'XJ Series', 1995, 'Diesel', 50214, 2, '2023-10-13 00:00:00', 225);
INSERT INTO public.vehicle VALUES (443, '73 KF 8566', 'GMC', 'Envoy XUV', 2005, 'Electricity', 35520, 5, '2023-10-11 00:00:00', 225);
INSERT INTO public.vehicle VALUES (444, '73 NM 9274', 'GMC', 'Yukon', 1998, 'LPG', 25832, 5, '2023-11-18 00:00:00', 225);
INSERT INTO public.vehicle VALUES (445, '73 RT 6723', 'Hyundai', 'Tiburon', 1997, 'Gas', 44345, 1, '2023-02-14 00:00:00', 226);
INSERT INTO public.vehicle VALUES (446, '74 KY 5351', 'Geo', 'Tracker', 1997, 'Diesel', 49947, 1, '2023-03-01 00:00:00', 226);
INSERT INTO public.vehicle VALUES (447, '74 OF 2892', 'Chrysler', 'Aspen', 2007, 'Electricity', 26363, 3, '2023-03-07 00:00:00', 226);
INSERT INTO public.vehicle VALUES (448, '74 PL 9685', 'Chevrolet', 'Volt', 2012, 'LPG', 57617, 5, '2023-11-11 00:00:00', 227);
INSERT INTO public.vehicle VALUES (449, '74 RC 598', 'Maserati', '228', 1989, 'Gas', 23516, 5, '2023-04-20 00:00:00', 228);
INSERT INTO public.vehicle VALUES (450, '74 TS 9352', 'Chevrolet', 'Cavalier', 2004, 'Diesel', 18266, 3, '2023-03-26 00:00:00', 228);
INSERT INTO public.vehicle VALUES (451, '74 Y 4095', 'Maserati', 'GranTurismo', 2010, 'Electricity', 42219, 3, '2023-05-23 00:00:00', 228);
INSERT INTO public.vehicle VALUES (452, '75 BH 6811', 'Jaguar', 'XK Series', 2013, 'LPG', 33240, 1, '2023-09-22 00:00:00', 229);
INSERT INTO public.vehicle VALUES (453, '75 DK 5049', 'Subaru', 'Impreza', 2002, 'Gas', 22039, 3, '2023-11-01 00:00:00', 229);
INSERT INTO public.vehicle VALUES (454, '75 HG 6331', 'Buick', 'Regal', 1997, 'Diesel', 55947, 5, '2023-09-29 00:00:00', 229);
INSERT INTO public.vehicle VALUES (455, '75 ID 5691', 'BMW', 'M', 2000, 'Electricity', 31871, 4, '2023-01-14 00:00:00', 230);
INSERT INTO public.vehicle VALUES (456, '75 KO 3763', 'GMC', 'Suburban 1500', 1998, 'LPG', 32737, 3, '2025-02-15 00:00:00', 231);
INSERT INTO public.vehicle VALUES (457, '75 KV 9668', 'GMC', 'Sierra 2500', 2003, 'Gas', 25170, 3, '2023-01-26 00:00:00', 232);
INSERT INTO public.vehicle VALUES (458, '75 RO 7076', 'Ford', 'E350', 2005, 'Diesel', 20001, 3, '2023-01-13 00:00:00', 232);
INSERT INTO public.vehicle VALUES (459, '75 SC 7822', 'Mazda', '929', 1989, 'Electricity', 11493, 3, '2023-01-22 00:00:00', 232);
INSERT INTO public.vehicle VALUES (460, '75 TR 758', 'Hyundai', 'Azera', 2006, 'LPG', 34179, 4, '2024-02-16 00:00:00', 233);
INSERT INTO public.vehicle VALUES (461, '75 UU 6697', 'GMC', '2500 Club Coupe', 1993, 'Gas', 39987, 1, '2025-01-11 00:00:00', 234);
INSERT INTO public.vehicle VALUES (462, '76 CB 3972', 'Buick', 'Century', 2004, 'Diesel', 44804, 5, '2025-02-19 00:00:00', 234);
INSERT INTO public.vehicle VALUES (463, '76 ES 5527', 'Isuzu', 'Trooper', 1996, 'Electricity', 35806, 1, '2024-03-10 00:00:00', 235);
INSERT INTO public.vehicle VALUES (464, '76 HN 3164', 'Mercury', 'Monterey', 2004, 'LPG', 10678, 2, '2024-03-11 00:00:00', 235);
INSERT INTO public.vehicle VALUES (465, '76 JE 3035', 'Aptera', 'Typ-1', 2008, 'Gas', 46129, 4, '2024-04-04 00:00:00', 235);
INSERT INTO public.vehicle VALUES (466, '76 LJ 9986', 'Lotus', 'Elan', 1990, 'Diesel', 42279, 4, '2023-03-19 00:00:00', 236);
INSERT INTO public.vehicle VALUES (467, '76 VA 9220', 'Buick', 'Century', 1990, 'Electricity', 34314, 3, '2023-03-05 00:00:00', 236);
INSERT INTO public.vehicle VALUES (468, '76 VK 686', 'GMC', 'Envoy XL', 2005, 'LPG', 37673, 3, '2024-09-04 00:00:00', 237);
INSERT INTO public.vehicle VALUES (469, '77 AY 658', 'Honda', 'Fit', 2007, 'Gas', 50919, 4, '2024-08-24 00:00:00', 237);
INSERT INTO public.vehicle VALUES (470, '77 BB 5246', 'Hummer', 'H1', 1995, 'Diesel', 10933, 5, '2024-08-18 00:00:00', 238);
INSERT INTO public.vehicle VALUES (471, '77 FF 7591', 'GMC', 'Savana 1500', 2008, 'Electricity', 21314, 1, '2024-07-03 00:00:00', 238);
INSERT INTO public.vehicle VALUES (472, '77 GL 2408', 'Volkswagen', 'Passat', 2000, 'LPG', 59122, 5, '2023-07-31 00:00:00', 239);
INSERT INTO public.vehicle VALUES (473, '77 IJ 6928', 'Infiniti', 'IPL G', 2012, 'Gas', 16885, 4, '2023-07-27 00:00:00', 239);
INSERT INTO public.vehicle VALUES (474, '77 JS 3293', 'Dodge', 'Dakota', 1995, 'Diesel', 39938, 5, '2023-08-16 00:00:00', 239);
INSERT INTO public.vehicle VALUES (475, '77 RO 5025', 'Mitsubishi', 'Endeavor', 2007, 'Electricity', 54363, 2, '2023-07-23 00:00:00', 239);
INSERT INTO public.vehicle VALUES (476, '77 VO 2533', 'Volkswagen', 'New Beetle', 2008, 'LPG', 17578, 3, '2023-07-23 00:00:00', 239);
INSERT INTO public.vehicle VALUES (477, '77 YI 6484', 'Lotus', 'Exige', 2007, 'Gas', 35346, 3, '2023-04-02 00:00:00', 240);
INSERT INTO public.vehicle VALUES (478, '78 CH 2079', 'Mitsubishi', 'Precis', 1993, 'Diesel', 27785, 3, '2023-04-28 00:00:00', 240);
INSERT INTO public.vehicle VALUES (479, '78 GK 3265', 'Ford', 'E-Series', 2002, 'Electricity', 44081, 4, '2023-04-14 00:00:00', 240);
INSERT INTO public.vehicle VALUES (480, '78 HD 3314', 'Audi', 'S8', 2007, 'LPG', 56027, 3, '2024-05-25 00:00:00', 241);
INSERT INTO public.vehicle VALUES (481, '78 UT 5748', 'Pontiac', 'LeMans', 1965, 'Gas', 46794, 5, '2024-05-13 00:00:00', 241);
INSERT INTO public.vehicle VALUES (482, '78 YN 372', 'Cadillac', 'Escalade', 2008, 'Diesel', 17763, 2, '2024-01-18 00:00:00', 242);
INSERT INTO public.vehicle VALUES (483, '79 BH 3630', 'Acura', 'RSX', 2005, 'Electricity', 11471, 2, '2024-01-16 00:00:00', 242);
INSERT INTO public.vehicle VALUES (484, '79 EA 8325', 'Pontiac', 'Firebird', 1992, 'LPG', 54402, 5, '2024-01-17 00:00:00', 242);
INSERT INTO public.vehicle VALUES (485, '79 GR 7597', 'Mazda', 'MX-3', 1993, 'Gas', 42379, 3, '2024-09-01 00:00:00', 243);
INSERT INTO public.vehicle VALUES (486, '79 GR 9066', 'Mitsubishi', '3000GT', 1996, 'Diesel', 20143, 3, '2024-08-29 00:00:00', 243);
INSERT INTO public.vehicle VALUES (487, '79 KL 6533', 'Porsche', 'Cayenne', 2004, 'Electricity', 16147, 1, '2023-06-15 00:00:00', 244);
INSERT INTO public.vehicle VALUES (488, '79 OV 4726', 'Dodge', 'Ram 1500 Club', 1996, 'LPG', 31996, 1, '2023-12-16 00:00:00', 245);
INSERT INTO public.vehicle VALUES (489, '79 UH 8612', 'Lincoln', 'Navigator L', 2010, 'Gas', 33414, 5, '2024-05-09 00:00:00', 246);
INSERT INTO public.vehicle VALUES (490, '80 ES 1240', 'Chevrolet', 'Silverado 2500', 2006, 'Diesel', 18657, 2, '2023-10-10 00:00:00', 247);
INSERT INTO public.vehicle VALUES (491, '80 HK 7698', 'Volkswagen', 'Eurovan', 1993, 'Electricity', 47181, 4, '2025-04-07 00:00:00', 248);
INSERT INTO public.vehicle VALUES (492, '80 PU 7895', 'Infiniti', 'G', 2003, 'LPG', 50251, 5, '2025-04-06 00:00:00', 248);
INSERT INTO public.vehicle VALUES (493, '80 YO 981', 'GMC', 'Savana 2500', 2000, 'Gas', 49935, 4, '2025-04-17 00:00:00', 248);
INSERT INTO public.vehicle VALUES (494, '80 ZJ 7459', 'Buick', 'Skylark', 1987, 'Diesel', 25751, 5, '2023-08-22 00:00:00', 249);
INSERT INTO public.vehicle VALUES (495, '81 HV 9787', 'Chevrolet', 'Silverado 2500', 2002, 'Electricity', 48895, 2, '2023-08-31 00:00:00', 249);
INSERT INTO public.vehicle VALUES (496, '81 IB 8145', 'Subaru', 'Brat', 1984, 'LPG', 38811, 1, '2023-09-09 00:00:00', 249);
INSERT INTO public.vehicle VALUES (497, '81 KO 9569', 'Pontiac', 'Fiero', 1984, 'Gas', 17331, 5, '2024-06-22 00:00:00', 250);
INSERT INTO public.vehicle VALUES (498, '81 TP 4110', 'Dodge', 'Ram Van 2500', 2001, 'Diesel', 59687, 1, '2024-06-14 00:00:00', 250);
INSERT INTO public.vehicle VALUES (499, '81 U 3402', 'Subaru', 'Outback', 2010, 'Electricity', 38675, 5, '2023-04-13 00:00:00', 251);
INSERT INTO public.vehicle VALUES (500, '81 VZ 6996', 'MINI', 'Clubman', 2009, 'LPG', 46101, 2, '2024-05-29 00:00:00', 252);
INSERT INTO public.vehicle VALUES (501, '01 BG 1975', 'Lexus', 'GX', 2003, 'Gas', 50897, 2, '2024-05-29 00:00:00', 253);
INSERT INTO public.vehicle VALUES (502, '01 SK 6489', 'Mazda', 'RX-8', 2009, 'Diesel', 47076, 4, '2023-09-15 00:00:00', 254);
INSERT INTO public.vehicle VALUES (503, '02 LB 7462', 'Chevrolet', 'Suburban 1500', 2011, 'Electricity', 10441, 5, '2023-09-06 00:00:00', 254);
INSERT INTO public.vehicle VALUES (504, '02 VI 2735', 'Lexus', 'SC', 2005, 'LPG', 53703, 4, '2023-09-09 00:00:00', 254);
INSERT INTO public.vehicle VALUES (505, '02 YF 1492', 'Suzuki', 'XL-7', 2004, 'Gas', 50081, 2, '2023-09-22 00:00:00', 254);
INSERT INTO public.vehicle VALUES (506, '03 J 9987', 'Mazda', 'MX-5', 2000, 'Diesel', 47453, 5, '2023-04-29 00:00:00', 255);
INSERT INTO public.vehicle VALUES (507, '03 TO 640', 'Ford', 'Edge', 2007, 'Electricity', 23972, 4, '2024-10-19 00:00:00', 256);
INSERT INTO public.vehicle VALUES (508, '03 YI 4375', 'Pontiac', '6000', 1985, 'LPG', 39316, 5, '2023-07-16 00:00:00', 257);
INSERT INTO public.vehicle VALUES (509, '03 ZK 1756', 'Saturn', 'VUE', 2003, 'Gas', 11880, 5, '2023-08-13 00:00:00', 257);
INSERT INTO public.vehicle VALUES (510, '03 ZL 2310', 'Ford', 'Country', 1967, 'Diesel', 51109, 5, '2023-07-13 00:00:00', 257);
INSERT INTO public.vehicle VALUES (511, '04 BN 9668', 'Oldsmobile', '88', 1994, 'Electricity', 41318, 1, '2024-09-14 00:00:00', 258);
INSERT INTO public.vehicle VALUES (512, '04 EB 9139', 'Kia', 'Sportage', 2012, 'LPG', 49648, 3, '2024-10-14 00:00:00', 258);
INSERT INTO public.vehicle VALUES (513, '04 FD 1392', 'BMW', '7 Series', 2006, 'Gas', 25435, 1, '2024-09-01 00:00:00', 258);
INSERT INTO public.vehicle VALUES (514, '04 GZ 1250', 'Plymouth', 'Voyager', 1998, 'Diesel', 11072, 1, '2024-10-07 00:00:00', 258);
INSERT INTO public.vehicle VALUES (515, '04 JH 2915', 'GMC', 'Savana 2500', 2011, 'Electricity', 49005, 3, '2024-08-25 00:00:00', 259);
INSERT INTO public.vehicle VALUES (516, '04 NG 6539', 'Dodge', 'Sprinter', 2009, 'LPG', 10785, 4, '2024-08-01 00:00:00', 259);
INSERT INTO public.vehicle VALUES (517, '04 S 8374', 'Cadillac', 'CTS-V', 2006, 'Gas', 32853, 5, '2024-08-18 00:00:00', 259);
INSERT INTO public.vehicle VALUES (518, '04 SF 9130', 'Maserati', 'Spyder', 2002, 'Diesel', 33185, 5, '2025-04-10 00:00:00', 260);
INSERT INTO public.vehicle VALUES (519, '04 V 5166', 'Pontiac', 'Bonneville', 1984, 'Electricity', 27739, 4, '2025-04-20 00:00:00', 260);
INSERT INTO public.vehicle VALUES (520, '05 BR 2083', 'Aston Martin', 'DB9', 2011, 'LPG', 34741, 1, '2025-03-14 00:00:00', 260);
INSERT INTO public.vehicle VALUES (521, '05 FA 6276', 'Nissan', '370Z', 2011, 'Gas', 55676, 2, '2024-11-23 00:00:00', 261);
INSERT INTO public.vehicle VALUES (522, '05 HC 832', 'Chevrolet', 'Astro', 1992, 'Diesel', 32959, 1, '2023-03-26 00:00:00', 262);
INSERT INTO public.vehicle VALUES (523, '05 HR 2348', 'GMC', 'Savana 3500', 2000, 'Electricity', 44705, 1, '2023-04-25 00:00:00', 262);
INSERT INTO public.vehicle VALUES (524, '05 KK 8033', 'Acura', 'TL', 2011, 'LPG', 23715, 4, '2024-08-25 00:00:00', 263);
INSERT INTO public.vehicle VALUES (525, '05 PP 3885', 'Chrysler', '300M', 2000, 'Gas', 14061, 4, '2024-10-20 00:00:00', 263);
INSERT INTO public.vehicle VALUES (526, '05 ZP 6218', 'Lotus', 'Esprit', 1987, 'Diesel', 49438, 1, '2024-09-15 00:00:00', 263);
INSERT INTO public.vehicle VALUES (527, '06 AJ 6307', 'Dodge', 'Ram Van B350', 1994, 'Electricity', 34215, 4, '2024-05-18 00:00:00', 264);
INSERT INTO public.vehicle VALUES (528, '06 FB 8259', 'Toyota', 'RAV4', 2004, 'LPG', 11878, 5, '2024-04-21 00:00:00', 265);
INSERT INTO public.vehicle VALUES (529, '06 GZ 4537', 'Cadillac', 'CTS', 2003, 'Gas', 18647, 5, '2024-04-01 00:00:00', 265);
INSERT INTO public.vehicle VALUES (530, '06 HZ 2921', 'Cadillac', 'Seville', 1992, 'Diesel', 43360, 3, '2024-05-11 00:00:00', 265);
INSERT INTO public.vehicle VALUES (531, '06 IZ 7480', 'Mitsubishi', 'Mirage', 1988, 'Electricity', 16511, 3, '2024-01-31 00:00:00', 266);
INSERT INTO public.vehicle VALUES (532, '06 MC 3965', 'Ford', 'Edge', 2007, 'LPG', 39843, 5, '2023-01-07 00:00:00', 267);
INSERT INTO public.vehicle VALUES (533, '06 NJ 176', 'Hyundai', 'Tucson', 2010, 'Gas', 37154, 3, '2024-12-19 00:00:00', 268);
INSERT INTO public.vehicle VALUES (534, '06 PE 1880', 'Dodge', 'Dakota Club', 1994, 'Diesel', 33637, 5, '2024-12-23 00:00:00', 268);
INSERT INTO public.vehicle VALUES (535, '06 Y 6867', 'Suzuki', 'Grand Vitara', 2008, 'Electricity', 36225, 1, '2025-01-02 00:00:00', 268);
INSERT INTO public.vehicle VALUES (536, '07 BV 9931', 'Pontiac', 'Firefly', 1988, 'LPG', 51911, 1, '2025-01-24 00:00:00', 268);
INSERT INTO public.vehicle VALUES (537, '07 HC 3279', 'Dodge', 'Colt', 1993, 'Gas', 13335, 1, '2023-05-11 00:00:00', 269);
INSERT INTO public.vehicle VALUES (538, '07 LY 1988', 'Dodge', 'Caravan', 2000, 'Diesel', 16033, 2, '2023-05-21 00:00:00', 269);
INSERT INTO public.vehicle VALUES (539, '07 TE 6171', 'Lincoln', 'Mark VIII', 1995, 'Electricity', 14293, 5, '2024-07-31 00:00:00', 270);
INSERT INTO public.vehicle VALUES (540, '07 TN 5902', 'Ford', 'Festiva', 1991, 'LPG', 40897, 1, '2024-08-07 00:00:00', 270);
INSERT INTO public.vehicle VALUES (541, '07 UA 1360', 'Dodge', 'Ram 2500', 1995, 'Gas', 15684, 4, '2023-10-10 00:00:00', 271);
INSERT INTO public.vehicle VALUES (542, '08 DC 6396', 'Honda', 'Pilot', 2010, 'Diesel', 40813, 4, '2023-11-08 00:00:00', 271);
INSERT INTO public.vehicle VALUES (543, '08 DF 3748', 'Plymouth', 'Volare', 1976, 'Electricity', 55002, 2, '2024-02-08 00:00:00', 272);
INSERT INTO public.vehicle VALUES (544, '08 FF 4237', 'Chevrolet', 'Express 1500', 2003, 'LPG', 35125, 3, '2024-03-11 00:00:00', 272);
INSERT INTO public.vehicle VALUES (545, '08 IO 1012', 'Lexus', 'LS', 2008, 'Gas', 41510, 4, '2024-02-18 00:00:00', 272);
INSERT INTO public.vehicle VALUES (546, '08 KG 6020', 'BMW', '5 Series', 2004, 'Diesel', 44820, 1, '2024-03-20 00:00:00', 272);
INSERT INTO public.vehicle VALUES (547, '08 LI 4268', 'Oldsmobile', 'Bravada', 1999, 'Electricity', 54647, 1, '2024-06-08 00:00:00', 273);
INSERT INTO public.vehicle VALUES (548, '08 OF 558', 'Chevrolet', 'Classic', 2005, 'LPG', 26521, 1, '2023-11-01 00:00:00', 274);
INSERT INTO public.vehicle VALUES (549, '08 PM 7727', 'Bentley', 'Continental', 2005, 'Gas', 20436, 2, '2023-09-18 00:00:00', 274);
INSERT INTO public.vehicle VALUES (550, '08 RI 686', 'Chrysler', 'Imperial', 1993, 'Diesel', 20269, 5, '2023-09-28 00:00:00', 274);
INSERT INTO public.vehicle VALUES (551, '08 UN 5361', 'Chevrolet', 'Express 1500', 2007, 'Electricity', 16637, 3, '2025-03-24 00:00:00', 275);
INSERT INTO public.vehicle VALUES (552, '08 YN 123', 'Oldsmobile', 'Aurora', 2001, 'LPG', 56284, 3, '2024-01-28 00:00:00', 276);
INSERT INTO public.vehicle VALUES (553, '09 GY 2213', 'Jeep', 'Wrangler', 2007, 'Gas', 33267, 1, '2024-03-14 00:00:00', 276);
INSERT INTO public.vehicle VALUES (554, '09 IT 3850', 'Nissan', 'Frontier', 2011, 'Diesel', 51805, 5, '2024-02-14 00:00:00', 276);
INSERT INTO public.vehicle VALUES (555, '09 ZA 9342', 'Mercury', 'Cougar', 1997, 'Electricity', 51423, 3, '2023-08-14 00:00:00', 277);
INSERT INTO public.vehicle VALUES (556, '10 AK 9816', 'Lexus', 'GX', 2007, 'LPG', 14366, 5, '2023-06-24 00:00:00', 277);
INSERT INTO public.vehicle VALUES (557, '10 EV 6139', 'Ford', 'Tempo', 1991, 'Gas', 23001, 4, '2024-11-28 00:00:00', 278);
INSERT INTO public.vehicle VALUES (558, '10 FF 4204', 'Ford', 'F-Series', 1994, 'Diesel', 24309, 3, '2024-12-01 00:00:00', 278);
INSERT INTO public.vehicle VALUES (559, '10 IY 4541', 'Pontiac', 'Firebird', 1993, 'Electricity', 18597, 2, '2023-07-16 00:00:00', 279);
INSERT INTO public.vehicle VALUES (560, '10 KA 4587', 'Toyota', 'Tacoma', 2005, 'LPG', 18715, 3, '2023-06-13 00:00:00', 279);
INSERT INTO public.vehicle VALUES (561, '10 PK 821', 'Dodge', 'Intrepid', 1995, 'Gas', 21021, 4, '2024-07-29 00:00:00', 280);
INSERT INTO public.vehicle VALUES (562, '10 YS 945', 'Dodge', 'Dakota', 2001, 'Diesel', 21768, 5, '2024-07-31 00:00:00', 280);
INSERT INTO public.vehicle VALUES (563, '11 AO 1567', 'Pontiac', 'Trans Sport', 1995, 'Electricity', 24603, 3, '2024-07-30 00:00:00', 280);
INSERT INTO public.vehicle VALUES (564, '11 HM 9581', 'Nissan', '300ZX', 1992, 'LPG', 14829, 3, '2024-05-30 00:00:00', 281);
INSERT INTO public.vehicle VALUES (565, '11 JP 4657', 'Dodge', 'Viper', 2001, 'Gas', 57295, 2, '2024-05-26 00:00:00', 281);
INSERT INTO public.vehicle VALUES (566, '11 UU 8038', 'GMC', 'Envoy', 2004, 'Diesel', 14461, 5, '2025-04-02 00:00:00', 282);
INSERT INTO public.vehicle VALUES (567, '11 YF 7971', 'Tesla', 'Roadster', 2010, 'Electricity', 10318, 3, '2025-03-03 00:00:00', 282);
INSERT INTO public.vehicle VALUES (568, '11 YI 6908', 'Alfa Romeo', '164', 1993, 'LPG', 21931, 1, '2023-12-07 00:00:00', 283);
INSERT INTO public.vehicle VALUES (569, '12 GG 5783', 'Ford', 'F250', 2004, 'Gas', 10194, 5, '2023-12-26 00:00:00', 284);
INSERT INTO public.vehicle VALUES (570, '12 KN 7268', 'Honda', 'Element', 2010, 'Diesel', 35847, 5, '2023-12-22 00:00:00', 284);
INSERT INTO public.vehicle VALUES (571, '12 LU 8146', 'Nissan', 'Frontier', 2002, 'Electricity', 12814, 5, '2023-12-29 00:00:00', 285);
INSERT INTO public.vehicle VALUES (572, '12 NK 8517', 'Saturn', 'S-Series', 1997, 'LPG', 18302, 2, '2024-03-11 00:00:00', 286);
INSERT INTO public.vehicle VALUES (573, '12 TK 4638', 'Hyundai', 'Tiburon', 2000, 'Gas', 29060, 3, '2024-03-12 00:00:00', 286);
INSERT INTO public.vehicle VALUES (574, '12 UN 9370', 'Lincoln', 'Town Car', 1996, 'Diesel', 11608, 4, '2025-04-11 00:00:00', 287);
INSERT INTO public.vehicle VALUES (575, '13 EL 1178', 'Oldsmobile', 'Cutlass', 1999, 'Electricity', 28383, 3, '2025-04-09 00:00:00', 287);
INSERT INTO public.vehicle VALUES (576, '13 GB 7500', 'Volvo', 'V70', 2007, 'LPG', 34580, 4, '2024-11-12 00:00:00', 288);
INSERT INTO public.vehicle VALUES (577, '13 JU 3387', 'Nissan', 'Maxima', 2010, 'Gas', 50675, 1, '2024-12-21 00:00:00', 288);
INSERT INTO public.vehicle VALUES (578, '13 ZO 9537', 'Cadillac', 'Brougham', 1992, 'Diesel', 15247, 3, '2024-12-03 00:00:00', 288);
INSERT INTO public.vehicle VALUES (579, '14 GN 9639', 'Acura', 'CL', 2003, 'Electricity', 10016, 2, '2024-07-29 00:00:00', 289);
INSERT INTO public.vehicle VALUES (580, '14 HN 6481', 'Subaru', 'XT', 1988, 'LPG', 13613, 1, '2024-06-18 00:00:00', 290);
INSERT INTO public.vehicle VALUES (581, '14 IC 6089', 'Mercury', 'Grand Marquis', 1986, 'Gas', 59445, 1, '2024-07-30 00:00:00', 290);
INSERT INTO public.vehicle VALUES (582, '14 NT 317', 'Dodge', 'Ramcharger', 1993, 'Diesel', 27443, 2, '2024-06-26 00:00:00', 290);
INSERT INTO public.vehicle VALUES (583, '14 OU 5332', 'Lexus', 'SC', 1997, 'Electricity', 58892, 1, '2024-02-10 00:00:00', 291);
INSERT INTO public.vehicle VALUES (584, '14 OV 158', 'Chevrolet', 'Sportvan G30', 1994, 'LPG', 41086, 1, '2025-03-28 00:00:00', 292);
INSERT INTO public.vehicle VALUES (585, '14 PZ 3777', 'Chrysler', 'PT Cruiser', 2009, 'Gas', 13593, 3, '2025-05-14 00:00:00', 293);
INSERT INTO public.vehicle VALUES (586, '14 SF 8463', 'Honda', 'Accord', 1992, 'Diesel', 12696, 2, '2023-06-03 00:00:00', 294);
INSERT INTO public.vehicle VALUES (587, '14 TL 8834', 'Suzuki', 'Swift', 1998, 'Electricity', 54122, 3, '2023-06-20 00:00:00', 294);
INSERT INTO public.vehicle VALUES (588, '14 ZV 5328', 'GMC', 'Sierra 2500', 2001, 'LPG', 19976, 2, '2023-08-21 00:00:00', 295);
INSERT INTO public.vehicle VALUES (589, '15 AL 3226', 'Mercedes-Benz', 'E-Class', 1991, 'Gas', 38621, 3, '2023-11-15 00:00:00', 296);
INSERT INTO public.vehicle VALUES (590, '15 CV 6225', 'Porsche', 'Carrera GT', 2005, 'Diesel', 30848, 1, '2023-10-25 00:00:00', 296);
INSERT INTO public.vehicle VALUES (591, '15 FU 444', 'Mazda', 'Mazda3', 2007, 'Electricity', 46854, 1, '2023-01-30 00:00:00', 297);
INSERT INTO public.vehicle VALUES (592, '15 IU 548', 'Chevrolet', 'Express 2500', 1998, 'LPG', 56014, 4, '2023-02-01 00:00:00', 297);
INSERT INTO public.vehicle VALUES (593, '15 KJ 9468', 'Volkswagen', 'Passat', 1992, 'Gas', 56796, 4, '2023-07-25 00:00:00', 298);
INSERT INTO public.vehicle VALUES (594, '15 LB 5507', 'Chevrolet', 'Cavalier', 1996, 'Diesel', 20219, 4, '2023-09-06 00:00:00', 298);
INSERT INTO public.vehicle VALUES (595, '15 LN 8511', 'Nissan', 'Maxima', 1998, 'Electricity', 35875, 5, '2023-08-26 00:00:00', 299);
INSERT INTO public.vehicle VALUES (596, '15 NP 542', 'Nissan', 'Altima', 2006, 'LPG', 54608, 3, '2023-09-24 00:00:00', 299);
INSERT INTO public.vehicle VALUES (597, '15 RC 1633', 'Pontiac', 'G6', 2006, 'Gas', 47410, 3, '2023-10-16 00:00:00', 299);
INSERT INTO public.vehicle VALUES (598, '15 UF 6316', 'Mitsubishi', 'Galant', 2011, 'Diesel', 39465, 2, '2023-09-25 00:00:00', 299);
INSERT INTO public.vehicle VALUES (599, '16 GB 7388', 'Mercedes-Benz', 'SL-Class', 1995, 'Electricity', 23544, 3, '2025-02-05 00:00:00', 300);
INSERT INTO public.vehicle VALUES (600, '17 OV 485', 'Subaru', 'Alcyone SVX', 1994, 'LPG', 34759, 2, '2025-03-25 00:00:00', 300);
INSERT INTO public.vehicle VALUES (601, '17 SI 6152', 'Chrysler', 'Grand Voyager', 2000, 'Gas', 34702, 4, '2025-02-16 00:00:00', 300);
INSERT INTO public.vehicle VALUES (602, '17 SI 9000', 'Audi', 'S5', 2012, 'Diesel', 27842, 3, '2025-06-05 00:00:00', 301);
INSERT INTO public.vehicle VALUES (603, '17 TM 602', 'Infiniti', 'G35', 2004, 'Electricity', 46567, 3, '2024-03-12 00:00:00', 302);
INSERT INTO public.vehicle VALUES (604, '17 UK 7769', 'Hyundai', 'Sonata', 1994, 'LPG', 59240, 3, '2024-04-07 00:00:00', 302);
INSERT INTO public.vehicle VALUES (605, '17 ZI 2743', 'Nissan', '350Z', 2004, 'Gas', 13062, 3, '2024-04-21 00:00:00', 302);
INSERT INTO public.vehicle VALUES (606, '17 ZZ 1073', 'Austin', 'Mini Cooper S', 1963, 'Diesel', 34408, 2, '2023-06-10 00:00:00', 303);
INSERT INTO public.vehicle VALUES (607, '18 HG 7543', 'Audi', 'A8', 2004, 'Electricity', 35187, 1, '2024-06-18 00:00:00', 304);
INSERT INTO public.vehicle VALUES (608, '18 SZ 5605', 'Volvo', 'S80', 2009, 'LPG', 23031, 2, '2024-07-07 00:00:00', 304);
INSERT INTO public.vehicle VALUES (609, '19 AK 3413', 'Mazda', 'Tribute', 2005, 'Gas', 47291, 2, '2024-05-16 00:00:00', 305);
INSERT INTO public.vehicle VALUES (610, '19 VJ 4745', 'Mercedes-Benz', '300TE', 1992, 'Diesel', 52140, 2, '2024-06-30 00:00:00', 305);
INSERT INTO public.vehicle VALUES (611, '20 PA 9106', 'Volkswagen', 'Type 2', 1989, 'Electricity', 54225, 3, '2023-06-17 00:00:00', 306);
INSERT INTO public.vehicle VALUES (612, '20 VH 9288', 'Hyundai', 'Genesis Coupe', 2013, 'LPG', 18798, 3, '2023-06-11 00:00:00', 306);
INSERT INTO public.vehicle VALUES (613, '20 ZI 6352', 'Lexus', 'ES', 2009, 'Gas', 40233, 4, '2024-10-23 00:00:00', 307);
INSERT INTO public.vehicle VALUES (614, '21 RF 6970', 'Audi', 'A6', 2010, 'Diesel', 13274, 1, '2024-10-29 00:00:00', 307);
INSERT INTO public.vehicle VALUES (615, '22 CI 4777', 'Ford', 'Bronco II', 1987, 'Electricity', 38471, 4, '2024-01-23 00:00:00', 308);
INSERT INTO public.vehicle VALUES (616, '22 D 5035', 'Lincoln', 'MKX', 2010, 'LPG', 29704, 4, '2023-11-28 00:00:00', 308);
INSERT INTO public.vehicle VALUES (617, '22 DJ 6074', 'Toyota', '4Runner', 1998, 'Gas', 46027, 4, '2023-12-27 00:00:00', 308);
INSERT INTO public.vehicle VALUES (618, '22 MH 1231', 'Land Rover', 'Range Rover Classic', 1993, 'Diesel', 41663, 1, '2023-04-27 00:00:00', 309);
INSERT INTO public.vehicle VALUES (619, '22 OF 264', 'Toyota', 'Tacoma', 2007, 'Electricity', 12735, 2, '2023-11-01 00:00:00', 310);
INSERT INTO public.vehicle VALUES (620, '22 SS 5731', 'Mercury', 'Sable', 2004, 'LPG', 29933, 1, '2023-10-10 00:00:00', 310);
INSERT INTO public.vehicle VALUES (621, '22 VY 6248', 'Cadillac', 'CTS', 2005, 'Gas', 48863, 1, '2024-11-04 00:00:00', 311);
INSERT INTO public.vehicle VALUES (622, '23 EF 9697', 'Toyota', 'Tacoma Xtra', 1999, 'Diesel', 51766, 4, '2024-10-19 00:00:00', 311);
INSERT INTO public.vehicle VALUES (623, '23 FI 7601', 'Lotus', 'Esprit', 1999, 'Electricity', 42055, 2, '2024-11-30 00:00:00', 312);
INSERT INTO public.vehicle VALUES (624, '23 JP 4049', 'Isuzu', 'Hombre Space', 1997, 'LPG', 21738, 2, '2024-10-26 00:00:00', 312);
INSERT INTO public.vehicle VALUES (625, '23 KV 8072', 'Land Rover', 'Range Rover', 1992, 'Gas', 16367, 5, '2024-01-21 00:00:00', 313);
INSERT INTO public.vehicle VALUES (626, '23 LR 6889', 'Ford', 'Explorer Sport Trac', 2008, 'Diesel', 57903, 2, '2023-12-09 00:00:00', 313);
INSERT INTO public.vehicle VALUES (627, '23 LZ 4506', 'Ford', 'F250', 2004, 'Electricity', 40904, 1, '2024-01-21 00:00:00', 313);
INSERT INTO public.vehicle VALUES (628, '23 SV 730', 'Chevrolet', 'Silverado 2500', 2006, 'LPG', 54254, 1, '2023-08-23 00:00:00', 314);
INSERT INTO public.vehicle VALUES (629, '23 VJ 7449', 'Ferrari', '458 Italia', 2012, 'Gas', 22311, 1, '2023-08-03 00:00:00', 314);
INSERT INTO public.vehicle VALUES (630, '24 FI 7968', 'Honda', 'S2000', 2006, 'Diesel', 49708, 4, '2023-09-29 00:00:00', 315);
INSERT INTO public.vehicle VALUES (631, '24 GF 8556', 'Ford', 'F350', 1997, 'Electricity', 35299, 4, '2023-08-22 00:00:00', 315);
INSERT INTO public.vehicle VALUES (632, '24 GG 8144', 'Volkswagen', 'GTI', 2000, 'LPG', 21630, 3, '2023-05-08 00:00:00', 316);
INSERT INTO public.vehicle VALUES (633, '24 GZ 1503', 'BMW', '7 Series', 2008, 'Gas', 45333, 3, '2023-04-09 00:00:00', 316);
INSERT INTO public.vehicle VALUES (634, '24 IO 505', 'Audi', 'A6', 1998, 'Diesel', 19866, 3, '2023-05-12 00:00:00', 316);
INSERT INTO public.vehicle VALUES (635, '24 LA 991', 'Isuzu', 'Hombre', 2000, 'Electricity', 23156, 3, '2023-05-22 00:00:00', 316);
INSERT INTO public.vehicle VALUES (636, '24 SC 9789', 'Subaru', 'Justy', 1993, 'LPG', 14440, 3, '2023-11-15 00:00:00', 317);
INSERT INTO public.vehicle VALUES (637, '24 ZS 6464', 'Volkswagen', 'Cabriolet', 1988, 'Gas', 13230, 3, '2023-11-21 00:00:00', 317);
INSERT INTO public.vehicle VALUES (638, '25 BC 6238', 'Oldsmobile', 'Alero', 2003, 'Diesel', 44203, 5, '2024-06-05 00:00:00', 318);
INSERT INTO public.vehicle VALUES (639, '25 CL 3701', 'GMC', 'Yukon XL 2500', 2010, 'Electricity', 36432, 2, '2024-06-18 00:00:00', 318);
INSERT INTO public.vehicle VALUES (640, '25 DN 3681', 'Mercury', 'Capri', 1986, 'LPG', 42419, 5, '2024-05-15 00:00:00', 318);
INSERT INTO public.vehicle VALUES (641, '25 FO 578', 'Ford', 'Probe', 1994, 'Gas', 36095, 4, '2023-07-22 00:00:00', 319);
INSERT INTO public.vehicle VALUES (642, '25 NS 6890', 'Volkswagen', 'Golf', 2004, 'Diesel', 55040, 5, '2023-08-27 00:00:00', 319);
INSERT INTO public.vehicle VALUES (643, '25 OT 2877', 'Volkswagen', 'Golf', 1984, 'Electricity', 42167, 5, '2023-07-04 00:00:00', 319);
INSERT INTO public.vehicle VALUES (644, '25 SS 6954', 'Ford', 'F-Series', 2002, 'LPG', 23619, 3, '2024-05-05 00:00:00', 320);
INSERT INTO public.vehicle VALUES (645, '25 YR 5968', 'Toyota', 'Camry Hybrid', 2008, 'Gas', 34511, 5, '2024-11-08 00:00:00', 321);
INSERT INTO public.vehicle VALUES (646, '26 CM 5154', 'Jaguar', 'XK', 2009, 'Diesel', 56322, 2, '2024-09-29 00:00:00', 321);
INSERT INTO public.vehicle VALUES (647, '26 IB 5438', 'Lotus', 'Exige', 2011, 'Electricity', 55634, 4, '2024-10-14 00:00:00', 321);
INSERT INTO public.vehicle VALUES (648, '26 NE 5038', 'Lincoln', 'Navigator', 2010, 'LPG', 25344, 2, '2023-06-09 00:00:00', 322);
INSERT INTO public.vehicle VALUES (649, '26 OO 2320', 'GMC', 'Sierra 2500', 2011, 'Gas', 36884, 3, '2025-02-24 00:00:00', 323);
INSERT INTO public.vehicle VALUES (650, '26 SJ 7496', 'Mitsubishi', 'Eclipse', 1989, 'Diesel', 11835, 1, '2025-03-03 00:00:00', 323);
INSERT INTO public.vehicle VALUES (651, '26 UV 3792', 'Honda', 'Pilot', 2008, 'Electricity', 53900, 2, '2024-07-10 00:00:00', 324);
INSERT INTO public.vehicle VALUES (652, '26 YL 8342', 'Lincoln', 'MKZ', 2007, 'LPG', 41431, 4, '2024-06-29 00:00:00', 324);
INSERT INTO public.vehicle VALUES (653, '27 BB 867', 'Bentley', 'Continental Super', 2012, 'Gas', 53061, 4, '2024-06-15 00:00:00', 324);
INSERT INTO public.vehicle VALUES (654, '27 BP 7769', 'Honda', 'Prelude', 1995, 'Diesel', 10387, 3, '2023-04-05 00:00:00', 325);
INSERT INTO public.vehicle VALUES (655, '27 EM 8336', 'Hummer', 'H1', 2001, 'Electricity', 32192, 4, '2023-03-18 00:00:00', 325);
INSERT INTO public.vehicle VALUES (656, '27 FY 4101', 'Mitsubishi', 'Diamante', 1995, 'LPG', 42821, 2, '2023-04-08 00:00:00', 325);
INSERT INTO public.vehicle VALUES (657, '27 KA 7578', 'Lexus', 'GS', 2003, 'Gas', 35608, 2, '2024-06-23 00:00:00', 326);
INSERT INTO public.vehicle VALUES (658, '27 ZA 120', 'Toyota', 'Avalon', 1997, 'Diesel', 26313, 5, '2025-02-11 00:00:00', 327);
INSERT INTO public.vehicle VALUES (659, '27 ZR 5150', 'Suzuki', 'XL7', 2006, 'Electricity', 22817, 1, '2025-01-26 00:00:00', 327);
INSERT INTO public.vehicle VALUES (660, '28 DU 8786', 'Mazda', 'Miata MX-5', 2005, 'LPG', 54092, 1, '2025-04-03 00:00:00', 328);
INSERT INTO public.vehicle VALUES (661, '28 HC 5369', 'Toyota', 'RAV4', 2003, 'Gas', 42095, 4, '2025-05-11 00:00:00', 328);
INSERT INTO public.vehicle VALUES (662, '28 JM 8411', 'Chevrolet', 'Corvette', 1993, 'Diesel', 23649, 3, '2025-02-28 00:00:00', 329);
INSERT INTO public.vehicle VALUES (663, '28 KD 9681', 'Saturn', 'Outlook', 2009, 'Electricity', 44687, 2, '2024-08-06 00:00:00', 330);
INSERT INTO public.vehicle VALUES (664, '28 LG 5974', 'Volvo', 'S40', 2011, 'LPG', 47055, 2, '2024-06-17 00:00:00', 330);
INSERT INTO public.vehicle VALUES (665, '28 NJ 9961', 'Toyota', 'Camry Hybrid', 2009, 'Gas', 19739, 1, '2024-08-09 00:00:00', 330);
INSERT INTO public.vehicle VALUES (666, '28 RC 1924', 'Buick', 'Century', 1999, 'Diesel', 35152, 5, '2024-08-12 00:00:00', 330);
INSERT INTO public.vehicle VALUES (667, '28 UZ 8029', 'Acura', 'Vigor', 1994, 'Electricity', 49620, 3, '2023-10-17 00:00:00', 331);
INSERT INTO public.vehicle VALUES (668, '28 VU 8586', 'Chevrolet', 'Silverado 1500', 2005, 'LPG', 20896, 5, '2023-09-23 00:00:00', 331);
INSERT INTO public.vehicle VALUES (669, '29 GC 7592', 'BMW', 'X5', 2004, 'Gas', 29908, 2, '2023-10-18 00:00:00', 331);
INSERT INTO public.vehicle VALUES (670, '29 LB 6202', 'Mercury', 'Tracer', 1997, 'Diesel', 14370, 2, '2023-10-02 00:00:00', 332);
INSERT INTO public.vehicle VALUES (671, '30 IU 3849', 'Audi', 'Q7', 2009, 'Electricity', 31561, 1, '2023-09-07 00:00:00', 332);
INSERT INTO public.vehicle VALUES (672, '30 TP 5558', 'Mercedes-Benz', '300CE', 1993, 'LPG', 57103, 5, '2025-03-11 00:00:00', 333);
INSERT INTO public.vehicle VALUES (673, '30 TP 9006', 'Pontiac', 'Firefly', 1984, 'Gas', 26207, 4, '2025-01-25 00:00:00', 333);
INSERT INTO public.vehicle VALUES (674, '31 AN 8370', 'Ford', 'Escort', 1985, 'Diesel', 13574, 5, '2024-10-24 00:00:00', 334);
INSERT INTO public.vehicle VALUES (675, '31 AT 5196', 'Maybach', '62', 2012, 'Electricity', 51587, 3, '2024-03-16 00:00:00', 335);
INSERT INTO public.vehicle VALUES (676, '31 DO 6705', 'Chevrolet', 'Silverado 1500', 2001, 'LPG', 49569, 1, '2024-03-27 00:00:00', 335);
INSERT INTO public.vehicle VALUES (677, '31 ET 4046', 'Mercedes-Benz', 'Sprinter 3500', 2011, 'Gas', 38966, 3, '2024-06-17 00:00:00', 336);
INSERT INTO public.vehicle VALUES (678, '31 JM 4581', 'GMC', 'Sierra 3500', 2010, 'Diesel', 30844, 2, '2024-08-01 00:00:00', 336);
INSERT INTO public.vehicle VALUES (679, '31 KN 5570', 'Mitsubishi', 'Outlander', 2008, 'Electricity', 47026, 1, '2024-06-17 00:00:00', 336);
INSERT INTO public.vehicle VALUES (680, '31 SJ 6923', 'Chevrolet', 'Avalanche', 2009, 'LPG', 38315, 3, '2025-01-16 00:00:00', 337);
INSERT INTO public.vehicle VALUES (681, '31 TO 5572', 'Mercedes-Benz', 'S-Class', 1987, 'Gas', 40749, 5, '2025-02-04 00:00:00', 337);
INSERT INTO public.vehicle VALUES (682, '32 C 013', 'Chevrolet', 'G-Series G20', 1992, 'Diesel', 49147, 1, '2025-02-10 00:00:00', 337);
INSERT INTO public.vehicle VALUES (683, '32 DZ 5149', 'Oldsmobile', 'Silhouette', 1993, 'Electricity', 10019, 1, '2024-12-16 00:00:00', 338);
INSERT INTO public.vehicle VALUES (684, '32 JR 2814', 'Volkswagen', 'Golf', 2004, 'LPG', 39444, 1, '2024-11-26 00:00:00', 339);
INSERT INTO public.vehicle VALUES (685, '32 KO 8129', 'Mercedes-Benz', 'CL-Class', 2009, 'Gas', 50868, 1, '2024-09-10 00:00:00', 340);
INSERT INTO public.vehicle VALUES (686, '32 LU 8318', 'Isuzu', 'VehiCROSS', 2001, 'Diesel', 17790, 4, '2024-09-15 00:00:00', 340);
INSERT INTO public.vehicle VALUES (687, '32 TS 2286', 'GMC', 'Sierra 2500HD', 2006, 'Electricity', 29620, 4, '2023-04-26 00:00:00', 341);
INSERT INTO public.vehicle VALUES (688, '32 VZ 6886', 'Chevrolet', 'Lumina APV', 1992, 'LPG', 18838, 3, '2023-03-26 00:00:00', 341);
INSERT INTO public.vehicle VALUES (689, '32 ZG 8045', 'Pontiac', '1000', 1984, 'Gas', 38806, 3, '2023-04-01 00:00:00', 341);
INSERT INTO public.vehicle VALUES (690, '33 CJ 9905', 'Isuzu', 'Ascender', 2005, 'Diesel', 27045, 1, '2023-04-16 00:00:00', 341);
INSERT INTO public.vehicle VALUES (691, '33 EJ 7651', 'Plymouth', 'Neon', 1996, 'Electricity', 58589, 5, '2024-08-23 00:00:00', 342);
INSERT INTO public.vehicle VALUES (692, '33 HK 1926', 'Ford', 'F-250 Super Duty', 2006, 'LPG', 10730, 1, '2024-09-10 00:00:00', 342);
INSERT INTO public.vehicle VALUES (693, '33 SB 8698', 'Volkswagen', 'Jetta', 1986, 'Gas', 22800, 3, '2024-07-15 00:00:00', 342);
INSERT INTO public.vehicle VALUES (694, '33 UH 1923', 'Bentley', 'Continental GT', 2009, 'Diesel', 28361, 5, '2024-09-10 00:00:00', 342);
INSERT INTO public.vehicle VALUES (695, '33 UJ 7944', 'Infiniti', 'QX56', 2009, 'Electricity', 22699, 4, '2025-01-06 00:00:00', 343);
INSERT INTO public.vehicle VALUES (696, '33 ZI 4167', 'Volvo', 'S60', 2002, 'LPG', 32114, 4, '2025-01-18 00:00:00', 343);
INSERT INTO public.vehicle VALUES (697, '34 AV 2037', 'Audi', 'Q7', 2007, 'Gas', 56103, 2, '2023-03-25 00:00:00', 344);
INSERT INTO public.vehicle VALUES (698, '34 CN 9870', 'Mazda', 'Miata MX-5', 2000, 'Diesel', 58406, 2, '2024-07-12 00:00:00', 345);
INSERT INTO public.vehicle VALUES (699, '34 CV 9282', 'Chrysler', 'Town & Country', 1997, 'Electricity', 27411, 3, '2024-06-17 00:00:00', 345);
INSERT INTO public.vehicle VALUES (700, '34 EK 6232', 'Mercury', 'Cougar', 1989, 'LPG', 27074, 5, '2024-07-01 00:00:00', 345);
INSERT INTO public.vehicle VALUES (701, '34 JA 4102', 'Maybach', '62', 2008, 'Gas', 21383, 4, '2024-07-20 00:00:00', 345);
INSERT INTO public.vehicle VALUES (702, '34 PA 6450', 'Ford', 'F-Series', 2001, 'Diesel', 41144, 2, '2024-05-12 00:00:00', 346);
INSERT INTO public.vehicle VALUES (703, '35 EY 4373', 'Dodge', 'Ram Van 3500', 1996, 'Electricity', 10830, 3, '2025-05-26 00:00:00', 347);
INSERT INTO public.vehicle VALUES (704, '35 LR 5273', 'Toyota', 'Celica', 2002, 'LPG', 20130, 1, '2025-04-11 00:00:00', 347);
INSERT INTO public.vehicle VALUES (705, '35 RO 2119', 'Mazda', 'MX-5', 1996, 'Gas', 51170, 2, '2023-08-23 00:00:00', 348);
INSERT INTO public.vehicle VALUES (706, '35 UT 2607', 'Holden', 'VS Commodore', 1995, 'Diesel', 30542, 2, '2023-08-06 00:00:00', 348);
INSERT INTO public.vehicle VALUES (707, '35 Y 6223', 'Dodge', 'Durango', 2003, 'Electricity', 40704, 1, '2024-01-12 00:00:00', 349);
INSERT INTO public.vehicle VALUES (708, '36 BU 1428', 'Ford', 'Ranger', 1999, 'LPG', 58231, 2, '2023-03-22 00:00:00', 350);
INSERT INTO public.vehicle VALUES (709, '36 CE 5966', 'Honda', 'FCX Clarity', 2012, 'Gas', 17591, 4, '2023-03-21 00:00:00', 350);
INSERT INTO public.vehicle VALUES (710, '36 DY 493', 'BMW', 'X3', 2004, 'Diesel', 44033, 5, '2023-04-01 00:00:00', 350);
INSERT INTO public.vehicle VALUES (711, '36 EU 2660', 'Chrysler', '300', 1999, 'Electricity', 39366, 5, '2023-12-07 00:00:00', 351);
INSERT INTO public.vehicle VALUES (712, '36 FJ 2481', 'Corbin', 'Sparrow', 2004, 'LPG', 41358, 3, '2023-11-24 00:00:00', 351);
INSERT INTO public.vehicle VALUES (713, '36 FP 4882', 'Mercedes-Benz', 'C-Class', 2000, 'Gas', 17328, 2, '2024-03-23 00:00:00', 352);
INSERT INTO public.vehicle VALUES (714, '36 FR 3121', 'Hyundai', 'Veracruz', 2008, 'Diesel', 31574, 5, '2024-03-31 00:00:00', 352);
INSERT INTO public.vehicle VALUES (715, '36 GI 5506', 'Volvo', 'S40', 2007, 'Electricity', 59842, 3, '2024-04-05 00:00:00', 352);
INSERT INTO public.vehicle VALUES (716, '36 GT 328', 'Ford', 'Taurus', 2001, 'LPG', 55928, 3, '2024-11-09 00:00:00', 353);
INSERT INTO public.vehicle VALUES (717, '36 HG 4897', 'GMC', 'Safari', 2005, 'Gas', 53520, 4, '2024-12-02 00:00:00', 353);
INSERT INTO public.vehicle VALUES (718, '36 LR 911', 'Spyker', 'C8', 2007, 'Diesel', 12225, 3, '2024-11-03 00:00:00', 353);
INSERT INTO public.vehicle VALUES (719, '36 YB 384', 'Land Rover', 'Range Rover', 1997, 'Electricity', 10727, 5, '2023-12-20 00:00:00', 354);
INSERT INTO public.vehicle VALUES (720, '37 OP 2201', 'Cadillac', 'Escalade EXT', 2004, 'LPG', 48339, 1, '2024-03-15 00:00:00', 355);
INSERT INTO public.vehicle VALUES (721, '37 YT 4196', 'Honda', 'Accord', 2002, 'Gas', 35964, 5, '2024-03-23 00:00:00', 355);
INSERT INTO public.vehicle VALUES (722, '38 PC 336', 'Lincoln', 'MKX', 2012, 'Diesel', 15461, 5, '2024-03-12 00:00:00', 355);
INSERT INTO public.vehicle VALUES (723, '38 TR 326', 'Volkswagen', 'Type 2', 1990, 'Electricity', 12145, 4, '2024-04-24 00:00:00', 356);
INSERT INTO public.vehicle VALUES (724, '38 TV 2984', 'GMC', '3500 Club Coupe', 1993, 'LPG', 53468, 4, '2024-04-05 00:00:00', 356);
INSERT INTO public.vehicle VALUES (725, '39 KJ 5303', 'Cadillac', 'Seville', 1994, 'Gas', 50521, 3, '2024-05-13 00:00:00', 356);
INSERT INTO public.vehicle VALUES (726, '39 KY 7688', 'Oldsmobile', 'Intrigue', 2002, 'Diesel', 41225, 1, '2023-08-25 00:00:00', 357);
INSERT INTO public.vehicle VALUES (727, '39 MK 2479', 'Pontiac', 'Solstice', 2008, 'Electricity', 52400, 3, '2023-09-07 00:00:00', 357);
INSERT INTO public.vehicle VALUES (728, '39 ND 016', 'Mercedes-Benz', 'GLK-Class', 2011, 'LPG', 50030, 5, '2024-01-28 00:00:00', 358);
INSERT INTO public.vehicle VALUES (729, '39 NO 2663', 'Lexus', 'RX Hybrid', 2011, 'Gas', 53413, 3, '2024-02-08 00:00:00', 358);
INSERT INTO public.vehicle VALUES (730, '39 YV 5447', 'Subaru', 'Legacy', 2008, 'Diesel', 32476, 1, '2025-06-03 00:00:00', 359);
INSERT INTO public.vehicle VALUES (731, '40 AA 5468', 'Jeep', 'Wrangler', 2004, 'Electricity', 45072, 5, '2025-06-14 00:00:00', 359);
INSERT INTO public.vehicle VALUES (732, '40 UY 4977', 'Kia', 'Amanti', 2007, 'LPG', 45890, 3, '2023-02-14 00:00:00', 360);
INSERT INTO public.vehicle VALUES (733, '40 ZR 4590', 'Mercury', 'Cougar', 1988, 'Gas', 16204, 4, '2023-03-01 00:00:00', 360);
INSERT INTO public.vehicle VALUES (734, '41 KM 9740', 'Geo', 'Metro', 1992, 'Diesel', 22675, 3, '2025-02-08 00:00:00', 361);
INSERT INTO public.vehicle VALUES (735, '41 PM 9207', 'Mercury', 'Cougar', 1986, 'Electricity', 59160, 5, '2023-09-06 00:00:00', 362);
INSERT INTO public.vehicle VALUES (736, '41 UY 1844', 'Ford', 'F150', 1996, 'LPG', 41208, 5, '2023-08-14 00:00:00', 362);
INSERT INTO public.vehicle VALUES (737, '42 BC 9747', 'Ram', '1500', 2011, 'Gas', 10501, 4, '2024-03-14 00:00:00', 363);
INSERT INTO public.vehicle VALUES (738, '42 GB 7670', 'Volkswagen', 'Jetta III', 1994, 'Diesel', 32191, 4, '2023-12-29 00:00:00', 364);
INSERT INTO public.vehicle VALUES (739, '42 JD 8206', 'Porsche', 'Cayman', 2007, 'Electricity', 36184, 2, '2023-06-19 00:00:00', 365);
INSERT INTO public.vehicle VALUES (740, '42 LO 617', 'Pontiac', 'Firebird', 1997, 'LPG', 34102, 4, '2023-07-23 00:00:00', 365);
INSERT INTO public.vehicle VALUES (741, '42 OY 3683', 'Volvo', 'V70', 1999, 'Gas', 42480, 4, '2023-08-06 00:00:00', 366);
INSERT INTO public.vehicle VALUES (742, '42 UD 6229', 'Ford', 'F250', 2011, 'Diesel', 11614, 2, '2023-09-13 00:00:00', 366);
INSERT INTO public.vehicle VALUES (743, '42 ZK 5327', 'Chevrolet', 'Uplander', 2005, 'Electricity', 19878, 4, '2023-08-18 00:00:00', 366);
INSERT INTO public.vehicle VALUES (744, '43 CC 6257', 'Oldsmobile', 'Silhouette', 2002, 'LPG', 36115, 5, '2024-07-18 00:00:00', 367);
INSERT INTO public.vehicle VALUES (745, '43 EM 5908', 'Toyota', 'Echo', 2003, 'Gas', 10463, 3, '2024-07-25 00:00:00', 367);
INSERT INTO public.vehicle VALUES (746, '43 G 8983', 'Chevrolet', 'Corvette', 1960, 'Diesel', 36287, 4, '2024-08-11 00:00:00', 368);
INSERT INTO public.vehicle VALUES (747, '43 GM 9153', 'Chevrolet', '3500', 1997, 'Electricity', 13815, 2, '2024-12-13 00:00:00', 369);
INSERT INTO public.vehicle VALUES (748, '43 ND 4736', 'Lexus', 'LS', 2007, 'LPG', 51874, 1, '2023-11-28 00:00:00', 370);
INSERT INTO public.vehicle VALUES (749, '44 CN 8611', 'Toyota', 'Camry', 1999, 'Gas', 16116, 4, '2023-02-16 00:00:00', 371);
INSERT INTO public.vehicle VALUES (750, '44 CN 938', 'Mitsubishi', 'Eclipse', 2003, 'Diesel', 26437, 4, '2023-02-24 00:00:00', 371);
INSERT INTO public.vehicle VALUES (751, '44 SS 3986', 'Mercedes-Benz', 'S-Class', 2006, 'Electricity', 29000, 4, '2023-07-14 00:00:00', 372);
INSERT INTO public.vehicle VALUES (752, '44 TF 5566', 'Mercury', 'Sable', 1987, 'LPG', 45044, 1, '2023-08-09 00:00:00', 372);
INSERT INTO public.vehicle VALUES (753, '44 TY 2078', 'Oldsmobile', 'Achieva', 1993, 'Gas', 24219, 4, '2023-08-26 00:00:00', 372);
INSERT INTO public.vehicle VALUES (754, '44 V 7381', 'Kia', 'Rio', 2012, 'Diesel', 57336, 1, '2025-03-10 00:00:00', 373);
INSERT INTO public.vehicle VALUES (755, '44 VT 2719', 'Jaguar', 'XJ Series', 1993, 'Electricity', 17569, 1, '2025-04-17 00:00:00', 373);
INSERT INTO public.vehicle VALUES (756, '45 D 5560', 'Chrysler', 'Town & Country', 2009, 'LPG', 10693, 5, '2024-11-07 00:00:00', 374);
INSERT INTO public.vehicle VALUES (757, '45 DM 9656', 'Ford', 'E350', 2008, 'Gas', 51628, 4, '2024-09-12 00:00:00', 375);
INSERT INTO public.vehicle VALUES (758, '45 IO 6965', 'Aston Martin', 'V8 Vantage', 2011, 'Diesel', 25875, 4, '2024-09-26 00:00:00', 375);
INSERT INTO public.vehicle VALUES (759, '45 JB 3669', 'Toyota', '4Runner', 2011, 'Electricity', 53714, 5, '2023-08-07 00:00:00', 376);
INSERT INTO public.vehicle VALUES (760, '45 KP 7963', 'Toyota', 'Tercel', 1995, 'LPG', 29160, 3, '2023-08-16 00:00:00', 376);
INSERT INTO public.vehicle VALUES (761, '45 LY 7082', 'Mitsubishi', '3000GT', 1998, 'Gas', 46765, 3, '2023-08-12 00:00:00', 376);
INSERT INTO public.vehicle VALUES (762, '45 LZ 5587', 'GMC', 'Rally Wagon G3500', 1995, 'Diesel', 23196, 3, '2025-01-06 00:00:00', 377);
INSERT INTO public.vehicle VALUES (763, '45 OD 9659', 'Mitsubishi', 'Mirage', 1998, 'Electricity', 33645, 5, '2025-05-13 00:00:00', 378);
INSERT INTO public.vehicle VALUES (764, '45 UG 381', 'Ford', 'Fiesta', 2001, 'LPG', 54133, 5, '2025-05-06 00:00:00', 378);
INSERT INTO public.vehicle VALUES (765, '46 AJ 6287', 'Saab', '9-3', 2006, 'Gas', 47977, 2, '2025-05-21 00:00:00', 378);
INSERT INTO public.vehicle VALUES (766, '46 D 781', 'Chrysler', 'Town & Country', 1999, 'Diesel', 11514, 1, '2025-05-14 00:00:00', 378);
INSERT INTO public.vehicle VALUES (767, '46 FY 5688', 'Acura', 'Vigor', 1993, 'Electricity', 29243, 2, '2025-05-05 00:00:00', 379);
INSERT INTO public.vehicle VALUES (768, '46 PF 2058', 'Acura', 'RSX', 2002, 'LPG', 47526, 2, '2025-05-26 00:00:00', 379);
INSERT INTO public.vehicle VALUES (769, '46 TT 3516', 'Suzuki', 'Esteem', 2002, 'Gas', 35674, 1, '2024-09-02 00:00:00', 380);
INSERT INTO public.vehicle VALUES (770, '46 UE 5352', 'Oldsmobile', '98', 1995, 'Diesel', 22875, 3, '2024-06-14 00:00:00', 381);
INSERT INTO public.vehicle VALUES (771, '46 UP 747', 'Toyota', 'Land Cruiser', 2003, 'Electricity', 27038, 3, '2024-05-21 00:00:00', 381);
INSERT INTO public.vehicle VALUES (772, '47 HB 1133', 'Ford', 'Econoline E150', 1994, 'LPG', 14797, 5, '2024-01-23 00:00:00', 382);
INSERT INTO public.vehicle VALUES (773, '47 KY 4229', 'Mitsubishi', 'Chariot', 1985, 'Gas', 31600, 2, '2024-02-16 00:00:00', 382);
INSERT INTO public.vehicle VALUES (774, '47 LB 1188', 'Mazda', '626', 1999, 'Diesel', 46057, 1, '2023-06-25 00:00:00', 383);
INSERT INTO public.vehicle VALUES (775, '47 ML 6489', 'Saab', '9000', 1995, 'Electricity', 58168, 3, '2023-08-10 00:00:00', 383);
INSERT INTO public.vehicle VALUES (776, '47 MZ 8817', 'Chrysler', 'Crossfire', 2007, 'LPG', 35178, 1, '2023-07-31 00:00:00', 383);
INSERT INTO public.vehicle VALUES (777, '47 PJ 9358', 'Toyota', 'Land Cruiser', 2001, 'Gas', 25050, 5, '2023-08-04 00:00:00', 383);
INSERT INTO public.vehicle VALUES (778, '47 RN 2119', 'Audi', 'RS4', 2007, 'Diesel', 11559, 4, '2023-12-13 00:00:00', 384);
INSERT INTO public.vehicle VALUES (779, '47 UC 5246', 'GMC', 'Sierra', 2010, 'Electricity', 17475, 4, '2024-01-02 00:00:00', 385);
INSERT INTO public.vehicle VALUES (780, '47 ZN 2908', 'Saab', '900', 1992, 'LPG', 49766, 2, '2024-01-25 00:00:00', 385);
INSERT INTO public.vehicle VALUES (781, '48 EF 8447', 'Toyota', 'Avalon', 1997, 'Gas', 29296, 4, '2023-12-12 00:00:00', 385);
INSERT INTO public.vehicle VALUES (782, '48 EK 9730', 'Toyota', 'Land Cruiser', 2013, 'Diesel', 48321, 5, '2023-10-15 00:00:00', 386);
INSERT INTO public.vehicle VALUES (783, '48 FI 9561', 'Lexus', 'LS', 1997, 'Electricity', 55605, 2, '2023-10-06 00:00:00', 386);
INSERT INTO public.vehicle VALUES (784, '48 JI 1728', 'Ford', 'Aerostar', 1987, 'LPG', 27175, 1, '2023-10-24 00:00:00', 386);
INSERT INTO public.vehicle VALUES (785, '48 SK 9928', 'Hyundai', 'Elantra', 1994, 'Gas', 18194, 2, '2023-10-15 00:00:00', 386);
INSERT INTO public.vehicle VALUES (786, '48 SM 7841', 'GMC', '1500', 1995, 'Diesel', 43640, 2, '2023-06-07 00:00:00', 387);
INSERT INTO public.vehicle VALUES (787, '48 SV 7337', 'Volkswagen', 'Vanagon', 1984, 'Electricity', 27043, 1, '2023-06-21 00:00:00', 387);
INSERT INTO public.vehicle VALUES (788, '48 ZP 6317', 'Chrysler', 'Aspen', 2007, 'LPG', 29028, 3, '2025-01-09 00:00:00', 388);
INSERT INTO public.vehicle VALUES (789, '49 BC 5028', 'Dodge', 'Dakota Club', 2003, 'Gas', 30579, 5, '2025-01-19 00:00:00', 388);
INSERT INTO public.vehicle VALUES (790, '49 T 4024', 'Honda', 'Fit', 2007, 'Diesel', 24069, 5, '2025-02-16 00:00:00', 388);
INSERT INTO public.vehicle VALUES (791, '49 TY 1088', 'Buick', 'Skylark', 1986, 'Electricity', 49898, 5, '2025-06-19 00:00:00', 389);
INSERT INTO public.vehicle VALUES (792, '50 NP 8762', 'Mitsubishi', 'Eclipse', 1994, 'LPG', 33548, 1, '2025-04-30 00:00:00', 389);
INSERT INTO public.vehicle VALUES (793, '50 OT 2793', 'Chevrolet', 'Silverado 3500HD', 2006, 'Gas', 50622, 4, '2025-06-13 00:00:00', 389);
INSERT INTO public.vehicle VALUES (794, '50 ZB 3678', 'Subaru', 'Baja', 2006, 'Diesel', 23565, 5, '2023-09-14 00:00:00', 390);
INSERT INTO public.vehicle VALUES (795, '51 EZ 2693', 'Nissan', 'Quest', 2004, 'Electricity', 51810, 3, '2024-10-11 00:00:00', 391);
INSERT INTO public.vehicle VALUES (796, '51 FC 342', 'Mercedes-Benz', 'E-Class', 2004, 'LPG', 47113, 4, '2024-01-15 00:00:00', 392);
INSERT INTO public.vehicle VALUES (797, '51 FO 7128', 'Mercedes-Benz', 'CLS-Class', 2008, 'Gas', 39633, 2, '2023-07-03 00:00:00', 393);
INSERT INTO public.vehicle VALUES (798, '51 HM 9785', 'Chrysler', 'Sebring', 2006, 'Diesel', 57771, 1, '2024-09-15 00:00:00', 394);
INSERT INTO public.vehicle VALUES (799, '51 HZ 5615', 'Buick', 'Regal', 2002, 'Electricity', 21385, 5, '2024-09-07 00:00:00', 394);
INSERT INTO public.vehicle VALUES (800, '51 RL 1918', 'Mitsubishi', 'Truck', 1986, 'LPG', 29264, 2, '2023-07-16 00:00:00', 395);
INSERT INTO public.vehicle VALUES (801, '52 FB 1303', 'Dodge', 'Viper', 1994, 'Gas', 32711, 1, '2023-07-20 00:00:00', 396);
INSERT INTO public.vehicle VALUES (802, '52 GP 030', 'Mercedes-Benz', 'S-Class', 1998, 'Diesel', 40027, 3, '2023-08-04 00:00:00', 396);
INSERT INTO public.vehicle VALUES (803, '52 II 6962', 'BMW', 'Z4', 2006, 'Electricity', 37450, 4, '2024-05-14 00:00:00', 397);
INSERT INTO public.vehicle VALUES (804, '52 KF 3790', 'Isuzu', 'Rodeo', 2004, 'LPG', 43841, 5, '2024-04-29 00:00:00', 397);
INSERT INTO public.vehicle VALUES (805, '52 OP 2127', 'Saturn', 'L-Series', 2004, 'Gas', 38357, 3, '2024-04-06 00:00:00', 397);
INSERT INTO public.vehicle VALUES (806, '52 PG 302', 'Mercury', 'Villager', 2002, 'Diesel', 42603, 1, '2023-12-07 00:00:00', 398);
INSERT INTO public.vehicle VALUES (807, '52 UY 9608', 'Ford', 'Flex', 2012, 'Electricity', 10004, 3, '2024-01-10 00:00:00', 398);
INSERT INTO public.vehicle VALUES (808, '52 ZY 911', 'Mercedes-Benz', 'E-Class', 2004, 'LPG', 26117, 1, '2024-01-03 00:00:00', 398);
INSERT INTO public.vehicle VALUES (809, '53 CS 1427', 'Pontiac', 'Grand Prix', 1970, 'Gas', 12717, 2, '2024-03-24 00:00:00', 399);
INSERT INTO public.vehicle VALUES (810, '53 IY 8026', 'Oldsmobile', 'Aurora', 2003, 'Diesel', 45009, 3, '2024-03-23 00:00:00', 399);
INSERT INTO public.vehicle VALUES (811, '53 LL 7601', 'Mitsubishi', 'Outlander', 2004, 'Electricity', 18805, 5, '2024-02-01 00:00:00', 400);
INSERT INTO public.vehicle VALUES (812, '53 LO 3899', 'Suzuki', 'Vitara', 2001, 'LPG', 20288, 4, '2024-02-03 00:00:00', 400);
INSERT INTO public.vehicle VALUES (813, '53 PE 2498', 'Mercedes-Benz', 'SLR McLaren', 2008, 'Gas', 44518, 3, '2024-01-07 00:00:00', 400);
INSERT INTO public.vehicle VALUES (814, '53 PV 9221', 'Mitsubishi', 'Galant', 2006, 'Diesel', 36189, 4, '2023-07-13 00:00:00', 401);
INSERT INTO public.vehicle VALUES (815, '54 FH 6556', 'Hummer', 'H2 SUV', 2006, 'Electricity', 12587, 3, '2023-06-24 00:00:00', 401);
INSERT INTO public.vehicle VALUES (816, '54 I 8423', 'Suzuki', 'Swift', 2006, 'LPG', 41449, 4, '2024-04-04 00:00:00', 402);
INSERT INTO public.vehicle VALUES (817, '54 IS 5100', 'Mercury', 'Mountaineer', 2002, 'Gas', 10534, 1, '2024-04-20 00:00:00', 402);
INSERT INTO public.vehicle VALUES (818, '54 JZ 177', 'Buick', 'Rendezvous', 2007, 'Diesel', 30241, 3, '2023-06-12 00:00:00', 403);
INSERT INTO public.vehicle VALUES (819, '54 MB 8002', 'Porsche', '928', 1986, 'Electricity', 18289, 2, '2025-04-20 00:00:00', 404);
INSERT INTO public.vehicle VALUES (820, '54 TH 5546', 'BMW', '7 Series', 2008, 'LPG', 27191, 2, '2025-05-11 00:00:00', 404);
INSERT INTO public.vehicle VALUES (821, '54 VR 939', 'Ford', 'Aspire', 1996, 'Gas', 25612, 4, '2024-03-07 00:00:00', 405);
INSERT INTO public.vehicle VALUES (822, '55 BY 8565', 'Chevrolet', '3500', 1997, 'Diesel', 32805, 5, '2024-12-25 00:00:00', 406);
INSERT INTO public.vehicle VALUES (823, '55 FH 1955', 'Isuzu', 'Rodeo', 2002, 'Electricity', 14352, 4, '2025-03-03 00:00:00', 407);
INSERT INTO public.vehicle VALUES (824, '55 IG 6338', 'GMC', 'Savana 2500', 2007, 'LPG', 20636, 3, '2023-03-27 00:00:00', 408);
INSERT INTO public.vehicle VALUES (825, '55 JT 7644', 'Nissan', 'Altima', 2013, 'Gas', 53825, 3, '2023-03-29 00:00:00', 408);
INSERT INTO public.vehicle VALUES (826, '55 NG 3476', 'Nissan', 'Pathfinder', 2008, 'Diesel', 18955, 2, '2023-02-24 00:00:00', 409);
INSERT INTO public.vehicle VALUES (827, '55 TT 4728', 'BMW', 'Alpina B7', 2007, 'Electricity', 18046, 5, '2024-07-11 00:00:00', 410);
INSERT INTO public.vehicle VALUES (828, '55 VV 3809', 'GMC', '3500 Club Coupe', 1998, 'LPG', 11175, 5, '2024-07-25 00:00:00', 411);
INSERT INTO public.vehicle VALUES (829, '55 YA 3777', 'Mercedes-Benz', 'SLK-Class', 1998, 'Gas', 16800, 3, '2024-08-31 00:00:00', 411);
INSERT INTO public.vehicle VALUES (830, '56 CS 5126', 'Honda', 'Accord', 1996, 'Diesel', 51459, 2, '2024-09-08 00:00:00', 411);
INSERT INTO public.vehicle VALUES (831, '56 DM 2962', 'Chevrolet', 'Camaro', 1968, 'Electricity', 52241, 2, '2024-09-13 00:00:00', 412);
INSERT INTO public.vehicle VALUES (832, '56 DP 8677', 'Mazda', 'B2000', 1985, 'LPG', 50635, 4, '2024-08-19 00:00:00', 412);
INSERT INTO public.vehicle VALUES (833, '56 FL 7373', 'Mitsubishi', 'Montero', 1995, 'Gas', 47911, 4, '2024-12-16 00:00:00', 413);
INSERT INTO public.vehicle VALUES (834, '56 KJ 2382', 'Cadillac', 'STS-V', 2009, 'Diesel', 31699, 4, '2023-10-14 00:00:00', 414);
INSERT INTO public.vehicle VALUES (835, '56 SL 2063', 'Pontiac', 'Sunfire', 1997, 'Electricity', 45263, 4, '2023-11-19 00:00:00', 414);
INSERT INTO public.vehicle VALUES (836, '57 EO 8301', 'Hyundai', 'Azera', 2011, 'LPG', 47675, 4, '2023-10-23 00:00:00', 414);
INSERT INTO public.vehicle VALUES (837, '57 FC 3839', 'Honda', 'Fit', 2012, 'Gas', 56013, 5, '2024-12-10 00:00:00', 415);
INSERT INTO public.vehicle VALUES (838, '57 LA 3666', 'Pontiac', 'GTO', 1968, 'Diesel', 36604, 5, '2024-12-17 00:00:00', 415);
INSERT INTO public.vehicle VALUES (839, '57 LI 8348', 'Land Rover', 'Range Rover', 1991, 'Electricity', 18299, 2, '2025-02-05 00:00:00', 416);
INSERT INTO public.vehicle VALUES (840, '57 TN 6165', 'Hummer', 'H3', 2009, 'LPG', 31378, 2, '2025-05-11 00:00:00', 417);
INSERT INTO public.vehicle VALUES (841, '57 VB 4120', 'Pontiac', 'Vibe', 2007, 'Gas', 55926, 1, '2025-05-28 00:00:00', 417);
INSERT INTO public.vehicle VALUES (842, '57 VV 2325', 'Chrysler', 'LeBaron', 1994, 'Diesel', 14903, 4, '2025-05-15 00:00:00', 418);
INSERT INTO public.vehicle VALUES (843, '58 BU 5099', 'Pontiac', 'Firefly', 1988, 'Electricity', 31674, 2, '2025-03-23 00:00:00', 418);
INSERT INTO public.vehicle VALUES (844, '58 EO 8153', 'Dodge', 'Ram 2500', 1997, 'LPG', 40696, 1, '2024-12-24 00:00:00', 419);
INSERT INTO public.vehicle VALUES (845, '58 ET 8491', 'Ford', 'Explorer', 1994, 'Gas', 57653, 1, '2023-02-21 00:00:00', 420);
INSERT INTO public.vehicle VALUES (846, '58 GH 6472', 'Mercedes-Benz', 'E-Class', 1999, 'Diesel', 16644, 5, '2023-02-24 00:00:00', 420);
INSERT INTO public.vehicle VALUES (847, '58 UD 7441', 'Chevrolet', 'Beretta', 1995, 'Electricity', 44472, 3, '2023-02-24 00:00:00', 420);
INSERT INTO public.vehicle VALUES (848, '58 YD 2686', 'Buick', 'Park Avenue', 1994, 'LPG', 32753, 1, '2023-02-13 00:00:00', 420);
INSERT INTO public.vehicle VALUES (849, '58 YO 6087', 'Jeep', 'Wrangler', 2010, 'Gas', 42086, 3, '2023-09-07 00:00:00', 421);
INSERT INTO public.vehicle VALUES (850, '59 BL 4453', 'Jaguar', 'XJ', 2010, 'Diesel', 21627, 5, '2023-07-30 00:00:00', 422);
INSERT INTO public.vehicle VALUES (851, '59 FP 1447', 'Morgan', 'Aero 8', 2007, 'Electricity', 43155, 5, '2023-06-09 00:00:00', 422);
INSERT INTO public.vehicle VALUES (852, '59 GI 3574', 'GMC', 'Yukon XL 2500', 2006, 'LPG', 43271, 2, '2023-04-19 00:00:00', 423);
INSERT INTO public.vehicle VALUES (853, '59 KS 118', 'Oldsmobile', 'Aurora', 2003, 'Gas', 34657, 1, '2024-12-22 00:00:00', 424);
INSERT INTO public.vehicle VALUES (854, '59 OP 8391', 'Chevrolet', 'Corvette', 1994, 'Diesel', 55584, 4, '2025-03-25 00:00:00', 425);
INSERT INTO public.vehicle VALUES (855, '59 TZ 6336', 'Mitsubishi', 'Challenger', 1998, 'Electricity', 50499, 3, '2025-02-19 00:00:00', 425);
INSERT INTO public.vehicle VALUES (856, '59 YG 9280', 'Suzuki', 'SJ', 1993, 'LPG', 41461, 2, '2024-04-15 00:00:00', 426);
INSERT INTO public.vehicle VALUES (857, '59 ZG 3173', 'Isuzu', 'Rodeo Sport', 2002, 'Gas', 20523, 5, '2023-03-01 00:00:00', 427);
INSERT INTO public.vehicle VALUES (858, '60 FO 8243', 'Honda', 'Odyssey', 2001, 'Diesel', 33697, 1, '2023-10-01 00:00:00', 428);
INSERT INTO public.vehicle VALUES (859, '60 HV 4843', 'GMC', 'Savana 1500', 2012, 'Electricity', 53782, 4, '2023-08-25 00:00:00', 428);
INSERT INTO public.vehicle VALUES (860, '60 IV 116', 'Ford', 'Crown Victoria', 2008, 'LPG', 36149, 1, '2023-06-28 00:00:00', 429);
INSERT INTO public.vehicle VALUES (861, '60 MJ 9847', 'Nissan', 'JUKE', 2011, 'Gas', 58358, 3, '2023-06-20 00:00:00', 429);
INSERT INTO public.vehicle VALUES (862, '60 OJ 1126', 'Hummer', 'H2', 2005, 'Diesel', 33284, 5, '2024-01-02 00:00:00', 430);
INSERT INTO public.vehicle VALUES (863, '60 R 761', 'Chevrolet', 'S10', 2000, 'Electricity', 35561, 5, '2023-12-15 00:00:00', 430);
INSERT INTO public.vehicle VALUES (864, '60 SF 3731', 'Mercedes-Benz', '300SE', 1993, 'LPG', 41386, 4, '2025-02-04 00:00:00', 431);
INSERT INTO public.vehicle VALUES (865, '60 SM 9119', 'Lincoln', 'Continental', 1994, 'Gas', 41636, 1, '2025-02-19 00:00:00', 432);
INSERT INTO public.vehicle VALUES (866, '61 OC 2390', 'Ford', 'F150', 2012, 'Diesel', 43474, 1, '2025-01-18 00:00:00', 432);
INSERT INTO public.vehicle VALUES (867, '61 RM 8290', 'GMC', 'Savana 1500', 1996, 'Electricity', 50301, 4, '2025-01-21 00:00:00', 433);
INSERT INTO public.vehicle VALUES (868, '62 BC 3082', 'Isuzu', 'Oasis', 1997, 'LPG', 54253, 1, '2025-01-18 00:00:00', 433);
INSERT INTO public.vehicle VALUES (869, '62 EB 1555', 'Ford', 'Crown Victoria', 1993, 'Gas', 11641, 5, '2025-03-20 00:00:00', 434);
INSERT INTO public.vehicle VALUES (870, '62 EF 782', 'Mercedes-Benz', 'GLK-Class', 2012, 'Diesel', 56778, 4, '2025-04-12 00:00:00', 434);
INSERT INTO public.vehicle VALUES (871, '62 EG 1011', 'Toyota', 'Celica', 1995, 'Electricity', 26531, 2, '2023-06-01 00:00:00', 435);
INSERT INTO public.vehicle VALUES (872, '62 GE 6200', 'GMC', '1500', 1995, 'LPG', 30367, 2, '2023-04-21 00:00:00', 435);
INSERT INTO public.vehicle VALUES (873, '62 II 6939', 'Acura', 'TSX', 2008, 'Gas', 28577, 4, '2023-04-06 00:00:00', 435);
INSERT INTO public.vehicle VALUES (874, '62 UD 376', 'Mercedes-Benz', 'Sprinter', 2011, 'Diesel', 36623, 2, '2023-05-30 00:00:00', 436);
INSERT INTO public.vehicle VALUES (875, '63 JC 9871', 'Chevrolet', 'Express', 2009, 'Electricity', 14029, 4, '2023-07-17 00:00:00', 436);
INSERT INTO public.vehicle VALUES (876, '63 JV 8445', 'Volkswagen', 'New Beetle', 2006, 'LPG', 58961, 2, '2023-06-25 00:00:00', 436);
INSERT INTO public.vehicle VALUES (877, '63 ML 4883', 'Isuzu', 'Stylus', 1993, 'Gas', 33874, 3, '2024-05-03 00:00:00', 437);
INSERT INTO public.vehicle VALUES (878, '63 PA 5581', 'Saab', '900', 1986, 'Diesel', 16782, 5, '2024-05-29 00:00:00', 437);
INSERT INTO public.vehicle VALUES (879, '63 PY 4680', 'Cadillac', 'Escalade ESV', 2006, 'Electricity', 56519, 4, '2024-05-01 00:00:00', 437);
INSERT INTO public.vehicle VALUES (880, '63 R 1589', 'Lexus', 'IS F', 2010, 'LPG', 39300, 2, '2024-05-06 00:00:00', 437);
INSERT INTO public.vehicle VALUES (881, '64 ED 1056', 'Suzuki', 'Swift', 1988, 'Gas', 13051, 1, '2023-03-23 00:00:00', 438);
INSERT INTO public.vehicle VALUES (882, '64 OM 3136', 'Toyota', 'Camry Solara', 2007, 'Diesel', 50556, 1, '2023-04-07 00:00:00', 438);
INSERT INTO public.vehicle VALUES (883, '64 YY 8954', 'GMC', 'Rally Wagon 1500', 1993, 'Electricity', 32742, 4, '2024-04-06 00:00:00', 439);
INSERT INTO public.vehicle VALUES (884, '65 CK 3998', 'Subaru', 'Tribeca', 2012, 'LPG', 28251, 3, '2023-09-03 00:00:00', 440);
INSERT INTO public.vehicle VALUES (885, '65 J 3021', 'Hummer', 'H1', 1999, 'Gas', 26666, 1, '2023-08-16 00:00:00', 440);
INSERT INTO public.vehicle VALUES (886, '65 JF 586', 'Pontiac', 'LeMans', 1988, 'Diesel', 30506, 3, '2024-11-19 00:00:00', 441);
INSERT INTO public.vehicle VALUES (887, '66 AU 9517', 'Pontiac', 'Firefly', 1994, 'Electricity', 16525, 2, '2024-11-10 00:00:00', 441);
INSERT INTO public.vehicle VALUES (888, '66 BR 4449', 'Nissan', 'Armada', 2010, 'LPG', 18791, 1, '2025-01-18 00:00:00', 442);
INSERT INTO public.vehicle VALUES (889, '66 D 8358', 'Ford', 'Fiesta', 2013, 'Gas', 32674, 4, '2025-02-11 00:00:00', 442);
INSERT INTO public.vehicle VALUES (890, '66 DC 6538', 'GMC', 'Savana 2500', 2003, 'Diesel', 33084, 3, '2024-04-11 00:00:00', 443);
INSERT INTO public.vehicle VALUES (891, '66 IB 4673', 'Chevrolet', 'Tracker', 2002, 'Electricity', 15395, 2, '2023-07-10 00:00:00', 444);
INSERT INTO public.vehicle VALUES (892, '66 MH 9667', 'Isuzu', 'Trooper', 2001, 'LPG', 13369, 1, '2025-01-04 00:00:00', 445);
INSERT INTO public.vehicle VALUES (893, '66 OP 2872', 'Cadillac', 'STS', 2010, 'Gas', 21637, 5, '2025-04-04 00:00:00', 446);
INSERT INTO public.vehicle VALUES (894, '66 SU 6504', 'BMW', 'M5', 2001, 'Diesel', 22831, 2, '2025-04-06 00:00:00', 446);
INSERT INTO public.vehicle VALUES (895, '66 UE 4245', 'Chevrolet', 'Suburban 2500', 1993, 'Electricity', 38594, 4, '2024-05-07 00:00:00', 447);
INSERT INTO public.vehicle VALUES (896, '66 ZV 9372', 'Maserati', 'Gran Sport', 2005, 'LPG', 14437, 2, '2025-04-28 00:00:00', 448);
INSERT INTO public.vehicle VALUES (897, '67 AM 1352', 'Kia', 'Sephia', 2000, 'Gas', 54860, 4, '2025-03-21 00:00:00', 448);
INSERT INTO public.vehicle VALUES (898, '67 FL 6912', 'Mercedes-Benz', 'E-Class', 1998, 'Diesel', 33225, 5, '2025-04-29 00:00:00', 448);
INSERT INTO public.vehicle VALUES (899, '67 JM 663', 'Mazda', '626', 1990, 'Electricity', 15868, 4, '2025-03-11 00:00:00', 448);
INSERT INTO public.vehicle VALUES (900, '67 LF 5808', 'Dodge', 'Durango', 2003, 'LPG', 25312, 1, '2023-03-25 00:00:00', 449);
INSERT INTO public.vehicle VALUES (901, '67 MP 6207', 'Dodge', 'Dakota', 1994, 'Gas', 59895, 3, '2023-04-06 00:00:00', 449);
INSERT INTO public.vehicle VALUES (902, '67 PH 978', 'Chevrolet', 'Caprice', 1977, 'Diesel', 26563, 5, '2025-06-10 00:00:00', 450);
INSERT INTO public.vehicle VALUES (903, '67 RO 2995', 'Dodge', 'Challenger', 2010, 'Electricity', 24026, 1, '2023-12-21 00:00:00', 451);
INSERT INTO public.vehicle VALUES (904, '68 AL 4320', 'GMC', 'Rally Wagon G2500', 1995, 'LPG', 44410, 2, '2024-08-27 00:00:00', 452);
INSERT INTO public.vehicle VALUES (905, '68 AP 2622', 'Toyota', 'Avalon', 2003, 'Gas', 50616, 1, '2024-10-10 00:00:00', 452);
INSERT INTO public.vehicle VALUES (906, '68 DT 8244', 'Lincoln', 'Navigator', 2005, 'Diesel', 14664, 4, '2024-04-29 00:00:00', 453);
INSERT INTO public.vehicle VALUES (907, '68 HU 5966', 'Lotus', 'Exige', 2012, 'Electricity', 34405, 3, '2023-05-05 00:00:00', 454);
INSERT INTO public.vehicle VALUES (908, '68 IK 4027', 'Chevrolet', 'Impala', 2002, 'LPG', 31032, 2, '2023-05-17 00:00:00', 454);
INSERT INTO public.vehicle VALUES (909, '68 RY 2865', 'Ford', 'Taurus', 1994, 'Gas', 16079, 2, '2023-03-26 00:00:00', 454);
INSERT INTO public.vehicle VALUES (910, '68 UI 4577', 'Pontiac', 'Grand Prix', 1965, 'Diesel', 28824, 5, '2024-02-22 00:00:00', 455);
INSERT INTO public.vehicle VALUES (911, '69 BB 3853', 'Ford', 'Bronco II', 1990, 'Electricity', 59576, 5, '2023-11-20 00:00:00', 456);
INSERT INTO public.vehicle VALUES (912, '69 EF 4712', 'Toyota', 'Corolla', 1994, 'LPG', 20972, 1, '2023-07-02 00:00:00', 457);
INSERT INTO public.vehicle VALUES (913, '69 FA 4106', 'Ford', 'Aspire', 1996, 'Gas', 47457, 2, '2023-06-10 00:00:00', 457);
INSERT INTO public.vehicle VALUES (914, '69 GP 3865', 'Toyota', 'T100', 1998, 'Diesel', 39500, 2, '2024-08-20 00:00:00', 458);
INSERT INTO public.vehicle VALUES (915, '69 HR 5862', 'Hyundai', 'Accent', 2011, 'Electricity', 25090, 3, '2024-08-11 00:00:00', 458);
INSERT INTO public.vehicle VALUES (916, '69 IC 8863', 'Chrysler', '300', 1999, 'LPG', 58489, 5, '2024-09-04 00:00:00', 458);
INSERT INTO public.vehicle VALUES (917, '69 IE 3269', 'Chevrolet', 'Camaro', 1975, 'Gas', 46958, 1, '2024-09-02 00:00:00', 458);
INSERT INTO public.vehicle VALUES (918, '69 J 9305', 'Volkswagen', 'Passat', 2006, 'Diesel', 11079, 1, '2023-12-02 00:00:00', 459);
INSERT INTO public.vehicle VALUES (919, '69 V 2174', 'Cadillac', 'Fleetwood', 1993, 'Electricity', 24127, 4, '2023-12-27 00:00:00', 459);
INSERT INTO public.vehicle VALUES (920, '69 YV 6315', 'Mercury', 'Cougar', 1993, 'LPG', 30215, 3, '2023-11-15 00:00:00', 459);
INSERT INTO public.vehicle VALUES (921, '70 HM 8837', 'Suzuki', 'Grand Vitara', 2012, 'Gas', 15997, 2, '2023-12-08 00:00:00', 459);
INSERT INTO public.vehicle VALUES (922, '70 LE 2840', 'Saturn', 'S-Series', 1999, 'Diesel', 51022, 3, '2024-08-20 00:00:00', 460);
INSERT INTO public.vehicle VALUES (923, '70 MO 3092', 'GMC', 'Vandura 1500', 1993, 'Electricity', 49967, 1, '2024-09-11 00:00:00', 460);
INSERT INTO public.vehicle VALUES (924, '70 UT 4703', 'Lexus', 'IS', 2010, 'LPG', 30296, 4, '2024-08-08 00:00:00', 460);
INSERT INTO public.vehicle VALUES (925, '71 EM 3725', 'Toyota', 'Xtra', 1994, 'Gas', 52970, 2, '2024-10-13 00:00:00', 461);
INSERT INTO public.vehicle VALUES (926, '71 FP 699', 'Jeep', 'Grand Cherokee', 2003, 'Diesel', 16379, 5, '2024-03-16 00:00:00', 462);
INSERT INTO public.vehicle VALUES (927, '71 IC 4035', 'Lincoln', 'Continental Mark VII', 1989, 'Electricity', 27492, 3, '2025-04-10 00:00:00', 463);
INSERT INTO public.vehicle VALUES (928, '71 RP 9644', 'Lamborghini', 'Diablo', 1998, 'LPG', 26860, 4, '2025-05-02 00:00:00', 463);
INSERT INTO public.vehicle VALUES (929, '71 ZU 1038', 'BMW', '645', 2004, 'Gas', 11991, 2, '2025-04-19 00:00:00', 463);
INSERT INTO public.vehicle VALUES (930, '72 BD 8379', 'Chevrolet', 'Express 2500', 1998, 'Diesel', 54335, 3, '2025-04-10 00:00:00', 463);
INSERT INTO public.vehicle VALUES (931, '72 CN 4675', 'Buick', 'Regal', 1999, 'Electricity', 20657, 4, '2023-12-06 00:00:00', 464);
INSERT INTO public.vehicle VALUES (932, '72 DK 7562', 'Honda', 'Odyssey', 2003, 'LPG', 51052, 3, '2024-01-31 00:00:00', 464);
INSERT INTO public.vehicle VALUES (933, '72 ID 3847', 'Chevrolet', 'Silverado 3500', 2006, 'Gas', 43809, 3, '2025-04-04 00:00:00', 465);
INSERT INTO public.vehicle VALUES (934, '72 ML 8726', 'GMC', 'Savana 1500', 2000, 'Diesel', 23794, 4, '2025-05-05 00:00:00', 465);
INSERT INTO public.vehicle VALUES (935, '72 NC 9720', 'Mazda', 'Mazda2', 2011, 'Electricity', 52979, 3, '2023-11-17 00:00:00', 466);
INSERT INTO public.vehicle VALUES (936, '72 NM 4150', 'Ford', 'Thunderbird', 1984, 'LPG', 17164, 1, '2023-10-02 00:00:00', 466);
INSERT INTO public.vehicle VALUES (937, '72 VT 2442', 'Mercury', 'Cougar', 1987, 'Gas', 55306, 1, '2024-11-28 00:00:00', 467);
INSERT INTO public.vehicle VALUES (938, '72 YG 694', 'Toyota', 'Avalon', 2003, 'Diesel', 40580, 5, '2024-12-26 00:00:00', 467);
INSERT INTO public.vehicle VALUES (939, '72 YJ 2252', 'Ford', 'Taurus', 2001, 'Electricity', 27623, 1, '2024-08-05 00:00:00', 468);
INSERT INTO public.vehicle VALUES (940, '73 AU 1263', 'Ferrari', '458 Italia', 2011, 'LPG', 14906, 1, '2024-06-17 00:00:00', 468);
INSERT INTO public.vehicle VALUES (941, '73 CB 9819', 'Chevrolet', 'Silverado 1500', 1999, 'Gas', 48411, 5, '2024-07-09 00:00:00', 468);
INSERT INTO public.vehicle VALUES (942, '73 D 9886', 'Lincoln', 'Continental', 1997, 'Diesel', 46823, 2, '2024-07-07 00:00:00', 468);
INSERT INTO public.vehicle VALUES (943, '73 FR 4426', 'BMW', '5 Series', 2001, 'Electricity', 55910, 1, '2025-03-12 00:00:00', 469);
INSERT INTO public.vehicle VALUES (944, '73 KD 7633', 'Pontiac', 'Firebird Trans Am', 1986, 'LPG', 50793, 3, '2025-05-09 00:00:00', 469);
INSERT INTO public.vehicle VALUES (945, '73 OJ 8272', 'Chevrolet', 'Sportvan G20', 1993, 'Gas', 18862, 4, '2023-11-16 00:00:00', 470);
INSERT INTO public.vehicle VALUES (946, '73 PD 550', 'Chevrolet', 'Corsica', 1995, 'Diesel', 36607, 3, '2023-11-12 00:00:00', 470);
INSERT INTO public.vehicle VALUES (947, '73 TK 1092', 'GMC', 'Savana 3500', 2005, 'Electricity', 18703, 1, '2023-10-27 00:00:00', 470);
INSERT INTO public.vehicle VALUES (948, '73 ZA 2495', 'Mitsubishi', 'Galant', 2006, 'LPG', 51609, 5, '2023-12-07 00:00:00', 471);
INSERT INTO public.vehicle VALUES (949, '73 ZD 1021', 'Mitsubishi', 'Precis', 1993, 'Gas', 24162, 3, '2024-01-10 00:00:00', 471);
INSERT INTO public.vehicle VALUES (950, '74 CM 5018', 'Ford', 'Mustang', 1988, 'Diesel', 31510, 2, '2023-12-09 00:00:00', 471);
INSERT INTO public.vehicle VALUES (951, '74 HC 6604', 'Mercedes-Benz', '600SEC', 1993, 'Electricity', 24912, 1, '2024-06-26 00:00:00', 472);
INSERT INTO public.vehicle VALUES (952, '74 LF 1986', 'Mercedes-Benz', 'CLK-Class', 2001, 'LPG', 23154, 4, '2024-08-05 00:00:00', 473);
INSERT INTO public.vehicle VALUES (953, '74 TI 1273', 'Mitsubishi', 'Galant', 2009, 'Gas', 21860, 1, '2023-05-27 00:00:00', 474);
INSERT INTO public.vehicle VALUES (954, '74 YZ 8784', 'MINI', 'Cooper Countryman', 2011, 'Diesel', 35217, 2, '2023-07-17 00:00:00', 474);
INSERT INTO public.vehicle VALUES (955, '75 K 9631', 'Mitsubishi', 'Outlander', 2012, 'Electricity', 40369, 4, '2025-03-20 00:00:00', 475);
INSERT INTO public.vehicle VALUES (956, '75 OI 5270', 'Lexus', 'RX Hybrid', 2011, 'LPG', 35674, 5, '2025-04-05 00:00:00', 475);
INSERT INTO public.vehicle VALUES (957, '75 OO 8114', 'Dodge', 'Grand Caravan', 2001, 'Gas', 50555, 3, '2025-04-18 00:00:00', 475);
INSERT INTO public.vehicle VALUES (958, '76 AY 1282', 'Mazda', 'MX-5', 1993, 'Diesel', 46362, 5, '2025-04-24 00:00:00', 475);
INSERT INTO public.vehicle VALUES (959, '76 CF 9693', 'Ford', 'Expedition', 1998, 'Electricity', 39954, 2, '2024-10-23 00:00:00', 476);
INSERT INTO public.vehicle VALUES (960, '76 GJ 3855', 'Mercury', 'Tracer', 1994, 'LPG', 15676, 4, '2024-09-15 00:00:00', 476);
INSERT INTO public.vehicle VALUES (961, '76 IR 3613', 'Dodge', 'Viper', 2008, 'Gas', 55850, 5, '2025-04-10 00:00:00', 477);
INSERT INTO public.vehicle VALUES (962, '76 NF 1012', 'Mercury', 'Mystique', 1998, 'Diesel', 58153, 5, '2024-06-30 00:00:00', 478);
INSERT INTO public.vehicle VALUES (963, '76 RU 6277', 'Dodge', 'Dakota', 2000, 'Electricity', 17864, 1, '2024-08-08 00:00:00', 478);
INSERT INTO public.vehicle VALUES (964, '76 TL 3437', 'Saab', '900', 1995, 'LPG', 24158, 2, '2023-08-25 00:00:00', 479);
INSERT INTO public.vehicle VALUES (965, '76 TT 9702', 'Lamborghini', 'Gallardo', 2012, 'Gas', 59847, 5, '2024-06-11 00:00:00', 480);
INSERT INTO public.vehicle VALUES (966, '76 UT 618', 'Ford', 'Econoline E250', 1998, 'Diesel', 47288, 5, '2024-07-19 00:00:00', 480);
INSERT INTO public.vehicle VALUES (967, '77 JD 6776', 'Acura', 'MDX', 2006, 'Electricity', 26484, 3, '2024-07-10 00:00:00', 480);
INSERT INTO public.vehicle VALUES (968, '77 LP 566', 'Cadillac', 'CTS-V', 2010, 'LPG', 35016, 2, '2024-06-01 00:00:00', 480);
INSERT INTO public.vehicle VALUES (969, '77 MI 9948', 'GMC', '3500 Club Coupe', 1994, 'Gas', 59746, 4, '2025-02-16 00:00:00', 481);
INSERT INTO public.vehicle VALUES (970, '77 MU 1945', 'Chevrolet', 'Sportvan G10', 1992, 'Diesel', 17032, 4, '2024-08-18 00:00:00', 482);
INSERT INTO public.vehicle VALUES (971, '78 LJ 1336', 'Maserati', 'Gran Sport', 2005, 'Electricity', 12859, 3, '2024-08-19 00:00:00', 482);
INSERT INTO public.vehicle VALUES (972, '78 LJ 7245', 'Chevrolet', 'Cavalier', 2004, 'LPG', 45613, 3, '2023-03-31 00:00:00', 483);
INSERT INTO public.vehicle VALUES (973, '78 MA 7429', 'Austin', 'Mini Cooper S', 1963, 'Gas', 58607, 1, '2024-12-21 00:00:00', 484);
INSERT INTO public.vehicle VALUES (974, '78 NY 6545', 'Morgan', 'Aero 8', 2008, 'Diesel', 51503, 5, '2024-10-06 00:00:00', 485);
INSERT INTO public.vehicle VALUES (975, '78 OD 7322', 'Maserati', 'Quattroporte', 1986, 'Electricity', 45210, 4, '2024-09-16 00:00:00', 485);
INSERT INTO public.vehicle VALUES (976, '78 UD 5542', 'Pontiac', 'Sunbird', 1990, 'LPG', 49630, 4, '2023-02-20 00:00:00', 486);
INSERT INTO public.vehicle VALUES (977, '78 YE 6823', 'Mazda', 'Tribute', 2010, 'Gas', 44973, 1, '2024-08-20 00:00:00', 487);
INSERT INTO public.vehicle VALUES (978, '79 CC 8917', 'Mercedes-Benz', 'E-Class', 2012, 'Diesel', 46447, 3, '2025-01-20 00:00:00', 488);
INSERT INTO public.vehicle VALUES (979, '79 DA 4356', 'Chrysler', '300', 2008, 'Electricity', 49041, 1, '2025-01-13 00:00:00', 489);
INSERT INTO public.vehicle VALUES (980, '79 HS 9582', 'Pontiac', 'Parisienne', 1985, 'LPG', 32431, 4, '2024-12-30 00:00:00', 489);
INSERT INTO public.vehicle VALUES (981, '79 JB 3635', 'Chevrolet', 'Camaro', 2002, 'Gas', 46297, 5, '2025-02-06 00:00:00', 489);
INSERT INTO public.vehicle VALUES (982, '79 L 3345', 'Nissan', 'GT-R', 2012, 'Diesel', 33914, 3, '2023-04-18 00:00:00', 490);
INSERT INTO public.vehicle VALUES (983, '79 OA 9636', 'Maserati', 'Quattroporte', 2009, 'Electricity', 18626, 5, '2024-09-06 00:00:00', 491);
INSERT INTO public.vehicle VALUES (984, '80 BY 3013', 'Acura', 'TL', 2004, 'LPG', 45701, 1, '2024-08-31 00:00:00', 491);
INSERT INTO public.vehicle VALUES (985, '80 BZ 4205', 'GMC', 'Jimmy', 1994, 'Gas', 11509, 3, '2024-05-03 00:00:00', 492);
INSERT INTO public.vehicle VALUES (986, '80 CP 2679', 'Mitsubishi', 'Challenger', 2001, 'Diesel', 39305, 1, '2024-05-24 00:00:00', 492);
INSERT INTO public.vehicle VALUES (987, '80 EC 3426', 'Mercedes-Benz', '500SEL', 1993, 'Electricity', 52286, 2, '2024-06-08 00:00:00', 492);
INSERT INTO public.vehicle VALUES (988, '80 GG 7959', 'Plymouth', 'Colt Vista', 1994, 'LPG', 35152, 3, '2024-08-14 00:00:00', 493);
INSERT INTO public.vehicle VALUES (989, '80 GI 2009', 'Ford', 'Laser', 1989, 'Gas', 58267, 2, '2023-08-07 00:00:00', 494);
INSERT INTO public.vehicle VALUES (990, '80 LL 2267', 'Chevrolet', 'Camaro', 1979, 'Diesel', 44606, 4, '2025-02-03 00:00:00', 495);
INSERT INTO public.vehicle VALUES (991, '80 LU 334', 'Dodge', 'Ram 3500', 2006, 'Electricity', 49113, 2, '2023-10-21 00:00:00', 496);
INSERT INTO public.vehicle VALUES (992, '80 RB 6034', 'Audi', 'R8', 2011, 'LPG', 50157, 3, '2024-12-09 00:00:00', 497);
INSERT INTO public.vehicle VALUES (993, '80 VM 6952', 'Lotus', 'Esprit Turbo', 1984, 'Gas', 50176, 4, '2024-12-12 00:00:00', 497);
INSERT INTO public.vehicle VALUES (994, '80 ZC 9064', 'Saturn', 'S-Series', 1992, 'Diesel', 59790, 1, '2024-05-08 00:00:00', 498);
INSERT INTO public.vehicle VALUES (995, '81 FC 1790', 'Toyota', 'Tacoma', 2012, 'Electricity', 53215, 2, '2024-05-31 00:00:00', 498);
INSERT INTO public.vehicle VALUES (996, '81 JF 8916', 'Audi', 'A6', 1995, 'LPG', 28772, 2, '2023-04-25 00:00:00', 499);
INSERT INTO public.vehicle VALUES (997, '81 JM 7470', 'Subaru', 'SVX', 1996, 'Gas', 53754, 5, '2023-05-17 00:00:00', 499);
INSERT INTO public.vehicle VALUES (998, '81 SC 688', 'Volvo', '960', 1992, 'Diesel', 43521, 5, '2023-06-12 00:00:00', 499);
INSERT INTO public.vehicle VALUES (999, '81 SU 6660', 'MINI', 'Cooper Clubman', 2010, 'Electricity', 25542, 4, '2024-04-29 00:00:00', 500);
INSERT INTO public.vehicle VALUES (1000, '81 ZN 5489', 'Ford', 'Laser', 1985, 'LPG', 25615, 1, '2024-05-16 00:00:00', 500);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 227
-- Name: appointment_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_appointment_id_seq', 1615, true);


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 221
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_city_id_seq', 1, false);


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 223
-- Name: dealership_dealership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dealership_dealership_id_seq', 243, true);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 229
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 3243, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 231
-- Name: employee_schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_schedule_schedule_id_seq', 1451, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 225
-- Name: maintenance_type_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maintenance_type_type_id_seq', 4, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 501, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 219
-- Name: vehicle_vehicle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicle_vehicle_id_seq', 1002, true);


--
-- TOC entry 4758 (class 2606 OID 16453)
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (appointment_id);


--
-- TOC entry 4752 (class 2606 OID 16423)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 4754 (class 2606 OID 16432)
-- Name: dealership dealership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealership
    ADD CONSTRAINT dealership_pkey PRIMARY KEY (dealership_id);


--
-- TOC entry 4760 (class 2606 OID 16480)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 4762 (class 2606 OID 16492)
-- Name: employee_schedule employee_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_schedule
    ADD CONSTRAINT employee_schedule_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 4756 (class 2606 OID 16445)
-- Name: maintenance_type maintenance_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenance_type
    ADD CONSTRAINT maintenance_type_pkey PRIMARY KEY (type_id);


--
-- TOC entry 4744 (class 2606 OID 16397)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4746 (class 2606 OID 16399)
-- Name: users users_u_mail_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_u_mail_key UNIQUE (u_mail);


--
-- TOC entry 4748 (class 2606 OID 16409)
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (vehicle_id);


--
-- TOC entry 4750 (class 2606 OID 16509)
-- Name: vehicle vehicle_plate_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_plate_number_key UNIQUE (plate_number);


--
-- TOC entry 4765 (class 2606 OID 16464)
-- Name: appointment appointment_dealership_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_dealership_id_fkey FOREIGN KEY (dealership_id) REFERENCES public.dealership(dealership_id) ON DELETE CASCADE;


--
-- TOC entry 4766 (class 2606 OID 16469)
-- Name: appointment appointment_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.maintenance_type(type_id) ON DELETE CASCADE;


--
-- TOC entry 4767 (class 2606 OID 16454)
-- Name: appointment appointment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4768 (class 2606 OID 16459)
-- Name: appointment appointment_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id) ON DELETE CASCADE;


--
-- TOC entry 4764 (class 2606 OID 16433)
-- Name: dealership dealership_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealership
    ADD CONSTRAINT dealership_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id) ON DELETE CASCADE;


--
-- TOC entry 4769 (class 2606 OID 16481)
-- Name: employee employee_dealership_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_dealership_id_fkey FOREIGN KEY (dealership_id) REFERENCES public.dealership(dealership_id) ON DELETE SET NULL;


--
-- TOC entry 4770 (class 2606 OID 16498)
-- Name: employee_schedule employee_schedule_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_schedule
    ADD CONSTRAINT employee_schedule_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointment(appointment_id) ON DELETE SET NULL;


--
-- TOC entry 4771 (class 2606 OID 16493)
-- Name: employee_schedule employee_schedule_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_schedule
    ADD CONSTRAINT employee_schedule_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id) ON DELETE CASCADE;


--
-- TOC entry 4763 (class 2606 OID 16412)
-- Name: vehicle vehicle_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


-- Completed on 2025-05-18 22:27:45

--
-- PostgreSQL database dump complete
--

