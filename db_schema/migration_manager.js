const { exec } = require("child_process");
const dotenv = require("dotenv");
const path = require("path");
const fs = require("fs");

// Cargar las variables de entorno
dotenv.config();

const { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT } = process.env;
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
