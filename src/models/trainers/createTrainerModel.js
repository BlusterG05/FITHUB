const { query } = require('../../db/config');

const createTrainerModel = async (trainer) => {
    const { cedula, firstName, lastName, age, gender, phone, email, address, city, mainDisciplineId } = trainer;
    const sql = `
        SELECT create_trainer($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
    `;
    const params = [cedula, firstName, lastName, age, gender, phone, email, address, city, mainDisciplineId];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error creating trainer: ' + err.message);
    }
};

module.exports = createTrainerModel;
