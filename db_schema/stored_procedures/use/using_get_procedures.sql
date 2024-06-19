-- -- Pruebas para Usuarios

-- Obtener todos los usuarios sin límite
SELECT * FROM get_all_users();

-- Obtener los primeros 10 usuarios
SELECT * FROM get_users(10);

-- Obtener un usuario por número de cédula
SELECT * FROM get_user('1234567890');
-- Pruebas para Entrenadores

-- Obtener todos los entrenadores sin límite
SELECT * FROM get_all_trainers();

-- Obtener los primeros 10 entrenadores
SELECT * FROM get_trainers(10);

-- Obtener un entrenador por número de cédula
SELECT * FROM get_trainer('0987654321');
-- Pruebas para Membresías

-- Obtener todas las membresías sin límite
SELECT * FROM get_all_memberships();

-- Obtener las primeras 5 membresías
SELECT * FROM get_memberships(5);

-- Obtener una membresía por ID
SELECT * FROM get_membership_byID(1); -- Asegúrate de que este ID existe
-- Pruebas para Máquinas

-- Obtener todas las máquinas sin límite
SELECT * FROM get_all_machines();

-- Obtener las primeras 5 máquinas
SELECT * FROM get_machines(5);

-- Obtener una máquina por ID
SELECT * FROM get_machine_byID(1); -- Asegúrate de que este ID existe
-- Pruebas para Ejercicios

-- Obtener todos los ejercicios sin límite
SELECT * FROM get_all_exercises();

-- Obtener los primeros 5 ejercicios
SELECT * FROM get_exercises(5);

-- Obtener un ejercicio por ID
SELECT * FROM get_exercise_byID(1); -- Asegúrate de que este ID existe