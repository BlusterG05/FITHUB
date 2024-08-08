--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-08-07 21:16:47

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
-- TOC entry 245 (class 1255 OID 16399)
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
-- TOC entry 246 (class 1255 OID 16400)
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
-- TOC entry 248 (class 1255 OID 16401)
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
-- TOC entry 261 (class 1255 OID 16402)
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
-- TOC entry 262 (class 1255 OID 16403)
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
-- TOC entry 263 (class 1255 OID 16404)
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
-- TOC entry 264 (class 1255 OID 16405)
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
-- TOC entry 265 (class 1255 OID 16406)
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
-- TOC entry 266 (class 1255 OID 16407)
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
-- TOC entry 267 (class 1255 OID 16408)
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
-- TOC entry 268 (class 1255 OID 16409)
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
-- TOC entry 269 (class 1255 OID 16410)
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
-- TOC entry 270 (class 1255 OID 16411)
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
-- TOC entry 271 (class 1255 OID 16412)
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
-- TOC entry 272 (class 1255 OID 16413)
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
-- TOC entry 273 (class 1255 OID 16414)
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
-- TOC entry 253 (class 1255 OID 16415)
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
-- TOC entry 244 (class 1255 OID 16416)
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
-- TOC entry 274 (class 1255 OID 16417)
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
-- TOC entry 275 (class 1255 OID 16418)
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
-- TOC entry 276 (class 1255 OID 16419)
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
-- TOC entry 277 (class 1255 OID 16420)
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
-- TOC entry 278 (class 1255 OID 16421)
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
-- TOC entry 279 (class 1255 OID 16422)
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
-- TOC entry 280 (class 1255 OID 16423)
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
-- TOC entry 247 (class 1255 OID 16424)
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
-- TOC entry 281 (class 1255 OID 16425)
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
-- TOC entry 282 (class 1255 OID 16426)
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
-- TOC entry 283 (class 1255 OID 16427)
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
-- TOC entry 284 (class 1255 OID 16428)
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
-- TOC entry 215 (class 1259 OID 16429)
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
-- TOC entry 216 (class 1259 OID 16433)
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
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 216
-- Name: administration_users_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administration_users_admin_id_seq OWNED BY public.administration_users.admin_id;


--
-- TOC entry 217 (class 1259 OID 16434)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    category_description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16439)
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
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 218
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 219 (class 1259 OID 16440)
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
-- TOC entry 220 (class 1259 OID 16445)
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
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 220
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.disciplines_discipline_id_seq OWNED BY public.disciplines.discipline_id;


--
-- TOC entry 221 (class 1259 OID 16446)
-- Name: exercisecategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercisecategory (
    exercise_category_exercise_id integer NOT NULL,
    exercise_category_category_id integer NOT NULL
);


ALTER TABLE public.exercisecategory OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16449)
-- Name: exercisegroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercisegroup (
    exercise_group_exercise_id integer NOT NULL,
    exercise_group_group_id integer NOT NULL
);


ALTER TABLE public.exercisegroup OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16452)
-- Name: exercisemachine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercisemachine (
    exercise_machine_exercise_id integer NOT NULL,
    exercise_machine_machine_id integer NOT NULL
);


ALTER TABLE public.exercisemachine OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16455)
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
-- TOC entry 225 (class 1259 OID 16460)
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
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 225
-- Name: exercises_exercise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercises_exercise_id_seq OWNED BY public.exercises.exercise_id;


--
-- TOC entry 226 (class 1259 OID 16461)
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
-- TOC entry 227 (class 1259 OID 16466)
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
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 227
-- Name: groups_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_group_id_seq OWNED BY public.groups.group_id;


--
-- TOC entry 228 (class 1259 OID 16467)
-- Name: machinecategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machinecategory (
    machine_category_machine_id integer NOT NULL,
    machine_category_category_id integer NOT NULL
);


ALTER TABLE public.machinecategory OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16470)
-- Name: machinediscipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machinediscipline (
    machine_discipline_machine_id integer NOT NULL,
    machine_discipline_discipline_id integer NOT NULL
);


