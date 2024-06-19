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


-- Procedimiento para eliminar un ejercicio por ID con manejo de errores
CREATE OR REPLACE FUNCTION delete_exercise(p_exercise_id INT)
    RETURNS VOID AS $$
BEGIN
    BEGIN
        DELETE FROM Exercises WHERE exercise_id = p_exercise_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No exercise found with ID: %', p_exercise_id;
        END IF;
    EXCEPTION
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
