const { query } = require('../../db/config');

const deleteTrainerModel = async (cedula) => {
    const sql = `
        SELECT delete_trainer($1)
    `;
    try {
        const res = await query(sql, [cedula]);
        return res;
    } catch (err) {
        throw new Error('Error deleting trainer: ' + err.message);
    }
};

module.exports = deleteTrainerModel;
