const deleteTrainerModel = require('../../models/trainers/deleteTrainerModel');

const deleteTrainerService = async (cedula) => {
    try {
        await deleteTrainerModel(cedula);
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = deleteTrainerService;