ALTER TABLE public.machinediscipline OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16473)
-- Name: machinegroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machinegroup (
    machine_group_machine_id integer NOT NULL,
    machine_group_group_id integer NOT NULL
);


ALTER TABLE public.machinegroup OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16476)
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
-- TOC entry 232 (class 1259 OID 16479)
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
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 232
-- Name: machines_machine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machines_machine_id_seq OWNED BY public.machines.machine_id;


--
-- TOC entry 233 (class 1259 OID 16480)
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
-- TOC entry 234 (class 1259 OID 16484)
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
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 234
-- Name: memberships_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.memberships_membership_id_seq OWNED BY public.memberships.membership_id;


--
-- TOC entry 235 (class 1259 OID 16485)
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
-- TOC entry 236 (class 1259 OID 16488)
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
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 236
-- Name: membershipuser_membership_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.membershipuser_membership_user_id_seq OWNED BY public.membershipuser.membership_user_id;


--
-- TOC entry 237 (class 1259 OID 16489)
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
-- TOC entry 238 (class 1259 OID 16492)
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
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 238
-- Name: membershipuserrecord_membership_user_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.membershipuserrecord_membership_user_record_id_seq OWNED BY public.membershipuserrecord.membership_user_record_id;


--
-- TOC entry 239 (class 1259 OID 16493)
-- Name: trainerdisciplines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainerdisciplines (
    trainer_discipline_trainer_id integer NOT NULL,
    trainer_discipline_discipline_id integer NOT NULL
);


ALTER TABLE public.trainerdisciplines OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16496)
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
-- TOC entry 241 (class 1259 OID 16502)
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
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 241
-- Name: trainers_trainer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trainers_trainer_id_seq OWNED BY public.trainers.trainer_id;


