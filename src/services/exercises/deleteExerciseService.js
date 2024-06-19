const deleteExerciseModel = require('../../models/exercises/deleteExerciseModel');

const deleteExerciseService = async (id) => {
    try {
        await deleteExerciseModel(id);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = deleteExerciseService;
