const { query } = require('../../db/config');

const getExerciseByIdModel = async (id) => {
    const sql = `
        SELECT * FROM get_exercise_byID($1)
    `;
    try {
        const res = await query(sql, [id]);
        return res.rows[0];
    } catch (err) {
        throw new Error('Error fetching exercise by ID: ' + err.message);
    }
};

module.exports = getExerciseByIdModel;
