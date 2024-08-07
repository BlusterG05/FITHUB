PGDMP  5        
            |            fithub    16.3    16.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16397    fithub    DATABASE     {   CREATE DATABASE fithub WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Ecuador.1252';
    DROP DATABASE fithub;
                postgres    false                       1255    16981 I   create_exercise(character varying, text, integer, text, integer, integer)    FUNCTION     �  CREATE FUNCTION public.create_exercise(p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer) RETURNS void
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
 �   DROP FUNCTION public.create_exercise(p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer);
       public          postgres    false                       1255    16957 B   create_machine(character varying, date, integer, integer, integer)    FUNCTION     I  CREATE FUNCTION public.create_machine(machine_name character varying, machine_acquired_at date, machine_category_id integer, machine_group_id integer, machine_discipline_id integer) RETURNS void
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
 �   DROP FUNCTION public.create_machine(machine_name character varying, machine_acquired_at date, machine_category_id integer, machine_group_id integer, machine_discipline_id integer);
       public          postgres    false                       1255    16969 \   create_membership(character varying, numeric, character varying, character varying, integer)    FUNCTION     b  CREATE FUNCTION public.create_membership(p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer) RETURNS void
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
 �   DROP FUNCTION public.create_membership(p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer);
       public          postgres    false                       1255    16954 �   create_trainer(character varying, character varying, character varying, integer, character, character varying, character varying, text, character varying, integer)    FUNCTION     8  CREATE FUNCTION public.create_trainer(trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer) RETURNS void
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
 ]  DROP FUNCTION public.create_trainer(trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer);
       public          postgres    false                        1255    16948 �   create_user(character varying, character varying, character varying, character varying, character varying, text, integer, character, bytea, integer, character varying)    FUNCTION     	  CREATE FUNCTION public.create_user(user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying) RETURNS void
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
 X  DROP FUNCTION public.create_user(user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying);
       public          postgres    false                       1255    16993    delete_exercise(integer)    FUNCTION     �   CREATE FUNCTION public.delete_exercise(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM Exercises WHERE exercise_id = p_id;
END;
$$;
 4   DROP FUNCTION public.delete_exercise(p_id integer);
       public          postgres    false                       1255    16958    delete_machine(integer)    FUNCTION     �  CREATE FUNCTION public.delete_machine(machine_delete_id integer) RETURNS void
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
 @   DROP FUNCTION public.delete_machine(machine_delete_id integer);
       public          postgres    false                       1255    16973    delete_membership(integer)    FUNCTION     �  CREATE FUNCTION public.delete_membership(p_membership_id integer) RETURNS void
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
 A   DROP FUNCTION public.delete_membership(p_membership_id integer);
       public          postgres    false                       1255    16992 !   delete_trainer(character varying)    FUNCTION     �  CREATE FUNCTION public.delete_trainer(p_trainer_cedula character varying) RETURNS void
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
 I   DROP FUNCTION public.delete_trainer(p_trainer_cedula character varying);
       public          postgres    false                       1255    16949    delete_user(character varying)    FUNCTION     �  CREATE FUNCTION public.delete_user(user_cedula_serch character varying) RETURNS void
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
 G   DROP FUNCTION public.delete_user(user_cedula_serch character varying);
       public          postgres    false                       1255    16991 P   edit_exercise(integer, character varying, text, integer, text, integer, integer)    FUNCTION     �  CREATE FUNCTION public.edit_exercise(p_exercise_id integer, p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer) RETURNS void
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
 �   DROP FUNCTION public.edit_exercise(p_exercise_id integer, p_exercise_name character varying, p_exercise_description text, p_exercise_discipline_id integer, p_exercise_recommendations text, p_exercise_group_id integer, p_exercise_category_id integer);
       public          postgres    false                       1255    16990 I   edit_machine(integer, character varying, date, integer, integer, integer)    FUNCTION     2  CREATE FUNCTION public.edit_machine(p_machine_id integer, p_machine_name character varying, p_machine_acquired_at date, p_machine_category_id integer, p_machine_group_id integer, p_machine_discipline_id integer) RETURNS void
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
 �   DROP FUNCTION public.edit_machine(p_machine_id integer, p_machine_name character varying, p_machine_acquired_at date, p_machine_category_id integer, p_machine_group_id integer, p_machine_discipline_id integer);
       public          postgres    false                       1255    16989 c   edit_membership(integer, character varying, numeric, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION public.edit_membership(p_membership_id integer, p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer) RETURNS void
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
 �   DROP FUNCTION public.edit_membership(p_membership_id integer, p_membership_name character varying, p_membership_price numeric, p_membership_type character varying, p_membership_status character varying, p_membership_duration integer);
       public          postgres    false                       1255    16988 �   edit_trainer(character varying, character varying, character varying, integer, character, character varying, character varying, text, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.edit_trainer(p_trainer_cedula character varying, p_trainer_first_name character varying, p_trainer_last_name character varying, p_trainer_age integer, p_trainer_gender character, p_trainer_phone character varying, p_trainer_email character varying, p_trainer_address text, p_trainer_city character varying, p_trainer_main_discipline_id integer) RETURNS void
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
 o  DROP FUNCTION public.edit_trainer(p_trainer_cedula character varying, p_trainer_first_name character varying, p_trainer_last_name character varying, p_trainer_age integer, p_trainer_gender character, p_trainer_phone character varying, p_trainer_email character varying, p_trainer_address text, p_trainer_city character varying, p_trainer_main_discipline_id integer);
       public          postgres    false                       1255    16987 �   edit_user(character varying, character varying, character varying, character varying, character varying, text, integer, character, bytea, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.edit_user(p_user_cedula character varying, p_user_first_name character varying, p_user_last_name character varying, p_user_phone character varying, p_user_email character varying, p_user_address text, p_user_age integer, p_user_gender character, p_user_profile_picture bytea, p_trainer_id integer, p_user_membership_status character varying) RETURNS void
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
 l  DROP FUNCTION public.edit_user(p_user_cedula character varying, p_user_first_name character varying, p_user_last_name character varying, p_user_phone character varying, p_user_email character varying, p_user_address text, p_user_age integer, p_user_gender character, p_user_profile_picture bytea, p_trainer_id integer, p_user_membership_status character varying);
       public          postgres    false                       1255    16983    get_all_exercises()    FUNCTION     �  CREATE FUNCTION public.get_all_exercises() RETURNS TABLE(exercise_id integer, exercise_name character varying, exercise_description text, exercise_discipline_name character varying, exercise_group_name character varying, exercise_category_name character varying, exercise_recommendations text)
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
 *   DROP FUNCTION public.get_all_exercises();
       public          postgres    false            
           1255    16960    get_all_machines()    FUNCTION     L  CREATE FUNCTION public.get_all_machines() RETURNS TABLE(machine_id integer, machine_name character varying, machine_acquired_at date, machine_category_name character varying, machine_group_name character varying, machine_discipline_name character varying)
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
 )   DROP FUNCTION public.get_all_machines();
       public          postgres    false                       1255    16971    get_all_memberships()    FUNCTION     �  CREATE FUNCTION public.get_all_memberships() RETURNS TABLE(membership_id integer, membership_name character varying, membership_price numeric, membership_type character varying, membership_status character varying, membership_duration integer, membership_created_at timestamp without time zone)
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
 ,   DROP FUNCTION public.get_all_memberships();
       public          postgres    false                       1255    16952    get_all_trainers()    FUNCTION       CREATE FUNCTION public.get_all_trainers() RETURNS TABLE(trainer_id integer, trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer, trainer_hired_at timestamp without time zone)
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
 )   DROP FUNCTION public.get_all_trainers();
       public          postgres    false            �            1255    16946    get_all_users()    FUNCTION       CREATE FUNCTION public.get_all_users() RETURNS TABLE(user_id integer, user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying, user_created_at timestamp without time zone)
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
 &   DROP FUNCTION public.get_all_users();
       public          postgres    false                       1255    16984    get_exercise_byid(integer)    FUNCTION     �  CREATE FUNCTION public.get_exercise_byid(p_exercise_id integer) RETURNS TABLE(exercise_id integer, exercise_name character varying, exercise_description text, exercise_discipline_name character varying, exercise_group_name character varying, exercise_category_name character varying, exercise_recommendations text)
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
 ?   DROP FUNCTION public.get_exercise_byid(p_exercise_id integer);
       public          postgres    false                       1255    16982    get_exercises(integer)    FUNCTION     �  CREATE FUNCTION public.get_exercises(p_limit integer) RETURNS TABLE(exercise_id integer, exercise_name character varying, exercise_description text, exercise_discipline_name character varying, exercise_group_name character varying, exercise_category_name character varying, exercise_recommendations text)
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
 5   DROP FUNCTION public.get_exercises(p_limit integer);
       public          postgres    false                       1255    16962    get_machine_byid(integer)    FUNCTION     �  CREATE FUNCTION public.get_machine_byid(machine_serch_id integer) RETURNS TABLE(machine_id integer, machine_name character varying, machine_acquired_at date, machine_category_name character varying, machine_group_name character varying, machine_discipline_name character varying)
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
 A   DROP FUNCTION public.get_machine_byid(machine_serch_id integer);
       public          postgres    false            	           1255    16961    get_machines(integer)    FUNCTION     i  CREATE FUNCTION public.get_machines(p_limit integer) RETURNS TABLE(machine_id integer, machine_name character varying, machine_acquired_at date, machine_category_name character varying, machine_group_name character varying, machine_discipline_name character varying)
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
 4   DROP FUNCTION public.get_machines(p_limit integer);
       public          postgres    false                       1255    16972    get_membership_byid(integer)    FUNCTION        CREATE FUNCTION public.get_membership_byid(p_membership_id integer) RETURNS TABLE(membership_id integer, membership_name character varying, membership_price numeric, membership_type character varying, membership_status character varying, membership_duration integer, membership_created_at timestamp without time zone)
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
 C   DROP FUNCTION public.get_membership_byid(p_membership_id integer);
       public          postgres    false                       1255    16970    get_memberships(integer)    FUNCTION     �  CREATE FUNCTION public.get_memberships(p_limit integer) RETURNS TABLE(membership_id integer, membership_name character varying, membership_price numeric, membership_type character varying, membership_status character varying, membership_duration integer, membership_created_at timestamp without time zone)
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
 7   DROP FUNCTION public.get_memberships(p_limit integer);
       public          postgres    false                       1255    16953    get_trainer(character varying)    FUNCTION     r  CREATE FUNCTION public.get_trainer(trainer_cedula_serch character varying) RETURNS TABLE(trainer_id integer, trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer, trainer_hired_at timestamp without time zone)
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
 J   DROP FUNCTION public.get_trainer(trainer_cedula_serch character varying);
       public          postgres    false                       1255    16951    get_trainers(integer)    FUNCTION     S  CREATE FUNCTION public.get_trainers(p_limit integer) RETURNS TABLE(trainer_id integer, trainer_cedula character varying, trainer_first_name character varying, trainer_last_name character varying, trainer_age integer, trainer_gender character, trainer_phone character varying, trainer_email character varying, trainer_address text, trainer_city character varying, trainer_main_discipline_id integer, trainer_hired_at timestamp without time zone)
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
 4   DROP FUNCTION public.get_trainers(p_limit integer);
       public          postgres    false            �            1255    16947    get_user(character varying)    FUNCTION     O  CREATE FUNCTION public.get_user(user_cedula_serch character varying) RETURNS TABLE(user_id integer, user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying, user_created_at timestamp without time zone)
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
 D   DROP FUNCTION public.get_user(user_cedula_serch character varying);
       public          postgres    false            �            1255    16945    get_users(integer)    FUNCTION     9  CREATE FUNCTION public.get_users(p_limit integer) RETURNS TABLE(user_id integer, user_cedula character varying, user_first_name character varying, user_last_name character varying, user_phone character varying, user_email character varying, user_address text, user_age integer, user_gender character, user_profile_picture bytea, trainer_id integer, user_membership_status character varying, user_created_at timestamp without time zone)
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
 1   DROP FUNCTION public.get_users(p_limit integer);
       public          postgres    false            �            1259    16682 
   categories    TABLE     �   CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    category_description text
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    16681    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categories_category_id_seq;
       public          postgres    false    216            �           0    0    categories_category_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;
          public          postgres    false    215            �            1259    16700    disciplines    TABLE     �   CREATE TABLE public.disciplines (
    discipline_id integer NOT NULL,
    discipline_name character varying(100) NOT NULL,
    discipline_description text,
    discipline_category_id integer
);
    DROP TABLE public.disciplines;
       public         heap    postgres    false            �            1259    16699    disciplines_discipline_id_seq    SEQUENCE     �   CREATE SEQUENCE public.disciplines_discipline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.disciplines_discipline_id_seq;
       public          postgres    false    220            �           0    0    disciplines_discipline_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.disciplines_discipline_id_seq OWNED BY public.disciplines.discipline_id;
          public          postgres    false    219            �            1259    16869    exercisecategory    TABLE     �   CREATE TABLE public.exercisecategory (
    exercise_category_exercise_id integer NOT NULL,
    exercise_category_category_id integer NOT NULL
);
 $   DROP TABLE public.exercisecategory;
       public         heap    postgres    false            �            1259    16854    exercisegroup    TABLE     �   CREATE TABLE public.exercisegroup (
    exercise_group_exercise_id integer NOT NULL,
    exercise_group_group_id integer NOT NULL
);
 !   DROP TABLE public.exercisegroup;
       public         heap    postgres    false            �            1259    16884    exercisemachine    TABLE     �   CREATE TABLE public.exercisemachine (
    exercise_machine_exercise_id integer NOT NULL,
    exercise_machine_machine_id integer NOT NULL
);
 #   DROP TABLE public.exercisemachine;
       public         heap    postgres    false            �            1259    16831 	   exercises    TABLE       CREATE TABLE public.exercises (
    exercise_id integer NOT NULL,
    exercise_name character varying(100) NOT NULL,
    exercise_description text,
    exercise_discipline_id integer,
    exercise_recommendations text,
    exercise_group_id integer,
    exercise_category_id integer
);
    DROP TABLE public.exercises;
       public         heap    postgres    false            �            1259    16830    exercises_exercise_id_seq    SEQUENCE     �   CREATE SEQUENCE public.exercises_exercise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.exercises_exercise_id_seq;
       public          postgres    false    235            �           0    0    exercises_exercise_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.exercises_exercise_id_seq OWNED BY public.exercises.exercise_id;
          public          postgres    false    234            �            1259    16691    groups    TABLE     �   CREATE TABLE public.groups (
    group_id integer NOT NULL,
    group_name character varying(100) NOT NULL,
    group_description text,
    group_recommendations text
);
    DROP TABLE public.groups;
       public         heap    postgres    false            �            1259    16690    groups_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.groups_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.groups_group_id_seq;
       public          postgres    false    218            �           0    0    groups_group_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.groups_group_id_seq OWNED BY public.groups.group_id;
          public          postgres    false    217            �            1259    16899    machinecategory    TABLE     �   CREATE TABLE public.machinecategory (
    machine_category_machine_id integer NOT NULL,
    machine_category_category_id integer NOT NULL
);
 #   DROP TABLE public.machinecategory;
       public         heap    postgres    false            �            1259    16929    machinediscipline    TABLE     �   CREATE TABLE public.machinediscipline (
    machine_discipline_machine_id integer NOT NULL,
    machine_discipline_discipline_id integer NOT NULL
);
 %   DROP TABLE public.machinediscipline;
       public         heap    postgres    false            �            1259    16914    machinegroup    TABLE     �   CREATE TABLE public.machinegroup (
    machine_group_machine_id integer NOT NULL,
    machine_group_group_id integer NOT NULL
);
     DROP TABLE public.machinegroup;
       public         heap    postgres    false            �            1259    16809    machines    TABLE     �   CREATE TABLE public.machines (
    machine_id integer NOT NULL,
    machine_name character varying(100) NOT NULL,
    machine_acquired_at date,
    machine_category_id integer,
    machine_group_id integer,
    machine_discipline_id integer
);
    DROP TABLE public.machines;
       public         heap    postgres    false            �            1259    16808    machines_machine_id_seq    SEQUENCE     �   CREATE SEQUENCE public.machines_machine_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.machines_machine_id_seq;
       public          postgres    false    233            �           0    0    machines_machine_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.machines_machine_id_seq OWNED BY public.machines.machine_id;
          public          postgres    false    232            �            1259    16752    memberships    TABLE     t  CREATE TABLE public.memberships (
    membership_id integer NOT NULL,
    membership_name character varying(100) NOT NULL,
    membership_price numeric(10,2) NOT NULL,
    membership_type character varying(50),
    membership_created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    membership_status character varying(50),
    membership_duration integer
);
    DROP TABLE public.memberships;
       public         heap    postgres    false            �            1259    16751    memberships_membership_id_seq    SEQUENCE     �   CREATE SEQUENCE public.memberships_membership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.memberships_membership_id_seq;
       public          postgres    false    226            �           0    0    memberships_membership_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.memberships_membership_id_seq OWNED BY public.memberships.membership_id;
          public          postgres    false    225            �            1259    16760    membershipuser    TABLE       CREATE TABLE public.membershipuser (
    membership_user_id integer NOT NULL,
    membership_user_user_id integer,
    membership_user_membership_id integer,
    membership_user_status character varying(50),
    membership_user_start_date date,
    membership_user_end_date date
);
 "   DROP TABLE public.membershipuser;
       public         heap    postgres    false            �            1259    16759 %   membershipuser_membership_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.membershipuser_membership_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.membershipuser_membership_user_id_seq;
       public          postgres    false    228            �           0    0 %   membershipuser_membership_user_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.membershipuser_membership_user_id_seq OWNED BY public.membershipuser.membership_user_id;
          public          postgres    false    227            �            1259    16777    membershipuserrecord    TABLE       CREATE TABLE public.membershipuserrecord (
    membership_user_record_id integer NOT NULL,
    membership_user_record_user_id integer,
    membership_user_record_membership_id integer,
    membership_user_record_start_date date,
    membership_user_record_end_date date
);
 (   DROP TABLE public.membershipuserrecord;
       public         heap    postgres    false            �            1259    16776 2   membershipuserrecord_membership_user_record_id_seq    SEQUENCE     �   CREATE SEQUENCE public.membershipuserrecord_membership_user_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public.membershipuserrecord_membership_user_record_id_seq;
       public          postgres    false    230            �           0    0 2   membershipuserrecord_membership_user_record_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.membershipuserrecord_membership_user_record_id_seq OWNED BY public.membershipuserrecord.membership_user_record_id;
          public          postgres    false    229            �            1259    16793    trainerdisciplines    TABLE     �   CREATE TABLE public.trainerdisciplines (
    trainer_discipline_trainer_id integer NOT NULL,
    trainer_discipline_discipline_id integer NOT NULL
);
 &   DROP TABLE public.trainerdisciplines;
       public         heap    postgres    false            �            1259    16714    trainers    TABLE       CREATE TABLE public.trainers (
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
    DROP TABLE public.trainers;
       public         heap    postgres    false            �            1259    16713    trainers_trainer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.trainers_trainer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.trainers_trainer_id_seq;
       public          postgres    false    222            �           0    0    trainers_trainer_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.trainers_trainer_id_seq OWNED BY public.trainers.trainer_id;
          public          postgres    false    221            �            1259    16733    users    TABLE       CREATE TABLE public.users (
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
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16732    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    224            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    223            �           2604    16685    categories category_id    DEFAULT     �   ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);
 E   ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    16703    disciplines discipline_id    DEFAULT     �   ALTER TABLE ONLY public.disciplines ALTER COLUMN discipline_id SET DEFAULT nextval('public.disciplines_discipline_id_seq'::regclass);
 H   ALTER TABLE public.disciplines ALTER COLUMN discipline_id DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    16834    exercises exercise_id    DEFAULT     ~   ALTER TABLE ONLY public.exercises ALTER COLUMN exercise_id SET DEFAULT nextval('public.exercises_exercise_id_seq'::regclass);
 D   ALTER TABLE public.exercises ALTER COLUMN exercise_id DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    16694    groups group_id    DEFAULT     r   ALTER TABLE ONLY public.groups ALTER COLUMN group_id SET DEFAULT nextval('public.groups_group_id_seq'::regclass);
 >   ALTER TABLE public.groups ALTER COLUMN group_id DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    16812    machines machine_id    DEFAULT     z   ALTER TABLE ONLY public.machines ALTER COLUMN machine_id SET DEFAULT nextval('public.machines_machine_id_seq'::regclass);
 B   ALTER TABLE public.machines ALTER COLUMN machine_id DROP DEFAULT;
       public          postgres    false    233    232    233            �           2604    16755    memberships membership_id    DEFAULT     �   ALTER TABLE ONLY public.memberships ALTER COLUMN membership_id SET DEFAULT nextval('public.memberships_membership_id_seq'::regclass);
 H   ALTER TABLE public.memberships ALTER COLUMN membership_id DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    16763 !   membershipuser membership_user_id    DEFAULT     �   ALTER TABLE ONLY public.membershipuser ALTER COLUMN membership_user_id SET DEFAULT nextval('public.membershipuser_membership_user_id_seq'::regclass);
 P   ALTER TABLE public.membershipuser ALTER COLUMN membership_user_id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    16780 .   membershipuserrecord membership_user_record_id    DEFAULT     �   ALTER TABLE ONLY public.membershipuserrecord ALTER COLUMN membership_user_record_id SET DEFAULT nextval('public.membershipuserrecord_membership_user_record_id_seq'::regclass);
 ]   ALTER TABLE public.membershipuserrecord ALTER COLUMN membership_user_record_id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    16717    trainers trainer_id    DEFAULT     z   ALTER TABLE ONLY public.trainers ALTER COLUMN trainer_id SET DEFAULT nextval('public.trainers_trainer_id_seq'::regclass);
 B   ALTER TABLE public.trainers ALTER COLUMN trainer_id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16736    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    224    223    224            �          0    16682 
   categories 
   TABLE DATA           V   COPY public.categories (category_id, category_name, category_description) FROM stdin;
    public          postgres    false    216   �B      �          0    16700    disciplines 
   TABLE DATA           u   COPY public.disciplines (discipline_id, discipline_name, discipline_description, discipline_category_id) FROM stdin;
    public          postgres    false    220   C      �          0    16869    exercisecategory 
   TABLE DATA           h   COPY public.exercisecategory (exercise_category_exercise_id, exercise_category_category_id) FROM stdin;
    public          postgres    false    237   aC      �          0    16854    exercisegroup 
   TABLE DATA           \   COPY public.exercisegroup (exercise_group_exercise_id, exercise_group_group_id) FROM stdin;
    public          postgres    false    236   ~C      �          0    16884    exercisemachine 
   TABLE DATA           d   COPY public.exercisemachine (exercise_machine_exercise_id, exercise_machine_machine_id) FROM stdin;
    public          postgres    false    238   �C      �          0    16831 	   exercises 
   TABLE DATA           �   COPY public.exercises (exercise_id, exercise_name, exercise_description, exercise_discipline_id, exercise_recommendations, exercise_group_id, exercise_category_id) FROM stdin;
    public          postgres    false    235   �C      �          0    16691    groups 
   TABLE DATA           `   COPY public.groups (group_id, group_name, group_description, group_recommendations) FROM stdin;
    public          postgres    false    218   D      �          0    16899    machinecategory 
   TABLE DATA           d   COPY public.machinecategory (machine_category_machine_id, machine_category_category_id) FROM stdin;
    public          postgres    false    239   aD      �          0    16929    machinediscipline 
   TABLE DATA           l   COPY public.machinediscipline (machine_discipline_machine_id, machine_discipline_discipline_id) FROM stdin;
    public          postgres    false    241   ~D      �          0    16914    machinegroup 
   TABLE DATA           X   COPY public.machinegroup (machine_group_machine_id, machine_group_group_id) FROM stdin;
    public          postgres    false    240   �D      �          0    16809    machines 
   TABLE DATA           �   COPY public.machines (machine_id, machine_name, machine_acquired_at, machine_category_id, machine_group_id, machine_discipline_id) FROM stdin;
    public          postgres    false    233   �D      �          0    16752    memberships 
   TABLE DATA           �   COPY public.memberships (membership_id, membership_name, membership_price, membership_type, membership_created_at, membership_status, membership_duration) FROM stdin;
    public          postgres    false    226   �D      �          0    16760    membershipuser 
   TABLE DATA           �   COPY public.membershipuser (membership_user_id, membership_user_user_id, membership_user_membership_id, membership_user_status, membership_user_start_date, membership_user_end_date) FROM stdin;
    public          postgres    false    228   .E      �          0    16777    membershipuserrecord 
   TABLE DATA           �   COPY public.membershipuserrecord (membership_user_record_id, membership_user_record_user_id, membership_user_record_membership_id, membership_user_record_start_date, membership_user_record_end_date) FROM stdin;
    public          postgres    false    230   KE      �          0    16793    trainerdisciplines 
   TABLE DATA           m   COPY public.trainerdisciplines (trainer_discipline_trainer_id, trainer_discipline_discipline_id) FROM stdin;
    public          postgres    false    231   hE      �          0    16714    trainers 
   TABLE DATA           �   COPY public.trainers (trainer_id, trainer_cedula, trainer_first_name, trainer_last_name, trainer_age, trainer_gender, trainer_phone, trainer_email, trainer_address, trainer_city, trainer_main_discipline_id, trainer_hired_at) FROM stdin;
    public          postgres    false    222   �E      �          0    16733    users 
   TABLE DATA           �   COPY public.users (user_id, user_cedula, user_first_name, user_last_name, user_phone, user_email, user_address, user_age, user_gender, user_profile_picture, trainer_id, user_membership_status, user_created_at) FROM stdin;
    public          postgres    false    224   �E      �           0    0    categories_category_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.categories_category_id_seq', 2, true);
          public          postgres    false    215            �           0    0    disciplines_discipline_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.disciplines_discipline_id_seq', 3, true);
          public          postgres    false    219            �           0    0    exercises_exercise_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.exercises_exercise_id_seq', 8, true);
          public          postgres    false    234            �           0    0    groups_group_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.groups_group_id_seq', 2, true);
          public          postgres    false    217            �           0    0    machines_machine_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.machines_machine_id_seq', 2, true);
          public          postgres    false    232            �           0    0    memberships_membership_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.memberships_membership_id_seq', 1, true);
          public          postgres    false    225            �           0    0 %   membershipuser_membership_user_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.membershipuser_membership_user_id_seq', 1, false);
          public          postgres    false    227            �           0    0 2   membershipuserrecord_membership_user_record_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.membershipuserrecord_membership_user_record_id_seq', 1, false);
          public          postgres    false    229            �           0    0    trainers_trainer_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.trainers_trainer_id_seq', 3, true);
          public          postgres    false    221            �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 4, true);
          public          postgres    false    223            �           2606    16689    categories categories_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    216            �           2606    16707    disciplines disciplines_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_pkey PRIMARY KEY (discipline_id);
 F   ALTER TABLE ONLY public.disciplines DROP CONSTRAINT disciplines_pkey;
       public            postgres    false    220            �           2606    16873 &   exercisecategory exercisecategory_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_pkey PRIMARY KEY (exercise_category_exercise_id, exercise_category_category_id);
 P   ALTER TABLE ONLY public.exercisecategory DROP CONSTRAINT exercisecategory_pkey;
       public            postgres    false    237    237            �           2606    16858     exercisegroup exercisegroup_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_pkey PRIMARY KEY (exercise_group_exercise_id, exercise_group_group_id);
 J   ALTER TABLE ONLY public.exercisegroup DROP CONSTRAINT exercisegroup_pkey;
       public            postgres    false    236    236            �           2606    16888 $   exercisemachine exercisemachine_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_pkey PRIMARY KEY (exercise_machine_exercise_id, exercise_machine_machine_id);
 N   ALTER TABLE ONLY public.exercisemachine DROP CONSTRAINT exercisemachine_pkey;
       public            postgres    false    238    238            �           2606    16838    exercises exercises_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (exercise_id);
 B   ALTER TABLE ONLY public.exercises DROP CONSTRAINT exercises_pkey;
       public            postgres    false    235            �           2606    16698    groups groups_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_id);
 <   ALTER TABLE ONLY public.groups DROP CONSTRAINT groups_pkey;
       public            postgres    false    218            �           2606    16903 $   machinecategory machinecategory_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_pkey PRIMARY KEY (machine_category_machine_id, machine_category_category_id);
 N   ALTER TABLE ONLY public.machinecategory DROP CONSTRAINT machinecategory_pkey;
       public            postgres    false    239    239            �           2606    16933 (   machinediscipline machinediscipline_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_pkey PRIMARY KEY (machine_discipline_machine_id, machine_discipline_discipline_id);
 R   ALTER TABLE ONLY public.machinediscipline DROP CONSTRAINT machinediscipline_pkey;
       public            postgres    false    241    241            �           2606    16918    machinegroup machinegroup_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_pkey PRIMARY KEY (machine_group_machine_id, machine_group_group_id);
 H   ALTER TABLE ONLY public.machinegroup DROP CONSTRAINT machinegroup_pkey;
       public            postgres    false    240    240            �           2606    16814    machines machines_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_pkey PRIMARY KEY (machine_id);
 @   ALTER TABLE ONLY public.machines DROP CONSTRAINT machines_pkey;
       public            postgres    false    233            �           2606    16758    memberships memberships_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (membership_id);
 F   ALTER TABLE ONLY public.memberships DROP CONSTRAINT memberships_pkey;
       public            postgres    false    226            �           2606    16765 "   membershipuser membershipuser_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_pkey PRIMARY KEY (membership_user_id);
 L   ALTER TABLE ONLY public.membershipuser DROP CONSTRAINT membershipuser_pkey;
       public            postgres    false    228            �           2606    16782 .   membershipuserrecord membershipuserrecord_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_pkey PRIMARY KEY (membership_user_record_id);
 X   ALTER TABLE ONLY public.membershipuserrecord DROP CONSTRAINT membershipuserrecord_pkey;
       public            postgres    false    230            �           2606    16797 *   trainerdisciplines trainerdisciplines_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_pkey PRIMARY KEY (trainer_discipline_trainer_id, trainer_discipline_discipline_id);
 T   ALTER TABLE ONLY public.trainerdisciplines DROP CONSTRAINT trainerdisciplines_pkey;
       public            postgres    false    231    231            �           2606    16722    trainers trainers_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_pkey PRIMARY KEY (trainer_id);
 @   ALTER TABLE ONLY public.trainers DROP CONSTRAINT trainers_pkey;
       public            postgres    false    222            �           2606    16724 $   trainers trainers_trainer_cedula_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_cedula_key UNIQUE (trainer_cedula);
 N   ALTER TABLE ONLY public.trainers DROP CONSTRAINT trainers_trainer_cedula_key;
       public            postgres    false    222            �           2606    16726 #   trainers trainers_trainer_email_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_email_key UNIQUE (trainer_email);
 M   ALTER TABLE ONLY public.trainers DROP CONSTRAINT trainers_trainer_email_key;
       public            postgres    false    222            �           2606    16741    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    224            �           2606    16743    users users_user_cedula_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_cedula_key UNIQUE (user_cedula);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_user_cedula_key;
       public            postgres    false    224            �           2606    16745    users users_user_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_email_key UNIQUE (user_email);
 D   ALTER TABLE ONLY public.users DROP CONSTRAINT users_user_email_key;
       public            postgres    false    224            �           2606    16708 3   disciplines disciplines_discipline_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_discipline_category_id_fkey FOREIGN KEY (discipline_category_id) REFERENCES public.categories(category_id);
 ]   ALTER TABLE ONLY public.disciplines DROP CONSTRAINT disciplines_discipline_category_id_fkey;
       public          postgres    false    220    4805    216            �           2606    16879 D   exercisecategory exercisecategory_exercise_category_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_exercise_category_category_id_fkey FOREIGN KEY (exercise_category_category_id) REFERENCES public.categories(category_id);
 n   ALTER TABLE ONLY public.exercisecategory DROP CONSTRAINT exercisecategory_exercise_category_category_id_fkey;
       public          postgres    false    4805    216    237                        2606    16874 D   exercisecategory exercisecategory_exercise_category_exercise_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercisecategory
    ADD CONSTRAINT exercisecategory_exercise_category_exercise_id_fkey FOREIGN KEY (exercise_category_exercise_id) REFERENCES public.exercises(exercise_id);
 n   ALTER TABLE ONLY public.exercisecategory DROP CONSTRAINT exercisecategory_exercise_category_exercise_id_fkey;
       public          postgres    false    4833    235    237            �           2606    16859 ;   exercisegroup exercisegroup_exercise_group_exercise_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_exercise_group_exercise_id_fkey FOREIGN KEY (exercise_group_exercise_id) REFERENCES public.exercises(exercise_id);
 e   ALTER TABLE ONLY public.exercisegroup DROP CONSTRAINT exercisegroup_exercise_group_exercise_id_fkey;
       public          postgres    false    236    4833    235            �           2606    16864 8   exercisegroup exercisegroup_exercise_group_group_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercisegroup
    ADD CONSTRAINT exercisegroup_exercise_group_group_id_fkey FOREIGN KEY (exercise_group_group_id) REFERENCES public.groups(group_id);
 b   ALTER TABLE ONLY public.exercisegroup DROP CONSTRAINT exercisegroup_exercise_group_group_id_fkey;
       public          postgres    false    236    4807    218                       2606    16889 A   exercisemachine exercisemachine_exercise_machine_exercise_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_exercise_machine_exercise_id_fkey FOREIGN KEY (exercise_machine_exercise_id) REFERENCES public.exercises(exercise_id);
 k   ALTER TABLE ONLY public.exercisemachine DROP CONSTRAINT exercisemachine_exercise_machine_exercise_id_fkey;
       public          postgres    false    4833    238    235                       2606    16894 @   exercisemachine exercisemachine_exercise_machine_machine_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercisemachine
    ADD CONSTRAINT exercisemachine_exercise_machine_machine_id_fkey FOREIGN KEY (exercise_machine_machine_id) REFERENCES public.machines(machine_id);
 j   ALTER TABLE ONLY public.exercisemachine DROP CONSTRAINT exercisemachine_exercise_machine_machine_id_fkey;
       public          postgres    false    238    4831    233            �           2606    16849 -   exercises exercises_exercise_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_category_id_fkey FOREIGN KEY (exercise_category_id) REFERENCES public.categories(category_id);
 W   ALTER TABLE ONLY public.exercises DROP CONSTRAINT exercises_exercise_category_id_fkey;
       public          postgres    false    216    4805    235            �           2606    16839 /   exercises exercises_exercise_discipline_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_discipline_id_fkey FOREIGN KEY (exercise_discipline_id) REFERENCES public.disciplines(discipline_id);
 Y   ALTER TABLE ONLY public.exercises DROP CONSTRAINT exercises_exercise_discipline_id_fkey;
       public          postgres    false    220    4809    235            �           2606    16844 *   exercises exercises_exercise_group_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_exercise_group_id_fkey FOREIGN KEY (exercise_group_id) REFERENCES public.groups(group_id);
 T   ALTER TABLE ONLY public.exercises DROP CONSTRAINT exercises_exercise_group_id_fkey;
       public          postgres    false    218    235    4807                       2606    16909 A   machinecategory machinecategory_machine_category_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_machine_category_category_id_fkey FOREIGN KEY (machine_category_category_id) REFERENCES public.categories(category_id);
 k   ALTER TABLE ONLY public.machinecategory DROP CONSTRAINT machinecategory_machine_category_category_id_fkey;
       public          postgres    false    239    4805    216                       2606    16904 @   machinecategory machinecategory_machine_category_machine_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machinecategory
    ADD CONSTRAINT machinecategory_machine_category_machine_id_fkey FOREIGN KEY (machine_category_machine_id) REFERENCES public.machines(machine_id);
 j   ALTER TABLE ONLY public.machinecategory DROP CONSTRAINT machinecategory_machine_category_machine_id_fkey;
       public          postgres    false    239    233    4831                       2606    16939 I   machinediscipline machinediscipline_machine_discipline_discipline_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_machine_discipline_discipline_id_fkey FOREIGN KEY (machine_discipline_discipline_id) REFERENCES public.disciplines(discipline_id);
 s   ALTER TABLE ONLY public.machinediscipline DROP CONSTRAINT machinediscipline_machine_discipline_discipline_id_fkey;
       public          postgres    false    220    4809    241                       2606    16934 F   machinediscipline machinediscipline_machine_discipline_machine_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machinediscipline
    ADD CONSTRAINT machinediscipline_machine_discipline_machine_id_fkey FOREIGN KEY (machine_discipline_machine_id) REFERENCES public.machines(machine_id);
 p   ALTER TABLE ONLY public.machinediscipline DROP CONSTRAINT machinediscipline_machine_discipline_machine_id_fkey;
       public          postgres    false    4831    233    241                       2606    16924 5   machinegroup machinegroup_machine_group_group_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_machine_group_group_id_fkey FOREIGN KEY (machine_group_group_id) REFERENCES public.groups(group_id);
 _   ALTER TABLE ONLY public.machinegroup DROP CONSTRAINT machinegroup_machine_group_group_id_fkey;
       public          postgres    false    218    240    4807                       2606    16919 7   machinegroup machinegroup_machine_group_machine_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machinegroup
    ADD CONSTRAINT machinegroup_machine_group_machine_id_fkey FOREIGN KEY (machine_group_machine_id) REFERENCES public.machines(machine_id);
 a   ALTER TABLE ONLY public.machinegroup DROP CONSTRAINT machinegroup_machine_group_machine_id_fkey;
       public          postgres    false    233    4831    240            �           2606    16815 *   machines machines_machine_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_category_id_fkey FOREIGN KEY (machine_category_id) REFERENCES public.categories(category_id);
 T   ALTER TABLE ONLY public.machines DROP CONSTRAINT machines_machine_category_id_fkey;
       public          postgres    false    216    4805    233            �           2606    16825 ,   machines machines_machine_discipline_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_discipline_id_fkey FOREIGN KEY (machine_discipline_id) REFERENCES public.disciplines(discipline_id);
 V   ALTER TABLE ONLY public.machines DROP CONSTRAINT machines_machine_discipline_id_fkey;
       public          postgres    false    4809    220    233            �           2606    16820 '   machines machines_machine_group_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_machine_group_id_fkey FOREIGN KEY (machine_group_id) REFERENCES public.groups(group_id);
 Q   ALTER TABLE ONLY public.machines DROP CONSTRAINT machines_machine_group_id_fkey;
       public          postgres    false    233    4807    218            �           2606    16771 @   membershipuser membershipuser_membership_user_membership_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_membership_user_membership_id_fkey FOREIGN KEY (membership_user_membership_id) REFERENCES public.memberships(membership_id);
 j   ALTER TABLE ONLY public.membershipuser DROP CONSTRAINT membershipuser_membership_user_membership_id_fkey;
       public          postgres    false    228    4823    226            �           2606    16766 :   membershipuser membershipuser_membership_user_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.membershipuser
    ADD CONSTRAINT membershipuser_membership_user_user_id_fkey FOREIGN KEY (membership_user_user_id) REFERENCES public.users(user_id);
 d   ALTER TABLE ONLY public.membershipuser DROP CONSTRAINT membershipuser_membership_user_user_id_fkey;
       public          postgres    false    4817    224    228            �           2606    16788 S   membershipuserrecord membershipuserrecord_membership_user_record_membership_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_membership_user_record_membership_id_fkey FOREIGN KEY (membership_user_record_membership_id) REFERENCES public.memberships(membership_id);
 }   ALTER TABLE ONLY public.membershipuserrecord DROP CONSTRAINT membershipuserrecord_membership_user_record_membership_id_fkey;
       public          postgres    false    4823    230    226            �           2606    16783 M   membershipuserrecord membershipuserrecord_membership_user_record_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.membershipuserrecord
    ADD CONSTRAINT membershipuserrecord_membership_user_record_user_id_fkey FOREIGN KEY (membership_user_record_user_id) REFERENCES public.users(user_id);
 w   ALTER TABLE ONLY public.membershipuserrecord DROP CONSTRAINT membershipuserrecord_membership_user_record_user_id_fkey;
       public          postgres    false    224    4817    230            �           2606    16803 K   trainerdisciplines trainerdisciplines_trainer_discipline_discipline_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_trainer_discipline_discipline_id_fkey FOREIGN KEY (trainer_discipline_discipline_id) REFERENCES public.disciplines(discipline_id);
 u   ALTER TABLE ONLY public.trainerdisciplines DROP CONSTRAINT trainerdisciplines_trainer_discipline_discipline_id_fkey;
       public          postgres    false    4809    231    220            �           2606    16798 H   trainerdisciplines trainerdisciplines_trainer_discipline_trainer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trainerdisciplines
    ADD CONSTRAINT trainerdisciplines_trainer_discipline_trainer_id_fkey FOREIGN KEY (trainer_discipline_trainer_id) REFERENCES public.trainers(trainer_id);
 r   ALTER TABLE ONLY public.trainerdisciplines DROP CONSTRAINT trainerdisciplines_trainer_discipline_trainer_id_fkey;
       public          postgres    false    231    4811    222            �           2606    16727 1   trainers trainers_trainer_main_discipline_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_trainer_main_discipline_id_fkey FOREIGN KEY (trainer_main_discipline_id) REFERENCES public.disciplines(discipline_id);
 [   ALTER TABLE ONLY public.trainers DROP CONSTRAINT trainers_trainer_main_discipline_id_fkey;
       public          postgres    false    222    220    4809            �           2606    16746    users users_trainer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainers(trainer_id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_trainer_id_fkey;
       public          postgres    false    222    4811    224            �   @   x�3�.)J�K/ɀ3J�3�2��R+R��3�S���8��R2�TYbqriNb��=... T9      �   P   x�3�t�O�L*��I��KG�(�V�%g�srq䗧�d����!sP�s:'�d�+�%f恔B�EF\1z\\\ g�)�      �      x������ � �      �      x������ � �      �      x������ � �      �   H   x�3�tJ�K�P(J-.�-(H-RH�O�T(.)J�K/�PH�H-J�,N�4�-NU(.�/)I-��b���� ��      �   A   x�3�-(H-Rp�O��t�H-J�,N-VH�/R(�HU(K&�$c���8}��q+�K���qqq 2      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   I   x�3�t��I�4�Գ��t��+M��4202�50�5�T04�26�24�37114����KL.�,K�463����� �5�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   s   x�3�4426135��4�����t�O�455�	sf�g���:�V$���%��t(�&f�)�pp�r����crIfY*��������������������������)W� ���     