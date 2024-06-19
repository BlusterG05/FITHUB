-- Pruebas para Editar Usuarios

-- Editar un usuario por número de cédula
SELECT edit_user(
    '1234567890',       -- user_cedula
    'John',             -- user_first_name
    'Doe',              -- user_last_name
    '555-9999',         -- user_phone (nuevo número de teléfono)
    'john.doe@newemail.com', -- user_email (nuevo email)
    '456 New St',       -- user_address (nueva dirección)
    31,                 -- user_age (nueva edad)
    'M',                -- user_gender
    NULL,               -- user_profile_picture
    NULL,               -- trainer_id (asumiendo null si no tiene entrenador)
    'Inactive'          -- user_membership_status (nuevo estado de membresía)
);
-- Pruebas para Editar Entrenadores

-- Editar un entrenador por número de cédula
SELECT edit_trainer(
    '0987654321',       -- trainer_cedula
    'Jane',             -- trainer_first_name
    'Doe',              -- trainer_last_name (nuevo apellido)
    29,                 -- trainer_age (nueva edad)
    'F',                -- trainer_gender
    '555-8888',         -- trainer_phone (nuevo número de teléfono)
    'jane.doe@newemail.com', -- trainer_email (nuevo email)
    '789 New St',       -- trainer_address (nueva dirección)
    'Gotham',           -- trainer_city (nueva ciudad)
    2                   -- trainer_main_discipline_id (nuevo ID de disciplina principal)
);
-- Pruebas para Editar Membresías

-- Editar una membresía por ID
SELECT edit_membership(
    1,                  -- membership_id
    'Gold',             -- membership_name (nuevo nombre de membresía)
    59.99,              -- membership_price (nuevo precio)
    'Annual',           -- membership_type (nuevo tipo)
    'Inactive',         -- membership_status (nuevo estado)
    365                 -- membership_duration (nueva duración en días)
);
-- Pruebas para Editar Máquinas

-- Editar una máquina por ID
SELECT edit_machine(
    1,                  -- machine_id
    'Elliptical',       -- machine_name (nuevo nombre de máquina)
    '2023-05-01',       -- machine_acquired_at (nueva fecha de adquisición)
    1,                  -- machine_category_id (nuevo ID de categoría)
    1,                  -- machine_group_id (nuevo ID de grupo)
    2                   -- machine_discipline_id (nuevo ID de disciplina)
);
-- Pruebas para Editar Ejercicios

-- Editar un ejercicio por ID
SELECT edit_exercise(
    1,                  -- exercise_id
    'Squat',            -- exercise_name (nuevo nombre de ejercicio)
    'Leg exercise',     -- exercise_description (nueva descripción)
    2,                  -- exercise_discipline_id (nuevo ID de disciplina)
    '3 sets of 12 reps',-- exercise_recommendations (nuevas recomendaciones)
    2,                  -- exercise_group_id (nuevo ID de grupo)
    2                   -- exercise_category_id (nuevo ID de categoría)
);