-- Crear un usuario
SELECT create_user(
    '1234567890',       
    'John',             
    'Doe',              
    '555-1234',         
    'john.doe@example.com', 
    '123 Main St',      
    30,                 
    'M',                
    NULL,               
    NULL,               
    'Active'            
);
-- Crear un entrenador
SELECT create_trainer(
    '0987654321',       
    'Jane',             
    'Smith',            
    28,                 
    'F',                
    '555-5678',         
    'jane.smith@example.com', 
    '456 Elm St',       
    'Metropolis',       
    1                   
);
-- Agregar datos de prueba a la tabla Categories
INSERT INTO Categories (category_name, category_description) VALUES
('Strength', 'Strength training exercises'),
('Cardio', 'Cardiovascular exercises');

-- Agregar datos de prueba a la tabla Groups
INSERT INTO Groups (group_name, group_description) VALUES
('Upper Body', 'Exercises for the upper body'),
('Lower Body', 'Exercises for the lower body');

-- Agregar datos de prueba a la tabla Disciplines
INSERT INTO Disciplines (discipline_name, discipline_description, discipline_category_id) VALUES
('Bodybuilding', 'Bodybuilding exercises', 1),
('Powerlifting', 'Powerlifting exercises', 1),
('Cardio Training', 'Cardio exercises', 2);

-- Crear una máquina
SELECT create_machine(
    'Treadmill',        
    '2022-01-01',       
    2,                  
    2,                  
    3                   
);

-- Crear un ejercicio
SELECT create_exercise(
    'Bench Press',      
    'Chest exercise',   
    1,                  
    '3 sets of 10 reps',
    1,                  
    1                   
);

-- Crear una membresía
SELECT create_membership(
    'Premium',    
    49.99,         
    'Monthly',    
    'Active',       
    30                 
);
