const getTrainerModel = require('../../models/trainers/getTrainerModel');

const getTrainerService = async (cedula) => {
    try {
        const trainer = await getTrainerModel(cedula);
        return trainer;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getTrainerService;
