const { Pool } = require('pg');
const { password } = require('pg/lib/defaults');
require('dotenv').config();

const pool = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
});

pool.on('connect', () => {
    console.log('Processing query');
});

pool.on('error', (err) => {
    console.error('Error connecting to the database:', err);
});

module.exports = {
  query: (text, params) => pool.query(text, params),
  pool, // Agrega esta línea para exportar el pool
};
