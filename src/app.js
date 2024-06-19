const express = require('express');
const bodyParser = require('body-parser');
const usersRoutes = require('./routes/users');
const trainersRoutes = require('./routes/trainers');  // Actualización aquí
const machinesRoutes = require('./routes/machines');
const exercisesRoutes = require('./routes/exercises');

const app = express();

app.use(bodyParser.json());

// Agregar la base /api/ y luego cada archivo de rutas agrega su propio segmento
app.use('/api/users', usersRoutes);
app.use('/api/trainers', trainersRoutes);
app.use('/api/machines', machinesRoutes);
app.use('/api/exercises', exercisesRoutes);

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});

module.exports = app;
