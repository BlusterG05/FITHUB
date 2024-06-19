const getExercisesModel = require('../../models/exercises/getExercisesModel');

const getExercisesService = async (limit) => {
    try {
        const exercises = await getExercisesModel(limit);
        return exercises;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getExercisesService;
