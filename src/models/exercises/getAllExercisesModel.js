const { query } = require('../../db/config');

const getAllExercisesModel = async () => {
    const sql = `
        SELECT * FROM get_all_exercises()
    `;
    try {
        const res = await query(sql);
        return res.rows;
    } catch (err) {
        throw new Error('Error fetching all exercises: ' + err.message);
    }
};

module.exports = getAllExercisesModel;
