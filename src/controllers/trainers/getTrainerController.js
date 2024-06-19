const getTrainerService = require('../../services/trainers/getTrainerService');

const getTrainerController = async (req, res) => {
    const { cedula } = req.params;
    try {
        const trainer = await getTrainerService(cedula);
        res.status(200).json(trainer);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching trainer', error: err.message });
    }
};

module.exports = getTrainerController;
