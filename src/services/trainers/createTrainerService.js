const createTrainerModel = require('../../models/trainers/createTrainerModel');

const createTrainerService = async (trainer) => {
    try {
        await createTrainerModel(trainer);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = createTrainerService;
