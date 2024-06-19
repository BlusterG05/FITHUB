const editTrainerModel = require('../../models/trainers/editTrainerModel');

const editTrainerService = async (trainer) => {
    try {
        await editTrainerModel(trainer);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = editTrainerService;
