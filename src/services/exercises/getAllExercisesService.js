const getAllExercisesModel = require('../../models/exercises/getAllExercisesModel');

const getAllExercisesService = async () => {
    try {
        const exercises = await getAllExercisesModel();
        return exercises;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getAllExercisesService;
