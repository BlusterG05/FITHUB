const { exec } = require("child_process");
const dotenv = require("dotenv");
const path = require("path");
const fs = require("fs");

// Cargar las variables de entorno
dotenv.config();

const DB_HOST = process.env.DB_HOST || "localhost";
const DB_USER = process.env.DB_USER || "postgres";
const DB_PASSWORD = process.env.DB_PASSWORD || "postgres";
const DB_NAME = process.env.DB_NAME || "fithub";
const DB_PORT = process.env.DB_PORT || 5432;

const backupsDir = path.join(__dirname, "backups");

// Obtener el archivo de backup más reciente
const files = fs
  .readdirSync(backupsDir)
  .filter((file) => file.endsWith("_backup_fithub.sql"));
const latestBackup = files.sort().pop();

if (!latestBackup) {
  console.error("No se encontraron backups.");
  process.exit(1);
}

const backupFile = path.join(backupsDir, latestBackup);
const command = `psql -h ${DB_HOST} -U ${DB_USER} -p ${DB_PORT} -d ${DB_NAME} -f "${backupFile}"`;

exec(command, { env: { PGPASSWORD: DB_PASSWORD } }, (error, stdout, stderr) => {
  if (error) {
    console.error(`Error al cargar el backup: ${error.message}`);
    return;
  }
  if (stderr) {
    console.error(`Error en el proceso: ${stderr}`);
    return;
  }
  console.log(`Backup cargado exitosamente: ${backupFile}`);
});
