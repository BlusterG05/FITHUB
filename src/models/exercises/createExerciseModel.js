const { query } = require('../../db/config');

const createExerciseModel = async (exercise) => {
    const { name, description, disciplineId, recommendations, groupId, categoryId } = exercise;
    const sql = `
        SELECT create_exercise($1, $2, $3, $4, $5, $6)
    `;
    const params = [name, description, disciplineId, recommendations, groupId, categoryId];
    try {
        const res = await query(sql, params);
        return res;
    } catch (err) {
        throw new Error('Error creating exercise: ' + err.message);
    }
};

module.exports = createExerciseModel;
