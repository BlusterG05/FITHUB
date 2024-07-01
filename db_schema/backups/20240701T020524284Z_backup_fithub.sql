--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-06-30 21:05:24

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
-- TOC entry 244 (class 1255 OID 17208)
-- Name: create_exercise(character varying, text, integer, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_exercise(p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        INSERT INTO Exercises (
            exercise_name, exercise_description, exercise_discipline_id,
            exercise_recommendations, exercise_group_id, exercise_category_id
        ) VALUES (
                     p_exercise_name, p_exercise_description, p_exercise_discipline_id,
                     p_exercise_recommendations, p_exercise_group_id, p_exercise_category_id
                 );
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid discipline_id, group_id, or category_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.create_exercise(p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 17209)
-- Name: create_machine(character varying, date, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_machine(machine_name character varying, machine_acquired_at date, machine_category_id integer, machine_group_id integer, machine_discipline_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        INSERT INTO Machines (
            machine_name, machine_acquired_at, machine_category_id,
            machine_group_id, machine_discipline_id
        ) VALUES (
                     machine_name, machine_acquired_at, machine_category_id,
                     machine_group_id, machine_discipline_id
                 );
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid category_id, group_id, or discipline_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.create_machine(machine_name character varying, machine_acquired_at date, machine_category_id integer, machine_group_id integer, machine_discipline_id integer) OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 17210)
-- Name: create_membership(character varying, numeric, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_membership(p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        INSERT INTO Memberships (
            membership_name, membership_price, membership_type,
            membership_status, membership_duration, membership_created_at
        ) VALUES (
                     p_membership_name, p_membership_price, p_membership_type,
                     p_membership_status, p_membership_duration, CURRENT_TIMESTAMP
                 );
    EXCEPTION
        WHEN unique_violation THEN
            RAISE EXCEPTION 'Duplicate entry for membership_name';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.create_membership(p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 17211)
-- Name: create_trainer(character varying, character varying, character varying, integer, character, character varying, character varying, text, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_trainer(trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        INSERT INTO Trainers (
            trainer_cedula, trainer_first_name, trainer_last_name, trainer_age,
            trainer_gender, trainer_phone, trainer_email, trainer_address,
            trainer_city, trainer_main_discipline_id, trainer_hired_at
        ) VALUES (
                     trainer_cedula, trainer_first_name, trainer_last_name, trainer_age,
                     trainer_gender, trainer_phone, trainer_email, trainer_address,
                     trainer_city, trainer_main_discipline_id, CURRENT_TIMESTAMP
                 );
    EXCEPTION
        WHEN unique_violation THEN
            RAISE EXCEPTION 'Duplicate entry for trainer_cedula or trainer_email';
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid trainer_main_discipline_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.create_trainer(trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 17212)
-- Name: create_user(character varying, character varying, character varying, character varying, character varying, text, integer, character, bytea, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_user(user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        INSERT INTO Users (
            user_cedula, user_first_name, user_last_name, user_phone, user_email,
            user_address, user_age, user_gender, user_profile_picture, trainer_id,
            user_membership_status, user_created_at
        ) VALUES (
                     user_cedula, user_first_name, user_last_name, user_phone, user_email,
                     user_address, user_age, user_gender, user_profile_picture, trainer_id,
                     user_membership_status, CURRENT_TIMESTAMP
                 );
    EXCEPTION
        WHEN unique_violation THEN
            RAISE EXCEPTION 'Duplicate entry for user_cedula or user_email';
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid trainer_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.create_user(user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 17213)
-- Name: delete_exercise(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_exercise(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM Exercises WHERE exercise_id = p_id;
END;
$$;


ALTER FUNCTION public.delete_exercise(p_id integer) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 17214)
-- Name: delete_machine(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_machine(machine_delete_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        DELETE FROM Machines WHERE machine_id = machine_delete_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No machine found with ID: %', machine_delete_id;
        END IF;
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.delete_machine(machine_delete_id integer) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 17215)
-- Name: delete_membership(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_membership(p_membership_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        DELETE FROM Memberships WHERE membership_id = p_membership_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No membership found with ID: %', p_membership_id;
        END IF;
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.delete_membership(p_membership_id integer) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 17216)
-- Name: delete_trainer(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_trainer(p_trainer_cedula character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        DELETE FROM Trainers WHERE trainer_cedula = p_trainer_cedula;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No trainer found with cedula: %', p_trainer_cedula;
        END IF;
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.delete_trainer(p_trainer_cedula character varying) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 17217)
-- Name: delete_user(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_user(user_cedula_serch character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        DELETE FROM Users WHERE user_cedula = user_cedula_serch;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No user found with cedula: %', user_cedula_serch;
        END IF;
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.delete_user(user_cedula_serch character varying) OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 17218)
-- Name: edit_exercise(integer, character varying, text, integer, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_exercise(p_exercise_id integer, p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        UPDATE Exercises
        SET 
            exercise_name = p_exercise_name,
            exercise_description = p_exercise_description,
            exercise_discipline_id = p_exercise_discipline_id,
            exercise_recommendations = p_exercise_recommendations,
            exercise_group_id = p_exercise_group_id,
            exercise_category_id = p_exercise_category_id
        WHERE exercise_id = p_exercise_id;
        
        -- Verificar si la fila fue encontrada y actualizada
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No exercise found with ID: %', p_exercise_id;
        END IF;
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid discipline_id, group_id, or category_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.edit_exercise(p_exercise_id integer, p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 17219)
-- Name: edit_machine(integer, character varying, date, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_machine(p_machine_id integer, p_machine_name character varying, p_machine_acquired_at date, p_machine_category_id integer, p_machine_group_id integer, p_machine_discipline_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        UPDATE Machines
        SET 
            machine_name = p_machine_name,
            machine_acquired_at = p_machine_acquired_at,
            machine_category_id = p_machine_category_id,
            machine_group_id = p_machine_group_id,
            machine_discipline_id = p_machine_discipline_id
        WHERE machine_id = p_machine_id;
        
        -- Verificar si la fila fue encontrada y actualizada
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No machine found with ID: %', p_machine_id;
        END IF;
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid category_id, group_id, or discipline_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.edit_machine(p_machine_id integer, p_machine_name character varying, p_machine_acquired_at date, p_machine_category_id integer, p_machine_group_id integer, p_machine_discipline_id integer) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 17220)
-- Name: edit_membership(integer, character varying, numeric, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_membership(p_membership_id integer, p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        UPDATE Memberships
        SET 
            membership_name = p_membership_name,
            membership_price = p_membership_price,
            membership_type = p_membership_type,
            membership_status = p_membership_status,
            membership_duration = p_membership_duration
        WHERE membership_id = p_membership_id;
        
        -- Verificar si la fila fue encontrada y actualizada
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No membership found with ID: %', p_membership_id;
        END IF;
    EXCEPTION
        WHEN unique_violation THEN
            RAISE EXCEPTION 'Duplicate entry for membership_name';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.edit_membership(p_membership_id integer, p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 17221)
-- Name: edit_trainer(character varying, character varying, character varying, integer, character, character varying, character varying, text, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_trainer(p_trainer_cedula character varying, p_trainer_first_name character varying, p_trainer_last_name character varying, p_trainer_age integer, p_trainer_gender character, p_trainer_phone character varying, p_trainer_email character varying, p_trainer_address text, p_trainer_city character varying, p_trainer_main_discipline_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        UPDATE Trainers
        SET 
            trainer_first_name = p_trainer_first_name,
            trainer_last_name = p_trainer_last_name,
            trainer_age = p_trainer_age,
            trainer_gender = p_trainer_gender,
            trainer_phone = p_trainer_phone,
            trainer_email = p_trainer_email,
            trainer_address = p_trainer_address,
            trainer_city = p_trainer_city,
            trainer_main_discipline_id = p_trainer_main_discipline_id
        WHERE trainer_cedula = p_trainer_cedula;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No trainer found with cedula: %', p_trainer_cedula;
        END IF;
    EXCEPTION
        WHEN unique_violation THEN
            RAISE EXCEPTION 'Duplicate entry for trainer_cedula or trainer_email';
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid trainer_main_discipline_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.edit_trainer(p_trainer_cedula character varying, p_trainer_first_name character varying, p_trainer_last_name character varying, p_trainer_age integer, p_trainer_gender character, p_trainer_phone character varying, p_trainer_email character varying, p_trainer_address text, p_trainer_city character varying, p_trainer_main_discipline_id integer) OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 17222)
-- Name: edit_user(character varying, character varying, character varying, character varying, character varying, text, integer, character, bytea, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_user(p_user_cedula character varying, p_user_first_name character varying, p_user_last_name character varying, p_user_phone character varying, p_user_email character varying, p_user_address text, p_user_age integer, p_user_gender character, p_user_profile_picture bytea, p_trainer_id integer, p_user_membership_status character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    BEGIN
        UPDATE Users
        SET 
            user_first_name = p_user_first_name,
            user_last_name = p_user_last_name,
            user_phone = p_user_phone,
            user_email = p_user_email,
            user_address = p_user_address,
            user_age = p_user_age,
            user_gender = p_user_gender,
            user_profile_picture = p_user_profile_picture,
            trainer_id = p_trainer_id,
            user_membership_status = p_user_membership_status
        WHERE user_cedula = p_user_cedula;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No user found with cedula: %', p_user_cedula;
        END IF;
    EXCEPTION
        WHEN unique_violation THEN
            RAISE EXCEPTION 'Duplicate entry for user_cedula or user_email';
        WHEN foreign_key_violation THEN
            RAISE EXCEPTION 'Invalid trainer_id: Foreign key constraint violation';
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$;


ALTER FUNCTION public.edit_user(p_user_cedula character varying, p_user_first_name character varying, p_user_last_name character varying, p_user_phone character varying, p_user_email character varying, p_user_address text, p_user_age integer, p_user_gender character, p_user_profile_picture bytea, p_trainer_id integer, p_user_membership_status character varying) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 17223)
-- Name: get_all_exercises(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_exercises() RETURNS TABLE(exercise_id integer, exercise_name character varying, exercise_description text, exercise_discipline_name character varying, exercise_group_name character varying, exercise_category_name character varying, exercise_recommendations text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            e.exercise_id AS id,
            e.exercise_name AS Nombre,
            e.exercise_description AS Descripcion,
            d.discipline_name AS Disciplina,
            g.group_name AS Grupo,
            c.category_name AS Categoria,
            e.exercise_recommendations AS Recomendaciones
        FROM Exercises e
                 LEFT JOIN Disciplines d ON e.exercise_discipline_id = d.discipline_id
                 LEFT JOIN Groups g ON e.exercise_group_id = g.group_id
                 LEFT JOIN Categories c ON e.exercise_category_id = c.category_id;
END;
$$;


ALTER FUNCTION public.get_all_exercises() OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 17224)
-- Name: get_all_machines(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_machines() RETURNS TABLE(machine_id integer, machine_name character varying, machine_acquired_at date, machine_category_name character varying, machine_group_name character varying, machine_discipline_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            m.machine_id AS id,
            m.machine_name AS Nombre,
            m.machine_acquired_at AS Fecha_adquisicion,
            c.category_name AS Categoria,
            g.group_name AS Grupo,
            d.discipline_name AS Disciplina
        FROM Machines m
                 LEFT JOIN Categories c ON m.machine_category_id = c.category_id
                 LEFT JOIN Groups g ON m.machine_group_id = g.group_id
                 LEFT JOIN Disciplines d ON m.machine_discipline_id = d.discipline_id;
END;
$$;


ALTER FUNCTION public.get_all_machines() OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 17225)
-- Name: get_all_memberships(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_memberships() RETURNS TABLE(membership_id integer, membership_name character varying, membership_price numeric, membership_type character varying, membership_status character varying, membership_duration integer, membership_created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            m.membership_id AS id,
            m.membership_name AS Nombre,
            m.membership_price AS Precio,
            m.membership_type AS Tipo,
            m.membership_status AS Estado,
            m.membership_duration AS Duracion,
            m.membership_created_at AS Creado_en
        FROM Memberships m;
END;
$$;


ALTER FUNCTION public.get_all_memberships() OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 17226)
-- Name: get_all_trainers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_trainers() RETURNS TABLE(trainer_id integer, trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer, trainer_hired_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            t.trainer_id AS id,
            t.trainer_cedula AS Cedula,
            t.trainer_first_name AS Nombre,
            t.trainer_last_name AS Apellido,
            t.trainer_age AS Edad,
            t.trainer_gender AS Genero,
            t.trainer_phone AS Telefono,
            t.trainer_email AS Email,
            t.trainer_address AS Direccion,
            t.trainer_city AS Ciudad,
            t.trainer_main_discipline_id AS Id_disciplina_principal,
            t.trainer_hired_at AS Contratado_en
        FROM Trainers t;
END;
$$;


ALTER FUNCTION public.get_all_trainers() OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 17227)
-- Name: get_all_users(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_users() RETURNS TABLE(user_id integer, user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying, user_created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            u.user_id as id,
            u.user_cedula as Cedula,
            u.user_first_name as Nombre,
            u.user_last_name as Apellido,
            u.user_phone Telefono,
            u.user_email Email,
            u.user_address Direccion,
            u.user_age Edad,
            u.user_gender Genero,
            u.user_profile_picture Foto_perfil,
            u.trainer_id Id_entrenador,
            u.user_membership_status Estado_membresia,
            u.user_created_at Creado_en
        FROM Users u;
END;
$$;


ALTER FUNCTION public.get_all_users() OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 17228)
-- Name: get_exercise_byid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_exercise_byid(p_exercise_id integer) RETURNS TABLE(exercise_id integer, exercise_name character varying, exercise_description text, exercise_discipline_name character varying, exercise_group_name character varying, exercise_category_name character varying, exercise_recommendations text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            e.exercise_id AS id,
            e.exercise_name AS Nombre,
            e.exercise_description AS Descripcion,
            d.discipline_name AS Disciplina,
            g.group_name AS Grupo,
            c.category_name AS Categoria,
            e.exercise_recommendations AS Recomendaciones
        FROM Exercises e
                 LEFT JOIN Disciplines d ON e.exercise_discipline_id = d.discipline_id
                 LEFT JOIN Groups g ON e.exercise_group_id = g.group_id
                 LEFT JOIN Categories c ON e.exercise_category_id = c.category_id
        WHERE e.exercise_id = p_exercise_id;
END;
$$;


ALTER FUNCTION public.get_exercise_byid(p_exercise_id integer) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 17229)
-- Name: get_exercises(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_exercises(p_limit integer) RETURNS TABLE(exercise_id integer, exercise_name character varying, exercise_description text, exercise_discipline_name character varying, exercise_group_name character varying, exercise_category_name character varying, exercise_recommendations text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY EXECUTE format('
        SELECT
            e.exercise_id AS id,
            e.exercise_name AS Nombre,
            e.exercise_description AS Descripcion,
            d.discipline_name AS Disciplina,
            g.group_name AS Grupo,
            c.category_name AS Categoria,
            e.exercise_recommendations AS Recomendaciones
        FROM Exercises e
        LEFT JOIN Disciplines d ON e.exercise_discipline_id = d.discipline_id
        LEFT JOIN Groups g ON e.exercise_group_id = g.group_id
        LEFT JOIN Categories c ON e.exercise_category_id = c.category_id
        LIMIT %L', p_limit);
END;
$$;


ALTER FUNCTION public.get_exercises(p_limit integer) OWNER TO postgres;

--
-- TOC entry 278 (class 1255 OID 17230)
-- Name: get_machine_byid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_machine_byid(machine_serch_id integer) RETURNS TABLE(machine_id integer, machine_name character varying, machine_acquired_at date, machine_category_name character varying, machine_group_name character varying, machine_discipline_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            m.machine_id AS id,
            m.machine_name AS Nombre,
            m.machine_acquired_at AS Fecha_adquisicion,
            c.category_name AS Categoria,
            g.group_name AS Grupo,
            d.discipline_name AS Disciplina
        FROM Machines m
                 LEFT JOIN Categories c ON m.machine_category_id = c.category_id
                 LEFT JOIN Groups g ON m.machine_group_id = g.group_id
                 LEFT JOIN Disciplines d ON m.machine_discipline_id = d.discipline_id
        WHERE m.machine_id = machine_serch_id;
END;
$$;


ALTER FUNCTION public.get_machine_byid(machine_serch_id integer) OWNER TO postgres;

--
-- TOC entry 279 (class 1255 OID 17231)
-- Name: get_machines(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_machines(p_limit integer) RETURNS TABLE(machine_id integer, machine_name character varying, machine_acquired_at date, machine_category_name character varying, machine_group_name character varying, machine_discipline_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY EXECUTE format('
        SELECT
            m.machine_id AS id,
            m.machine_name AS Nombre,
            m.machine_acquired_at AS Fecha_adquisicion,
            c.category_name AS Categoria,
            g.group_name AS Grupo,
            d.discipline_name AS Disciplina
        FROM Machines m
        LEFT JOIN Categories c ON m.machine_category_id = c.category_id
        LEFT JOIN Groups g ON m.machine_group_id = g.group_id
        LEFT JOIN Disciplines d ON m.machine_discipline_id = d.discipline_id
        LIMIT %L', p_limit);
END;
$$;


ALTER FUNCTION public.get_machines(p_limit integer) OWNER TO postgres;

--
-- TOC entry 280 (class 1255 OID 17232)
-- Name: get_membership_byid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_membership_byid(p_membership_id integer) RETURNS TABLE(membership_id integer, membership_name character varying, membership_price numeric, membership_type character varying, membership_status character varying, membership_duration integer, membership_created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            m.membership_id AS id,
            m.membership_name AS Nombre,
            m.membership_price AS Precio,
            m.membership_type AS Tipo,
            m.membership_status AS Estado,
            m.membership_duration AS Duracion,
            m.membership_created_at AS Creado_en
        FROM Memberships m
        WHERE m.membership_id = p_membership_id;
END;
$$;


ALTER FUNCTION public.get_membership_byid(p_membership_id integer) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 17233)
-- Name: get_memberships(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_memberships(p_limit integer) RETURNS TABLE(membership_id integer, membership_name character varying, membership_price numeric, membership_type character varying, membership_status character varying, membership_duration integer, membership_created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY EXECUTE format('
        SELECT
            m.membership_id AS id,
            m.membership_name AS Nombre,
            m.membership_price AS Precio,
            m.membership_type AS Tipo,
            m.membership_status AS Estado,
            m.membership_duration AS Duracion,
            m.membership_created_at AS Creado_en
        FROM Memberships m
        LIMIT %L', p_limit);
END;
$$;


ALTER FUNCTION public.get_memberships(p_limit integer) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 17234)
-- Name: get_trainer(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_trainer(trainer_cedula_serch character varying) RETURNS TABLE(trainer_id integer, trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer, trainer_hired_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            t.trainer_id AS id,
            t.trainer_cedula AS Cedula,
            t.trainer_first_name AS Nombre,
            t.trainer_last_name AS Apellido,
            t.trainer_age AS Edad,
            t.trainer_gender AS Genero,
            t.trainer_phone AS Telefono,
            t.trainer_email AS Email,
            t.trainer_address AS Direccion,
            t.trainer_city AS Ciudad,
            t.trainer_main_discipline_id AS Id_disciplina_principal,
            t.trainer_hired_at AS Contratado_en
        FROM Trainers t
        WHERE t.trainer_cedula = trainer_cedula_serch;
END;
$$;


ALTER FUNCTION public.get_trainer(trainer_cedula_serch character varying) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 17235)
-- Name: get_trainers(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_trainers(p_limit integer) RETURNS TABLE(trainer_id integer, trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer, trainer_hired_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY EXECUTE format('
        SELECT
            t.trainer_id AS id,
            t.trainer_cedula AS Cedula,
            t.trainer_first_name AS Nombre,
            t.trainer_last_name AS Apellido,
            t.trainer_age AS Edad,
            t.trainer_gender AS Genero,
            t.trainer_phone AS Telefono,
            t.trainer_email AS Email,
            t.trainer_address AS Direccion,
            t.trainer_city AS Ciudad,
            t.trainer_main_discipline_id AS Id_disciplina_principal,
            t.trainer_hired_at AS Contratado_en
        FROM Trainers t
        LIMIT %L', p_limit);
END;
$$;


ALTER FUNCTION public.get_trainers(p_limit integer) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 17236)
-- Name: get_user(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user(user_cedula_serch character varying) RETURNS TABLE(user_id integer, user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying, user_created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            u.user_id as id,
            u.user_cedula as Cedula,
            u.user_first_name as Nombre,
            u.user_last_name as Apellido,
            u.user_phone Telefono,
            u.user_email Email,
            u.user_address Direccion,
            u.user_age Edad,
            u.user_gender Genero,
            u.user_profile_picture Foto_perfil,
            u.trainer_id Id_entrenador,
            u.user_membership_status Estado_membresia,
            u.user_created_at Creado_en
        FROM Users u
        WHERE u.user_cedula = user_cedula_serch;
END;
$$;


ALTER FUNCTION public.get_user(user_cedula_serch character varying) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 17237)
-- Name: get_users(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_users(p_limit integer) RETURNS TABLE(user_id integer, user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying, user_created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY EXECUTE format('
        SELECT
            u.user_id as id,
            u.user_cedula as Cedula,
            u.user_first_name as Nombre,
            u.user_last_name as Apellido,
            u.user_phone Telefono,
            u.user_email Email,
            u.user_address Direccion,
            u.user_age Edad,
            u.user_gender Genero,
            u.user_profile_picture Foto_perfil,
            u.trainer_id Id_entrenador,
            u.user_membership_status Estado_membresia,
            u.user_created_at Creado_en
        FROM Users u
        LIMIT %L', p_limit);
END;
$$;


ALTER FUNCTION public.get_users(p_limit integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 243 (class 1259 OID 17259)
-- Name: administration_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administration_users (
    admin_id integer NOT NULL,
    admin_name character varying(50) NOT NULL,
    admin_username character varying(50) NOT NULL,
    admin_email character varying(100) NOT NULL,
    admin_password character varying(100) NOT NULL,
    admin_created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    admin_role character varying(50) NOT NULL
);


ALTER TABLE public.administration_users OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17258)
-- Name: administration_users_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administration_users_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administration_users_admin_id_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 242
-- Name: administration_users_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administration_users_admin_id_seq OWNED BY public.administration_users.admin_id;


--
-- TOC entry 216 (class 1259 OID 16944)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    category_description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16943)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 215
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 220 (class 1259 OID 16962)
-- Name: disciplines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplines (
    discipline_id integer NOT NULL,
    discipline_name character varying(100) NOT NULL,
    discipline_description text,
    discipline_category_id integer
);


ALTER TABLE public.disciplines OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16961)
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.disciplines_discipline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.disciplines_discipline_id_seq OWNER TO postgres;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 219
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.disciplines_discipline_id_seq OWNED BY public.disciplines.discipline_id;


--
-- TOC entry 237 (class 1259 OID 17131)
-- Name: exercisecategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercisecategory (
    exercise_category_exercise_id integer NOT NULL,
    exercise_category_category_id integer NOT NULL
);


ALTER TABLE public.exercisecategory OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17116)
-- Name: exercisegroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercisegroup (
    exercise_group_exercise_id integer NOT NULL,
    exercise_group_group_id integer NOT NULL
);


ALTER TABLE public.exercisegroup OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17146)
-- Name: exercisemachine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercisemachine (
    exercise_machine_exercise_id integer NOT NULL,
    exercise_machine_machine_id integer NOT NULL
);


ALTER TABLE public.exercisemachine OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17093)
-- Name: exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercises (
    exercise_id integer NOT NULL,
    exercise_name character varying(100) NOT NULL,
    exercise_description text,
    exercise_discipline_id integer,
    exercise_recommendations text,
    exercise_group_id integer,
    exercise_category_id integer
);


ALTER TABLE public.exercises OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17092)
-- Name: exercises_exercise_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercises_exercise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercises_exercise_id_seq OWNER TO postgres;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 234
-- Name: exercises_exercise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercises_exercise_id_seq OWNED BY public.exercises.exercise_id;


--
-- TOC entry 218 (class 1259 OID 16953)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    group_id integer NOT NULL,
    group_name character varying(100) NOT NULL,
    group_description text,
    group_recommendations text
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16952)
-- Name: groups_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.groups_group_id_seq OWNER TO postgres;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 217
-- Name: groups_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_group_id_seq OWNED BY public.groups.group_id;


--
-- TOC entry 239 (class 1259 OID 17161)
-- Name: machinecategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machinecategory (
    machine_category_machine_id integer NOT NULL,
    machine_category_category_id integer NOT NULL
);


ALTER TABLE public.machinecategory OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17191)
-- Name: machinediscipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machinediscipline (
    machine_discipline_machine_id integer NOT NULL,
    machine_discipline_discipline_id integer NOT NULL
);


ALTER TABLE public.machinediscipline OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17176)
-- Name: machinegroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machinegroup (
    machine_group_machine_id integer NOT NULL,
    machine_group_group_id integer NOT NULL
);


ALTER TABLE public.machinegroup OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17071)
-- Name: machines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machines (
    machine_id integer NOT NULL,
    machine_name character varying(100) NOT NULL,
    machine_acquired_at date,
    machine_category_id integer,
    machine_group_id integer,
    machine_discipline_id integer
);


ALTER TABLE public.machines OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17070)
-- Name: machines_machine_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machines_machine_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.machines_machine_id_seq OWNER TO postgres;

--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 232
-- Name: machines_machine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machines_machine_id_seq OWNED BY public.machines.machine_id;


--
-- TOC entry 226 (class 1259 OID 17014)
-- Name: memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.memberships (
    membership_id integer NOT NULL,
    membership_name character varying(100) NOT NULL,
    membership_price numeric(10,2) NOT NULL,
    membership_type character varying(50),
    membership_created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    membership_status character varying(50),
    membership_duration integer
);


ALTER TABLE public.memberships OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17013)
-- Name: memberships_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.memberships_membership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.memberships_membership_id_seq OWNER TO postgres;

--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 225
-- Name: memberships_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.memberships_membership_id_seq OWNED BY public.memberships.membership_id;


--
-- TOC entry 228 (class 1259 OID 17022)
-- Name: membershipuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membershipuser (
    membership_user_id integer NOT NULL,
    membership_user_user_id integer,
    membership_user_membership_id integer,
    membership_user_status character varying(50),
    membership_user_start_date date,
    membership_user_end_date date
);


ALTER TABLE public.membershipuser OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17021)
-- Name: membershipuser_membership_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.membershipuser_membership_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.membershipuser_membership_user_id_seq OWNER TO postgres;

--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 227
-- Name: membershipuser_membership_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.membershipuser_membership_user_id_seq OWNED BY public.membershipuser.membership_user_id;


--
-- TOC entry 230 (class 1259 OID 17039)
-- Name: membershipuserrecord; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membershipuserrecord (
    membership_user_record_id integer NOT NULL,
    membership_user_record_user_id integer,
    membership_user_record_membership_id integer,
    membership_user_record_start_date date,
    membership_user_record_end_date date
);


ALTER TABLE public.membershipuserrecord OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17038)
-- Name: membershipuserrecord_membership_user_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.membershipuserrecord_membership_user_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.membershipuserrecord_membership_user_record_id_seq OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 229
-- Name: membershipuserrecord_membership_user_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.membershipuserrecord_membership_user_record_id_seq OWNED BY public.membershipuserrecord.membership_user_record_id;


--
-- TOC entry 231 (class 1259 OID 17055)
-- Name: trainerdisciplines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainerdisciplines (
    trainer_discipline_trainer_id integer NOT NULL,
    trainer_discipline_discipline_id integer NOT NULL
);


ALTER TABLE public.trainerdisciplines OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16976)
-- Name: trainers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainers (
    trainer_id integer NOT NULL,
    trainer_cedula character varying(10) NOT NULL,
    trainer_first_name character varying(50),
    trainer_last_name character varying(50),
    trainer_age integer,
    trainer_gender character(1),
    trainer_phone character varying(15),
    trainer_email character varying(100),
    trainer_address text,
    trainer_city character varying(100),
    trainer_main_discipline_id integer,
    trainer_hired_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.trainers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16975)
-- Name: trainers_trainer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trainers_trainer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trainers_trainer_id_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 221
-- Name: trainers_trainer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trainers_trainer_id_seq OWNED BY public.trainers.trainer_id;


--
-- TOC entry 224 (class 1259 OID 16995)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_cedula character varying(10) NOT NULL,
    user_first_name character varying(50),
    user_last_name character varying(50),
    user_phone character varying(15),
    user_email character varying(100),
    user_address text,
    user_age integer,
    user_gender character(1),
    user_profile_picture bytea,
    trainer_id integer,
    user_membership_status character varying(50),
    user_created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16994)
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
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4755 (class 2604 OID 17262)
-- Name: administration_users admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users ALTER COLUMN admin_id SET DEFAULT nextval('public.administration_users_admin_id_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 17248)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 4744 (class 2604 OID 17249)
-- Name: disciplines discipline_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines ALTER COLUMN discipline_id SET DEFAULT nextval('public.disciplines_discipline_id_seq'::regclass);


--
-- TOC entry 4754 (class 2604 OID 17250)
-- Name: exercises exercise_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises ALTER COLUMN exercise_id SET DEFAULT nextval('public.exercises_exercise_id_seq'::regclass);


--
-- TOC entry 4743 (class 2604 OID 17251)
-- Name: groups group_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN group_id SET DEFAULT nextval('public.groups_group_id_seq'::regclass);


--
-- TOC entry 4753 (class 2604 OID 17252)
-- Name: machines machine_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines ALTER COLUMN machine_id SET DEFAULT nextval('public.machines_machine_id_seq'::regclass);


--
-- TOC entry 4749 (class 2604 OID 17253)
-- Name: memberships membership_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships ALTER COLUMN membership_id SET DEFAULT nextval('public.memberships_membership_id_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 17254)
-- Name: membershipuser membership_user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser ALTER COLUMN membership_user_id SET DEFAULT nextval('public.membershipuser_membership_user_id_seq'::regclass);


--
-- TOC entry 4752 (class 2604 OID 17255)
-- Name: membershipuserrecord membership_user_record_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord ALTER COLUMN membership_user_record_id SET DEFAULT nextval('public.membershipuserrecord_membership_user_record_id_seq'::regclass);


--
-- TOC entry 4745 (class 2604 OID 17256)
-- Name: trainers trainer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers ALTER COLUMN trainer_id SET DEFAULT nextval('public.trainers_trainer_id_seq'::regclass);


--
-- TOC entry 4747 (class 2604 OID 17257)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5003 (class 0 OID 17259)
-- Dependencies: 243
-- Data for Name: administration_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administration_users (admin_id, admin_name, admin_username, admin_email, admin_password, admin_created_at, admin_role) FROM stdin;
\.


--
-- TOC entry 4976 (class 0 OID 16944)
-- Dependencies: 216
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name, category_description) FROM stdin;
1	Strength	Strength training exercises
2	Cardio	Cardiovascular exercises
\.


--
-- TOC entry 4980 (class 0 OID 16962)
-- Dependencies: 220
-- Data for Name: disciplines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplines (discipline_id, discipline_name, discipline_description, discipline_category_id) FROM stdin;
1	Bodybuilding	Bodybuilding exercises	1
2	Powerlifting	Powerlifting exercises	1
3	Cardio Training	Cardio exercises	2
\.


--
-- TOC entry 4997 (class 0 OID 17131)
-- Dependencies: 237
-- Data for Name: exercisecategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercisecategory (exercise_category_exercise_id, exercise_category_category_id) FROM stdin;
\.


--
-- TOC entry 4996 (class 0 OID 17116)
-- Dependencies: 236
-- Data for Name: exercisegroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercisegroup (exercise_group_exercise_id, exercise_group_group_id) FROM stdin;
\.


--
-- TOC entry 4998 (class 0 OID 17146)
-- Dependencies: 238
-- Data for Name: exercisemachine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercisemachine (exercise_machine_exercise_id, exercise_machine_machine_id) FROM stdin;
\.


--
-- TOC entry 4995 (class 0 OID 17093)
-- Dependencies: 235
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (exercise_id, exercise_name, exercise_description, exercise_discipline_id, exercise_recommendations, exercise_group_id, exercise_category_id) FROM stdin;
9	Bench Press	Upper body strength exercise	1	Use spotter	1	1
\.


--
-- TOC entry 4978 (class 0 OID 16953)
-- Dependencies: 218
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (group_id, group_name, group_description, group_recommendations) FROM stdin;
1	Upper Body	Exercises for the upper body	\N
2	Lower Body	Exercises for the lower body	\N
\.


--
-- TOC entry 4999 (class 0 OID 17161)
-- Dependencies: 239
-- Data for Name: machinecategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machinecategory (machine_category_machine_id, machine_category_category_id) FROM stdin;
\.


--
-- TOC entry 5001 (class 0 OID 17191)
-- Dependencies: 241
-- Data for Name: machinediscipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machinediscipline (machine_discipline_machine_id, machine_discipline_discipline_id) FROM stdin;
\.


--
-- TOC entry 5000 (class 0 OID 17176)
-- Dependencies: 240
-- Data for Name: machinegroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machinegroup (machine_group_machine_id, machine_group_group_id) FROM stdin;
\.


--
-- TOC entry 4993 (class 0 OID 17071)
-- Dependencies: 233
-- Data for Name: machines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machines (machine_id, machine_name, machine_acquired_at, machine_category_id, machine_group_id, machine_discipline_id) FROM stdin;
3	Treadmill	2022-01-01	1	1	1
\.


--
-- TOC entry 4986 (class 0 OID 17014)
-- Dependencies: 226
-- Data for Name: memberships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.memberships (membership_id, membership_name, membership_price, membership_type, membership_created_at, membership_status, membership_duration) FROM stdin;
1	Gold	59.99	Annual	2024-06-19 12:32:17.744119	Inactive	365
\.


--
-- TOC entry 4988 (class 0 OID 17022)
-- Dependencies: 228
-- Data for Name: membershipuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membershipuser (membership_user_id, membership_user_user_id, membership_user_membership_id, membership_user_status, membership_user_start_date, membership_user_end_date) FROM stdin;
\.


--
-- TOC entry 4990 (class 0 OID 17039)
-- Dependencies: 230
-- Data for Name: membershipuserrecord; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membershipuserrecord (membership_user_record_id, membership_user_record_user_id, membership_user_record_membership_id, membership_user_record_start_date, membership_user_record_end_date) FROM stdin;
\.


--
-- TOC entry 4991 (class 0 OID 17055)
-- Dependencies: 231
-- Data for Name: trainerdisciplines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trainerdisciplines (trainer_discipline_trainer_id, trainer_discipline_discipline_id) FROM stdin;
\.


--
-- TOC entry 4982 (class 0 OID 16976)
-- Dependencies: 222
-- Data for Name: trainers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trainers (trainer_id, trainer_cedula, trainer_first_name, trainer_last_name, trainer_age, trainer_gender, trainer_phone, trainer_email, trainer_address, trainer_city, trainer_main_discipline_id, trainer_hired_at) FROM stdin;
4	0987654321	Jane	Smith	28	F	555-5678	jane.smith@example.com	456 Elm St	Metropolis	1	2024-06-30 14:08:20.492551
\.


--
-- TOC entry 4984 (class 0 OID 16995)
-- Dependencies: 224
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_cedula, user_first_name, user_last_name, user_phone, user_email, user_address, user_age, user_gender, user_profile_picture, trainer_id, user_membership_status, user_created_at) FROM stdin;
\.


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 242
-- Name: administration_users_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administration_users_admin_id_seq', 1, false);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 215
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 2, true);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 219
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.disciplines_discipline_id_seq', 3, true);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 234
-- Name: exercises_exercise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercises_exercise_id_seq', 9, true);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 217
-- Name: groups_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_group_id_seq', 2, true);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 232
-- Name: machines_machine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machines_machine_id_seq', 3, true);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 225
-- Name: memberships_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.memberships_membership_id_seq', 1, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 227
-- Name: membershipuser_membership_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membershipuser_membership_user_id_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 229
-- Name: membershipuserrecord_membership_user_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membershipuserrecord_membership_user_record_id_seq', 1, false);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 221
-- Name: trainers_trainer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trainers_trainer_id_seq', 4, true);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 13, true);


--
-- TOC entry 4800 (class 2606 OID 17269)
-- Name: administration_users administration_users_admin_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users
    ADD CONSTRAINT administration_users_admin_email_key UNIQUE (admin_email);


--
-- TOC entry 4802 (class 2606 OID 17267)
-- Name: administration_users administration_users_admin_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users
    ADD CONSTRAINT administration_users_admin_username_key UNIQUE (admin_username);


--
-- TOC entry 4804 (class 2606 OID 17265)
-- Name: administration_users administration_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users
    ADD CONSTRAINT administration_users_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 4758 (class 2606 OID 16951)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4762 (class 2606 OID 16969)
-- Name: disciplines disciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_pkey PRIMARY KEY (discipline_id);


--
-- TOC entry 4790 (class 2606 OID 17135)
-- Name: exercisecategory exercisecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_pkey PRIMARY KEY (exercise_category_exercise_id, exercise_category_category_id);


--
-- TOC entry 4788 (class 2606 OID 17120)
-- Name: exercisegroup exercisegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_pkey PRIMARY KEY (exercise_group_exercise_id, exercise_group_group_id);


--
-- TOC entry 4792 (class 2606 OID 17150)
-- Name: exercisemachine exercisemachine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_pkey PRIMARY KEY (exercise_machine_exercise_id, exercise_machine_machine_id);


--
-- TOC entry 4786 (class 2606 OID 17100)
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (exercise_id);


--
-- TOC entry 4760 (class 2606 OID 16960)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_id);


--
-- TOC entry 4794 (class 2606 OID 17165)
-- Name: machinecategory machinecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_pkey PRIMARY KEY (machine_category_machine_id, machine_category_category_id);


--
-- TOC entry 4798 (class 2606 OID 17195)
-- Name: machinediscipline machinediscipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_pkey PRIMARY KEY (machine_discipline_machine_id, machine_discipline_discipline_id);


--
-- TOC entry 4796 (class 2606 OID 17180)
-- Name: machinegroup machinegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_pkey PRIMARY KEY (machine_group_machine_id, machine_group_group_id);


--
-- TOC entry 4784 (class 2606 OID 17076)
-- Name: machines machines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_pkey PRIMARY KEY (machine_id);


--
-- TOC entry 4776 (class 2606 OID 17020)
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (membership_id);


--
-- TOC entry 4778 (class 2606 OID 17027)
-- Name: membershipuser membershipuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_pkey PRIMARY KEY (membership_user_id);


--
-- TOC entry 4780 (class 2606 OID 17044)
-- Name: membershipuserrecord membershipuserrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_pkey PRIMARY KEY (membership_user_record_id);


--
-- TOC entry 4782 (class 2606 OID 17059)
-- Name: trainerdisciplines trainerdisciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_pkey PRIMARY KEY (trainer_discipline_trainer_id, trainer_discipline_discipline_id);


--
-- TOC entry 4764 (class 2606 OID 16984)
-- Name: trainers trainers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_pkey PRIMARY KEY (trainer_id);


--
-- TOC entry 4766 (class 2606 OID 16986)
-- Name: trainers trainers_trainer_cedula_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_cedula_key UNIQUE (trainer_cedula);


--
-- TOC entry 4768 (class 2606 OID 16988)
-- Name: trainers trainers_trainer_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_email_key UNIQUE (trainer_email);


--
-- TOC entry 4770 (class 2606 OID 17003)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4772 (class 2606 OID 17005)
-- Name: users users_user_cedula_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_cedula_key UNIQUE (user_cedula);


--
-- TOC entry 4774 (class 2606 OID 17007)
-- Name: users users_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_email_key UNIQUE (user_email);


--
-- TOC entry 4805 (class 2606 OID 16970)
-- Name: disciplines disciplines_discipline_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_discipline_category_id_fkey FOREIGN KEY (discipline_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4822 (class 2606 OID 17141)
-- Name: exercisecategory exercisecategory_exercise_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_exercise_category_category_id_fkey FOREIGN KEY (exercise_category_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4823 (class 2606 OID 17136)
-- Name: exercisecategory exercisecategory_exercise_category_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_exercise_category_exercise_id_fkey FOREIGN KEY (exercise_category_exercise_id) REFERENCES public.exercises(exercise_id);


--
-- TOC entry 4820 (class 2606 OID 17121)
-- Name: exercisegroup exercisegroup_exercise_group_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_exercise_group_exercise_id_fkey FOREIGN KEY (exercise_group_exercise_id) REFERENCES public.exercises(exercise_id);


--
-- TOC entry 4821 (class 2606 OID 17126)
-- Name: exercisegroup exercisegroup_exercise_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_exercise_group_group_id_fkey FOREIGN KEY (exercise_group_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4824 (class 2606 OID 17151)
-- Name: exercisemachine exercisemachine_exercise_machine_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_exercise_machine_exercise_id_fkey FOREIGN KEY (exercise_machine_exercise_id) REFERENCES public.exercises(exercise_id);


--
-- TOC entry 4825 (class 2606 OID 17156)
-- Name: exercisemachine exercisemachine_exercise_machine_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_exercise_machine_machine_id_fkey FOREIGN KEY (exercise_machine_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4817 (class 2606 OID 17111)
-- Name: exercises exercises_exercise_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_category_id_fkey FOREIGN KEY (exercise_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4818 (class 2606 OID 17101)
-- Name: exercises exercises_exercise_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_discipline_id_fkey FOREIGN KEY (exercise_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4819 (class 2606 OID 17106)
-- Name: exercises exercises_exercise_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_group_id_fkey FOREIGN KEY (exercise_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4826 (class 2606 OID 17171)
-- Name: machinecategory machinecategory_machine_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_machine_category_category_id_fkey FOREIGN KEY (machine_category_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4827 (class 2606 OID 17166)
-- Name: machinecategory machinecategory_machine_category_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_machine_category_machine_id_fkey FOREIGN KEY (machine_category_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4830 (class 2606 OID 17201)
-- Name: machinediscipline machinediscipline_machine_discipline_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_machine_discipline_discipline_id_fkey FOREIGN KEY (machine_discipline_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4831 (class 2606 OID 17196)
-- Name: machinediscipline machinediscipline_machine_discipline_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_machine_discipline_machine_id_fkey FOREIGN KEY (machine_discipline_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4828 (class 2606 OID 17186)
-- Name: machinegroup machinegroup_machine_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_machine_group_group_id_fkey FOREIGN KEY (machine_group_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4829 (class 2606 OID 17181)
-- Name: machinegroup machinegroup_machine_group_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_machine_group_machine_id_fkey FOREIGN KEY (machine_group_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4814 (class 2606 OID 17077)
-- Name: machines machines_machine_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_category_id_fkey FOREIGN KEY (machine_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4815 (class 2606 OID 17087)
-- Name: machines machines_machine_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_discipline_id_fkey FOREIGN KEY (machine_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4816 (class 2606 OID 17082)
-- Name: machines machines_machine_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_group_id_fkey FOREIGN KEY (machine_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4808 (class 2606 OID 17033)
-- Name: membershipuser membershipuser_membership_user_membership_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_membership_user_membership_id_fkey FOREIGN KEY (membership_user_membership_id) REFERENCES public.memberships(membership_id);


--
-- TOC entry 4809 (class 2606 OID 17028)
-- Name: membershipuser membershipuser_membership_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_membership_user_user_id_fkey FOREIGN KEY (membership_user_user_id) REFERENCES public.users(user_id);


--
-- TOC entry 4810 (class 2606 OID 17050)
-- Name: membershipuserrecord membershipuserrecord_membership_user_record_membership_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_membership_user_record_membership_id_fkey FOREIGN KEY (membership_user_record_membership_id) REFERENCES public.memberships(membership_id);


--
-- TOC entry 4811 (class 2606 OID 17045)
-- Name: membershipuserrecord membershipuserrecord_membership_user_record_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_membership_user_record_user_id_fkey FOREIGN KEY (membership_user_record_user_id) REFERENCES public.users(user_id);


--
-- TOC entry 4812 (class 2606 OID 17065)
-- Name: trainerdisciplines trainerdisciplines_trainer_discipline_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_trainer_discipline_discipline_id_fkey FOREIGN KEY (trainer_discipline_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4813 (class 2606 OID 17060)
-- Name: trainerdisciplines trainerdisciplines_trainer_discipline_trainer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_trainer_discipline_trainer_id_fkey FOREIGN KEY (trainer_discipline_trainer_id) REFERENCES public.trainers(trainer_id);


--
-- TOC entry 4806 (class 2606 OID 16989)
-- Name: trainers trainers_trainer_main_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_main_discipline_id_fkey FOREIGN KEY (trainer_main_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4807 (class 2606 OID 17008)
-- Name: users users_trainer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainers(trainer_id);


-- Completed on 2024-06-30 21:05:24

--
-- PostgreSQL database dump complete
--