--
-- TOC entry 242 (class 1259 OID 16503)
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
-- TOC entry 243 (class 1259 OID 16509)
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
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 243
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4796 (class 2604 OID 16510)
-- Name: administration_users admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users ALTER COLUMN admin_id SET DEFAULT nextval('public.administration_users_admin_id_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 16511)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 16512)
-- Name: disciplines discipline_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines ALTER COLUMN discipline_id SET DEFAULT nextval('public.disciplines_discipline_id_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 16513)
-- Name: exercises exercise_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises ALTER COLUMN exercise_id SET DEFAULT nextval('public.exercises_exercise_id_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 16514)
-- Name: groups group_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN group_id SET DEFAULT nextval('public.groups_group_id_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 16515)
-- Name: machines machine_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines ALTER COLUMN machine_id SET DEFAULT nextval('public.machines_machine_id_seq'::regclass);


--
-- TOC entry 4803 (class 2604 OID 16516)
-- Name: memberships membership_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships ALTER COLUMN membership_id SET DEFAULT nextval('public.memberships_membership_id_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 16517)
-- Name: membershipuser membership_user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser ALTER COLUMN membership_user_id SET DEFAULT nextval('public.membershipuser_membership_user_id_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 16518)
-- Name: membershipuserrecord membership_user_record_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord ALTER COLUMN membership_user_record_id SET DEFAULT nextval('public.membershipuserrecord_membership_user_record_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 16519)
-- Name: trainers trainer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers ALTER COLUMN trainer_id SET DEFAULT nextval('public.trainers_trainer_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 16520)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5029 (class 0 OID 16429)
-- Dependencies: 215
-- Data for Name: administration_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administration_users (admin_id, admin_name, admin_username, admin_email, admin_password, admin_created_at, admin_role) FROM stdin;
1	Jeremy Collaguazo	JeryCohe05	jerycohe05@gmail.com	$2a$12$eGmrFLfkD1EC0XYUOWp4nuPDcNufHEUeYLJiqh3P5Bp7VyVgXQlw2	2024-07-15 21:37:01.679125	Admin
2	Samir	Samir Cohe	allusiveaunt@gmail.com	$2a$12$OGoIzp/0fm/dYSEacKjm0.8niQEXAQn8zwyEvV35XmJJEe8VCHNRa	2024-07-15 22:19:18.243611	User
6	Carlitos	Carlitos23	calitos@gmail.com	$2b$12$bc3wr0101iUc.pJSPUh1nOgWdaqJ2HT/pqR24CHRpppLVlj3n.DcS	2024-07-15 22:35:04.721979	User
7	Jose	joselito	joselito_elpro@gmial.com	$2b$12$uElZUtdq.N3T2mPr.C/Y0uXDXmZEaqTyPebT.l35r02mgWATgbU22	2024-07-15 23:11:03.163382	Usuario
22	john	Jhon Pro	jhoncito_33@gmail.com	$2b$12$v1ayg/D0nz7nv6OcYR4bv.bBYW.asrTccOlJLzI34jyY.0IXJgKtW	2024-07-15 23:24:56.854775	Usuario
24	Johan	JohanCohe	johancohe05@gmail.com	$2b$12$tnkGV1i3vjjVELPN8g6OL.MVLRqphPFfwvoE.Pt7yWNmcmKipdDWa	2024-07-17 23:05:02.848567	Usuario
25	Jeremy Johan Collaguazo/Herrera	jjcollaguazo	jjcollaguazo@pucesd.edu.ec	$2b$12$.6RcNwM4jgHMgHA7dPDprufRaoeTGeshFGwuwjdP.lh3488WKI4jy	2024-07-19 23:42:39.584261	Usuario
26	Samir Xaolo Colla	samirxaolo	samirxaolo@gmail.com	$2b$12$P2SBULYB3C0QCHwCOJoaHOCw75iyNxI2EwVE7LAZrLz1GDyuR1rDa	2024-08-06 22:03:43.834443	Usuario
\.


--
-- TOC entry 5031 (class 0 OID 16434)
-- Dependencies: 217
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name, category_description) FROM stdin;
1	Strength	Strength training exercises
2	Cardio	Cardiovascular exercises
\.


--
-- TOC entry 5033 (class 0 OID 16440)
-- Dependencies: 219
-- Data for Name: disciplines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplines (discipline_id, discipline_name, discipline_description, discipline_category_id) FROM stdin;
1	Bodybuilding	Bodybuilding exercises	1
2	Powerlifting	Powerlifting exercises	1
3	Cardio Training	Cardio exercises	2
\.


--
-- TOC entry 5035 (class 0 OID 16446)
-- Dependencies: 221
-- Data for Name: exercisecategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercisecategory (exercise_category_exercise_id, exercise_category_category_id) FROM stdin;
\.


--
-- TOC entry 5036 (class 0 OID 16449)
-- Dependencies: 222
-- Data for Name: exercisegroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercisegroup (exercise_group_exercise_id, exercise_group_group_id) FROM stdin;
\.


--
-- TOC entry 5037 (class 0 OID 16452)
-- Dependencies: 223
-- Data for Name: exercisemachine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercisemachine (exercise_machine_exercise_id, exercise_machine_machine_id) FROM stdin;
\.


--
-- TOC entry 5038 (class 0 OID 16455)
-- Dependencies: 224
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (exercise_id, exercise_name, exercise_description, exercise_discipline_id, exercise_recommendations, exercise_group_id, exercise_category_id) FROM stdin;
9	Bench Press	Upper body strength exercise	1	Use spotter	1	1
10	Squat	Lower body strength exercise	1	Maintain proper form to avoid injury	2	1
12	Deadlift	Full body strength exercise	1	Keep back straight and lift with legs	2	1
13	Pull-Up	Upper body strength exercise	1	Use full range of motion	1	1
\.


--
-- TOC entry 5040 (class 0 OID 16461)
-- Dependencies: 226
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (group_id, group_name, group_description, group_recommendations) FROM stdin;
1	Upper Body	Exercises for the upper body	\N
2	Lower Body	Exercises for the lower body	\N
\.


--
-- TOC entry 5042 (class 0 OID 16467)
-- Dependencies: 228
-- Data for Name: machinecategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machinecategory (machine_category_machine_id, machine_category_category_id) FROM stdin;
\.


--
-- TOC entry 5043 (class 0 OID 16470)
-- Dependencies: 229
-- Data for Name: machinediscipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machinediscipline (machine_discipline_machine_id, machine_discipline_discipline_id) FROM stdin;
\.


--
-- TOC entry 5044 (class 0 OID 16473)
-- Dependencies: 230
-- Data for Name: machinegroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machinegroup (machine_group_machine_id, machine_group_group_id) FROM stdin;
\.


--
-- TOC entry 5045 (class 0 OID 16476)
-- Dependencies: 231
-- Data for Name: machines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machines (machine_id, machine_name, machine_acquired_at, machine_category_id, machine_group_id, machine_discipline_id) FROM stdin;
3	Treadmill	2022-01-01	1	1	1
\.


--
-- TOC entry 5047 (class 0 OID 16480)
-- Dependencies: 233
-- Data for Name: memberships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.memberships (membership_id, membership_name, membership_price, membership_type, membership_created_at, membership_status, membership_duration) FROM stdin;
1	Gold	59.99	Annual	2024-06-19 12:32:17.744119	Inactive	365
\.


--
-- TOC entry 5049 (class 0 OID 16485)
-- Dependencies: 235
-- Data for Name: membershipuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membershipuser (membership_user_id, membership_user_user_id, membership_user_membership_id, membership_user_status, membership_user_start_date, membership_user_end_date) FROM stdin;
\.


--
-- TOC entry 5051 (class 0 OID 16489)
-- Dependencies: 237
-- Data for Name: membershipuserrecord; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membershipuserrecord (membership_user_record_id, membership_user_record_user_id, membership_user_record_membership_id, membership_user_record_start_date, membership_user_record_end_date) FROM stdin;
\.


--
-- TOC entry 5053 (class 0 OID 16493)
-- Dependencies: 239
-- Data for Name: trainerdisciplines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trainerdisciplines (trainer_discipline_trainer_id, trainer_discipline_discipline_id) FROM stdin;
\.


--
-- TOC entry 5054 (class 0 OID 16496)
-- Dependencies: 240
-- Data for Name: trainers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trainers (trainer_id, trainer_cedula, trainer_first_name, trainer_last_name, trainer_age, trainer_gender, trainer_phone, trainer_email, trainer_address, trainer_city, trainer_main_discipline_id, trainer_hired_at) FROM stdin;
4	0987654321	Jane	Smith	28	F	555-5678	jane.smith@example.com	456 Elm St	Metropolis	1	2024-06-30 14:08:20.492551
\.


--
-- TOC entry 5056 (class 0 OID 16503)
-- Dependencies: 242
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_cedula, user_first_name, user_last_name, user_phone, user_email, user_address, user_age, user_gender, user_profile_picture, trainer_id, user_membership_status, user_created_at) FROM stdin;
\.


--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 216
-- Name: administration_users_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administration_users_admin_id_seq', 26, true);


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 218
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 2, true);


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 220
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.disciplines_discipline_id_seq', 3, true);


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 225
-- Name: exercises_exercise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercises_exercise_id_seq', 13, true);


--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 227
-- Name: groups_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_group_id_seq', 2, true);


--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 232
-- Name: machines_machine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machines_machine_id_seq', 3, true);


--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 234
-- Name: memberships_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.memberships_membership_id_seq', 1, true);


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 236
-- Name: membershipuser_membership_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membershipuser_membership_user_id_seq', 1, false);


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 238
-- Name: membershipuserrecord_membership_user_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membershipuserrecord_membership_user_record_id_seq', 1, false);


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 241
-- Name: trainers_trainer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trainers_trainer_id_seq', 4, true);


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 243
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 13, true);


--
-- TOC entry 4812 (class 2606 OID 16522)
-- Name: administration_users administration_users_admin_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users
    ADD CONSTRAINT administration_users_admin_email_key UNIQUE (admin_email);


--
-- TOC entry 4814 (class 2606 OID 16524)
-- Name: administration_users administration_users_admin_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users
    ADD CONSTRAINT administration_users_admin_username_key UNIQUE (admin_username);


--
-- TOC entry 4816 (class 2606 OID 16526)
-- Name: administration_users administration_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administration_users
    ADD CONSTRAINT administration_users_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 4818 (class 2606 OID 16528)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4820 (class 2606 OID 16530)
-- Name: disciplines disciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_pkey PRIMARY KEY (discipline_id);


--
-- TOC entry 4822 (class 2606 OID 16532)
-- Name: exercisecategory exercisecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_pkey PRIMARY KEY (exercise_category_exercise_id, exercise_category_category_id);


--
-- TOC entry 4824 (class 2606 OID 16534)
-- Name: exercisegroup exercisegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_pkey PRIMARY KEY (exercise_group_exercise_id, exercise_group_group_id);


--
-- TOC entry 4826 (class 2606 OID 16536)
-- Name: exercisemachine exercisemachine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_pkey PRIMARY KEY (exercise_machine_exercise_id, exercise_machine_machine_id);


--
-- TOC entry 4828 (class 2606 OID 16538)
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (exercise_id);


--
-- TOC entry 4830 (class 2606 OID 16540)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_id);


--
-- TOC entry 4832 (class 2606 OID 16542)
-- Name: machinecategory machinecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_pkey PRIMARY KEY (machine_category_machine_id, machine_category_category_id);


--
-- TOC entry 4834 (class 2606 OID 16544)
-- Name: machinediscipline machinediscipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_pkey PRIMARY KEY (machine_discipline_machine_id, machine_discipline_discipline_id);


--
-- TOC entry 4836 (class 2606 OID 16546)
-- Name: machinegroup machinegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_pkey PRIMARY KEY (machine_group_machine_id, machine_group_group_id);


--
-- TOC entry 4838 (class 2606 OID 16548)
-- Name: machines machines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_pkey PRIMARY KEY (machine_id);


--
-- TOC entry 4840 (class 2606 OID 16550)
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (membership_id);


--
-- TOC entry 4842 (class 2606 OID 16552)
-- Name: membershipuser membershipuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_pkey PRIMARY KEY (membership_user_id);


--
-- TOC entry 4844 (class 2606 OID 16554)
-- Name: membershipuserrecord membershipuserrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_pkey PRIMARY KEY (membership_user_record_id);


--
-- TOC entry 4846 (class 2606 OID 16556)
-- Name: trainerdisciplines trainerdisciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_pkey PRIMARY KEY (trainer_discipline_trainer_id, trainer_discipline_discipline_id);


--
-- TOC entry 4848 (class 2606 OID 16558)
-- Name: trainers trainers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_pkey PRIMARY KEY (trainer_id);


--
-- TOC entry 4850 (class 2606 OID 16560)
-- Name: trainers trainers_trainer_cedula_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_cedula_key UNIQUE (trainer_cedula);


--
-- TOC entry 4852 (class 2606 OID 16562)
-- Name: trainers trainers_trainer_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_email_key UNIQUE (trainer_email);


--
-- TOC entry 4854 (class 2606 OID 16564)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4856 (class 2606 OID 16566)
-- Name: users users_user_cedula_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_cedula_key UNIQUE (user_cedula);


--
-- TOC entry 4858 (class 2606 OID 16568)
-- Name: users users_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_email_key UNIQUE (user_email);


--
-- TOC entry 4859 (class 2606 OID 16569)
-- Name: disciplines disciplines_discipline_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_discipline_category_id_fkey FOREIGN KEY (discipline_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4860 (class 2606 OID 16574)
-- Name: exercisecategory exercisecategory_exercise_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_exercise_category_category_id_fkey FOREIGN KEY (exercise_category_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4861 (class 2606 OID 16579)
-- Name: exercisecategory exercisecategory_exercise_category_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_exercise_category_exercise_id_fkey FOREIGN KEY (exercise_category_exercise_id) REFERENCES public.exercises(exercise_id);


--
-- TOC entry 4862 (class 2606 OID 16584)
-- Name: exercisegroup exercisegroup_exercise_group_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_exercise_group_exercise_id_fkey FOREIGN KEY (exercise_group_exercise_id) REFERENCES public.exercises(exercise_id);


--
-- TOC entry 4863 (class 2606 OID 16589)
-- Name: exercisegroup exercisegroup_exercise_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_exercise_group_group_id_fkey FOREIGN KEY (exercise_group_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4864 (class 2606 OID 16594)
-- Name: exercisemachine exercisemachine_exercise_machine_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_exercise_machine_exercise_id_fkey FOREIGN KEY (exercise_machine_exercise_id) REFERENCES public.exercises(exercise_id);


--
-- TOC entry 4865 (class 2606 OID 16599)
-- Name: exercisemachine exercisemachine_exercise_machine_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_exercise_machine_machine_id_fkey FOREIGN KEY (exercise_machine_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4866 (class 2606 OID 16604)
-- Name: exercises exercises_exercise_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_category_id_fkey FOREIGN KEY (exercise_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4867 (class 2606 OID 16609)
-- Name: exercises exercises_exercise_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_discipline_id_fkey FOREIGN KEY (exercise_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4868 (class 2606 OID 16614)
-- Name: exercises exercises_exercise_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_group_id_fkey FOREIGN KEY (exercise_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4869 (class 2606 OID 16619)
-- Name: machinecategory machinecategory_machine_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_machine_category_category_id_fkey FOREIGN KEY (machine_category_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4870 (class 2606 OID 16624)
-- Name: machinecategory machinecategory_machine_category_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_machine_category_machine_id_fkey FOREIGN KEY (machine_category_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4871 (class 2606 OID 16629)
-- Name: machinediscipline machinediscipline_machine_discipline_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_machine_discipline_discipline_id_fkey FOREIGN KEY (machine_discipline_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4872 (class 2606 OID 16634)
-- Name: machinediscipline machinediscipline_machine_discipline_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_machine_discipline_machine_id_fkey FOREIGN KEY (machine_discipline_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4873 (class 2606 OID 16639)
-- Name: machinegroup machinegroup_machine_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_machine_group_group_id_fkey FOREIGN KEY (machine_group_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4874 (class 2606 OID 16644)
-- Name: machinegroup machinegroup_machine_group_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_machine_group_machine_id_fkey FOREIGN KEY (machine_group_machine_id) REFERENCES public.machines(machine_id);


--
-- TOC entry 4875 (class 2606 OID 16649)
-- Name: machines machines_machine_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_category_id_fkey FOREIGN KEY (machine_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4876 (class 2606 OID 16654)
-- Name: machines machines_machine_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_discipline_id_fkey FOREIGN KEY (machine_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4877 (class 2606 OID 16659)
-- Name: machines machines_machine_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_group_id_fkey FOREIGN KEY (machine_group_id) REFERENCES public.groups(group_id);


--
-- TOC entry 4878 (class 2606 OID 16664)
-- Name: membershipuser membershipuser_membership_user_membership_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_membership_user_membership_id_fkey FOREIGN KEY (membership_user_membership_id) REFERENCES public.memberships(membership_id);


--
-- TOC entry 4879 (class 2606 OID 16669)
-- Name: membershipuser membershipuser_membership_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_membership_user_user_id_fkey FOREIGN KEY (membership_user_user_id) REFERENCES public.users(user_id);


--
-- TOC entry 4880 (class 2606 OID 16674)
-- Name: membershipuserrecord membershipuserrecord_membership_user_record_membership_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_membership_user_record_membership_id_fkey FOREIGN KEY (membership_user_record_membership_id) REFERENCES public.memberships(membership_id);


--
-- TOC entry 4881 (class 2606 OID 16679)
-- Name: membershipuserrecord membershipuserrecord_membership_user_record_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_membership_user_record_user_id_fkey FOREIGN KEY (membership_user_record_user_id) REFERENCES public.users(user_id);


--
-- TOC entry 4882 (class 2606 OID 16684)
-- Name: trainerdisciplines trainerdisciplines_trainer_discipline_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_trainer_discipline_discipline_id_fkey FOREIGN KEY (trainer_discipline_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4883 (class 2606 OID 16689)
-- Name: trainerdisciplines trainerdisciplines_trainer_discipline_trainer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_trainer_discipline_trainer_id_fkey FOREIGN KEY (trainer_discipline_trainer_id) REFERENCES public.trainers(trainer_id);


--
-- TOC entry 4884 (class 2606 OID 16694)
-- Name: trainers trainers_trainer_main_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_main_discipline_id_fkey FOREIGN KEY (trainer_main_discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 4885 (class 2606 OID 16699)
-- Name: users users_trainer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainers(trainer_id);


-- Completed on 2024-08-07 21:16:47

--
-- PostgreSQL database dump complete
--

