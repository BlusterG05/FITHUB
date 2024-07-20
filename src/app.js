const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const { generateJWT } = require('./utils/jwtUtils');
const passport = require('./config/passport'); // Asegúrate de que este archivo exista
const cors = require('cors');
const usersRoutes = require('./routes/users');
const trainersRoutes = require('./routes/trainers');
const machinesRoutes = require('./routes/machines');
const exercisesRoutes = require('./routes/exercises');
const administrationRoutes = require('./routes/administrationUser');
const authenticateUser = require('./middlewares/authenticateUser');

const app = express(); // Inicializa la aplicación Express

app.use(cors());
app.use(bodyParser.json());
app.use(session({ 
  secret: process.env.SESSION_SECRET, 
  resave: false, 
  saveUninitialized: true 
}));
app.use(passport.initialize());
app.use(passport.session());

app.use('/api/users', authenticateUser, usersRoutes);
app.use('/api/trainers', authenticateUser, trainersRoutes);
app.use('/api/machines', authenticateUser, machinesRoutes);
app.use('/api/exercises', authenticateUser, exercisesRoutes);
app.use('/api/admin', administrationRoutes);

// Rutas OAuth
app.get('/auth/oauth', passport.authenticate('google', { scope: ['profile', 'email'] }));
app.get('/auth/callback', 
  passport.authenticate('google', { failureRedirect: '/login' }),
  function(req, res) {
    const token = generateJWT(req.user);
    res.redirect(`http://localhost:5173/auth/callback?token=${token}`);
  }
);

if (require.main === module) {
  app.listen(3000, () => {
    console.log("Server is running on port 3000");
  });
}

module.exports = app;