const { exec } = require("child_process");
const dotenv = require("dotenv");
const path = require("path");
const fs = require("fs");

// Cargar las variables de entorno
dotenv.config();

const { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT } = process.env;
const timestamp = new Date().toISOString().replace(/[-:.]/g, "");
const backupFile = path.join(
  __dirname,
  "backups",
  `${timestamp}_backup_fithub.sql`
);

// Verifica si la carpeta de backups existe
if (!fs.existsSync(path.join(__dirname, "backups"))) {
  fs.mkdirSync(path.join(__dirname, "backups"));
}

const command = `pg_dump -h ${DB_HOST} -U ${DB_USER} -p ${DB_PORT} -F p -b -v -f "${backupFile}" ${DB_NAME}`;

exec(command, { env: { PGPASSWORD: DB_PASSWORD } }, (error, stdout, stderr) => {
  if (error) {
    console.error(`Error al crear el backup: ${error.message}`);
    return;
  }
  if (stderr) {
    console.error(`Error en el proceso: ${stderr}`);
    return;
  }
  console.log(`Backup creado exitosamente: ${backupFile}`);
});
