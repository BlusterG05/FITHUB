const getAllTrainersService = require('../../services/trainers/getAllTrainersService');

const getAllTrainersController = async (req, res) => {
    try {
        const trainers = await getAllTrainersService();
        res.status(200).json(trainers);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching trainers', error: err.message });
    }
};

module.exports = getAllTrainersController;
