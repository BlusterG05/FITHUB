const { query } = require('../../db/config');

const editTrainerModel = async (trainer) => {
    const { cedula, firstName, lastName, age, gender, phone, email, address, city, mainDisciplineId } = trainer;
    const sql = `
        SELECT edit_trainer($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
    `;
    const params = [cedula, firstName, lastName, age, gender, phone, email, address, city, mainDisciplineId];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error editing trainer: ' + err.message);
    }
};

module.exports = editTrainerModel;
