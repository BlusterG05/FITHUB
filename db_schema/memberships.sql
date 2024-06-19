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
