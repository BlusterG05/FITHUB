const { query } = require('../../db/config');

const editExerciseModel = async (exercise) => {
    const { id, name, description, disciplineId, recommendations, groupId, categoryId } = exercise;
    const sql = `
        SELECT edit_exercise($1, $2, $3, $4, $5, $6, $7)
    `;
    const params = [id, name, description, disciplineId, recommendations, groupId, categoryId];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error editing exercise: ' + err.message);
    }
};

module.exports = editExerciseModel;
