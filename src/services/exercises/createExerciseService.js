const createExerciseModel = require('../../models/exercises/createExerciseModel');

const createExerciseService = async (exercise) => {
    try {
        await createExerciseModel(exercise);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = createExerciseService;
