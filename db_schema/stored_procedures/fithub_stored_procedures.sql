-- Procedimiento para obtener todos los usuarios con límite opcional
CREATE OR REPLACE FUNCTION get_users("p_limit" INT)
    RETURNS TABLE (
                      user_id INT,
                      user_cedula VARCHAR,
                      user_first_name VARCHAR,
                      user_last_name VARCHAR,
                      user_phone VARCHAR,
                      user_email VARCHAR,
                      user_address TEXT,
                      user_age INT,
                      user_gender CHAR,
                      user_profile_picture BYTEA,
                      trainer_id INT,
                      user_membership_status VARCHAR,
                      user_created_at TIMESTAMP
                  ) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todos los usuarios sin límite
CREATE OR REPLACE FUNCTION get_all_users()
    RETURNS TABLE (
                      user_id INT,
                      user_cedula VARCHAR,
                      user_first_name VARCHAR,
                      user_last_name VARCHAR,
                      user_phone VARCHAR,
                      user_email VARCHAR,
                      user_address TEXT,
                      user_age INT,
                      user_gender CHAR,
                      user_profile_picture BYTEA,
                      trainer_id INT,
                      user_membership_status VARCHAR,
                      user_created_at TIMESTAMP
                  ) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener un usuario por número de cédula
CREATE OR REPLACE FUNCTION get_user(user_cedula_serch VARCHAR)
    RETURNS TABLE (
                      user_id INT,
                      user_cedula VARCHAR,
                      user_first_name VARCHAR,
                      user_last_name VARCHAR,
                      user_phone VARCHAR,
                      user_email VARCHAR,
                      user_address TEXT,
                      user_age INT,
                      user_gender CHAR,
                      user_profile_picture BYTEA,
                      trainer_id INT,
                      user_membership_status VARCHAR,
                      user_created_at TIMESTAMP
                  ) AS $$
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
$$ LANGUAGE plpgsql;


-- Procedimiento para crear un nuevo usuario con manejo de errores
CREATE OR REPLACE FUNCTION create_user(
    user_cedula VARCHAR,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    user_phone VARCHAR,
    user_email VARCHAR,
    user_address TEXT,
    user_age INT,
    user_gender CHAR,
    user_profile_picture BYTEA,
    trainer_id INT,
    user_membership_status VARCHAR
)
    RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;


-- Procedimiento para eliminar un usuario por cédula con manejo de errores
CREATE OR REPLACE FUNCTION delete_user(user_cedula_serch VARCHAR)
    RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;


-- Procedimiento para editar un usuario por número de cédula con manejo de errores y condiciones seguras
CREATE OR REPLACE FUNCTION edit_user(
    p_user_cedula VARCHAR,
    p_user_first_name VARCHAR,
    p_user_last_name VARCHAR,
    p_user_phone VARCHAR,
    p_user_email VARCHAR,
    p_user_address TEXT,
    p_user_age INT,
    p_user_gender CHAR,
    p_user_profile_picture BYTEA,
    p_trainer_id INT,
    p_user_membership_status VARCHAR
)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;



-- Procedimiento para obtener todos los entrenadores con límite opcional
CREATE OR REPLACE FUNCTION get_trainers(p_limit INT)
    RETURNS TABLE (
                      trainer_id INT,
                      trainer_cedula VARCHAR,
                      trainer_first_name VARCHAR,
                      trainer_last_name VARCHAR,
                      trainer_age INT,
                      trainer_gender CHAR,
                      trainer_phone VARCHAR,
                      trainer_email VARCHAR,
                      trainer_address TEXT,
                      trainer_city VARCHAR,
                      trainer_main_discipline_id INT,
                      trainer_hired_at TIMESTAMP
                  ) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todos los entrenadores sin límite
CREATE OR REPLACE FUNCTION get_all_trainers()
    RETURNS TABLE (
                      trainer_id INT,
                      trainer_cedula VARCHAR,
                      trainer_first_name VARCHAR,
                      trainer_last_name VARCHAR,
                      trainer_age INT,
                      trainer_gender CHAR,
                      trainer_phone VARCHAR,
                      trainer_email VARCHAR,
                      trainer_address TEXT,
                      trainer_city VARCHAR,
                      trainer_main_discipline_id INT,
                      trainer_hired_at TIMESTAMP
                  ) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener un entrenador por número de cédula
CREATE OR REPLACE FUNCTION get_trainer(trainer_cedula_serch VARCHAR)
    RETURNS TABLE (
                      trainer_id INT,
                      trainer_cedula VARCHAR,
                      trainer_first_name VARCHAR,
                      trainer_last_name VARCHAR,
                      trainer_age INT,
                      trainer_gender CHAR,
                      trainer_phone VARCHAR,
                      trainer_email VARCHAR,
                      trainer_address TEXT,
                      trainer_city VARCHAR,
                      trainer_main_discipline_id INT,
                      trainer_hired_at TIMESTAMP
                  ) AS $$
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
$$ LANGUAGE plpgsql;


-- Procedimiento para crear un nuevo entrenador con manejo de errores
CREATE OR REPLACE FUNCTION create_trainer(
    trainer_cedula VARCHAR,
    trainer_first_name VARCHAR,
    trainer_last_name VARCHAR,
    trainer_age INT,
    trainer_gender CHAR,
    trainer_phone VARCHAR,
    trainer_email VARCHAR,
    trainer_address TEXT,
    trainer_city VARCHAR,
    trainer_main_discipline_id INT
)
    RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;


-- Procedimiento para eliminar un entrenador por cédula con manejo de errores
CREATE OR REPLACE FUNCTION delete_trainer(trainer_cedula VARCHAR)
    RETURNS VOID AS $$
BEGIN
    BEGIN
        DELETE FROM Trainers WHERE trainer_cedula = trainer_cedula;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No trainer found with cedula: %', trainer_cedula;
        END IF;
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;


-- Procedimiento para editar un entrenador por número de cédula con manejo de errores y condiciones seguras
CREATE OR REPLACE FUNCTION edit_trainer(
    p_trainer_cedula VARCHAR,
    p_trainer_first_name VARCHAR,
    p_trainer_last_name VARCHAR,
    p_trainer_age INT,
    p_trainer_gender CHAR,
    p_trainer_phone VARCHAR,
    p_trainer_email VARCHAR,
    p_trainer_address TEXT,
    p_trainer_city VARCHAR,
    p_trainer_main_discipline_id INT
)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;


