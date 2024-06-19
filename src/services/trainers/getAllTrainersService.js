const getAllTrainersModel = require('../../models/trainers/getAllTrainersModel');

const getAllTrainersService = async () => {
    try {
        const trainers = await getAllTrainersModel();
        return trainers;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getAllTrainersService;
