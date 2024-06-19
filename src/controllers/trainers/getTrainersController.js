const getTrainersService = require('../../services/trainers/getTrainersService');

const getTrainersController = async (req, res) => {
    const { limit } = req.query;
    try {
        const trainers = await getTrainersService(limit);
        res.status(200).json(trainers);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching trainers', error: err.message });
    }
};

module.exports = getTrainersController;
