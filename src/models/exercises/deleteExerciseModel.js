const { query } = require('../../db/config');

const deleteExerciseModel = async (id) => {
    const sql = `
        SELECT delete_exercise($1)
    `;
    try {
        const res = await query(sql, [id]);
        return res;
    } catch (err) {
        throw new Error('Error deleting exercise: ' + err.message);
    }
};

module.exports = deleteExerciseModel;
