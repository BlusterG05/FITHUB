const { query } = require('../../db/config');

const getTrainerModel = async (cedula) => {
    const sql = `
        SELECT * FROM get_trainer($1)
    `;
    try {
        const res = await query(sql, [cedula]);
        return res.rows[0];
    } catch (err) {
        throw new Error('Error fetching trainer: ' + err.message);
    }
};

module.exports = getTrainerModel;
