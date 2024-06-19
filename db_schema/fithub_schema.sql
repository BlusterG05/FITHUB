-- Crear tabla Categories primero porque es referenciada por otras tablas
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_description TEXT
);

-- Crear tabla Groups
-- Tabla de grupos que almacena los diferentes grupos de ejercicios y máquinas
CREATE TABLE Groups (
    group_id SERIAL PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL,
    group_description TEXT,
    group_recommendations TEXT
);

-- Crear tabla Disciplines
-- Tabla de disciplinas que almacena las diferentes disciplinas de entrenamiento
CREATE TABLE Disciplines (
    discipline_id SERIAL PRIMARY KEY,
    discipline_name VARCHAR(100) NOT NULL,
    discipline_description TEXT,
    discipline_category_id INT,
    FOREIGN KEY (discipline_category_id) REFERENCES Categories(category_id)
);

-- Crear tabla Trainers
-- Tabla de entrenadores que almacena la información personal de los entrenadores
CREATE TABLE Trainers (
    trainer_id SERIAL PRIMARY KEY,
    trainer_cedula VARCHAR(10) NOT NULL UNIQUE,
    trainer_first_name VARCHAR(50),
    trainer_last_name VARCHAR(50),
    trainer_age INT,
    trainer_gender CHAR(1),
    trainer_phone VARCHAR(15),
    trainer_email VARCHAR(100) UNIQUE,
    trainer_address TEXT,
    trainer_city VARCHAR(100),
    trainer_main_discipline_id INT,
    trainer_hired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trainer_main_discipline_id) REFERENCES Disciplines(discipline_id)
);

-- Crear tabla Users
-- Tabla de usuarios que almacena la información personal de los usuarios de Fithub
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    user_cedula VARCHAR(10) NOT NULL UNIQUE,
    user_first_name VARCHAR(50),
    user_last_name VARCHAR(50),
    user_phone VARCHAR(15),
    user_email VARCHAR(100) UNIQUE,
    user_address TEXT,
    user_age INT,
    user_gender CHAR(1),
    user_profile_picture BYTEA,
    trainer_id INT,
    user_membership_status VARCHAR(50),
    user_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);

-- Crear tabla Memberships
-- Tabla de membresías que almacena la información de los diferentes tipos de membresías
CREATE TABLE Memberships (
    membership_id SERIAL PRIMARY KEY,
    membership_name VARCHAR(100) NOT NULL,
    membership_price DECIMAL(10, 2) NOT NULL,
    membership_type VARCHAR(50),
    membership_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    membership_status VARCHAR(50),
    membership_duration INT
);

-- Crear tabla MembershipUser
-- Tabla que relaciona usuarios con sus membresías
CREATE TABLE MembershipUser (
    membership_user_id SERIAL PRIMARY KEY,
    membership_user_user_id INT,
    membership_user_membership_id INT,
    membership_user_status VARCHAR(50),
    membership_user_start_date DATE,
    membership_user_end_date DATE,
    FOREIGN KEY (membership_user_user_id) REFERENCES Users(user_id),
    FOREIGN KEY (membership_user_membership_id) REFERENCES Memberships(membership_id)
);

-- Crear tabla MembershipUserRecord
-- Tabla que almacena el historial de membresías de los usuarios
CREATE TABLE MembershipUserRecord (
    membership_user_record_id SERIAL PRIMARY KEY,
    membership_user_record_user_id INT,
    membership_user_record_membership_id INT,
    membership_user_record_start_date DATE,
    membership_user_record_end_date DATE,
    FOREIGN KEY (membership_user_record_user_id) REFERENCES Users(user_id),
    FOREIGN KEY (membership_user_record_membership_id) REFERENCES Memberships(membership_id)
);

-- Crear tabla TrainerDisciplines
-- Tabla que relaciona entrenadores con las disciplinas que enseñan
CREATE TABLE TrainerDisciplines (
    trainer_discipline_trainer_id INT,
    trainer_discipline_discipline_id INT,
    PRIMARY KEY (
        trainer_discipline_trainer_id,
        trainer_discipline_discipline_id
    ),
    FOREIGN KEY (trainer_discipline_trainer_id) REFERENCES Trainers(trainer_id),
    FOREIGN KEY (trainer_discipline_discipline_id) REFERENCES Disciplines(discipline_id)
);

