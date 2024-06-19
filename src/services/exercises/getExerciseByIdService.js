const getExerciseByIdModel = require('../../models/exercises/getExerciseByIdModel');

const getExerciseByIdService = async (id) => {
    try {
        const exercise = await getExerciseByIdModel(id);
        return exercise;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getExerciseByIdService;
