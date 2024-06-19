const { query } = require('../../db/config');

const getTrainersModel = async (limit) => {
    const sql = `
        SELECT * FROM get_trainers($1)
    `;
    try {
        const res = await query(sql, [limit]);
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching trainers: ' + err.message);
    }
};

module.exports = getTrainersModel;