-- Crear tabla Machines
-- Tabla de máquinas que almacena la información de las máquinas de ejercicio
CREATE TABLE Machines (
    machine_id SERIAL PRIMARY KEY,
    machine_name VARCHAR(100) NOT NULL,
    machine_acquired_at DATE,
    machine_category_id INT,
    machine_group_id INT,
    machine_discipline_id INT,
    FOREIGN KEY (machine_category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (machine_group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (machine_discipline_id) REFERENCES Disciplines(discipline_id)
);

-- Crear tabla Exercises
-- Tabla de ejercicios que almacena la información de los ejercicios
CREATE TABLE Exercises (
    exercise_id SERIAL PRIMARY KEY,
    exercise_name VARCHAR(100) NOT NULL,
    exercise_description TEXT,
    exercise_discipline_id INT,
    exercise_recommendations TEXT,
    exercise_group_id INT,
    exercise_category_id INT,
    FOREIGN KEY (exercise_discipline_id) REFERENCES Disciplines(discipline_id),
    FOREIGN KEY (exercise_group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (exercise_category_id) REFERENCES Categories(category_id)
);

-- Crear tabla ExerciseGroup
-- Tabla que relaciona ejercicios con grupos
CREATE TABLE ExerciseGroup (
    exercise_group_exercise_id INT,
    exercise_group_group_id INT,
    PRIMARY KEY (
        exercise_group_exercise_id,
        exercise_group_group_id
    ),
    FOREIGN KEY (exercise_group_exercise_id) REFERENCES Exercises(exercise_id),
    FOREIGN KEY (exercise_group_group_id) REFERENCES Groups(group_id)
);

-- Crear tabla ExerciseCategory
-- Tabla que relaciona ejercicios con categorías
CREATE TABLE ExerciseCategory (
    exercise_category_exercise_id INT,
    exercise_category_category_id INT,
    PRIMARY KEY (
        exercise_category_exercise_id,
        exercise_category_category_id
    ),
    FOREIGN KEY (exercise_category_exercise_id) REFERENCES Exercises(exercise_id),
    FOREIGN KEY (exercise_category_category_id) REFERENCES Categories(category_id)
);

-- Crear tabla ExerciseMachine
-- Tabla que relaciona ejercicios con máquinas
CREATE TABLE ExerciseMachine (
    exercise_machine_exercise_id INT,
    exercise_machine_machine_id INT,
    PRIMARY KEY (
        exercise_machine_exercise_id,
        exercise_machine_machine_id
    ),
    FOREIGN KEY (exercise_machine_exercise_id) REFERENCES Exercises(exercise_id),
    FOREIGN KEY (exercise_machine_machine_id) REFERENCES Machines(machine_id)
);

-- Crear tabla MachineCategory
-- Tabla que relaciona máquinas con categorías
CREATE TABLE MachineCategory (
    machine_category_machine_id INT,
    machine_category_category_id INT,
    PRIMARY KEY (
        machine_category_machine_id,
        machine_category_category_id
    ),
    FOREIGN KEY (machine_category_machine_id) REFERENCES Machines(machine_id),
    FOREIGN KEY (machine_category_category_id) REFERENCES Categories(category_id)
);

-- Crear tabla MachineGroup
-- Tabla que relaciona máquinas con grupos
CREATE TABLE MachineGroup (
    machine_group_machine_id INT,
    machine_group_group_id INT,
    PRIMARY KEY (machine_group_machine_id, machine_group_group_id),
    FOREIGN KEY (machine_group_machine_id) REFERENCES Machines(machine_id),
    FOREIGN KEY (machine_group_group_id) REFERENCES Groups(group_id)
);

-- Crear tabla MachineDiscipline
-- Tabla que relaciona máquinas con disciplinas
CREATE TABLE MachineDiscipline (
    machine_discipline_machine_id INT,
    machine_discipline_discipline_id INT,
    PRIMARY KEY (
        machine_discipline_machine_id,
        machine_discipline_discipline_id
    ),
    FOREIGN KEY (machine_discipline_machine_id) REFERENCES Machines(machine_id),
    FOREIGN KEY (machine_discipline_discipline_id) REFERENCES Disciplines(discipline_id)
);