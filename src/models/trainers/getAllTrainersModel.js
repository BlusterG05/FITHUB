const { query } = require('../../db/config');

const getAllTrainersModel = async () => {
    const sql = `
        SELECT * FROM get_all_trainers()
    `;
    try {
        const res = await query(sql);
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching all trainers: ' + err.message);
    }
};

module.exports = getAllTrainersModel;
