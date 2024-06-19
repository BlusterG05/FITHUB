const { query } = require('../../db/config');

const getExercisesModel = async (limit) => {
    const sql = `
        SELECT * FROM get_exercises($1)
    `;
    try {
        const res = await query(sql, [limit]);
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching exercises: ' + err.message);
    }
};

module.exports = getExercisesModel;
