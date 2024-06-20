CREATE OR REPLACE FUNCTION delete_exercise(p_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM Exercises WHERE exercise_id = p_id;
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

-- Procedimiento para editar una membresía por ID con manejo de errores y condiciones seguras
CREATE OR REPLACE FUNCTION edit_membership(
    p_membership_id INT,
    p_membership_name VARCHAR,
    p_membership_price DECIMAL,
    p_membership_type VARCHAR,
    p_membership_status VARCHAR,
    p_membership_duration INT
)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para editar una máquina por ID con manejo de errores y condiciones seguras
CREATE OR REPLACE FUNCTION edit_machine(
    p_machine_id INT,
    p_machine_name VARCHAR,
    p_machine_acquired_at DATE,
    p_machine_category_id INT,
    p_machine_group_id INT,
    p_machine_discipline_id INT
)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para editar un ejercicio por ID con manejo de errores y condiciones seguras
CREATE OR REPLACE FUNCTION edit_exercise(
    p_exercise_id INT,
    p_exercise_name VARCHAR,
    p_exercise_description TEXT,
    p_exercise_discipline_id INT,
    p_exercise_recommendations TEXT,
    p_exercise_group_id INT,
    p_exercise_category_id INT
)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para eliminar un usuario por cédula con manejo de errores
CREATE OR REPLACE FUNCTION delete_user(p_user_cedula VARCHAR)
RETURNS VOID AS $$
BEGIN
    BEGIN
        DELETE FROM Users WHERE user_cedula = p_user_cedula;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No user found with cedula: %', p_user_cedula;
        END IF;
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;
-- Procedimiento para eliminar un entrenador por cédula con manejo de errores
CREATE OR REPLACE FUNCTION delete_trainer(p_trainer_cedula VARCHAR)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;
-- Procedimiento para eliminar una membresía por ID con manejo de errores
CREATE OR REPLACE FUNCTION delete_membership(p_membership_id INT)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;
-- Procedimiento para eliminar una máquina por ID con manejo de errores
CREATE OR REPLACE FUNCTION delete_machine(p_machine_id INT)
RETURNS VOID AS $$
BEGIN
    BEGIN
        DELETE FROM Machines WHERE machine_id = p_machine_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No machine found with ID: %', p_machine_id;
        END IF;
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todos los ejercicios con límite opcional
CREATE OR REPLACE FUNCTION get_exercises(p_limit INT)
RETURNS TABLE (
    exercise_id INT,
    exercise_name VARCHAR,
    exercise_description TEXT,
    exercise_discipline_name VARCHAR,
    exercise_group_name VARCHAR,
    exercise_category_name VARCHAR,
    exercise_recommendations TEXT
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todos los ejercicios sin límite
CREATE OR REPLACE FUNCTION get_all_exercises()
RETURNS TABLE (
    exercise_id INT,
    exercise_name VARCHAR,
    exercise_description TEXT,
    exercise_discipline_name VARCHAR,
    exercise_group_name VARCHAR,
    exercise_category_name VARCHAR,
    exercise_recommendations TEXT
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener un ejercicio por ID
CREATE OR REPLACE FUNCTION get_exercise_byID(p_exercise_id INT)
RETURNS TABLE (
    exercise_id INT,
    exercise_name VARCHAR,
    exercise_description TEXT,
    exercise_discipline_name VARCHAR,
    exercise_group_name VARCHAR,
    exercise_category_name VARCHAR,
    exercise_recommendations TEXT
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para crear un nuevo ejercicio con manejo de errores
CREATE OR REPLACE FUNCTION create_exercise(
    p_exercise_name VARCHAR,
    p_exercise_description TEXT,
    p_exercise_discipline_id INT,
    p_exercise_recommendations TEXT,
    p_exercise_group_id INT,
    p_exercise_category_id INT
)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todas las membresías con límite opcional
CREATE OR REPLACE FUNCTION get_memberships(p_limit INT)
RETURNS TABLE (
    membership_id INT,
    membership_name VARCHAR,
    membership_price DECIMAL,
    membership_type VARCHAR,
    membership_status VARCHAR,
    membership_duration INT,
    membership_created_at TIMESTAMP
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todas las membresías sin límite
CREATE OR REPLACE FUNCTION get_all_memberships()
RETURNS TABLE (
    membership_id INT,
    membership_name VARCHAR,
    membership_price DECIMAL,
    membership_type VARCHAR,
    membership_status VARCHAR,
    membership_duration INT,
    membership_created_at TIMESTAMP
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener una membresía por ID
CREATE OR REPLACE FUNCTION get_membership_byID(p_membership_id INT)
RETURNS TABLE (
    membership_id INT,
    membership_name VARCHAR,
    membership_price DECIMAL,
    membership_type VARCHAR,
    membership_status VARCHAR,
    membership_duration INT,
    membership_created_at TIMESTAMP
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para crear una nueva membresía con manejo de errores
CREATE OR REPLACE FUNCTION create_membership(
    p_membership_name VARCHAR,
    p_membership_price DECIMAL,
    p_membership_type VARCHAR,
    p_membership_status VARCHAR,
    p_membership_duration INT
)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todas las máquinas sin límite
CREATE OR REPLACE FUNCTION get_all_machines()
RETURNS TABLE (
    machine_id INT,
    machine_name VARCHAR,
    machine_acquired_at DATE,
    machine_category_name VARCHAR,
    machine_group_name VARCHAR,
    machine_discipline_name VARCHAR
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todas las máquinas con límite opcional
CREATE OR REPLACE FUNCTION get_machines(p_limit INT)
RETURNS TABLE (
    machine_id INT,
    machine_name VARCHAR,
    machine_acquired_at DATE,
    machine_category_name VARCHAR,
    machine_group_name VARCHAR,
    machine_discipline_name VARCHAR
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener todas las máquinas sin límite
CREATE OR REPLACE FUNCTION get_all_machines()
RETURNS TABLE (
    machine_id INT,
    machine_name VARCHAR,
    machine_acquired_at DATE,
    machine_category_name VARCHAR,
    machine_group_name VARCHAR,
    machine_discipline_name VARCHAR
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener una máquina por ID
CREATE OR REPLACE FUNCTION get_machine_byID(machine_serch_id INT)
RETURNS TABLE (
    machine_id INT,
    machine_name VARCHAR,
    machine_acquired_at DATE,
    machine_category_name VARCHAR,
    machine_group_name VARCHAR,
    machine_discipline_name VARCHAR
) AS $$
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
$$ LANGUAGE plpgsql;

-- Procedimiento para crear una nueva máquina con manejo de errores
CREATE OR REPLACE FUNCTION create_machine(
    machine_name VARCHAR,
    machine_acquired_at DATE,
    machine_category_id INT,
    machine_group_id INT,
    machine_discipline_id INT
)
RETURNS VOID AS $$
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

-- Procedimiento para obtener todos los usuarios con límite opcional
CREATE OR REPLACE FUNCTION get_users(p_limit INT)
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
            u.user_id,
            u.user_cedula,
            u.user_first_name,
            u.user_last_name,
            u.user_phone,
            u.user_email,
            u.user_address,
            u.user_age,
            u.user_gender,
            u.user_profile_picture,
            u.trainer_id,
            u.user_membership_status,
            u.user_created_at
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
        u.user_id,
        u.user_cedula,
        u.user_first_name,
        u.user_last_name,
        u.user_phone,
        u.user_email,
        u.user_address,
        u.user_age,
        u.user_gender,
        u.user_profile_picture,
        u.trainer_id,
        u.user_membership_status,
        u.user_created_at
    FROM Users u;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para obtener un usuario por número de cédula
CREATE OR REPLACE FUNCTION get_user(user_serch_cedula VARCHAR)
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
        u.user_id,
        u.user_cedula,
        u.user_first_name,
        u.user_last_name,
        u.user_phone,
        u.user_email,
        u.user_address,
        u.user_age,
        u.user_gender,
        u.user_profile_picture,
        u.trainer_id,
        u.user_membership_status,
        u.user_created_at
    FROM Users u
    WHERE u.user_cedula = user_serch_cedula;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para crear un usuario de administración
CREATE OR REPLACE FUNCTION create_admin_user(
    p_name VARCHAR,
    p_username VARCHAR,
    p_email VARCHAR,
    p_password VARCHAR,
    p_role VARCHAR
)
RETURNS VOID AS $$
BEGIN
    BEGIN
        INSERT INTO administration_users (
            admin_name,
            admin_username,
            admin_email,
            admin_password,
            admin_role
        )
        VALUES (
            p_name,
            p_username,
            p_email,
            p_password,
            p_role
        );
    EXCEPTION WHEN others THEN
        RAISE EXCEPTION 'An error occurred: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;