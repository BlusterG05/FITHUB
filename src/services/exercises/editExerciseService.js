const editExerciseModel = require('../../models/exercises/editExerciseModel');

const editExerciseService = async (exercise) => {
    try {
        await editExerciseModel(exercise);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = editExerciseService;
