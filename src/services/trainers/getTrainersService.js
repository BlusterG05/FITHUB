const getTrainersModel = require('../../models/trainers/getTrainersModel');

const getTrainersService = async (limit) => {
    try {
        const trainers = await getTrainersModel(limit);
        return trainers;
    } catch (err) {
        throw new Error('Service error: ' + err.message);
    }
};

module.exports = getTrainersService;
