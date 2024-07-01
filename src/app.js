const express = require('express');
const bodyParser = require('body-parser');
const usersRoutes = require('./routes/users');
const trainersRoutes = require('./routes/trainers');  // Actualización aquí
const machinesRoutes = require('./routes/machines');
const exercisesRoutes = require('./routes/exercises');

const app = express();

app.use(bodyParser.json());


app.use('/api/users', usersRoutes);
app.use('/api/trainers', trainersRoutes);
app.use('/api/machines', machinesRoutes);
app.use('/api/exercises', exercisesRoutes);

if (require.main === module) {
  app.listen(3000, () => {
    console.log("Server is running on port 3000");
  });
}

module.exports = app;
